[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "CEO_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared CEO = let
  Source = Excel.Workbook(Web.Contents("https://docs.google.com/spreadsheets/d/1X8LtysjOjOSYRtXv5hVqYJUZClzfvHgb/export?format=xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "CEO", Kind = "Sheet"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"Column1", type text}, {"Column2", type text}})
in
  #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "MtoMTarget_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared MtoMTarget = let
  Source = Excel.Workbook(Web.Contents("https://docs.google.com/spreadsheets/d/1X8LtysjOjOSYRtXv5hVqYJUZClzfvHgb/export?format=xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "MtoMTarget", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Country", type text}, {"Type", type text}, {"Target", Int64.Type}})
in
  #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "MtoMPeople_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared MtoMPeople = let
  Source = Excel.Workbook(Web.Contents("https://docs.google.com/spreadsheets/d/1X8LtysjOjOSYRtXv5hVqYJUZClzfvHgb/export?format=xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "MtoMPeople", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Owner", type text}, {"BankAccount", Int64.Type}})
in
  #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "MtoMTransactions_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared MtoMTransactions = let
  Source = Excel.Workbook(Web.Contents("https://docs.google.com/spreadsheets/d/1X8LtysjOjOSYRtXv5hVqYJUZClzfvHgb/export?format=xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "MtoMTransactions", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"BankAccount", Int64.Type}, {"Transaction", Int64.Type}, {"Currency", type text}})
in
  #"Changed column type";
shared CEO_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "220b3636-7557-420f-8b6d-593f0d48c908"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "8720fecb-786c-4008-8b0d-722a65fd77d4"]}[Data],
  TableNavigation = Navigation_2{[Id = "CEO", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared MtoMTarget_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "220b3636-7557-420f-8b6d-593f0d48c908"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "8720fecb-786c-4008-8b0d-722a65fd77d4"]}[Data],
  TableNavigation = Navigation_2{[Id = "MtoMTarget", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared MtoMPeople_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "220b3636-7557-420f-8b6d-593f0d48c908"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "8720fecb-786c-4008-8b0d-722a65fd77d4"]}[Data],
  TableNavigation = Navigation_2{[Id = "MtoMPeople", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared MtoMTransactions_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "220b3636-7557-420f-8b6d-593f0d48c908"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "8720fecb-786c-4008-8b0d-722a65fd77d4"]}[Data],
  TableNavigation = Navigation_2{[Id = "MtoMTransactions", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
