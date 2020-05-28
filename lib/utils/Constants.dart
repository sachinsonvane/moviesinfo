
class Constants{

  final String BASE_URL = "http://www.omdbapi.com";
  final String API_KEY = "95d3a066";

  final NETWORK_TITLE_MSG = "Network";
  final NETWORK_DESC_MSG = "Server request failed.";
  final LOGIN_FAILED_MSG = "Login failed.";

// http://www.omdbapi.com/
  // http://www.omdbapi.com/?i=tt3896198&apikey=95d3a066

  /*

  {"Title":"Guardians of the Galaxy Vol. 2","Year":"2017","Rated":"PG-13","Released":"05 May 2017","Runtime":"136 min","Genre":"Action, Adventure, Comedy, Sci-Fi","Director":"James Gunn","Writer":"James Gunn, Dan Abnett (based on the Marvel comics by), Andy Lanning (based on the Marvel comics by), Steve Englehart (Star-Lord created by), Steve Gan (Star-Lord created by), Jim Starlin (Gamora and Drax created by), Stan Lee (Groot created by), Larry Lieber (Groot created by), Jack Kirby (Groot created by), Bill Mantlo (Rocket Raccoon created by), Keith Giffen (Rocket Raccoon created by), Steve Gerber (Howard the Duck created by), Val Mayerik (Howard the Duck created by)","Actors":"Chris Pratt, Zoe Saldana, Dave Bautista, Vin Diesel","Plot":"The Guardians struggle to keep together as a team while dealing with their personal family issues, notably Star-Lord's encounter with his father the ambitious celestial being Ego.","Language":"English","Country":"USA","Awards":"Nominated for 1 Oscar. Another 15 wins & 56 nominations.","Poster":"https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"7.6/10"},{"Source":"Rotten Tomatoes","Value":"85%"},{"Source":"Metacritic","Value":"67/100"}],"Metascore":"67","imdbRating":"7.6","imdbVotes":"537,920","imdbID":"tt3896198","Type":"movie","DVD":"22 Aug 2017","BoxOffice":"$389,804,217","Production":"Walt Disney Pictures","Website":"N/A","Response":"True"}
   */

  /*
http://www.omdbapi.com/?t=Adventure&apikey=95d3a066

  {"Title":"Bill & Ted's Excellent Adventure","Year":"1989","Rated":"PG","Released":"17 Feb 1989","Runtime":"90 min","Genre":"Adventure, Comedy, Music, Romance, Sci-Fi","Director":"Stephen Herek","Writer":"Chris Matheson, Ed Solomon","Actors":"Keanu Reeves, Alex Winter, George Carlin, Terry Camilleri","Plot":"Two seemingly dumb teens set off on a quest to prepare the ultimate historical presentation with the help of a time machine.","Language":"English, French, German, Greek,  Ancient (to 1453)","Country":"USA","Awards":"3 nominations.","Poster":"https://m.media-amazon.com/images/M/MV5BMTk3Mjk5MzI3OF5BMl5BanBnXkFtZTcwMTY4MzcyNA@@._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"6.9/10"},{"Source":"Rotten Tomatoes","Value":"79%"},{"Source":"Metacritic","Value":"50/100"}],"Metascore":"50","imdbRating":"6.9","imdbVotes":"105,548","imdbID":"tt0096928","Type":"movie","DVD":"N/A","BoxOffice":"N/A","Production":"N/A","Website":"N/A","Response":"True"}
   */

