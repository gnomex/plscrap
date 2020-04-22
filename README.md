# README

Challenge to scrap data using `mechanize` and `nokogiri` and return data as an api using `jbuilder`, all done in `Ruby on Rails 6`

## Getting started

> Assuming you have ruby, docker-compose and yarn/npm installed

1. clone the project
2. run `bundle install`
3. run `yarn install`
4. run db with `[sudo] docker-compose up -d`
5. create the db with `rails db:create` and `rails db:migrate`
6. `rails s`

## How to use?

### Scrapping the data

It's not automated, you must do one of them:

* `rails c`, `ScrapingService.scrap_camara_nh`

or

* `curl localhost:3000/scrap_data`

### Accessing the data

From your browser

* open `localhost:3000/projects`

From your terminal

* `curl localhost:3000/projects`


#### API

The returned json should be:

```json
/* n is an integer*/
{
  "total_items": 0,
  "page": n,
  "items_per_page": 10,
  "prev_page": "url?page=n-1" /* null for first page */,
  "next_page": "url?page=n+1" /* null for last page */,
  "projects":[
    {
      name: "",
      link: "",
      description: ""
    },
    /*...*/
  ]
}
```

