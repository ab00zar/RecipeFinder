# README

Problem statement:
It's dinner time! Create an application that helps users find the most relevant recipes that they can prepare with the ingredients that they have at home

Data:
A json file including 10000 recipes in the form of:
```
{
    "title": "Golden Sweet Cornbread",
    "cook_time": 25,
    "prep_time": 10,
    "ingredients": [
      "1 cup all-purpose flour",
      "1 cup yellow cornmeal",
      "⅔ cup white sugar",
      "1 teaspoon salt",
      "3 ½ teaspoons baking powder",
      "1 egg",
      "1 cup milk",
      "⅓ cup vegetable oil"
    ],
    "ratings": 4.74,
    "cuisine": "",
    "category": "Cornbread",
    "author": "bluegirl",
    "image": "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2021%2F10%2F26%2Fcornbread-1.jpg"
  }
```
Solution: A full-text search using ```tsvector```

The focus is on the core functionality, and providing a minimal solution that works with the possibility of future extentions. So here are the user stories:
1. As a user, I want to input my available ingredients, so I can find matching recipes.
   - Acceptance Criteria:
      - User submits a list of ingredients.
      - The system returns recipes that contain some or all of the provided ingredients.
      - The results are sorted by relevance (recipes requiring fewer missing ingredients are ranked higher).
      - The matching ingredients are highlighted.
2. As a user, I want to view detailed information about a recipe, so I can see its ingredients, preparation time, cooking time, etc.
   - Acceptance Criteria:
      - Clicking on a recipe shows its name, ingredients, etc.
