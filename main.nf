#!/usr/bin/env nextflow

params.input_dir = '/mnt/c/Users/Paulo/fastq-organizer-nextflow/data'
params.output_dir = '/mnt/c/Users/Paulo/fastq-organizer-nextflow/output'

process ORGANIZE_FASTQ {
    input:
    tuple val(sample), path(fastq_files)

    output:
    path "${sample}/*.fastq", optional: true

    script:
    """
    mkdir -p ${params.output_dir}/${sample}
    cp -L ${fastq_files} ${params.output_dir}/${sample}/
    """
}

process PLOT_SUMMARY {
    input:
    path output_dir

    output:
    path "summary.png", optional: true

    script:
    """
    cp ${projectDir}/bin/plot_summary.R .
    chmod +x plot_summary.R
    ./plot_summary.R ${params.output_dir}
    cp summary.png ${params.output_dir}/
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

    PLOT_SUMMARY(file(params.output_dir))
}