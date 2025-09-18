# Fish For Thought
A [fishing themed digital journal](https://youtu.be/_w8JkJIDEeA) that helps you reel in your emotions. Practice mindfulness and jot down your thoughts for new fishy pals!

<video src="https://github.com/user-attachments/assets/882406c9-0119-49fb-b94b-9a630faa368e" width="800" /></video>

### Runner-up for the [Martian API](https://www.withmartian.com) Sponsorship Prize
Backend requires the Demois Router to run: https://github.com/withmartian/deimos-router

Original Devpost Submission to Hack the North 2025: [Devpost](https://devpost.com/software/fish-for-thought)

### Inspiration
Inspired by the tranquil experience that fishing by the shore offers, **Fish for Thought** aims to help users reflect and log what they did and felt throughout their day. 

Generally, people love custom experiences. Mildly inspired by the popularity of daily horoscopes, Fish For Thought gives users a custom breakdown of the emotions and things they did that day through a cute journaling interface, intended to be for mobile so it can be done on the go.  

![inthepond](https://github.com/user-attachments/assets/e0222b65-6c36-4846-b5a5-c1d213f2e59e)

### What It Does

In this game you write down a journal entry, our AI analyzes the tone, and then you're awarded a special fish that represents that emotion. For example, a joyful entry might get you the cheerful Mola Mola, while a calm entry might get you a tranquil Koi. Our goal is to gamify self-care, turning a personal reflection into a relaxing and visually satisfying experience.

### Sponsored Tools
- Windsurf: Backend was build entirely AI‑native IDE workflow, helped greatly with integrating Martian since some examples were broken. Frontend was made in Godot's native editor, as Windsurf is not made for game development, though it was used to help with GDScript generation.
- Martian: Use it to access OpenAI models and pick which models were ideal for the task using the Deimos Router's Autotask ruleset. Message Length rules were also used.

### How We Built It
- Frontend: Godot/GDScript
- Backend: Python/Flask
- AI Integration: Martian's Deimos Router
- Tools: Windsurf IDE

It was really interesting to get to use Windsurf for game development. Although we ran into some issues since it's not specialized for this, it did help make .gdscript files (pretty similar to python) and overall quickened the development. It also helped in integrating the Martian API, especially because a few of the examples didn't work out of the box.

The Martian Deimos Router API is the real star of the show and the backbone to the game, generating custom descriptions of the fish to the users that use a mix of sentiment analysis for their journal, creative writing, and real fish facts!!! 

Fish For Thought uses Martian to decide on the best models given the length of the journaling that day, as well as whether the journal might require some more thought provoking analysis, or gentle reassurance, help summarizing, or more! It also gives a name to emotions, when it might not be immediate obvious what you're feeling. This is a general boon of journaling, but using AI also helps specifically draw out subtle cues towards your moods for the day.

(And considering the entire project took less than a dollar of the free credits given it seems to be working)

### Challenges
- Learning how to do UI heavy work in Godot, and learning to use its tools correctly
- Coming up with an idea that mixed both game development and AI integration (given the opportunity to work with so many tools for free)
- Deciding how to best use Martian's unique ability to pick which model should be used, and which tasks we would use AI for to help augment user experience

### Accomplishments We're Proud Of
- Custom drawn art for the whole app
- Getting to make a game
- Implementing a full back-end for a mobile game
- Getting so much free food

### What We Learned
- What features are core and what needs to be cut in the face of a time crunch :')
- The strengths and weaknesses of AI powered development tools
- Which models work best for each task, and how to fine-tune prompts so outputs are consistent enough to parse and store within a structured system (fish and descriptions).

### What’s Next
- Fish interactions: Originally planned but cut for time. Users could “talk” to their fish, a whimsical way to process thoughts and feelings with AI guidance that doesn't feel too "serious"

- Adaptive responses: Martian’s auto task routing could handle open-ended questions, adjusting based on what users want from reflection.

- Look back: Revisit past catches and analyze moods from especially good or tough days once there’s space to process.

- Bigger patterns: With a week or month of entries, AI could spot trends—like certain people, places, or situations tied to recurring emotions.

- Find a niche fit: Like Finch or Habitica, but focused on journaling—gamified self-care through collecting and interacting with fish.

- Privacy: Data handling needs careful attention, but existing practices can cover this.

![gallery](https://github.com/user-attachments/assets/8816e7cd-2b48-4725-aaef-68346f3bc0ae)


### Last Thoughts

Of course, Fish For Thought is not doing anything AI can't already do. Rather, it's intended to use existing models in a unique and relaxing environment that will allow users to use it to its full potential. User experience is important, and as AI gets more and more integrated into our lives, it's important to think about *how* we want to integrate it and what customization could people want. What makes it unique is the interactive, playful environment that turns AI from a tool into a character you can engage with. By embedding AI into a game, users get real-time, personalized responses that feel alive, creating a sense of companionship and whimsy. The game format
