`timescale 1ns / 1ps

module rinse_mode(
    input rinse_start, input pause, input power, input clk,
    input weight,
    output reg rinse_end_sign, 
    //light
    output reg water_in_light, output reg rinsing_light,output reg water_out_light,
    output reg [2:0]water_level, output reg dewatering_light
    );
    reg [2:0]state, nextstate;
    reg water_in_end_sign, water_in_start, water_out_start, water_out_end_sign, dewatering_start, rinsing_start, dewatering_end_sign, rinsing_end_sign;
    parameter water_out_state = 0, dewatering_state = 1, water_in_state = 2, rinsing_state = 3, rinse_end_state = 4;
    
    
    initial begin
            state = water_out_state;
            nextstate = water_out_state;
            water_in_end_sign = 0;
            water_out_end_sign = 0;
            dewatering_end_sign = 0;
            rinsing_end_sign = 0;
            water_out_light = 1;
            dewatering_light = 0;
            water_in_light = 0;
            rinsing_light = 1;
            water_in_start = 0;
            water_out_start = 0;
            dewatering_start = 0;
            rinsing_start = 0;
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
        if(power & rinse_start) state = nextstate;
        else begin
            rinse_end_sign = 0;
            nextstate = water_out_state;
        end
        end
        
        //spangle light
        always @(posedge clk)
        if(rinse_start & power)
        begin
            case(state)
                water_out_state: water_out_light = ~water_out_light;
                dewatering_state: begin water_out_light = 0; dewatering_light = ~dewatering_light; end
                water_in_state: begin dewatering_light = 0; water_in_light = ~water_in_light; end
                rinsing_state: begin water_in_light = 0; rinsing_light = ~rinsing_light; end
                rinse_end_state: begin rinsing_light = 0; end
            endcase
        end
        
        always @(state or pause)
        if(rinse_start & !pause) begin
            case(state)
                water_out_state: begin rinse_end_sign = 0; water_out_start = 1; end
                dewatering_state: begin dewatering_start = 1; water_out_start = 0;end
                water_in_state: begin dewatering_start = 0; water_in_start = 1; end
                rinsing_state: begin water_in_start = 0; rinsing_start = 1; end
                rinse_end_state: begin rinse_end_sign = 1; end
            endcase
        end
        
        
        
        always @(water_in_end_sign or water_out_end_sign or dewatering_end_sign or rinsing_end_sign or rinse_start)
        begin
            case(state)
                water_out_state:
                    if(water_out_end_sign)
                        nextstate = dewatering_state;
                    else nextstate = water_out_state;
                dewatering_state:
                    if(dewatering_end_sign)
                        nextstate = water_in_state;
                    else nextstate = dewatering_state;
                water_in_state:
                    if(water_in_end_sign) nextstate = rinsing_state;
                    else nextstate = water_in_state;
                rinsing_state:
                    if(rinsing_end_sign) nextstate = rinse_end_state;
                    else nextstate = rinsing_state;
                rinse_end_state:
                    if(!rinse_start) nextstate = water_out_state;
                    else nextstate = rinse_end_state;
            endcase
        end
endmodule
