# Changelog

### 0.4.3+1
- #### Bug Fix
  - fix code block not selectable
  - fix code preview container not shrink when content height change

### 0.4.1+1
- #### Change
  - change loading illustration
- #### Bug Fix
  - fix row span render
  - fix search keyboard listener
  - fix highlight table of content
  - fix presentation text displayed on table of content previously show **
- #### Improvement
  - improve url path to contain fragment and branch
  - add redirect to spec / usage from search
  - add loading animation on section tab (spec / usage)
  - add empty error message on empty search

### 0.3.1+1
- #### Hot Fix
  - fix CORS issue on typesense

### 0.3.0+1
- #### Features
  - Logout
- #### Bug Fix
  - highligted sidebar, hirarki-nya jg terhighlight (textnya)
  - turunin tab2 dibawah lastupdate, heightnya dikecilin
  - rewording -> Overview | Spec | Usage
  - spesific chrome tidak bisa load content
  - handling no data content
  - fix pagination limit page to 100 data
  - fix hardcoded branch to getImage
- #### Improvement
  - highlight selected branch
  - login with enter
  - highlight table of content
  - animasi expand collapse sidebar

### 0.2.0+1
- #### Features
  - Hex Color Parsing
  - User Domain Auth
  - Version Selector (based on git branch)
- #### Bug Fix
  - HTTP 401 not redirected to login page
  - session cache not working when refresh URL from browser
- #### Improvement
  - rework url routing to match each project id from gitlab so later can be used as share link
  - improve navigation panel file tree font and color

