# vim: nowrap

config.load_autoconfig(False)

c.editor.command = ['x-terminal-emulator', '-e', 'vim', '{file}']

c.fonts.web.family.fixed = 'Monospace'
c.fonts.web.family.sans_serif = 'Sans Serif'
c.fonts.web.family.serif = 'Serif'
c.fonts.web.family.standard = 'Sans Serif'
c.fonts.default_size = "14pt"

c.url.default_page = 'https://ecosia.com/'
c.url.searchengines = {'DEFAULT' : 'https:/ecosia.com/search?q={}',
                       'ddg'     : 'https:/duckduckgo.com/?q={}',
                       'msd'     : 'https:/www.msdmanuals.com/it/professionale/SearchResults?query={}',
                       'msden'   : 'https:/www.msdmanuals.com/en/professionale/SearchResults?query={}',
                       'utd'     : 'https:/www.uptodate.com/contents/search?search={}',
                       'farm'    : 'https:/mediately.co/it/drugs?q={}',
                       'trec'    : 'https://www.treccani.it/enciclopedia/ricerca/{}',
                       'wit'     : 'https:/it.m.wikipedia.org/w/index.php?go=Go&search={}',
                       'wen'     : 'https:/en.m.wikipedia.org/w/index.php?go=Go&search={}',
                       'meteo'   : 'https://www.meteoam.it/it/meteo-citta/{}',
                       }
c.url.start_pages = 'https://ecosia.com'

config.bind (',EZ','hint links fill :open https://www.ezproxy.unibo.it/login?url={hint-url}')
config.bind (',ez','open https://www.ezproxy.unibo.it/login?url={url}')
config.bind(',M', 'spawn --detach mpv --force-window yes {url}')
config.bind(',m', 'hint links spawn --detach mpv --force-window yes {hint-url}')
config.bind('<Ctrl-a>','fake-key <Home>', mode = 'insert')
config.bind('<Ctrl-e>','fake-key <End>', mode = 'insert')
config.bind('<Ctrl-p>','spawn sh -c "pass -c $(fd --type f .gpg .password-store | sed s,\.password-store/,, | sed s,.gpg,, | dmenu -i)" ;; fake-key <Ctrl-v>', mode='insert')
config.bind('<Ctrl-u>','fake-key <Shift+Home> ;; fake-key <Delete>', mode = 'insert')

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
