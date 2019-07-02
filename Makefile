_site/index.html: *.* pubs/*.* _includes/main.css _layouts/*.html js/switcher.js
	cd pubs;\
	R CMD BATCH --no-save --no-restore x.R .x.Rout
	jekyll build
