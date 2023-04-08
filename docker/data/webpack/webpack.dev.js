const {
    merge
} = require("webpack-merge"),
    common = require("./webpack.common.js"),
    fs = require("fs"),
    CopyPlugin = require("copy-webpack-plugin"),
    path = require("path"),
    srcFolder = path.resolve(__dirname, "src"),
    distFolder = path.resolve(__dirname, "dist");

module.exports = merge(common, {
    entry: ["babel-polyfill", srcFolder + "/js/script.js", srcFolder + "/scss/style.scss"],
    output: {
        path: distFolder,
        filename: "js/script.min.js",
        clean: !0
    },
    devtool: "inline-source-map",
});