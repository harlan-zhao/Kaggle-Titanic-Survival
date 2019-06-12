import pandas as pd
from sklearn import linear_model, preprocessing

df_train = pd.read_csv("train.csv")
df_test = pd.read_csv("test.csv")

df_train.insert(1,"FamilySize",(df_train["SibSp"]+df_train["Parch"]).astype(int))

df_train["Fare"] = df_train["Fare"].fillna(df_train["Fare"].dropna().median())
df_train["Age"] = df_train["Age"].fillna(df_train["Age"].dropna().median())

df_train.loc[df_train["Sex"] == "male", "Sex"] = 0
df_train.loc[df_train["Sex"] == "female", "Sex"] = 1

labels = df_train["Survived"].values
train = df_train[["Pclass","Sex","Age","FamilySize"]].values

poly = preprocessing.PolynomialFeatures(degree=2)
PolyTrain = poly.fit_transform(train)

classifier = linear_model.LogisticRegression()
result = classifier.fit(PolyTrain,labels)
print(result.score(PolyTrain,labels))

# 82% accuracy
