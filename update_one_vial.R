# TOOL update_one_vial.R: "Update vial information" (Update vial information. You can add new vial or modify existing one. Existing values will be overwritten. Values that have been left blanc are not changed in the database. )
# OUTPUT update.log
# PARAMETER vial_barcode: "Barcode of the vial" TYPE STRING (Barcode of the vial)
# PARAMETER OPTIONAL inchi_code: "InChI code" TYPE STRING (InChI code)
# PARAMETER OPTIONAL external_ID: "External ID" TYPE STRING (External ID)
# PARAMETER OPTIONAL mol_weight: "Molecular weight" TYPE DECIMAL (Molecular weight)
# PARAMETER OPTIONAL purity: "Purity" TYPE DECIMAL (Purity of the sample)  
# PARAMETER OPTIONAL method: "Method" TYPE STRING (Method for determing chemistry)
# PARAMETER OPTIONAL vial_empty: "Empty vial mass" TYPE DECIMAL (Empty vial mass)
# PARAMETER OPTIONAL vial_tot: "Total mass of vial" TYPE DECIMAL (Total mass of vial)
# PARAMETER OPTIONAL content_mass: "Content mass" TYPE DECIMAL (Content mass)
# PARAMETER OPTIONAL target_mass_min: "Minimum target mass" TYPE DECIMAL (Minimum target mass)
# PARAMETER OPTIONAL target_mass_max: "Maximum target mass" TYPE DECIMAL (Minimum target mass) 
# PARAMETER OPTIONAL description: "Description" TYPE STRING (description)                
# PARAMETER OPTIONAL univ: "Institute" TYPE STRING (Home institute of the imported data)
# PARAMETER OPTIONAL dep: "Department" TYPE STRING (Home department of the imported data)
# PARAMETER OPTIONAL person: "Contact person" TYPE STRING (Contact person for the imported data)


update_command_start <- ("/opt/chipster/tools_local/miniconda3/bin/python /opt/chipster/tools_local/finchem/update_one_vial.py -c /opt/chipster/tools_local/finchem/mysql_write.conf")

if( inchi_code != "") {
   update_command <- paste(update_command_start, " -f inchi_key -v '", inchi_key ,"' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}


if( external_ID != "") {
   update_command <- paste(update_command_start, " -f external_ID -v '", external_ID , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if ( is.numeric(mol_weight) ) {
   update_command <- paste(update_command_start, " -f mol_weight -v '", mol_weight , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( is.numeric(purity)) {
   update_command <- paste(update_command_start, " -f purity -v '", purity , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( method != "") {
   update_command <- paste(update_command_start, " -f method -v '", method , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}


if( is.numeric(vial_empty)) {
   update_command <- paste(update_command_start, " -f vial_empty -v '", vial_empty , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( is.numeric(vial_tot)) {
   update_command <- paste(update_command_start, " -f vial_tot -v '", vial_tot , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( is.numeric(content_mass)) {
   update_command <- paste(update_command_start, " -f content_mass -v '", content_mass , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( is.numeric(target_mass_min)) {
   update_command <- paste(update_command_start, " -f target_mass_min -v '", target_mass_min, "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( is.numeric(target_mass_max)) {
   update_command <- paste(update_command_start, " -f target_mass_max -v '", target_mass_max , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( description != "") {
   update_command <- paste(update_command_start, " -f description -v '", description , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( univ != "") {
   update_command <- paste(update_command_start, " -f institute -v '", univ , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( dep != "") {
   update_command <- paste(update_command_start, " -f department -v '", dep , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

if( person != "") {
   update_command <- paste(update_command_start, " -f person -v '", person , "' -b ", vial_barcode, " >> update.log", sep="")
   system(update_command)
}

