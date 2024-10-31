# Java-STAG final tasks checklist

- [x] Lock door功能  -- 已经实现，但是给我的basic and extension actionfile里面实际并没有

- [x] Blow the horn时候将Lumberjack从Storeroom拖出来

- [x] Drop axe and potion不应该成功但是成功了 

- [x] Open the door with axe 不应该成功但是成功了Extraneous Entity

- [x] 在除了RiverBank以外的地方吹喇叭 都不是从Storeroom把lumberjack拖出来，实际上是从已经在的位置把它拖出来

- [x] 类名verb+Noun

- [x] 充分注释，将重要方法的签名标注清楚

- [x] 查重

- [x] 确认线上还跑不跑代码

- [x] 请求线上跑代码

- [x] NHS看病预约

- [x] STAG-DB - 你的方法名往往非常短，以至于很难确定它们的用途。有些方法名可能存在问题，因为它们只是单个单词，而且不符合推荐标准（它们不是动词、检查或事件处理程序）。

- [ ] STAG-DB - 以下方法非常长：`DBServer.handleCommand()`、`DBServer.join()`、`DBServer.select()`、`DBServer.selectRowList()`、`DBServer.delete()`和`DBServer.update()`。这些方法可以重构成更短的、单独的方法吗？你的变量名通常也很短，因此有时很难推断它们的用途。

- [ ] STAG-DB - 以下方法包含大量的IF/CASE语句：`DBServer.join()`、`DBServer.select()`、`DBServer.handleCommand()`、`DBServer.alter()`、`DBServer.delete()`、`DBServer.update()`、`DBServer.createTable()`和`DBServer.selectRowList()`。这些方法可能需要更优雅地实现吗？

- [ ] STAG-DB - 以下类具有非常深的嵌套：`DBServer`、`Util`和`Database`。这可能会使它们在长期维护中变得困难。请注意，有些类成对紧密耦合（`DBServer`<->`edu/uob/Database`，`DBServer`<->`edu/uob/Row`和`DBServer`<->`edu/uob/Table`），它们可能需要通过重构来改进封装和分离。

- [ ] STAG-DB - 你的代码可能需要一些额外的描述性注释。以下方法结构特别复杂：`DBServer.handleCommand()`、`DBServer.join()`、`DBServer.createTable()`、`DBServer.dropTable()`、`DBServer.insert()`、`DBServer.select()`、`DBServer.selectRowList()`、`DBServer.delete()`、`DBServer.update()`、`DBServer.alter()`、`DBServer.writeFile()`、`DBServer.getConditionsMap()`和`Database.addTable()` - 这可能会使它们难以理解

