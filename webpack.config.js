module.exports = {
  entry: './src/js/AppMain.coffee',
  output: {
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.scss$/, loader: "style-loader!css-loader!sass-loader" }
    ]
  },
  resolve: {
    extensions: ["", ".web.coffee", ".web.js", ".coffee", ".js", ".scss"]
  }
}
