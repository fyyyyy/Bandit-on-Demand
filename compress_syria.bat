
powershell -Command "Copy-Item -Force './scripts/bandit_on_demand.lua' -Destination '.\Bandit on Demand Syria\l10n\DEFAULT\bandit_on_demand.lua'"
powershell -Command "7z a -tzip BanditonDemand_Syria.zip '.\Bandit on Demand Syria\*'"
powershell -Command "Copy-Item -Force './BanditonDemand_Syria.zip' -Destination 'C:\Users\frank\Saved Games\DCS\Missions\Bandit on Demand Syria.miz'"
powershell -Command "rm './BanditonDemand_Syria.zip'"
