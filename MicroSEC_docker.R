#!/bin/Rscript

# load necessary packages
library(MicroSEC)

# set arguments
args <- commandArgs(trailingOnly = T)
output <- args[1]
sample_name <- args[2]
mutation_file <- args[3]
bam_file <- args[4]
read_list <- args[5]
read_length <- as.integer(args[6])
adapter_1 <- args[7]
adapter_2 <- args[8]
organism <- args[9]
wd <- args[10]
progress_bar <- "N"
list_exist <- FALSE
setwd(wd)
fun_load_genome(organism) # ref_genome
fun_load_chr_no(organism) # chr_no
fun_load_mutation(mutation_file, sample_name) # df_mutation

# get the bam
bam_file_tmp1 <- paste(bam_file, ".tmp1", sep = "")
bam_file_tmp2 <- paste(bam_file, ".tmp2", sep = "")
bam_file_slim <- paste(bam_file, ".SLIM", sep = "")
if (!file.exists(bam_file_slim)) {
  for (mut_no in seq_len(dim(df_mutation)[1])) {
    print(paste(mut_no, "/", dim(df_mutation)[1]))
    if (mut_no == 1 & mut_no != dim(df_mutation)[1]) {
      if (df_mutation$Chr[mut_no + 1] != df_mutation$Chr[mut_no] |
        df_mutation$Pos[mut_no + 1] > df_mutation$Pos[mut_no] + 400) {
        syscom <- paste("samtools view -h ",
          bam_file,
          " ",
          df_mutation$Chromosome[mut_no],
          ":",
          max(1, df_mutation$Pos[mut_no] - 200),
          "-",
          df_mutation$Pos[mut_no] + 200,
          " > ",
          bam_file_slim,
          sep = ""
        )
        system(syscom)
        continuous <- FALSE
        sep_new <- FALSE
      } else {
        continuous <- TRUE
        pos_last <- max(1, df_mutation$Pos[mut_no] - 200)
      }
    } else if (mut_no == 1 & mut_no == dim(df_mutation)[1]) {
      syscom <- paste("samtools view -h ",
        bam_file,
        " ",
        df_mutation$Chromosome[mut_no],
        ":",
        max(1, df_mutation$Pos[mut_no] - 200),
        "-",
        df_mutation$Pos[mut_no] + 200,
        " > ",
        bam_file_slim,
        sep = ""
      )
      system(syscom)
    } else if (mut_no == dim(df_mutation)[1]) {
      if (sep_new) {
        syscom <- paste("samtools view -h ",
          bam_file,
          " ",
          df_mutation$Chromosome[mut_no],
          ":",
          pos_last,
          "-",
          df_mutation$Pos[mut_no] + 200,
          " > ",
          bam_file_slim,
          sep = ""
        )
        system(syscom)
      } else if (continuous) {
        syscom <- paste("samtools view -h ",
          bam_file,
          " ",
          df_mutation$Chromosome[mut_no],
          ":",
          pos_last,
          "-",
          df_mutation$Pos[mut_no] + 200,
          " > ",
          bam_file_tmp1,
          sep = ""
        )
        system(syscom)
        syscom <- paste("samtools merge -fucp ",
          bam_file_tmp2,
          " ",
          bam_file_slim,
          " ",
          bam_file_tmp1,
          sep = ""
        )
        system(syscom)
        syscom <- paste("mv ",
          bam_file_tmp2,
          " ",
          bam_file_slim,
          sep = ""
        )
        system(syscom)
      } else {
        syscom <- paste("samtools view -h ",
          bam_file,
          " ",
          df_mutation$Chromosome[mut_no],
          ":",
          max(1, df_mutation$Pos[mut_no] - 200),
          "-",
          df_mutation$Pos[mut_no] + 200,
          " > ",
          bam_file_tmp1,
          sep = ""
        )
        system(syscom)
        syscom <- paste("samtools merge -fucp ",
          bam_file_tmp2,
          " ",
          bam_file_slim,
          " ",
          bam_file_tmp1,
          sep = ""
        )
        system(syscom)
        syscom <- paste("mv ",
          bam_file_tmp2,
          " ",
          bam_file_slim,
          sep = ""
        )
        system(syscom)
      }
    } else {
      if (sep_new) {
        if (df_mutation$Chr[mut_no + 1] != df_mutation$Chr[mut_no] |
          df_mutation$Pos[mut_no + 1] > df_mutation$Pos[mut_no] + 400) {
          syscom <- paste("samtools view -h ",
            bam_file,
            " ",
            df_mutation$Chromosome[mut_no],
            ":",
            pos_last,
            "-",
            df_mutation$Pos[mut_no] + 200,
            " > ",
            bam_file_slim,
            sep = ""
          )
          system(syscom)
          continuous <- FALSE
          sep_new <- FALSE
        }
      } else if (continuous) {
        if (df_mutation$Chr[mut_no + 1] != df_mutation$Chr[mut_no] |
          df_mutation$Pos[mut_no + 1] > df_mutation$Pos[mut_no] + 400) {
          syscom <- paste("samtools view -h ",
            bam_file,
            " ",
            df_mutation$Chromosome[mut_no],
            ":",
            pos_last,
            "-",
            df_mutation$Pos[mut_no] + 200,
            " > ",
            bam_file_tmp1,
            sep = ""
          )
          system(syscom)
          syscom <- paste("samtools merge -fucp ",
            bam_file_tmp2,
            " ",
            bam_file_slim,
            " ",
            bam_file_tmp1,
            sep = ""
          )
          system(syscom)
          syscom <- paste("mv ",
            bam_file_tmp2,
            " ",
            bam_file_slim,
            sep = ""
          )
          system(syscom)
          continuous <- FALSE
        }
      } else {
        if (df_mutation$Chr[mut_no + 1] != df_mutation$Chr[mut_no] |
          df_mutation$Pos[mut_no + 1] > df_mutation$Pos[mut_no] + 400) {
          syscom <- paste("samtools view -h ",
            bam_file,
            " ",
            df_mutation$Chromosome[mut_no],
            ":",
            max(1, df_mutation$Pos[mut_no] - 200),
            "-",
            df_mutation$Pos[mut_no] + 200,
            " > ",
            bam_file_tmp1,
            sep = ""
          )
          system(syscom)
          syscom <- paste("samtools merge -fucp ",
            bam_file_tmp2,
            " ",
            bam_file_slim,
            " ",
            bam_file_tmp1,
            sep = ""
          )
          system(syscom)
          syscom <- paste("mv ",
            bam_file_tmp2,
            " ",
            bam_file_slim,
            sep = ""
          )
          system(syscom)
        } else {
          continuous <- TRUE
          pos_last <- max(1, df_mutation$Pos[mut_no] - 200)
        }
      }
    }
  }

  ## generate bam files
  syscom <- paste("samtools view -bS ",
    bam_file_slim,
    " > ",
    bam_file_tmp2,
    sep = ""
  )
  system(syscom)

  syscom <- paste("samtools sort -@ 4 -o ",
    bam_file_slim,
    " ",
    bam_file_tmp2,
    sep = ""
  )
  system(syscom)

  syscom <- paste("rm ",
    bam_file_tmp1,
    sep = ""
  )
  system(syscom)

  syscom <- paste("rm ",
    bam_file_tmp2,
    sep = ""
  )
  system(syscom)

  syscom <- paste("samtools index ",
    bam_file_slim,
    sep = ""
  )
  system(syscom)

  print(paste("Slimmed BAM files were saved as ", bam_file_slim, sep = ""))
}

