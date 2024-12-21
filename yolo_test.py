from ultralytics import YOLO

# Eğitilen modeli yükle
model = YOLO("yolov8n_trained.pt")

# Test görüntüsü üzerinde tahmin yap
results = model(source="test_image.jpg", save=True, conf=0.3)
