configfile: "config.yaml"

print('Config details:')
print(config)

base_path=config['scratch_dir']

rule all:
    input:
        expand("{base_path}/outputs/report.html", base_path=base_path)

rule test_report:
    input:
        test_rmd = "{base_path}/scripts/test_rmd.Rmd",
        raw_reads = "{base_path}/outputs/raw_reads.tiff"
    output:
        html_file = "{base_path}/outputs/report.html"
    log:
        log_file = "{base_path}/logs/make_report.log"
    conda: 
        config["my_r_env"]
    shell:
        """
        Rscript -e \
        'rmarkdown::render( \
            input= "{input.test_rmd}", \
            output_file = "{output.html_file}", \
            params=list( \
                plot="{input.raw_reads}", \
                log="{log.log_file}") \
            ) \
        '
        """