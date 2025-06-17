from flask import Flask, render_template, request
import requests

app = Flask(__name__)

# Google Translate endpoint (unofficial, free, no key needed)
TRANSLATE_URL = "https://translate.googleapis.com/translate_a/single"

# Supported language codes for demo purposes
LANGUAGES = {
    "en": "English",
    "es": "Spanish",
    "fr": "French",
    "de": "German",
    "it": "Italian",
    "pt": "Portuguese"
}

@app.route('/', methods=['GET', 'POST'])
def translate():
    translated_text = ""
    original_text = ""
    source_lang = "en"
    target_lang = "fr"

    if request.method == 'POST':
        original_text = request.form['text']
        source_lang = request.form['source_lang']
        target_lang = request.form['target_lang']

        try:
            response = requests.get(TRANSLATE_URL, params={
                "client": "gtx",
                "sl": source_lang,
                "tl": target_lang,
                "dt": "t",
                "q": original_text
            })

            if response.status_code == 200:
                translated_text = response.json()[0][0][0]
            else:
                translated_text = '[Translation failed]'
        except Exception as e:
            translated_text = f'[Error: {str(e)}]'

    return render_template('index.html',
                           translated_text=translated_text,
                           original_text=original_text,
                           source_lang=source_lang,
                           target_lang=target_lang,
                           languages=LANGUAGES)

if __name__ == '__main__':
    app.run(debug=True)
