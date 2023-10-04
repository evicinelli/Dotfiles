// https://askubuntu.com/questions/1203105/ubuntu-18-04-3-lts-super-key-searching-increase-the-number-of-files-displaye

function init() {}

function enable() { imports.ui.search.MAX_LIST_SEARCH_RESULTS_ROWS=10; }

function disable() { imports.ui.search.MAX_LIST_SEARCH_RESULTS_ROWS=5; }
