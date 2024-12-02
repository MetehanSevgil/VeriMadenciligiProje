import os
import numpy as np
from PIL import Image

def random_crop(image, crop_percentage_min=0.2, crop_percentage_max=0.3):
    """
    Görüntüyü kenarlardan rastgele bir yüzdeyle kırpar.
    :param image: Orijinal görüntü (numpy array veya PIL Image)
    :param crop_percentage_min: Kenarları kırpma oranının minimum değeri
    :param crop_percentage_max: Kenarları kırpma oranının maksimum değeri
    :return: Kırpılmış görüntü
    """
    if isinstance(image, Image.Image):  # Eğer görüntü PIL formatındaysa numpy'a çevir
        image = np.array(image)
    
    height, width, _ = image.shape
    
    # Kırpma oranını rastgele seç
    crop_percentage = np.random.uniform(crop_percentage_min, crop_percentage_max)
    
    crop_width = int(width * crop_percentage)
    crop_height = int(height * crop_percentage)
    
    # Rastgele kırpma koordinatları
    start_x = np.random.randint(0, crop_width + 1)
    start_y = np.random.randint(0, crop_height + 1)
    end_x = width - np.random.randint(0, crop_width + 1)
    end_y = height - np.random.randint(0, crop_height + 1)
    
    # Görüntüyü kırpma
    cropped_image = image[start_y:end_y, start_x:end_x, :]
    return cropped_image

# Giriş ve çıkış klasörlerini belirleyin
input_folder = "C:\\Users\\Metehan Sevgil\\Desktop\\yemekler\\Yan_Yemekler\\SU BÖREĞİ"  # İşlenecek görüntülerin klasörü
output_folder = input_folder   # Çıkış görüntülerinin kaydedileceği klasör

os.makedirs(output_folder, exist_ok=True)  # Çıkış klasörü yoksa oluştur

# Tüm görüntüleri döngüyle işleme
for filename in os.listdir(input_folder):
    if filename.endswith(('.jpg', '.jpeg', '.png')):  # Sadece resim dosyalarını işleme
        image_path = os.path.join(input_folder, filename)
        original_image = Image.open(image_path)
        
        # 9 varyasyon oluşturma
        base_name, ext = os.path.splitext(filename)  # Dosya adını ve uzantısını ayır
        for i in range(1, 10):  # 9 farklı kırpma için döngü
            cropped_image = random_crop(original_image, crop_percentage_min=0.15, crop_percentage_max=0.35)
            
            # Yeni dosya adı oluşturma
            output_filename = f"{base_name}_aug{i}{ext}"  # Örneğin, doner1_aug1.jpg
            output_path = os.path.join(output_folder, output_filename)
            
            # Görüntüyü kaydet
            cropped_image_pil = Image.fromarray(cropped_image)
            cropped_image_pil.save(output_path)

print("Tüm görüntüler başarıyla işlendi ve kaydedildi!")
