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

def tohex(val , nbits):
     return hex ((val + (1 << nbits)) % (1 <<nbits))
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
with open('input_data_bin.txt' , 'w') as file:
    for number in list1:
        binary_value = int16_to_binary(number)
        file.write(binary_value+'\n')

#convert to hex and save this data
with open('input_data_hex.txt' , 'w') as file:
    for number in list1:
        hex_value = int16_to_hex(number)
        file.write(hex_value+'\n')
##################################################################################################
####################                        TEST4                       ##########################
##################################################################################################

# Example list of signed decimal values
values = list1
packed_data = bytearray()

# Pack the list into a binary format 
packed_data = struct.pack(f'{len(values)}i', *values)
"""""
print(values)
print(packed_data);
# Unpack the received data
unpacked_data = struct.unpack(f'{len(values)}i', packed_data)
print(unpacked_data);
"""

# Configure the serial port (adjust the parameters as needed)
#ser = serial.Serial('COM7', 115200, timeout=1)  # Replace with your UART port and baud rate

# Send the packed data over UART
print(len(values))
print(packed_data);
print(list1)

ser = serial.Serial('COM7', 115200)  # Adjust the port and baud rate as needed

# Send the packed data
ser.write(packed_data)

# Receive the data back
received_data = ser.read(len(packed_data))

# Unpack the received data
unpacked_data = struct.unpack(f'{len(values)}i', received_data)

# Close the UART communication
ser.close()

# Print the received values
print(unpacked_data)

##################################################################################################
####################                        READ                        ##########################
##################################################################################################

#from here, we read the filtered values, convert them to decimal representation



#this list contain the converted values
n_l=[]
for by in unpacked_data:
    n_l.append(by/2**(2*(N1-1)))

#print(n_l)
plt.plot(output,color='blue',linewidth=3,label='Original signal')
plt.plot(n_l,color='red',linewidth=3,label='Filtered signal')
plt.legend()
plt.savefig('result.png',dpi=600)
plt.show();
