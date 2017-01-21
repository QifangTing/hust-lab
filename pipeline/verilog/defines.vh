// `ifndef DEFINES_INCLUDED
// `define DEFINES_INCLUDED

`define OP      31:26
`define RS      25:21
`define RT      20:16
`define RD      15:11
`define SHAM    10:6
`define FUNCTY  5:0
`define IMM16   15:0
`define IMM26   25:0

`define ADD     6'b100000
`define ADDI    6'b001000
`define ADDIU   6'b001001
`define ADDU    6'b100001
`define AND     6'b100100
`define ANDI    6'b001100
`define SLL     6'b000000
`define SRA     6'b000011
`define SRL     6'b000010
`define SUB     6'b100010
`define OR      6'b100101
`define ORI     6'b001101
`define NOR     6'b100111
`define LW      6'b100011
`define SW      6'b101011
`define BEQ     6'b000100
`define BNE     6'b000101
`define SLT     6'b101010
`define SLTI    6'b001010
`define SLTU    6'b101011
`define J       6'b000010
`define JAL     6'b000011
`define JR      6'b001000
`define SYSCALL 6'b001100

`define $ZERO   5'd0
`define $AT     5'd1
`define $V0     5'd2
`define $V1     5'd3
`define $A0     5'd4
`define $A1     5'd5
`define $A2     5'd6
`define $A3     5'd7
`define $T0     5'd8
`define $T1     5'd9
`define $T2     5'd10
`define $T3     5'd11
`define $T4     5'd12
`define $T5     5'd13
`define $T6     5'd14
`define $T7     5'd15
`define $S0     5'd16
`define $S1     5'd17
`define $S2     5'd18
`define $S3     5'd19
`define $S4     5'd20
`define $S5     5'd21
`define $S6     5'd22
`define $S7     5'd23
`define $T8     5'd24
`define $T9     5'd25
`define $K0     5'd26
`define $K1     5'd27
`define $GP     5'd28
`define $SP     5'd29
`define $FP     5'd30
`define $RA     5'd31

// for bit 6, 1 -> R_type, 0 -> not R_type
// for bit [5:0], R_type -> funct, not R_type -> op_code
// `define ADD     7'b1100000
// `define ADDI    7'b0001000
// `define ADDIU   7'b0001001
// `define ADDU    7'b1100001
// `define AND     7'b1100100
// `define ANDI    7'b0001100
// `define SLL     7'b1000000
// `define SRA     7'b1000011
// `define SRL     7'b1000010
// `define SUB     7'b1100010
// `define OR      7'b1100101
// `define ORI     7'b0001101
// `define NOR     7'b1100111
// `define LW      7'b0100011
// `define SW      7'b0101011
// `define BEQ     7'b0000100
// `define BNE     7'b0000101
// `define SLT     7'b1101010
// `define SLTI    7'b0001010
// `define SLTU    7'b1101011
// `define J       7'b0000010
// `define JAL     7'b0000011
// `define JR      7'b1001000
// `define SYSCALL 7'b1001100

// `endif
