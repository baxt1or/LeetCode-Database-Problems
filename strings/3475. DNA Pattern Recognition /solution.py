import pandas as pd 

def analyze_dna_patterns(samples: pd.DataFrame) -> pd.DataFrame:

    stop_codons = [ 'TAA', 'TAG', 'TGA'] 

    repeated_codons = 'ATAT'

    ggs = ['GGG' ,'GGGG']
    
    samples["has_start"] = samples["dna_sequence"].apply(lambda x: 1 if x[:3] == 'ATG' else 0)

    samples["has_stop"] = samples["dna_sequence"].apply(lambda x: 1 if x[-3:] in stop_codons else 0)

    samples["has_atat"] = samples["dna_sequence"].apply(lambda x: 1 if repeated_codons in x else 0)

    samples["has_ggg"] = samples["dna_sequence"].apply(lambda x: 1 if 'GGG' in x or 'GGGG' in x else 0)

    return samples


if __name__ == '__main__':

    data = [[1, 'ATGCTAGCTAGCTAA', 'Human'], [2, 'GGGTCAATCATC', 'Human'], [3, 'ATATATCGTAGCTA', 'Human'], [4, 'ATGGGGTCATCATAA', 'Mouse'], [5, 'TCAGTCAGTCAG', 'Mouse'], [6, 'ATATCGCGCTAG', 'Zebrafish'], [7, 'CGTATGCGTCGTA', 'Zebrafish']]
    samples = pd.DataFrame(data=data,columns=['sample_id','dna_sequence','species'])


    analyze_dna_patterns(samples=samples)