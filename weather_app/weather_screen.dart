import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:weather_app/additional_information.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart';
import 'package:flutter/material.dart';
import 'weather_icon_mapping.dart';
import 'package:weather_app/hourly_weather_card.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Lahore";
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherKey"));

      final data = jsonDecode(res.body);
      if (data['cod'] != "200") {
        throw data["message"];
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        titleTextStyle:
            const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            style: const ButtonStyle(
              iconColor: WidgetStatePropertyAll(Colors.white),
              iconSize: WidgetStatePropertyAll(40),
            ),
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            // print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final data = snapshot.data!;
            final currentTemp = data["list"][0]["main"]["temp"];
            final currentWeatherText = data["list"][0]["weather"][0]["main"];
            final currentWeatherIcon = data["list"][0]["weather"][0]["icon"];
            final currentHumidity = data["list"][0]["main"]["humidity"];
            final currentWindSpeed = data["list"][3]["wind"]["speed"];
            final currentPressure = data["list"][3]["main"]["pressure"];

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // display card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "$currentTemp K",
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                IconMapping(iconName: currentWeatherIcon),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "$currentWeatherText",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //weather forcast card
                  const Text(
                    "Weather Focrcast",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        final hourlyWeather = data["list"][index + 1];
                        return HourlyWeatherCard(
                          time: hourlyWeather["dt_txt"],
                          icon: IconMapping(
                              iconName: hourlyWeather["weather"][0]["icon"]),
                          temperature: hourlyWeather["main"]["temp"].toString(),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //additional information card
                  const Text(
                    "Additional Information",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInformation(
                        icon: WeatherIcons.humidity,
                        info1: "Humidity",
                        info2: currentHumidity.toString(),
                      ),
                      AdditionalInformation(
                        icon: WeatherIcons.wind,
                        info1: "Wind Speed",
                        info2: currentWindSpeed.toString(),
                      ),
                      AdditionalInformation(
                        icon: WeatherIcons.umbrella,
                        info1: "Pressure",
                        info2: currentPressure.toString(),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
