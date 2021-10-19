# ProximityTest
Project for the air quality monitoring using MVVM in Swift for internal purpose.


### Cities List View
![Simulator Screen Shot - iPhone 12 Pro Max - 2021-10-20 at 00 27 00](https://user-images.githubusercontent.com/17081093/137970737-8dc18b15-15a2-4a28-b7a0-8fa3ff73c0ab.png)

### Realtime Graph View
![Simulator Screen Shot - iPhone 12 Pro Max - 2021-10-20 at 00 30 29](https://user-images.githubusercontent.com/17081093/137971300-bc48ddb9-32d0-43a1-95cb-b88a5349aca7.png)
# Details

#### MVVM
Used MVVM design pattern.

#### WebSocket
- Subscribe to websocket `ws://city-ws.herokuapp.com` to receive Air Quality Indices for the Cities.
- Pod: `Starscream` => https://github.com/daltoniam/Starscream

#### Realtime Graph
- Show the realtime graph for the City AQI (Air Quality Index) Data.
- Pod: `Charts` => https://github.com/danielgindi/Charts


- Model: is used as data source. i.e. AirQualityResposne, CityModelData, AirQualityModel
- View: has ability to show list. i.e. AirQualityCityListCell
- ViewModel: has all the logic and a mediator between `View` & `Model`. i.e. AirQualityIndexListViewModel, AirQualityIndexListDetailViewModel
- ViewController: AirQualityCityListVC, AirQualityIndexGraphVC


#### Unit/UI tests
- Added Unit and UI Tests using `XCTest`.

