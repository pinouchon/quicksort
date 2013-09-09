#BetterErrors.editor = :rubymine if defined? BetterErrors
#BetterErrors.editor = "rubymine://open/?url=file://%{file}&line=%{line}" if defined? BetterErrors
#BetterErrors.editor = 'rubymine://open?url=file://%{file}&line=%{line}'  if defined? BetterErrors

BetterErrors.editor='x-mine://open?file=%{file}&line=%{line}' if defined? BetterErrors # if OS==macOs
#BetterErrors.editor='????' # if OS==ubuntu