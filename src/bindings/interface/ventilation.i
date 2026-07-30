
%module(package="aether") ventilation
%include symbol_export.h

%{
    #include "ventilation.h"
%}

void read_params_evaluate_flow(double T_interval, double press_in, double i_to_e_ratio, double refvol, double volume_target, double pmus_step, double chest_wall_compliance, int n_samples, const char *EXNODEFILE);

%include ventilation.h