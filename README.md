# ffpefilter version 0.0.1 #
Use MicroSec for FFPE filtering. ffpefilter pipeline is a pipelined designed to do variant filtering for FFPE samples by using microsec tool. It uses the docker image scao/microsec:0.0.1 for efficiently launching jobs on compute1 cluster (LSF job system)


## Install ##

The only thing you need to do is to do "git pull https://github.com/ding-lab/ffpefiltering.git" 

## Usage ##

perl ffpefilter.pl  --rdir --log --groupname --users --step 

<rdir> = full path of the folder holding files for this run (user must provide)

<log> = full path of the folder for saving log file; usually upper folder of rdir

<groupname> = job group name

<users> = user name for job group

<step> run this pipeline step by step. (user must provide)

## Contact ##

Yingduo Song and Song Cao
