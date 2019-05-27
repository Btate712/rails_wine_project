# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

rose = Variety.create(name: "Rose", color: "pink")
merlot = Variety.create(name: "Merlot", color: "red")
sb = Variety.create(name: "Sauvingon Blanc", color: "white")

wines = []
wines << Wine.create(name: "Wolffer Estate Rose", variety: rose)
wines << Wine.create(name: "Damine Tempier Bandol Rose", variety: rose)
wines << Wine.create(name: "Mateus Rose", variety: rose)
wines << Wine.create(name: "Low Hanging Fruit Merlot", variety: merlot)
wines << Wine.create(name: "Double Dog Dare Merlot", variety: merlot)
wines << Wine.create(name: "Pacific Peak Merlot", variety: merlot)
wines << Wine.create(name: "Tesco Finest Sauvignon Blanc", variety: sb)
wines << Wine.create(name: "The Ned Sauvignon Blanc", variety: sb)
wines << Wine.create(name: "Ghost Corner Sauvignon Blanc", variety: sb)

index = 0
20.times do
  user = User.create(username: "User#{index}", password: 'temp')
  wines.each do |wine|
    user.reviews.build(wine_id: wine.id, rating: rand(1..5))
  end
  user.save
  index += 1
end
