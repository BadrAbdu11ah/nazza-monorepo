import 'package:frontend_user/core/class/state_request.dart';
import 'package:flutter/material.dart';

class HandlingDataView extends StatelessWidget {
  final StateRequest state;
  final Widget child;
  final void Function()? onPressed;

  const HandlingDataView({
    super.key,
    required this.state,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case StateRequest.loading:
        return Center(
          child: CircularProgressIndicator(color: Colors.blueAccent),
        );
      case StateRequest.offlineFailure:
        return Center(child: Text("Offline Failure"));
      case StateRequest.serverFailure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Server Failure"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: onPressed,
                child: Text("Logout", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        );
      case StateRequest.failure:
        return Center(child: Text("Failure"));
      default:
        return child;
    }
  }
}
