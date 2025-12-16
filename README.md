# Systematic Sampling using R Shiny

This repository contains an R Shiny application developed as part of the
Sampling–2 coursework. The project demonstrates systematic sampling for
estimating the population mean and visualizes the design of the experiment.

---

## Objective
- To estimate the population mean using systematic sampling
- To determine the required sample size using sampling bias and confidence level
- To visualize the design of the experiment using an R Shiny application

---

## Methodology
The required sample size for estimating the population mean is computed using
the formula:

n = (Z² S²) / B²

where Z is the confidence level, S is the assumed population standard deviation,
and B is the allowable sampling bias. A sampling interval is then calculated and
units are selected systematically from an ordered population using a random
start.

---

## Implementation
- Language: R
- Environment: RStudio
- Framework: Shiny
- Visualization: ggplot2

The application allows users to input population size, confidence level, and
sampling bias, and generates both a summary table and a design-of-experiment
visualization.

---

## Files in this Repository
- `app.R` – R Shiny application
- `Systematic_Sampling_Report.pdf` – Assignment report
- `README.md` – Project documentation
- `screenshots/` – Application screenshots

---

## How to Run the Application
1. Install required packages:
   ```r
   install.packages(c("shiny", "ggplot2"))
