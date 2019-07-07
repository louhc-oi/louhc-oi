mkdocs build
rm site/assets -rf
xcopy site "../louhc-oi.github.io" /S /Y
rm site -rf
