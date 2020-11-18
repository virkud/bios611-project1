
# coding: utf-8

# In[1]:


import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
from sklearn.manifold import TSNE
from plotnine import *


# In[2]:


data = pd.read_csv("~/hw5/q2dset2.csv")


# In[3]:


X = data.loc[:,"Intelligence":"Combat"]
Y = data.loc[:,"Alignment"]


# In[7]:


pca = PCA(n_components=2)
pca_result = pca.fit_transform(X)


# In[8]:


pca_df = pd.DataFrame(columns = ['pca1','pca2'])
pca_df['pca1'] = pca_result[:,0]
pca_df['pca2'] = pca_result[:,1]


# In[21]:


X_embedded = TSNE(n_components=2).fit_transform(pca_result)
df = pd.DataFrame(X_embedded, columns=['x', 'y'])
df.to_csv("tsne.csv")
df["cluster"] = Y


# In[27]:


plot=(ggplot(df, aes(df.x,df.y))+ geom_point(aes(color=df.cluster)))
plot
ggsave(plot, "pytsneplot.png")

