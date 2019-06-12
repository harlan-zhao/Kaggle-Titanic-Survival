import pandas as pd
from sklearn import svm

df_train = pd.read_csv("train.csv")
df_test = pd.read_csv("test.csv")


df_train.insert(1,"FamilySize",(df_train["SibSp"]+df_train["Parch"]).astype(int))

df_train["Fare"] = df_train["Fare"].fillna(df_train["Fare"].dropna().median())
df_train["Age"] = df_train["Age"].fillna(df_train["Age"].dropna().median())

df_train.loc[df_train["Sex"] == "male", "Sex"] = 0
df_train.loc[df_train["Sex"] == "female", "Sex"] = 1

features = ["Pclass","Sex","Age","FamilySize"]
labels = df_train["Survived"].values
train = df_train[features].values

df_test.insert(1,"FamilySize",(df_test["SibSp"]+df_test["Parch"]).astype(int))
df_test["Fare"] = df_test["Fare"].fillna(df_test["Fare"].dropna().median())
df_test["Age"] = df_test["Age"].fillna(df_test["Age"].dropna().median())

df_test.loc[df_test["Sex"] == "male", "Sex"] = 0
df_test.loc[df_test["Sex"] == "female", "Sex"] = 1
test = df_test[features]

model =svm.SVC()
model.fit(train,labels)
results = model.predict(test)

df_test.insert(1,"Survived",results)
print(results)

final = df_test[["PassengerId","Survived"]]
final.to_csv("SVM.csv")



