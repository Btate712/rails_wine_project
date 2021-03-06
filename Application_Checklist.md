# Rails Project Checklist of Requirements

- A summary of the application:
  - The application allows users write reviews for and to rate wines.  A logged
    in user can view the wines that they’ve reviewed or view the reviews other
    users have submitted for a given wine.

- What will your models and associations be and why? You will need a has_many
  and belongs_to relationship as well as a many to many relationship.
  - User
    - Has many reviews
    - Has many wines through reviews
  - Review
    - Belongs to user
    - Belongs to wine
  - Wine
    - Has many reviews
    - Has many users through reviews
    - Belongs to variety
  - Variety
    - Has many wines

- How will you implement a user submittable attribute on the join table of the
  many to many relationship?
  - Reviews is a join table with multiple user submittable attributes such as
    review_content (text), dryness (integer), sweetness (integer),
    overall_rating (integer).

- What it is an ActiveRecord scope method and what is your implementation plan?
  - A scope method is a class method for retrieving objects from the database
    using frequently used search parameters.  I plan on implementing filter
    options on the wine/index page to allow the user to search for wines based
    on parameters such as color and variety

- What validations will you have for your models?
  - Users
    - Username – validates presence and uniqueness
  - Reviews
    - User – validates presence and uniqueness (maximum of one review per wine
      per user – I don’t know if ActiveRecord validations will work for this or
      if I’ll have to create a method to validate)
    - Overall rating – validates presence and value between 1 and 5 (inclusive)
    - All integer ratings (dryness, sweetness, etc) – validate presence and
      value between 1 and 5 (inclusive)
  - Wine
    - Name – validates presence and uniqueness
  - Variety
    - Name - validates presence and uniqueness
    - Color - validates presence

- How will you implement an authentication system?
  - Authentication will be via username and bcrypt secure password OR Google
    login via OmniAuth

- What 3rd party login service will you use?
  - Google via OmniAuth

- With the way your models are setup what nested routes will you use to meet the
  requirement?
  - A user will be able to view reviews for a particular wine via the nested
    route: wines/:id/reviews and will be able to view a particular review for a
    particular wine via the nested route: wines/:id/reviews/:review_id

- Additional features:
  - Once the minimum project requirements are met, I plan to add the following
    additional features as time permits:
    - Responsive CSS layout
    - Add a restaurants model and a restaurant_wine model
      - Restaurants have many wines through restaurant_wine and wines have many
        restaurants through restaurant_wine
      - This feature, combined with the “users with similar tastes” feature will
        allow restaurants to upload their wine list to allow users to view the
        wine list with ratings based on the reviews of users with similar
        tastes.
      - This feature is what necessitates having a responsive CSS layout – users
        will be accessing the app via mobile devices at restaurants when
        selecting wines from restaurant wine lists.
        Wines are suggested for a user based on the reviews of users with similar
          tastes
    - This feature will require an alternate rating algorithm that determines
      which other users have similar tastes and weights their reviews more
      heavily than those of others
