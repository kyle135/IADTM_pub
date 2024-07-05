`ifndef RTL_FUNCTIONS_VH
    `define RTL_FUNCITIONS_VH

function automatic unsigned integer min_unsigned (input unsigned integer a, input unsigned integer b)

    if ( a <= b ) return a;
    else          return b;

endfunction


function automatic signed integer min_signed ( 
    integer signed a,
    integer signed b);

    if ( a <= b ) return a;
    else          return b;

endfunction


`endif
