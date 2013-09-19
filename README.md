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
tickets = project.tickets :all, :state => 'closed' # all closed tickets
ticket = project.ticket 855
```

### Opening A Ticket

```ruby
ticket = project.ticket!(
  :title => "New Ticket"
  :body => "Content of the new ticket."
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
ticket.title = "Updated Title"
ticket.body = "New body"
ticket.save
```

### Finding Ticket Comments

```ruby
comments = ticket.comments
```

### Adding a Comment to a Ticket

```ruby
ticket.comment! "Your Comment Goes Here"
```

## Dependencies

- rubygems
- taskmapper
- ruby-trello

## Notes

This gem is currently WIP and may not have full functionality.

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
