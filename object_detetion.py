from ultralytics import YOLO

# Modeli yükle
model = YOLO("yolov8n.pt")

# Modeli eğitin
results = model.train(data="data.yaml", epochs=50)

# Modeli kaydet
model.save("yolov8n_trained.pt")