  //{"Response":"False","Error":"Something went wrong."}

// {"Response":"False","Error":"Movie not found!"} login

// {"Response":"False","Error":"Too many results."}  search

/*

{"Title":"The Lego Movie",
"Year":"2014",
"Rated":"PG",
"Released":"07 Feb 2014",
"Runtime":"100 min",
"Genre":"Animation, Action, Adventure, Comedy, Family, Fantasy",
"Director":"Christopher Miller, Phil Lord",
"Writer":"Phil Lord (screenplay by), Christopher
Miller (screenplay by), Dan Hageman (story by),
 Kevin Hageman (story by), Phil Lord (story by), Christopher Miller (story by), Ole Kirk Christiansen
  (based on LEGO Construction Toys created by), Godtfred Kirk Christiansen (based on LEGO Construction Toys created by),
  Jens Nygaard Knudsen (based on LEGO Construction Toys created by), Peter Laird (characters created by: Teenage Mutant Ninja Turtles),
  Kevin Eastman (characters created by: Teenage Mutant Ninja Turtles)",
  "Actors":"Will Arnett, Elizabeth Banks, Craig Berry, Alison Brie",
  "Plot":"The LEGO Movie is a 3D animated film which follows lead character,
  Emmet a completely ordinary LEGO mini-figure who is identified as the most \"extraordinary person\" and
  the key to saving the Lego universe. Emmet and his friends go on an epic journey to stop the evil tyrant, Lord Business.",
  "Language":"English, Turkish",
  "Country":"USA, Denmark, Australia",
  "Awards":"Nominated for 1 Oscar. Another 72 wins & 65 nominations.",
  "Poster":"https://m.media-amazon.com/images/M/MV5BMTg4MDk1ODExN15BMl5BanBnXkFtZTgwNzIyNjg3MDE@._V1_SX300.jpg",
  "Ratings":[{"Source":"Internet Movie Database","Value":"7.7/10"},
  {"Source":"Rotten Tomatoes","Value":"96%"},{"Source":"Metacritic","Value":"83/100"}],
  "Metascore":"83",
  "imdbRating":"7.7",
  "imdbVotes":"315,571",
  "imdbID":"tt1490017",
  "Type":"movie","DVD":"N/A",
  "BoxOffice":"N/A","Production":"N/A",
  "Website":"N/A","Response":"True"}

 */

/*
  Search

  http://www.omdbapi.com/?s=Guardians&apikey=95d3a066

  {"Search":[

    {"Title":"Guardians of the Galaxy",
    "Year":"2014","imdbID":"tt2015381",
    "Type":"movie",
    "Poster":"https://m.media-amazon.com/images/M/MV5BMTAwMjU5OTgxNjZeQTJeQWpwZ15BbWU4MDUxNDYxODEx._V1_SX300.jpg"},

    {"Title":"Guardians of the Galaxy Vol. 2","Year":"2017","imdbID":"tt3896198","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BNjM0NTc0NzItM2FlYS00YzEwLWE0YmUtNTA2ZWIzODc2OTgxXkEyXkFqcGdeQXVyNTgwNzIyNzg@._V1_SX300.jpg"},

    {"Title":"Rise of the Guardians","Year":"2012","imdbID":"tt1446192","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMTkzMjgwMDg1M15BMl5BanBnXkFtZTcwMTgzNTI1OA@@._V1_SX300.jpg"},
    {"Title":"Legend of the Guardians: The Owls of Ga'Hoole","Year":"2010","imdbID":"tt1219342","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMjE0NjA5OTA4N15BMl5BanBnXkFtZTcwODA3MTA3Mw@@._V1_SX300.jpg"},
    {"Title":"Guardians","Year":"2017","imdbID":"tt4600952","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BYzgxY2NkZGYtOGI4NC00MTc4LTlkY2QtNmRjOTU1NDI0NGQ1XkEyXkFqcGdeQXVyNTc4MjczMTM@._V1_SX300.jpg"},{"Title":"7 Guardians of the Tomb","Year":"2018","imdbID":"tt4915672","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BZjMzZDI4YmEtZDIwNS00YWQ5LTkzN2UtMzJiMTliNjZiMzRjXkEyXkFqcGdeQXVyMzQwMTY2Nzk@._V1_SX300.jpg"},{"Title":"Naruto the Movie 3: Guardians of the Crescent Moon Kingdom","Year":"2006","imdbID":"tt1071815","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BNjk2ZWIzOTYtMGUxMC00MzdhLWI3ZGMtZGJhNzZmMDYxYjJlXkEyXkFqcGdeQXVyMjQ3NTQ4MjQ@._V1_SX300.jpg"},{"Title":"Guardians of the Galaxy","Year":"2015–","imdbID":"tt4176370","Type":"series","Poster":"https://m.media-amazon.com/images/M/MV5BNDM4NDQxMDU2MV5BMl5BanBnXkFtZTgwMDY2MDQ5NjE@._V1_SX300.jpg"},{"Title":"Halo 5: Guardians","Year":"2015","imdbID":"tt3467114","Type":"game","Poster":"https://m.media-amazon.com/images/M/MV5BMjAzMjIzMjY4OF5BMl5BanBnXkFtZTgwNDM5NzQxNzE@._V1_SX300.jpg"},{"Title":"The Guardians","Year":"2017","imdbID":"tt6213362","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BNjdkZmU1MzEtNjQ4OC00ZWM3LWIwNGUtZmM1MjBjYTI2M2E0XkEyXkFqcGdeQXVyNDU0NjMyNTQ@._V1_SX300.jpg"}],"totalResults":"161","Response":"True"}

 */
}