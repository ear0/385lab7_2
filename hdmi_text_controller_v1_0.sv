//`timescale 1 ns / 1 ps

//module hdmi_text_controller_v1_0 #
//(
//    // Users to add parameters here

//    // User parameters ends
//    // Do not modify the parameters beyond this line


//    // Parameters of Axi Slave Bus Interface S00_AXI
//    parameter integer C_AXI_DATA_WIDTH	= 32,
//    parameter integer C_AXI_ADDR_WIDTH	= 12 
//)
//(
//    // Users to add ports here

//    output wire hdmi_clk_n,
//    output wire hdmi_clk_p,
//    output wire [2:0] hdmi_tx_n,
//    output wire [2:0] hdmi_tx_p,

//    // User ports ends
//    // Do not modify the ports beyond this line


//    // Ports of Axi Slave Bus Interface AXI
//    input logic  axi_aclk,
//    input logic  axi_aresetn,
//    input logic [C_AXI_ADDR_WIDTH-1 : 0] axi_awaddr,
//    input logic [2 : 0] axi_awprot,
//    input logic  axi_awvalid,
//    output logic  axi_awready,
//    input logic [C_AXI_DATA_WIDTH-1 : 0] axi_wdata,
//    input logic [(C_AXI_DATA_WIDTH/8)-1 : 0] axi_wstrb,
//    input logic  axi_wvalid,
//    output logic  axi_wready,
//    output logic [1 : 0] axi_bresp,
//    output logic  axi_bvalid,
//    input logic  axi_bready,
//    input logic [C_AXI_ADDR_WIDTH-1 : 0] axi_araddr,
//    input logic [2 : 0] axi_arprot,
//    input logic  axi_arvalid,
//    output logic  axi_arready,
//    output logic [C_AXI_DATA_WIDTH-1 : 0] axi_rdata,
//    output logic [1 : 0] axi_rresp,
//    output logic  axi_rvalid,
//    input logic  axi_rready
//);

////additional logic variables as necessary to support VGA, and HDMI modules.
////ADDED SIGNALS FROM 6.2
//    logic [C_AXI_ADDR_WIDTH - 3 :0] font_rom_addr;
//    logic [C_AXI_DATA_WIDTH - 1 :0] font_rom_data;
//    logic [C_AXI_DATA_WIDTH - 1 :0] draw_sig;
//    logic clk_25MHz, clk_125MHz, clk, clk_100MHz;
//    logic hsync, vsync, vde;
//    logic locked;
//    logic [3:0] red, green, blue, red_int, green_int, blue_int;
//    logic [9:0] drawX, drawY, ballxsig, ballysig, ballsizesig;
//    logic [7:0] draw_code;
////    assign ballxsig = 100; //hardcoded the ball stuff
////    assign ballysig = 100;
////    assign ballsizesig = 10;
//// Instantiation of Axi Bus Interface AXI
//hdmi_text_controller_v1_0_AXI # ( 
//    .C_S_AXI_DATA_WIDTH(C_AXI_DATA_WIDTH),
//    .C_S_AXI_ADDR_WIDTH(C_AXI_ADDR_WIDTH)
//) hdmi_text_controller_v1_0_AXI_inst (
//    .S_AXI_ACLK(axi_aclk),
//    .S_AXI_ARESETN(axi_aresetn),
//    .S_AXI_AWADDR(axi_awaddr),
//    .S_AXI_AWPROT(axi_awprot),
//    .S_AXI_AWVALID(axi_awvalid),
//    .S_AXI_AWREADY(axi_awready),
//    .S_AXI_WDATA(axi_wdata),
//    .S_AXI_WSTRB(axi_wstrb),
//    .S_AXI_WVALID(axi_wvalid),
//    .S_AXI_WREADY(axi_wready),
//    .S_AXI_BRESP(axi_bresp),
//    .S_AXI_BVALID(axi_bvalid),
//    .S_AXI_BREADY(axi_bready),
//    .S_AXI_ARADDR(axi_araddr),
//    .S_AXI_ARPROT(axi_arprot),
//    .S_AXI_ARVALID(axi_arvalid),
//    .S_AXI_ARREADY(axi_arready),
//    .S_AXI_RDATA(axi_rdata),
//    .S_AXI_RRESP(axi_rresp),
//    .S_AXI_RVALID(axi_rvalid),
//    .S_AXI_RREADY(axi_rready)
//    //added these for font_rom drawing stuff
//    ,.font_rom_addr(font_rom_addr)
//    ,.font_rom_data(font_rom_data)
//    ,.draw_sig(draw_sig)
//);


