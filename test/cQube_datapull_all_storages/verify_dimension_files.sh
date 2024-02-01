#!/bin/bash
# Define ANSI escape codes for colors
txtreset=$(tput sgr0)     # Text reset
txtgreen=$(tput setaf 10)  # Green
txtred=$(tput setaf 1)    # Red
bold=$(tput bold)        # Bold text


check_district-dimension_file() {
  folder_path="ansible/dimension_files"

  if [[ -e "${folder_path}/district-dimension.data.csv" ]]; then
    echo "${txtgreen}district-dimension.data.csv file found in ${folder_path}${txtreset}"
  else
    while true; do
      echo -e "${bold}${txtred}Error - The file 'district-dimension.data.csv' does not exist in the folder '$folder_path'. Please upload the file.${txtreset} "
      break
    done
  fi
}

check_grade-dimension_file() {
  folder_path="ansible/dimension_files"

  if [[ -e "${folder_path}/grade-dimension.data.csv" ]]; then
    echo "${txtgreen}grade-dimension.data.csv file found in ${folder_path}${txtreset}"
  else
    while true; do
      echo -e "${bold}${txtred}Error - The file 'grade-dimension.data.csv' does not exist in the folder '$folder_path'. Please upload the file.${txtreset} "
      break
    done
  fi
}

check_medium-dimension_file() {
  folder_path="ansible/dimension_files"

  if [[ -e "${folder_path}/medium-dimension.data.csv" ]]; then
    echo "${txtgreen}medium-dimension.data.csv file found in ${folder_path}${txtreset}"
  else
    while true; do
      echo -e "${bold}${txtred}Error - The file 'medium-dimension.data.csv' does not exist in the folder '$folder_path'. Please upload the file.${txtreset} "
      break
    done
  fi
}

check_state-dimension_file() {
  folder_path="ansible/dimension_files"

  if [[ -e "${folder_path}/state-dimension.data.csv" ]]; then
    echo "${txtgreen}state-dimension.data.csv file found in ${folder_path}${txtreset}"
  else
    while true; do
      echo -e "${bold}${txtred}Error - The file 'state-dimension.data.csv' does not exist in the folder '$folder_path'. Please upload the file.${txtreset} "
      break
    done
  fi
}

check_subject-dimension_file() {
  folder_path="ansible/dimension_files"

  if [[ -e "${folder_path}/subject-dimension.data.csv" ]]; then
    echo "${txtgreen}subject-dimension.data.csv file found in ${folder_path}${txtreset}"
  else
    while true; do
      echo -e "${bold}${txtred}Error - The file 'subject-dimension.data.csv' does not exist in the folder '$folder_path'. Please upload the file.${txtreset} "
      break
    done
  fi
}

check_district-dimension_file
check_grade-dimension_file
check_medium-dimension_file
check_state-dimension_file
check_subject-dimension_file


