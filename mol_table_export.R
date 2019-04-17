# TOOL mol_table_export.R: "Show vial data" (Print vial data as a table. By default information about all vials is reported. You can also set a filtering criteria)
# OUTPUT data.tsv
# OUTPUT OPTIONAL data.log
# PARAMETER OPTIONAL field: "Column" TYPE [vials.vial_barcode: vial_barcode, molecules.inchi_code: inchi_code, vials.external_ID: external_ID, vials.mol_weight: mol_weight, vials.purity: purity, vials.method: method, vials.vial_empty: vial_empty, vials.vial_tot: vial_tot, vials.content_mass: content_mass, vials.target_mass_min: vials.target_mass_min, vilas.target_mass_max: target_mass_max, vials.description: description, vials.insititute: insititute, vials.department: department, vials.person: person] DEFAULT vial_barcde (Query column)
# PARAMETER OPTIONAL comparison: "Filtering criteria" TYPE [equal-to: equal-to, smaller-than: smaller-than, larger-than: larger-than, not-equal-to: not-equal-to, none: none] DEFAULT none (Query condotion)
# PARAMETER OPTIONAL q_value: "Query value" TYPE STRING (Query value)  
# PARAMETER OPTIONAL inchi_code: "InChI code" TYPE [yes: yes, no: no] DEFAULT yes (InChI code)
# PARAMETER OPTIONAL inchikey_code: "InChI key code" TYPE [yes: yes, no: no] DEFAULT yes (InChI code)
# PARAMETER OPTIONAL external_ID: "External ID" TYPE [yes: yes, no: no] DEFAULT yes (External ID)
# PARAMETER OPTIONAL mol_weight: "Molecular weight" TYPE [yes: yes, no: no] DEFAULT yes (Molecular weight)
# PARAMETER OPTIONAL purity: "Purity" TYPE [yes: yes, no: no] DEFAULT yes (Purity of the sample)  
# PARAMETER OPTIONAL method: "Method" TYPE [yes: yes, no: no] DEFAULT yes (Method for determing chemistry)
# PARAMETER OPTIONAL vial_empty: "Empty vial mass" TYPE [yes: yes, no: no] DEFAULT yes (Empty vial mass)
# PARAMETER OPTIONAL vial_tot: "Total mass of  vial" TYPE [yes: yes, no: no] DEFAULT yes (Total mass of vial)
# PARAMETER OPTIONAL content_mass: "Content mass" TYPE [yes: yes, no: no] DEFAULT yes (Content mass)
# PARAMETER OPTIONAL target_mass_min: "Minimum target mass" TYPE [yes: yes, no: no] DEFAULT yes (Minimum target mass)
# PARAMETER OPTIONAL target_mass_max: "Maximum target mass" TYPE [yes: yes, no: no] DEFAULT yes (Minimum target mass) 
# PARAMETER OPTIONAL description: "Description" TYPE [yes: yes, no: no] DEFAULT yes (description)                
# PARAMETER OPTIONAL univ: "Institute" TYPE [yes: yes, no: no] DEFAULT yes (Home institute of the imported data)
# PARAMETER OPTIONAL dep: "Department" TYPE [yes: yes, no: no] DEFAULT yes (Home department of the imported data)
# PARAMETER OPTIONAL person: "Contact person" TYPE [yes: yes, no: no] DEFAULT yes (Contact person for the imported data)

columns <- ("vials.vial_barcode")

if ( inchi_code == "yes" ){
   columns <- paste(columns, ", molecules.inchi_code")
}

if ( inchikey_code == "yes" ){
   columns <- paste(columns, ", molecules.inchikey_code")
}

if ( external_ID == "yes" ){
   columns <- paste(columns, ", vials.external_ID")
}

if (mol_weight == "yes" ) {
   columns <- paste(columns, ", vials.mol_weight")
}

if (purity == "yes" ) {
   columns <- paste(columns, ", vials.purity")
}

if (method == "yes" ) {
   columns <- paste(columns, ", vials.method")
}

if (vial_empty == "yes" ) {
   columns <- paste(columns, ", vials.vial_empty")
}

if (vial_tot == "yes" ) {
   columns <- paste(columns, ", vials.vial_tot")
}

if (content_mass == "yes" ) {
   columns <- paste(columns, ", vials.content_mass")
}

if (target_mass_min == "yes" ) {
   columns <- paste(columns, ", vials.target_mass_min")
}


if (target_mass_max == "yes" ) {
   columns <- paste(columns, ", vials.target_mass_min")
}

if (description == "yes" ) {
   columns <- paste(columns, ", vials.description")
}

if (univ == "yes" ) {
   columns <- paste(columns, ", vials.institute")
}

if (dep == "yes" ) {
   columns <- paste(columns, ", vials.department")
}

if (person == "yes" ) {
   columns <- paste(columns, ", vials.person")
}

if (comparison == "equal-to"){
   cm <- ("=")
}


if (comparison == "smaller-than"){
   cm <- ("<")
} 

if (comparison == "larger-than"){
   cm <- (">")
}

if (comparison == "not-equal-to"){
  cm <- ("!=")
}

mysql_command <- paste('mysql --defaults-file=/opt/chipster/tools_local/finchem/mysql_read.conf  -e "SELECT ', columns , 'FROM vials, molecules WHERE vials.comp_num=molecules.comp_num" > data.tsv')

if (comparison != "none") {
   if (field == "vials.mol_weight" || field == "vials.purity" || field == "vials.vial_empty" || field == "vials.vial_tot" || field == "vials.content_mass" || field == "vials.target_mass_min" || field == "vials.target_mass_min"){
         comparison <- paste ("AND ", field, cm , q_value)
         system("echo numerical >> data.log")
   }else{
         comparison <- paste ("AND ", field," ", cm," '", q_value,"' ", sep="") 
            system("echo string >> data.log")
   }
   sql_statement <- paste('SELECT ', columns , 'FROM vials, molecules WHERE vials.comp_num=molecules.comp_num', comparison )
   echo_command <-paste("echo '", sql_statement,"'  >> data.log")
   system(echo_command)

   mysql_command <- paste('mysql -u dbuser -pdbpass --host=192.168.1.7 finscreen -e "', sql_statement ,'" > data.tsv 2>> data.log')
}

#echo_command <- paste('echo  "SELECT ', columns , 'FROM vials, molecules WHERE vials.comp_num=molecules.comp_num" >> data.log')
#system(echo_command) 
system(mysql_command)
#system('mysql -u dbuser -pdbpass --host=192.168.1.7 finscreen -e "SELECT * FROM vials, molecules WHERE vials.comp_num=molecules.comp_num" > data.tsv')
