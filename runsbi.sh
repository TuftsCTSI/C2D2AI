#/bin/bash
#input dir is the dir of the notes for patients
# INPUT_DIR="/reev/data/proj_SBI/ESPRESSO-2023/input/"
# OUTPUT_DIR="/reev/data/proj_SBI/ESPRESSO-2023/output/raw/"
# OUTPUT_SUMMARY_DIR="/reev/data/proj_SBI/ESPRESSO-2023/output/summary/"
# RULES_DIR="/reev/data/proj_SBI/ESPRESSO-2023/SBI/"

# INPUT_DIR="/root/ESPRESSO-2023/input/"
# OUTPUT_DIR="/root/ESPRESSO-2023/output/raw/"
# OUTPUT_SUMMARY_DIR="/root/ESPRESSO-2023/output/summary/"
# RULES_DIR="/root/ESPRESSO-2023/SBI/"

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )


INPUT_DIR=$DIR"/input/"
OUTPUT_DIR=$DIR"/output/raw/"
OUTPUT_SUMMARY_DIR=$DIR"/output/summary/"
RULES_DIR=$DIR"/SBI/"
echo '$INPUT_DIR'

java -Xms512M -Xmx2000M -jar MedTagger-fit.jar $INPUT_DIR $OUTPUT_DIR $RULES_DIR
python3 SBI/model/run_output_sbi.py $OUTPUT_DIR $OUTPUT_SUMMARY_DIR "0"

