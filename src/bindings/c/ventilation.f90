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

  subroutine read_params_evaluate_flow_c(FRC, T_interval, Gdirn, press_in, i_to_e_ratio,&
                                        refvol, volume_target, pmus_step, chest_wall_compliance)&
                                        bind(C, name='read_params_evaluate_flow_c')
    use iso_c_binding, only: c_ptr
    use precision
    use ventilation, only: read_params_evaluate_flow
    implicit none

    integer,intent(inout) :: Gdirn
    real(dp),intent(inout) :: FRC, T_interval, press_in, i_to_e_ratio, refvol, volume_target,&
                          pmus_step, chest_wall_compliance

    call read_params_evaluate_flow(FRC, T_interval, Gdirn, press_in, i_to_e_ratio, refvol,&
                                  volume_target, pmus_step, chest_wall_compliance)

  end subroutine read_params_evaluate_flow_c

  !###################################################################################
end module ventilation_c
