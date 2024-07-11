//-----------------------------------------------------------------------------
// Licensing:    It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//               under Creative Commons Attribution 4.0 International.
// Company:      It's All Digital To Me
// Engineer:     Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
//-----------------------------------------------------------------------------

module SignedMagnitudeAddition
#(  //------------------------------//-----------------------------------------
    //                              // Description(s)
    //------------------------------//-----------------------------------------
    parameter int N = 32,           //
    parameter int B =  2            //
)  (//------------------------------//-----------------------------------------
    //                              // Description(s)
    //------------------------------//-----------------------------------------
    input  logic [N-1:0] a,         //
    input  logic [N-1:0] b,         //
    input  logic         carry_in,  //
    //------------------------------//-----------------------------------------
    //                              // Description(s)
    //------------------------------//-----------------------------------------
    output logic [N-1:0] c,         //
    output logic [N-1:0] carry_out  //
);


    function logic [N:0] NaturalAddition (
    // Function Parameter(s)
    logic [N-1:0] a,
    logic [N-1:0] b,
    logic         carry_in);
    // Local Variables
    logic [N:0] carry;
    begin
        carry[0] = carry_in;
        for (int i = 0; i < N; i = i + 1) begin
            {carry[i+1], c[i]} = carry[i] + a[i] + b[i];
        end
        return {carry[N], c};
    end
    endfunction : NaturalAddition


    function logic [N+1:0] Subtraction (
    // Function Parameter(s)
    logic [N-1:0] a,
    logic [N-1:0] b,
    logic         carry_in);
    // Local Variables
    logic         negative;
    logic [N  :0] carry;
    begin
        carry[0] = carry_in;
        for (int i = 0; i < N-1: i = i + 1) begin : BITWISE_SUBSTRACTION
            if ((a[i] - b[i] - carry[i]) < 0) begin : CARRY_DETECTED
                carry[i+1] = 1'b1;
            end : CARRY_DETECTED
            else begin : CARRY_DETECTED
                carry[i+1] = 1'b0;
            end : CARRY_DETECTED
            c[i] = (a[i]-b[i]-carry[i]) & 1'b1;
        end : BITWISE_SUBSTRACTION
        negative = c[N-1];
        carry_out = carry[N];
        return {negative, carry_out, c};
    end
    endfunction : Subtraction

    function logic [N+1:0] BsComplementAddition(
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,
    input  logic         carry_in);
    // Local Variables
    logic         negative;
    begin
        if (a[N-1] == 1'b0) a[N-1] = 1'b0;
        else                a[N-1] = 1'(B - 1);
        
        if (b[N-1] == 1'b0) b[N-1] = 1'b0;
        else                b[N-1] = 1'(B - 1);
        
        {carry_out, c} = NaturalAddition(a, b, carry_in);
        negative = c[N-1];
        return {negative, carry_out, c};
    end
    endfunction : BsComplementAddition
    


    function logic [N-1:0] BsComplementSignChange(
    input  logic [N-1:0] a);
    // Local Variables
    logic         carry_out;
    logic [N-1:0] inv_a;
    logic [N-1:0] c;
    begin
        if (a[N-1] == 1'b0) a[N-1] = 1'b0;
        else                a[N-1] = 1'(B - 1);
        for (int i = 0; i < N-1; i = i +1 ) begin : INVERT_BITS
            inv_a[i] = ~a[i];
        end : INVERT_BITS
        {carry_out, c} = NaturalAddition(1, inv_a, 0);
    end
    endfunction : BsComplementSignChange

    // B’s Complement Subtraction
    // if x(n-1)<B/2 then x(n):=0; else x(n):=B-1; end if;
    // if y(n-1)<B/2 then y(n):=0; else y(n):=B-1; end if;
    // for i in 0..n loop y’(i):=B-1-y(i); end loop;
    // c_in:=1-b_in;
    // natural_addition(n+1, x, y’, c_in, z, not_used);    
    function logic [N-1:0] BsComplementSubtraction(
    // Function Parameter(s)
    logic [N-1:0] a,
    logic [N-1:0] b,
    logic         carry_in);
    // Local Variables
    logic [N-1:0] inv_a;
    begin
        if (a[N-1] == 1'b0) a[N-1] = 1'b0;
        else                a[N-1] = 1'(B - 1);
        
        if (b[N-1] == 1'b0) b[N-1] = 1'b0;
        else                b[N-1] = 1'(B - 1);

        for (int i = 0; i < N-1; i = i +1 ) begin : INVERT_BITS
            inv_b[i] = ~a[i];
        end : INVERT_BITS        
    end
    endfunction : BsComplementSubtraction




    always@*


endmodule : SignedMagnitudeAddition
