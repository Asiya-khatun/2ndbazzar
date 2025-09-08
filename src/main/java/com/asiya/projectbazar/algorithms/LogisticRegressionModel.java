package com.asiya.projectbazar.algorithms;

import java.util.List;
import java.util.Random;

import com.asiya.projectbazar.algorithms.RecommendationProcess.TrainingExample;

public class LogisticRegressionModel implements RecommenderModel{
	private double[]w;
	private final double learningRate;
	private final double l2;
	private final int epochs;
	private final int seed;

	public LogisticRegressionModel( double learningRate, double l2, int epochs, int seed) {
		this.learningRate = learningRate;
		this.l2 = l2;
		this.epochs = epochs;
		this.seed = seed;
	}

	@Override
	public void train(List<TrainingExample> data) {
		if (data.isEmpty()) return;
		int dim = data.get(0).x.length;
		w = new double[dim];
		Random rng = new Random(seed);

		for (int epoch = 0; epoch < epochs; epoch++) {
			java.util.Collections.shuffle(data, rng);
			for (RecommendationProcess.TrainingExample ex : data) {
				double z = dot(w, ex.x);
				double p = sigmoid(z);
				double error = p - ex.y;

				// L2 regularization
				for (int j = 0; j < dim; j++) {
					double grad = error * ex.x[j] + l2 * w[j];
					w[j] -= learningRate * grad;
				}
			}
		}
	}

	@Override
	public double score(double[] x) {
		if (w == null) return 0.0;
		return sigmoid(dot(w, x));
	}

	private double dot(double[] a, double[] b) {
		double s = 0.0;
		for (int i = 0; i < a.length; i++) s += a[i] * b[i];
		return s;
	}

	private double sigmoid(double z) {
		if (z < -35) return 1e-15;
		if (z > 35) return 1 - 1e-15;
		return 1.0 / (1.0 + Math.exp(-z));
	}
	
	public static void evaluateModel(int[] actual,int[] predicted) {
		int TP=0,TN=0,FP=0,FN=0;
	for(int i=0; i<actual.length; i++) {
		if(predicted[i]==1 && actual[i]==1)TP++;
        else if (predicted[i] == 0 && actual[i] == 0) TN++;
        else if (predicted[i] == 1 && actual[i] == 0) FP++;
        else if (predicted[i] == 0 && actual[i] == 1) FN++;
		}
	double accuracy = (double) (TP + TN) / (TP + TN + FP + FN);
    double precision = TP + FP == 0 ? 0 : (double) TP / (TP + FP);
    double recall = TP + FN == 0 ? 0 : (double) TP / (TP + FN);
    double f1 = (precision + recall) == 0 ? 0 : (2 * precision * recall) / (precision + recall);

    System.out.println("Accuracy: " + accuracy);
    System.out.println("Precision: " + precision);
    System.out.println("Recall: " + recall);
    System.out.println("F1-Score: " + f1);
	}
}