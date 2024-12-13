----------------------------------------------------------------------------------
-- Company: Electronics Research Institute 
-- Engineer: Mostafa Mahmoud Sayed 
-- 
-- Create Date: 12/07/2024 03:47:46 PM
-- Design Name: 
-- Module Name: Design1_Top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Design1_Top is

    Port ( CLK          : in STD_LOGIC;
           RST          : in STD_LOGIC;
           LOAD_COUNTER : in STD_LOGIC;
           out_data     : out STD_LOGIC;
           in_data      : in STD_LOGIC_VECTOR (3 downto 0);
           LOAD_P2S     : in STD_LOGIC);
		   
end Design1_Top;

architecture Behavioral of Design1_Top is

signal connector : std_logic_vector (3 downto 0);

begin
 
u1: entity work.up_counter
port map (
           CLK      => CLK,
           RST      => RST,
           LOAD     => LOAD_COUNTER,
           in_data  => in_data,
           out_data => connector
		   
           );



u2: entity work.P2S_converter
port map (
           LOAD     => LOAD_P2S,
           CLK      => CLK,
           RST      => RST,
           in_data  => connector,
           out_data => out_data
		   
           );




end Behavioral;
