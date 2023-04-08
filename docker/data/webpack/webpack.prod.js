const {
    merge
} = require("webpack-merge"),
    common = require("./webpack.common.js"),
    path = require("path"),
    srcFolder = path.resolve(__dirname, "src"),
    distFolder = path.resolve(__dirname, "dist");

module.exports = merge(common, {
    entry: ["babel-polyfill", srcFolder + "/js/script.js", srcFolder + "/scss/style.scss"],
    devtool: "source-map",
    output: {
        path: distFolder,
        filename: "js/script.min.js",
        clean: !0
    }
});