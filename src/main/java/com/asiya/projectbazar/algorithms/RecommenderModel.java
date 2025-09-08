package com.asiya.projectbazar.algorithms;

import java.util.List;

public interface RecommenderModel {
    void train(List<RecommendationProcess.TrainingExample> data);
    double score(double[] x);
}

