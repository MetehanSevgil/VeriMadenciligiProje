import os
import shutil
from sklearn.model_selection import train_test_split

def split_data_no_labels(dataset_dir, output_dir, train_ratio=0.7, test_ratio=0.17, val_ratio=0.13):
    # Klasörlerin oluşturulması
    train_dir = os.path.join(output_dir, "train", "images")
    test_dir = os.path.join(output_dir, "test", "images")
    val_dir = os.path.join(output_dir, "val", "images")

    for split_dir in [train_dir, test_dir, val_dir]:
        os.makedirs(split_dir, exist_ok=True)

    # Sınıf klasörlerini işleme
    for class_name in os.listdir(dataset_dir):
        class_dir = os.path.join(dataset_dir, class_name)
        if not os.path.isdir(class_dir):
            continue

        images = [f for f in os.listdir(class_dir) if f.endswith(".jpg")]

        # Eğitim, test ve doğrulama oranlarına göre bölme
        train_images, temp_images = train_test_split(images, test_size=(1 - train_ratio), random_state=42)
        test_images, val_images = train_test_split(temp_images, test_size=val_ratio / (test_ratio + val_ratio), random_state=42)

        # Dosyaları ilgili klasörlere taşı
        for img in train_images:
            shutil.copy(os.path.join(class_dir, img), os.path.join(train_dir, f"{class_name}_{img}"))

        for img in test_images:
            shutil.copy(os.path.join(class_dir, img), os.path.join(test_dir, f"{class_name}_{img}"))

        for img in val_images:
            shutil.copy(os.path.join(class_dir, img), os.path.join(val_dir, f"{class_name}_{img}"))

    print(f"Veri seti {output_dir} klasörüne başarıyla bölündü!")
    print(f"Eğitim oranı: %{train_ratio * 100}, Test oranı: %{test_ratio * 100}, Doğrulama oranı: %{val_ratio * 100}")

# Ana klasör yollarını belirleyin
DATASET_DIR = "C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\Veriler"  # Orijinal veri klasörü
OUTPUT_DIR = "C:\\Users\\Metehan Sevgil\\Desktop\\VeriMadenciligiProje\\Veriler_Split"  # Bölünmüş veri klasörü

# Veriyi böl
split_data_no_labels(DATASET_DIR, OUTPUT_DIR, train_ratio=0.7, test_ratio=0.17, val_ratio=0.13)
