function res = entropy(positive, negative)
		total = positive + negative
	 	res = -(positive/total)*log2(positive/total) - (negative/total)*log2(negative/total)

