
powershell -Command "Copy-Item -Force './scripts/spawn_ctrl.lua' -Destination '.\Bandit on Demand\l10n\DEFAULT\spawn_ctrl.lua'"
powershell -Command "7z a -tzip BanditonDemand.zip '.\Bandit on Demand\*'"
powershell -Command "Copy-Item -Force './BanditonDemand.zip' -Destination 'C:\Users\frank\Saved Games\DCS\Missions\Bandit on Demand.miz'"