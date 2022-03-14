# Dirichlet-Simulator
A function simulating a Dirichlet process of clustering. 

**Parameters:** _a_, the alpha parameter; _n_, the number of units to cluster; _r_, the ‘resolution’ or number of simulations; _all_, the desired output format. 

Resolution is defined as the number of Dirichlet processes simulated in one iteration of the function. There is a important trade off between running time and precision of the answer. Low r might not identify every possible configuration and probability estimates will be less accurate. On the other hand, large r take longer to run. The default is set to 1000 but users should change it according to their needs. The all parameter takes a logical value. For all=TRUE, the function returns every clustering configuration identified along with their corresponding probabilities. For all=FALSE (default), the function only returns the most likely clustering distribution, along with its probability. 

