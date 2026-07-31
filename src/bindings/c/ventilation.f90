module ventilation_c
  implicit none
  private

contains

!!!###################################################################################

  subroutine evaluate_vent_c() bind(C, name="evaluate_vent_c")

    use arrays,only: dp
    use ventilation, only: evaluate_vent
    implicit none

    call evaluate_vent()

  end subroutine evaluate_vent_c


  !###################################################################################

  subroutine evaluate_uniform_flow_c() bind(C, name="evaluate_uniform_flow_c")

    use ventilation, only: evaluate_uniform_flow
    implicit none

    call evaluate_uniform_flow

  end subroutine evaluate_uniform_flow_c


!###################################################################################

  subroutine two_unit_test_c() bind(C, name="two_unit_test_c")
    use ventilation, only: two_unit_test
    implicit none

    call two_unit_test

  end subroutine two_unit_test_c

!###################################################################################

  subroutine read_params_evaluate_flow_c(T_interval, press_in, i_to_e_ratio,&
                                        refvol, volume_target, pmus_step, chest_wall_compliance,&
                                        n_samples, EXNODEFILE, filename_len)&
                                        bind(C, name='read_params_evaluate_flow_c')
    use iso_c_binding, only: c_ptr
    use other_consts, only: MAX_FILENAME_LEN
    use utils_c, only: strncpy
    use precision
    use ventilation, only: read_params_evaluate_flow
    implicit none

    real(dp),intent(inout) :: T_interval, press_in, i_to_e_ratio, refvol, volume_target,&
                          pmus_step, chest_wall_compliance
    integer, intent(inout) :: n_samples
    integer, intent(in) :: filename_len
    type(c_ptr), value, intent(in) :: EXNODEFILE
    character(len=MAX_FILENAME_LEN) :: filename_f
    call strncpy(filename_f, EXNODEFILE, filename_len)

    call read_params_evaluate_flow(T_interval, press_in, i_to_e_ratio, refvol,&
                                  volume_target, pmus_step, chest_wall_compliance, n_samples, filename_f)

  end subroutine read_params_evaluate_flow_c

  !###################################################################################

  function get_num_nodes_c() result(n) bind(C, name="get_num_nodes_c")
    use iso_c_binding
    use arrays, only: node_xyz
    integer(c_int) :: n
    n = size(node_xyz, 2)
  end function get_num_nodes_c

  subroutine get_node_xyz_c(xyz_out, n, dim) bind(C, name="get_node_xyz_c")
    use iso_c_binding
    use arrays, only: node_xyz
    integer(c_int), value :: n, dim
    real(c_double), intent(out) :: xyz_out(dim, n)
    xyz_out = node_xyz
  end subroutine get_node_xyz_c

    function get_num_edges_c() result(n) bind(C, name="get_num_edges_c")
    use iso_c_binding
    use arrays, only: elem_nodes
    integer(c_int) :: n
    n = size(elem_nodes, 2)
  end function get_num_edges_c

  subroutine get_edges_c(edges_out, n, dim) bind(C, name="get_edges_c")
    use iso_c_binding
    use arrays, only: elem_nodes
    integer(c_int), value :: n, dim
    integer(c_int), intent(out) :: edges_out(dim, n)
    edges_out = elem_nodes
  end subroutine get_edges_c

end module ventilation_c
