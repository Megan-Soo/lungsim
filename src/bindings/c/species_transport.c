
#include "species_transport.h"

void initialise_transport_c(double *VO2_in);

void initialise_transport(double VO2_in)
{
	initialise_transport_c(&VO2_in);
}
