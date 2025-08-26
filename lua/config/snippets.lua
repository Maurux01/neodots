-- Snippets profesionales completos para todos los lenguajes y frameworks
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- JavaScript - Snippets modernos
ls.add_snippets("javascript", {
  s("async", {
    t("const "), i(1, "fetchData"), t(" = async ("), i(2), t(") => {"),
    t({"", "  try {"}),
    t({"", "    const response = await fetch('"), i(3, "url"), t("');"),
    t({"", "    if (!response.ok) throw new Error('Request failed');"}),
    t({"", "    const data = await response.json();"}),
    t({"", "    return data;"}),
    t({"", "  } catch (error) {"}),
    t({"", "    console.error('Error:', error);"}),
    t({"", "    throw error;"}),
    t({"", "  }"}),
    t({"", "};"}), i(0)
  }),
  s("class", {
    t("class "), i(1, "MyClass"), t(" {"),
    t({"", "  constructor("), i(2), t(") {"),
    t({"", "    "}), i(3),
    t({"", "  }"}),
    t({"", ""}),
    t({"", "  "}), i(4, "method"), t("() {"),
    t({"", "    "}), i(5),
    t({"", "  }"}),
    t({"", "}"}), i(0)
  }),
  s("api", {
    t("const api = {"),
    t({"", "  baseURL: '"), i(1, "https://api.example.com"), t("',"),
    t({"", "  async get(endpoint) {"}),
    t({"", "    const response = await fetch(`${this.baseURL}${endpoint}`);"}),
    t({"", "    return response.json();"}),
    t({"", "  },"}),
    t({"", "  async post(endpoint, data) {"}),
    t({"", "    const response = await fetch(`${this.baseURL}${endpoint}`, {"}),
    t({"", "      method: 'POST',"}),
    t({"", "      headers: { 'Content-Type': 'application/json' },"}),
    t({"", "      body: JSON.stringify(data)"}),
    t({"", "    });"}),
    t({"", "    return response.json();"}),
    t({"", "  }"}),
    t({"", "};"}), i(0)
  })
})

-- TypeScript - Snippets con tipos
ls.add_snippets("typescript", {
  s("interface", {
    t("interface "), i(1, "User"), t(" {"),
    t({"", "  id: number;"}),
    t({"", "  name: string;"}),
    t({"", "  email: string;"}),
    t({"", "  "}), i(2, "createdAt: Date;"),
    t({"", "}"}), i(0)
  }),
  s("generic", {
    t("function "), i(1, "identity"), t("<T>(arg: T): T {"),
    t({"", "  return arg;"}),
    t({"", "}"}), i(0)
  }),
  s("service", {
    t("class "), i(1, "UserService"), t(" {"),
    t({"", "  private baseURL = '"), i(2, "https://api.example.com"), t("';"),
    t({"", ""}),
    t({"", "  async getUser(id: number): Promise<User> {"}),
    t({"", "    const response = await fetch(`${this.baseURL}/users/${id}`);"}),
    t({"", "    if (!response.ok) {"}),
    t({"", "      throw new Error(`HTTP error! status: ${response.status}`);"}),
    t({"", "    }"}),
    t({"", "    return response.json();"}),
    t({"", "  }"}),
    t({"", "}"}), i(0)
  })
})

-- React - Componentes modernos
ls.add_snippets("javascriptreact", {
  s("component", {
    t("import React, { useState, useEffect } from 'react';"),
    t({"", ""}),
    t({"", "const "}), i(1, "MyComponent"), t(" = ({ "), i(2, "props"), t(" }) => {"),
    t({"", "  const ["), i(3, "state"), t(", set"), i(4, "State"), t("] = useState("), i(5, "null"), t(");"),
    t({"", ""}),
    t({"", "  useEffect(() => {"}),
    t({"", "    "}), i(6, "// Effect logic"),
    t({"", "  }, []);"}),
    t({"", ""}),
    t({"", "  return ("}),
    t({"", "    <div className=\""), i(7, "container"), t("\">"),
    t({"", "      "}), i(8, "<h1>Hello World</h1>"),
    t({"", "    </div>"}),
    t({"", "  );"}),
    t({"", "};"}),
    t({"", ""}),
    t({"", "export default "}), i(1), t(";"), i(0)
  }),
  s("hook", {
    t("import { useState, useEffect } from 'react';"),
    t({"", ""}),
    t({"", "const use"}), i(1, "CustomHook"), t(" = ("), i(2), t(") => {"),
    t({"", "  const ["), i(3, "data"), t(", set"), i(4, "Data"), t("] = useState(null);"),
    t({"", "  const [loading, setLoading] = useState(false);"),
    t({"", "  const [error, setError] = useState(null);"),
    t({"", ""}),
    t({"", "  useEffect(() => {"}),
    t({"", "    "}), i(5, "// Hook logic"),
    t({"", "  }, []);"}),
    t({"", ""}),
    t({"", "  return { data, loading, error };"}),
    t({"", "};"}),
    t({"", ""}),
    t({"", "export default use"}), i(1), t(";"), i(0)
  })
})

-- Python - Snippets profesionales
ls.add_snippets("python", {
  s("class", {
    t("class "), i(1, "MyClass"), t(":"),
    t({"", "    \"\"\""), i(2, "Class description"), t("\"\"\""),
    t({"", "    "}),
    t({"", "    def __init__(self, "), i(3), t("):"),
    t({"", "        "}), i(4),
    t({"", "    "}),
    t({"", "    def "}), i(5, "method"), t("(self):"),
    t({"", "        \"\"\"Method description\"\"\""}),
    t({"", "        "}), i(6),
    t({"", "        return "}), i(7), i(0)
  }),
  s("async", {
    t("import asyncio"),
    t({"", "import aiohttp"),
    t({"", ""}),
    t({"", "async def "}), i(1, "fetch_data"), t("(url: str) -> dict:"),
    t({"", "    \"\"\"Fetch data from API asynchronously\"\"\""}),
    t({"", "    async with aiohttp.ClientSession() as session:"}),
    t({"", "        try:"}),
    t({"", "            async with session.get(url) as response:"}),
    t({"", "                response.raise_for_status()"}),
    t({"", "                return await response.json()"}),
    t({"", "        except aiohttp.ClientError as e:"}),
    t({"", "            print(f'Error fetching data: {e}')"}),
    t({"", "            raise"}), i(0)
  }),
  s("fastapi", {
    t("from fastapi import FastAPI, HTTPException"),
    t({"", "from pydantic import BaseModel"}),
    t({"", ""}),
    t({"", "app = FastAPI()"}),
    t({"", ""}),
    t({"", "class "}), i(1, "Item"), t("(BaseModel):"),
    t({"", "    name: str"}),
    t({"", "    price: float"}),
    t({"", ""}),
    t({"", "@app.get('/items/{item_id}')"}),
    t({"", "async def get_item(item_id: int):"}),
    t({"", "    if item_id < 1:"}),
    t({"", "        raise HTTPException(status_code=400, detail='Invalid item ID')"}),
    t({"", "    return {'item_id': item_id, 'name': '"}), i(2, "Sample Item"), t("'}"), i(0)
  })
})

-- Java - Snippets modernos
ls.add_snippets("java", {
  s("class", {
    t("public class "), i(1, "MyClass"), t(" {"),
    t({"", "    private "}), i(2, "String"), t(" "), i(3, "field"), t(";"),
    t({"", ""}),
    t({"", "    public "}), i(1), t("("), i(4), t(") {"),
    t({"", "        this."}), i(3), t(" = "), i(5), t(";"),
    t({"", "    }"}),
    t({"", ""}),
    t({"", "    public "}), i(6, "void"), t(" "), i(7, "method"), t("() {"),
    t({"", "        "}), i(8),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  }),
  s("spring", {
    t("@RestController"),
    t({"", "@RequestMapping('/api/"}), i(1, "users"), t("')"),
    t({"", "public class "}), i(2, "UserController"), t(" {"),
    t({"", ""}),
    t({"", "    @Autowired"}),
    t({"", "    private "}), i(3, "UserService"), t(" userService;"),
    t({"", ""}),
    t({"", "    @GetMapping('/{id}')"}),
    t({"", "    public ResponseEntity<User> getUser(@PathVariable Long id) {"}),
    t({"", "        try {"}),
    t({"", "            User user = userService.findById(id);"}),
    t({"", "            return ResponseEntity.ok(user);"}),
    t({"", "        } catch (Exception e) {"}),
    t({"", "            return ResponseEntity.notFound().build();"}),
    t({"", "        }"}),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  })
})

-- C# - Snippets .NET
ls.add_snippets("cs", {
  s("class", {
    t("public class "), i(1, "MyClass"), t(" {"),
    t({"", "    private "}), i(2, "string"), t(" _"), i(3, "field"), t(";"),
    t({"", ""}),
    t({"", "    public "}), i(1), t("("), i(4), t(") {"),
    t({"", "        _"}), i(3), t(" = "), i(5), t(";"),
    t({"", "    }"}),
    t({"", ""}),
    t({"", "    public "}), i(6, "void"), t(" "), i(7, "Method"), t("() {"),
    t({"", "        "}), i(8),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  }),
  s("api", {
    t("[ApiController]"),
    t({"", "[Route('api/[controller]')]"}),
    t({"", "public class "}), i(1, "UsersController"), t(" : ControllerBase {"),
    t({"", "    private readonly "}), i(2, "IUserService"), t(" _userService;"),
    t({"", ""}),
    t({"", "    public "}), i(1), t("("), i(2), t(" userService) {"),
    t({"", "        _userService = userService;"}),
    t({"", "    }"}),
    t({"", ""}),
    t({"", "    [HttpGet('{id}')]"}),
    t({"", "    public async Task<ActionResult<User>> GetUser(int id) {"}),
    t({"", "        try {"}),
    t({"", "            var user = await _userService.GetByIdAsync(id);"}),
    t({"", "            return Ok(user);"}),
    t({"", "        } catch (Exception ex) {"}),
    t({"", "            return NotFound();"}),
    t({"", "        }"}),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  })
})

-- Go - Snippets modernos
ls.add_snippets("go", {
  s("struct", {
    t("type "), i(1, "User"), t(" struct {"),
    t({"", "    ID    int    `json:\"id\"`"}),
    t({"", "    Name  string `json:\"name\"`"}),
    t({"", "    Email string `json:\"email\"`"}),
    t({"", "}"}),
    t({"", ""}),
    t({"", "func (u *"}), i(1), t(") "), i(2, "Method"), t("() error {"),
    t({"", "    "}), i(3),
    t({"", "    return nil"}),
    t({"", "}"}), i(0)
  }),
  s("handler", {
    t("func "), i(1, "handleUsers"), t("(w http.ResponseWriter, r *http.Request) {"),
    t({"", "    w.Header().Set(\"Content-Type\", \"application/json\")"),
    t({"", ""}),
    t({"", "    switch r.Method {"}),
    t({"", "    case http.MethodGet:"}),
    t({"", "        "}), i(2, "// GET logic"),
    t({"", "    case http.MethodPost:"}),
    t({"", "        "}), i(3, "// POST logic"),
    t({"", "    default:"}),
    t({"", "        http.Error(w, \"Method not allowed\", http.StatusMethodNotAllowed)"}),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  })
})

-- PHP - Snippets modernos
ls.add_snippets("php", {
  s("class", {
    t("<?php"),
    t({"", ""}),
    t({"", "class "}), i(1, "MyClass"), t(" {"),
    t({"", "    private "}), i(2, "$property"), t(";"),
    t({"", ""}),
    t({"", "    public function __construct("}), i(3), t(") {"),
    t({"", "        $this->"}), i(2), t(" = "), i(4), t(";"),
    t({"", "    }"}),
    t({"", ""}),
    t({"", "    public function "}), i(5, "method"), t("(): "), i(6, "string"), t(" {"),
    t({"", "        "}), i(7),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  }),
  s("laravel", {
    t("<?php"),
    t({"", ""}),
    t({"", "namespace App\\Http\\Controllers;"),
    t({"", ""}),
    t({"", "use Illuminate\\Http\\Request;"),
    t({"", "use Illuminate\\Http\\JsonResponse;"),
    t({"", ""}),
    t({"", "class "}), i(1, "UserController"), t(" extends Controller {"),
    t({"", "    public function index(): JsonResponse {"}),
    t({"", "        $users = User::all();"}),
    t({"", "        return response()->json($users);"}),
    t({"", "    }"}),
    t({"", ""}),
    t({"", "    public function store(Request $request): JsonResponse {"}),
    t({"", "        $validated = $request->validate(["}),
    t({"", "            'name' => 'required|string|max:255',"}),
    t({"", "            'email' => 'required|email|unique:users'"}),
    t({"", "        ]);"}),
    t({"", ""}),
    t({"", "        $user = User::create($validated);"}),
    t({"", "        return response()->json($user, 201);"}),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  })
})

-- Rust - Snippets modernos
ls.add_snippets("rust", {
  s("struct", {
    t("#[derive(Debug, Clone)]"),
    t({"", "struct "}), i(1, "User"), t(" {"),
    t({"", "    id: u32,"}),
    t({"", "    name: String,"}),
    t({"", "    email: String,"}),
    t({"", "}"}),
    t({"", ""}),
    t({"", "impl "}), i(1), t(" {"),
    t({"", "    fn new(id: u32, name: String, email: String) -> Self {"}),
    t({"", "        Self { id, name, email }"}),
    t({"", "    }"}),
    t({"", "}"}), i(0)
  }),
  s("async", {
    t("use tokio;"),
    t({"", "use reqwest;"),
    t({"", ""}),
    t({"", "async fn "}), i(1, "fetch_data"), t("(url: &str) -> Result<String, reqwest::Error> {"),
    t({"", "    let response = reqwest::get(url).await?;"},
    t({"", "    let body = response.text().await?;"}),
    t({"", "    Ok(body)"}),
    t({"", "}"}),
    t({"", ""}),
    t({"", "#[tokio::main]"}),
    t({"", "async fn main() -> Result<(), Box<dyn std::error::Error>> {"}),
    t({"", "    let data = "}), i(1), t("(\""), i(2, "https://api.example.com"), t("\").await?;"),
    t({"", "    println!(\"{}\", data);"}),
    t({"", "    Ok(())"}),
    t({"", "}"}), i(0)
  })
})

-- Vue.js - Snippets modernos
ls.add_snippets("vue", {
  s("component", {
    t("<template>"),
    t({"", "  <div class=\""}), i(1, "container"), t("\">"),
    t({"", "    <h1>{{ "}), i(2, "title"), t(" }}</h1>"),
    t({"", "    <button @click=\""}), i(3, "handleClick"), t("\">Click me</button>"),
    t({"", "  </div>"}),
    t({"", "</template>"}),
    t({"", ""}),
    t({"", "<script setup>"}),
    t({"", "import { ref, onMounted } from 'vue'"}),
    t({"", ""}),
    t({"", "const "}), i(2), t(" = ref('"), i(4, "Hello Vue"), t("')"),
    t({"", "const "}), i(5, "count"), t(" = ref(0)"),
    t({"", ""}),
    t({"", "const "}), i(3), t(" = () => {"),
    t({"", "  "}), i(5), t(".value++"),
    t({"", "}"}),
    t({"", ""}),
    t({"", "onMounted(() => {"}),
    t({"", "  console.log('Component mounted')"}),
    t({"", "})"}),
    t({"", "</script>"}), i(0)
  })
})

-- Docker - Snippets profesionales
ls.add_snippets("dockerfile", {
  s("node", {
    t("FROM node:18-alpine"),
    t({"", ""}),
    t({"", "WORKDIR /app"}),
    t({"", ""}),
    t({"", "COPY package*.json ./"}),
    t({"", "RUN npm ci --only=production"}),
    t({"", ""}),
    t({"", "COPY . ."}),
    t({"", ""}),
    t({"", "EXPOSE "}), i(1, "3000"),
    t({"", ""}),
    t({"", "USER node"}),
    t({"", ""}),
    t({"", "CMD [\"npm\", \"start\"]"}), i(0)
  }),
  s("multistage", {
    t("# Build stage"),
    t({"", "FROM node:18-alpine AS builder"}),
    t({"", "WORKDIR /app"}),
    t({"", "COPY package*.json ./"}),
    t({"", "RUN npm ci"}),
    t({"", "COPY . ."}),
    t({"", "RUN npm run build"}),
    t({"", ""}),
    t({"", "# Production stage"}),
    t({"", "FROM node:18-alpine AS production"}),
    t({"", "WORKDIR /app"}),
    t({"", "COPY package*.json ./"}),
    t({"", "RUN npm ci --only=production"}),
    t({"", "COPY --from=builder /app/dist ./dist"}),
    t({"", "EXPOSE "}), i(1, "3000"),
    t({"", "CMD [\"npm\", \"start\"]"}), i(0)
  })
})

-- SQL - Snippets profesionales
ls.add_snippets("sql", {
  s("table", {
    t("CREATE TABLE "), i(1, "users"), t(" ("),
    t({"", "    id SERIAL PRIMARY KEY,"}),
    t({"", "    name VARCHAR(255) NOT NULL,"}),
    t({"", "    email VARCHAR(255) UNIQUE NOT NULL,"}),
    t({"", "    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"}),
    t({"", "    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"}),
    t({"", "});"}),
    t({"", ""}),
    t({"", "CREATE INDEX idx_"}), i(1), t("_email ON "), i(1), t("(email);"), i(0)
  }),
  s("query", {
    t("SELECT "), i(1, "*"),
    t({"", "FROM "}), i(2, "users"), t(" u"),
    t({"", "LEFT JOIN "}), i(3, "profiles"), t(" p ON u.id = p.user_id"),
    t({"", "WHERE u."}), i(4, "active"), t(" = true"),
    t({"", "ORDER BY u.created_at DESC"},
    t({"", "LIMIT "}), i(5, "10"), t(";"), i(0)
  })
})