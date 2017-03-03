isim force add clk 1 -value 0 -time 10 ns -repeat 20 ns
put rst 1

run 10ns
put rst 0
run 20ms