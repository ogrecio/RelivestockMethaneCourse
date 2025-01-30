!W 10000 !CYCLE !RENAME !ARG 6 8  // !DOPART $1
Title: test_course
 ID            !P
 herd          !A 
 HYS           !I 155
 parity		   !I 3
 ACC
 lact_week
 std_avgCH4
 std_speaks
 std_npeaks
 std_avgCO2
 std_ratio
 std_CH4gr
 std_MeI
 npeaks100 !=std_npeaks !*100
 peID          !A 1200

ped4gen_ord2.ped   !MAKE !CSV !SORT
DB4co4.dat  !SKIP !MAXIT 2000 !AISING !continue !TOLERANCE !MVINCLUDE 

### UNIVARIATE NETHERLANDS ###

!PART 1

std_avgCH4 ~ mu HYS lact_week ACC.parity  !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4

!PART 2

std_speaks ~ mu HYS lact_week ACC.parity  !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4

!PART 3

std_npeaks ~ mu HYS lact_week ACC.parity  !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4

!PART 4

std_avgCO2 ~ mu HYS lact_week ACC.parity !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4

!PART 5

std_ratio ~ mu HYS lact_week ACC.parity !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4

!PART 6

std_CH4gr ~ mu HYS lact_week ACC.parity !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4

!PART 7

std_MeI ~ mu HYS lact_week ACC.parity  !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4

!PART 8

npeaks100 ~ mu HYS lact_week ACC.parity  !r nrm(ID) peID

VPREDICT !DEFINE
P Var_P       1 2 3        # 4
H h2          2 4
H c2          1 4
