# ElapsedTime

Add support for converting an English representation of elapsed time into seconds and back (with validation).


## Example

    "1 day, 10 hours, 17 minutes and 36 seconds".parse_elapsed_time
    => 123456

    123456.to_elapsed_time
    => "1 day, 10 hours, 17 minutes and 36 seconds"

    class Job < ActiveRecord::Base
      elapsed_time :estimate
      validates_elapsed_time_of :estimate, :allow_nil => true
    end

## TODO

* documentation

## Legal

**Author:** S. Brent Faulkner <brentf@unwwwired.net>  
**License:** Copyright &copy; 2008-2010 unwwwired.net, released under the MIT license
