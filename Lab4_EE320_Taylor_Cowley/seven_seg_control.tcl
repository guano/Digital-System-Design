put data_in 0000111100111100
put blank 0000
isim force add clk 1 -value 0 -time 10 ns -repeat 20 ns
run 100ms
