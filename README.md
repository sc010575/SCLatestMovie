# SCLatestMovie
Latest Movie list and details about movies to watch

## Features
- After launching the application it will make an api call to retrive upcoming movie list
- Movies will show in the assending order of the user voting average
- Select any movies will show the details page where app will cover details like poster image, overview, popularity, movie type(adult/universal) and movie genres.

### Api Links
- https://api.themoviedb.org/3/movie/upcoming?api_key=449d682523802e0ca4f8b06d8dcf629c&language=en-US

### Development Platform
- iOS 12.2 and XCode 10.2.1
- Swift 5

### Swift libraries 
- Quick.Nimble for BDD testing
- GCDWebServer for mock server
- SDWebImage for image download and caching

### Targets
- SCLatestMovie - Main application target
- SCLatestMovieTests - Unit testing target

### Instruction to run
- Download the project from URL or .Zip
- open SCLatestMovie.xcworkspace and run in the simulator
[For simpicity I also include the pod projects so that you should not run the pod install]

### Swift architecture
- The application is build with MVVM-C (Model-View-ViewModel and Coordinator) architecture. Use of coordinator patern for navigation. Therefore viewcontrollers are free from navigation. 
- Universal App that support different layouts for iPhone and iPad in horizental and vertical orientation.

### Code Coverage
- Current code coverage is 84.2%


