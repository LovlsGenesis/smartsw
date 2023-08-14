# README

## Steps to install the project:

#### Requirements:

* Github
* Ruby ~> 3.1.2
* Rails 7.0.1
* Terminal (Command prompt)
* Docker
* Docker Compose

### 1. Clone the Repository

  1.1 To download the repository:
  ```bash
  $ git clone git@github.com:lovlsgenesis/name.git
  ```

### 2. Build Docker Image (you can also build it locally)

  2.1 Enter the project folder:
  ```bash
  $ cd smartsw
  ```

### 3. Initialize the project

  3. If you are using Docker Compose follow these next steps:

  3.1 Build Docker Image:
  ```bash
  $ docker build -t smartsw-ruby .
  ```

  Then
  ```bash
  $ docker compose up
  ```

  3.2 Create database:
  ```bash
  $ docker compose run web rake db:create
  ```

  3.3 Run migrations:
  ```bash
  $ docker compose run web rake db:create
  ```

  If you are running the project locally
  Create database:
  ```bash
  $ rake db:create
  ```

  Run the migrations:
  ```bash
  $ rake db:migrate
  ```

  Initialize the project
  ```bash
  $ rails s
  ```

### 4. Run Tests

  4.1 To run the code with Docker Compose:
  ```bash
  $ docker compose run web rspec
  ```

  If you aren't using Docker Compose:
  ```bash
  $ bundle exec rspec
  ```



