# taskmapper-trello


This is the [TaskMapper][] for interaction with [Trello][]

## Usage

Initialize the Trello TaskMapper instance using your public key and member
token:

```ruby
trello = TaskMapper.new(
  :taskmapper,
  :developer_public_key => "YOUR_DEVELOPER_PUBLIC_KEY",
  :member_token => "YOUR_MEMBER_TOKEN"
)
```

To find your `developer_public_key`, go to
[https://trello.com/1/appKey/generate][key].

To get a `member_token` you can use ad infinitum, modify this URL and visit it in
a browser:

    https://trello.com/1/authorize?key=APPLICATION_KEY&scope=read%2Cwrite&name=taskmapper-trello&expiration=never&response_type=token

After confirming, you'll be given a `member_token` that should not
expire.


[key]: https://trello.com/1/appKey/generate#
[token]: https://trello.com/1/appKey/generate#

### Finding Projects(Boards)

You can find your own projects by using:

```ruby
projects = trello.projects # will return all boards
projects = trello.projects ["board_id", "another_board_id"]
project = trello.projects.find :first, "board_id"
projects = trello.projects.find :all, ["board_id", "another_board_id"]
```

### Finding Tickets(Cards)

```ruby
tickets = project.tickets # All open tickets
tickets = project.tickets :all, :status => 'closed' # all closed tickets
ticket = project.ticket "4ea4fa0dd791269d4e29a1b3"
```

### Opening A Ticket

```ruby
ticket = project.ticket!(
  :name => "New Ticket"
  :description => "Content of the new ticket."
)
```

### Closing Tickets

```ruby
ticket.close
```

### Reopening Tickets

```ruby
ticket.reopen
```

### Updating Tickets

```ruby
ticket.name = "Updated name"
ticket.description = "New description"
ticket.save
```

## Dependencies

- rubygems
- [taskmapper][]
- [ruby-trello][]

## Notes

The Trello API does not currently support fetching comments for tickets/cards.
As such, the `taskmapper-trello` gem does not provide comment functionality for
tickets right now. If the API changes to allow this, we'll update
`taskmapper-trello` to match.

If you run into any issues, please feel free to open an issue or pull request.

## Contributing

The main way you can contribute is with some code! Here's how:

- Fork `taskmapper-trello`
- Create a topic branch: git checkout -b my_awesome_feature
- Push to your branch - git push origin my_awesome_feature
- Create a Pull Request from your branch
- That's it!

We use RSpec for testing. Please include tests with your pull request. A simple
`bundle exec rake` will run the suite. Also, please try to TomDoc your methods,
it makes it easier to see what the code does and makes it easier for future
contributors to get started.

(c) 2013 The Hybrid Group

[TaskMapper]: http://ticketrb.com
[Trello]: http://trello.com
[ruby-trello]: https://github.com/jeremytregunna/ruby-trello
