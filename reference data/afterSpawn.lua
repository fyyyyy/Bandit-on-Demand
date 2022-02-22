dataAfterRespawn_Teleport = {
    ["visible"] = false,
    ["modulation"] = 0,
    ["tasks"] = {},
    ["radioSet"] = false,
    ["startTime"] = 0,
    ["task"] = "CAP",
    ["uncontrolled"] = false,
    ["route"] = {
        ["points"] = {
            [1] = {
                ["alt"] = 6096,
                ["type"] = "Turning Point",
                ["action"] = "Turning Point",
                ["alt_type"] = "BARO",
                ["form"] = "Turning Point",
                ["y"] = 764014.376,
                ["x"] = -280295.264,
                ["speed"] = 220.97222222222,
                ["task"] = {
                    ["id"] = "ComboTask",
                    ["params"] = {
                        ["tasks"] = {
                            [1] = {
                                ["number"] = 1,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = true, ["name"] = 17}}
                                }
                            },
                            [2] = {
                                ["enabled"] = true,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["number"] = 2,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 4, ["name"] = 18}}
                                }
                            },
                            [3] = {
                                ["enabled"] = true,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["number"] = 3,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = true, ["name"] = 19}}
                                }
                            },
                            [4] = {
                                ["enabled"] = true,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["number"] = 4,
                                ["params"] = {
                                    ["action"] = {
                                        ["id"] = "Option",
                                        ["params"] = {
                                            ["targetTypes"] = {},
                                            ["noTargetTypes"] = {
                                                [1] = "Fighters",
                                                [2] = "Multirole fighters",
                                                [3] = "Bombers",
                                                [4] = "Helicopters",
                                                [5] = "Infantry",
                                                [6] = "Fortifications",
                                                [7] = "Tanks",
                                                [8] = "IFV",
                                                [9] = "APC",
                                                [10] = "Artillery",
                                                [11] = "Unarmed vehicles",
                                                [12] = "AAA",
                                                [13] = "SR SAM",
                                                [14] = "MR SAM",
                                                [15] = "LR SAM",
                                                [16] = "Aircraft Carriers",
                                                [17] = "Cruisers",
                                                [18] = "Destroyers",
                                                [19] = "Frigates",
                                                [20] = "Corvettes",
                                                [21] = "Light armed ships",
                                                [22] = "Unarmed ships",
                                                [23] = "Submarines",
                                                [24] = "Cruise missiles",
                                                [25] = "Antiship Missiles",
                                                [26] = "AA Missiles",
                                                [27] = "AG Missiles",
                                                [28] = "SA Missiles"
                                            },
                                            ["name"] = 21,
                                            ["value"] = "none;"
                                        }
                                    }
                                }
                            },
                            [5] = {
                                ["enabled"] = true,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["number"] = 5,
                                ["params"] = {
                                    ["action"] = {
                                        ["id"] = "Option",
                                        ["params"] = {
                                            ["value"] = 196609,
                                            ["variantIndex"] = 1,
                                            ["name"] = 5,
                                            ["formationIndex"] = 3
                                        }
                                    }
                                }
                            },
                            [6] = {
                                ["number"] = 6,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = true, ["name"] = 26}}
                                }
                            },
                            [7] = {
                                ["number"] = 7,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 3, ["name"] = 3}}
                                }
                            },
                            [8] = {
                                ["number"] = 8,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 0, ["name"] = 1}}
                                }
                            },
                            [9] = {
                                ["enabled"] = true,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["number"] = 9,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 0, ["name"] = 0}}
                                }
                            },
                            [10] = {
                                ["number"] = 10,
                                ["auto"] = false,
                                ["id"] = "EngageTargets",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["targetTypes"] = {[1] = "Planes"},
                                    ["noTargetTypes"] = {
                                        [1] = "Helicopters",
                                        [2] = "Cruise missiles",
                                        [3] = "Antiship Missiles",
                                        [4] = "AA Missiles",
                                        [5] = "AG Missiles",
                                        [6] = "SA Missiles"
                                    },
                                    ["value"] = "Planes;",
                                    ["priority"] = 0,
                                    ["maxDistEnabled"] = false,
                                    ["maxDist"] = 15000
                                }
                            }
                        }
                    }
                }
            },
            [2] = {
                ["y"] = 772792.368,
                ["x"] = -283243.899,
                ["alt"] = 5933.1270951407,
                ["task"] = {
                    ["id"] = "ComboTask",
                    ["params"] = {
                        ["tasks"] = {
                            [1] = {
                                ["number"] = 1,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = true, ["name"] = 17}}
                                }
                            },
                            [2] = {
                                ["enabled"] = true,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["number"] = 2,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 4, ["name"] = 18}}
                                }
                            },
                            [3] = {
                                ["enabled"] = true,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["number"] = 3,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = true, ["name"] = 19}}
                                }
                            },
                            [4] = {
                                ["enabled"] = true,
                                ["auto"] = true,
                                ["id"] = "WrappedAction",
                                ["number"] = 4,
                                ["params"] = {
                                    ["action"] = {
                                        ["id"] = "Option",
                                        ["params"] = {
                                            ["targetTypes"] = {},
                                            ["noTargetTypes"] = {
                                                [1] = "Fighters",
                                                [2] = "Multirole fighters",
                                                [3] = "Bombers",
                                                [4] = "Helicopters",
                                                [5] = "Infantry",
                                                [6] = "Fortifications",
                                                [7] = "Tanks",
                                                [8] = "IFV",
                                                [9] = "APC",
                                                [10] = "Artillery",
                                                [11] = "Unarmed vehicles",
                                                [12] = "AAA",
                                                [13] = "SR SAM",
                                                [14] = "MR SAM",
                                                [15] = "LR SAM",
                                                [16] = "Aircraft Carriers",
                                                [17] = "Cruisers",
                                                [18] = "Destroyers",
                                                [19] = "Frigates",
                                                [20] = "Corvettes",
                                                [21] = "Light armed ships",
                                                [22] = "Unarmed ships",
                                                [23] = "Submarines",
                                                [24] = "Cruise missiles",
                                                [25] = "Antiship Missiles",
                                                [26] = "AA Missiles",
                                                [27] = "AG Missiles",
                                                [28] = "SA Missiles"
                                            },
                                            ["name"] = 21,
                                            ["value"] = "none;"
                                        }
                                    }
                                }
                            },
                            [5] = {
                                ["enabled"] = true,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["number"] = 5,
                                ["params"] = {
                                    ["action"] = {
                                        ["id"] = "Option",
                                        ["params"] = {
                                            ["value"] = 196609,
                                            ["variantIndex"] = 1,
                                            ["name"] = 5,
                                            ["formationIndex"] = 3
                                        }
                                    }
                                }
                            },
                            [6] = {
                                ["number"] = 6,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = true, ["name"] = 26}}
                                }
                            },
                            [7] = {
                                ["number"] = 7,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 3, ["name"] = 3}}
                                }
                            },
                            [8] = {
                                ["number"] = 8,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 0, ["name"] = 1}}
                                }
                            },
                            [9] = {
                                ["enabled"] = true,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["number"] = 9,
                                ["params"] = {
                                    ["action"] = {["id"] = "Option", ["params"] = {["value"] = 0, ["name"] = 0}}
                                }
                            },
                            [10] = {
                                ["number"] = 10,
                                ["auto"] = false,
                                ["id"] = "EngageTargets",
                                ["enabled"] = true,
                                ["params"] = {
                                    ["targetTypes"] = {[1] = "Planes"},
                                    ["noTargetTypes"] = {
                                        [1] = "Helicopters",
                                        [2] = "Cruise missiles",
                                        [3] = "Antiship Missiles",
                                        [4] = "AA Missiles",
                                        [5] = "AG Missiles",
                                        [6] = "SA Missiles"
                                    },
                                    ["value"] = "Planes;",
                                    ["priority"] = 0,
                                    ["maxDistEnabled"] = false,
                                    ["maxDist"] = 15000
                                }
                            }
                        }
                    }
                },
                ["type"] = "Turning Point"
            }
        }
    },
    ["groupId"] = 1000035,
    ["hidden"] = false,
    ["units"] = {
        [1] = {
            ["alt"] = 5933.1270951407,
            ["heading"] = 1.7907509828456,
            ["callsign"] = {[1] = 4, [2] = 1, [3] = 1, ["name"] = "Colt11"},
            ["type"] = "MiG-21Bis",
            ["livery_id"] = "Bulgaria - 1-3 IAE",
            ["skill"] = "Excellent",
            ["alt_type"] = "BARO",
            ["y"] = 764014.376,
            ["x"] = -280295.264,
            ["name"] = "MiG-21@Excellent-1",
            ["payload"] = {
                ["pylons"] = {},
                ["fuel"] = 2280,
                ["flare"] = 40,
                ["ammo_type"] = 1,
                ["chaff"] = 18,
                ["gun"] = 100
            },
            ["onboard_num"] = "013",
            ["speed"] = 220.97222222222,
            ["unitId"] = "1000036"
        },
        [2] = {
            ["alt"] = 5933.1270951407,
            ["heading"] = 1.7907509828456,
            ["callsign"] = {[1] = 4, [2] = 1, [3] = 1, ["name"] = "Colt11"},
            ["type"] = "MiG-21Bis",
            ["livery_id"] = "Bulgaria - 1-3 IAE",
            ["skill"] = "Excellent",
            ["alt_type"] = "BARO",
            ["y"] = 764014.376,
            ["x"] = -280295.264,
            ["name"] = "MiG-21@Excellent-2",
            ["payload"] = {
                ["pylons"] = {},
                ["fuel"] = 2280,
                ["flare"] = 40,
                ["ammo_type"] = 1,
                ["chaff"] = 18,
                ["gun"] = 100
            },
            ["onboard_num"] = "013",
            ["speed"] = 220.97222222222,
            ["unitId"] = "1000037"
        },
        [3] = {
            ["alt"] = 5933.1270951407,
            ["heading"] = 1.7907509828456,
            ["callsign"] = {[1] = 4, [2] = 1, [3] = 1, ["name"] = "Colt11"},
            ["type"] = "MiG-21Bis",
            ["livery_id"] = "Bulgaria - 1-3 IAE",
            ["skill"] = "Excellent",
            ["alt_type"] = "BARO",
            ["y"] = 764014.376,
            ["x"] = -280295.264,
            ["name"] = "MiG-21@Excellent-3",
            ["payload"] = {
                ["pylons"] = {},
                ["fuel"] = 2280,
                ["flare"] = 40,
                ["ammo_type"] = 1,
                ["chaff"] = 18,
                ["gun"] = 100
            },
            ["onboard_num"] = "013",
            ["speed"] = 220.97222222222,
            ["unitId"] = "1000038"
        },
        [4] = {
            ["alt"] = 5933.1270951407,
            ["heading"] = 1.7907509828456,
            ["callsign"] = {[1] = 4, [2] = 1, [3] = 1, ["name"] = "Colt11"},
            ["type"] = "MiG-21Bis",
            ["livery_id"] = "Bulgaria - 1-3 IAE",
            ["skill"] = "Excellent",
            ["alt_type"] = "BARO",
            ["y"] = 764014.376,
            ["x"] = -280295.264,
            ["name"] = "MiG-21@Excellent-4",
            ["payload"] = {
                ["pylons"] = {},
                ["fuel"] = 2280,
                ["flare"] = 40,
                ["ammo_type"] = 1,
                ["chaff"] = 18,
                ["gun"] = 100
            },
            ["onboard_num"] = "013",
            ["speed"] = 220.97222222222,
            ["unitId"] = "1000039"
        }
    },
    ["countryId"] = 81,
    ["name"] = "Red-MiG-21",
    ["coalition"] = "red",
    ["start_time"] = 0,
    ["frequency"] = 124
}
