!W 10000 !CYCLE !RENAME !ARG 1 2 // !DOPART $1
Title: uni_RR
 ID            !P
 herd          !A 
 HYS           !I 41
 parity		   !I 3
 ACC
 lact_week     40
 avgCH4
 speaks
 npeaks
 avgCO2
 ratio
 CH4gr
 MeI
 peID          !A 1173
 npeaks100 !=npeaks !*100

ped.ped   !MAKE !CSV !SORT
datRR.dat  !SKIP !MAXIT 2000 !AISING !continue !TOLERANCE !MVINCLUDE !EMFLAG 5

### UNIVARIATE RANDOM REGRESSION ###

!PART 1  
avgCH4 ~ mu HYS lact_week parity.leg(lact_week,1) parity.leg(ACC,2) !r us(leg(lact_week,1)).nrm(ID) us(leg(lact_week,1)).id(peID)  

!VPREDICT !DEFINE
F Perm   peID  * 1      
F AddVar nrm(ID)  * 1
K Leg1_0   0.70711  -1.22474
K Leg1_10   0.70711  -0.61237
K Leg1_20   0.70711   0.00000
K Leg1_30   0.70711   0.61237
K Leg1_40   0.70711   1.22474
M Genmat Leg AddVar
M Pemat Leg Perm
F Phenvar AddVar Perm Residual
F Phenvar0 14 29 Residual
F Phenvar10 16 31 Residual
F Phenvar20 19 34 Residual
F Phenvar30 23 38 Residual
F Phenvar40 28 43 Residual
H H2_0 14 47
H H2_10 16 48
H H2_20 19 49
H H2_30 23 50
H H2_40 28 51
H C2_0 29 47
H C2_10 31 48
H C2_20 34 49
H C2_30 38 50
H C2_40 43 51
R Gencorr Genmat
R Pecorr Pemat

#### FULL MATRIX
!PART 2
avgCH4 ~ mu HYS lact_week parity.leg(lact_week,1) parity.leg(ACC,2) !r us(leg(lact_week,1)).nrm(ID) us(leg(lact_week,1)).id(peID)  

