# Main build rule
all: gen/output/plot_Antwerp.pdf gen/output/plot_all.pdf

# Sub-builds
gen/output/plot_all.pdf: src/analysis/plot_all.R gen/temp/aggregated_df.csv
	Rscript -e "dir.create('gen/output', recursive = TRUE)"
	R --vanilla < src/analysis/plot_all.R

gen/output/plot_Antwerp.pdf: src/analysis/plot_Antwerp.R gen/temp/pivot_table.csv
	Rscript -e "dir.create('gen/output', recursive = TRUE)"
	R --vanilla < src/analysis/plot_Antwerp.R

gen/temp/pivot_table.csv: src/analysis/pivot_table.R gen/temp/aggregated_df.csv
	Rscript -e "dir.create('gen/temp', recursive = TRUE)"
	R --vanilla < src/analysis/pivot_table.R

gen/temp/aggregated_df.csv: data/reviews.csv data/listings.csv src/data-preparation/clean.R
	Rscript -e "dir.create('gen/temp', recursive = TRUE)"
	R --vanilla < src/data-preparation/clean.R

data/listings.csv data/reviews.csv: src/data-preparation/download.R
	Rscript -e "dir.create('data', recursive = TRUE)"
	R --vanilla < src/data-preparation/download.R

clean:
	R -e "unlink('data', recursive = TRUE)"
	R -e "unlink('gen', recursive = TRUE)"
