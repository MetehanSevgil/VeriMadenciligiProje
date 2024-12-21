from ultralytics import YOLO

# Modeli yükle
model = YOLO("yolov8n.pt")

# Modeli eğitin
results = model.train(data="data.yaml", epochs=20, batch_size=64)

# Modeli kaydet
model.save("yolov8n_trained.pt")
