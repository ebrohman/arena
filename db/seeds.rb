[
  {
    'name' => 'Puffer',
    'strength' => 12,
    'speed' => 21,
    'intelligence' => 22,
    'integrity' => 66
  },
  {
    'name' => 'Max',
    'strength' => 14,
    'speed' => 21,
    'intelligence' => 28,
    'integrity' => 68
  }
].map { |attrs| BattlePet.find_or_create_by!(attrs)}
