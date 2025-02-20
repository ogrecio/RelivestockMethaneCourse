#!/bin/bash

ml use /lustre/shared/Courses/RELIVESTOCK2025/modules

module load SnifferAnalyzer

sniffer_analyzer herd_robot101.csv herd_sniffer101_Loggy_48sg.txt 42
