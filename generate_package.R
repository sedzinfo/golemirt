##########################################################################################
# DIRECTORIES
##########################################################################################
# R CMD check irtexplorer
# R CMD Rd2pdf irtexplorer
# R CMD build irtexplorer --resave-data
library(devtools)
library(roxygen2)
rm(list = ls())
graphics.off()
cat("\014")
##########################################################################################
# FUNCTIONS PACKAGE
##########################################################################################
directory <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(directory)
document()
test()
if ("irtexplorer" %in% loadedNamespaces()) unloadNamespace("irtexplorer") # an old version still loaded would make the reinstalled one look corrupt
if ("irtexplorer" %in% rownames(installed.packages())) remove.packages("irtexplorer")
install()
library(irtexplorer)

pkgdown::build_site(getwd())
system("R CMD Rd2pdf . --force --no-preview --output=irtexplorer.pdf")
if (.Platform$OS.type == "windows") shell.exec("irtexplorer.pdf") else system("evince irtexplorer.pdf")
system("R CMD build . --resave-data")

irtexplorer::run_app() # starts the app: the console stays busy until you close it
