configfile: "config.yaml"

print('Config details:')
print(config)

base_path=config['scratch_dir']

rule all:
    input:
        expand("{base_path}/outputs/report.html", base_path=base_path)

rule make_plot: 
    output: 
        a_plot= "{base_path}/outputs/a_plot.tiff"
    params:
        script_path= "base_path}/scripts"
    log: 
        log_file= "{base_path}/logs/make_plot.log"
    conda:
        config["my_r_env"]
    script: 
        "{params.script_path}/make_plot.R"

rule test_report:
    input:
        rmd_file = "{base_path}/scripts/make_report.Rmd",
        plot = "{base_path}/outputs/a_plot.tiff"
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
            input= "{input.rmd_file}", \
            output_file = "{output.html_file}", \
            params=list( \
                plot="{input.plot}", \
                log="{log.log_file}") \
            ) \
        '
        """
