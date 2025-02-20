#!/bin/bash

ml use /lustre/shared/Courses/RELIVESTOCK2025/modules
rm /home/WUR/manza003/.asreml/asreml_active
rm /home/WUR/manza003/VSNi
module load asreml/4.2.1

time asreml -n uni.as
#time asreml -n biv.as
#time asreml -n RR.as