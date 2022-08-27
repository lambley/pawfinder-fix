// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import HomeSearchController from "./home_search_controller"
application.register("home-search", HomeSearchController)

import MapController from "./map_controller"
application.register("map", MapController)

import StarRatingController from "./star_rating_controller"
application.register("star-rating", StarRatingController)
