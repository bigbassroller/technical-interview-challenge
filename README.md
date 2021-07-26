## Backstory

At first, the model architecture was `Dog Breed breeds` etc. It became quickly apparent that every model afterward would be repetitive and redundant. I then got inspired by the work I have previously done on my own SaaS product BrandPlace.app, where I played around with the idea of using WordPress's model of "Post Types." Then while hearing Starship "we can build this thing together" at the convenience store, I had the "ah-ha" moment, "Block Types!"

## What Are Block Types?

Block Types houses content inside of Blocks organized and extended by Block Type. Blocks contain a name, description, body, and image field (more fields TBD).  Users can use Blocks to compose blog posts, pages, media attachments, navigation menus, component libraries, dashboards, admin systems, dashboards, and much more. A user can then query Blocks by Block Type using GraphQL API to precisely get the data needed to build web pages and apps. Your imagination is the limit!

BlockTypes CMS is a fully open-source platform with hosting available at BlockTypes.com (coming soon). 

## Features of this Demo
- Backend API that serves:
    - A list of available dog breeds based on those available in `/images`. See `priv/repo/seeds.exs`.
- Frontend UI that provides:
Individual dog images by breed
    - A list of dog breeds
    - The ability to choose a breed and display the image for it
    - **Bonus Feature** Ability to add a new breed with a new image

## Technology


### Programming Language and Framework:
Elixir, Phoenix

### Data Management
Ecto, Postgres 

### Frontend
LiveView, Milligram CSS

### API
GraphQL (coming soon)


## Getting Started

**Step 1:**

`git clone --single-branch --branch mchavez https://github.com/bigbassroller/technical-interview-challenge`

**Step 2:**

`cd technical-interview-challenge`

**Step 3:**

`mix deps.get && npm install --prefix assets && mix ecto.migrate && mix phx.server` 

(this will probably take awhile the first time)

**Step 4:**

Go to <a href="http://localhost:4000/blocks/" target="_blank">http://localhost:4000/blocks</a> to see a list of Blocks featuring dogs with Block Type "Dog Breeds".


## Road Map

### Todo
-----------------
- Put on hosting environment
- Add sign up, sign in, multitenancy
- Add GraphQL
- Use a meta field instead image field for images.
- Select image from list of blocks with block type "image" with option to upload image to a block type.
- Select BlockType from list of existing Block Types or add new block type. 
- User management
- Table Sorting
  - Add filter
- Options Page
  - Add to menu
- Settings page
- Add tags
- Smart naming by upload file name


### Done
------------------
- Ensure update blocks works
- Display image
- Add file uploads
