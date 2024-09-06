# Compartmental Models: Prediction of COVID-19 Progression

## Group 42
- Yufu Li
- Zhiqing Zhang
- Yongjun Zhou
- Qifan Zhu

## Abstract
This project explores the prediction of the COVID-19 progression using several compartmental models. We start by applying a deterministic SIR model and then enhance it with a modified SEIRD model, which accounts for additional factors such as exposed and deceased individuals. We also employ stochastic models like the SIR and SEIR, leveraging an agent-based Markov chain Monte Carlo (MCMC) framework to handle subject-level infection histories and account for missing infection data. The models are tested with real COVID-19 data, such as cases from Italy and the Waterloo region, to predict infection trajectories and evaluate their effectiveness in forecasting disease spread.

## Models Implemented
### 1. **Deterministic SIR Model**
   - Basic compartmental model dividing the population into Susceptible (S), Infectious (I), and Removed (R).
   - The model assumes constant transmissibility and recovery rates, which are solved through ordinary differential equations (ODEs).
   - Limitations include its exclusion of asymptomatic and deceased individuals, leading to a simplified view of epidemic dynamics.

### 2. **Modified SEIRD Model**
   - This extends the SIR model by introducing two additional compartments: Exposed (E) and Deceased (D).
   - The model assumes that asymptomatic individuals contribute to the spread of the virus and separates recovered and dead individuals.
   - The SEIRD model introduces machine learning to fit the parameters and improve accuracy.

### 3. **Stochastic SIR and SEIR Models**
   - These models account for randomness in transitions between compartments and are more robust when dealing with partial infection data.
   - An MCMC framework is used to sample infection histories and estimate transition rates dynamically.

## Methodology
The methodology includes:
- **Deterministic Model Fitting**: Using the `deSolve` package in R to solve the ODE system for the SIR and SEIRD models.
- **Modified SEIRD Parameter Estimation**: Utilizing machine learning to estimate optimal parameters that minimize log loss between predicted and real data.
- **Stochastic Models**: Leveraging the Markov chain Monte Carlo (MCMC) approach for stochastic epidemic modeling.

## Results
- The deterministic SIR model was applied to COVID-19 data from Italy and was found to predict outbreaks accurately in regions where disease progression was simple and stable.
- The modified SEIRD model provided a better fit by addressing the incubation period of COVID-19 and separating fatal from recovered cases.
- Stochastic models, applied to smaller datasets like the Waterloo region, provided better predictions for early-stage outbreaks and situations with incomplete data.

## Files
- `seir_main.py`: Python implementation of the SEIRD model and parameter optimization.
- `sir_model.R`: R script for fitting the deterministic SIR model using real COVID-19 data.
- `stochastic_model.R`: R script for fitting stochastic SIR and SEIR models using MCMC methods.

## Dependencies
### R:
- `deSolve`: For solving differential equations in deterministic models.
- `coronaModel`: A custom R package for fitting compartmental models to COVID-19 data.
- `ggplot2`: For visualizing the results of the models.

### Python:
- `numpy`: For numerical operations.
- `scipy.optimize`: For dual annealing optimization of model parameters.
- `reticulate`: To allow seamless integration between Python and R.

## How to Run the Models
1. **Install the required R and Python packages**.
   - In R:  
     ```R
     install.packages(c("deSolve", "MLmetrics", "ggplot2", "coronaModel", "reticulate"))
     ```
   - In Python (if using the `seir_main.py` script):
     ```bash
     pip install numpy scipy
     ```

2. **Run the R scripts**:
   - To run the deterministic SIR model, use the `sir_model.R` script:
     ```R
     source("sir_model.R")
     ```

   - For the stochastic SIR/SEIR model:
     ```R
     source("stochastic_model.R")
     ```

3. **Run the Python scripts**:
   - To fit and predict using the SEIRD model, use the following command in Python:
     ```bash
     python seir_main.py
     ```

## References
- Allen, L. (1999). "Comparison of deterministic and stochastic SIS and SIR models in discrete time".
- Centers of Disease Control and Prevention. (2020). "Coronavirus Disease 2019 (COVID-19) Factsheet".
- World Health Organization (WHO) Situation Reports, 2020.

For more detailed results, refer to the included PDF report.

