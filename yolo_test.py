from ultralytics import YOLO

model = YOLO("yolov8n_trained_ensonmodel.pt")

results = model(source="test_image.jpeg", save=True, conf=0.2)
