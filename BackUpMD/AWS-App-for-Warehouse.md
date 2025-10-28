A 7-day fast plan to deploy a web app that accepts my uploaded `.xlsx` files and performs Power Query–style data transforms — built step-by-step so I can adjust based on the exact requirements later. 


 A **7-day crash plan** to deploy a web app that accepts `.xlsx` uploads and performs Power Query-style data transformations, laid out step-by-step so I can adjust implementation based on detailed requirements later.

**learning + build + deploy plan**  (each day lists goals, tasks, deliverables and example commands/snippets).

------

### 第一天 — 准备与技术选型

**目标：** 确定技术栈、申请 AWS 账号并搭建本地开发环境。
 **Goal:** Pick the tech stack, create an AWS account, and set up a local dev environment.

- 任务（Tasks）：
  - 决定快速原型与生产部署方案：
    - **快速原型（推荐）**：Python + **FastAPI**（后端 API）+ **pandas / openpyxl**（xlsx 解析/变换）+ 简单前端（HTML+JS 或 React）。
      - 原因：FastAPI 易用、可用 pandas 做几乎所有 Power Query 风格操作。
    - **可选更快实现**：**Streamlit**（单体应用，极快展示与上传），但生产化部署在 AWS 上需要额外配置。
  - 注册/确认 AWS 账号并启用 IAM 最低权限账号用于实验。
  - 本地安装：Python 3.10/3.11、pipenv/venv、node（如果用 React）、Git。
- 产出（Deliverable）：README，写明选型与本地运行步骤。
- 示例命令（Examples）：
  - `python -m venv .venv && source .venv/bin/activate`
  - `pip install fastapi uvicorn pandas openpyxl python-multipart boto3`
  - `npx create-react-app frontend`（若使用 React）



Yes — you should create the virtual environment **inside your cloned repo folder**.

Here’s why and how:

------

### ✅ Why in the repo folder

- Keeps all project-specific dependencies isolated from other Python projects.
- Makes it easier for others (or you later) to reproduce the environment.
- `.venv` is usually added to `.gitignore` so it won’t be pushed to GitHub.

------

### ✅ How to do it

1. Open a terminal and `cd` into your cloned repo folder:

```
cd path/to/your/cloned/repo
```

1. Create the virtual environment:

```
python -m venv .venv
```

> The `.` prefix is optional but common — it keeps the folder hidden in most systems.

1. Activate the virtual environment:

- **Windows:**

```
.venv\Scripts\activate
```

- **Mac/Linux:**

```
source .venv/bin/activate
```

1. Upgrade pip inside the virtual environment:

```
pip install --upgrade pip


```

------





Perfect! We'll start with **Day 1**. Since this is for a **professional portfolio project**, I’ll prepare a **React + FastAPI** setup: FastAPI for the backend API (handling `.xlsx` uploads and transformations), React for a modern, clean frontend.

Here’s the **full Day 1 checklist and setup**:

------

## **Day 1 — Preparation & Minimal Backend Setup**

### **Objective**

- Set up the local development environment
- Create a minimal FastAPI backend for uploading `.xlsx` files
- Ensure you can run it locally

------

### **Step 1 — Set Up Python Environment**

1. Make sure Python 3.11+ is installed.
2. Create a virtual environment:

```bash
python -m venv .venv
# Activate it:
# Windows:
.venv\Scripts\activate
# Mac/Linux:
source .venv/bin/activate
```

1. Upgrade `pip`:

```bash
pip install --upgrade pip
```

------

### **Step 2 — Create `requirement.txt`**

Create a file named `requirements.txt` with the following content:

```bash
fastapi==0.111.1
uvicorn==0.24.0
numpy==1.26.4
pandas==2.0.3
openpyxl==3.1.3
python-multipart==0.0.7
```

> These packages cover FastAPI, Excel parsing, and file uploads.

Install dependencies:

```bash
pip install -r requirement.txt
```

------

### **Step 3 — Minimal FastAPI Backend**

Create a folder `backend/` and inside it a file `app.py` with this content:

```python
from fastapi import FastAPI, File, UploadFile
import pandas as pd
import numpy as np
import io
import traceback

app = FastAPI(title="Warelytics API")

@app.post("/upload")
async def upload_xlsx(file: UploadFile = File(...)):
    contents = await file.read()
    try:
        # Read Excel file into DataFrame
        df = pd.read_excel(io.BytesIO(contents), sheet_name=0)
        
        # Replace NaN with None (JSON safe)
        df = df.replace({np.nan: None})
        
        # Return JSON records
        return df.to_dict(orient="records")

    except Exception as e:
        traceback.print_exc()  # Print full error to terminal
        return {"error": str(e)}
```

------

### **Step 4 — Run the Backend Locally**

```bash
uvicorn backend.app:app --reload
```

