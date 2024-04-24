cd downloadUrl
sudo singularity build downloadUrl/downloadURL.sif downloadUrl/downloadURL.def
singularity exec -i --cleanenv -B ..:/data downloadURL.sif ./download.sh --decompress --directory /data/salmon_demo_work ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR016/DRR016125/DRR016125_1.fastq.gz
singularity exec -i --cleanenv -B ..:/data downloadURL.sif ./download.sh --decompress --directory /data/salmon_demo_work ftp://ftp.sra.ebi.ac.uk/vol1/fastq/DRR016/DRR016125/DRR016125_2.fastq.gz
singularity exec -i --cleanenv -B ..:/data downloadURL.sif ./download.sh --directory /data/salmon_demo_work ftp://ftp.ensemblgenomes.org/pub/plants/release-28/fasta/arabidopsis_thaliana/cdna/Arabidopsis_thaliana.TAIR10.28.cdna.all.fa.gz 

cd ..

# Use this if you get issues downloading debian image from docker file
# sudo rm -rf ~/.singularity/cache
sudo singularity build salmon/salmon.sif salmon/salmon.def

singularity exec -i --cleanenv -B .:/data salmon/salmon.sif /usr/local/salmon/bin/salmon index  -i /data/salmon_demo_work/athal_index -t /data/salmon_demo_work/Arabidopsis_thaliana.TAIR10.28.cdna.all.fa.gz -p 4


