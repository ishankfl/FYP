// // view_request_bloc.dart

// import 'package:bloc/bloc.dart';

// enum ViewRequestEvent { newRequest, accept, completed }

// class ViewRequestBloc extends Bloc<ViewRequestEvent, int> {
//   ViewRequestBloc() : super(0);

//   @override
//   Stream<int> mapEventToState(ViewRequestEvent event) async* {
//     switch (event) {
//       case ViewRequestEvent.newRequest:
//         yield 0;
//         break;
//       case ViewRequestEvent.accept:
//         yield 1;
//         break;
//       case ViewRequestEvent.completed:
//         yield 2;
//         break;
//     }
//   }
// }
