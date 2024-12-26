# The Field

You are on The Filed. Survive as long as you can!

## What?

This is a Quake mod inspired by [Devil Daggers](https://store.steampowered.com/app/422970/Devil_Daggers/).

I wanted to learn about Quake modding and QuakeC, so I created this.

I do not plan to continue the development, but feel free to fork it and make it better.

## How?

Download [Q.wad](https://www.quaddicted.com/files/wads/q.zip) and extract it to `/wad`.

I used the original `qutils` from id to develop this mod, I've created a version that can be compiled on modern systems: [qutils](https://github.com/g0mb4/qutils).

Compile `qutils` and add them to your `PATH`, then, depending on your OS:

**Windows**
```
build.bat
```

**Linux**
```
make
```

If the command succeded the `thefiled` directory will be present. Copy it next to your favourite Quake
executable (where `id1` folder lives) and launch it with `-game thefield +map thefield` arguments.

There is a `thefield.bat` as an example in the release, by default is uses the steam version.

## Anything else?

The resources I used:

+ [QuakeC Reference
Manual](https://pages.cs.wisc.edu/~jeremyp/quake/quakec/quakec.pdf) for QuakeC.

+ Jason2Brownlees [CleanFixedQuakeC](https://github.com/Jason2Brownlee/CleanFixedQuakeC) as the base.

+ [TrenchBroom](https://trenchbroom.github.io/) for editing the map.

+ quakewikis [modding page](https://quakewiki.org/wiki/Main_Page) for useful tips/examples.

Tested with [quakespasm](https://github.com/sezero/quakespasm) and the [official rerelease version](https://store.steampowered.com/app/2310/Quake/).
