module cpu8 (
    input  wire       clk,
    input  wire       reset_n,

    output reg  [7:0] mem_addr,
    input  wire [7:0] mem_rdata,
    output reg  [7:0] mem_wdata,
    output reg        mem_rd,
    output reg        mem_wr,

    output wire       halted
);

    // Programmer-visible architectural registers.
    reg [7:0] A;
    reg [7:0] X;
    reg [7:0] PC;
    reg       Z;
    reg       C;

    // Internal instruction register.
    reg [7:0] IR;

    // Hardwired control FSM.
    localparam [1:0] FETCH   = 2'd0;
    localparam [1:0] EXECUTE = 2'd1;
    localparam [1:0] HALT    = 2'd2;

    reg [1:0] state;

    assign halted = (state == HALT);

    // External memory interface control.
    always @* begin
        mem_addr  = 8'h00;
        mem_wdata = 8'h00;
        mem_rd    = 1'b0;
        mem_wr    = 1'b0;

        case (state)
            FETCH: begin
                mem_addr = PC;
                mem_rd   = 1'b1;
            end

            EXECUTE: begin
                case (IR[7:4])
                    4'h5,       // LDA [X]
                    4'h7,       // ADD [X]
                    4'h8: begin // SUB [X]
                        mem_addr = X;
                        mem_rd   = 1'b1;
                    end

                    4'h6: begin // STA [X]
                        mem_addr  = X;
                        mem_wdata = A;
                        mem_wr    = 1'b1;
                    end

                    default: begin
                        mem_addr  = 8'h00;
                        mem_wdata = 8'h00;
                        mem_rd    = 1'b0;
                        mem_wr    = 1'b0;
                    end
                endcase
            end

            default: begin
                // HALT and unused state encodings perform no memory access.
                mem_addr  = 8'h00;
                mem_wdata = 8'h00;
                mem_rd    = 1'b0;
                mem_wr    = 1'b0;
            end
        endcase
    end

    // Architectural state and instruction execution.
    always @(posedge clk) begin
        if (!reset_n) begin
            A     <= 8'h00;
            X     <= 8'h00;
            PC    <= 8'h00;
            IR    <= 8'h00;
            Z     <= 1'b1;
            C     <= 1'b0;
            state <= FETCH;
        end else begin
            case (state)
                FETCH: begin
                    IR    <= mem_rdata;
                    PC    <= PC + 8'h01;
                    state <= EXECUTE;
                end

                EXECUTE: begin
                    case (IR[7:4])
                        4'h0: begin
                            // NOP
                            state <= FETCH;
                        end

                        4'h1: begin
                            // LDI4 imm4
                            A     <= {4'b0000, IR[3:0]};
                            Z     <= (IR[3:0] == 4'h0);
                            state <= FETCH;
                        end

                        4'h2: begin
                            // ORI4 imm4
                            A     <= A | {4'b0000, IR[3:0]};
                            Z     <= ((A | {4'b0000, IR[3:0]}) == 8'h00);
                            state <= FETCH;
                        end

                        4'h3: begin
                            // TAX
                            X     <= A;
                            Z     <= (A == 8'h00);
                            state <= FETCH;
                        end

                        4'h4: begin
                            // TXA
                            A     <= X;
                            Z     <= (X == 8'h00);
                            state <= FETCH;
                        end

                        4'h5: begin
                            // LDA [X]
                            A     <= mem_rdata;
                            Z     <= (mem_rdata == 8'h00);
                            state <= FETCH;
                        end

                        4'h6: begin
                            // STA [X]
                            // Memory write is performed by the external
                            // interface at this rising edge.
                            state <= FETCH;
                        end

                        4'h7: begin
                            // ADD [X]
                            {C, A} <= {1'b0, A}
                                    + {1'b0, mem_rdata};
                            Z      <= ((A + mem_rdata) == 8'h00);
                            state  <= FETCH;
                        end

                        4'h8: begin
                            // SUB [X]
                            // Carry out is one when no unsigned borrow occurs.
                            {C, A} <= {1'b0, A}
                                    + {1'b0, ~mem_rdata}
                                    + 9'h001;
                            Z      <= ((A - mem_rdata) == 8'h00);
                            state  <= FETCH;
                        end

                        4'h9: begin
                            // INX
                            X     <= X + 8'h01;
                            Z     <= ((X + 8'h01) == 8'h00);
                            state <= FETCH;
                        end

                        4'hA: begin
                            // DEX
                            X     <= X - 8'h01;
                            Z     <= ((X - 8'h01) == 8'h00);
                            state <= FETCH;
                        end

                        4'hB: begin
                            // BRA rel4
                            PC    <= PC + {{4{IR[3]}}, IR[3:0]};
                            state <= FETCH;
                        end

                        4'hC: begin
                            // BZ rel4
                            if (Z)
                                PC <= PC + {{4{IR[3]}}, IR[3:0]};
                            state <= FETCH;
                        end

                        4'hD: begin
                            // BNZ rel4
                            if (!Z)
                                PC <= PC + {{4{IR[3]}}, IR[3:0]};
                            state <= FETCH;
                        end

                        4'hE: begin
                            // JMP X
                            PC    <= X;
                            state <= FETCH;
                        end

                        4'hF: begin
                            // HALT
                            state <= HALT;
                        end

                        default: begin
                            state <= FETCH;
                        end
                    endcase
                end

                HALT: begin
                    // Remain halted until synchronous reset.
                    state <= HALT;
                end

                default: begin
                    state <= FETCH;
                end
            endcase
        end
    end

endmodule