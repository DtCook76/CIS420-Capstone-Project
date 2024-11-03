The Workbench

The Workbench is a web application designed to help hobbyists and DIY enthusiasts organize tools, supplies, and projects efficiently. It provides a structured system for categorizing tools and supplies by locations and containers, and linking them to ongoing projects through an intuitive tagging system. This ensures that users can easily find and manage their resources in one place.

Features

User Authentication: Secure login and registration for users.

Projects Management: Create and manage projects, and link relevant tools and supplies.

Tools & Supplies Organization: Categorize tools and supplies by locations, containers, and tags.

Intuitive Tagging System: Use tags to link tools, supplies, and projects for better organization.

Technologies Used

Backend: Elixir, Phoenix Framework, Phoenix LiveView

Frontend: Tailwind CSS, HEEx Templates

Database: PostgreSQL

Hosting: Gigalixir (for application and database)

Setup Guide

Prerequisites

Elixir: Install Elixir by following the instructions at https://elixir-lang.org/install.html.

Phoenix Framework: Install the Phoenix project generator by running:

mix archive.install hex phx_new

PostgreSQL: Ensure PostgreSQL is installed and running.

Node.js & NPM: Required for JavaScript and Tailwind CSS dependencies.

Gigalixir CLI (optional, for deployment): Install with:

curl -sSL https://get.gigalixir.com | bash

Installation

Clone the Repository:

git clone https://github.com/yourusername/workbench.git
cd workbench

Install Dependencies:

Install Elixir dependencies:

mix deps.get

Install Node.js dependencies:

cd assets && npm install

Database Setup:

Create and migrate the database:

mix ecto.create
mix ecto.migrate

Environment Configuration:

Rename .env.example to .env and update the variables as needed.

Source the environment variables:

source .env

Start the Server:

Start the Phoenix server:

mix phx.server

Visit http://localhost:4000 in your browser to access the application.

Contributing

Feel free to open issues or submit pull requests to contribute to the project.

License

This project is licensed under the MIT License - see the LICENSE file for details.

Contact

For questions or support, please contact dtcook76@gmail.com.

