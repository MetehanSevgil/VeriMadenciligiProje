from ultralytics import YOLO

model = YOLO("yolov8n.pt")

results = model.train(data="data.yaml", epochs=50, batch=32)

model.save("yolov8n_trained_ensonmodel.pt")