!VPREDICT !DEFINE
F Perm   peID  * 1      
F AddVar nrm(ID)  * 1
K Leg1_0   0.70711  -1.22474
K Leg1_1   0.70711  -1.16351
K Leg1_2   0.70711  -1.10227
K Leg1_3   0.70711  -1.04103
K Leg1_4   0.70711  -0.97980
K Leg1_5   0.70711  -0.91856
K Leg1_6   0.70711  -0.85732
K Leg1_7   0.70711  -0.79608
K Leg1_8   0.70711  -0.73485
K Leg1_9   0.70711  -0.67361
K Leg1_10   0.70711  -0.61237
K Leg1_11   0.70711  -0.55114
K Leg1_12   0.70711  -0.48990
K Leg1_13  0.70711  -0.42866
K Leg1_14   0.70711  -0.36742
K Leg1_15   0.70711  -0.30619
K Leg1_16   0.70711  -0.24495
K Leg1_17   0.70711  -0.18371
K Leg1_18   0.70711  -0.12247
K Leg1_19   0.70711  -0.06124
K Leg1_20   0.70711   0.00000
K Leg1_21   0.70711   0.06124
K Leg1_22   0.70711   0.12247
K Leg1_23   0.70711   0.18371
K Leg1_24   0.70711   0.24495
K Leg1_25   0.70711   0.30619
K Leg1_26   0.70711   0.36742
K Leg1_27   0.70711   0.42866
K Leg1_28   0.70711   0.48990
K Leg1_29   0.70711   0.55114
K Leg1_30   0.70711   0.61237
K Leg1_31   0.70711   0.67361
K Leg1_32   0.70711   0.73485
K Leg1_33   0.70711   0.79608
K Leg1_34   0.70711   0.85732
K Leg1_35   0.70711   0.91856
K Leg1_36   0.70711   0.97980
K Leg1_37   0.70711   1.04103
K Leg1_38   0.70711   1.10227
K Leg1_39   0.70711   1.16351
K Leg1_40   0.70711   1.22474
M Genmat Leg AddVar
M Pemat Leg Perm
F Phenvar AddVar Perm Residual
F Phenvar0 14 875 Residual
F Phenvar1 16 877 Residual
F Phenvar2 19 880 Residual
F Phenvar3 23 884 Residual
F Phenvar4 28 889 Residual
F Phenvar5 34 895 Residual
F Phenvar6 41 902 Residual
F Phenvar7 49 910 Residual
F Phenvar8 58 919 Residual
F Phenvar9 68 929 Residual
F Phenvar10 79 940 Residual
F Phenvar11 91 952 Residual
F Phenvar12 104 965 Residual
F Phenvar13 118 979 Residual
F Phenvar14 133 994 Residual
F Phenvar15 149 1010 Residual
F Phenvar16 166 1027 Residual
F Phenvar17 184 1045 Residual
F Phenvar18 203 1064 Residual
F Phenvar19 223 1084 Residual
F Phenvar20 244 1105 Residual
F Phenvar21 266 1127 Residual
F Phenvar22 289 1150 Residual
F Phenvar23 313 1174 Residual
F Phenvar24 338 1199 Residual
F Phenvar26 364 1225 Residual
F Phenvar27 391 1252 Residual
F Phenvar28 419 1280 Residual
F Phenvar29 448 1309 Residual
F Phenvar30 478 1339 Residual
F Phenvar31 509 1370 Residual
F Phenvar32 541 1402 Residual
F Phenvar33 574 1435 Residual
F Phenvar34 608 1469 Residual
F Phenvar35 643 1504 Residual
F Phenvar36 679 1540 Residual
F Phenvar37 716 1577 Residual
F Phenvar38 754 1615 Residual
F Phenvar39 793 1654 Residual
F Phenvar40 833 1694  Residual
F Phenvar41 874 1735 Residual
H H2_0 14 1739
H H2_1 16 1740
H H2_2 19 1741
H H2_3 23 1742
H H2_4 28 1743
H H2_5 34 1744
H H2_6 41 1745
H H2_7 49 1746
H H2_8 58 1747
H H2_9 68 1748
H H2_10 79 1749
H H2_11 91 1750
H H2_12 104 1751
H H2_13 118 1752
H H2_14 133 1753
H H2_15 149 1754
H H2_16 166 1755
H H2_17 184 1756
H H2_18 203 1757
H H2_19 223 1758
H H2_20 244 1759
H H2_21 266 1760
H H2_22 289 1761
H H2_23 313 1762
H H2_24 338 1763
H H2_25 364 1764
H H2_26 391 1765
H H2_27 419 1766
H H2_28 448 1767
H H2_29 478 1768
H H2_30 509 1769
H H2_31 541 1770
H H2_32 574 1771
H H2_33 608 1772
H H2_34 643 1773
H H2_35 679 1774
H H2_36 716 1775
H H2_37 754 1776
H H2_38 793 1777
H H2_39 833 1778
H H2_40 874 1779
H C2_0 875 1739
H C2_1 877 1740
H C2_2 880 1741
H C2_3 884 1742
H C2_4 889 1743
H C2_5 895 1744
H C2_6 902 1745
H C2_7 910 1746
H C2_8 919 1747
H C2_9 929 1748
H C2_10 940 1749
H C2_11 952 1750
H C2_12 965 1751
H C2_13 979 1752
H C2_14 994 1753
H C2_15 1010 1754
H C2_16 1027 1755
H C2_17 1045 1756
H C2_18 1064 1757
H C2_19 1084 1758
H C2_20 1105 1759
H C2_21 1127 1760
H C2_22 1150 1761
H C2_23 1174 1762
H C2_24 1199 1763
H C2_25 1225 1764
H C2_26 1252 1765
H C2_27 1280 1766
H C2_28 1309 1767
H C2_29 1339 1768
H C2_30 1370 1769
H C2_31 1402 1770
H C2_32 1435 1771
H C2_33 1469 1772
H C2_34 1504 1773
H C2_35 1540 1774
H C2_36 1577 1775
H C2_37 1654 1776
H C2_38 1694 1777
H C2_39 1735 1778
H C2_40 1615 1779
R Gencorr Genmat
R Pecorr Pemat