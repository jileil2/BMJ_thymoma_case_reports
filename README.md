# Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis  
_A Systematic Review and Statistical Analysis (BMJ submission)_

This repository contains the analysis code and figure/table generation scripts accompanying the manuscript  
**“Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis: A Systematic Review and Statistical Analysis.”**

> **Note:** The dataset is not publicly available. Access can be requested (see **Data Access** below).  
> All code is included to ensure full reproducibility once the data are available locally.

---

## Repository Structure

```
.
├── figures/
│   ├── figure_S1/
│   │   ├── figure_S1.R        # Reproduces results for Figure S1
│   │   ├── figure_S1.tex      # Arranges sub-figures into a composite panel
│   │   └── tex/               # LaTeX files for individual sub-figures
│   ├── figure_2/
│   ├── figure_3/
│   ├── figure_4/
│   ├── figure_5/
│   ├── figure_6/
│   └── figure_7/
│
├── tables/
│   ├── data_dictionary.pdf    # Variable definitions for all datasets
│   ├── data1.csv              # Concomitant IIM and MG
│   ├── data2.csv              # ICI-Induced IIM and/or MG
│   ├── data3.csv              # Isolated IIM with TET
│   ├── data4.csv              # Thymoma spontaneous regression
│   ├── table_1/               # Analysis scripts for data1.csv
│   ├── table_2/               # Analysis scripts for data2.csv
│   ├── table_3/               # Analysis scripts for data3.csv
│   └── table_4/               # Analysis scripts for data4.csv
│
├── README.md
└── (optional) renv/ or requirements files if present
```

---

## How to Reproduce Results

> You’ll need local copies of the data files in the `tables/` directory (see **Data Access** below).  
> All scripts are intended to be run **line by line in R** to help users inspect intermediate outputs and verify reproducibility.  
> Readers can find in each script which lines of code correspond to specific results reported in the manuscript.

### 1. Figures (Figure S1, Figures 2–7)

Each folder `figures/figure_*` contains:
- an **R file** (`figure_*.R`) — performs statistical analysis and saves the outputs used for plotting;  
- a **LaTeX file** (`figure_*.tex`) — assembles multiple sub-figures into a single composite panel;  
- a **`tex/` subfolder** — contains LaTeX source files for the individual sub-figures.

**Important:**  
Before compiling `figure_*.tex`, you must **first compile all `.tex` files inside the `tex/` subfolder** to generate the sub-figures.  
Then, compile `figure_*.tex` to assemble the final composite figure.

**Typical workflow:**
```bash
# Step 1: Run the R script line by line to generate intermediate data/plots
Rscript figures/figure_2/figure_2.R

# Step 2: Compile the sub-figures first
cd figures/figure_2/tex
pdflatex -interaction=nonstopmode subfigure_1.tex
pdflatex -interaction=nonstopmode subfigure_2.tex
# ...

# Step 3: Compile the main figure panel
cd ..
pdflatex -interaction=nonstopmode figure_2.tex
# or:
latexmk -pdf figure_2.tex
```

Repeat for `figure_S1`, `figure_3`, …, `figure_7`.

---

### 2. Tables (Analyses for data1–data4)

Each `tables/table_k/` folder contains R scripts that reproduce the analyses for Table 1–4.  
The codes are intended to be run **line by line** in R. Readers can refer to each script for details on which sections generate which parts of the manuscript results.

---

### 3. Working Directory Setup

Before running any R script, make sure to set your working directory to the location where both the **data file** (e.g., `data1.csv`) and the **R script** (e.g., `data1.R`) reside.

```r
# Example for data1
setwd("/path/to/tables/table_1")
source("data1.R")
```

Alternatively, in RStudio, use:
```
Session → Set Working Directory → To Source File Location
```

---

## Software Requirements

- **R** (version ≥ 4.0)
- Common R packages used by the scripts (see `library(...)` calls at the top of each `.R` file)
- (Optional) **renv** for reproducible environments:
  ```r
  install.packages("renv")
  renv::restore()
  ```
- **LaTeX** distribution (TeX Live or MiKTeX) with `pdflatex` or `latexmk` for compiling `.tex` figures

---

## Data Access

The dataset is available upon request for research purposes.

- **Data queries:** [luoj1129@gmail.com](mailto:luoj1129@gmail.com)  
  Please mention the manuscript title and describe your intended use briefly.

> Some scripts will not run to completion without the data files (`tables/data1.csv`–`data4.csv`).  
> The `data_dictionary.pdf` file provides variable definitions and coding details.

---

## Questions & Support

- **Code and reproducibility:** [jileil2@gwmail.gwu.edu](mailto:jileil2@gwmail.gwu.edu)  
- **Data requests:** [luoj1129@gmail.com](mailto:luoj1129@gmail.com)

---

## Citation

If you use this code or build upon the analyses, please cite:

> *Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis: A Systematic Review and Statistical Analysis.* (Submitted to **BMJ**)

---

## Disclaimer

This repository is provided for academic and research use.  
Results may change as the manuscript undergoes peer review and revisions.
