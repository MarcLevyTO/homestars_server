# HomeStars BackEnd Features

## Completed Features

User Controller

- Can create a user and receive a JWT token
- Can login and receive a JWT token

(All further actions will require JWT authentication)

User Controller

- Can retrieve user's information

Channel Controller

- Can get list of all channels and their status (Active, Archived)
- Can create a new channel
- Can get channel information including messages and users in that channel
- Can join a channel
- Can archive a channel

Messages Controller

- Can post a new message to a channel if channel is not archived
- Can edit a message
- Can delete a message
- Can search for a message

Search Controller

- Can search for users or channels

Gif Search Controller

- Can search for gifs

Statistics Controller

- Can receive stats about number of users in app
- Can receive stats about number of valid users in app
- Can receive stats about number of messages for each user
- Can receive stats about number of users in a channel

## Notes

- The features implemented were done so to fulfil the requirements on the front-end application.
- The DELETE commands are non-destructive, and mark records as "Deleted" as opposed to removing them from the DB.
- Joining a channel is a done by programmatically creating a new message in the room saying "PERSON has joined the channel".
- I built out the GIF suggestion endpoint using GIPHY api endpoint and tying into their search endpoint.

I had tried to get Web Sockets implemented on the Rails <-> React with Action Cable, but kept running into configuration issues.
Instead, I just went with a basic CRUD application.

If I had more time:

- I would certainly make the application a LIVE chat application instead of a RELOAD chat application.
- Create a join table to handle user -> channel status, like joining or leaving and handling permissions of being able archive a room.
- Flush out more of the RSPEC tests.
- Add more statistics.
