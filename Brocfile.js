/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp();

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

app.import('vendor/bootstrap/dist/js/bootstrap.js');
app.import('vendor/bootstrap/dist/css/bootstrap.css');
app.import('vendor/debugjs/dist/bundle.js');

app.import('vendor/ember-split-view/lib/ember-split-view.js')

app.import('vendor/es5-shim/es5-shim.js');

var pickFiles = require('broccoli-static-compiler');
var aceEditor = pickFiles('vendor/ace-builds/src-noconflict/', {
    srcDir: '/',
    files: ['worker-javascript.js', 'ace.js', 'mode-javascript.js'],
    destDir: '/assets'
});

var bootstrapForEmber = pickFiles('vendor/ember-addons.bs_for_ember/dist/js/', {
    srcDir: '/',
    files: ['bs-core.max.js', 'bs-basic.max.js', 'bs-modal.max.js', 'bs-button.max.js'],
    destDir: '/assets'
});

var bootstrapSlider = pickFiles('public/', {
	srcDir: '/',
	files: ['bootstrap-slider.js', 'slider.css'],
	destDir: '/assets'
});

var mergeTrees = require('broccoli-merge-trees');
module.exports = mergeTrees([app.toTree(), aceEditor, bootstrapForEmber, bootstrapSlider]);
