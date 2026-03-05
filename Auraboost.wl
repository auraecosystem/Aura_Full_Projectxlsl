(* ====================================== *)
(* auraBoost.wl: Super Wolfram toolkit for aura.xlsl *)
(* ====================================== *)

(* ---------- 1️⃣ Data Generation & Export ---------- *)
Module[{data},
  data = Table[
    {"Row " <> ToString[i], RandomInteger[{1, 100}], RandomReal[]},
    {i, 1, 20}
  ];
  
  Export["wolfram/aura_analysis.xlsx", <|
    "Sheet1" -> Prepend[data, {"Name", "Score", "Value"}]
  |>, "XLSX"];
  
  Print["✅ Spreadsheet exported!"]
];

(* ---------- 2️⃣ Dashboard & Visualization ---------- *)
Module[{dataset, cleaned},
  dataset = Import["wolfram/aura_analysis.xlsx", "Data"][[1]];
  cleaned = Rest[dataset];
  
  Print["📊 Scores Distribution Bar Chart"];
  BarChart[
    cleaned[[All, 2]],
    ChartLabels -> cleaned[[All, 1]],
    ChartStyle -> "Pastel",
    PlotLabel -> "Scores Distribution"
  ];
  
  Print["📈 Score vs Value Scatter Plot"];
  ListPlot[
    cleaned[[All, {2, 3}]],
    PlotStyle -> Red,
    PlotLabel -> "Score vs Value",
    AxesLabel -> {"Score", "Value"}
  ];
];

(* ---------- 3️⃣ Live Data Integration ---------- *)
Module[{cryptoData, cryptoTable},
  cryptoData = URLRead[
      "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=usd"
    ] // ImportString[#, "JSON"] &;
  
  cryptoTable = {
    {"Asset", "USD Price"},
    {"BTC", cryptoData["bitcoin", "usd"]},
    {"ETH", cryptoData["ethereum", "usd"]}
  };
  
  Export["wolfram/crypto_prices.xlsx", cryptoTable, "XLSX"];
  Print["💰 Live crypto prices exported!"]
];

(* ---------- 4️⃣ Automated Data Tests ---------- *)
Module[{dataset, headerTest, scoreTest, valueTest},
  dataset = Import["wolfram/aura_analysis.xlsx", "Data"][[1]];
  
  headerTest = AllTrue[First[dataset], StringQ];
  scoreTest = AllTrue[Rest[dataset][[All, 2]], NumberQ];
  valueTest = AllTrue[Rest[dataset][[All, 3]], NumberQ];
  
  If[headerTest && scoreTest && valueTest,
    Print["✅ All tests passed!"],
    Print["❌ Data check failed!"]
  ];
];

(* ---------- 5️⃣ Optional Cloud Dashboard Deployment ---------- *)
(* Uncomment below if using Wolfram Cloud *)
(*
CloudDeploy[
  FormFunction[{"UploadExcel" -> "File"},
    Module[{data = Import[#UploadExcel, "Data"]},
      BarChart[data[[2 ;;, 2]], ChartLabels -> data[[2 ;;, 1]]]
    ] &],
  "auraCloudPlot"
];
Print["🌐 Cloud dashboard deployed!"]
*)

Print["🎉 auraBoost.wl setup complete! All features ready."]
