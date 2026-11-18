library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contador_4bit is
    port (
        reset    : in  std_logic;
        carga   :       in  std_logic;
        hab      :       in  std_logic;
        clk        :       in  std_logic;
        valor    :        in  std_logic_vector(3 downto 0);
        cuenta :        out std_logic_vector(3 downto 0)
    );
end entity contador_4bit;

architecture arch of contador_4bit is

    signal estado, estado_act : std_logic_vector(3 downto 0);

begin

    -- Memoria: registro de estado
    memoria: process(clk)
    begin
        if rising_edge(clk) then
           if reset = '1' then
                estado_act <= "0000";
            elsif carga = '1' then
                estado_act <= valor;
            elsif hab = '1' then
                estado_act <= std_logic_vector(unsigned(estado_act) + 1);
            else
                estado_act <= estado_act;
            end if;
        end if;
    end process;

    Cuenta <= estado_act;

    -- Salida del contador
end architecture;