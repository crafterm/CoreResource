## Core Resource

http://github.com/crafterm/CoreResource

### Description

Core Resource is an experimental Core Data backed structured webservice client, useful for consuming data oriented webservices, and communicating with 
Rails applications via REST similar to Active Resource for Rails applications.

Core Resource uses Core Data for client side storage of data retrieved from your Rails models, from a JSON or XML feed (ie. an NSArray of structured NSDictionary objects)
between server and client. It supports many model property types (string, int, floats, etc) including associations.

To use Core Resource, you create a Core Data model that matches your Rails model (ie. the models/entities you wish to send to your client), including associations (ie. relationships
in Core Data). After generating your Core Data model classes, RABuilder can read a remote JSON or XML stream (essentially an array of dictionaries) and create/populate instances 
of those Core Data model objects with content. When RABuilder encounters a nested dictionary, it assumes it to be an association and recursively builds a new Core Data model
instance, associating the child and parent during processing. 

If an existing Core Data model instance exists (identified via an duplicate associated 'id' field) then it's used as-is rather than created, allowing you to build up a local model
structure matching your remote structure, including 1-many relationships where the associated object is referenced from many child objects.

### Example
    // Assume a Core Data model containing Wine, Vineyard and Region entities, and a Rails application with matching model objects with associations

    NSArray * wineJSON = [json JSONValue]; // fetched remotely using RAService, or NSURLRequest directly
    
    self.wines = [NSMutableArray array];
    
    RABuilder * builder = [[RABuilder alloc] initWithManagedContext:managedObjectContext];
    
    for (NSDictionary * wineData in wineJSON) {
        Wine * wine = [builder create:wineData];
        [self.wines addObject:wine];
        [wine release];
    }
    
    [builder release];
    
    // self.wines is now a Core Data mode structure that contains all Wine objects from the remote webservice, and can be read including traversing associations, and be persisted
    
    for (Wine * wine in self.wines) {
        NSLog(@"Wine: %@ (%@) (%@)", wine.name, wine.vineyard.name, wine.vineyard.region.name);
    }
    
Please look at the Tests directory for a complete example including the core data model described above, etc.

### Limitations

Core Resource is currently a proof of concept that only supports reading of content (no update or create operations just yet), those operations will be added soon. It also
requires that you build a local Core Data model structure following the relationships defined in your remote Rails app - which hence currently works best when you control 
both server and client. After some more testing and use, I'll definitely be looking to solidify the concepts and make the code more resilient and adaptable.

If you have any comments, thoughts, feedback or ideas please feel free to contact me at Marcus Crafter <crafterm@redartisan.com>.


### LICENSE:

(The MIT License)

Copyright (c) 2009 Marcus Crafter <crafterm@redartisan.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


