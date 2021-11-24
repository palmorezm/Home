

import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt
import seaborn as sns

cities = pd.read_csv("cities.csv")
print(cities.head(10))

df = pd.Categorical(cities)
print(df)

