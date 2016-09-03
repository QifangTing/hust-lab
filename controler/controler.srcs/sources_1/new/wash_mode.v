`timescale 1ns / 1ps

module wash_mode(
    input wash_start, input pause, input power, input clk, //input wash_control,
    input weight,
    output reg wash_end_sign, 
    //light
    output reg water_in_light, output reg washing_light,
    output reg [2:0]water_level
    );
    // FIXED ME: there's 3 state, but state and nextState only can hold 1 bit.
    reg [1:0]state, nextstate;
    reg water_in_end_sign, water_in_start, washing_start;
    parameter water_in_state = 0, washing_state = 1, wash_end_state = 2;
    
    initial begin
        state = water_in_state;
        nextstate = water_in_state;
//        water_in_end_sign = 0;
//        spangle_start = 0;
        water_in_light = 0;
        washing_light = 1;
    end
    
     water_in_mode WATER_IN_MODE (.water_in_end_sign(water_in_end_sign),
                                  .water_in_start(water_in_start),
                                  .clk(clk),
                                  .power(power),
                                  .weight(weight),
                                  .pause(pause),
                                  .water_level(water_level)
                       );
//     timer TIME_WASH (.(washing_light))
//     timer TIME_SPANGLE (.clk(clk),
//                         .start(spangle_start),
//                         .(washing_light));
    
    // FIXED ME: edge detective(posedge) can't be mix up with level detective(power).
    always @(posedge power or posedge clk)
    begin
    if(power) state = nextstate;
    else begin
        wash_end_sign = 0;
        nextstate = water_in_state;
    end
    end
    
    //spangle light
    always @(posedge clk)
    if(wash_start & power)
    begin
        case(state)
            water_in_state: water_in_light = ~water_in_light;
            washing_state: begin water_in_light = 0; washing_light = ~washing_light; end
            wash_end_state: begin washing_light = 0; end
        endcase
    end
    
    always @(state or pause)
    if(wash_start & !pause) begin
        case(state)
            water_in_state: begin wash_end_sign = 0; water_in_start = 1; end
            washing_state: begin water_in_start = 0; washing_start = 1; end
            wash_end_state: begin  washing_start = 0; wash_end_sign = 1; end
        endcase
    end
    
    always @(water_in_end_sign or wash_end_sign or wash_start)
    begin
        case(state)
            water_in_state:
                if(water_in_end_sign)
                    nextstate = washing_state;
                else nextstate = water_in_state;
            washing_state:
                if(wash_end_sign)
                    nextstate = wash_end_state;
                else nextstate = washing_state;
            wash_end_state:
                if(!wash_start) nextstate = water_in_state;
                else nextstate = wash_end_state;
        endcase
    end
endmodule
