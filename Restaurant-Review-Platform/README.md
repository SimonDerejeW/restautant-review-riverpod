# Restaurant-Review-Platform

Group Members
1. Simon Dereje  --  UGR/0952/14
2. [Samuel Endale](https://github.com/samienda) --  UGR/9314/14
3. Abenezer Tileye - UGR/5256/14
4. [Feven Lendu](https://github.com/Fevi-lendu)   --  UGR/1779/13


This is a web based app that enables users to comment on restaurants.

## 1.Introduction 
The restaurant rating system allows users to comment on restaurants. Moreover, it enables users to discover new dining places and gain insights on existing restaurant reviews. 
## 2.Features
  ### User Authentication and Authorization
      User registration and login
      Role based access control for common users and restaurant owners
###   User Profile Management: 
      User profile creation 
###   Common Users Features:
      View list of restaurants for easy exploration
      Search functionality for finding specific restaurants 
      Commenting feature for sharing opinions  
      Comprehensive view all comments on restaurants
      Update and Delete comments
      Update and Delete restaurants
###   Restaurant Owners Features:
      Feature that enables restaurants to post their dining establishment`
## 3.Technologies used
###  Frontend:  TypeScript, Tailwind
###  Backend: Node.js, Nest.js
###  Database: MongoDB
###  Authentication: JWT Token
###  Fetch API is usedfor communication with the backend.
## 4. Why MongoDB?
When selecting a database for the Restaurant Review App, several factors were considered, and MongoDB emerged as the optimal choice for the following reasons:
- **Flexible Schema Design:** MongoDB's document-oriented model allows for a flexible and dynamic schema. 
- **Scalability**
- **JSON-Like Documents:** MongoDB stores data in BSON format, a binary representation of JSON-like documents. This aligns well with the application's use of TypeScript and simplifies the integration of data between the frontend and the database.
- **Rich Query Language:** MongoDB provides a powerful and expressive query language, allowing for complex queries and efficient retrieval of data. This is crucial for implementing features like comprehensive views of comments and reviews.
- **Document Validation and Indexing:**MongoDB's document validation capabilities allow for enforcing data integrity at the database level. Additionally, the ability to create indexes enhances query performance, contributing to faster response times.
## 5. Prerequisites
Before you begin, ensure you have the following installed:
- [Node.js](https://nodejs.org/)
- [npm](https://www.npmjs.com/) (Node Package Manager)
- [MongoDB](https://www.mongodb.com/)
##6. Getting Started
To run the Restaurant Review App locally, follow the following steps:
A. **Clone Repository**
B. **Install Dependencies:**
   -     cd restaurant-review-app
   -     npm install
C.  **Set up environment variables**
D.  **Run the application**
   -      npm start
E. **Access the app**
- open your web browser and proceed by signing up html page to begin the process.


  

<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>
    <p align="center">
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/v/@nestjs/core.svg" alt="NPM Version" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/l/@nestjs/core.svg" alt="Package License" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/dm/@nestjs/common.svg" alt="NPM Downloads" /></a>
<a href="https://circleci.com/gh/nestjs/nest" target="_blank"><img src="https://img.shields.io/circleci/build/github/nestjs/nest/master" alt="CircleCI" /></a>
<a href="https://coveralls.io/github/nestjs/nest?branch=master" target="_blank"><img src="https://coveralls.io/repos/github/nestjs/nest/badge.svg?branch=master#9" alt="Coverage" /></a>
<a href="https://discord.gg/G7Qnnhy" target="_blank"><img src="https://img.shields.io/badge/discord-online-brightgreen.svg" alt="Discord"/></a>
<a href="https://opencollective.com/nest#backer" target="_blank"><img src="https://opencollective.com/nest/backers/badge.svg" alt="Backers on Open Collective" /></a>
<a href="https://opencollective.com/nest#sponsor" target="_blank"><img src="https://opencollective.com/nest/sponsors/badge.svg" alt="Sponsors on Open Collective" /></a>
  <a href="https://paypal.me/kamilmysliwiec" target="_blank"><img src="https://img.shields.io/badge/Donate-PayPal-ff3f59.svg"/></a>
    <a href="https://opencollective.com/nest#sponsor"  target="_blank"><img src="https://img.shields.io/badge/Support%20us-Open%20Collective-41B883.svg" alt="Support us"></a>
  <a href="https://twitter.com/nestframework" target="_blank"><img src="https://img.shields.io/twitter/follow/nestframework.svg?style=social&label=Follow"></a>
</p>
  <!--[![Backers on Open Collective](https://opencollective.com/nest/backers/badge.svg)](https://opencollective.com/nest#backer)
  [![Sponsors on Open Collective](https://opencollective.com/nest/sponsors/badge.svg)](https://opencollective.com/nest#sponsor)-->

## Description

[Nest](https://github.com/nestjs/nest) framework TypeScript starter repository.

## Installation

```bash
$ npm install
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Test

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## Stay in touch

- Author - [Kamil Myśliwiec](https://kamilmysliwiec.com)
- Website - [https://nestjs.com](https://nestjs.com/)
- Twitter - [@nestframework](https://twitter.com/nestframework)

## License

Nest is [MIT licensed](LICENSE).
