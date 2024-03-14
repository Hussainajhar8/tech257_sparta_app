# Azure Monitoring and alert management

1. **Monitoring and creating dashboards**

    a. What is worst to best in terms of monitoring and responding to load/traffic?
    
      - The worst way is to manually monitor a dashboard and respond to changes. This approach is prone to missing spikes in traffic and delays in response.
        
      - A better method is to set up Azure monitoring and create alarms on specific metrics. This notifies responsible workers to respond promptly.
        
      - The best way is to automate monitoring with autoscaling. An autoscaling service adjusts resources automatically based on predefined policies and demand.
        
    b. How to setup a dashboard?
    
      - Go to the virtual machine, navigate to monitoring, and pin the desired charts. Azure will prompt to create a dashboard.
      ![alt text](img/image-101.png)
        
      - Access the dashboard by searching for `Dashboard Hub` -> `Overview`. Your created dashboards with charts will be available there.
        
    c. How did a combination of load testing and the dashboard help us?
    
      - Load testing allowed us to visualize CPU usage on the dashboard, helping us identify and respond to spikes in CPU usage if necessary.
        
    d. Screenshot of Dashboard when it stops responding through extreme load testing.
    ![alt text](img/image-102.png)
    
2. **Create CPU Usage Alert**
   
    - Click on one of the charts in the dashboard to create an alert rule. ![alt text](img/image-103.png)
    - Set up the alert to check the average CPU usage for each minute.
    ![alt text](img/image-104.png) 
    - Set up action for when alert is triggered.
    ![alt text](img/image-105.png)
    - Here is a screenshot of the email notification, and the chart.
    ![alt text](img/image-106.png)
    ![alt text](img/image-107.png)

We have successfully, created a dashboard and alert rule.
