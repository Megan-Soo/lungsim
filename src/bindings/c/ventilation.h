#ifndef AETHER_VENTILATION_H
#define AETHER_VENTILATION_H

#include "symbol_export.h"

SHO_PUBLIC void evaluate_vent();
SHO_PUBLIC void evaluate_uniform_flow();
SHO_PUBLIC void two_unit_test();
SHO_PUBLIC void read_params_evaluate_flow(double T_interval, double press_in, double i_to_e_ratio, double refvol, double volume_target, double pmus_step, double chest_wall_compliance, int n_samples, const char *EXNODEFILE);

int get_num_nodes_c();          // simple return value, no typemap needed
void get_node_xyz_c(double* xyz_out, int n, int dim);

int get_num_edges_c();
void get_edges_c(int* edges_out, int n, int dim);
void get_flow_edges_c(double* flow_out, int n, int dim);

int get_num_terminal_c();
void get_terminal_c(double* t_out, int n, int dim);
void get_flow_c(double* f_out, int n, int dim);

void initialise_vent_c();
void evaluate_vent_step_c();
int ventilation_continue_c();
int breath_continue_c();

#endif /* AETHER_VENTILATION_H */
