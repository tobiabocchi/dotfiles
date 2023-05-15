-- Configure the plugin only if it's installed
-- local success, _ = pcall(require, 'markdown-preview.nvim')
-- if not success then
--     return
-- end

-- default: 1, preview closes upon leaving markdown buffer
-- vim.g.mkdp_auto_close = 0

-- specify browser to open preview page
-- for path with space
-- valid: `/path/with\ space/xxx`
-- invalid: `/path/with\\ space/xxx`
-- default: ''
-- g.mkdp_browser = ''

-- default is 0, echo url in command line when open preview page
vim.g.mkdp_echo_preview_url = 1

-- a custom vim function name to open preview page
-- this function will receive url as param
-- default is empty
-- g.mkdp_browserfunc = ''

-- options for markdown render
-- mkit: markdown-it options for render
-- katex: katex options for math
-- uml: markdown-it-plantuml options
-- maid: mermaid options
-- disable_sync_scroll: if disable sync scroll, default 0
-- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
--   middle: mean the cursor position alway show at the middle of the preview page
--   top: mean the vim top viewport alway show at the top of the preview page
--   relative: mean the cursor position alway show at the relative positon of the preview page
-- hide_yaml_meta: if hide yaml metadata, default is 1
-- sequence_diagrams: js-sequence-diagrams options
-- content_editable: if enable content editable for preview page, default: v:false
-- disable_filename: if disable filename header for preview page, default: 0
-- g.mkdp_preview_options = {
--     \ 'mkit': {},
--     \ 'katex': {},
--     \ 'uml': {},
--     \ 'maid': {},
--     \ 'disable_sync_scroll': 0,
--     \ 'sync_scroll_type': 'middle',
--     \ 'hide_yaml_meta': 1,
--     \ 'sequence_diagrams': {},
--     \ 'flowchart_diagrams': {},
--     \ 'content_editable': v:false,
--     \ 'disable_filename': 0,
--     \ 'toc': {}
--     \ }

-- preview page title
-- ${name} will be replace with the file name
vim.g.mkdp_page_title = 'M↓Preview: ${name}'

-- set default theme (dark or light)
-- By default the theme is define according to the preferences of the system
vim.g.mkdp_theme = 'dark'
