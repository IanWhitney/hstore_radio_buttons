# hstore_radio_buttons

So, you need a bunch of radio buttons on a form. But there's no particular reason for you to save each question in its own database field. And, even better, you have access to the Hstore data type in postgres. hstore_radio_buttons is the library you are looking for. Define a set of radio buttons, display them in your form and then gather them all up and save the data in an hstore field.

# Requirements

- Postgres. If you have the hstore extension enabled, great. If not, the
  migration generated by this gem will turn it on.
- Rails 3 and the activerecord-postgres-hstore gem installed

This might work with Rails 4, which has native support for hstore, but I haven't tried that yet.

## Installation

Add this line to your application's Gemfile:

    gem 'hstore_radio_buttons'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hstore_radio_buttons

hstore_radio_buttons will save all of your hstores in a single table. To
generate that table, do:

    $ rails generate hstore_radio_buttons:migration
    $ rake db:migrate

The migration does two things:

1. Executes the command "CREATE EXTENSION IF NOT EXISTS hstore"
2. Creates a polymorphic table hstore_radio_data, which is where all the
   persisted data will be saved.

If you don't need to set up the hstore extension, just remove that part
of the migration before running it.

## Usage

For every collection of radio button questions, you'll need to define their set of values as well as a label for the set of buttons. Say you want something like this:

    Gender:
      o Male
      o Female
      o Other
  
    Favorite Barn Animal:
      o Cow
      o Sheep
      o Pig

### Defining buttons in a YAML file

In above example we have two sets of buttons, one for the Gender question and one for the Barn Animal question. Each set needs to be defined in a yaml file that lives in config/hstore_radio_button_sets.yml

    person:
      gender:
        - male
        - female
        - other
      'favorite barn animal':
        - cow
        - sheep
        - pig

The above defines two sets of buttons that can be used by the person model. For a model to generate/save radio button data, the set must be defined for the model.

Then set up your model so that it knows it has hstore_radio_buttons.

    class Person < ActiveRecord::Base
      include HstoreRadioButtons

      hstore_radio_buttons_from_yaml
      ...
    end

### Defining buttons with macros in the model itself

Instead of using the yaml file, you can define your buttons macro-style
within the model itself.

    class Person < ActiveRecord::Base
      include HstoreRadioButtons

      hstore_radio_button {'gender' => ['male', 'female', 'other']}
      hstore_radio_button {'favorite barn animal' => %w(cow sheep pig)}
      ...
    end

### Displaying buttons in a form

To display the radio button set on the form, you have two options:

    <%= form_for @person do |f|>
      <%= f.hstore_radio_tag('gender') %>
      <%= f.hstore_radio_tag('favorite barn animal') %>
    <% end>

Or, you could render all radio sets defined for your model:

    <%= form_for @person do |f|>
      <%= f.hstore_radio_tags %>
    <% end>

Which would render both Gender and Favorite Barn Animal in the same order in which they appear in the yaml file.

The exact html that gets rendered in the above example would be:

    <form...>
      <label for=''>Gender</label>
      <input type='radio' name='' value='male'>Male</input>
      <input type='radio' name='' value='female'>Female</input>
      <input type='radio' name='' value='other'>Other</input>
      ...
    </form>

And once processed and saved, the hstore would look like:

    {'gender' => 'female', 'favorite barn animal' => 'sheep'}

Persisted hstore data is stored in the hstore_radio_data table.

And, of course, this perisisted data is used to mark the correct radio
buttons as 'selected' when the form is loaded later.

You can interact with all this data in the console as well:

    >> p = Person.find(1)
    >> p.gender 
      => 'female'
    >> p.favorite_barn_animal
      => 'sheep'
    >> p.favorite_barn_animal = 'pig'
      => 'pig'

Keep in mind that the returned data will always be strings. So boolean
values aren't true and false, they are 'true' and 'false'. That's just
how hstore works.

And, for the sake of security, you can't set a value to
something that's not in your button definition. So if someone changes their
form submission values to include malicious data that should not be a
problem.<sup>*</sup>


    >> p = Person.find(1)
    >> p.gender = 'something hackerish' 
      => nil

<sup>*</sup> Notice the 'should' part there. I am not a security expert
and I welcome any pull requests that make this gem more secure.

TODO: It'd be nice to have default values for a set.  
TODO: Multi-model radio button sets.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
