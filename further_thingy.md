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
- Xiaomi Redmi 3S problem cause of Adreno 505 (known issue: Adreno (3xx and 5xx series) bad implementation of OpenGL ES 3.0), mali chipsets also have problem (un-verified)

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


### GUI
resolution (16:9) = 504 x 896
1. drive_pieces:
    - replace color:
        from : fff200
        to   : 1e77d0

### Unity3D Multiplayer github:
1. https://github.com/david-alejandro-reyes-milian/unity3d-super-metroid-multiplayer
2. https://github.com/msukkari/A-Distant-Path
3. https://github.com/Ziririn/HeroesArena
4. https://github.com/jallen720/unity-multiplayer
5. https://github.com/KatVHarris/UnityMultiplayer
6. https://github.com/SocketWeaver/karting
7. https://github.com/masseydigital/unity-multiplayer-tutorial
8. https://github.com/pulinho/donttrip
9. https://github.com/jewong42/dungeon-game
10. https://github.com/BeardedManStudios/ForgeNetworkingRemastered
11. https://github.com/corpusc/Paramancer
12. 

#### Pertanyaan:
~~a. untuk score yg complete:
    contoh:
    - complete pada shots ke 3, bonus: 1500
    - 11 kotak ijo sebelumnya
    - 5 kotak menjadi ijo pada shots ke 3
    - 7 piece yg chain interlocked
    - apakah kalkulasinya (5 x 7) + 1500 atau (5 x 5 x 7) + 1500 atau (11 x 5 x 7) + 1500 ?~~


### Pdf Search and Hghlighting Module
- What version of MacOS ??? Mojave (download Mojave newest (10.14.xx) Image)
  - Installed are version: 10.13.4 High Sierra 
- What version of XCode ??? 10.2
  - download manual (6-7GBs) XCode Version: https://xcodereleases.com/
  - https://developer.apple.com/download/more/
- Need to download Swift too.. the newest..
- What kind of framework or Library used for parsing the PDF file ??? PDFKit

[ ] search module
[ ] outline navigation module

#### search pdf text in PDFKit:
- https://stackoverflow.com/questions/50609526/how-to-search-a-pdf-using-pdfkit-in-swift
- https://stackoverflow.com/questions/48925001/pdfview-doesnt-highlight-search-results
- https://medium.com/@jdoth/pdfkit-pdfview-8f2be66a4c8f
- https://stackoverflow.com/questions/51709014/searching-in-pdfs-increases-apps-memory-usage-too-much
- https://github.com/rajubd49/PDFKit_Sample
- https://github.com/kishikawakatsumi/BookReader
- https://github.com/tzshlyt/iOS11-PDFKit-Example
- https://pdfkit.org/docs/text.html
- https://stackoverflow.com/questions/50575299/searching-pdf-using-pdfkit-in-swift
- https://equaleyes.com/blog/2018/02/02/introducing-pdfkit-the-right-way-to-treat-your-pdfs-on-ios/
- https://medium.com/@ji3g4kami/make-a-ebook-reader-with-pdfkit-in-swift-6010f82bd51
- https://frameworker.wordpress.com/2018/07/27/pdfkit-the-lost-samples/
- https://medium.com/@artempoluektov/ios-pdfkit-ink-annotations-tutorial-4ba19b474dce
- 

#### resizeableView:
- https://github.com/spoletto/SPUserResizableView
- https://github.com/ppoh71/resizeRectangleOnTouchDrag/blob/master/ResizeRectangle/ViewController.swift
- https://github.com/RajatJain4061/RKUserResizableView
- 

### Bahasa Indonesia bahan kuis:
- Kata
    > Subjek:
    > - pelaku
    > - pengalam

    > Predikat:
    > - tindakan subjek
    > - kondisi / situasi / perasaan / keadaan / sifat subjek
    > - peran subjek

    > Objek:
    > - Target tindakan / sasaran
    > - pendamping

    > Keterangan:
    > - waktu
    > - tempat
    > - cara
    > - frekuensi

- Frasa:
    > kelompok kata / non-predikatif
    > - _gabungan dari dua kata atau lebih namun tidak dapat membentuk kalimat sempurna karena tidak memiliki predikat._

- Klausa:
    > kelompok kata yang merupakan bagian kalimat yang dasarnya memiliki **subjek dan predikat**.

- Kalimat
    > urutan kata yang logis dan berakhiran dengan titik.

- Kalimat Efektif
    > kalimat yang mengikuti kaidah-kaidah kebahasaan yang baik dan benar.

- Paragraf
    urutan kalimat yang terdiri dari satu pikiran pendek dan penjelas.
    > ciri paragraf yang baik:
    > 1. satu pikiran utama.
    > 2. ada kalimat penjelas.
    > 3. antar kalimat saling berkaitan.

- Tugas dua paragraf:
Tema: Perkembangan Informasi Teknologi
- apa yg dimaksud dengan informasi teknologi?
    > Teknologi informasi merupakan suatu teknologi yang digunakan untuk mengolah dan memanipulasi data dengan berbagai cara agar menghasilkan informasi yang berkualitas.

- mengapa informasi teknologi itu penting?
    > Seiring dengan perkembangan teknologi dan globalisasi, jumlah dan ukuran informasi yang dihasilkan pun meningkat. Oleh karena itu, dibutuhkan cara agar dapat mengolah dan memanipulasi informasi-informasi tersebut sehingga dapat digunakan secara relevan, strategis, akurat dan tepat waktu. Teknologi informasi pun berkembang seiring dengan perkembangan teknologi untuk menjawab tantangan dalam mengolah dan memanipulasi informasi.
    
    >Perkembangan teknologi informasi ini didorong oleh berbagai kepentingan, seperti kepentingan pribadi, bisnis, dan pemerintahan dalam menggunakan hasil olahan dan manipulasi dari informasi tersebut. Hal ini dikarenakan oleh kemampuan teknologi informasi dalam menolong memecahkan suatu masalah, serta meningkatkan efektivitas dan efisiensi dalam menyelesaikan pekerjaan.

- bagaimana keadaan informasi teknologi sekarang?