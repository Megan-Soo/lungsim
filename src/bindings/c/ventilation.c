
#include "ventilation.h"

void evaluate_vent_c();
void evaluate_uniform_flow_c();
void two_unit_test_c();
void read_params_evaluate_flow_c(double *T_interval, double *press_in, double *i_to_e_ratio, double *refvol, double *volume_target, double *pmus_step, double *chest_wall_compliance);

void evaluate_vent()
{
  evaluate_vent_c();
}

void evaluate_uniform_flow()
{
  evaluate_uniform_flow_c();
}

void two_unit_test()
{
  two_unit_test_c();
}

void read_params_evaluate_flow(double T_interval, double press_in, double i_to_e_ratio, double refvol, double volume_target, double pmus_step, double chest_wall_compliance)
{
  read_params_evaluate_flow_c(&T_interval, &press_in, &i_to_e_ratio, &refvol, &volume_target, &pmus_step, &chest_wall_compliance);
}
