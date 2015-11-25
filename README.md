[![Build Status](https://travis-ci.org/tcmacdonald/acts_as_indexable.svg)](https://travis-ci.org/tcmacdonald/acts_as_indexable)

# acts_as_indexable

This gem is a Rails engine that provides a configurable DSL for rendering tables in index views of your application. It works with any collection of enumerable objects, ActiveRecord or otherwise. 

# Usage

You first need to install the gem via Bundler by adding the following to your application’s Gemfile… 

  gem ‘acts_as_indexable’,  ‘~> 0.0.1’

In your controller, you need to include the `ActsAsIndexable::View` concern and define the attributes you’d like to render within your table via the `current_attrs` method… 

    class WidgetsController < ApplicationController
      include ActsAsIndexable::View

      def current_attrs
        {
          id: {},
          title: {},
          created_at: {}
        }
      end
    end

Lastly, drop the following helper method into your template, passing your enumerable collection of objects as the first argument…

    <%= render_indexable Widget.all %>

This should render something similar to the following… 

![](https://s3.amazonaws.com/helloample/acts_as_indexable/widgets_index.png)

Add custom class selectors to your table by passing them along to `render_indexable`, like so...

    <%= render_indexable Widget.all, class: 'table table-striped' %>


# Customizations

For more control over what attributes are exposed, you can define `@current_attrs` directly within an action or `before_filter`. For example…

    def index
      @current_attrs = {
        id: {},
        username: {}
      }
    end

There are number of other customizations you can invoke on each attribute to get the output of your table exactly the way you want it. To customize any attribute, you simply pass the following keys/values within each attribute definition, like so...

    {
      title: {
        link_to: :self,
        class: 'btn',
        label: 'Name',
        ...
      }
    }

Descriptions for the available customization options are as follows...

|Key|Description|
|---|---|
|`label`|Customize the `th` element for each attribute|
|`link_to`|Link the attribute's value. Acceptable values are `:self` and `/path/to/:id`|
|`label`|Customize the `th` element for each attribute|
|`format`|Format the value according to current locale. Useful for customizing date/time objects|
|`partial`|Path to custom partial for the contents of `td`|


# Actions

Because most index views need a column for relevant CTAs, you can define a special attribute called `actions` to handle this. The declaration for this column deviates from the above conventions slightly, such that you can define multiple links to be rendered...

    {
      actions: {
        edit: { class: 'btn btn-primary' },
        delete: { class: 'btn btn-secondary' }
      }
    }

# Testing

    bundle exec rspec

# License

This project rocks and uses MIT-LICENSE.





