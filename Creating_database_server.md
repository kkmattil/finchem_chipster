# Requirements to set up and use DDCB compund database

##1. Database server  (Ubuntu 18 + MySQL)

(Incomplete) set of installation commands:
```text
sudo apt-get update
sudo apt-get install mysql-server mysql-client
mysqladmin -u root password xxxxxx
mysql -u root -p
sudo mysql_secure_installation
mysql -u root -p -e "GRANT ALL ON *.* TO 'dbuser'@'localhost' IDENTIFIED BY 'dbpass'"
sudo mysqld –init-file=/home/ubuntu/mypwreset
```


MySQL Table creation commands
```text
CREATE TABLE IF NOT EXISTS molecules (    
comp_num INT AUTO_INCREMENT,
inchi_code VARCHAR(4000),
inchikey_code VARCHAR(27),
smiles VARCHAR(4000),
date DATE,     
PRIMARY KEY (comp_num)
)  ENGINE=INNODB;
```
```text
CREATE TABLE IF NOT EXISTS molecule_data(
comp_num INT,
formula VARCHAR(100),
mol_weight_ob DECIMAL(6,3),
filename VARCHAR(500),
chembl_ BIGINT(20),
data BLOB,
date DATE,
PRIMARY KEY (comp_num)
)  ENGINE=INNODB;
```
```text
CREATE TABLE IF NOT EXISTS vials (    
vial_num INT AUTO_INCREMENT,
vial_barcode INT,
comp_num INT,
external_ID VARCHAR(50),
mol_weight DECIMAL(6,3),  
purity TINYINT,
method VARCHAR(100),
vial_empty DECIMAL(8,5),
vial_tot DECIMAL(8,5),
content_mass DECIMAL(8,5),
target_mass_min DECIMAL(4,2),
target_mass_max DECIMAL(4,2),
description VARCHAR(1000),
date DATE,  
PRIMARY KEY (vial_num)
)  ENGINE=INNODB;
```
```text
CREATE TABLE IF NOT EXISTS vial_data(
vialdata_num INT AUTO_INCREMENT,
vial_num INT,
method VARCHAR(50),
filename VARCHAR(500),
data BLOB,
date DATE,
PRIMARY KEY (vialdata_num)
)  ENGINE=INNODB;
```


## 2.  Tools for data import

Dependencies:
#### miniconda3
```text
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64
bash Miniconda3-latest-Linux-x86_64.sh 
export PATH=/opt/chipster/tools/miniconda3/bin:${PATH}
## or: eval "$(/opt/chipster/tools/miniconda3/bin/conda shell.bash hook)"
```
 
### mariadb/mysql
```text
sudo apt-get install mysql-client
pip install mysql.connector
``` 
### spyder

### OpenBabel 

In ubuntu:
```text
sudo apt install libopenbabel-dev
export PATH=/opt/chipster/tools_local/miniconda3/bin:${PATH}
conda install -c openbabel openbabel
sudo apt install openbabel
sudo apt install python-openbabel
```
### RDkit
```text
conda install -c conda-forge rdkit
```
###Biocervices:
```text
./miniconda3/bin/pip install bioservices
```

## Discovery Studio installation to a Chipster server (based on Ubuntu):

```text
mkdir BIOVIA
cd BIOVIA
wget https://dstudio19.csc.fi:9943/scitegic/dsclient/linux/DS2019Client.bin
bash DS2019Client.bin --keep
cd client/
sed s/"echoe"/"echo -e"/g install_DSClient.sh > install_DSClient_e.sh
bash install_DSClient_e.sh
cd lp_installer/
bash lp_setup_linux.sh --keep
cd lpbuild/
sed s/"echoe"/"echo -e"/g install_lp.sh > install_lp_e.sh
cd .. /BIOVIA_LicensePack/Licenses/
echo "1752@license1.csc.fi" > msi_server.fil
```
Following settings are needed to fix issues with perl:

```text
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/chipster/tools_local/BIOVIA/DiscoveryStudio2019/lib
export PERL5LIB=/opt/chipster/tools_local/BIOVIA/DiscoveryStudio2019/lib/5.26.1:/opt/chipster/tools_local/BIOVIA/DiscoveryStudio2019/lib/site_perl:/opt/chipster/tools_local/BIOVIA/DiscoveryStudio2019/lib/site_perl/5.26.1:/opt/chipster/tools_local/BIOVIA/DiscoveryStudio2019/lib

wget https://dstudio18.csc.fi:9943/scitegic/dsclient/linux/DS2018Client.bin
```

Reload chipster tools:
```text
kubectl exec deployment/toolbox -it touch /opt/chipster/toolbox/.reload/touch-me-to-reload-tools
```

### Wheasyprint:
```text
pip install WeasyPrint
```

Wheasyprint needs a wrapper server
```text
#!/bin/bash
source /opt/chipster/venv/bin/activate
/opt/chipster/venv/bin/wheasyprint $1 $2
```
