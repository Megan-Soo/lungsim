
%module(package="aether") species_transport
%include symbol_export.h
%include species_transport.h

%{
#include "species_transport.h"
%}

void initialise_transport(double VO2_in);

%include species_transport.h
