.PHONY: help

logo:
	@echo "\033[31;3m Postchi: in-browser interpreter of Mr. Hashemi Language \033[0m";


help: logo ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%16s\033[0m : %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help



HASHEM_VER=0.04

HASHEM_VER_2=0.02
HASHEM_VER_3=0.03

struct:
	@mkdir -p ./bin


env:
#	@[`which python3.7`] && echo "python3.7 exists" || sudo apt-get install python3.7 -y 
#	@[`which virtualenv`] && echo "virtualenv exists" || sudo apt-get install python3-virtualenv -y
#	@python -m virtualenv -p python3.7 venv
	@bash ./bin/packages-download

run:
	@bash ./bin/run


update:  ## update 
	@[ -e ./bin/hashem-${HASHEM_VER} ] || wget "https://github.com/mr-hashemi/mr-hashemi/releases/download/${HASHEM_VER}/hashem" -q
	@[ -e ./hashem ] && chmod +x hashem
	@[ -e ./hashem ] && mv hashem ./bin/hashem-${HASHEM_VER}


updatev2:  ## get version 0.02
	echo "\033[32;3m downloading version 0.02 \033[0m";
	@[ -e ./bin/hashem-${HASHEM_VER_2} ] || wget "https://github.com/mr-hashemi/mr-hashemi/releases/download/${HASHEM_VER_2}/hashem" -q
	@[ -e ./hashem ] && chmod +x hashem
	@[ -e ./hashem ] && mv hashem ./bin/hashem-${HASHEM_VER_2}


updatev3:  ## get version 0.03
	@echo "\033[32;3m downloading version 0.03 \033[0m";
	@[ -e ./bin/hashem-${HASHEM_VER_3} ] || wget "https://github.com/mr-hashemi/mr-hashemi/releases/download/${HASHEM_VER_3}/hashem" -q
	@[ -e ./hashem ] && chmod +x hashem
	@[ -e ./hashem ] && mv hashem ./bin/hashem-${HASHEM_VER_3}

all: logo struct update  updatev2 updatev3 ## get latest version of hashemlang  
