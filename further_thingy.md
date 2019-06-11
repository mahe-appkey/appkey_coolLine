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


(deadline 26 Juni 2019 full Android and IOS)
### Estimation time on COOL LINE <MAX11> 
- squares/tile: $4 \times 4 = 16 squares$
- 10 rounds, each round has 4 shots/chances; total would be 40 shots (20 to 40 ???)
- linkage or chaining limit is 11 times
- 