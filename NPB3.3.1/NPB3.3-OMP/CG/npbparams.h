c CLASS = A
c  
c  
c  This file is generated automatically by the setparams utility.
c  It sets the number of processors and the class of the NPB
c  in this directory. Do not modify it by hand.
c  
        integer            na, nonzer, niter
        double precision   shift, rcond
        parameter(  na=14000,
     >              nonzer=11,
     >              niter=15,
     >              shift=20.,
     >              rcond=1.0d-1 )
        logical  convertdouble
        parameter (convertdouble = .false.)
        character compiletime*11
        parameter (compiletime='02 Apr 2025')
        character npbversion*5
        parameter (npbversion='3.3.1')
        character cs1*8
        parameter (cs1='gfortran')
        character cs2*6
        parameter (cs2='$(F77)')
        character cs3*6
        parameter (cs3='(none)')
        character cs4*6
        parameter (cs4='(none)')
        character cs5*31
        parameter (cs5='-O -fopenmp -fallow-invalid-boz')
        character cs6*26
        parameter (cs6='-O -fopenmp -lm -lgfortran')
        character cs7*6
        parameter (cs7='randi8')
