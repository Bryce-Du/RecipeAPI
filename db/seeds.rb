# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ingredient.destroy_all

api_url = "https://api.nal.usda.gov/fdc/v1/foods/search?query=*&dataType=SR%20Legacy&pageSize=7793&api_key="

data = JSON.parse( RestClient.get(api_url + ENV["USDA_API_KEY"]))

data["foods"].each do |food_item|
    ingr = {
        name: food_item["commonNames"],
        description: food_item["description"],
    }
    calorie_obj = food_item["foodNutrients"].find{|n| n["nutrientId"] == 1008} # id for Energy in KCALs
    ingr["calories"] = calorie_obj["value"] if calorie_obj
    Ingredient.create(ingr)

end
# Ingredient.create(name: "Apple", calories: 95)
# Ingredient.create(name: "Banana", calories: 105)
# Ingredient.create(name: "Almonds (10)", calories: 78)
# Ingredient.create(name: "Lettuce (cup, shredded)", calories: 5)
# Ingredient.create(name: "Bread (slice)", calories: 79)
# Ingredient.create(name: "Avocado", calories: 322)
# Ingredient.create(name: "Pasta (1 lb)", calories: 594)
# Ingredient.create(name: "Bacon (slice)", calories: 44)
# Ingredient.create(name: "Chicken (1 cup)", calories: 335)
# Ingredient.create(name: "Spinach (1 cup)", calories: 7)