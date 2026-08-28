# Makefile do teste técnico GGSoft (OpenFL/Lime + Haxe)
# Alvo principal de ENTREGA: HTML5 (é o que deve ir versionado no seu repo,
# em Export/html5/bin, pra quem avaliar abrir direto no navegador).

LIME ?= lime

.PHONY: html run clean rebuild windows macos

# Compila para HTML5 → saída em Export/html5/bin (é isso que você entrega).
html:
	$(LIME) build html5

# Compila e já abre no navegador (útil enquanto você desenvolve).
run:
	$(LIME) test html5

# Build nativo Windows (opcional, só pra testar localmente — exige hxcpp).
windows:
	$(LIME) build windows

# Build nativo macOS (opcional, só pra testar localmente — exige hxcpp).
macos:
	$(LIME) build macos

clean:
	$(LIME) clean html5

rebuild: clean html
