#!/bin/bash
# Define ANSI escape codes for colors
txtreset=$(tput sgr0)     # Text reset
txtgreen=$(tput setaf 10)  # Green
txtred=$(tput setaf 1)    # Red
bold=$(tput bold)        # Bold text


check_certificate_crt_file() {
  folder_path="ansible/ssl_certificates"

  if [[ -e "${folder_path}/certificate.crt" ]]; then
    echo "${txtgreen}certificate.crt file found in ${folder_path}${txtreset}"
  else
    while true; do
      echo -e "${bold}${txtred}Error - The file 'certificate.crt' does not exist in the folder '$folder_path'. Please upload the file.${txtreset} "
      break
    done
  fi
}

check_private_key_file() {
  folder_path="ansible/ssl_certificates"

  if [[ -e "${folder_path}/private.key" ]]; then
    echo "${txtgreen}private.key file found in ${folder_path}${txtreset}"
  else
    while true; do
      echo -e "${bold}${txtred}Error - The file 'private.key' does not exist in the folder '$folder_path'. Please upload the file.${txtreset}"
      break
    done
  fi
}



check_certificate_crt_file
check_private_key_file

