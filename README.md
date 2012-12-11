# Rpgview

RPGView is a ruby based sql generator for creating a Postgresql view wrapper around a gnarly legacy table. It includes all the Postgresql 9.x trigger goodness for interacting directly with the view in your Rails app.

## Installation

Add this line to your application's Gemfile:

    gem 'rpgview'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rpgview

## Usage

rpgview /path/to/mapping.yaml

The mapping.yaml file should look something like:

    mapping:
      table: 'radcheck'
      view: 'radius_check'
      mappings:
        legacyid: 'id'
        username: 'user_name'
        attribute: 'attribute_type'
        op: 'operator'
        value: 'attribute_value'

And it will output the following sql:

    /*
     * View created by rpgview for radcheck table.
    */
    CREATE VIEW radius_check AS
      SELECT id AS id,
      username AS user_name,
      attribute AS attribute_type,
      op AS op,
      value AS attribute_value
      FROM radcheck;

    /*
     * Triggers for updating view
    */
    CREATE OR REPLACE FUNCTION radius_radius_check_handler()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $function$
      BEGIN
        IF TG_OP = 'INSERT' THEN
          INSERT INTO radcheck VALUES(
            NEW.id,
      NEW.user_name,
      NEW.attribute_type,
      NEW.op,
      NEW.attribute_value
          );
          RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
          UPDATE radcheck
          SET id=NEW.id,
      username=NEW.user_name,
      attribute=NEW.attribute_type,
      op=NEW.op,
      value=NEW.attribute_value
          WHERE id = OLD.id;
          RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
          DELETE FROM radcheck
          WHERE id = OLD.id;
          RETURN NULL;
        END IF;
        RETURN NEW;
      END;
    $function$;

    /*
     * Bind function to INSERT, UPDATE, DELETE events
    */
    CREATE TRIGGER radius_check_change
    INSTEAD OF INSERT OR UPDATE OR DELETE
    ON radius_check
    FOR EACH ROW EXECUTE PROCEDURE radius_check_change_handler();


Please note this sql will only work in PostgreSQL 9.1 and greater. Previous versions rely on rules.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
