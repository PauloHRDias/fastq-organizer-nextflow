# FASTQ Organizer — Nextflow Pipeline

A simple [Nextflow](https://nextflow.io/) pipeline that organizes paired-end FASTQ files by sample, automatically grouping `_R1` and `_R2` files into per-sample directories.

## 🎯 Purpose

This pipeline demonstrates:
- Writing a functional Nextflow workflow
- Handling file grouping logic in Groovy
- Running pipelines in a Linux/WSL environment
- Version control with Git

## 📁 Project structure
fastq-organizer-nextflow/
├── main.nf # Main Nextflow pipeline
├── nextflow.config # Pipeline configuration
├── bin/
│ └── organize.sh # Bash script (documentation/reference)
├── data/ # Input FASTQ files (test data)
│ ├── sample1_R1.fastq
│ ├── sample1_R2.fastq
│ ├── sample2_R1.fastq
│ └── sample2_R2.fastq
└── output/ # Generated output (per-sample folders)

text

## 🚀 How to run

### Prerequisites
- Nextflow (v24+)
- Java 17+
- Linux / macOS / WSL

### Run the pipeline

```bash
nextflow run main.nf
⚙️ How it works
The pipeline lists all .fastq files in data/.

It extracts the sample name (sample1, sample2, ...) by stripping the _R1/_R2 suffix.

It groups R1 and R2 files by sample using groupTuple().

For each sample, it creates a folder under output/ and copies the paired files inside.

📊 Expected output
text
output/
├── sample1/
│   ├── sample1_R1.fastq
│   └── sample1_R2.fastq
└── sample2/
    ├── sample2_R1.fastq
    └── sample2_R2.fastq
🛠️ Technologies used
Nextflow — workflow orchestration

Groovy — pipeline scripting

Bash — file handling

Git — version control

👤 Author
Paulo Henrique da Rocha Dias
Biological Sciences student at UFSC | Bioinformatics | Genomic Surveillance
GitHub
