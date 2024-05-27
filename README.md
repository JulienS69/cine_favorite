# cine_favorite

A Flutter mobile project that utilizes The Movie Database API and the Riverpod package for application state management.

## Objective

The purpose of this project is to display recently released movies in theaters and allow users to add them to their favorites. It also includes navigation management.

# Architecture du Projet

## lib/

### core/
- **helpers/**
  - `utils.dart` : File returning methods/variables used multiple times in the project.
- **interceptors/** : File for handling requests and adding additional logs.
- **styles/**
  - `colors.dart`
  - `text_styles.dart`
  - `text_theme.dart`
- **navigation/**
  - `app_router.dart` : File listing all the routes of the project.
  - `auto_tabs_navigator.dart` : File managing navigation between the various pages of the application.
- **widgets/**
  - `empty_content.dart` : Example of widgets reused in multiple places within the application.

### data/
- **models/** :  Models class

### presentation/
- **screens/**
  - **movie/**
    - `movie_screen.dart`  : View displaying films within the application.
    - `movie_controller.dart` : All logic and execution of API calls required by the view.
  - **favorite/**
    - `favorite_screen.dart` : View displaying favorites film within the application.
    - `favorite_controller.dart` : All logic and execution of API calls required by the view.
  - ... (others screens)

### providers/
- **favorite/**
  - `favorite_provider.dart` : File where the state of variables manipulated in the views is managed.
- **movie/**
  - `movie_provider.dart` : File where the state of variables manipulated in the views is managed.

