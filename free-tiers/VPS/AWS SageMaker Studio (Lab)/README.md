- #### [SageMaker Studio Lab <sub><img src="https://github.com/Azathothas/BugGPT-Tools/assets/58171889/0eacb57a-972e-41fd-ae58-e0bccb8c42e9"  width="30" height="30"> </sub>](https://studiolab.sagemaker.aws)
> - [**BenchMarks**]()
> - [**About**]()
> - [**Setup**]()
> - [**Configuration**]()
> - [**SSH**]()
> - [**RDP**]()
---

> - #### About: [<img src="https://github.com/Azathothas/BugGPT-Tools/assets/58171889/7737d632-1cf6-46a0-8b3a-644482b9022d" width="30" height="30">**Intro** & **Setup**](https://www.youtube.com/watch?v=g0xu9DA4gDw)
> [![Google Colab Tutorial for Beginners](https://img.youtube.com/vi/SP-WBt2b54o/maxresdefault.jpg)](https://www.youtube.com/watch?v=SP-WBt2b54o)
> 
> > ➼ [**Limits**](https://studiolab.sagemaker.aws/faqhttps://studiolab.sagemaker.aws/faq)
> >
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/183cbae2-4388-4b76-96ad-0db9d7692cba)
> > 
> > ```yaml
> > Quota                           : Unlimited # You can just reset & run again 
> > Interactive Session Limit       : 12 Hr (CPU Only,  [Auto Terminates] 
> > Non Interactive Session Limit   : 12 Hr [Auto Terminates] 
> > ```
> > ➼ **Specs**
> > 1. **No `Credit Card`** || **No `Free Trial`**
> > 
> > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/204e2fee-1e1d-41e5-9f54-b14a5ca22641)
> > 
> > > ```YAML
> > > CPU                  : 4 Cores (Intel) ~ 2.5 GHZ # Amazon EC2 t3.xlarge : https://aws.amazon.com/ec2/instance-types/t3/
> > > GPU                  : Tesla T4 (~ 16 GB | If Lucky) # Not Always Available (If Really unlucky)
> > > RAM                  : 16 GB
> > > Init                 : supervisord JupyterLab  # NOT Privileged (ps -p 1 -o comm=)
> > > Storage (Temp)       : ~ 50 GB # May Vary based on Availability
> > >   Usable             : ~ 30 GB # Allocated through different Partitions
> > >   Persistent         : ~ 15 GB 
> > > Networking           : Limited
> > >   IPv4               : Yes
> > >   IPv6               : No
> > >   Benchmarks         : See #Benchmarks Below
> > > Cron                 : ? # 
> > > ROOTED               : NO # Extremely Locked 
> > > ```
> > > - **GPU**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/1220ecd7-ed92-43d7-96e5-117578b21b40)
> > >
> > > - **Storage**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/bc0537f3-d1c0-459e-8f6c-3b3892a33d95)
> > > 
----
> - #### Setup:
> > 1. **Request an Account** & **Join `Waitlist`** : https://studiolab.sagemaker.aws/requestAccount
> > > - **AWS will Verify** & **Approve the request within** **`~ 7 Days`**
> > > - **After your account is verified**, **`Login`**
> > 2. **Right Click** >> **Open Link In New Tab** : <a href="https://studiolab.sagemaker.aws/import/github/Azathothas/BugGPT-Tools/blob/main/free-tiers/VPS/AWS%20SageMaker%20Studio%20(Lab)/SageMaker.ipynb" target="_parent"><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/58171889/244918231-056e22a6-a19a-4850-b5e6-c94c52472fac.svg" alt="Open In SageMaker"/></a>
> > 3. **`Start Runtime`** >> **WAIT** >> **`Copy To Project`** >> **`Copy Notebook Only`**
> > 4. **RUN** & **Follow Instructions**
> > > ---
> > > https://github.com/Azathothas/BugGPT-Tools/assets/58171889/da5efda1-9164-4699-877f-70d24e52de97
> > > 
> > > ---
---



> > >
---
> - **References**
> > - Main Update & Issue Page : https://github.com/aws/studio-lab-examples/issues
> > - Intro & Setup : https://www.missioncloud.com/blog/amazon-sagemaker-studio-tutorial
> > - https://thenewstack.io/amazon-sagemaker-studio-lab-from-the-eyes-of-an-mlops-engineer/
> > - Architecture & Infra : https://dataintegration.info/dive-deep-into-amazon-sagemaker-studio-notebooks-architecture
> > - https://thenewstack.io/amazon-sagemaker-studio-lab-from-the-eyes-of-an-mlops-engineer/
> > - https://www.reddit.com/r/aws/comments/10vpgwf/sagemaker_studio_system_terminal_resource_cost/
> > - No root access 2023/02/04: https://github.com/aws/studio-lab-examples/issues/198#issuecomment-1416420060
> > - VPC workaround for SSH : https://github.com/ruslanmv/How-to-connect-via-ssh-to-SageMaker

- [![Kaggle](https://kaggle.com/static/images/open-in-kaggle.svg)](https://kaggle.com/kernels/welcome?src=https://github.com/roboflow-ai/notebooks/blob/main/notebooks/train-yolov8-object-detection-on-custom-dataset.ipynb) 
