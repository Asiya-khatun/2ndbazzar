package com.asiya.projectbazar.algorithms;

import java.util.List;

import com.asiya.projectbazar.algorithms.RecommendationProcess.TrainingExample;

public class NaiveBayesModel implements RecommenderModel {
	private double[] pFeatureGivenPos;    //p(x_j=1|y=1)
	private double[] pFeatureGivenNeg;		//p(x_j=1|y=0)
	private double pPos;					//p(y=1)
	private double threshold=0.5;			//turning the feature into 0/1

	@Override
	public void train(List<TrainingExample> data) {
if(data.isEmpty()) return;
int dim=data.get(0).x.length;

double posCount=0.0;
double negCount=0.0;
double[] posOnes=new double[dim];
double [] negOnes=new double[dim];

double alpha=1.0;
double beta=1.0;
for(RecommendationProcess.TrainingExample ex:data) {
	if(ex.y==1) {
		posCount+=1.0;
		for(int j=0;j<dim;j++) {
			if(ex.x[j]>=threshold) posOnes[j]+=1.0;
		}
	
	}else {
		negCount+=1.0;
		for(int j=0;j<dim;j++) {
			if(ex.x[j]>=threshold) negOnes[j]+=1.0;
		}
	}
}
pPos=(posCount+1.0)/(posCount+negCount+2.0);
pFeatureGivenPos=new double[dim];
pFeatureGivenNeg=new double[dim];
for(int j=0;j<dim;j++) {
           pFeatureGivenPos[j] = (posOnes[j] + alpha) / (posCount + alpha + beta);
           pFeatureGivenNeg[j] = (negOnes[j] + alpha) / (negCount + alpha + beta);
       }
   }


	@Override
    public double score(double[] x) {
        if (pFeatureGivenPos == null) return 0.0;

      
        double logP1 = Math.log(pPos);
        double logP0 = Math.log(1.0 - pPos);

        for (int j = 0; j < x.length; j++) {
            boolean bit = x[j] >= threshold;
            double pj1 = clampProb(bit ? pFeatureGivenPos[j] : (1.0 - pFeatureGivenPos[j]));
            double pj0 = clampProb(bit ? pFeatureGivenNeg[j] : (1.0 - pFeatureGivenNeg[j]));
            logP1 += Math.log(pj1);
            logP0 += Math.log(pj0);
        }

        double logOdds = logP1 - logP0;
        return 1.0 / (1.0 + Math.exp(-logOdds));
    }

    private double clampProb(double p) {
        double eps = 1e-12;
        if (p < eps) return eps;
        if (p > 1 - eps) return 1 - eps;
        return p;
    }
    
    public static void evaluateModel(int[] actual, int[] predicted) {
        int TP = 0, TN = 0, FP = 0, FN = 0;

        for (int i = 0; i < actual.length; i++) {
            if (predicted[i] == 1 && actual[i] == 1) TP++;
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

