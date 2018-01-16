# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(login: "kirkland", password: "weouthere")
foa = JSON.parse(File.read("foa_products.json"))
foa.each do |key, val|
  val.each do |e|
    if e
      Product.create(name: e["name"], description: e["description"], thumbnail: e["img"], brand: "Furniture of America")
    end
  end
end
json = JSON.parse(File.read("product_output.json")).each do |e|
  product = e[1]["product"]
  Product.create(number: product['number'],name: product['name'],description: product['description'],images: product['images'],thumbnail: product['thumbnail'], brand: "Homelegance")
end

Category.create([
  {name: "Dining Sets", parent_category: "dining"},
  {name: "Counter Height Dining Sets", parent_category: "dining"},
  {name: "Buffets/Hutches", parent_category: "dining"},
  {name: "Servers", parent_category: "dining"},
  {name: "Barstools", parent_category: "dining"},
  {name: "Curios", parent_category: "dining"},
  {name: "Bedroom Sets", parent_category: "bedroom"},
  {name: "Beds/Headboards", parent_category: "bedroom"},
  {name: "Pillows/Bedding", parent_category: "bedroom"},
  {name: "Chairs", parent_category: "seating"},
  {name: "Accent Chairs", parent_category: "seating"},
  {name: "Sofa Love Sets", parent_category: "seating"},
  {name: "Sectionals", parent_category: "seating"},
  {name: "Motion", parent_category: "seating"},
  {name: "Recliners", parent_category: "seating"},
  {name: "Bunk Beds", parent_category: "youth"},
  {name: "Day Beds", parent_category: "youth"},
  {name: "Trundle Beds", parent_category: "youth"},
  {name: "Beds", parent_category: "youth"},
  {name: "Youth Bedroom Sets", parent_category: "youth"},
  {name: "Misc", parent_category: "home"},
  {name: "Lamps", parent_category: "home"},
  {name: "Entertainment Centers", parent_category: "home"},
  {name: "Ottomans", parent_category: "seating"},
  {name: "Occasional", parent_category: "home"},
  {name: "Wine Lovers", parent_category: "home"},
  {name: "Bookshelves", parent_category: "home"},
  {name: "Desks", parent_category: "home"},
  {name: "Mattresses", parent_category: "mattresses"}
])

subs = JSON.parse(File.read("subs.json"))
subs.each do |key, val|
  @category = Category.find_by_name(key)
  val.each do |image|
    @category.products.push(Product.find_by_thumbnail(image))
  end
end

@category = Category.find_by_name("Occasional")
Product.where(brand: "Homelegance").each do |prod|
  if prod.categories.length == 0
    @category.products.push(prod)
  end
end
