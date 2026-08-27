# Easy Marketplace

Easy Marketplace is a marketplace app built with Spring Boot.
Users can register, log in, add products, upload images, and search for items.
The app runs with MySQL through Docker Compose.

## Features

- User registration and login
- Password hashing with BCrypt
- Role-based access with `ROLE_USER` and `ROLE_ADMIN`
- Admin panel for users with `ROLE_ADMIN`
- Product create, edit, and delete for product owners
- Product image upload
- Product image gallery
- Product search by title and city
- Price and category filters
- Sorting by date and price
- Pagination on the product list
- Product view counter
- Public seller profile pages
- Read-only REST API:
  - `GET /api/products`
  - `GET /api/products/{id}`
- Default product categories loaded on startup

## Tech Stack

Backend

- Java 21
- Spring Boot 3.3
- Spring MVC
- Spring Data JPA
- Spring Validation
- Lombok

Database

- MySQL 8.4
- H2 for tests

Security

- Spring Security
- Form login
- BCrypt password hashing
- CSRF protection for forms

Frontend

- Freemarker templates
- HTML
- CSS
- Small amount of JavaScript for image previews and galleries

Build Tools

- Maven
- Maven Wrapper

Testing

- JUnit 5
- Mockito
- Spring Boot Test

Containerisation

- Docker
- Docker Compose

## Getting Started

Docker is the recommended way to run the project.

Clone the repository:

```bash
git clone https://github.com/nazarukiv/easy-marketplace.git
cd easy-marketplace
```

Start the app and database:

```bash
docker compose up --build
```

Open the app:

```text
http://localhost:8081
```

Docker Compose starts:

- the Spring Boot app
- a MySQL database
- a persistent database volume
- health checks for both services

To stop the app:

```bash
docker compose down
```

To remove the database volume as well:

```bash
docker compose down -v
```

## Running Without Docker

You can also run the app directly on your machine.

You need:

- Java 21
- MySQL
- Maven, or the Maven Wrapper from this repo

Create a MySQL database named `easymarket`.

Use `src/main/resources/application-example.properties` as a guide for local settings.
The local profile can also read these environment variables:

- `SPRING_DATASOURCE_URL`
- `SPRING_DATASOURCE_USERNAME`
- `SPRING_DATASOURCE_PASSWORD`

Run the app:

```bash
./mvnw spring-boot:run
```

## Project Structure

```text
src/main/java/com/nazarukiv/easymarket
```

- `controllers` handles web pages, forms, images, admin pages, and REST endpoints.
- `services` holds the main business logic.
- `repositories` contains Spring Data JPA repositories.
- `models` contains JPA entities such as `User`, `Product`, `Image`, and `Category`.
- `models/enums` contains user roles.
- `configurations` contains Spring Security configuration.

```text
src/main/resources
```

- `templates` contains Freemarker pages.
- `static` contains CSS.
- `application.properties` contains shared app settings.
- `application-local.properties` contains local settings.
- `application-docker.properties` contains Docker settings.
- `data.sql` loads default categories.

```text
src/test
```

- Contains a Spring context test and a product service unit test.


## Author
Ivan Nazaruk

