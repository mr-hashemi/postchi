import os 
import re
import time
from flask import Flask, render_template, request



def modify(text):
    mapping = {
        r"\bببین\b": "bebin" , 
        r"\bبچاپ\b": "bechap" , 
        r"\bبده\b": "bede" ,     
        r"\bتا\b": "ta" , 
        r"\bبود\b": "bood" , 
        r"\bاگه\b": "age" , 
        r"\bبعدی\b": "badi" , 
        r"\bخب\b": "khob" ,   
        r"\bنو\b": "jadid" ,        
        r"\bجدید\b": "jadid" ,        
        r"\bن\b\s+[\?؟]\b": "na ?" ,    
        r"\bبزرگتر\s+از\b": ">" ,    
        r"\bبزرگتر\s+مساوی\b": ">=" ,    
        r"\bکوچکتر\s+از\b": "<" ,    
        r"\bکوچکتر\s+مساوی\b": "<=" ,     
    }

    for k, v in mapping.items():
        text = re.sub(k, v, text)
    return text


def modify_rest(text):
    farsi = "آابپتثجچحخدذرزٓسشصضطظعغفقکگلمنوهیی"
    engl = "AaptTjChxdZrzzswquIMVQfgkGlmnvhEL"
    for f, e in zip(farsi, engl):
        text = text.replace(f, e)

    return text

def farsize(text):
    pat = r"(\")(.*?\1)"
    delim_str = "{-res_iter-}"

    res = re.findall(pat, text)
    res = [''.join(r) for r in res]
    nonstr = re.sub(pat, delim_str, text).split(delim_str)
    xxx = [modify_rest(modify(nonstr[t//2])) if not t%2 else res[t//2] for t in  range(2 * len(nonstr)-2 )]
    xxx.append(modify_rest(nonstr[-1]))

    code = ''.join(xxx) 
    return code



app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        tmp_fname = f"./tmp/code-{time.time()}.hashem"
        code = request.form['code']
        with open(tmp_fname, 'w') as f:
            code = farsize(code)
            f.write(code)
        
        with os.popen(f'./hashem {tmp_fname}') as res:
            value = res.read()
        return render_template('index.html', code=code, value=value)
    return render_template('index.html')
        

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
