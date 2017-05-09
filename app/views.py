# views.py

from flask import render_template, request, send_file

from app import app
from io import BytesIO

import watermark.watermark as wt

from PIL import Image




@app.route('/')
def index():
    return render_template("index.html", name="Sony Watermarking POC", uploaded='false')

@app.route('/decryption')
def about():
    return render_template("decrypt.html", name="Sony Watermarking POC", uploaded='false')


@app.route('/upload', methods = ['GET', 'POST'])
def upload_file():

	keyValue = request.form.get('keyValue')
	f = request.files['file']

	# in_memory_file = BytesIO()
	#
	# in_memory_file.write(f.read())
	# in_memory_file.seek(0)

	f.save("input-file.jpg")

	wt.markByteImage("input-file.jpg",keyValue)

	app.logger.info(keyValue)

	return send_file("../output-file.jpg", mimetype='image/jpeg')


@app.route('/decrypt', methods = ['GET', 'POST'])
def decrypt_file():

	f = request.files['file']

	# in_memory_file = BytesIO()
	#
	# in_memory_file.write(f.read())
	# in_memory_file.seek(0)

	f.save("input-file.jpg")

	out=wt.getKeyFromByteImage("input-file.jpg")

	return out