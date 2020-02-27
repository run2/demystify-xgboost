import math
import random

leaf2_prob_ww = [0.129,0.249,0.363,0.469,0.571,0.667,0.757,0.842,0.923]
leaf2_class0 = [3,4,2,2,2,2,2,2,1]
leaf2_class1 = [1,1,1,1,2,1,1,1,6]


leaf1_prob_ww = [0.076,0.155,0.24,0.329,0.425,0.527,0.633,0.748,0.87]
leaf1_class0 = [147,8,6,6,4,4,2,2,1]
leaf1_class1 = [0,0,0,0,0,1,1,1,2]


leaf1_prob_nw = [0.07,0.145,0.226,0.312,0.406,0.507,0.615,0.733,0.86]
leaf2_prob_nw = [0.088,0.179,0.272,0.367,0.467,0.569,0.672,0.778,0.888]



sample_prob_ww = []
sample_prob_nw = []
sample_label = []
for pww,pnw,c0,c1 in zip(leaf2_prob_ww,leaf2_prob_nw,leaf2_class0,leaf2_class1):
    if c0 > 0 :
        sample_prob_ww = sample_prob_ww + list(np.ones(c0)*pww)
        sample_prob_nw = sample_prob_nw + list(np.ones(c0)*pnw)
        sample_label = sample_label + list(np.zeros(c0))
    if c1 > 0 :
        sample_prob_ww = sample_prob_ww + list(np.ones(c1)*pww)
        sample_prob_nw = sample_prob_nw + list(np.ones(c1)*pnw)
        sample_label = sample_label + list(np.ones(c1))
        
for pww,pnw,c0,c1 in zip(leaf1_prob_ww,leaf1_prob_nw,leaf1_class0,leaf1_class1):
    if c0 > 0 :
        sample_prob_ww = sample_prob_ww + list(np.ones(c0)*pww)
        sample_prob_nw = sample_prob_nw + list(np.ones(c0)*pnw)
        sample_label = sample_label + list(np.zeros(c0))
    if c1 > 0 :
        sample_prob_ww = sample_prob_ww + list(np.ones(c1)*pww)
        sample_prob_nw = sample_prob_nw + list(np.ones(c1)*pnw)
        sample_label = sample_label + list(np.ones(c1))
    

assert(len(sample_label)==220)
assert(len(sample_prob_ww)==220)
assert(len(sample_prob_nw)==220)


from sklearn.metrics import roc_auc_score,roc_curve

print('Auc with weights',roc_auc_score(sample_label,sample_prob_ww))

print('Auc with no weights',roc_auc_score(sample_label,sample_prob_nw))

fprww,tprww,thww = roc_curve(sample_label,sample_prob_ww)
fprnw,tprnw,thnw = roc_curve(sample_label,sample_prob_nw)

import matplotlib as mpl
import matplotlib.pyplot as plt
%matplotlib inline
rcParams['figure.figsize'] = 8,5

plt.plot(fprww, tprww, linestyle='--', label='With Weights')
plt.plot(fprnw, tprnw, marker='.', label='No Weights')
# axis labels
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
# show the legend
plt.legend()





