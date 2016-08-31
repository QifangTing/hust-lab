`timescale 1ns / 1ps

module wash_mode(
    input wash_start, input pause, input power, input clk, input reset, input wash_control,
    input weight_ch,
    output reg wash_end
    );
    reg state, nextstate;
    parameter wait_state = 0, water_in = 1, washing = 2;
    
    initial begin
        state = wait_state;
        nextstate = wait_state;
    end
    
    always @(posedge wash_start or power or posedge clk or posedge reset)
    begin
    if(power)
        if(wash_control)
            if(reset) wash_end = 0;
            else state = nextstate;
        else wash_end = 0;
    else begin
        wash_end = 0;
        nextstate = wait_state;
    end
    end
    
endmodule
