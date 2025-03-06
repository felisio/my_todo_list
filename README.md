# ✅ My Todo List

## A beautiful to-do list to you enjoy 🌼

## Getting Started

To run the project follow the instructions

- rename the .env_example file to .env and set your open AI key this way: (If you don't have OpenAI key click [here](https://help.openai.com/en/articles/4936850-where-do-i-find-my-openai-api-key) to find instructions)

```
OPENAI_API_KEY=YOUR_KEY

```

- The app is using [Device Preview](https://pub.dev/packages/device_preview) so you just need run the script: `flutter run` in your bash
- If you have some emulator already opened the app will open on the emulator (android or IOS) otherwise you can choose to open as a MacOS application, the app **doesn't have support the open on Chrome yet**
- If something goes wrong this APP was create in Flutter so you can find more structions [here](https://docs.flutter.dev/get-started/test-drive)
- Emjoy the app and send some feedbacks 😎

## Why you'll love My Todo List?

- **✨ AI Magic List**: Just describe what you need to do, and our smart AI will create your to-do list in seconds. No more staring at a blank screen – our AI robots do the heavy lifting!

- **🎨 Modern & Vibrant Design**: With a sleek, colorful interface and a cool animation, My Todo List is as stylish as you are. With beautiful colors and cool icons you gonna love create to-do lists here.

- **💬 Teen-Friendly Vibes**: Designed with you in mind, My Todo List speaks your language. From school projects to weekend plans, it’s the perfect sidekick for your busy life.

## Perfect For:

- 👧🏼 Students: Stay on top of homework, exams, and extracurriculars.

- 🙋🏻‍♀️ Social Butterflies: Create your to-do list for parties, weekend on the beach, your for you travel planning

- 💭 Dreamers: Turn your big ideas into items and make them happen.

## How the UI assistance works:

1 - **Describe Your Tasks**: Tell My Todo List what you need to do – like "List to buy in the supermarket, clean my room, and plan a movie night."

2 - **AI Creates Your List**: Watch as My Todo List instantly generates a clear, organized to-do list with the categories.

3 - **Get It Done**: Check off tasks, and feel the satisfaction of crushing your goals! 💪

## 📲 Technical thoughts

### 1 - Identify the problem and my goals

After see de description I decided for create a modern to-do app that appeals to teenagers/young people and simplifies task management. I knew that I also needed to create an AI integration, so I my main focus was:

- Create a Modern UI thinking in my public target
- Create a simple to-do list that the user can create, delete, and mark the task as done
- Add categories for that list with icons this way the user can indentify your task easily
- Integrate with some AI assistant, this way the user can describe what he needs and the app will create the list
- User can be able to clean the list and remove all items
- Create at least one animation bringing more style to the app

### 2 - Breaking down the solution

To solve my goals I divided my solution in few parts:

- Create and initial configuration of the solution
- Create the UI (Screen, Forms, and Widgets)
- Create the Models
- Integrate the Models with the UI
- Add the Storage and integrate with Models
- Add AI assistante
- Add Animation
- Fix some Bugs, Tech Debits, and Improvements

### 3 - Technical Choices:

- AI Model: Used OpenAI's GPT-3.5 for natural language processing (NLP).
- Storage: Used [Hive](https://github.com/isar/hive)
- Animation: Used [confetti](https://pub.dev/packages/confetti)
- Dropdown: used [dropdown_search](https://pub.dev/packages/dropdown_search)
