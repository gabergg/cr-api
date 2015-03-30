**To Uber:** <br>

This project focuses on back-end. Feel free to check out https://github.com/gabergg/gabergg.github.io (hosted at http://gabergg.github.io/tictactoe) for some front-end code, or https://github.com/gabergg/third_wave (hosted at http://thirdwave.herokuapp.com) for some a larger rails project (disclaimer: UI is all over the place currently!). 

Technologies: I was learning Rails when I decided to build this. Furthermore, Rails gives some nice routing for APIs and Rspec allows for clean and organized testing. Rails allowed me to develop rapidly, and ActiveRecord makes it nice to work with models and our database. If I weren't learning Rails at the time, I would have used an API gem. I'm using PostgreSQL to run the same database in development and production on Heroku.

This API is currently hosted at coffeeapi.herokuapp.com. You can find my resume at gabegsell.com/resume.

---

This is a basic little API for CoffeeReview.com. It includes rake tasks to scrape new reviews into the database, which are then accessed through the API. It's still unrefined; feel free to contact me/comment with issues, ideas, or suggestions. 

---

**Motivation** <br>
CoffeeReview.com has some useful coffee reviews, but it doesn't have the flexibility that I would like to navigate the reviews. Furthermore, I wanted json-based access to these reviews, in part for the potential to integrate with other projects. 

---

**API Endpoint:** <br>
`http://coffeeapi.herokuapp.com/v2`

---

**Get Reviews**
----
  Returns json data about a set of coffee reviews.

* **URL**

  /reviews

* **Method:**

  `GET`
  
*  **URL Params**

   **Required:**

   none

   **Optional:**

   `order=[{rating,location,origin,roaster}]`    _order of reviews in json response_ <br>
   `location=[string]`    _substring roaster location match e.g. new+yor_<br>
   `origin=[string]`    _substring origin match e.g. ethio_<br>
   `roast=[{light,medium-light,medium,medium-dark,dark}]`    _roast level_ <br>
   `roaster=[string]`    _substring roaster match e.g. intell_<br>
   `rating=[integer]`    _minimum rating_<br>
   `count=[integer]`    _number of reviews to grab_<br>

   **Defaults:**

   order=date <br>
   count=100

* **Sample Call:**

  ```bash
    curl 'http://coffeeapi.herokuapp.com/v2/reviews?rating=95&location=cali&order=rating&count=15'
  ```

* **Success Response:**

  * **Code:** 200 <br>
    **Content:**
  ```javascript
  {
    reviews: 
      {
      "name":"Panama Ironman Camilina Geisha",
      "roaster":"Klatch Coffee",
      "roast":"Medium-Light",
      "origin":"Boquete growing region, western Panama.",
      "location":"Los Angeles, California",
      "review_date":"September 2014",
      "overall_rating":97,
      "aroma":10,
      "acidity":9,
      "body":9,
      "flavor":10,
      "aftertaste":9,
      "description":"Beautifully structured and almost impossibly intricate in flavor and aroma. The fruit sensation is so deep and so complex that one could find almost any note in it: we settled on guava, mango and tangerine. Intensely floral – passion fruit, lilac, lily – with crisp cacao nib and sandalwood complication. Rich, lyric acidity; syrupy but buoyant mouthfeel. The aromatic fireworks quiet a bit but still saturate the finish.",
      "price":"$49.95/8 ounces",
      "agtron":"58/80",
      "with_milk":null
      }, ...
  }
  ```
  
  By Gabe G'Sell, 2014.
