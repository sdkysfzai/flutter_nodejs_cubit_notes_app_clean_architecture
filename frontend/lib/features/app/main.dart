import 'package:flutter/material.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/authentication_page/sign_in_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/config/routes/on_generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: "/",
      routes: {
        "/": (context) => const SignInPage(),
      },
    );
  }
}


/*
Watched thoroughly your code
What I didn't liked 
1. You have features folder but you didn't separated features
Like you have everything inside one file 
What you could have done is that having 
Auth 
Comment
Post
Profile
These kind of subfeatures inside feature folder 
And having domain data and presentation layer inside each subfeature 
This could really make file leaner and more maintainable
2. Showing toast directly from data layer 
Your data layer should only be responsible for handling data related task 
Like fetching data and handling exception nothing else 
3. Your cubit are also handling exception logics
Which shouldn't be done 
Instead handle exception in data layer 
And pass in failure to domain layer usecases 
4. Having more than one usecase dependency inside single cubit 
Eg. DeleteUsecase
CommentUsecase
Replyusecase inside a cubit 
Rater create one major usecase 
And have those injected inside that usecase 
And use single usecase in cubit 
Overall code looks clean. That's my feedback. Hope you don't mind
*/