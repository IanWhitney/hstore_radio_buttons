# hstore_radio_buttons

So, you need a bunch of radio buttons on a form. But there's no particular reason for you to save each question in its own database field. And, even better, you have access to the Hstore data type in postgres. hstore_radio_buttons is the library you are looking for. Define a set of radio buttons, display them in your form and then gather them all up and save the data in an hstore field.

# Requirements

- Postgres with hstore data type enabled
- Rails 3 and the activerecord-postgres-hstore gem installed

This might work with Rails 4, which has native support for hstore, but I haven't tried that yet.

## Installation

Add this line to your application's Gemfile:

    gem 'hstore_radio_buttons'

And then execute:

    $ bundle

hstore_radio_buttons will save all of your hstores in a single table. To
generate that table, do:

    $ rails generate hstore_radio_buttons:migration
    $ rake db:migrate

Or install it yourself as:

    $ gem install hstore_radio_buttons

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

In this example we have two sets of buttons, one for the Gender question and one for the Barn Animal question. Each set needs to be defined in a yaml file that lives in config/hstore_radio_button_sets.yml

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

To display the radio button set on the form, you have several different options

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

And, of course, this perisisted data is used to mark the correct radio
buttons as 'selected' when the form is loaded later.

TODO: It'd be nice to have default values for a set.
TODO: Multi-model radio button sets.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
