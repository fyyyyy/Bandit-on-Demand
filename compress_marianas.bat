
powershell -Command "Copy-Item -Force './scripts/bandit_on_demand.lua' -Destination '.\Bandit on Demand Marianas\l10n\DEFAULT\bandit_on_demand.lua'"
powershell -Command "7z a -tzip BanditonDemand_Marianas.zip '.\Bandit on Demand Marianas\*'"
powershell -Command "Copy-Item -Force './BanditonDemand_Marianas.zip' -Destination 'C:\Users\frank\Saved Games\DCS\Missions\Bandit on Demand Marianas.miz'"
powershell -Command "rm './BanditonDemand_Marianas.zip'"
