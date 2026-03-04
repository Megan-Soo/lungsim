module species_transport_c
  implicit none
  private

contains

!!!###################################################################################

  subroutine initialise_transport_c(VO2_in) bind(C, name="initialise_transport_c")
    
    use arrays,only: dp
    use species_transport, only: initialise_transport
    implicit none
    real(dp),intent(in) :: VO2_in
    
    call initialise_transport(VO2_in)

  end subroutine initialise_transport_c


end module species_transport_c
