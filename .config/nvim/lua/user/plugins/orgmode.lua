-- load orgmode plugin
local orgmode_status, orgmode = pcall(require, "orgmode")
if not orgmode_status then
  return
end


orgmode.setup_ts_grammar()

orgmode.setup({
    org_agenda_files = {
        '~/.local/share/gtd/todo.org',
        '~/.local/share/gtd/regular.org',
        '~/.local/share/gtd/someday.org',
    },
    org_archive_location = '~/.local/share/gtd/archive.org',
    org_default_notes_file = '~/.local/share/gtd/inbox.org',
    org_todo_keywords = {
        'TODO(t)', 'NEXT(n)', 'WAIT(w)', 'PROJ(p)',
        '|',
        'DONE(d)', 'CANC(c)', 'SUSP(s)'
    },
    org_deadline_warning_days = 14,
    org_agenda_start_on_weekday = false,  -- start agenda view from today
    org_agenda_start_day = '-2d',         -- offset of start day in agenda view
    org_agenda_templates = {
        t = {description = 'TODO', template = '* TODO %?\n  %u'},
        p = {description = 'PROJECT', template = '* PROJ %?\n  %u'},
        n = {description = 'NOTE', template = '* NOTE %?\n  %u'}
    },
    org_todo_keyword_faces = {
        SUSP = ':foreground cyan :weight bold',
    }
})
