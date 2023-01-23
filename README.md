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


The rdir contains all sample names that need the ffpe filtering. It should contain a maf file and a tumor bam file and associated index file named as:

samplename.formated.maf
samplename.T.bam

The maf file should contain the following column:

Hugo_Symbol     Chromosome      Start_Position  End_Position    Strand  Variant_Classification  Variant_Type    Reference_Allele        Tumor_Seq_Allele1       Tumor_Seq_Allele2       Tumor_Sample_Barcode

SAMD11  chr1    925818  925818  +       Intron  SNP     G       G       T       ALCH-ABBG-TTP1-A

## Contact ##

Yingduo Song and Song Cao
