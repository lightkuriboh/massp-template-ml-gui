
from flask import Flask, request, render_template, url_for, redirect, send_from_directory
import os

from mpl_toolkits.axes_grid1 import host_axes

import config
import time
import cv2
import numpy as np
from haze_removal import haze_removal
import try_lib

app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template('index.html', name='hieu pro')


@app.route('/img_show/<path:filename>')
def img_show(filename):
    return send_from_directory(config.img_out_dir, filename)


@app.route("/handleUpload", methods=['POST'])
def handle_file_upload():
    if 'photo' in request.files:
        photo = request.files['photo']
        if photo.filename != '':
            new_name = str(int(time.time())) + '.jpg'
            photo.save(os.path.join(config.img_dir, new_name))
            # time.sleep(1)
            de_haze(new_name) # solve problem
            time.sleep(1)
    return redirect(url_for('img_show', filename=new_name))


def de_haze(new_name):
    image = np.array(cv2.imread(config.img_dir + new_name))
    cv2.imwrite(config.img_out_dir + new_name, haze_removal(image))


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
