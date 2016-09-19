var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  entry: ["./semantic/dist/semantic.css", "./semantic/dist/semantic.js", "./web/static/js/app.js"],
  output: {
    path: "./priv/static",
    filename: "js/app.js"
  },

  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: "babel",
      query: {
        presets: ["es2015"]
      }
    }, {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract("style", "css")
    }, {
        test: /\.(eot|svg|ttf|woff|woff2)$/,
        loader: 'file?emitFile=false&name=../assets/themes/default/assets/fonts/[name].[ext]'
    }]
  },

  plugins: [
    new ExtractTextPlugin("css/app.css"),
    new CopyWebpackPlugin([
      {from: './semantic/dist/assets', to: 'assets'}
    ])
  ],

  resolve: {
    modulesDirectories: [ "node_modules", __dirname + "/web/static/js", __dirname + "/semantic/dist" ]
  }
};