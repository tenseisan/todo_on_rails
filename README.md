[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/tenseisan/todo_on_rails">
    <img src="https://i.imgur.com/0iTTCl6.png" alt="Logo" width="600" height="90">
  </a>
  <p align="center">
    <a href="https://to-do-on-rails-web.herokuapp.com/">View Demo</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)


## About Project

![Product Name Screen Shot][product-screenshot]

This project is my first experience of using VueJS as frontend and GraphQL(instead REST) as backend.
The project is unlikely to be maintained, but maybe i will back with new experiments or updates.
The code is not perfect, there are not enough validations, etc. But oh well....

If this code helps you, star this repo :D plssss plsss

### Built With
* [Rails 6](https://getbootstrap.com)
* [VueJS 2.6.1](https://vuejs.org/)
* [GraphQL](https://graphql-ruby.org/)
* [Vuetify](https://vuetifyjs.com/en/)
* [MDI Icons](https://materialdesignicons.com/)



<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

```sh
rails 6+
npm latest

add database.yml to %app_root%/config/ with your postgresql login/pass/address
```

### Installation


Clone the repo
```sh
git clone https://github.com/tenseisan/todo_on_rails.git
```
Install gems and NPM
```
npm install npm@latest -g */ frontend folder
bundle install */ backend folder
```
Migrations
```
rails db:create / rails db:migrate
```

RUN
```
rails s */ notice port should be 3000
npm run serve */ from frontend folder and port should be 8080
```


<!-- CONTRIBUTING -->
## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Feel free to use, fork etc. no licence


<!-- CONTACT -->
## Contact

Dmitriy Malyshev - [@tenseisan](https://telegram.me/tenseisan) via TG


[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/edotensei/?lipi=urn%3Ali%3Apage%3Ad_flagship3_feed%3BcZ8XRgmJTTukdQ2tV9F2mg%3D%3D
[product-screenshot]: https://i.imgur.com/GCm2M1G.jpeg
