#!/usr/bin/env python
import os,time

from aether.diagnostics import set_diagnostics_on
from aether.indices import ventilation_indices, get_ne_radius, get_ne_unstrained_radius
from aether.geometry import define_node_geometry, define_1d_elements, define_rad_from_file, define_rad_from_geom, append_units
from aether.ventilation import evaluate_vent
from aether.exports import export_1d_elem_geometry, export_node_geometry, export_elem_field, export_1d_elem_field, export_terminal_solution



def main():
    set_diagnostics_on(False)

    # Read settings
    ventilation_indices()
    export_directory = 'output'

    if not os.path.exists(export_directory):
        os.makedirs(export_directory)

    define_node_geometry('geometry/P2BRP268-H12816_Airway_Full.ipnode')
    define_1d_elements('geometry/P2BRP268-H12816_Airway_Full.ipelem')
	# If there is an ipfiel file you can use that
    # define_rad_from_file(get_default_geometry_path('SmallTree.ipfiel'))
	# In general its best to set up airway radius on solve (typically faster)
    trachea_rad=8.74 #radius of trachea (ideally from imaging)
    h_ratio=1.16 #Horsfield ratio (adjusted so terminal bronchioles are approx 0.1-0.15mm radius)
    order_system = 'horsf' #tell the code to use the horsfield system
    order_options = 'all'
    name = 'inlet'
    define_rad_from_geom(order_system, h_ratio, name, trachea_rad, order_options,'')

    append_units()

    # Set the working directory to the this files directory and then reset after running simulation.
    file_location = os.path.dirname(os.path.abspath(__file__))
    cur_dir = os.getcwd()
    os.chdir(file_location)

    # Run simulation.
    start=time.time()
    evaluate_vent()
    end=time.time()
    print(f' Simulation elapsed time: {round((end-start)/60,2)} minutes')

    # Set the working directory back to it's original location.
    os.chdir(cur_dir)

    # Output results
    # Export airway nodes and elements
    group_name = 'vent_model'
    export_1d_elem_geometry(export_directory + '/P2BRP268-H12816_Airway.exelem', group_name)
    export_node_geometry(export_directory + '/P2BRP268-H12816_Airway.exnode', group_name)

    # Export element field for radius
    field_name = 'flow'
    export_1d_elem_field(6, export_directory + '/P2BRP268-H12816_ventilation_field.exelem', group_name, field_name)

    # Export element field for radius
    ne_radius = get_ne_radius()
    field_name = 'radius'
    export_1d_elem_field(ne_radius, export_directory + '/P2BRP268-H12816_ventilation_radius_field.exelem', group_name, field_name)

    # Export terminal solution
    export_terminal_solution(export_directory + '/P2BRP268-H12816_terminal.exnode', group_name)

    # Export elem field
    ne_unstrained_rad = get_ne_unstrained_radius()
    export_1d_elem_field(ne_unstrained_rad, export_directory + '/P2BRP268-H12816_elem.exelem', group_name,field_name)


if __name__ == '__main__':
    main()
