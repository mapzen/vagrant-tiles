%w(
  git+https://github.com/mapzen/tilequeue#egg=tilequeue
  git+https://github.com/mapzen/tilestache-providers#egg=tilestache-providers
  git+https://github.com/mapzen/tileglue#egg=tileglue
).each do |p|
  python_pip p
end
