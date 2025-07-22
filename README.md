# 🍽️ Random Meal Idea Generator

A web application built with Ruby on Rails to help users decide what to cook. Users can generate random meals, browse recipes, save favorites, and rate dishes.

---

## 🛠 Tech Stack

- **Ruby**: 3.4.4
- **Rails**: 8.0.2
- **Database**: PostgreSQL
- **Authentication**: Devise
- **Frontend**: Hotwire (Turbo + Stimulus)
- **HTTP Requests**: Faraday
- **Testing**: RSpec

---

## 🚀 Features

- **Random Meal Generation:** Generate a random meal idea, fetched from an external API and saved if not already present.
- **Browse Meals:** Browse meals with search/filter by category, name, country (area), and ingredients.
- **View Meal Details:** See detailed information about meals, including ingredients and instructions.
- **Favourite Meals:** Mark/unmark meals as favourites and view your list of favourites.
- **Meal Reviews:** Add, view, and delete your own reviews (rating and comment) for meals.
- **Filter Meals:** Filter/search meals by category, area (country/region), or ingredient.
- **Category Import:** Import meal categories from an external API, including name, thumbnail, and description.
- **Area Listing:** Fetch and list available meal areas (countries/regions) from the external API.
- **TheMealDB Integration:** Integrates with TheMealDB API for meal, category, and area data, with caching for efficiency.
- **Homepage:** Landing/dashboard page for the app.

---

## 🧪 Running Locally

```bash
# Clone the project
git clone git@github.com:xadizx/meal-db.git
cd meal_ideas_generator

# Install dependencies
bundle install

# Set up the database
rails db:setup

# Run the server
bin/dev
```
