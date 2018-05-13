%.dbk: %.html
	cat lib/header.dbk > $@
	echo '<articleinfo>' >> $@
	TITLE=$$(grep '<title>' test.html | sed 's/.*<title>\(.*\)<\/title>.*/\1/'); \
	echo '<title>'$$TITLE'</title>' >> $@
	echo '</articleinfo>' >> $@
	pandoc -t docbook $< >> $@
	cat lib/footer.dbk >> $@

%.fo: %.dbk
	xsltproc /usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl $< > $@

%.pdf: %.fo
	fop -fo $< -pdf $@


clean:
	rm -f *.dbk *.pdf *.fo
