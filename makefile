.PHONY: help

logo:
	@echo "\033[31;3m Postchi: in-browser interpreter of Mr. Hashemi Language \033[0m";


help: logo ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%16s\033[0m : %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help


HASHEM_VER=0.04

update:  ## update 
	@mkdir -p ./bin
	@[ -e ./bin/hashem-${HASHEM_VER} ] || wget "https://github.com/mr-hashemi/mr-hashemi/releases/download/${HASHEM_VER}/hashem" -q
	@chmod +x hashem
	@mv hashem ./bin/hashem-${HASHEM_VER}


all: logo update ## get latest version of hashemlang  
