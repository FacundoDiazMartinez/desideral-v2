# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create users
User.where(email: "john_doe@email.com").first_or_create do |user|
  user.first_name = "John"
  user.last_name = "Doe"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = :admin
end

# Create companies
Company.where(name: "Company 1").first_or_create

# Create categories
Category.where(name: "Category 1").first_or_create do |category|
  category.company = Company.first
end

# Create subcategories
Category.where(name: "Subcategory 1").first_or_create do |subcategory|
  subcategory.category = Category.first
  subcategory.company = Company.first
end

# Create products
Product.where(name: "Product 1").first_or_create do |product|
  product.description = "Product 1 description"
  product.company = Company.first
  product.category = Category.first
  product.taxes << Tax.where(name: "Tax 1").first_or_initialize
  product.price = 100.0
  product.available = true
  product.unit = :unit
end