- Visit http://127.0.0.1:8000/docs to see **interactive API docs**.
- Test uploading an `.xlsx` file — you should get back **columns + first 5 rows** in JSON.

------

### **Step 5 — Folder Structure**

```
project-root/
│
├── backend/
│   └── app.py
├── frontend/  # React app will go here later
└── requirements.txt
```

------

### ✅ **Deliverables for Day 1**

- Python virtual environment working
- `requirements.txt` installed
- FastAPI backend can **accept `.xlsx` upload** and return preview
  - How can I test it
- Local testing with `/docs` works

------

Next, on **Day 2**, we will implement:

- **File upload from the frontend** (React)
- Handling multiple sheets
- Preview rendering on the webpage

------

If you like, I can immediately prepare a **minimal React frontend** that can upload an Excel file to this backend — so that by the end of Day 1 you can **click, upload, and preview the Excel file in your browser**.

Do you want me to do that now?

### 第二天 — 后端：文件上传与解析（基本版）

**目标：** 实现上传接口并把 `.xlsx` 读入 pandas DataFrame 并返回文件预览（头部几行）。
 **Goal:** Implement upload endpoint and load `.xlsx` into pandas DataFrame; return a preview.

- 任务（Tasks）：

  - 使用 FastAPI 写 `/upload` POST 接口，接收 `multipart/form-data` 的 xlsx 文件。
  - 用 `pandas.read_excel()` 读取 Excel，返回前 10 行的 JSON（`df.head().to_dict(orient='records')`）。
  - 在返回中包含 sheet 名称、列名与数据类型（方便前端生成 UI）。

- 产出（Deliverable）：可上传文件并在 Postman 或前端查看 preview 的后端。

- 关键代码片段（snippet）：

  ```python
  from fastapi import FastAPI, File, UploadFile
  import pandas as pd
  app = FastAPI()
  
  @app.post("/upload")
  async def upload(file: UploadFile = File(...)):
      contents = await file.read()
      # pandas 可以直接读取 bytes via BytesIO
      df = pd.read_excel(io.BytesIO(contents), sheet_name=0)
      return {"columns": df.columns.tolist(), "preview": df.head(10).to_dict(orient="records")}
  ```

- 测试命令：

  - `uvicorn app:app --reload`
  - 用 curl 或 Postman 上传文件或稍后用前端上传。

------

### 第三天 — 核心变换引擎（Power Query 风格操作）

**目标：** 在后端实现一组“变换操作”API：过滤、选择列、添加计算列、分组聚合、透视表、合并（join）。
 **Goal:** Implement core transformation operations in backend: filter, select, calculated columns, group/agg, pivot, merge.

- 任务（Tasks）：
  - 设计**变换步骤描述格式**（例如 JSON 数组，一步代表一个操作：`{op: "filter", expr: "colA > 10"}`），后端按步骤对 DataFrame 逐步执行并保存“步骤历史”（方便撤销/重做）。
  - 使用 pandas 实现常见操作：`df.query()`、`df.assign()`、`df.groupby().agg()`、`pd.pivot_table()`、`df.merge()`。
  - 返回每一步的预览与完整 schema。
- 产出（Deliverable）：一个 `/transform` API，接受步骤列表并返回处理后的 preview 与步骤执行记录。
- 说明（Note）：把表达式限制为安全可解析的子集（不要执行 arbitrary Python from users）。可以用简单表达式解析或基于 JSON 指令（比如 filter 用 `{col, op, value}`）来避免安全问题。

------

### 第四天 — 前端：上传、显示与交互（最小可用界面）

**目标：** 做一个能上传 xlsx、展示列/preview、并发送变换步骤到后端的简单界面。
 **Goal:** Build a UI to upload xlsx, show columns/preview, and send transform steps to backend.

- 任务（Tasks）：

  - 若想最快完成：用基础 HTML + vanilla JS + Fetch；若你想更现代：用 React 做组件化界面（列选择器、过滤器构建器、group/pivot UI）。
  - 实现文件上传表单、preview 渲染、简单的 filter 构建器（选择列、操作符、值），每个动作生成一个步骤并发送到 `/transform`。
  - 在页面显示步骤历史（Power Query 风格步骤面板）。

- 产出（Deliverable）：前端能上传，用户能点选列并发起 filter/aggregate 操作并看到结果。

- 简单 HTML 上传示例：

  ```html
  <input id="file" type="file" accept=".xlsx" />
  <button onclick="upload()">Upload</button>
  <script>
  async function upload(){
    const f = document.getElementById('file').files[0];
    const fd = new FormData();
    fd.append('file', f);
    const r = await fetch('/upload', {method:'POST', body: fd});
    const j = await r.json();
    console.log(j);
  }
  </script>
  ```

------

### 第五天 — 功能完善：步骤历史、导出与复杂操作

