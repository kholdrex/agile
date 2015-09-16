# Agile

<a href="https://codeclimate.com/github/kholdrex/agile"><img src="https://codeclimate.com/github/kholdrex/agile/badges/gpa.svg" /></a>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'agile', github: 'kholdrex/agile'
```

And then execute:

    $ bundle

## Usage

```ruby
file1_path = '/home/user_name/files/file1'
fiel2_path = '/home/user_name/files/file2'

agile_comparer = Agile::Comparer.new(max_lines: 3000)

puts agile_comparer.compare(file1_path, file2_path)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/agile. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

