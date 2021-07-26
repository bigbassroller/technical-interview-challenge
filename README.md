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


## Road Map

### Todo
-----------------
- Put on hosting environment
- Add GraphQL
- Use a meta field instead image field for images.
- Select image from list of blocks with block type "image" with option to upload image to a block type.
- Select BlockType from list of existing Block Types or add new block type. 
- Add sign up, sign in
- Add multitenancy
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
