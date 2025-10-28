# Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis  
_A Systematic Review and Statistical Analysis (BMJ submission)_

This repository contains the analysis code and figure/table generation scripts accompanying the manuscript  
**“Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis: A Systematic Review and Statistical Analysis.”**

> **Note:** The analytic dataset is not publicly available. Access can be requested (see **Data Access** below).  
> All code is included to ensure reproducibility once the data are available locally.

---

## Repository Structure

```
.
├── figures/
│   ├── figure_S1/
│   │   ├── figure_S1.R        # Reproduces Figure S1 interactively
│   │   ├── figure_S1.tex      # Combines sub-figures into one panel
│   │   └── tex/               # LaTeX files for individual sub-figures
│   ├── figure_2/
│   ├── figure_3/
│   ├── figure_4/
│   ├── figure_5/
│   ├── figure_6/
│   └── figure_7/
│
├── tables/
│   ├── data_dictionary.pdf    # Variable definitions
│   ├── data1.csv              # Concomitant IIM and MG
│   ├── data2.csv              # ICI-Induced IIM and/or MG
│   ├── data3.csv              # Isolated IIM with TET
│   ├── data4.csv              # Thymoma spontaneous regression
│   ├── table_1/–table_4/      # Analyses for Tables 1–4
│
├── README.md
└── (optional) renv/ or environment files
```

---

## How to Reproduce Results

All scripts are intended to be run **line by line in R**, not as batch jobs.  
The R scripts do **not** create intermediate files; instead, they display tables and plots interactively.  
Inline comments indicate which code blocks correspond to specific manuscript results.

---

### 1. Figures (Figure S1, Figures 2–7)

Each folder `figures/figure_*` contains:
- **`figure_*.R`** — R code for statistical analysis and visualization (run line by line).  
- **`figure_*.tex`** — LaTeX file that arranges multiple sub-figures into one composite figure.  
- **`tex/` subfolder** — LaTeX sources for each sub-figure (e.g., individual panels).

#### Workflow

1. **Run the R script line by line** in R to view analyses and plots.  
2. **Compile all `.tex` files** in the `tex/` subfolder to generate sub-figure PDFs.  
3. **Move or copy** the resulting PDFs into the same directory as `figure_*.tex`.  
4. **Compile** the main `figure_*.tex` to assemble the final composite figure.

```bash
# Example: Figure 2
Rscript figures/figure_2/figure_2.R

# Compile sub-figures
pdflatex figures/figure_2/tex/*.tex

# Move sub-figure PDFs next to figure_2.tex
mv figures/figure_2/tex/*.pdf figures/figure_2/

# Compile composite panel
pdflatex figures/figure_2/figure_2.tex
# or
latexmk -pdf figures/figure_2/figure_2.tex
```

Repeat for `figure_S1`, `figure_3`, …, `figure_7`.

---

### 2. Tables (Analyses for data1–data4)

Each folder `tables/table_k/` (for k = 1,…,4) contains R scripts that replicate the analyses for Tables 1–4.  
Execute each script **line by line** in R.  
Comments in the scripts indicate which code segments correspond to specific reported results.

---

### 3. Working Directory Setup

Before running any R script, set your working directory to where both the **data** and the **script** are located.

```r
# Example
setwd("/path/to/tables/table_1")
```

Or, in RStudio:

```
Session → Set Working Directory → To Source File Location
```

---

## Software Requirements

- **R** (version ≥ 4.0)  
- Common R packages listed in `library(...)` calls at the top of each `.R` file  
- (Optional) **renv** for reproducible environments:
  ```r
  install.packages("renv")
  renv::restore()
  ```
- **LaTeX** distribution (TeX Live or MiKTeX) with `pdflatex` or `latexmk` for compiling figures

---

## Data Access

The dataset is available upon request for research purposes.

- **Data queries:** [luoj1129@gmail.com](mailto:luoj1129@gmail.com)  
  Include the manuscript title and a short description of intended use.

> Some scripts will not run to completion without the data files (`tables/data1.csv`–`data4.csv`).  
> See `data_dictionary.pdf` for variable definitions and coding details.

---

## Questions & Support

- **Code and reproducibility:** [jileil2@gwmail.gwu.edu](mailto:jileil2@gwmail.gwu.edu)  
- **Data requests:** [luoj1129@gmail.com](mailto:luoj1129@gmail.com)

---

## Citation

If you use this code or build upon the analyses, please cite:

> *Striational Antibody-Associated Myositis – Bridging the Gap between Thymoma and Myasthenia Gravis: A Systematic Review and Statistical Analysis.*  
> (Submitted to **BMJ**)

---

## Disclaimer

This repository is provided for academic and research use.  
Results may change as the manuscript undergoes peer review and revision.
