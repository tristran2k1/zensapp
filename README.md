# zens_app

This is a simple Flutter mobile app that lets users search for and buy drinks

## Result
### In technically, the source code is achieved

- Architectural model: Clean architecture
  
  ![image](https://github.com/tristran2k1/zensapp/assets/60394372/348b7aeb-db38-4b32-a832-559b35e92d54)

- This app will display drinks fetched from an API.
- DO NOT use any state management library.
- DO NOT use setState: `ValueNotifier` and `Stream` instead
- The less I rely on third-party libraries.
```yaml
shared_preferences: ^2.2.2
flutter_svg: ^2.0.9
intl: ^0.19.0
```
- Prioritize both scalability and maintainability in your coding approach.
- Thoroughly review your work before submitting it to the tester.
- The app is mobile responsive.

### In terms of application, the completed functions include:
- User interface according to design
- Mark as favorite: this data is being saved locally
- Choose dishes, customize size, toppings, other options, quantity of dishes ordered
- The price of the item is updated as soon as the user adjusts the selections
- After placing an order, the order will be saved in the cart (local database) for the user to continue selecting items

## Demo video

https://github.com/tristran2k1/zensapp/assets/60394372/2bfbb212-5081-4247-9fc2-eeaf492472d4




