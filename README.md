# 🚀 AI CV Matcher 

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![n8n](https://img.shields.io/badge/n8n-%23FF6B6B.svg?style=for-the-badge&logo=n8n&logoColor=white)
![Gemini AI](https://img.shields.io/badge/Gemini_AI-%238E75B2.svg?style=for-the-badge&logo=googlebard&logoColor=white)

A stateful, AI-powered career assistant built with **Flutter** and **n8n**. This application goes beyond a standard ChatGPT wrapper by utilizing a custom backend workflow to cross-reference user skills against a hidden dataset of job openings, retaining conversational memory across sessions.

---

## 📱 App Preview


### Screenshots
<p align="center">
  <img src="https://github.com/Ismailcyp/Ai-CV-Matcher-Flutter/blob/main/cvanalysis/home.png?raw=true" alt="Home" width="220"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Ismailcyp/Ai-CV-Matcher-Flutter/blob/main/cvanalysis/upload.png?raw=true" alt="UploadCV" width="220"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Ismailcyp/Ai-CV-Matcher-Flutter/blob/main/cvanalysis/jopsmatch.png?raw=true" alt="Jops Match" width="220"/>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Ismailcyp/Ai-CV-Matcher-Flutter/blob/main/cvanalysis/chat&n8n.png?raw=true" alt="Job Match Result" width="220"/>
  </p>

---

## ✨ Features
* **Conversational UI:** A smooth, native Flutter chat interface with custom slide-in route animations and loading state indicators.
* **Stateful Memory:** Uses a persistent Session ID routed through n8n, allowing the AI to remember user names, preferences, and past messages across app restarts.
* **Custom AI Routing:** Powered by Gemini AI, strictly prompted and formatted via n8n to act as a professional tech-recruiter API.
* **Data Retrieval:** The AI cross-references user inputs with a specific, internal dataset of tech jobs and internships to find perfect matches.

## 🛠️ Tech Stack
* **Frontend:** Flutter & Dart
* **Backend Automation:** n8n (Cloud)
* **LLM Engine:** Google Gemini AI
* **API Integration:** Standard HTTP POST webhooks

## 🧠 How the Backend Works (n8n)
The Flutter app sends user messages and a unique `userId` to an n8n Webhook. n8n utilizes a **Window Buffer Memory** node to pull up the user's chat history, combines it with the new message, and feeds it to the **AI Agent**. The Agent queries the provided job dataset, generates a contextual response, and n8n sends the cleaned output back to the Flutter UI.
