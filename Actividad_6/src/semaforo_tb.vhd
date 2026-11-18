library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity semaforo_tb is
end entity semaforo_tb;

architecture sim of semaforo_tb is

    -- Configuramos FCK = 2 para que 1 segundo equivalga a solo 2 ciclos de reloj en simulación
    constant FCK_SIM     : positive := 2;
    constant NP_SIM      : positive := 4;
    constant N_SIM       : positive := 7;
    constant PERIODO_CLK : time := 5 ns;
    constant UN_SEG      : time := PERIODO_CLK * FCK_SIM; -- 10 ns = 1 segundo simulado

    signal clk_tb   : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal p_ns_tb  : std_logic := '0';
    signal p_eo_tb  : std_logic := '0';
    signal e_ns_tb  : std_logic := '0';
    signal e_eo_tb  : std_logic := '0';
    signal l_ns_tb  : std_logic_vector(2 downto 0);
    signal l_eo_tb  : std_logic_vector(2 downto 0);

begin

    uut : entity work.semaforo
        generic map (
            FCK => FCK_SIM,
            NP  => NP_SIM,
            N   => N_SIM
        )
        port map (
            clk   => clk_tb,
            reset => reset_tb,
            p_ns  => p_ns_tb,
            p_eo  => p_eo_tb,
            e_ns  => e_ns_tb,
            e_eo  => e_eo_tb,
            l_ns  => l_ns_tb,
            l_eo  => l_eo_tb
        );

    -- Generación de reloj
    reloj_process : process
    begin
        clk_tb <= '0';
        wait for PERIODO_CLK / 2;
        clk_tb <= '1';
        wait for PERIODO_CLK / 2;
    end process;

    -- Proceso de estímulos
    estimulo : process
    begin
        reset_tb <= '1';
        wait for 2 * PERIODO_CLK;
        reset_tb <= '0'; 
        reset_tb <= '1';
        wait for 3 * PERIODO_CLK;
        reset_tb <= '0';       
        wait for 375 ns; 
        e_ns_tb <= '1';
        wait for 1875 ns;
        e_ns_tb <= '0'; 

        wait for 500 ns;
        finish;
    end process;

end architecture sim;