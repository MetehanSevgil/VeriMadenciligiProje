from PIL import Image
import os

# Yeniden boyutlandırılacak boyut
target_size = (256, 256)

# Görsellerin bulunduğu klasör
input_folder = "C:\\Users\\ismke\Belgeler\\VeriMadenciligiProje\\Veriler\\icecekler"
output_folder = input_folder

# Çıkış klasörünü oluştur
os.makedirs(output_folder, exist_ok=True)

for img_name in os.listdir(input_folder):
    img_path = os.path.join(input_folder, img_name)
    try:
        with Image.open(img_path) as img:
            resized_img = img.resize(target_size)
            resized_img.save(os.path.join(output_folder, img_name))
    except Exception as e:
        print(f"Hata oluştu: {img_name} - {e}")
