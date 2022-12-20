# MINESWEEPER GOLD

## __Introduction__
For my CS50 Final project, I have decided to recreate the classic video game Minesweeper with the Löve2D engine using the Lua programming language. 

My goal for starting CS50 was to help me get into the video-game development industry. What better project is there other than building a video-game from the ground up? I chose Minesweeper because it seemed to be one of, if not, the most accessible approach. Being a mostly static game, I knew it was the perfect game to clone with the right amount of challenge at my level of knowledge and experience (which was limited to everything CS50 teaches durong its 10 weeks course)

However, I did not want to only reproduce a game that has already been done, but try to enhance its design with additional features that would solve some major issues and create more opportunities for fun and interesting gameplay. That is how Minesweeper Gold was born.

Although I’m not quite sure when I started working on this project, the oldest file i have dates back to the 2nd of October. I intend to submit it for the end of December 2022.

I am very pleased and proud to say that, except for the font files, the « classic.lua » library of functions for creating Objects, the "conf.lua" file and the Löve2D framework, every line of code in the 35 files that makes this software work were written by me. I have never, at any point of the production of this game, relied on the work of someone else, everything has been created « in house » so to speak.

I have realized during the developpement process the way I’ve constructed this software may not have been « best practice » for Object-Oriented programming. However, as I was already months under way, I decided to keep it this way, and do better next project. Through out this document, i have included comments on how i have constructed this project, but also how I should have based on my understanding. That said, for my first project, I must say that I am completely satisfied with software that perform as intended.

Before delving into how this software operates, I would like to briefly touch on the overall design of the game.

Minesweeper Gold is based on the classic computer game Minesweeper created by Microsoft in the early 1990’s. It is a logic puzzle video game in which the player is presented with a grid of squares that may or may not hide mines. The goal is to clear all squares and avoid mines. To do that, each empty square contain a clue showing the number of mines directly adjacent of it. If the clue shows the number 2, this means that, among all the squares all around it, lie exactly 2 mines. By correctly considering all available clues, the player is able to clear the whole grid and avoid triggering a mine.

While the design of the original game is undeniably timeless, it has at least one major flaw which, in certain situations, can ruin its premise. In certain cases, the player may find themselves unable to discern which squares hide a mine and which ones do not, as illustrated in image 1.2. In this example, no clue gives away the position of the last mine, which forces the player to clear a square at random in order to go on. This goes against the logic based gameplay intended for the game and it is the issue I have set myself to solve.

To solve this issue, I have created 2 new features for the game: the first one is called Sweepers and the second one is Gold Squares.

Sweepers are tools that gives the player the ability to clear any squares without any consequences. However, there is a limited number of sweepers for every game and a certains amount of squares to clear to obtain one sweeper. Sweepers are precious ressources and players need to think about when and where is best to use them.

In addition to solving the issue I’ve mentioned, sweepers also fixes a somewhat trivial aspect of the game’s presentation. When I first worked on this project, and I took the position of a Game Designer, I’ve realized an incoherence between the name of the game, and it’s actual gameplay: in Minesweeper, you don’t actually sweep any mines, you only avoid them. Wouldn’t it be fun to actually sweep some mines in a game called Minesweeper? That’s what sweepers are for.

However, sweepers, while useful for some cases,  created their own issues. Mainly, the game became too easy: what stopped to player to blast through every mines their paths crossed with? I needed to find some obstacle that tipped the balance of the game back to equilibrium. I wanted to force the player into more interesting situations and take harder decisions whether to use a sweeper now, or keep it for later. Which is how I came up with Gold squares.

Gold squares can not be cleared in the same way other squares are: players need to use a sweeper  in order to clear them. Just like any other squares, they can hide clues or mines, which can be tricky if players need the information they conceal but don’t have enough sweepers to sweep them.

This dynamic between what the players know (cleared squares and their clues), what they don’t know (uncleared squares) and the choices they have to make (clear a square or sweep it) and their consequences (Is the clue the square they want to sweep will give them the information they need to progress) makes, in theory, an interesting take on this classic game while keeping its fundamental feel intact: you’re always one mistake away from blowing up. 

As the final project description prompts, i will go though all the files that makes this software, starting with "main.lua".

## __main.lua__ 
In order to write a game using the LÖVE2D engine, one must include a file named « main.lua » and locate it at the root directory of the project. Inside this file lie the three fundamental callback functions of the engine:

```
function love.load()
end

function love.update()
end

function love.draw()
end
```

Love.load() is used to load all the necessary data and functions in order to run the initial state of the game. Love.update() updates said state using other functions to adapt the software to inside or outside change (like animations or user input, among others). Finally love.draw() draws all elements on the screen. Additionally, other optional callback functions can be added here, like love.keypressed() or love.mousemoved() which respectively watches if a key of the keyboard is pressed and if the mouse has moved. Any other other lines of code could be written here, however, for clarity sake, I’ve limited only necessary functions and variables to this file.

My goal for this file was to make it as plain and clear as possible. That meant including the bare minimum of code in order to make it as easy to read as possible. In other words, I wanted this file to read as a map leading to other files to make understanding its structure straightforward.

