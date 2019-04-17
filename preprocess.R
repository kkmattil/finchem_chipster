# TOOL preprocess.R: "Check the cvs file" (Produces a table showing what data the import tool will import to the database.)
# INPUT input: "Input dataform" TYPE GENERIC
# OUTPUT prepared.tsv
# OUTPUT prepared.log
# PARAMETER OPTIONAL sep: "Column separator in input file" TYPE [tab: "tabulator", space: "space or tabulator", semic: "semicolon (\;\)", doubp: "colon (\:\)", comma: "comma (\,\)", pipe: "pipe (\|\)"] DEFAULT semic (Select the column separator used to parse the input data. By default, Chipster uses tabulator.)  


system('echo "tehdään otsikko" > prepared.log')
system('echo "Vial_Barcode;External_ID;InChI_Code;Molecular_Weight;Purity;Method;Description;Vial_empty;Vial_total;Mass;Target_mass_min;Target_mass_max;n;V;" |  tr ";" "\t" > prepared.tsv ')


if ( sep == "tab"){
   system("grep 'InChI=' input >> prepared.tsv")
}
if ( sep == "space"){
   system('grep "InChI=" input | tr " " "\t"  >> prepared.tsv')
}
if ( sep == "semic"){
   system('grep "InChI=" input | tr ";" "\t"  >> prepared.tsv')
}
if ( sep == "doubp"){
   system('grep "InChI=" input | tr ":" "\t"  >> prepared.tsv')
}
if ( sep == "comma"){
   system('grep "InChI=" input | tr "," "\t"  >> prepared.tsv')
}
if ( sep == "pipe"){
  system('grep "InChI=" input | tr "," "\t"  >> prepared.tsv')
}

system("ls -l >> prepared.log")
