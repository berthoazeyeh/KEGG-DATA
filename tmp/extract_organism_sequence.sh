
#!bin/bash
mkdir kegg;
mkdir organism_sequences;
mkdir kegg/sequence_id;
while read row; do
   wget -nc https://rest.kegg.jp/list/$row --output-document=kegg/$row.txt;
    #extraction of gens numbers
   cut -f 1 kegg/$row.txt >> kegg/sequence_id/$row.txt;
   mkdir organism_sequences/$row;
   while read line; do 
     gene=$(wget -qO- https://rest.kegg.jp/get/$line/NTSEQ);
     protein=$(wget -qO- https://rest.kegg.jp/get/$line/AASEQ);
     echo "$gene" >> organism_sequences/$row/dna_sequence.fasta;
     echo "$protein" >> organism_sequences/$row/protein_sequence.fasta;	
   done < kegg/sequence_id/$row.txt;
done < organism_abbreviation.txt;
