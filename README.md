**Coffee Review API Endpoint** <br>
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

   order=[date,location,origin,roast,roaster]
   location=[*string]
   origin=[*string]
   roast=[*string]
   roaster=[*string]
   rating=[*integer]
   count=[*integer]

   **Defaults:**

   order=date
   count=100

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{ id : 12, name : "Michael Bloom" }`
 
* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** `{ error : "User doesn't exist" }`

  OR

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{ error : "You are unauthorized to make this request." }`

* **Sample Call:**

  ```javascript
    $.ajax({
      url: "/users/1",
      dataType: "json",
      type : "GET",
      success : function(r) {
        console.log(r);
      }
    });
  ```
