####
Robots!

Run ```bundle install``` from root of project, then ```./script/robot_runner``` with optional name of file. There are files in the ```./test_files``` directory. If you ```cat``` the input file right after you look at the output, you can see the comments regarding expectations. The robot's interpreter is trained to ignore such things as the comments.

I realize I could put the file handling stuff into a module, but this project has run on very long, and I wanted you to have it to look at!

Ideally the Transport::Robot class would not handle reporting by going directly to stdout, as it should really use the interpreter from the Instructable module to convey messages. Due to other design decisions there was no way to have Instructable::Interpreter know enough about Directions and Board positions to handle this gracefully, so for now, the speaking is right there in the Robot class.

I must've gone back and forth a dozen times about what to put where, how much to hardcode vs. when to use dependency injection.

I think if I were writing a program like this in the future, I'd want to use a functional language rather than such a purely object-oriented one, injecting rules as lambdas/functions, etc.

Cheers!