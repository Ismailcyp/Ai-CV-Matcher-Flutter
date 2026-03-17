# AI CV Matcher 🚀

A stateful, AI-powered career assistant built with **Flutter** and **n8n**. This application goes beyond a standard ChatGPT wrapper by utilizing a custom backend workflow to cross-reference user skills against a hidden dataset of job openings, retaining conversational memory across sessions.

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
