# TMDb API Application

This is an application that utilizes the TMDb (The Movie Database) API to fetch and display information about movies, TV shows, and other entertainment-related content. The project is built using SwiftUI and follows the MVVM architecture pattern, ensuring clean and maintainable code.

## Screenshots
<img width=200 src="https://github.com/user-attachments/assets/462fdab1-0ab4-4584-b164-1b9c56163270"/>
<img width=200 src="https://github.com/user-attachments/assets/424e6f57-668d-47b1-9630-070c3697ef14"/>
<img width=200 src="https://github.com/user-attachments/assets/988a157b-ebc7-4548-b526-f77d26ce7ddf"/>
<img width=200 src="https://github.com/user-attachments/assets/ad3f84be-ed5a-4f7f-907d-df5027eaedc2"/>

## Features

- **Search Movies and TV Shows**: Search for movies or TV shows by name.
- **Detailed Information**: View detailed information about a specific movie or show, including the synopsis, release date, cast, and ratings.
- **Discover Popular Content**: Browse trending and popular movies or TV shows.
- **Personalized Lists**: Create and manage watchlists or favorites.

## Getting Started

### Prerequisites

- [TMDb API Key](https://www.themoviedb.org/documentation/api): Sign up and generate an API key.
- A Mac with Xcode installed to run and test the application.

### Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/your-username/tmdb-api-app.git
   cd tmdb-api-app
   ```

2. Open the project in Xcode.

3. Create a `Constants.swift` file in the project and add your TMDb API key:

   ```swift
   struct Constants {
       static let apiKey = "your_api_key_here"
   }
   ```

4. Build and run the application:

   - Select your simulator or connected device in Xcode.
   - Press `Cmd + R` to build and run the app.

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Model**: Represents the data and business logic.
- **View**: SwiftUI views that display the data.
- **ViewModel**: Handles the business logic and provides data to the views.

### Dependency Injection

- The services and view models are distributed using a **Factory** pattern, ensuring a single responsibility and reusability across the app.

## Caching

The app includes a lightweight caching mechanism to store and retrieve frequently used data, improving performance and reducing network calls.

## Technologies Used

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM
- **Network**: URLSession
- **Caching**: Custom in-memory caching solution (no third-party libraries used).

## Usage

1. **Search for Movies/TV Shows**:

   - Enter the name of a movie or TV show in the search bar.
   - View a list of matching results with brief details.

2. **View Detailed Information**:

   - Tap on any movie or show to view its detailed information, including:
     - Title
     - Overview
     - Ratings

3. **Discover Popular Content**:

   - Visit the "Trending" section to explore currently popular movies and TV shows.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m 'Add a new feature'`).
4. Push to the branch (`git push origin feature-name`).
5. Open a pull request.

## Acknowledgments

- [TMDb](https://www.themoviedb.org/) for the API.
- The SwiftUI community for inspiration and best practices.
