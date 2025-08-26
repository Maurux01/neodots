-- Configuración de snippets personalizados
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Snippets para C
ls.add_snippets("c", {
  s("if", {
    t("if ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("else", {
    t("else {"),
    t({"", "    "}), i(1, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("elif", {
    t("else if ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("while", {
    t("while ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("for", {
    t("for ("), i(1, "int i = 0"), t("; "), i(2, "i < n"), t("; "), i(3, "i++"), t(") {"),
    t({"", "    "}), i(4, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("main", {
    t("#include <stdio.h>"),
    t({"", "", "int main() {"}),
    t({"", "    "}), i(1, "// código aquí"),
    t({"", "    return 0;"}),
    t({"", "}"}), i(0)
  }),
  
  s("printf", {
    t("printf(\""), i(1, "formato"), t("\", "), i(2, "variables"), t(");"), i(0)
  }),
  
  s("scanf", {
    t("scanf(\""), i(1, "%d"), t("\", "), i(2, "&variable"), t(");"), i(0)
  })
})

-- Snippets para C++
ls.add_snippets("cpp", {
  s("if", {
    t("if ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("else", {
    t("else {"),
    t({"", "    "}), i(1, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("elif", {
    t("else if ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("while", {
    t("while ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("for", {
    t("for ("), i(1, "int i = 0"), t("; "), i(2, "i < n"), t("; "), i(3, "i++"), t(") {"),
    t({"", "    "}), i(4, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("main", {
    t("#include <iostream>"),
    t({"", "using namespace std;", "", "int main() {"}),
    t({"", "    "}), i(1, "// código aquí"),
    t({"", "    return 0;"}),
    t({"", "}"}), i(0)
  }),
  
  s("cout", {
    t("cout << "), i(1, "\"mensaje\""), t(" << endl;"), i(0)
  }),
  
  s("cin", {
    t("cin >> "), i(1, "variable"), t(";"), i(0)
  }),
  
  s("class", {
    t("class "), i(1, "ClassName"), t(" {"),
    t({"", "private:"}),
    t({"", "    "}), i(2, "// miembros privados"),
    t({"", "", "public:"}),
    t({"", "    "}), i(3, "// constructor y métodos"),
    t({"", "};"}), i(0)
  })
})

-- Snippets para Python
ls.add_snippets("python", {
  s("if", {
    t("if "), i(1, "condition"), t(":"),
    t({"", "    "}), i(2, "# código aquí"), i(0)
  }),
  
  s("else", {
    t("else:"),
    t({"", "    "}), i(1, "# código aquí"), i(0)
  }),
  
  s("elif", {
    t("elif "), i(1, "condition"), t(":"),
    t({"", "    "}), i(2, "# código aquí"), i(0)
  }),
  
  s("while", {
    t("while "), i(1, "condition"), t(":"),
    t({"", "    "}), i(2, "# código aquí"), i(0)
  }),
  
  s("for", {
    t("for "), i(1, "item"), t(" in "), i(2, "iterable"), t(":"),
    t({"", "    "}), i(3, "# código aquí"), i(0)
  }),
  
  s("def", {
    t("def "), i(1, "function_name"), t("("), i(2, "parameters"), t("):"),
    t({"", "    "}), i(3, "# código aquí"),
    t({"", "    return "}), i(4, "None"), i(0)
  }),
  
  s("class", {
    t("class "), i(1, "ClassName"), t(":"),
    t({"", "    def __init__(self, "}), i(2, "parameters"), t("):"),
    t({"", "        "}), i(3, "# inicialización"), i(0)
  })
})

-- Snippets para JavaScript
ls.add_snippets("javascript", {
  s("if", {
    t("if ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("else", {
    t("else {"),
    t({"", "    "}), i(1, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("elif", {
    t("else if ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("while", {
    t("while ("), i(1, "condition"), t(") {"),
    t({"", "    "}), i(2, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("for", {
    t("for (let "), i(1, "i = 0"), t("; "), i(2, "i < array.length"), t("; "), i(3, "i++"), t(") {"),
    t({"", "    "}), i(4, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("function", {
    t("function "), i(1, "functionName"), t("("), i(2, "parameters"), t(") {"),
    t({"", "    "}), i(3, "// código aquí"),
    t({"", "}"}), i(0)
  }),
  
  s("arrow", {
    t("const "), i(1, "functionName"), t(" = ("), i(2, "parameters"), t(") => {"),
    t({"", "    "}), i(3, "// código aquí"),
    t({"", "}"}), i(0)
  })
})