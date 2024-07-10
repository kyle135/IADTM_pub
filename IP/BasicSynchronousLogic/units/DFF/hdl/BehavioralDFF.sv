


module BehaviorallDFF
#(  //=========================================================================
    // Parameters
    //=========================================================================
    parameter  ENABLE_RESET      = 1'b0,
    parameter  SYNCHRONOUS_RESET = 1'b1,
    parameter  ACTIVE_LOW_RESET  = 1'b0,
    parameter  RESET_VALUE       = 1'b0
)
(
    input  wire clk,
    input  wire rst,
    input  wire d,
    output reg  q,
    output reg  q_b
);


    generate
        if (ENABLE_RESET !== 1'b0) begin : RESET_ENABLED_DFF_GENERATION
            if (SYNCHRONOUS_RESET !== 1'b0) begin : SYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                if (ACTIVE_LOW_RESET !== 1'b0) begin : ACTIVE_LOW_SYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                    always @(posedge clk) begin
                        if (~rst) begin
                            q   <=  RESET_VALUE;
                            q_b <= ~RESET_VALUE;
                        end else begin
                            q   <=  d;
                            q_b <= ~d;
                        end
                    end
                end : ACTIVE_LOW_SYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                else if (ACTIVE_LOW_RESET === 1'b0) begin : ACTIVE_HIGH_SYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                    always @(posedge clk) begin
                        if (rst) begin
                            q   <=  RESET_VALUE;
                            q_b <= ~RESET_VALUE;
                        end else begin
                            q   <=  d;
                            q_b <= ~d;
                        end
                    end : ACTIVE_HIGH_SYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                end
            else begin : ASYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                if (ACTIVE_LOW_RESET !== 1'b0) begin : ACTIVE_LOW_ASYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                    always @(posedge clk, negedge rst) begin
                        if (~rst) begin
                            q   <=  RESET_VALUE;
                            q_b <= ~RESET_VALUE;
                        end else begin
                            q   <=  d;
                            q_b <= ~d;
                        end
                    end
                end : ACTIVE_LOW_SYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                else if (ACTIVE_LOW_RESET === 1'b0) begin : ACTIVE_HIGH_ASYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                    always @(posedge clk) begin
                        if (rst) begin
                            q   <=  RESET_VALUE;
                            q_b <= ~RESET_VALUE;
                        end else begin
                            q   <=  d;
                            q_b <= ~d;
                        end
                    end : ACTIVE_HIGH_ASYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
                end
            end : ASYNCHRONOUS_RESET_ENABLED_DFF_GENERATION
        end : 
        else begin : RESET_ENABLED_DFF_GENERATION
            always @(posedge clk) begin
                q   <=  d;
                q_b <= ~d;
            end
        end
    endgenerate
    
endmodule : BehviorallDFF