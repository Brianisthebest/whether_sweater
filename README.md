# Whether, Sweater?

## Learning Goals
- How to consume the Mapquest API with a given location in order to get the latitude and longitude of the location to send to the Weather API to then get the data of the current weather, daily weather for the next five days, and the hourly weather for the current day.
- Build an API endpoint for user registration/creation based on email, password, and password confirmation and creating an API for each user on creation.
- Build and endpoint for session creation for a user when logging in based on email being an email stored in the database and is password is correctly authenticated by that users email.
- Consume the Mapquest API for directions from one place to another to then provide data on the start city, end city, travel time between both locations, and the weather in the end city at the time of arrival.

## How to use
- Fork this repo
- Clone your fork
- From your command line, install gems and setup your database:
```
bundle install
rails db:{drop,create,migrate,seed}
```

## API Keys needed
- [Mapquest](https://developer.mapquest.com/documentation/)
- [Weather](https://www.weatherapi.com/)

## Endpoints

### ` GET '/api/v0/forecast' `
**Parameters**
| **Name** | **Description** |
| ----------- | ----------- |
| location, string(query)  | The city and state. ex, 'colorado springs, co' | 

**Responses**
| Code | Description |
| ----------- | ----------- |
| 200 | A forecast for that city |

*Example*
```
{
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2023-06-12 16:30",
                "temperature": 54.0,
                "feels_like": 51.4,
                "humidity": 64,
                "uvi": 5.0,
                "visibility": 9.0,
                "condition": "Partly cloudy",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
            },
            "daily_weather": [
                {
                    "date": "2023-06-12",
                    "sunrise": "05:34 AM",
                    "sunset": "08:25 PM",
                    "max_temp": 68.2,
                    "min_temp": 45.9,
                    "condition": "Moderate rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png"
                },
                {
                    "date": "2023-06-13",
                    "sunrise": "05:34 AM",
                    "sunset": "08:25 PM",
                    "max_temp": 60.3,
                    "min_temp": 44.2,
                    "condition": "Moderate rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png"
                },
              ...
            ],
            "hourly_weather": [
                {
                    "time": "00:00",
                    "temperature": 50.9,
                    "conditions": "Mist",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/143.png"
                },
                {
                    "time": "01:00",
                    "temperature": 48.4,
                    "conditions": "Mist",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/143.png"
                },
               ...
            ]
        }
    }
}
```

### ` POST /api/v0/users `
**Parameters**
| **Name** | **Description** |
| ----------- | ----------- |
| **user details**, *required*(body)  | example request body | 

*Example*
```
{"user":
    {
    "email": "whatever123@example.com",
    "password": "password",
    "password_confirmation": "password"
    }
}
```

**Responses**
| Code | Description |
| ----------- | ----------- |
| 201 | The user was created successfully. |

*Example*
```
{
    "data": {
        "id": "2",
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "900665e0ff9530d89ac23e4e338eeb19"
        }
    }
}
```

### ` POST /api/v0/sessions `
**Parameters**
| **Name** | **Description** |
| ----------- | ----------- |
| **session details**, *required*(body)  | example request body | 

*Example*
```
{"session": 
    {
    "email": "whatever@example.com",
    "password": "password"
    }
}
```

**Responses**
| Code | Description |
| ----------- | ----------- |
| 201 | The session was created successfully. |

*Example*
```
{
    "data": {
        "id": "2",
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "900665e0ff9530d89ac23e4e338eeb19"
        }
    }
}
```

### ` POST /api/v0/road_trip `
**Parameters**
| **Name** | **Description** |
| ----------- | ----------- |
| **road trip details**, *required*(body)  | example request body | 

*Example*
```
{"road_trip": 
    {
    "origin": "new york, ny",
    "destination": "los angeles, ca",
    "api_key": "thisisanapikey"
    }
}
```

**Responses**
| Code | Description |
| ----------- | ----------- |
| 201 | The road trip was created successfully. |

*Example*
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "new york, ny",
            "end_city": "los angeles, ca",
            "travel_time": "39:19:27",
            "weather_at_eta": {
                "datetime": "2023-06-14 09:00",
                "temperature": 66.0,
                "conditions": "Partly cloudy"
            }
        }
    }
}
```