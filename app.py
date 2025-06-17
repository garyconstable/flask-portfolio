from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mail import Mail, Message
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize app only ONCE
app = Flask(__name__)
app.secret_key = 'your_secret_key_here'

# 📦 Register Translator Blueprint
from Projects.Translator.translator_app import translator_bp
app.register_blueprint(translator_bp)

# 📧 Gmail SMTP Config
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = os.environ.get('MAIL_USERNAME')
app.config['MAIL_PASSWORD'] = os.environ.get('MAIL_PASSWORD')

mail = Mail(app)

# 🌍 Page Routes
@app.route('/', methods=['GET', 'POST'])
def home():
    return render_template('index.html', title='Home')

@app.route('/generic', methods=['GET', 'POST'])
def generic():
    return render_template('generic.html', title='Generic')

@app.route('/elements', methods=['GET', 'POST'])
def elements():
    return render_template('elements.html', title='Elements')

@app.route('/translator', methods=['GET', 'POST'])
def translator():
    return render_template('pages/translator.html', title='Free AI Translator | Instant Language Translation Tool – Gary Constable')

# 📬 Contact Form Handler
@app.route('/contact-form', methods=['POST'])
def contact_form():
    name = request.form.get('name')
    email = request.form.get('email')
    message = request.form.get('message')

    if not name or not email or not message:
        flash('Please fill out all fields.')
        return redirect(request.referrer or url_for('home'))

    try:
        msg = Message(
            subject=f'New Contact Form Submission from {name}',
            sender=app.config['MAIL_USERNAME'],
            recipients=['garyconstable80@gmail.com'],
            body=f"Name: {name}\nEmail: {email}\n\nMessage:\n{message}"
        )
        mail.send(msg)
        flash('Thanks! Your message was sent.')
    except Exception as e:
        print(f"Email sending failed: {e}")
        flash('Error sending message. Please try again.')

    return redirect(request.referrer or url_for('home'))

# ❌ 404 Page
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html', title='404 – Not Found'), 404

# 🚀 Run the App
if __name__ == '__main__':
    app.run(debug=True)
