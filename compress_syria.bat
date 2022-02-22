
powershell -Command "Copy-Item -Force './scripts/spawn_ctrl.lua' -Destination '.\Bandit on Demand Syria\l10n\DEFAULT\spawn_ctrl.lua'"
powershell -Command "7z a -tzip BanditonDemand_Syria.zip '.\Bandit on Demand Syria\*'"
powershell -Command "Copy-Item -Force './BanditonDemand_Syria.zip' -Destination 'C:\Users\frank\Saved Games\DCS\Missions\Bandit on Demand Syria.miz'"