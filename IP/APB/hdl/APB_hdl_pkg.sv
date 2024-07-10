//-----------------------------------------------------------------------------
// Licensing:   It's All Digital To Me © 2018 by Kyle D. Gilsdorf is licensed 
//              under Creative Commons Attribution 4.0 International.
// Company:     It's All Digital To Me
// Engineer:    Kyle D. Gilsdorf (Kyle.Gilsdorf@asu.edu)
// Module Name: APB_hdl_pkg
// Description: 
// Contains all type defintions, parameters, tasks, for APB logic.    
//-----------------------------------------------------------------------------
package APB_hdl_pkg;
    //-------------------------------------------------------------------------
    // Local Parameter(s)
    //-------------------------------------------------------------------------


    //-------------------------------------------------------------------------
    // Type Definition(s)
    //-------------------------------------------------------------------------
    typedef enum logic {            //
        APB_NOT_SELECTED= 1'b0,     //
        APB_SELECTED    = 1'b1      //
    } apb_select_t;

    typedef enum logic {            //
        APB_READ        = 1'b0,     //
        APB_WRITE       = 1'b1      //
    } apb_direction_t;              //
    
    typedef enum logic {            //
        APB_NOT_READY   = 1'b0,     //
        APB_READY       = 1'b1      //
    } apb_ready_t;                  //

    typedef enum logic {            //
        APB_DISABLE     = 1'b0,     //
        APB_ENABLE      = 1'b1      //
    } apb_enable_t;                 //

    typedef enum logic {            //
        APB_NO_ERROR    = 1'b0,     //
        APB_ERROR       = 1'b1      //
    } apb_error_t;                  //

    typedef enum logic {            //
        APB_NORMAL      = 1'b0,     //
        APB_PRIVILEGED  = 1'b1      //
    } apb_privileged_access_t;      //

    typedef enum logic {            //
        APB_SECURE      = 1'b0,     //
        APB_NON_SECURE  = 1'b1      //
    } apb_secure_access_t;          //

    typedef enum logic {            //
        APB_DATA        = 1'b0,     //
        APB_INSTRUCTION = 1'b1      //
    } apb_data_instruction_t;       //

    typedef union packed {              //
        logic [2:0]  protection;        //
        struct packed {                 //
            apb_data_instruction_t  d;  // [2] Data or Instruction
            apb_secure_access_t     s;  // [1] Secure or non-secure
            apb_privileged_access_t p;  // [0] Normal or privileged
        } apb_protection_s;             //
    } apb_protection_t;

endpackage : APB_hdl_pkg
