module.exports = {
  presets: [
    'module:@react-native/babel-preset',
    '@babel/preset-flow',
    '@babel/preset-typescript',
    '@babel/preset-react',
  ],
  plugins: [
    '@babel/plugin-transform-flow-strip-types',
  ],
};
