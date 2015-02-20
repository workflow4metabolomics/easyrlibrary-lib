###############################################
# Mini tools for Galaxy scripting
# Coded by: M.Petera, 
# - -
# R functions to use in R scripts and wrappers
# to make things easier (lightening code, reducing verbose...)
# - -
# V0 : script structure + first functions
###############################################


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Function to call packages without printing all the verbose
# (only getting the essentials, like warning messages for example)

shyLib <- function(...){
	for(i in 1:length(list(...))){
		suppressPackageStartupMessages(library(list(...)[[i]],character.only=TRUE))
	}
}

#example: shyLib("xcms","pcaMethods")



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Fonction pour sourcer les scripts R requis
# /!\ ATTENTION : actuellement la fonction n'est pas chargee au lancement du script,
# il faut donc la copier-coller dans le wrapper R pour pouvoir l'utiliser. 

if(FALSE){
source_local <- function(...){
	argv <- commandArgs(trailingOnly = FALSE)
	base_dir <- dirname(substring(argv[grep("--file=", argv)], 8))
	for(i in 1:length(list(...))){
		source(paste(base_dir, list(...)[[i]], sep="/"))
	}
}
}

#example: source_local("filter_script.R","RcheckLibrary.R")