- [ ] 大量代码在`DBServer`和`Util`中重复出现。避免复制和粘贴重复的代码：保持代码的DRY原则！`DBServer`类包含一些非常长的代码行 - 这些行真的有必要吗？你有大量类似的“复制和粘贴”的方法 - 记住保持代码DRY！

  **重复代码块和改进建议**

  1. **数据库和表检查逻辑**

     代码段：

     ```java
     if (currentDatabase == null) {
         throw new RuntimeException("Database not selected prior");
     }
     List<Table> tableList = currentDatabase.getTableList();
     if (!tableList.isEmpty()) {
         for (Table table : tableList) {
             String tableName = table.getName();
             if (tableName.equals(name)) {
                 throw new RuntimeException("Table already exists");
             }
         }
     }
     ```

     解决方案：提取为一个方法

     ```java
     private void checkDatabaseSelected() {
         if (currentDatabase == null) {
             throw new RuntimeException("Database not selected prior");
         }
     }
     
     private void checkTableExists(String tableName) {
         List<Table> tableList = currentDatabase.getTableList();
         for (Table table : tableList) {
             if (table.getName().equals(tableName)) {
                 throw new RuntimeException("Table already exists");
             }
         }
     }
     ```

  2. **文件创建和删除逻辑**

     代码段：

     ```java
     File file = Paths.get("databases" + File.separator + currentDatabase.getName() +
             File.separator + name + ".tab").toAbsolutePath().toFile();
     
     if (file.exists()) {
         if (file.delete()) {
             throw new RuntimeException("Table creation failed");
         }
     }
     try {
         if (!file.createNewFile()) {
             throw new RuntimeException("Table creation failed");
         }
     } catch (Exception e) {
         throw new RuntimeException("Table creation failed");
     }
     ```

     解决方案：提取为一个方法

     ```java
     private File createTableFile(String name) {
         File file = Paths.get("databases" + File.separator + currentDatabase.getName() +
                 File.separator + name + ".tab").toAbsolutePath().toFile();
     
         if (file.exists() && !file.delete()) {
             throw new RuntimeException("Table creation failed");
         }
         try {
             if (!file.createNewFile()) {
                 throw new RuntimeException("Table creation failed");
             }
         } catch (Exception e) {
             throw new RuntimeException("Table creation failed");
         }
         return file;
     }
     ```

  3. **相似的条件检查逻辑**

     代码段：

     ```java
     List<String> columnNameList = table.getColumnNameList();
     if (!conditionsMap.isEmpty()) {
         Set<String> keySet = conditionsMap.keySet();
         for (String key : keySet) {
             boolean columnNameExist = false;
             for (String columnName : columnNameList) {
                 if (columnName.equalsIgnoreCase(key)) {
                     columnNameExist = true;
                     break;
                 }
             }
             if (!columnNameExist) {
                 throw new RuntimeException("Unknown column '" + key + "' in 'where clause'");
             }
         }
     }
     ```

     解决方案：提取为一个方法

     ```java
     private void checkConditions(Map<String, List<String>> conditionsMap, List<String> columnNameList) {
         if (!conditionsMap.isEmpty()) {
             Set<String> keySet = conditionsMap.keySet();
             for (String key : keySet) {
                 if (!columnNameList.contains(key)) {
                     throw new RuntimeException("Unknown column '" + key + "' in 'where clause'");
                 }
             }
         }
     }
     ```

  4. **表文件写入逻辑**

     代码段：

     ```java
     try (FileWriter fw = new FileWriter(file, append)) {
         for (String row : rowList) {
             row += "\n";
             fw.write(row);
             fw.flush();
         }
     } catch (IOException e) {
         throw new RuntimeException("Insert data fail");
     }
     ```

     解决方案：提取为一个方法

     ```java
     private void writeRowsToFile(File file, Boolean append, List<String> rowList) {
         try (FileWriter fw = new FileWriter(file, append)) {
             for (String row : rowList) {
                 row += "\n";
                 fw.write(row);
                 fw.flush();
             }
         } catch (IOException e) {
             throw new RuntimeException("Insert data fail");
         }
     }
     ```

  ### 重构后的代码示例

  重构后的部分代码示例：

  ```java
  public class DBServer {
      // Other methods...
  
      private void checkDatabaseSelected() {
          if (currentDatabase == null) {
              throw new RuntimeException("Database not selected prior");
          }
      }
  
      private void checkTableExists(String tableName) {
          List<Table> tableList = currentDatabase.getTableList();
          for (Table table : tableList) {
              if (table.getName().equals(tableName)) {
                  throw new RuntimeException("Table already exists");
              }
          }
      }
  
      private File createTableFile(String name) {
          File file = Paths.get("databases" + File.separator + currentDatabase.getName() +
                  File.separator + name + ".tab").toAbsolutePath().toFile();
  
          if (file.exists() && !file.delete()) {
              throw new RuntimeException("Table creation failed");
          }
          try {
              if (!file.createNewFile()) {
                  throw new RuntimeException("Table creation failed");
              }
          } catch (Exception e) {
              throw new RuntimeException("Table creation failed");
          }
          return file;
      }
  
      private void checkConditions(Map<String, List<String>> conditionsMap, List<String> columnNameList) {
          if (!conditionsMap.isEmpty()) {
              Set<String> keySet = conditionsMap.keySet();
              for (String key : keySet) {
                  if (!columnNameList.contains(key)) {
                      throw new RuntimeException("Unknown column '" + key + "' in 'where clause'");
                  }
              }
          }
      }
  
      private void writeRowsToFile(File file, Boolean append, List<String> rowList) {
          try (FileWriter fw = new FileWriter(file, append)) {
              for (String row : rowList) {
                  row += "\n";
                  fw.write(row);
                  fw.flush();
              }
          } catch (IOException e) {
              throw new RuntimeException("Insert data fail");
          }
      }
  
      // Use these methods in other parts of your code
      private static void createTable(String name, List<String> columnNameList) {
          checkDatabaseSelected();
          checkTableExists(name);
          File file = createTableFile(name);
          // Other logic...
      }
  
      private static void dropTable(String name) {
          checkDatabaseSelected();
          // Other logic...
      }
  
      // Other methods...
  }
  ```

  通过这种方式，你可以将重复的逻辑提取到独立的方法中，以提高代码的可读性和可维护性。确保所有重复的逻辑都被正确识别并提取到公共方法中，从而实现代码的DRY原则。

  详细指出原有代码中重复代码块的出现行数，并且明确哪些地方可以重构为公共方法。

  ### 1. 数据库和表检查逻辑

  #### 出现行数：

  - `createDatabase` 方法中，第264-275行。
  - `createTable` 方法中，第320-330行。
  - `dropTable` 方法中，第407-419行。

  #### 重复代码块：

  ```java
  if (currentDatabase == null) {
      throw new RuntimeException("Database not selected prior");
  }
  List<Table> tableList = currentDatabase.getTableList();
  if (!tableList.isEmpty()) {
      for (Table table : tableList) {
          String tableName = table.getName();
          if (tableName.equals(name)) {
              throw new RuntimeException("Table already exists");
          }
      }
  }
  ```

  ### 2. 文件创建和删除逻辑

  #### 出现行数：

  - `createTable` 方法中，第332-342行。
  - `dropTable` 方法中，第421-425行。

  #### 重复代码块：

  ```java
  File file = Paths.get("databases" + File.separator + currentDatabase.getName() +
          File.separator + name + ".tab").toAbsolutePath().toFile();
  
  if (file.exists() && !file.delete()) {
      throw new RuntimeException("Table creation failed");
  }
  try {
      if (!file.createNewFile()) {
          throw new RuntimeException("Table creation failed");
      }
  } catch (Exception e) {
      throw new RuntimeException("Table creation failed");
  }
  ```

  ### 3. 相似的条件检查逻辑

  #### 出现行数：

  - `selectRowList` 方法中，第646-658行。
  - `delete` 方法中，第707-719行。
  - `update` 方法中，第775-787行。

  #### 重复代码块：

  ```java
  List<String> columnNameList = table.getColumnNameList();
  if (!conditionsMap.isEmpty()) {
      Set<String> keySet = conditionsMap.keySet();
      for (String key : keySet) {
          boolean columnNameExist = false;
          for (String columnName : columnNameList) {
              if (columnName.equalsIgnoreCase(key)) {
                  columnNameExist = true;
                  break;
              }
          }
          if (!columnNameExist) {
              throw new RuntimeException("Unknown column '" + key + "' in 'where clause'");
          }
      }
  }
  ```

  ### 4. 表文件写入逻辑

  #### 出现行数：

  - `writeTableFile` 方法中，第883-891行。
  - `writeFile` 方法中，第898-921行。

  #### 重复代码块：

  ```java
  try (FileWriter fw = new FileWriter(file, append)) {
      for (String row : rowList) {
          row += "\n";
          fw.write(row);
          fw.flush();
      }
  } catch (IOException e) {
      throw new RuntimeException("Insert data fail");
  }
  ```

  ### 重构后的代码示例

  在重构后的代码中，这些重复的逻辑会被提取为独立的方法。例如：

  ```java
  private void checkDatabaseSelected() {
      if (currentDatabase == null) {
          throw new RuntimeException("Database not selected prior");
      }
  }
  
  private void checkTableExists(String tableName) {
      List<Table> tableList = currentDatabase.getTableList();
      for (Table table : tableList) {
          if (table.getName().equals(tableName)) {
              throw new RuntimeException("Table already exists");
          }
      }
  }
  
  private File createTableFile(String name) {
      File file = Paths.get("databases" + File.separator + currentDatabase.getName() +
              File.separator + name + ".tab").toAbsolutePath().toFile();
  
      if (file.exists() && !file.delete()) {
          throw new RuntimeException("Table creation failed");
      }
      try {
          if (!file.createNewFile()) {
              throw new RuntimeException("Table creation failed");
          }
      } catch (Exception e) {
          throw new RuntimeException("Table creation failed");
      }
      return file;
  }
  
  private void checkConditions(Map<String, List<String>> conditionsMap, List<String> columnNameList) {
      if (!conditionsMap.isEmpty()) {
          Set<String> keySet = conditionsMap.keySet();
          for (String key : keySet) {
              if (!columnNameList.contains(key)) {
                  throw new RuntimeException("Unknown column '" + key + "' in 'where clause'");
              }
          }
      }
  }
  
  private void writeRowsToFile(File file, Boolean append, List<String> rowList) {
      try (FileWriter fw = new FileWriter(file, append)) {
          for (String row : rowList) {
              row += "\n";
              fw.write(row);
              fw.flush();
          }
      } catch (IOException e) {
          throw new RuntimeException("Insert data fail");
      }
  }
  ```

  通过这种方式，你可以消除代码中的重复部分，提高代码的可读性和可维护性。请确保你已经识别并提取了所有重复的逻辑，并将它们转换为公共方法，以遵循DRY原则。

