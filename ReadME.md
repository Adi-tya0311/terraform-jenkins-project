<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:7B42BC,50:FF9900,100:D24939&height=220&section=header&text=Terraform%20%E2%9A%A1%20Jenkins%20CI%2FCD&fontSize=44&fontColor=ffffff&animation=fadeIn&fontAlignY=36&desc=Git%20push%20%E2%86%92%20SonarQube%20%E2%86%92%20Docker%20%E2%86%92%20ECR%20%E2%86%92%20Live%20on%20AWS&descSize=17&descAlignY=58" alt="header" width="100%"/>

### Push code. Watch it ship. Zero manual steps.

<p>
  <img src="https://img.shields.io/badge/Terraform-IaC-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins&logoColor=white" />
  <img src="https://img.shields.io/badge/AWS-EC2%20%7C%20ECR-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white" />
  <img src="https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
</p>
<p>
  <img src="https://img.shields.io/badge/SonarQube-Code%20Quality-4E9BCD?style=for-the-badge&logo=sonarqube&logoColor=white" />
  <img src="https://img.shields.io/badge/Nginx-Web%20Server-009639?style=for-the-badge&logo=nginx&logoColor=white" />
  <img src="https://img.shields.io/badge/Amazon%20Linux-2023-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white" />
  <img src="https://img.shields.io/badge/GitHub-Webhook-181717?style=for-the-badge&logo=github&logoColor=white" />
</p>

</div>

---

## ⚡ The Idea

A complete **DevOps pipeline** that takes code from a `git push` to a **live Docker container on AWS**, fully automated.
**Terraform** builds the infrastructure. **Jenkins** runs the show.

<div align="center">

```
 💻 Push  ➜  🔔 Webhook  ➜  🧪 SonarQube  ➜  🐳 Build  ➜  📦 ECR  ➜  ✅ Verify  ➜  🚀 Deploy
```

</div>

---

## 🏗️ Architecture

```mermaid
flowchart LR
    A([👨‍💻 Developer]) -- git push --> B[(GitHub)]
    B -- Webhook --> C{{Jenkins}}
    C --> D[SonarQube<br/>Code Quality]
    C --> E[Docker Build]
    E --> F[(Amazon ECR)]
    F -- verify --> G[EC2<br/>Docker + Nginx]
    G --> H([🌐 Live Website])

    style A fill:#7B42BC,color:#fff,stroke:none
    style B fill:#181717,color:#fff,stroke:none
    style C fill:#D24939,color:#fff,stroke:none
    style D fill:#4E9BCD,color:#fff,stroke:none
    style E fill:#2496ED,color:#fff,stroke:none
    style F fill:#FF9900,color:#fff,stroke:none
    style G fill:#232F3E,color:#fff,stroke:none
    style H fill:#009639,color:#fff,stroke:none
```

---

## 🔄 Pipeline Stages

| # | Stage | What happens |
|:-:|---|---|
| 1️⃣ | **Checkout** | Pulls the latest code from GitHub |
| 2️⃣ | **Verify Files** | Confirms required project files exist |
| 3️⃣ | **SonarQube Analysis** | Automated code-quality scan |
| 4️⃣ | **Build Image** | Builds the Docker image |
| 5️⃣ | **Login to ECR** | Authenticates with Amazon ECR |
| 6️⃣ | **Tag & Push** | Ships the image to the registry |
| 7️⃣ | **Verify ECR Image** | Checks the image really landed |
| 8️⃣ | **Deploy** | Replaces the old container with the new one |

---

## 🧰 Tech Stack

<div align="center">

<img src="https://skillicons.dev/icons?i=terraform,jenkins,aws,docker,nginx,github,linux,bash,html,css,js&perline=11" />

</div>

---

## ☁️ Infrastructure (Terraform)

Everything on AWS is created with code. No console clicking.

```bash
terraform init      # 🔧 set up providers
terraform plan      # 👀 preview changes
terraform apply     # 🚀 build the infrastructure
terraform destroy   # 💣 tear it all down
```

**Provisions:** EC2 instance · Security Group · Key Pair

| Port | Service |
|:-:|---|
| `22` | 🔑 SSH |
| `80` | 🌐 Application |
| `8080` | 🛠️ Jenkins |
| `9000` | 🔍 SonarQube |

---

## 🐳 Run It Locally

```bash
docker build -t devops-portfolio .
docker run -d --name devops-app -p 80:80 devops-portfolio
```

Then open **http://localhost** 🎉

---

## 📁 Project Structure

```text
terraform-jenkins-project/
├── main.tf                    # AWS resources
├── variables.tf               # Configurable values
├── outputs.tf                 # Terraform outputs
├── Dockerfile                 # Nginx container
├── Jenkinsfile                # CI/CD pipeline
├── sonar-project.properties   # SonarQube config
└── index.html                 # The app
```

---

## 🔐 Security

Secrets like the **SonarQube token** and **AWS credentials** live in **Jenkins Credentials Manager**. They are never committed to the repo.

---

## 🗺️ Roadmap

- [ ] 🔒 HTTPS with SSL/TLS + custom domain
- [ ] 🏷️ Docker image versioning + ECR lifecycle policies
- [ ] 📈 Prometheus + Grafana monitoring
- [ ] 🔁 Blue/green or rolling deployments
- [ ] ☸️ Kubernetes deployment

---

<div align="center">

### 💡 Why I built this

Instead of learning DevOps tools one by one, I wired them into **one real workflow**,<br/>
to understand exactly what happens between `git push` and *"it's live."*

<br/>

**Built by [Adi-tya0311](https://github.com/Adi-tya0311)**

⭐ If you found this useful, drop a star!

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:D24939,50:FF9900,100:7B42BC&height=120&section=footer" width="100%"/>

</div>