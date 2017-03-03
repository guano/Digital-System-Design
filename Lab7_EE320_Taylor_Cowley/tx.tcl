isim force add clk 1 -value 0 -time 10 ns -repeat 20 ns
put rst 1
put data_in 11001010
put send_character 0
run 10ns
put rst 0
run 20ms