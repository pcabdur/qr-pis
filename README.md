<div align="center">

# 🛡️ QR-PIS
### AI-Powered QR Phishing Intelligence System

Detect malicious QR codes before they become phishing attacks.

![Python](https://img.shields.io/badge/Python-3.12-blue?style=for-the-badge&logo=python)
![Flask](https://img.shields.io/badge/Flask-REST_API-black?style=for-the-badge&logo=flask)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazonaws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![Scikit Learn](https://img.shields.io/badge/Scikit--Learn-ML-F7931E?style=for-the-badge&logo=scikitlearn)
![License](https://img.shields.io/badge/License-MIT-success?style=for-the-badge)

</div>

---

# 📖 Overview

QR-PIS (QR Phishing Intelligence System) is an AI-powered phishing detection platform that analyzes URLs extracted from QR codes and predicts whether they are **Safe** or **Phishing**.

The project combines Machine Learning, QR image processing, Flask REST APIs, and AWS cloud infrastructure to demonstrate how phishing attacks can be detected before users visit malicious websites.

Instead of relying on static blacklists, QR-PIS extracts URL characteristics, generates meaningful features, and performs intelligent classification using a trained Random Forest model.

---

# ✨ Features

- 📷 Scan QR Codes from Images
- 🔍 Extract Embedded URLs
- 🤖 AI-powered Phishing Detection
- ⚡ Real-time Prediction API
- ☁ AWS Infrastructure using Terraform
- 🔐 Secure Cloud Storage
- 📊 Model Performance Metrics
- 📦 Infrastructure as Code
- 🎯 Random Forest Classification

---

# 🏗 System Architecture

```

User Uploads QR Image
│
▼
QR Scanner (JavaScript + jsQR)
│
▼
Extract URL
│
▼
Flask REST API
│
▼
Feature Engineering
│
▼
Random Forest Model
│
▼
Prediction
│
▼
Safe ✅ / Phishing 🚨

```

---

# 🧠 Machine Learning Pipeline

The model follows an end-to-end machine learning workflow.

### Data Processing

- Dataset Cleaning
- URL Labeling
- Feature Extraction
- Feature Engineering

### Features Used

- URL Length
- Number of Hyphens
- Dot Count
- Slash Count
- Domain Length
- HTTPS Presence

### Model

Random Forest Classifier

### Evaluation

- Accuracy
- Precision
- Recall
- F1 Score

---

# ☁ AWS Infrastructure

Infrastructure is provisioned using Terraform.

Services used:

| Service | Purpose |
|----------|----------|
| Amazon S3 | Store application assets |
| AWS Lambda | Serverless prediction service |
| DynamoDB | Store scan results |
| IAM | Secure permissions |
| CloudWatch | Monitoring & Logs |

---

# 🖥 Frontend

Built using

- HTML5
- CSS3
- JavaScript
- jsQR

Features

- Upload QR Images
- Live QR Decoding
- Display Extracted URL
- Display AI Prediction

---

# ⚙ Backend

Built with

- Python
- Flask
- Scikit-Learn
- Pandas
- Joblib

Responsibilities

- API Endpoints
- Model Loading
- URL Feature Extraction
- Prediction
- Confidence Score

---

# 📂 Project Structure

```

QR-PIS
│
├── app/
│ ├── index.html
│
├── src/
│ ├── preprocess.py
│ ├── train.py
│ ├── predict.py
│
├── main.py
├── main.tf
└── README.md

```

---

# 🚀 Getting Started

## Clone Repository

```bash
git clone https://github.com/pcabdur/qr-pis.git
```

Install Dependencies

```bash
pip install -r requirements.txt
```

Run

```bash
python main.py
```

Start Flask

```bash
python app.py
```

---

# 🎯 Future Improvements

- Live Camera QR Scanning
- Deep Learning Detection
- Browser Extension
- Mobile App
- Explainable AI (XAI)
- Risk Score
- Dashboard
- QR History
- Multi-language Support
- Docker Deployment

---

# 📸 Screenshots

```

Add screenshots here

```

---

# 📈 Roadmap

- [x] QR Image Processing
- [x] URL Feature Engineering
- [x] ML Model Training
- [x] Flask API
- [x] AWS Infrastructure
- [ ] Docker Deployment
- [ ] CI/CD
- [ ] Explainable AI
- [ ] Mobile Version

---

# 👨‍💻 Tech Stack

Python • Flask • Scikit-Learn • Pandas • HTML • CSS • JavaScript • Terraform • AWS • DynamoDB • Lambda • CloudWatch • S3

---

# ⭐ Why this Project?

QR phishing attacks are becoming increasingly common because users often trust QR codes without verifying the destination.

QR-PIS demonstrates how Machine Learning and Cloud Computing can work together to proactively detect suspicious URLs before users interact with them, helping improve digital security and awareness.

---

<div align="center">

Made with ❤️ by Abdur Rahman

If you found this project interesting,
⭐ Star the repository!

</div>
