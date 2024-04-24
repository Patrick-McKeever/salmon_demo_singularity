cd downloadUrl
if [ ! -f downloadURL.sif ]; then
	sudo singularity build downloadURL.sif downloadURL.def
fi

singularity exec -i --cleanenv -B ..:/data downloadURL.sif ./download.sh --decompress --directory /data/salmon_demo_work ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR016/DRR016125/DRR016125_1.fastq.gz
singularity exec -i --cleanenv -B ..:/data downloadURL.sif ./download.sh --decompress --directory /data/salmon_demo_work ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR016/DRR016125/DRR016125_2.fastq.gz
singularity exec -i --cleanenv -B ..:/data downloadURL.sif ./download.sh --directory /data/salmon_demo_work ftp://ftp.ensemblgenomes.org/pub/plants/release-28/fasta/arabidopsis_thaliana/cdna/Arabidopsis_thaliana.TAIR10.28.cdna.all.fa.gz 

cd ..

# Use this if you get issues downloading debian image from docker file
# sudo rm -rf ~/.singularity/cache
if [ ! -f salmon/salmon.sif ]; then
	sudo singularity build salmon/salmon.sif salmon/salmon.def
fi

singularity exec -i --cleanenv -B .:/data salmon/salmon.sif /usr/local/salmon/bin/salmon index  -i /data/salmon_demo_work/athal_index -t /data/salmon_demo_work/Arabidopsis_thaliana.TAIR10.28.cdna.all.fa.gz -p 4
singularity exec -i --cleanenv -B .:/data salmon/salmon.sif /usr/local/salmon/bin/salmon quant  -i /data/salmon_demo_work/athal_index --libType A --mates1 /data/salmon_demo_work/DRR016125_1.fastq  --mates2 /data/salmon_demo_work/DRR016125_2.fastq  -o /data/salmon_demo_work/DRR016125_quant -p 4


