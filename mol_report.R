# TOOL mol_report.R: "Molecule report" (Extarct data about given molecule.)
# OUTPUT OPTIONAL report.html
# OUTPUT OPTIONAL report.log
# OUTPUT OPTIONAL report.pdf 
# PARAMETER inchikey: "InChI-key" TYPE STRING (InChI-key of the molecule)
# PARAMETER OPTIONAL save_log: "Collect a log file" TYPE [yes: Yes, no: No] DEFAULT no (Collect a log file about the Mimimap2 mapping process.)



mol_report_bin <- ('/opt/chipster/tools_local/miniconda3/bin/python /opt/chipster/tools_local/finchem/mol_report.py --mysqlconf /opt/chipster/tools_local/finchem/mysql_read.conf -k')
mol_command <- paste(mol_report_bin, inchikey, " >> report.log")
system(mol_command)


system("weasyprint report.html report.pdf")
system(mol_command)

system("ls -l >> report.log")

if ( save_log == "no") {
	system ("rm -f report.log")
}
