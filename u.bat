mkdocs build
xcopy site "../louhc-oi.github.io" /S /Y
rm site -rf
