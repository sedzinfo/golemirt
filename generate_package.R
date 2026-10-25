##########################################################################################
# DIRECTORIES
##########################################################################################
# R CMD check golemirt
# R CMD Rd2pdf golemirt
# R CMD build golemirt --resave-data
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
if ("golemirt" %in% loadedNamespaces()) unloadNamespace("golemirt") # an old version still loaded would make the reinstalled one look corrupt
if ("golemirt" %in% rownames(installed.packages())) remove.packages("golemirt")
install()
library(golemirt)

pkgdown::build_site(getwd())
system("R CMD Rd2pdf . --force --no-preview --output=golemirt.pdf")
if (.Platform$OS.type == "windows") shell.exec("golemirt.pdf") else system("evince golemirt.pdf")
system("R CMD build . --resave-data")

golemirt::run_app() # starts the app: the console stays busy until you close it
