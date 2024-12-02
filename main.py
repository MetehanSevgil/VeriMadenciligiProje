import tensorflow as tf

from keras.utils import image_dataset_from_directory

# Veri seti dizini
dataset_path = "C:\\Users\\Metehan Sevgil\\Desktop\\yemekler\\Ana_Yemekler\\Döner" # Buraya kendi veri seti dizin yolunuzu yazın

# Veri setini yükle
batch_size = 32
img_size = (256, 256)

# Eğitim, doğrulama ve test setleri
train_ds = image_dataset_from_directory(
    dataset_path,
    validation_split=0.2,
    subset="training",
    seed=123,
    image_size=img_size,
    batch_size=batch_size
)

val_ds = image_dataset_from_directory(
    dataset_path,
    validation_split=0.2,
    subset="validation",
    seed=123,
    image_size=img_size,
    batch_size=batch_size
)

# Performansı artırmak için veri setini önbelleğe al ve karıştır
AUTOTUNE = tf.data.AUTOTUNE
train_ds = train_ds.cache().shuffle(1000).prefetch(buffer_size=AUTOTUNE)
val_ds = val_ds.cache().prefetch(buffer_size=AUTOTUNE)
