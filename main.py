import tensorflow as tf
from keras.applications import ResNet50
from keras import layers, models
from keras.utils import image_dataset_from_directory

# Veri seti dizini
dataset_path = "C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\Veriler" # Buraya kendi veri seti dizin yolunuzu yazın

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

# Sınıf isimlerini kontrol et
class_names = train_ds.class_names
print("Sınıflar:", class_names)

# Performansı artırmak için veri setini önbelleğe al ve karıştır
AUTOTUNE = tf.data.AUTOTUNE
train_ds = train_ds.cache().shuffle(1000).prefetch(buffer_size=AUTOTUNE)
val_ds = val_ds.cache().prefetch(buffer_size=AUTOTUNE)

# ResNet'i temel model olarak yükle
base_model = ResNet50(
    weights="imagenet",
    include_top=False,  # Kendi sınıflandırıcımızı ekleyeceğiz
    input_shape=(256, 256, 3)
)

# Temel modeli dondur (önceden eğitilmiş ağırlıklar korunur)
base_model.trainable = False

# Model katmanları
model = models.Sequential([
    base_model,
    layers.GlobalAveragePooling2D(),
    layers.Dense(128, activation='relu'),
    layers.Dropout(0.5),
    layers.Dense(train_ds.cardinality().numpy(), activation='softmax')  # Sınıf sayısına göre ayarla
])

# Modeli derle
model.compile(
    optimizer=tf.keras.optimizers.Adam(),
    loss=tf.keras.losses.SparseCategoricalCrossentropy(),
    metrics=['accuracy']
)

# Modeli eğit
epochs = 5  # Daha fazla eğitim için artırabilirsiniz
history = model.fit(
    train_ds,
    validation_data=val_ds,
    epochs=epochs
)

# Modeli kaydet
model.save("C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\deneme_resnet50_model.keras")