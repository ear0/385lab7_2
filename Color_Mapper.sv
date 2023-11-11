//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper (input logic Clk_optional,
                      input logic Reset,
                      input logic [9:0] DrawX, DrawY,
                      input logic [31:0] palette[8], //added //week2 8 32 bit arrays
                      input logic [15:0] draw_code, //added
                      output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;
    logic [10:0] sprite_addr;
    logic [7:0] sprite_data;
  
    font_rom fontrom(.addr(sprite_addr),
                     .data(sprite_data));
                     
    assign sprite_addr = (draw_code[14:8] << 4) + (DrawY & 10'b0000001111); //mod 16 is just masking out everything but [3:0], shift = *16
    //lazy ahh
    genvar i;
    generate
    for (i = 0; i < 8; i++) begin : palette_case
        always_comb begin
            if ((sprite_data[7 - DrawX[2:0]] != draw_code[15]) || (sprite_data[7 - DrawX[2:0]] != draw_code[15]))
            begin
                case (draw_code[7:4])
                    4'b0000, 4'b0001 : {Red, Green, Blue} = {palette[i][11:8], palette[i][7:4], palette[i][3:0]};
                    4'b0010, 4'b0011 : {Red, Green, Blue} = {palette[i][27:24], palette[i][23:20], palette[i][19:16]};
                endcase
            end
            else
            begin
                case (draw_code[3:0])
                    4'b0000, 4'b0001 : {Red, Green, Blue} = {palette[i][11:8], palette[i][7:4], palette[i][3:0]};
                    4'b0010, 4'b0011 : {Red, Green, Blue} = {palette[i][27:24], palette[i][23:20], palette[i][19:16]};
                endcase
            end
        end
    end
endgenerate

endmodule
