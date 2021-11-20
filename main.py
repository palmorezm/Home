
import matplotlib.pyplot as plt 
import numpy as np 
import pandas as pd
from numpy import random
import seaborn as sns

x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
y = [2,4,6,8,10,12,14,16,18,20]

plt.plot(x,y)

x = random.randint(100, size=(100))
y = random.randint(100, size=(100))
z = random.randint(20, 23, size=10)
df = pd.DataFrame(x, y, z)
print(df)

sns.scatterplot(data = df, x = x, y = y)