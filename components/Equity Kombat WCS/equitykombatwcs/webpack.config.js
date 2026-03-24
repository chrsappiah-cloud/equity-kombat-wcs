const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'production',
  entry: path.resolve(__dirname, 'EquityKombatWCS', 'index.js'),
  output: {
    path: path.resolve(__dirname, 'EquityKombatWCS', 'public'),
    filename: 'bundle.js',
    publicPath: '/',
  },
  resolve: {
    alias: {
      'react-native$': 'react-native-web',
    },
    extensions: ['.web.js', '.js', '.jsx', '.ts', '.tsx', '.json'],
  },
  module: {
    rules: [
      {
        test: /\.[jt]sx?$/,
        exclude: (modulePath) => {
          // Exclude all node_modules except @react-native/new-app-screen
          return /node_modules/.test(modulePath) && !/node_modules[\\/]@react-native[\\/]new-app-screen/.test(modulePath);
        },
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env', '@babel/preset-react', '@babel/preset-flow'],
            plugins: ['@babel/plugin-transform-flow-strip-types'],
          },
        },
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, 'EquityKombatWCS', 'public', 'index.html'),
    }),
  ],
  devServer: {
    static: path.resolve(__dirname, 'EquityKombatWCS', 'public'),
    historyApiFallback: true,
    port: 3000,
  },
};
