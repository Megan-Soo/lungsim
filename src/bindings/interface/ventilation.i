
%module(package="aether") ventilation
%include symbol_export.h

%{
    #define SWIG_FILE_WITH_INIT
    #include "ventilation.h"
    #include "numpy/arrayobject.h"
%}

%include "numpy.i"
%init %{
    import_array();
%}

%apply (double* INPLACE_ARRAY2, int DIM1, int DIM2) {(double* xyz_out, int n, int dim)}
%apply (int* INPLACE_ARRAY2, int DIM1, int DIM2) {(int* edges_out, int n, int dim)}

void read_params_evaluate_flow(double T_interval, double press_in, double i_to_e_ratio, double refvol, double volume_target, double pmus_step, double chest_wall_compliance, int n_samples, const char *EXNODEFILE);

%include ventilation.h