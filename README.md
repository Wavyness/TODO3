# TODO3: A Task Management App ✅
The TODO3 App is a simple and intuitive application designed to help you **manage your daily tasks** effectively across multiple devices with the help of a self-hosted Database. With features like task creation, editing, and deletion, it ensures that you stay organized. TODO3 comes with **its own API for a self-hosted database**: [TODO3-API](https://github.com/Wavyness/TODO3-API). This App is inspired by [Things3](https://culturedcode.com/things/).

TODO3 is made to proof certain capabilities:
- Easy adjustment to new programming language
- Building a DB with API endpoints
- Building and connecting an App with a DB

## Showcase 📸
![todo3-mockups](https://github.com/user-attachments/assets/2cf0729c-c00c-48f8-8e9c-894b6c9339e4)

## Dependencies 🔗
This App can only be ran on MacOS or iOS. Furthermore you need:

- XCode and Simulator [[here](https://developer.apple.com/documentation/safari-developer-tools/installing-xcode-and-simulators)]
- Docker [[here](https://docs.docker.com/desktop/install/mac-install/)]
- TODO3-API [[here](https://github.com/Wavyness/TODO3-API)]
- Ngrok (optional) [[here](https://ngrok.com)]

## Install Guide 📖
1. Install XCode and an iOS Simulator of choice
2. Install Docker and have it active.
3. Clone the TODO3 and TODO3-API repository on your machine
   
### Starting the App
1. Start the TODO3-API
   - CD in TODO3-API folder
   - Start DB and its API with
   ```docker-compose up --build```
2. Build and start TODO3 on Simulator (with XCode)

### Optional: Use TODO3 beyond your local network
Alternatively, you could install the app on your own iPhone and access the database remotely with the help of `ngrok`. ngrok is an all-in-one API gateway, Kubernetes Ingress, DDoS protection, firewall, and global load balancing as a service. To use ngrok you need an account which comes with a token to use ngrok. Steps to use ngrok and access TODO3 remotely.
1. Install ngrok
```
brew install ngrok/ngrok/ngrok
```
2. Enter your token from your ngrok account
3. Make an exposed API gateway
```
ngrok http 8080
```
4. Visit file `TODO3/Utilities/Constants.swift`
5. Change the `baseURL` to the `Forwarding URL` seen received from ngrok
   - Make sure the URL ends with `/`
6. [Start the app](#starting-the-app)

#### Thank you for investing your time in my app. Have a nice day! ~Dimitri
