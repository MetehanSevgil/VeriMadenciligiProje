from ultralytics import YOLO
import cv2
import matplotlib.pyplot as plt

# Eğitilen modeli yükle
model = YOLO("yolov8n_trained.pt")

# Test görüntüsü üzerinde tahmin yap
results = model(source="test_image.jpg", show=True, save=True, conf=0.05)

