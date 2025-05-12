from pyspark.sql import SparkSession
from pyspark.ml.feature import StringIndexer, VectorAssembler
from pyspark.ml.classification import RandomForestClassifier
from pyspark.ml.evaluation import MulticlassClassificationEvaluator
from pyspark.ml import Pipeline
import matplotlib.pyplot as plt

spark = SparkSession.builder.appName("A5").getOrCreate()
features = ["sepal_length", "sepal_width", "petal_length", "petal_width"]
schema = "sepal_length DOUBLE, sepal_width DOUBLE, petal_length DOUBLE, petal_width DOUBLE, species STRING"
iris = spark.read.csv(r"a5/iris.csv", schema=schema)

# Load the data and set features.
indexer = StringIndexer(inputCol="species", outputCol="label")
assembler = VectorAssembler(
    inputCols=features,
    outputCol="features")

# Make the pipeline and train the model.
rf = RandomForestClassifier(numTrees=30, maxDepth=5)
pipeline = Pipeline(stages=[indexer, assembler, rf])
train, test = iris.randomSplit([0.8, 0.2], seed=42)
model = pipeline.fit(train)

# Produce predictions on the test set.
predictions = model.transform(test).cache()

evaluator = MulticlassClassificationEvaluator(metricName="accuracy")
accuracy = evaluator.evaluate(predictions)

print(f"Test accuracy = {accuracy:.3f}")
predictions.select("features", "label", "prediction").show(50, truncate=False)

# Show some additional stats about the dataset.
stats = iris.select(features).summary("count", "mean", "min", "25%", "50%", "75%", "max")
stats.show(truncate=False)

# 1. Plot how important each feature is to the model.
rf_model = model.stages[-1]  # Get the last state of the pipeline.
importances = rf_model.featureImportances.toArray()

plt.figure(figsize=(6, 4))
plt.bar(range(len(importances)), importances, tick_label=features)
plt.ylabel("Importance (0 ‒ 1)")
plt.title("Level of Importance for Each Feature")
plt.xticks(rotation=30, ha="right")
plt.tight_layout()
plt.show()


# 2. Plot the feature correlation.
iris_pd = iris.select(features).toPandas()  # Use as pandas DataFrame.
pearson_coefficients = iris_pd.corr()  # 4x4 heat-map of features.

plt.figure(figsize=(8, 6))
im = plt.imshow(pearson_coefficients, vmin=-1, vmax=1, cmap="coolwarm")

# Axis labels.
plt.xticks(range(len(features)), features, rotation=30, ha="right")
plt.yticks(range(len(features)), features)
plt.title("Feature Correlation Heat‑map")

# Display the pearson coefficient for each cell.
for i in range(pearson_coefficients.shape[0]):
    for j in range(pearson_coefficients.shape[1]):
        plt.text(j, i, f"{pearson_coefficients.iloc[i, j]:.2f}",
                 ha="center", va="center", fontsize=8)

plt.colorbar(im, label="Pearson Coefficient")
plt.tight_layout()
plt.show()