- [ ] 在查看你的 `DBServer` 类代码时，以下是一些可能有不寻常缩进的地方：

  1. **第172行到174行**：`createTable` 方法中的 if 语句：

     ```java
     if (file.exists()) {
         if (file.delete()) {
             throw new RuntimeException("Table creation failed");
         }
     }
     ```

  2. **第491行到492行**：`writeFile` 方法中的注释行位置：

     ```java
     //                        fw.write("\n");
     //                    } else {
     ```

  3. **第179行到180行**：多个嵌套的 if 语句，没有缩进清晰的区分：

     ```java
     if (!file.mkdirs()) {
         throw new RuntimeException("Database creation failed");
     }
     ```

  4. **第425行到428行**：嵌套的 for 循环可能会有不清晰的缩进：

     ```java
     for (Row row : rowList) {
         //逐行遍历
         List<String> valueList = row.getValueList();
         if (!valueList.isEmpty()) {
     ```

  5. **第558行到559行**：`update` 方法中的 if 语句嵌套：

     ```java
     if (!conditionsMap.isEmpty()) {
         Set<String> keySet = conditionsMap.keySet();
     ```

  6. **第808行**：`blockingHandleConnection` 方法中的 try 语句：

     ```java
     try (Socket s = serverSocket.accept();
     BufferedReader reader = new BufferedReader(new InputStreamReader(s.getInputStream()));
     BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(s.getOutputStream()))) {
     ```

  这些地方可能存在不寻常的缩进或者可读性较差的地方，你可以检查并调整这些部分的缩进，以提高代码的可读性和一致性。

