#ifndef AETHER_VENTILATION_H
#define AETHER_VENTILATION_H

#include "symbol_export.h"

SHO_PUBLIC void evaluate_vent();
SHO_PUBLIC void evaluate_uniform_flow();
SHO_PUBLIC void two_unit_test();
SHO_PUBLIC void read_params_evaluate_flow(double T_interval, double press_in, double i_to_e_ratio, double refvol, double volume_target, double pmus_step, double chest_wall_compliance, int n_samples, const char *EXNODEFILE);

#endif /* AETHER_VENTILATION_H */
