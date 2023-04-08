const webpack = require("webpack"),
    WebpackMessages = require("webpack-messages"),
    WebpackBar = require("webpackbar"),
    ESLintPlugin = require("eslint-webpack-plugin"),
    MiniCssExtractPlugin = require("mini-css-extract-plugin"),
    process = require("process"),
    path = require("path"),
    srcFolder = path.resolve(__dirname, "src"),
    distFolder = path.resolve(__dirname, "dist");

module.exports = {
    watchOptions: {
        aggregateTimeout: 200,
        poll: 1e3
    },
    resolve: {
        fallback: {
            fs: !1
        }
    },
    module: {
        rules: [{
            test: /\.m?js$/,
            exclude: /(node_modules)/,
            use: {
                loader: "babel-loader",
                options: {
                    presets: ["@babel/preset-env"]
                }
            }
        }, {
            test: /\.s?css$/,
            use: [MiniCssExtractPlugin.loader, "css-loader", "sass-loader"]
        }]
    },
    optimization: {
        minimize: !0,
        concatenateModules: !0,
        emitOnErrors: !0
    },
    plugins: [new webpack.BannerPlugin("Copyright 2022 NiWee Productions."), new WebpackMessages({
        name: "Building Wordpress bundle in " + process.env.NODE_ENV + " mode",
        logger: e => console.log(`>> ${e}`)
    }), new WebpackBar({
        name: "Building Wordpress bundle in " + process.env.NODE_ENV + " mode",
        color: "#006994",
        basic: !1,
        profile: !0,
        fancy: !0,
        reporters: ["fancy"]
    }), new ESLintPlugin, new MiniCssExtractPlugin({
        filename: "css/style.min.css"
    })]
};