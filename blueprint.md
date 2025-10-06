# Padosi: Your Hyper-Local Social Network

## Overview

Padosi is a next-generation social app designed to foster real-world connections within your neighborhood. The app prioritizes utility and immediate needs, allowing users to connect with verified neighbors within a 1 KM radius.

## Key Features

*   **Real-Time Utility:** Post urgent "Needs," "Offers," and "Now-Events" that are prominently displayed in the local feed.
*   **Flexible Posting:** Users have full control over their posts, which do not auto-delete.
*   **Full Social Profile:** Instagram-style profiles with ratings and a history of helpfulness.
*   **Follow & Chat:** Follow trusted neighbors and engage in secure, direct conversations.
*   **Modern UI:** A beautiful and intuitive user interface built with Flutter and Material Design 3.
*   **Responsive Design:** The app will be responsive and work seamlessly on both mobile and web.

## Development Plan

### Iteration 1: Core Structure and UI

1.  **Project Setup:**
    *   Add necessary dependencies: `google_fonts`, `provider`, and `go_router`.
    *   Configure the main theme, including color schemes and typography.
2.  **Directory Structure:**
    *   Create a scalable project structure with folders for screens, widgets, services, and models.
3.  **Basic UI and Navigation:**
    *   Implement a bottom navigation bar for easy access to the main sections of the app (Home, Needs, Offers, Profile).
    *   Set up `go_router` for declarative navigation.
    *   Create placeholder screens for each section.

### Iteration 2: Feed and Posting

1.  **Feed UI:**
    *   Design and build the main feed to display "Needs," "Offers," and "Now-Events."
    *   Create custom widgets for feed items.
2.  **Posting Functionality:**
    *   Implement a "create post" screen where users can select the type of post (Need, Offer, Now-Event) and add content.
    *   Develop the logic to handle post creation and display it in the feed.

### Iteration 3: User Profiles

1.  **Profile Screen:**
    *   Create the user profile screen, displaying user information, ratings, and a history of their posts.
    *   Implement a "follow" button.
2.  **Profile Editing:**
    *   Allow users to edit their profile information.

### Iteration 4: Chat

1.  **Chat UI:**
    *   Design and build the chat interface for direct messaging between users.
2.  **Chat Logic:**
    *   Implement the logic for sending and receiving messages.
    *   Ensure that chat is only available between users who follow each other.

### Iteration 5: Backend Integration (Future)

1.  **Firebase Setup:**
    *   Integrate Firebase for authentication, Firestore database, and storage.
2.  **User Authentication:**
    *   Implement user registration and login.
3.  **Data Persistence:**
    *   Store user data, posts, and chats in Firestore.
