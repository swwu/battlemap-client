module.exports = {
  entry: './src/AppMain.coffee',
  output: {
    filename: 'bundle.js'
  },
	module: {
		loaders: [
			{ test: /\.coffee$/, loader: "coffee" }
		]
	},
	resolve: {
		extensions: ["", ".web.coffee", ".web.js", ".coffee", ".js"]
	}
}
