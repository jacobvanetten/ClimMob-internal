# ClimMob internal code
# Jacob van Etten
# May 2018

# Input parameters
data_route <- "data"
work_route <- "/processing"
out_route <- "/out"
json_filename <- "climmobv4_result.json"
lang <- "EN"

# Load packages
library(jsonlite)
library(PlackettLuce)
library(plyr)
setwd("C:/Users/Jacob Van Etten/Documents/ClimMob-internal")

#Load data
d <- fromJSON(paste(data_route, json_filename, sep="/"))

#Peel data from JSON
for(i in seq_along(d$specialfields)) assign(paste("specialfields", names(d$specialfields)[[i]], sep="_"), d$specialfields[[i]])
for(i in seq_along(d$project)) assign(names(d$project)[[i]], d$project[[i]])
for(i in seq_along(d$registry)) assign(paste("registry", names(d$registry)[[i]], sep="_"), d$registry[[i]])
for(i in seq_along(d$importantfields)) assign(paste("importantfields", names(d$importantfields)[[i]], sep="_"), d$importantfields[[i]])
for(i in seq_along(d$assessments)) assign(paste("assessments", names(d$assessments)[[i]], sep="_"), d$assessments[[i]])
for(i in seq_along(d$packages)) assign(paste("packages", names(d$packages)[[i]], sep="_"), d$packages[[i]])
dd <- d$data

#Create dataframe with data and package composition
packages_comps_list <- vector(length=length(packages_comps), mode="list")
for(i in seq_along(packages_comps)){
  
  pp <- unlist(packages_comps[[i]]$technologies)
  packages_comps_list[[i]] <- c(pp[names(pp) == "tech_name"], pp[names(pp) == "alias_name"])
  
}

packages_comps_df <- data.frame(do.call(rbind, packages_comps_list))
packages_df <- data.frame(packages_package_id, packages_farmername, packages_comps_df)
colnames(packages_df)[colnames(packages_df) == "tech_name"] <- "techname.0"
colnames(packages_df)[colnames(packages_df) == "alias_name"] <- "aliasname.0"
# Sum 1 to make them nice...

#Create dataframe with evaluation data


dd[,grep("_perf", colnames(dd))]
