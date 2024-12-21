import os
import random

# Klasör yolunu belirtin
folder_path = "C:\\Users\\Metehan Sevgil\\Desktop\\bizim_fotolar"

# Klasördeki tüm dosya adlarını alın
file_list = os.listdir(folder_path)

# Sadece fotoğraf dosyalarını filtreleyin (örn. jpg, png)
image_extensions = ('.jpg', '.jpeg', '.png', '.bmp')
image_files = [f for f in file_list if f.lower().endswith(image_extensions)]

# Sıralamayı karıştırın
random.shuffle(image_files)

# Yeni dosya adlarıyla sıralamayı uygula
for i, old_name in enumerate(image_files, start=1):
    old_path = os.path.join(folder_path, old_name)
    new_name = f"image_{i}{os.path.splitext(old_name)[1]}"  # image_1.jpg gibi
    new_path = os.path.join(folder_path, new_name)
    os.rename(old_path, new_path)

print("Dosyaların sırası başarıyla karıştırıldı!")
