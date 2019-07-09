_site/index.html: *.* pubs/*.* css/style.scss _layouts/*.html js/switcher.js
	cd pubs;\
	R CMD BATCH --no-save --no-restore x.R .x.Rout
	jekyll build
