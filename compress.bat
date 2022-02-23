
@REM extract
@REM powershell -Command "7z x -aoa 'C:\Users\frank\Saved Games\DCS\Missions\Bandit on Demand.miz' -o'.\Bandit on Demand\'"
@REM powershell -Command "7z x -aoa 'C:\Users\frank\Saved Games\DCS\Missions\Bandit on Demand Syria.miz' -o'.\Bandit on Demand Syria\'"

@REM compile and copy
powershell -Command "Copy-Item -Force './scripts/bandit_on_demand.lua' -Destination '.\Bandit on Demand\l10n\DEFAULT\bandit_on_demand.lua'"
powershell -Command "7z a -tzip BanditonDemand.zip '.\Bandit on Demand\*'"
powershell -Command "Copy-Item -Force './BanditonDemand.zip' -Destination 'C:\Users\frank\Saved Games\DCS\Missions\Bandit on Demand.miz'"
powershell -Command "rm './BanditonDemand.zip'"