**目标：** 完成步骤管理（undo/redo）、支持导出 CSV/Excel、实现 merge（两个表）与 calculated column（表达式或小函数）。
 **Goal:** Add step history (undo/redo), export results, implement merge and computed columns.

- 任务（Tasks）：

  - 后端保存 session 的步骤历史（内存或 S3 + metadata；开发阶段可存内存或本地缓存）。
  - 实现 `/export` 接口，可以把处理后的 DataFrame 存为 CSV / xlsx 并将文件返回或上传到 S3。
  - 增加列计算（例如 `NewCol = ColA * 1.2 + ColB`）的安全解析器 — 用 JSON 表达式或用 `numexpr` 但要限制函数。

- 产出（Deliverable）：用户可以把最终结果导出为 xlsx，并能回退历史步骤查看。

- 示例导出（backend）：

  ```python
  df.to_excel("result.xlsx", index=False)
  # 或者上传到 S3 用 boto3
  ```

------

### 第六天 — 安全、测试与 AWS 准备（打包部署）

**目标：** 增强安全性（限制文件大小、验证 Excel 内容、IAM 策略）、写自动化测试、准备 Dockerfile / EB 配置。
 **Goal:** Harden security (max file size, validate content, IAM), write tests, prepare Dockerfile / Elastic Beanstalk configuration.

- 任务（Tasks）：

  - 限制文件大小（例如 20MB），校验文件扩展与 MIME，验证列数/行数限制以防内存耗尽。
  - 在后端实现基本鉴权（API key 或简单登录），并为 S3 操作创建最小权限 IAM 角色/用户。
  - 写几个单元测试（测试上传、filter、groupby、pivot）。
  - 为部署准备 `Dockerfile`（推荐）或 `requirements.txt` + `Procfile`（用于 Elastic Beanstalk）。

- 产出（Deliverable）：安全检查通过的代码库、测试通过、Dockerfile / EB 配置文件。

- 示例 Dockerfile（简略）：

  ```dockerfile
  FROM python:3.11-slim
  WORKDIR /app
  COPY . /app
  RUN pip install -r requirements.txt
  CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
  ```

------

### 第七天 — 在 AWS 上部署与发布（Elastic Beanstalk + S3）

**目标：** 将应用部署到 AWS，并配置上传文件存储（S3）、域名与 HTTPS。
 **Goal:** Deploy app to AWS, configure S3 for file storage, domain and HTTPS.

- 任务（Tasks）：
  - 在 AWS 创建 S3 Bucket（用于存放上传与导出的文件），配置 CORS（若前端在不同域）。
  - 使用 Elastic Beanstalk（或 ECS）部署 Docker 容器（Elastic Beanstalk 对新手友好）：创建 EB app、上传 Docker 镜像或 ZIP，启动环境。
  - 配置环境变量（S3 bucket 名、AWS creds via EB environment variables，或给 EB 角色权限）。
  - 配置 HTTPS：用 AWS Certificate Manager (ACM) + Elastic Load Balancer（在 EB 环境中配置）或 Route 53 + ALB。
  - 做最终端到端测试（上传文件 → 变换 → 导出 → 下载）。
- 产出（Deliverable）：线上可访问的网址（带 HTTPS），能上传 `.xlsx` 并做变换与导出。
- 注意与节省费用（Cost control）：测试时使用小实例（t3.micro / t3a.nano），上传日志与 S3 保留策略设置避免费用膨胀。

------

### 附加建议与可选扩展（未来迭代）

- 持久会话与用户管理（用 RDS 存储步骤/项目）。
- 更高级的 Power Query UI：可视化步骤编辑器（拖拽或“录制步骤”）。
- 使用 AWS Lambda + API Gateway 做无服务器部署（可能节省成本但增加复杂度）。
- 添加并发控制与队列（SQS）以处理大文件异步任务。

------

如果你同意这个 7 天计划，我会马上把 **第 1 天的具体待办清单与命令** 写得更详细（包括 exact `requirements.txt`、最小后端模板文件、以及本地运行与测试步骤）。
 如果你希望替换成 **Streamlit 快速原型** 路线或偏好 **React + FastAPI** 的界面方案，也告诉我，我会直接按你选的路线细化每日任务并把 Day-by-day 的代码模版都给你。

如果你现在就想要第 1 天的逐条执行清单（包括一份最小的 `app.py` 上传示例），我会直接把它给你。
 If you agree to this 7-day plan I will immediately prepare Day-1’s exact checklist and commands (including a minimal `requirements.txt`, a backend template file and local run / test steps).
 If you prefer a **Streamlit quick-prototype** path or a **React + FastAPI** UI path instead, tell me and I’ll refine the plan accordingly and produce day-by-day code templates.
 If you want Day 1’s step-by-step executable checklist now (including a minimal `app.py` upload example), I’ll provide it straight away.