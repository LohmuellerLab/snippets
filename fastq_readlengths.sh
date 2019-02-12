zcat file.fastq.gz | awk '{if(NR%4==2) print length($1)}' > readLengths.txt