////Instiante clocking wizard, VGA sync generator modules, and VGA-HDMI IP here. For a hint, refer to the provided
////top-level from the previous lab. You should get the IP to generate a valid HDMI signal (e.g. blue screen or gradient)
////prior to working on the text drawing.

////ADDING IP's FROM 6.2
////6.2 signals
    
//    vga_controller vga (
//                    .pixel_clk(clk_25MHz),
//                    .reset(~axi_aresetn),
//                    .hs(hsync),
//                    .vs(vsync),
//                    .active_nblank(vde),
//                    .drawX(drawX),
//                    .drawY(drawY)
//    );
//    clk_wiz_0 clk_wiz (
//                    .clk_out1(clk_25MHz),
//                    .clk_out2(clk_125MHz),
//                    .reset(~axi_aresetn),
//                    .locked(locked),
//                    .clk_in1(axi_aclk)
//    );
//    //add registers as per campuswire post #1110 - this might improve timing closure prospects
//    Reg_NSizeNWidth #(4) R(.Clk(clk_25MHz),
//                           .Load(1'b1),
//                           .Reset(~axi_aresetn),
//                           .D(red_int),
//                           .Q(red));
                           
//    Reg_NSizeNWidth #(4) G(.Clk(clk_25MHz),
//                           .Load(1'b1),
//                           .Reset(~axi_aresetn),
//                           .D(green_int),
//                           .Q(green));
                           
//    Reg_NSizeNWidth #(4) B(.Clk(clk_25MHz),
//                           .Load(1'b1),
//                           .Reset(~axi_aresetn),
//                           .D(blue_int),
//                           .Q(blue));
                
//    color_mapper color_instance(
//                    .Clk_optional(),
//                    .Reset(),
//                    .DrawX(drawX),
//                    .DrawY(drawY)
//                    ,.draw_sig(draw_sig) //added for font draw
//                    ,.draw_code(draw_code) //added for font draw
//                    ,.Red(red_int),
//                    .Green(green_int),
//                    .Blue(blue_int)
//    );

//    //Real Digital VGA to HDMI converter
//    hdmi_tx_0 vga_to_hdmi (
//        //Clocking and Reset
//        .pix_clk(clk_25MHz),
//        .pix_clkx5(clk_125MHz),
//        .pix_clk_locked(locked),
//        //Reset is active HIGH idk why it said active low bruh
//        .rst(~axi_aresetn),
//        //Color and Sync Signals
//        .red(red),
//        .green(green),
//        .blue(blue),
//        .hsync(hsync),
//        .vsync(vsync),
//        .vde(vde),
        
//        //aux Data (unused)
//        .aux0_din(4'b0),
//        .aux1_din(4'b0),
//        .aux2_din(4'b0),
//        .ade(1'b0),
        
//        //Differential outputs
//        .TMDS_CLK_P(hdmi_clk_p),          
//        .TMDS_CLK_N(hdmi_clk_n),          
//        .TMDS_DATA_P(hdmi_tx_p),         
//        .TMDS_DATA_N(hdmi_tx_n)          
//    );
    
//    draw_chars drawing(.Clk_optional(),
//                        .Reset(),
//                        .drawX(drawX),
//                        .drawY(drawY),
//                        .font_rom_data(font_rom_data),
//                        .draw_code(draw_code),
//                        .font_rom_addr(font_rom_addr));
//// User logic ends

//endmodule
