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
  ! (MS) added
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

  subroutine get_flow_edges_c(flow_out, n, dim) bind(C, name="get_flow_edges_c")
    use iso_c_binding
    use indices, only: ne_Vdot
    use arrays, only: elem_field
    integer(c_int), value :: n, dim
    real(c_double), intent(out) :: flow_out(dim, n)
    flow_out(1,:) = elem_field(ne_Vdot, :)
  end subroutine get_flow_edges_c

  function get_num_terminal_c() result(n) bind(C, name="get_num_terminal_c")
    use iso_c_binding
    use arrays, only: num_units
    integer(c_int) :: n
    n = num_units
  end function get_num_terminal_c

  subroutine get_terminal_c(t_out, n , dim) bind(C, name="get_terminal_c")
    use iso_c_binding
    use arrays, only: elem_nodes, units, num_units, node_xyz
    integer(c_int),value :: n, dim
    real(c_double), intent(out) :: t_out(dim, n)
    integer :: np, nolist
    do nolist=1,num_units
      np=elem_nodes(2,units(nolist))
      t_out(:,nolist)=node_xyz(:,np)
    enddo
  end subroutine get_terminal_c

  subroutine get_flow_c(f_out, n, dim) bind(C, name="get_flow_c")
    use iso_c_binding
    use indices, only: nu_vol
    use arrays, only: unit_field, num_units
    integer(c_int), value :: n, dim
    real(c_double), intent(out) :: f_out(dim, n)
    f_out(1,:) = unit_field(nu_vol,:)
  end subroutine get_flow_c

!###################################################################################
 ! (MS) WIP: see if efficient to get in Python environment
  ! function get_unit_field_shape_c(dim1, dim2) bind(C, name="get_unit_field_shape_c")
  !   use iso_c_binding
  !   use ventilation, only: unit_field
  !   integer(c_int), intent(out) :: dim1, dim2
  !   dim1 = size(unit_field, 1)
  !   dim2 = size(unit_field, 2)
  ! end function

  ! subroutine get_unit_field_c(field_out, d1, d2) bind(C, name="get_unit_field_c")
  !   use iso_c_binding
  !   use ventilation, only: unit_field
  !   integer(c_int), value :: d1, d2
  !   real(c_double), intent(out) :: field_out(d1, d2)
  !   field_out = unit_field
  ! end subroutine get_unit_field_c
!###################################################################################

  subroutine initialise_vent_c() bind(C, name="initialise_vent_c")
    use ventilation, only: initialise_vent
    implicit none

    call initialise_vent()

  end subroutine initialise_vent_c

!###################################################################################
  
subroutine evaluate_vent_step_c() bind(C, name="evaluate_vent_step_c")
  use ventilation, only: evaluate_vent_step
  implicit none
  call evaluate_vent_step()
end subroutine evaluate_vent_step_c

  !###################################################################################
  
  function ventilation_continue_c() result(continue_flag) bind(C, name="ventilation_continue_c")
    use iso_c_binding
    use ventilation, only: ventilation_continue!, n, num_brths, sum_tidal, volume_target
    implicit none
    integer(c_int) :: continue_flag

    continue_flag = merge(1, 0, ventilation_continue())!(n, num_brths, sum_tidal, volume_target))

  end function ventilation_continue_c
  !###################################################################################

  function breath_continue_c() result(continue_flag) bind(C, name="breath_continue_c")
    use iso_c_binding
    use ventilation, only: breath_continue
    implicit none
    integer(c_int):: continue_flag
    continue_flag=merge(1,0,breath_continue())
  end function breath_continue_c

  !###################################################################################
  
end module ventilation_c
