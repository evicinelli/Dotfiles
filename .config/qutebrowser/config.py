config.load_autoconfig(False)

c.editor.command = ['x-terminal-emulator', '-e', 'nvim', '{file}']

c.fonts.web.family.fixed = 'Monospace'
c.fonts.web.family.sans_serif = 'Sans Serif'
c.fonts.web.family.serif = 'Serif'

c.url.default_page = 'https://ecosia.com/'
c.url.searchengines = {'DEFAULT': 'https://ecosia.com/search?q={}', 'ddg': 'https://duckduckgo.com/?q={}', 'msd':'https://www.msdmanuals.com/it/professionale/SearchResults?query={}', 'msden':'https://www.msdmanuals.com/en/professionale/SearchResults?query={}'}
c.url.start_pages = 'https://ecosia.com'

config.bind('E', 'edit-text')

config.bind('<Ctrl-m>', 'hint links spawn --detach mpv --force-window yes {hint-url}')
config.bind('<Ctrl-Shift-m>', 'spawn --detach mpv --force-window yes {url}')

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'qute://*/*')
