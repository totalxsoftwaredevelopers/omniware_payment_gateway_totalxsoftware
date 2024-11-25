import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Displays a loading dialog to the user.
///
/// This function shows a custom loading dialog with an activity indicator
/// and a message "Please wait...". It prevents the user from interacting
/// with the rest of the UI while the dialog is visible.
///
/// [context]: The [BuildContext] used to display the dialog.
void showProgress(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const _CustomLoadingDailog(),
  );
}

// ignore: must_be_immutable
/// A custom loading dialog widget that shows an activity indicator and a message.
///
/// This widget displays a loading dialog with a message "Please wait..." and
/// prevents user interactions while the dialog is visible. The dialog cannot
/// be dismissed by tapping outside of it, as the `canPop` property is set to false.
///
/// The dialog consists of a [CupertinoActivityIndicator] to indicate loading
/// and a text message to inform the user about the ongoing process.
class _CustomLoadingDailog extends StatelessWidget {
  const _CustomLoadingDailog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: PopScope(
        canPop: false, // Prevents dialog from being dismissed by tapping outside
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200, // Adjust the width
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 25),
                  CupertinoActivityIndicator(
                    color: Colors.black,
                    radius: 12,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Please wait...',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
