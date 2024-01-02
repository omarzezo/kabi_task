# kabi_task

Kind of Flutter application that apply MVVM with Flutter Bloc package.
Also the main purpose of this application is show posts and add post .
 
Architecture:
# Mvvm >>  Model View ViewModel 
     model >> hold the data model of response .
     View >> hold the screens and views .
     ViewModel >> hold the business logic of screen .

# Network Domain 
  - contain network config
  - contain network manager
  - contain network urls

# BaseView 
  -handle state of Screen

# View
- First Screen Called HomeScreen
  >>  contains all posts 
  >>  contains floating button that create new post


- Second Screen Called Create Post
  >>  contains Two Fields title and body and button for submit .
  >>  Also show the title and body of selected post and you can edit on it .