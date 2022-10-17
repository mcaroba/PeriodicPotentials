# Before running this script you need to do this
# npm install
# npm run serve


# Built the TurboGAP pages
ln -sf vue_turbogap.config.js vue.config.js
npm run build
cd dist
tar -czvf ../turbogap_files.tar.gz *
cd ..

# Built the GAP pages
ln -sf vue_gap.config.js vue.config.js
npm run build
cd dist
tar -czvf ../gap_files.tar.gz *
cd ..
