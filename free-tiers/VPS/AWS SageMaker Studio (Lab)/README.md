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
> > Interactive Session Limit       : 12 Hr [Auto Terminates and Loses Persistance] # Interactive = You continously use the Shell Environment
> > Non Interactive Session Limit   : 20Mins ~ 1 Hr [Auto Terminates and Loses Persistance] # Non Interactive = You do nothing & Shell Environment is Idle
> > ```
> > ➼ **Specs**
> > 1. **No `Credit Card`** || **No `Free Trial`**
> > 
> > > ```YAML
> > > CPU                  : 2 Cores (Intel / AMD) ~ 2 GHZ
> > > GPU                  : Tesla T4 (~ 16 GB | If Lucky) /K80 (~ 12 GB If Unlucky) | tGPU  # Not Always Available (If Really unlucky): https://www.kaggle.com/general/251969
> > > RAM                  : 12 GB
> > > Init                 : docker-init # NOT Privileged (ps -p 1 -o comm=)
> > > Storage (Temp)       : ~ 150 GB # Everything is purged & deleted 
> > >   Usable             : ~ 80-90 GB # Allocated through different Partitions
> > > Networking           : Limited
> > >   IPv4               : Yes
> > >   IPv6               : No
> > >   Benchmarks         : See #Benchmarks Below
> > > Cron                 : Yes # Limited to the 12Hr Window ofc
> > > ```
> > > - **GPU**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/feb06f9e-db8f-4b1b-8b78-6b7fab0af049)
> > >
> > > - **Storage**
> > > 
> > > ![image](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/9f1b634f-47d3-413c-bbd6-9f22e0be97e9)
> > > 
----
> - #### Setup:
> > 1. **Request an Account** & **Join `Waitlist`** : https://studiolab.sagemaker.aws/requestAccount
> > > - **AWS will Verify** & **Approve the request within** **`~ 7 Days`**





- [![Kaggle](https://kaggle.com/static/images/open-in-kaggle.svg)](https://kaggle.com/kernels/welcome?src=https://github.com/roboflow-ai/notebooks/blob/main/notebooks/train-yolov8-object-detection-on-custom-dataset.ipynb) 

- [![SageMaker](https://github.com/Azathothas/BugGPT-Tools/assets/58171889/056e22a6-a19a-4850-b5e6-c94c52472fac)](https://studiolab.sagemaker.aws/import/github/roboflow-ai/notebooks/blob/main/notebooks/train-yolov8-object-detection-on-custom-dataset.ipynb)

---
> - **References**
> > - Main Update & Issue Page : https://github.com/aws/studio-lab-examples/issues
> > - Intro & Setup : https://www.missioncloud.com/blog/amazon-sagemaker-studio-tutorial
> > -               : https://thenewstack.io/amazon-sagemaker-studio-lab-from-the-eyes-of-an-mlops-engineer/
> > - Architecture & Infra : https://dataintegration.info/dive-deep-into-amazon-sagemaker-studio-notebooks-architecture
> > - https://thenewstack.io/amazon-sagemaker-studio-lab-from-the-eyes-of-an-mlops-engineer/
> > - https://www.reddit.com/r/aws/comments/10vpgwf/sagemaker_studio_system_terminal_resource_cost/
> > - No root access 2023/02/04: https://github.com/aws/studio-lab-examples/issues/198#issuecomment-1416420060
> > - VPC workaround for SSH : https://github.com/ruslanmv/How-to-connect-via-ssh-to-SageMaker
