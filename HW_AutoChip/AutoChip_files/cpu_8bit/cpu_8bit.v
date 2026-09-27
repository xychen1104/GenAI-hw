module cpu_8bit (
    input clk,
    input reset_n,
    input [7:0] instruction,
    output reg [7:0] pc,
    output reg [7:0] accumulator,
    output reg [7:0] out_port,
    output reg halted
);
    
    // States
    reg [3:0] opcode;
    reg [3:0] operand;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Asynchronous reset
            pc <= 8'b0;
            accumulator <= 8'b0;
            out_port <= 8'b0;
            halted <= 1'b0;
        end else if (!halted) begin
            // Fetch opcode and operand
            opcode <= instruction[7:4];
            operand <= instruction[3:0];

            // Execute instruction based on opcode
            case (opcode)
                4'h0: begin // NOP
                    // No operation, just increment pc
                    pc <= pc + 1;
                end
                
                4'h1: begin // LDI imm4
                    accumulator <= {4'b0000, operand}; // Zero-extend immediate
                    pc <= pc + 1;
                end
                
                4'h2: begin // ADD imm4
                    accumulator <= accumulator + {4'b0000, operand};
                    pc <= pc + 1;
                end
                
                4'h3: begin // SUB imm4
                    accumulator <= accumulator - {4'b0000, operand};
                    pc <= pc + 1;
                end
                
                4'h4: begin // AND imm4
                    accumulator <= accumulator & {4'b0000, operand};
                    pc <= pc + 1;
                end
                
                4'h5: begin // OR imm4
                    accumulator <= accumulator | {4'b0000, operand};
                    pc <= pc + 1;
                end
                
                4'h6: begin // XOR imm4
                    accumulator <= accumulator ^ {4'b0000, operand};
                    pc <= pc + 1;
                end
                
                4'h7: begin // LSL
                    accumulator <= accumulator << 1;
                    pc <= pc + 1;
                end
                
                4'h8: begin // LSR
                    accumulator <= accumulator >> 1;
                    pc <= pc + 1;
                end
                
                4'h9: begin // JNZ addr4
                    if (accumulator != 8'b0)
                        pc <= {4'b0000, operand}; // Zero-extend address
                    else
                        pc <= pc + 1;
                end
                
                4'hA: begin // OUT
                    out_port <= accumulator;
                    pc <= pc + 1;
                end
                
                4'hF: begin // HALT
                    halted <= 1'b1;
                end
                
                default: begin
                    // Default case (should not happen)
                    pc <= pc + 1;
                end
            
            endcase
        end
    end
endmodule