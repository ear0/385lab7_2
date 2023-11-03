module Reg_NSizeNWidth #(parameter width = 16)
                        (input logic Clk, Load, Reset,
                         input logic [width - 1 :0] D,
                         output logic [width -1 : 0] Q);
                         
    always_ff @(posedge Clk)
    begin
        if(Reset)
            Q <= 0;
        else if(Load)
            Q <= D;
    end
endmodule
