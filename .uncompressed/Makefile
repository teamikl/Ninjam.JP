##

# Usage:
# watchmedo shell-command --patterns="*.js;*.css;*.html" --command="make gzip"

JS_SRC = ${wildcard *.js}
CSS_SRC = ${wildcard *.css}
HTML_SRC = ${wildcard *.html}
SRCS = $(JS_SRC) $(CSS_SRC) $(HTML_SRC)
GZIP = $(JS_SRC:%.js=%.js.gz) $(CSS_SRC:%.css=%.css.gz) $(HTML_SRC:%.html=%.html.gz)

%.gz : % $(SRCS)
	gzip -k -f $<

gzip: $(GZIP)
	mv *.html.gz ../
	mv *.css.gz ../

clean:
	rm -rf *.gz

.PHONY: clean
