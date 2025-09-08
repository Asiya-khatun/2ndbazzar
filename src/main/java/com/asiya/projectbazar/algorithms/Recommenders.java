package com.asiya.projectbazar.algorithms;

public class Recommenders {
	public static RecommenderModel logisticRegressionDefault() {
		return new LogisticRegressionModel(0.05,1e-4,10,42);
	}
	
	public static RecommenderModel naiveBayesDefault() {
		return new NaiveBayesModel();
	}

}
