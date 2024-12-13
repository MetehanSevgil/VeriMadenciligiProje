import tensorflow as tf
from keras.models import load_model
import numpy as np

# Model ve test görseli yolu
MODEL_PATH = "C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\deneme_resnet50_model.keras"  # Model yolu
TEST_IMAGE_PATH = "C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\Veriler\\brokoli\\brokoli1_aug4.jpg"  # Test görüntüsü yolu
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

# Görüntüyü hazırla
img = tf.image.decode_jpeg(tf.io.read_file(TEST_IMAGE_PATH), channels=3)  # Görüntüyü yükle ve aç
img = tf.image.resize(img, IMG_SIZE)  # Görüntüyü boyutlandır
img_array = tf.expand_dims(img, axis=0)  # Batch boyutunu ekle
img_array = img_array / 255.0  # Normalizasyon

# Tahmin yap
predictions = model.predict(img_array)
predicted_class = np.argmax(predictions[0])  # En yüksek olasılıklı sınıf
print(f"Tahmin Edilen Sınıf: {CLASS_NAMES[predicted_class]}")
