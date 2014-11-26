**Coffee Review API Endpoint:** <br>
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

   `order=[{date,location,origin,roast,roaster}]`    _order of reviews in json response_ <br>
   `location=[string]`    _substring roaster location match e.g. cali_<br>
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