- [x] 删除不合适的内容

  Target

  mvnwrapper

- [ ] 跑出来的结果

  "C:\Program Files\Eclipse Adoptium\jdk-17.0.10.7-hotspot\bin\java.exe" "-javaagent:C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2023.3.4\lib\idea_rt.jar=64757:C:\Program Files\JetBrains\IntelliJ IDEA Community Edition 2023.3.4\bin" -Dfile.encoding=UTF-8 -classpath C:\Users\Ricardo\Desktop\JAVA-CW-2023\cw-db\target\classes edu.uob.DBClient
  SQL:> CREATE DATABASE markbook;
  [OK]
  SQL:> USE markbook;
  [OK]
  SQL:> CREATE TABLE marks (name, mark, pass);
  [OK]
  SQL:> INSERT INTO marks VALUES ('Simon', 65, TRUE);
  [OK]
  SQL:> INSERT INTO marks VALUES ('Sion', 55, TRUE);
  [OK]
  SQL:> INSERT INTO marks VALUES ('Rob', 35, FALSE);
  [OK]
  SQL:> INSERT INTO marks VALUES ('Chris', 20, FALSE);
  [OK]
  SQL:> SELECT * FROM marks;
  [OK]
  id	name	mark	pass	
  1	'Simon'	65	TRUE	
  2	'Sion'	55	TRUE	
  3	'Rob'	35	FALSE	
  4	'Chris'	20	FALSE	
  SQL:> SELECT * FROM marks WHERE name != 'Sion';
  [OK]
  id	name	mark	pass	
  1	'Simon'	65	TRUE	
  3	'Rob'	35	FALSE	
  4	'Chris'	20	FALSE	
  SQL:> SELECT * FROM marks WHERE pass == TRUE;
  [OK]
  id	name	mark	pass	
  1	'Simon'	65	TRUE	
  2	'Sion'	55	TRUE	
  SQL:> CREATE TABLE coursework (task, submission);
  [OK]
  SQL:> INSERT INTO coursework VALUES(OXO, 3);
  [OK]
  SQL:> INSERT INTO coursework VALUES(DB, 1);
  [OK]
  SQL:> INSERT INTO coursework VALUES(OXO, 4);
  [OK]
  SQL:> INSERT INTO coursework VALUES(STAG, 2);
  [OK]
  SQL:> JOIN coursework AND marks ON submission AND id;
  [OK]
  id	coursework.task	marks.name	marks.mark	marks.pass	
  1	OXO	'Rob'	35	FALSE	
  2	DB	'Simon'	65	TRUE	
  3	OXO	'Chris'	20	FALSE	
  4	STAG	'Sion'	55	TRUE	
  SQL:> UPDATE marks SET mark = 38 WHERE name == 'Chris';
  [OK]
  SQL:> SELECT * FROM marks WHERE name == 'Chris';
  [OK]
  id	name	mark	pass	
  4	'Chris'	38	FALSE	
  SQL:> DELETE FROM marks WHERE name == 'Sion';
  [OK]
  SQL:> SELECT * FROM marks;
  [OK]
  id	name	mark	pass	
  1	'Simon'	65	TRUE	
  3	'Rob'	35	FALSE	
  4	'Chris'	38	FALSE	
  SQL:> SELECT * FROM marks WHERE (pass == FALSE) AND (mark > 35);
  [OK]
  id	name	mark	pass	
  4	'Chris'	38	FALSE	
  SQL:> SELECT * FROM marks WHERE name LIKE 'i';
  [OK]
  id	name	mark	pass	
  1	'Simon'	65	TRUE	
  3	'Rob'	35	FALSE	
  4	'Chris'	38	FALSE	
  SQL:> SELECT id FROM marks WHERE pass == FALSE;
  [OK]
  id	
  3	
  4	
  SQL:> SELECT name FROM marks WHERE mark>60;
  [OK]
  name	
  'Simon'	
  'Rob'	
  'Chris'	
  SQL:> DELETE FROM marks WHERE mark<40;
  [OK]
  SQL:> SELECT * FROM marks;
  [OK]
  SQL:> ALTER TABLE marks ADD age;
  [OK]
  SQL:> SELECT * FROM marks;
  [OK]
  id	name	mark	pass	age	
  		
  		
  		
  		
  SQL:> UPDATE marks SET age = 35 WHERE name == 'Simon';
  [ERROR]: Index 1 out of bounds for length 1
  SQL:> 
  进程已结束，退出代码为 130