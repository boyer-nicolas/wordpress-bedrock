"use strict";
module.exports = function (e) {
    return e.cache(!0), e.assertVersion("^7.4.5"), {
        presets: [
            ["@babel/preset-env", {
                targets: {
                    esmodules: !0,
                    node: !0
                }
            }]
        ],
        plugins: [
            ["@babel/plugin-transform-modules-commonjs"],
            ["@babel/plugin-transform-destructuring"],
            ["@babel/plugin-proposal-class-properties"],
            ["@babel/plugin-proposal-decorators", {
                decoratorsBeforeExport: !0
            }],
            ["@babel/plugin-proposal-export-default-from"],
            ["@babel/plugin-proposal-export-namespace-from"],
            ["@babel/plugin-proposal-object-rest-spread"],
            ["@babel/plugin-transform-template-literals"],
            ["@babel/plugin-proposal-pipeline-operator", {
                proposal: "minimal"
            }],
            ["@babel/plugin-transform-runtime"],
            ["@babel/plugin-transform-classes"]
        ]
    }
};