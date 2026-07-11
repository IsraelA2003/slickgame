# Dicebound: Skeleton Crypt — Combat Overhaul

This version includes situational detection encounters and a full turn-based combat rebalance.

## New mechanics

- Archer attacks are telegraphed for one full turn.
- Red targeting lines show incoming shots.
- Hitting an aiming archer interrupts the shot.
- Pillars, statues, crates, and walls block arrows and line of sight.
- Press Shift or click Dodge to evade the entire next enemy phase.
- The player has two dodge charges; one recharges after several player turns.
- Skeleton attacks roll two dice for variable damage.
- Double sixes cause enemy critical hits.
- Archer damage and detection range are reduced.
- Melee skeletons are slightly stronger.

## Controls

- Explore: hold WASD or arrow keys
- Combat move: tap WASD or arrow keys
- Select enemy: click
- Attack: Space or Roll Attack
- Dodge: Shift or Dodge button

## Deploy to AWS

Upload all files to the `IsraelA2003/dicebound-roguelike` repository, then run on the EC2 instance:

```bash
sudo /usr/local/bin/update-dicebound
```

Open the instance using HTTP:

```text
http://YOUR-EC2-PUBLIC-IP
```


## Expanded World and Shop Update

- The dungeon world is now much larger than the viewport and uses a scrolling camera.
- A minimap appears in the upper-right corner.
- Explore to find gold piles, health pickups, and treasure chests.
- Gold pickups and enemy rewards persist throughout the run.
- After floors 5, 10, 15, and every fifth floor after that, a merchant shop appears.
- Shop purchases include healing, max HP, damage, critical chance, armor, movement speed, attack range, and extra dodge capacity.
