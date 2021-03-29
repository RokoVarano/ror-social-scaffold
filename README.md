# Scaffold for social media app with Ruby on Rails

This version includes the following features:

- Users can be created
- Users can Log in

Logged in Users:
- Users have access to the main post index
- Users have access to the 'All Users' page
- Users have access to the 'Timeline' page (Post index)
- Users have access to the 'My Friends' page

The 'All Users' page features a list of users, each with a friend request option
The 'My Friends' page features a list of friendship relationships. Clicking on a user will open that user's profile
The user profile page displays the name of the user, his posts, and his current friends.
The user profile page contains the 'Accept' and 'Reject' option for friend requests.
The 'Timeline' page displays a list of friend and own posts, ordered chronologically

This submission is for milestone 2, so mirror friendships are yet to be addressed

## Built With

- Ruby v2.7.0
- Ruby on Rails v5.2.4

## Live Demo

TBA


## Getting Started

Clone the folowing [repository](https://github.com/RokoVarano/ror-social-scaffold)

### Prerequisites

Ruby: 2.6.3
Rails: 5.2.3
Postgres: >=9.5

### Setup

Instal gems with:

```
bundle install
```

Setup database with:

```
   rails db:create
   rails db:migrate
```

### Github Actions

To make sure the linters' checks using Github Actions work properly, you should follow the next steps:

1. On your recently forked repo, enable the GitHub Actions in the Actions tab.
2. Create the `feature/branch` and push.
3. Start working on your milestone as usual.
4. Open a PR from the `feature/branch` when your work is done.


### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

```
    rpsec --format documentation
```

### Deployment

TBA

## Authors

:bust_in_silhouette: **John hernandez**
- GitHub: [@johnhernandez-code](https://github.com/johnhernandez-code)
- Twitter: [@JohnHernCode](https://twitter.com/JohnHernCode)
- LinkedIn: [John Hernandez](https://www.linkedin.com/in/john-hernandez-56a7821b8/)

:bust_in_silhouette: **Rodrigo Ibaceta**
- GitHub: [Rodrigo Ibateca](https://github.com/RokoVarano/)
- Twitter: [@Rodrigo Ibaceta](https://twitter.com/RodrigoIbacet11)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/rodrigo-ibaceta-a8657611a/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

TBA

## 📝 License

TBA