# load genomic sequence
bam_file <- bam_file_slim
fun_load_bam(bam_file) # df_bam

result <- fun_read_check(short_homology_search_length = 4)
msec <- result[[1]]
homology_search <- result[[2]]
mut_depth <- result[[3]]
msec <- fun_homology(msec,
  homology_search,
  min_homology_search = 40
)

# statistical analysis
msec <- fun_summary(msec)
msec <- fun_analysis(msec,
  mut_depth,
  short_homology_search_length = 4,
  min_homology_search = 40,
  threshold_p = 10^(-6),
  threshold_hairpin_ratio = 0.50,
  threshold_short_length = 0.75,
  threshold_distant_homology = 0.15,
  threshold_low_quality_rate = 0.1,
  homopolymer_length = 15
)
# save the results
fun_save(msec, output, ".")

# check the output
# detect <- paste0("MicroSEC-result_", output)
# doc <- list.files()[stringr::str_detect(list.files(), detect)]
# result <- openxlsx::read.xlsx(doc, sheet = 1)

# if (length(table(result$filter_4_highly_homologous_region)) == 1) {
# syscom <- paste("echo", " ", "'no artifacts found.'", " ", ">", output, "_artifacts_detect.txt", sep = "")
# system(syscom)
# } else {
# result_sub <- result[which(result$filter_4_highly_homologous_region), c("Tumor_Sample_Barcode", "Chr", "Gene", "Pos", "Mut_type", "Ref", "Alt", "total_read", "soft_clipped_read", "filter_1_mutation_intra_hairpin_loop", "filter_2_hairpin_structure", "filter_3_microhomology_induced_mutation", "filter_4_highly_homologous_region")]
# file_name <- paste(output, "_artifacts_detect.txt", sep = "")
# write.table(result_sub, file_name, sep = "\t", quote = F, row.names = F)
# }
