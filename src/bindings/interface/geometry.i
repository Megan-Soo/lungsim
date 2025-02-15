%module(package="aether") geometry
  %include symbol_export.h
  
  %typemap(in) (int elemlist_len, int elemlist[]) {
  int i;
  if (!PyList_Check($input)) {
    PyErr_SetString(PyExc_ValueError, "Expecting a list");
    SWIG_fail;
  }
  $1 = PyList_Size($input);
  $2 = (int *) malloc(($1)*sizeof(int));
  for (i = 0; i < $1; i++) {
    PyObject *o = PyList_GetItem($input, i);
    if (!PyInt_Check(o)) {
      free($2);
      PyErr_SetString(PyExc_ValueError, "List items must be integers");
      SWIG_fail;
    }
    $2[i] = PyInt_AsLong(o);
  }
 }
 
  %typemap(in) (int unit_dvdt_list_len, float unit_dvdt_list[]) {
  int i;
  if (!PyList_Check($input)) {
    PyErr_SetString(PyExc_ValueError, "Expecting a list");
    SWIG_fail;
  }
  $1 = PyList_Size($input);
  $2 = (float *) malloc(($1)*sizeof(float));
  for (i = 0; i < $1; i++) {
    PyObject *o = PyList_GetItem($input, i);
    if (!PyFloat_Check(o)) {
      free($2);
      PyErr_SetString(PyExc_ValueError, "List items must be float values");
      SWIG_fail;
    }
    $2[i] = PyFloat_AsDouble(o);
  }
 }
 
  %typemap(in) (int centroid_list_len, double centroid_list[]) {
  int i;
  if (!PyList_Check($input)) {
    PyErr_SetString(PyExc_ValueError, "Expecting a list");
    SWIG_fail;
  }
  $1 = PyList_Size($input);
  $2 = (double *) malloc(($1)*sizeof(double));
  for (i = 0; i < $1; i++) {
    PyObject *o = PyList_GetItem($input, i);
    if (!PyFloat_Check(o)) {
      free($2);
      PyErr_SetString(PyExc_ValueError, "List items must be float values");
      SWIG_fail;
    }
    $2[i] = PyFloat_AsDouble(o);
  }
 }
 
  %typemap(in) (int signals_list_len, double signals_list[]) {
  int i;
  if (!PyList_Check($input)) {
    PyErr_SetString(PyExc_ValueError, "Expecting a list");
    SWIG_fail;
  }
  $1 = PyList_Size($input);
  $2 = (double *) malloc(($1)*sizeof(double));
  for (i = 0; i < $1; i++) {
    PyObject *o = PyList_GetItem($input, i);
    if (!PyFloat_Check(o)) {
      free($2);
      PyErr_SetString(PyExc_ValueError, "List items must be float values");
      SWIG_fail;
    }
    $2[i] = PyFloat_AsDouble(o);
  }
 }

  %typemap(in) (int spaces_preful_len, double spaces_preful[]) {
  int i;
  if (!PyList_Check($input)) {
    PyErr_SetString(PyExc_ValueError, "Expecting a list");
    SWIG_fail;
  }
  $1 = PyList_Size($input);
  $2 = (double *) malloc(($1)*sizeof(double));
  for (i = 0; i < $1; i++) {
    PyObject *o = PyList_GetItem($input, i);
    if (!PyFloat_Check(o)) {
      free($2);
      PyErr_SetString(PyExc_ValueError, "List items must be float values");
      SWIG_fail;
    }
    $2[i] = PyFloat_AsDouble(o);
  }
 }

%typemap(freearg) (int elemlist_len, int elemlist[]) {
  if ($2) free($2);
 }
 
%typemap(freearg) (int unit_dvdt_list_len, int unit_dvdt_list[]) {
  if ($2) free($2);
 }
 
%typemap(freearg) (int centroid_list_len, int centroid_list[]) {
  if ($2) free($2);
 }
 
%typemap(freearg) (int signals_list_len, int signals_list[]) {
  if ($2) free($2);
 }
 
%typemap(freearg) (int spaces_preful_len, int spaces_preful[]) {
  if ($2) free($2);
 }

%{
#include "geometry.h"
  %}

// define_rad_from_file has an optional argument that C cannot replicate,
// so we use SWIG to override with a C++ version that can.
void define_elem_geometry_2d(const char *ELEMFILE, const char *sf_option="arcl");
void define_node_geometry_2d(const char *NODEFILE);
void import_node_geometry_2d(const char *NODEFILE);
void write_elem_geometry_2d(const char *ELEMFILE);
void write_geo_file(int ntype, const char *GEOFILE);
void write_node_geometry_2d(const char *NODEFILE);
void define_rad_from_file(const char *FIELDFILE, const char *radius_type="no_taper");
void define_init_volume(const char *FIELDFILE, const char *FRC);
void read_params(int spaces_preful_len, double spaces_preful[], int num_centroids, int num_frames);
void read_centroid_signals(int idx_centroid, int centroid_list_len, double centroid_list[], int signals_list_len, double signals_list[]);
void define_rad_from_geom(const char *ORDER_SYSTEM, double CONTROL_PARAM, const char *START_FROM, double START_RAD, const char *group_type_in="all", const char *group_option_in="dummy");


%include geometry.h

