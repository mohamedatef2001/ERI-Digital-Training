import numpy as np 
import matplotlib.pyplot as plt 

#this function is used to perform the transformation from a signed binary to signed decimal 

def todecimal(x , bits):
    assert len (x) <= bits 
    n = int (x , 2)
    s = 1 << (bits -1 )
    return (n & s-1) - (n &s)

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
plt.plot(output)
plt.show();

##################################################################################################
####################                        TEST3                       ##########################
##################################################################################################

#convert to integers
#this list contain N2 bits signed representation of the sin seq
list1=[]
for number in output:
    list1.append(np.binary_repr(int(number*(2**N1-1)),N2))

#save the converted seq to the data file
with open('input data' , 'w') as file:
    for number in list1:
        file.write(number + '\n')
#print(list1)
##################################################################################################
####################                        TEST4                       ##########################
##################################################################################################


##################################################################################################
####################                        READ                        ##########################
##################################################################################################

#from here, we read the filtered values, convert them to decimal representation
read_b=[]
with open("save_data") as file:
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
