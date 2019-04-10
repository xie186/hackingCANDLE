## P3B1: Multi-task Deep Neural Net (DNN) for data extraction from clinical reports

**Overview**: Given a corpus of patient-level clinical reports, build a deep learning network that can simultaneously identify: (i) b tumor sites, (ii) t tumor laterality, and (iii) g clinical grade of tumors.

**Relationship to core problem**: Instead of training individual deep learning networks for individual machine learning tasks, build a multi-task DNN that can exploit task-relatedness to simultaneously learn multiple concepts.

**Expected outcome**: Multi-task DNN that trains on same corpus and can automatically classify across three related tasks.

### Benchmark Specs

#### Description of data
* Data source: Annotated pathology reports
* Input dimensions: 250,000-500,000 [characters], or 5,000-20,000 [bag of words], or 200-500 [bag of concepts]
* Output dimensions: (i) b tumor sites, (ii) t tumor laterality, and (iii) g clinical grade of tumors

* Sample size: O(1,000)
* Notes on data balance and other issues: standard NLP pre-processing is required, including (but not limited to) stemming words, keywords, cleaning text, stop words, etc. Data balance is an issue since the number of positive examples vs. control is skewed

#### Expected Outcomes
* Classification
* Output range or number of classes: Initially, 4 classes; can grow up to 32 classes, depending on number of tasks simultaneously trained.

#### Evaluation Metrics
* Accuracy or loss function: Standard approaches such as F1-score, accuracy, ROC-AUC, etc. will be used.
* Expected performance of a naïve method: Compare performance against (i) deep neural nets against single tasks, (ii) multi-task SVM based predictions, and (iii) random forest based methods.

#### Description of the Network
* Proposed network architecture: Deep neural net across individual tasks
* Number of layers: 5-6 layers

A graphical representation of the MTL-DNN is shown below:
![MTL-DNN Architecture](https://raw.githubusercontent.com/ECP-CANDLE/Benchmarks/master/Pilot3/P3B1/images/MTL1.png)

### Running the baseline implementation
There are two broad options for running our MTL implementation. The first baseline option includes the basic training of an MTL-based deep neural net. The second implementation includes a standard 10-fold cross-validation loop and depends on the first baseline for building and training the MTL-based deep neural net.

For the first baseline run, an example run is shown below:
```
cd P3B1
python MTL_run.py
```

For the second baseline run, including the 10-fold cross-validation loop, the set up is shown below.
```
cd P3B1
python keras_p3b1_baseline.py
```

Note that the training and testing data files are provided as standard CSV files in a folder called data. The code is documented to provide enough information to reproduce the code on other platforms.

The original data from the pathology reports cannot be made available online. Hence, we have pre-processed the reports so that example training/testing sets can be generated. Contact yoonh@ornl.gov for more information for generating additional training and testing data. A generic data loader that generates training and testing sets will be provided in the near future.
