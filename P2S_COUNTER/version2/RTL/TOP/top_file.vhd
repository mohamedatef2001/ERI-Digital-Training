----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2024 07:47:35 PM
-- Design Name: 
-- Module Name: top_file - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;   
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_file is Port (
I_STOP_VALUE : in std_logic_vector (3 downto 0);
I_DATA : in std_logic_vector (3 downto 0 );
I_LOAD : in std_logic ;
I_RESET: in std_logic ;
I_CLK  : in std_logic ;
O_DATA : out std_logic;
O_VALID : out std_logic 
 );
end top_file;

architecture Behavioral of top_file is

 component counter is port (
                              i_data : in std_logic_vector (3 downto 0) ;
                              i_stop_value : in std_logic_vector (3 downto 0);
                              i_clk  : in std_logic ;
                              i_reset: in std_logic ;
                              i_load : in std_logic ;
                              o_stop : out std_logic ;
                              o_data : out std_logic_vector (3 downto 0) );
                         end component ;
                        
 component P2S is port (
                              i_data_p : in std_logic_vector (3 downto 0) ;
                              i_reset  : in std_logic ;
                              i_clk    : in std_logic ;
                              i_valid  : in std_logic ;
                              o_done   : out std_logic ;
                              o_data_s : out std_logic );
                         end component ;      
signal s_count_connection : std_logic_vector (3 downto 0 );
signal s_stop_flag : std_logic ;

begin
U1_COUNTER : counter port map(
                             i_data => I_DATA ,
                             i_stop_value => I_STOP_VALUE ,
                             i_clk   =>  I_CLK  ,
                             i_reset =>  I_RESET ,
                             i_load  =>   I_LOAD   ,
                             o_stop  =>   s_stop_flag ,
                             o_data  =>   s_count_connection
                            );

U1_P2S : P2S port map ( 
                            i_data_p => s_count_connection ,
                            i_reset  => I_RESET ,
                            i_clk    => I_CLK   ,
                            i_valid  => s_stop_flag ,
                            o_done   => O_VALID     ,
                            o_data_s => O_DATA  
                      );

end Behavioral;
