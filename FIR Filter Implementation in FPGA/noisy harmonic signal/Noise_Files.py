import numpy as np 
import matplotlib.pyplot as plt 
import serial
import time 
import struct

#this function is used to perform the transformation from a signed binary to signed decimal 
def todecimal(x , bits):
    assert len (x) <= bits 
    n = int (x , 2)
    s = 1 << (bits -1 )
    return (n & s-1) - (n &s)
# Function to convert a signed 16-bit integer to hexadecimal
def int16_to_hex(i):
    return hex(struct.unpack('<H', struct.pack('<h', i))[0]).upper()
# Function to convert a signed 16-bit integer to binary
def int16_to_binary(i):
    return bin(struct.unpack('<H', struct.pack('<h', i))[0]).replace("0b", "").zfill(16)
#compute a binary representation of the filter coff
tap=8
#for computing first scale, we want to represent filter coff as 8 bit
N1=8
#this is used to convert the filter input to 16 bit signed values 
N2=16
#this is the output bit width
N3=32

real_coff=(1/tap);
print(real_coff);

##################################################################################################
####################                        TEST1                       ##########################
##################################################################################################

#bit representation of coff
coff_bit=np.binary_repr (int(real_coff*(2**(N1-1))),N1)

#double check, invert it should be equal to real_coff
check=todecimal(coff_bit,N1)/(2**(N1-1))
print(check)

##################################################################################################
####################                        TEST2                       ##########################
##################################################################################################

#generate a test noisy harmonic signal
timeVector=np.linspace(0,2*np.pi,100)
output=np.sin(2*timeVector)+np.cos(3*timeVector)+0.3*np.random.randn(len(timeVector))
#plt.plot(output)
#plt.show();

##################################################################################################
####################                        TEST3                       ##########################
##################################################################################################

# Array of signed 16-bit integers
list1=[]
#convert values of output to large scale 
for number in output:
    list1.append(int(number*(2**N1-1)));

#convert to binary and save this data
with open('input_data_bin' , 'w') as file:
    for number in list1:
        binary_value = int16_to_binary(number)
        file.write(binary_value+'\n')

#convert to hex and save this data
with open('input_data_hex' , 'w') as file:
    for number in list1:
        hex_value = int16_to_hex(number)
        file.write(hex_value+'\n')
##################################################################################################
####################                        TEST4                       ##########################
##################################################################################################


#send data to uart

#For serial comm with uart and baud_rate
com_port = 'COM5'
baud_rate = 115200


#Array for sending data to uart
dataSendingToUart=[]
with open("input_data_hex", 'r') as file:
    for line in file:
        dataSendingToUart.append(line.rstrip('\n'))

#open connection with uart and send data        
ser = serial.Serial(com_port,baudrate=baud_rate, timeout=1)
try:
        for byte in dataSendingToUart:
            data = ser.write(bytes([byte]))
            print(f"sending data:  {hex(byte)} ")
            time.sleep(0.1)
except KeyboardInterrupt:
            print("\nExiting ...")
finally:
        ##ser.close()
         print("Serial Port finish with sending \n now receive.")

#Receive filterd signal
with open("save_data", 'wb') as file:
    print(f"Reading data from {com_port} ...")
    try:
        while True:
            data = ser.read(10)
            if data:
                file.write(data)
                print(f"Reading and saving data:  {data} ")
                break;

    except KeyboardInterrupt:
        print("\nExiting ...")
    finally:
        ser.close()
        print("Serial Port closed.")

##################################################################################################
####################                        READ                        ##########################
##################################################################################################

#from here, we read the filtered values, convert them to decimal representation

read_b=[]
with open("save_data", 'r') as file:
    for line in file:
        read_b.append(line.rstrip('\n'))
#print(read_b)


#this list contain the converted values
n_l=[]
for by in read_b:
    n_l.append(todecimal(by,N3)/2**(2*(N1-1)))

#print(n_l)
plt.plot(output,color='blue',linewidth=3,label='Original signal')
plt.plot(n_l,color='red',linewidth=3,label='Filtered signal')
plt.legend()
plt.savefig('result.png',dpi=600)
plt.show();
