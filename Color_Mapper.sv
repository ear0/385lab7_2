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
                      input logic [31:0] draw_sig, //added
                      input logic [7:0] draw_code, //added
                      output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    logic [10:0] sprite_addr;
    logic [7:0] sprite_data;
  
    font_rom fontrom(.addr(sprite_addr),
                     .data(sprite_data));
                     
                        
    always_comb
    //always_ff @(posedge Clk_optional)
    begin: Ball_on_proc
        sprite_addr = (draw_code[6:0] << 4) + (DrawY & 10'b0000001111); //mod 16 is just masking out everything but [3:0], shift = *16
    end
    /*
    [24:21] [20:17] [16:13] [12:9] [8:5] [4:1]
    fgd_r   fgd_g   fgd_b   bkd_r  bkd_g bkd_b
    */
    always_comb
    begin: RGB_display
        if((sprite_data[7-DrawX[2:0]] == 1'b1 && draw_code[7] == 1'b0)
            ||(sprite_data[7-DrawX[2:0]] == 1'b0 && draw_code[7] == 1'b1))
        begin
            Red = draw_sig[24:21];
            Green = draw_sig[20:17];
            Blue = draw_sig[16:13];
        end
        else
        begin
            Red = draw_sig[12:9];
            Green = draw_sig[8:5];
            Blue = draw_sig[4:1];
        end
        
    end
endmodule
