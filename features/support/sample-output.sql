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
CREATE OR REPLACE FUNCTION radius_check_change_handler()
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