While I think I have achieved this level of readability at this level, I realize now that a misunderstanding of how classes and objects work and should be used has severely degraded its overall readability the deeper you go in the structure, especially for the UI directory.

During the majority of development, I didn’t understand that multiple objects could be created using a single class, instead, I created a class for each object. For example, instead of creating a single class called « UIContainer », using it to create all instances of the UI, extending it and creating mixins when needed, I created as many classes as objects, which is highly inefficient, time wasting, and results in a plethora of unnecessary files and weighs the whole project down and makes finding anything a pain. Changing how the whle project is structured would basically means rewriting it from scratch and would take a lot more time that i would like to spend on it (which already is about three months) However, the software doesn’t seem to be bothered too much, it runs as intended. 

At the very beginning of the file, I have included the version of the software I am using, mostly as a reminder. Below this are the five files required for main.lua to run. Finally, before the love.load() are the seed variables needed to create a game of Minesweeper Gold.

1. mapMode
    - The « map » of the game is how I call the actual grid of squares the player sees and clicks on during play. The variable defines wether the data used to build this map is from a set of preset or custom variables, as determined either from the initial boot of the game, or from player input in the menu screen  (which I’ll talk about later on). The two options for this variable is « presets » or « custom »
2. mapSize
    - If the mapMode is set to « presets », mapSize determines the number of rows and columns the grid will have.
    - Three options are available: « small » (9 rows, 9 columns), « medium » (16 rows, 16 columns) or « big » (30 rows, 16 columns). 
    - I have chosen these presets metrics in accordance to other Minesweeper games which have similar preset map sizes.
3. difficulty
    - If the mapMode is set to « presets », difficulty determines the rate of the number mines, gold squares and bonus sweepers depending on the total number of squares.
    - Much, if not all, of the game balance lies in these three variables as they also determine the maximum amount of sweepers available for one game (« sweepers.max ») the number of squares to clear required to gain one sweeper (« sweepers.required ») and the total number of squares available to gain sweepers (« sweepers.limit »). I will go in more depth into how I approached game balance later on.
    - The difficulty variable takes one of three options : « easy », « normal », « hard ».
4. gameMode
    - Finally, gameMode defines in which of the two available modes the game will run: « gold » or « classic »
    - Because Minesweeper Gold is built on top of the original game, I wanted to make sure the option of playing both was available for the player. It would have felt as a missed opportunity otherwise.
    - If gameMode is set to « classic », the variables for gold, sweepers.max, sweepers.required and sweepers limit are all set to 0, and the player will be able to enjoy a classic game of Minesweeper.

In order to create a new game, th eplayer needs to either click on the "new" button, located at the top-right corner of the screen, or push the "n" key of the keyboard. Doing so will trigger love.load() to create a new game based on the metrics selected in the menu screen. This is the reason why the "seed" variable is placed outside any functions as a global variable. Otherwise, love.load() would change all of its data to what it was originaly. In other words, having "seed" as a global variable enable me to create a new game with a fresh set of metrics any time i want.

### *love.load()*
Love.load() has only four elements:
* gameplay
* map
* ui
* debug

As succinct as it seems, the first three objects make up the whole software.

1. gameplay
    - The gamePlay object handles the game’s states (« start », « play », « paused » and « over »), the settings of the map (based on the data from the « seed » variable as seen previously), sweepers and several other functions which dictates how the game should behave (like how it starts, how it ends, what to do when which button is pressed, etc..)
2. map
    - The map object is tasked to build and update the grid of squares the player will see and interact with once drawn.
3. ui 
    - The ui object processes all the coordinates of the user interface based on the size of the window as well as all of their functionnality. It is also linked to gamePlay and map to extract some key information serving the user experience (like the dashboard).

Finally the debug object is a tool I built and used to help me with the development of the software. When activated, it reveals all squares. It is only accessible from the source code.

Following love.load() are love.update() and love.draw(). The only notable thing to say is that I’ve gathered every line of drawing code into the ui object, so if something looks wrong on screen, I know where to look.

What comes next are all callback functions tied to user input from the mouse and the keyboard:

1. love.wheelmoved()
    - Here is where the mouse wheel is tied to the zooming feature.
2. love.keypressed()
    - This function links certain keys to certain features. 
    - Everyone of these features can be activated from the game, by clicking on virtual buttons on the ui using the mouse. However, I wanted more options available for the player, for the sake of user experience and accessibility.
3. love.mousepressed()
    - Handles which button of the mouse is pressed, which I pass on to specific « onClick » methods of several objects
4. Love.mousemoved()
    - Detects the changes of position of the mouse which I pass on to a method of the ui object.


## conf.lua and ASSETS
conf.lua is one of the couple ones I have not actually written. It contains the love.conf() function which runs before love.load() in order to overwrite the initial configurations of the engine to customize how to game runs. I have included the exhaustive list of variables for configurations, but the only ones I’ve ever modified are the window.width and window.length to simulate the size of a phone screen. I also often used the window.fullscreen variable to test if my UI behaved as intended, but for the final version of the game, I left it as false.

As for ASSETS, it is the directory in which i've placed the font i've used throughout the software. It is of course free to use.

## LIBS

Short for "Libraries", LIBS contains 2 files:
- classic.lua
- helpers.lua