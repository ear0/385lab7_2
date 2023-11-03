module draw_chars(input logic Clk_optional, Reset,
                  input logic [9:0] drawX, drawY,
                  input logic [31:0] font_rom_data,
                  output logic [7:0] draw_code,
                  output logic [9:0] font_rom_addr);
    
    int sprite_nom_addr;
    int intermediate_result;
    int ycomp;
    int sprite, symbol, symbol_rem;

    always_comb
    begin //avoiding % / *
            sprite_nom_addr = (drawX >> 3) + (drawY >> 4)*80;
            symbol = (sprite_nom_addr >> 2);
            symbol_rem = (symbol << 2);
            sprite = (sprite_nom_addr - symbol_rem);
            font_rom_addr = symbol;
            case(sprite)
                'd0: draw_code = font_rom_data[7:0];
                'd1: draw_code = font_rom_data[15:8];
                'd2: draw_code = font_rom_data[23:16];
                default: draw_code = font_rom_data[31:24];
            endcase
    end
endmodule
