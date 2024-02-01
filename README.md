# zens_app

This is a simple Flutter mobile app that lets users search for and buy drinks

## Result
### In technically, the source code is achieved

- This app will display drinks fetched from an API.
- users can select drinks to the cart
- DO NOT use any state management library.
- DO NOT use setState.
- The less I rely on third-party libraries.
- Prioritize both scalability and maintainability in your coding approach.
- Thoroughly review your work before submitting it to the tester.
- The app is mobile responsive.

### In terms of application, the completed functions include:
- User interface according to design
- mark as favorite: this data is being saved locally

  ### example
  ```dart
return  Scaffold(
	backgroundColor:  Colors.white,
	body:  Container(
		child:  FoldableList(
			animationType:  ANIMATION_TYPE.NONE,
			foldableItems:  this.expandedWidgetList,
			items:  this.simpleWidgetList
		)
	)
);
```
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
