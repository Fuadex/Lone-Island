#cd C:\Users\Fuad\Desktop\Design\Independent Studies\Processing
#python

import pylrc, spacy, csv

nlp = spacy.load('en_default') #Change to en or any other module pack featured by spaCy

lrc_file = open('Abachbida.lrc.txt') #.lrc.txt file to be read
lrc_string = ''.join(lrc_file.readlines())
lrc_file.close()
subs = pylrc.parse(lrc_string) #all the magical parsing works here (pylrc)

def most_similar(word):
  queries = [s for s in word.vocab if s.is_lower == word.is_lower and s.prob <=0] #Here you may define the similarity cut-off
  by_similarity = sorted(queries, key=lambda s: word.similarity(s), reverse=True)
  return by_similarity[:18] #You can manipulate by how many similar words the code will return

lines = []
for s in subs:
  lines.append(s.text.lower().split())

lines_last = [l[-1] for l in lines] #This will get the last word, although may be manipulated to get the first or another

with open('Abachbida 0.csv', 'wb') as csvfile: #Please define a specific file output
  writer = csv.writer(csvfile)
  for w in lines_last:
  	writer.writerow([w]+[s.lower_.encode("ascii","replace") for s in most_similar (nlp.vocab[unicode(w)])])


 #for w in lines_last:
 # (w, [s.lower_ for s in most_similar(nlp.vocab[unicode(w)])])

 #for s in subs:
 #word_list = s.text.lower().split()
 #[s.lower_ for s in most_similar(nlp.vocab[s])]