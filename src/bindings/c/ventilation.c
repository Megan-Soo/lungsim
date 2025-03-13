
#include "ventilation.h"

void evaluate_vent_c();
void evaluate_uniform_flow_c();
void two_unit_test_c();

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

void read_params_evaluate_flow(double FRC, double T_interval, int Gdirn, double press_in, double i_to_e_ratio, double refvol, double volume_target, double pmus_step, double chest_wall_compliance)
{
  read_params_evaluate_flow_c(&FRC, &T_interval, &Gdirn, &press_in, &i_to_e_ratio, &refvol, &volume_target, &pmus_step, &chest_wall_compliance);
}
