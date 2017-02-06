
# coding: utf-8

# # Table of Contents
#  <p>

# In[1]:

import xlwings as xw


# In[2]:

xw.Range('A1').value = 'something'


# In[4]:

import pandas as pd
df = xw.Range('A1').expand().options(pd.DataFrame).value
df.head()


# In[6]:

df.groupby(level = 'Plan')


# In[ ]:



