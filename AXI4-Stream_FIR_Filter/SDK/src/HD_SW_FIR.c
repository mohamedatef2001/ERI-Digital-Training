#include <stdlib.h>
#include <xuartps.h>
#include <xparameters.h>
#include <time.h>
#include <sleep.h>
#include <xaxidma.h>
#include <xil_cache.h>
#include <xil_printf.h>
//If you create a file without specifying a type and fill it with zeros and ones, the file won't have a header.
//Headers are typically added by specific file formats (like .jpg, .png, .mp3, etc.) to store metadata about the file. Since your file is just raw binary data,
//it won't include any header information.
//The size of the file will be determined solely by the amount of data you put into it.

#define fileSize 400

XAxiDma_Config  *MyDmaConfig ;
XAxiDma MyDMA;
XUartPs_Config *MyUartConfig;
XUartPs MyUart;

u32 status;

u32 ReceivedBytes=0;
u32 TotalReceivedBytes=0;

u32 TransmittedBytes=0;
u32 TotalTransmittedBytes=0;

u32 checkHalted(u32 baseAddress,u32 offset);


int main(){

//Memory allocation Step
u8 *fileData ;
fileData = malloc (sizeof(u8)*(fileSize));
if (fileData <= 0){
	print("Memory Allocation Failed... \n");
	return -1;
    }
//print("Memory Allocation success..\n");

//-------------------------------DMA initialization----------------------------------//
 //Look up the hardware configuration for a device instance based on base address
 MyDmaConfig = XAxiDma_LookupConfigBaseAddr(XPAR_AXI_DMA_0_BASEADDR);
 //This function initializes a DMA engine.
 status = XAxiDma_CfgInitialize(&MyDMA, MyDmaConfig);
 if(status!=XST_SUCCESS){
	 print("DMA initialization failed");
	 return -1;
 }
// print("DMA initialization success..\n");

//-------------------------------UART initialization------------------------------------//
 // Looks up the device configuration based on the unique device ID. The table
 // contains the configuration info for each device in the system.

 // @return	A pointer to the configuration structure or NULL if the
 // specified device is not in the system.
 MyUartConfig = XUartPs_LookupConfig(XPAR_PS7_UART_0_DEVICE_ID);
 status = XUartPs_CfgInitialize(&MyUart,MyUartConfig,MyUartConfig->BaseAddress );
 if(status!=XST_SUCCESS){
	 print("UART initialization failed");
	 return -1;
 }
 //print("UART initialization success..\n");

 //-------------------------------------Baud Rate----------------------------------//

 status = XUartPs_SetBaudRate(&MyUart, 115200);
 if(status!=XST_SUCCESS){
	 print("SetBaudRate failed");
	 return -1;
 }

 //-----------------------------Receive from PC to Memory--------------------------//
 //This function attempts to receive a specified number of bytes of data
 // from the device and store it into the specified buffer.
 //* @return	The number of bytes received.
 while(TotalReceivedBytes<fileSize){
 ReceivedBytes =  XUartPs_Recv(&MyUart,(u8*)&fileData[TotalReceivedBytes],100);
 TotalReceivedBytes += ReceivedBytes;

 }


 //----------------------------------Flush a Data cache --------------------------//
 // To force the processor to write 'fileData' into the memory immediately
 //Xil_DCacheInvalidateRange(INTPTR adr, u32 len);
 Xil_DCacheFlush();


 // It's better to enable sending XAXIDMA_DEVICE_TO_DMA first to make sure the internal memory of the DMA
 // does not get full and halt.

 //-----------------------------XAXIDMA_DEVICE_TO_DMA--------------------------//
 /// Note that this function just configures the internal register of the DMA,
 /// where it needs the data and how much it needs to send.
 /// But this function doesn't wait for all the data to be sent.
 status = XAxiDma_SimpleTransfer(&MyDMA, (u32)&fileData[0],fileSize ,XAXIDMA_DEVICE_TO_DMA);
 if(status!=XST_SUCCESS){
	 print("XAXIDMA_DEVICE_TO_DMA failed");
	 return -1;
 }

 //-----------------------------XAXIDMA_DMA_TO_DEVICE--------------------------//
 status = XAxiDma_SimpleTransfer(&MyDMA, (u32)&fileData[0],fileSize ,XAXIDMA_DMA_TO_DEVICE);
 if(status!=XST_SUCCESS){
	 print("XAXIDMA_DEVICE_TO_DMA failed");
	 return -1;
 }


//-------------------------------checkHalted-----------------------------------------//
// Check if either DMA internal memory gets full during sending and receiving data. It will stay in that loop until
// all data is transferred.
 status = checkHalted(XPAR_AXI_DMA_0_BASEADDR,0x4);
    while(status != 1){
    	status = checkHalted(XPAR_AXI_DMA_0_BASEADDR,0x4);
    }
    status = checkHalted(XPAR_AXI_DMA_0_BASEADDR,0x34);
    while(status != 1){
    	status = checkHalted(XPAR_AXI_DMA_0_BASEADDR,0x34);
    }
	//print("DMA transfer success..\n");

//------------------------------Sending data to PC-----------------------------------//
while(TotalTransmittedBytes<fileSize){
//xil_printf("data = %0x", (u8*)&fileData[TotalTransmittedBytes]);
TransmittedBytes =  XUartPs_Send(&MyUart,(u8*)&fileData[TotalTransmittedBytes],2);
TotalTransmittedBytes += TransmittedBytes;
 usleep(1000) ;
}




}


u32 checkHalted(u32 baseAddress,u32 offset){
		u32 status;
		status = (XAxiDma_ReadReg(baseAddress,offset))&XAXIDMA_HALTED_MASK;
		return status;
}



