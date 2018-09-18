#cd C:\Users\Fuad\Desktop\Design\Independent Studies\Processing
#python

import pylrc, spacy, csv

nlp = spacy.load('en_default')

lrc_file = open('Abachbida.lrc.txt')
lrc_string = ''.join(lrc_file.readlines())
lrc_file.close()
subs = pylrc.parse(lrc_string)

def most_similar(word):
  queries = [s for s in word.vocab if s.is_lower == word.is_lower and s.prob <=-15]
  by_similarity = sorted(queries, key=lambda s: word.similarity(s), reverse=True)
  return by_similarity[:10]

lines = []
for s in subs:
  lines.append(s.text.lower().split())

lines_last = [l[-1] for l in lines]

with open('apples.csv', 'wb') as csvfile:
  writer = csv.writer(csvfile)
  for w in lines_last:
  	writer.writerow([w]+[s.lower_.encode("ascii","replace") for s in most_similar (nlp.vocab[unicode(w)])])


 #for w in lines_last:
 # (w, [s.lower_ for s in most_similar(nlp.vocab[unicode(w)])])

 #for s in subs:
 #word_list = s.text.lower().split()
 #[s.lower_ for s in most_similar(nlp.vocab[s])]