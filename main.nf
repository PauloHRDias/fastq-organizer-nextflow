#!/usr/bin/env nextflow

params.input_dir = '/mnt/c/Users/Paulo/fastq-organizer-nextflow/data'
params.output_dir = '/mnt/c/Users/Paulo/fastq-organizer-nextflow/output'

process ORGANIZE_FASTQ {
    input:
    tuple val(sample), path(fastq_files)

    output:
    path "${sample}/*.fastq"

    script:
    """
    mkdir -p ${sample}
    cp -r ${fastq_files} ${sample}/
    cp -r ${sample} ${params.output_dir}/
    """
}

workflow {
    def data_dir = new File(params.input_dir)
    def fastq_files = data_dir.listFiles()
        .findAll { it.name.endsWith('.fastq') }
        .collect { file(it.toString()) }

    fastq_ch = Channel.fromList(fastq_files)
        .map { path ->
            def s = path.name.replaceAll(/_R[12]\.fastq$/, '')
            tuple(s, path)
        }
        .groupTuple()

    ORGANIZE_FASTQ(fastq_ch)
}