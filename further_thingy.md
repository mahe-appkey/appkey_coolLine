```c++
for 1 rotation:
0 + 1 = 1
1 + 1 = 2
2 + 1 = 3
3 + 1 = 4 => 0 : (3+1)-(4-(3-3))

(numDisk[i]+num) - (4-(i-numDisk[i]))

for 2 rotation:
0 + 2 = 2
1 + 2 = 3
2 + 2 = 4 => 0 : 2 + 2 - 3 => (2+2) - (4 - (2-2)) = 0
3 + 2 = 5 => 1 	=> (3 + 2) - (4 - (3 - 3)) = 1

(numDisk[i]+num) - 4
for 3 rotation:
0 + 3 = 3
1 + 3 = 4 => 0 => (1+3) - 4 = 0
2 + 3 = 5 => 1 => (2+3) - 4 = 1
3 + 3 = 6 => 2 => (3+3) - 4 = 2
```
```plantuml
digraph Test {
A -> B
}
```

inventory system for drag n drop n snapping:
https://github.com/RodZill4/godot_inventory

https://github.com/GDquest/make-pro-2d-games-with-godot/tree/master/interface/menus

https://github.com/search?utf8=%E2%9C%93&q=gdscript+language%3AGDScript&type=Repositories&ref=advsearch&l=GDScript&l=

https://github.com/GDquest

godot 3 tutorial list:
https://www.reddit.com/r/godot/comments/an0iq5/godot_tutorials_list_of_video_and_written/

for fixing the lagged issue on VSCode:
https://github.com/Microsoft/vscode/issues/15211


### Estimation time on COOL LINE <MAX11> (deadline 26 Juni 2019 full Android and IOS) 
- squares/tile: $4 \times 4 = 16 squares$
- 10 rounds, each round has 4 shots/chances; total would be 40 shots (20 to 40 ???)
- linkage or chaining limit is 11 times
- 

### to do or experiment:
- [x] rotation using tween node in the sprite class, test if it can be added as child or parent, directly?
- [x] change the instance? from full script to prefabs?
- [x] game control
- [x] tes build into android
    - [x] download build template and bring it to appkey (400MB++)
- [ ] tes build into iOS
- [ ] menu
    - [ ] main menu
    - [ ] score/ranking
    - [ ]
    - [ ] option
- [ ] transition when round end + calculation
- [ ] sounds
- [x] score calculation
- [x] state for drag and drop

### questions?
- [ ] if every new rounds, all board are turned back to brown, but keep the pieces/drives position and orientation, what about the randomize empty space? change or not?
- [ ] how about the calculation? score calculation when not complete and score calculation on complete?
- [ ] what are the theme and color composition?
- [ ] what about the assets?
- [ ] to how much degree should the animation done?

### problems
- ~~can't download openjdk or any other jdk for test build Android.~~
- ~~make sure to download/use JDK 8, for Godot~~
- AdMob in Godot need several Module and rebuild project
- ~~tween inside loop became a problem, because it skipped everything,
and only appear at the end, which is a problem.
either change the animation, or make node instead generate it directly from script.~~
- ~~tween must be inside process function to be able processed with time frame~~

- ~~disk value not updated correctly, it use the before rotation value~~

#### direction chaining edgecases:
num_column = 4
num_slot = 16
- no UP: 0,1,2,3 => 
```
0 <= x < num_column
```
- no DOWN: 12,13,14,15 => 
```
(num_slot/num_column)-1 <= x < num_slot
```
- no LEFT: 0,4,8,12 =>
```
for i in range(num_colomn):
    no_left[i]=i*num_column
```
- no RIGHT: 3,7,11,15 =>
```
for i in range(num_column):
    no_right[i]=no_left[i]+(num_column-1)
```

#### route
1. use next to probe, if blocked change dir
2. if next is okay, change cur, and do animation etc
3. back to one

        
#### How to Play
1. Pieces are divided into four sections, each representing a number between 0 and 3, the sections colored red are the trigger point.
2. When a piece moved to an empty space, chain linkage will start in the direction of trigger point.
3. Pieces that in the chain linkage direction will rotate counter-clockwise by the number displayed in the previous pieces.
4. If in the chain linkage direction, interlocking encounter empty space, perimeter or number of previous pieces are 0 (chain blockage), chain linkage direction will turn to the left.
5. Chain linkage will stop if the 11 pieces interlocked or chain linkage encounter two times of chain blockage in a row in the same square.
6. When interlocking happened, piece's square will be activated from brown to green. Each square could only activated once.
7. Game consist of 10 rounds, in each round, player have 4 chances/shots in order to activated as many square as possible.
8. In each round, all square will be deactivated, while pieces direction and location will be maintained. Round end if all the square activated or player used all 4 chances/shots.

#### How to Score
1. If all square activated, the rounds will end and calculation for the score begin. Bonus score given determined by the number of remaining shots when all square activated.
    - 2 shots remaining, Bonus Score: 2000
    - 1 shots remaining, Bonus Score: 1500
    - 0 shots remaining, Bonus Score: 1000
    Score Calculation:
    Score = (Fp x Fs) + Bonus
    Fp: number of pieces interlocked in final shot
    Fs: number of activated square in final shot

2. If rounds end while not all square activated, score calculation would be:
    Score = (As x 10)
    As: number of activated square in the current round
