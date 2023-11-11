module draw_chars(input logic Clk_optional, Reset,
                  input logic [9:0] drawX, drawY,
                  input logic [31:0] font_rom_data,
                  output logic [15:0] draw_code,
                  output logic [11:0] font_rom_addr);
    
    int sprite_nom_addr, symbol, todraw;
    int symbol_rem;
    
    always_comb
    begin // x/8, y/16 * 80
        sprite_nom_addr = (drawX >> 3) + ((drawY >> 4) * 80);
        symbol = sprite_nom_addr >> 1;
        symbol_rem = symbol << 1;
        font_rom_addr = symbol;
        if ((sprite_nom_addr - symbol_rem) == 0)
            draw_code = font_rom_data[15:0];
        else
            draw_code = font_rom_data[31:16];
    end
endmodule
