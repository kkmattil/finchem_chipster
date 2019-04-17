# TOOL finscreen_import.R: "Import data to vial database" (Imports data from the stadard formatted csv file to the DDCB compound database.)
# INPUT input: "Input dataform" TYPE GENERIC
# OUTPUT import.log
# PARAMETER univ: "Institute" TYPE STRING (Home institute of the imported data)
# PARAMETER dep: "Department" TYPE STRING (Home department of the imported data)
# PARAMETER person: "Contact person" TYPE STRING (Contact person for the imported data)
# PARAMETER OPTIONAL sep: "Column separator in input file" TYPE [tab: "tabulator", space: "space or tabulator", semic: "semicolon (\;\)", doubp: "colon (\:\)", comma: "comma (\,\)", pipe: "pipe (\|\)"] DEFAULT semic (Select the column separator used to parse the input data. By default, Chipster uses tabulator.)  


# Handle output names
source(file.path(chipster.common.path, "tool-utils.R"))
input.names <- read.table("chipster-inputs.tsv", header=F, sep="\t")
data_inf <- input.names[1,2]

echo_command <- paste("echo input file name:", data_inf, "> import.log") 
system(echo_command)

cp_command <- paste("cp input ", data_inf)
system(cp_command)

import_command <- paste("/opt/chipster/tools_local/miniconda3/bin/python /opt/chipster/tools_local/finchem/finscreen_import.py -c /opt/chipster/tools_local/finchem/mysql_write.conf -i ", data_inf, " -n '", person, "' -l '", dep, "' -y '", univ, "' >> import.log", sep="")
system(import_command)
system("echo  >> import.log; echo Updating unichem links >> import.log")
system('/opt/chipster/tools_local/miniconda3/bin/python /opt/chipster/tools_local/finscreen/unichem_data2.py --host 192.168.1.7 >> import.log')
system("echo  >> import.log; echo Updating molecular data >> import.log")
system('/opt/chipster/tools_local/miniconda3/bin/python /opt/chipster/tools_local/finscreen/add_mol_data.py --host 192.168.1.7 >> import.log')

#Store the original input to object storage

obs_check_command <- paste("s3cmd ls s3://ddcb-database/data/uploaded_files/", data_inf, " |wc -l", sep="")
num_files <- as.integer(system(obs_check_command, intern = TRUE ))


system("cp input ./input_local")

if ( num_files > 0 ){
  count <- num_files + 1
  obs_upload <- paste("s3cmd put input_local s3://ddcb-database/data/uploaded_files/", data_inf, ".", count," 2>&1 >> import.log", sep="")   
}else{
  obs_upload <- paste("s3cmd put input_local s3://ddcb-database/data/uploaded_files/", data_inf, " 2>&1 >> import.log", sep="")
}
#echo_command <- paste ("echo '", obs_upload, "'>> import.log")
#system(echo_command)

system(obs_upload)

system("echo valmis >> import.log")
