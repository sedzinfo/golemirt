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
if ("golemirt" %in% loadedNamespaces()) unloadNamespace("golemirt")
if ("golemirt" %in% rownames(installed.packages())) remove.packages("golemirt")
document()
test()
install()
library(golemirt)

pkgdown::build_site(getwd(), lazy = TRUE)
system("R CMD Rd2pdf . --force --no-preview --output=golemirt.pdf")
if (.Platform$OS.type == "windows") shell.exec("golemirt.pdf") else system("evince golemirt.pdf")
system("R CMD build . --resave-data")

golemirt::run_app()
