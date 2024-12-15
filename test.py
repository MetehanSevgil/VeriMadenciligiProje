import tensorflow as tf
from keras.models import load_model
import numpy as np

# Model ve test görseli yolu
MODEL_PATH = "C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\deneme_resnet50_model.keras"  # Model yolu
TEST_IMAGE_PATH = "C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\Veriler\\salata\\salata1.jpg"  # Test görüntüsü yolu
CLASS_NAMES = ['acili_ezme',
                'ayran_corbasi',
                'baklava',
                'brokoli',
                'cacik',
                'cigkofte',
                'domates_corbasi',
                'doner',
                'etli_patates',
                'ezogelin_corbasi',
                'fasulye',
                'icecekler',
                'kanat',
                'kazandibi',
                'kofte',
                'kremali_mantar_corbasi',
                'makarna',
                'mantar_sote',
                'mercimek_corbasi',
                'musakka',
                'pilav',
                'salata',
                'su_boregi',
                'sutlac',
                'trilece',
                'tulumba',
                'tursu',
                ]  # Modelinizdeki sınıf isimlerini yazın
IMG_SIZE = (256, 256)

# Modeli yükle
model = load_model(MODEL_PATH)
print("Model yüklendi!")

# Test görüntüsünü yükle
img = tf.keras.preprocessing.image.load_img(TEST_IMAGE_PATH, target_size=IMG_SIZE)
img_array = tf.keras.preprocessing.image.img_to_array(img)
img_array = tf.expand_dims(img_array, 0)  # Resmi modele uygun şekle getir
img_array = img_array / 255.0  # Normalizasyon

# Tahmin yap
predictions = model.predict(img_array)
score = tf.nn.softmax(predictions[0])

# Sonuçları yazdır
print("Bu görüntü en olası şekilde {} sınıfına ait.".format(CLASS_NAMES[np.argmax(score)]))
print("Tahmin olasılıkları:")

for i in range(len(CLASS_NAMES)):
    print("{}: {:.2f}%".format(CLASS_NAMES[i], 100 * score[i]))

# Test görüntüsünü göster
img.show()
