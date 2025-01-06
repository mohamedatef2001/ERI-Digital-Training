/*
 * send_receive_uart.c
 *
 *  Created on: Jan 1, 2025
 *      Author: ASUS
 */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <xil_types.h>
#include <xuartps.h>
#include <xparameters.h>

#define dataSize 512*512
#define headerSize 30170
#define fileSize dataSize+headerSize
int main(){
	u8 *fileData; // unsigned 8-bit , pointer type
	u32 status ;

	u32 receviedBytes=0;
	u32 totalReceviedBytes=0;

    u32 transmittedBytes=0;
	u32 totalTransmittedBytes=0;
	

	//u32 sendBytes=0;
	XUartPs_Config *uartConfig;
	XUartPs myUart;




	fileData = malloc(sizeof(fileSize));//take size in bytes
	uartConfig = XUartPs_LookupConfig(XPAR_PS7_UART_1_DEVICE_ID);
	status = XUartPs_CfgInitialize(&myUart,uartConfig, uartConfig->BaseAddress);
	if(status != XST_SUCCESS )
		print("INITI FAILED\n\r");
	status =XUartPs_SetBaudRate(&myUart,115200);
	if(status != XST_SUCCESS )
			print("BAUDRATE FAILED\n\r");


      //Receive Data
      while(totalReceviedBytes < fileSize){
	  receviedBytes= XUartPs_Recv(&myUart,(u8*)&fileData[totalReceviedBytes],100);
	  totalReceviedBytes+= receviedBytes;
      }


      for(int i=headerSize;i<fileSize;i++)
    	  fileData[i] = 255-fileData[i];
      //Send data
	  while(totalTransmittedBytes < fileSize){
	  transmittedBytes= XUartPs_Send(&myUart,(u8*)&fileData[totalReceviedBytes],1);
	  totalReceviedBytes+= transmittedBytes;
	  sleep(2);
      }

 /*
      //sleep(1);
      for(int i=0; i<10;i++){
    	  xil_printf("%0x" , fileData[i]);
      }

      //sendBytes = XUartPs_Send(&myUart,(u8*)&fileData,10);
      return 0;
 */


}



