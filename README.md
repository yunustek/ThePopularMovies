# ThePopularMovies
The Popular Movies iOS App

## What the app is about
This app is a simple drop down list application that gives you the ability to browse through movies and read the detail or view your favorites using https://www.themoviedb.org's REST API.

## About Code
This project is written using Swift 5 and MVVM architectural and consists of Network, Json Models, Infrastructure, Base Classes, Controllers and ViewModels. Data such as apiKey and apiUrl are stored on XCConfig and matched with targets. Local save operations are saved by writing an encodable sequence on UserDefaults. Api mapping was done with swift Codable, api unit test cases were written and no framework was used in the project.
