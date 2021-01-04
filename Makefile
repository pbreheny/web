_site/index.html: *.* pubs/*.* _sass/*.scss _layouts/*.html js/switcher.js pdf/BrehenyCV.pdf
	cd pubs;\
	R CMD BATCH --no-save --no-restore x.R .x.Rout
	jekyll build
