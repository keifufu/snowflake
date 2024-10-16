{ pkgs, ... }:

{
  home.packages = with pkgs; [
    p7zip-rar
    fd
  ];

  programs.yazi = {
    enable = true;
    catppuccin.enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        ratio = [ 1 4 3];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "size";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;
      };
    };
    keymap = {
      manager.keymap = [
        { on = [ "<Esc>" ]; run = "escape";             desc = "Exit visual mode; clear selected; or cancel search"; }
        { on = [ "q" ];     run = "quit";               desc = "Exit the process"; }

        # Navigation
        { on = [ "<Up>" ];    run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ];  run = "arrow 1";  desc = "Move cursor down"; }
        { on = [ "<Left>" ];  run = "leave";    desc = "Go back to the parent directory"; }
        { on = [ "<Right>" ]; run = "enter";    desc = "Enter the child directory"; }

        { on = [ "<S-Up>" ];   run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "<S-Down>" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }

        { on = [ "<C-Up>" ]; run = "arrow -100%";  desc = "Move cursor up full page"; }
        { on = [ "<C-Down>" ]; run = "arrow 100%"; desc = "Move cursor down full page"; }

        # Selection
        { on = [ "<Space>" ]; run = [ "select --state=none" "arrow 1" ];  desc = "Toggle the current selection state"; }
        { on = [ "<C-a>" ];   run = "select_all --state=true";            desc = "Select all files"; }
        { on = [ "<C-r>" ];   run = "select_all --state=none";            desc = "Inverse selection of all files"; }

        # Operation
        { on = [ "<Enter>" ];   run = "open";                       desc = "Open the selected files"; }
        { on = [ "<C-Enter>" ]; run = "open --interactive";         desc = "Open the selected files interactively"; }
        { on = [ "y" ];         run = ["yank" ''
          shell --confirm 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list'
          ''];                                                      desc = "Copy the selected files"; }
        { on = [ "Y" ];         run = "unyank";                     desc = "Cancel the yank status of files"; }
        { on = [ "x" ];         run = "yank --cut";                 desc = "Cut the selected files"; }
        { on = [ "X" ];         run = "unyank";                     desc = "Cancel the yank status of files"; }
        { on = [ "p" ];         run = "paste";                      desc = "Paste the files"; }
        { on = [ "P" ];         run = "paste --force";              desc = "Paste the files (overwrite if the destination exists)"; }
        { on = [ "d" ];         run = "remove";                     desc = "Move the files to the trash"; }
        # { on = [ "D" ];         run = "remove --permanently";       desc = "Permanently delete the files"; }
        { on = [ "D" ];         run = "remove";                     desc = "Move the files to the trash"; }
        { on = [ "a" ];         run = "create";                     desc = "Create a file or directory (ends with / for directories)"; }
        { on = [ "r" ];         run = "rename --cursor=before_ext"; desc = "Rename a file or directory"; }
        { on = [ ";" ];         run = "shell --interactive";                      desc = "Run a shell command"; }
        { on = [ ":" ];         run = "shell --interactive --block";              desc = "Run a shell command (block the UI until the command finishes)"; }
        { on = [ "." ];         run = "hidden toggle";              desc = "Toggle the visibility of hidden files"; }

        # Find
        { on = [ "<C-f>" ]; run = "find --smart";            desc = "Find next file"; }
        { on = [ "n" ];     run = "find_arrow";              desc = "Go to next found file"; }
        { on = [ "N" ];     run = "find_arrow --previous";   desc = "Go to previous found file"; }

        # Filter
        { on = [ "f" ]; run = "filter --smart"; desc = "Filter the files"; }

        # Linemode
        { on = [ "m" "s" ]; run = "linemode size";        desc = "Set linemode to size"; }
        { on = [ "m" "p" ]; run = "linemode permissions"; desc = "Set linemode to permissions"; }
        { on = [ "m" "m" ]; run = "linemode mtime";       desc = "Set linemode to mtime"; }
        { on = [ "m" "n" ]; run = "linemode none";        desc = "Set linemode to none"; }

        # Copy
        { on = [ "c" "c" ]; run = "copy path";             desc = "Copy the absolute path"; }
        { on = [ "c" "d" ]; run = "copy dirname";          desc = "Copy the path of the parent directory"; }
        { on = [ "c" "f" ]; run = "copy filename";         desc = "Copy the name of the file"; }
        { on = [ "c" "n" ]; run = "copy name_without_ext"; desc = "Copy the name of the file without the extension"; }

        # Sorting
        { on = [ "s" "M" ]; run = "sort modified --reverse=no --dir-first";               desc = "Sort by modified time"; }
        { on = [ "s" "m" ]; run = "sort modified --reverse --dir-first";     desc = "Sort by modified time (reverse)"; }
        { on = [ "s" "C" ]; run = "sort created --reverse=no --dir-first";                desc = "Sort by created time"; }
        { on = [ "s" "c" ]; run = "sort created --reverse --dir-first";      desc = "Sort by created time (reverse)"; }
        { on = [ "s" "E" ]; run = "sort extension --reverse=no --dir-first";         	    desc = "Sort by extension"; }
        { on = [ "s" "e" ]; run = "sort extension --reverse --dir-first";    desc = "Sort by extension (reverse)"; }
        { on = [ "s" "A" ]; run = "sort alphabetical --reverse=no --dir-first";           desc = "Sort alphabetically"; }
        { on = [ "s" "a" ]; run = "sort alphabetical --reverse --dir-first"; desc = "Sort alphabetically (reverse)"; }
        { on = [ "s" "N" ]; run = "sort natural --reverse=no --dir-first";                desc = "Sort naturally"; }
        { on = [ "s" "n" ]; run = "sort natural --reverse --dir-first";      desc = "Sort naturally (reverse)"; }
        { on = [ "s" "S" ]; run = "sort size --reverse=no --dir-first";                   desc = "Sort by size"; }
        { on = [ "s" "s" ]; run = "sort size --reverse --dir-first";         desc = "Sort by size (reverse)"; }

        # Tasks
        { on = [ "t" ]; run = "tasks_show"; desc = "Show the tasks manager"; }

        # Goto
        { on = [ "G" ];           run = "arrow 99999999";   desc = "Move cursor to the bottom"; }
        { on = [ "g" "g" ];       run = "arrow -99999999";  desc = "Move cursor to the top"; }
        { on = [ "g" "h" ];       run = "cd ~";             desc = "Go to the home directory"; }
        { on = [ "g" "d" ];       run = "cd ~/Downloads";   desc = "Go to the downloads directory"; }
        { on = [ "g" "s" ];       run = "cd /stuff";        desc = "Go to the stuff directory"; }
        { on = [ "g" "c" ];       run = "cd /stuff/code";   desc = "Go to the code directory"; }
        { on = [ "g" "n" ];       run = "cd /nfs";          desc = "Go to the nfs directory"; }
        { on = [ "g" "p" ];       run = "cd /nfs/pictures"; desc = "Go to the pictures directory"; }
        { on = [ "g" "o" ];       run = "cd /nfs/others";   desc = "Go to the others directory"; }
        { on = [ "g" "<Space>" ]; run = "cd --interactive"; desc = "Go to a directory interactively"; }
      ];
      tasks.keymap = [
        { on = [ "<Esc>" ]; run = "close"; desc = "Hide the task manager"; }
        { on = [ "t" ];     run = "close"; desc = "Hide the task manager"; }

        { on = [ "<Up>" ];   run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1";  desc = "Move cursor down"; }

        { on = [ "<Enter>" ]; run = "inspect"; desc = "Inspect the task"; }
        { on = [ "<C-c>" ];   run = "cancel";  desc = "Cancel the task"; }
        { on = [ "x" ];       run = "cancel";  desc = "Cancel the task"; }
      ];
      select.keymap = [
        { on = [ "<Esc>" ];   run = "close";          desc = "Cancel selection"; }
        { on = [ "<C-c>" ];   run = "close";          desc = "Cancel selection"; }
        { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the selection"; }

        { on = [ "<Up>" ];   run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1";  desc = "Move cursor down"; }
        { on = [ "<S-Up>" ];   run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "<S-Down>" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }
      ];
      input.keymap = [
        { on = [ "<Esc>" ];   run = "close";          desc = "Closes input"; }
        { on = [ "<C-c>" ];   run = "close";          desc = "Cancel input"; }
        { on = [ "<Enter>" ]; run = "close --submit"; desc = "Submit the input"; }
        { on = [ "<Esc>" ];   run = "escape";         desc = "Go back the normal mode, or cancel input"; }
        { on = [ "<C-c>" ];   run = "escape";         desc = "Go back the normal mode, or cancel input"; }

        { on = [ "<Left>" ];  run = "move -1"; desc = "Move back a character"; }
        { on = [ "<Right>" ]; run = "move 1";  desc = "Move forward a character"; }

        # Word-wise movement
        { on = [ "<C-Left>" ];     run = "backward";              desc = "Move back to the start of the current or previous word"; }
        { on = [ "<C-Right>" ];    run = "forward";               desc = "Move forward to the start of the next word"; }

        # TODO: dont know how to select
        # Word-wise select
        # { on = [ "<C-S-Left>" ];     run = "backward";              desc = "Move back to the start of the current or previous word"; }
        # { on = [ "<C-S-Right>" ];    run = "forward";               desc = "Move forward to the start of the next word"; }

        # Delete
        { on = [ "<Backspace>" ];   run = "backspace";	       desc = "Delete the character before the cursor"; }
        { on = [ "<C-Backspace>" ]; run = "kill backward";	   desc = "Delete the previous word"; }
        { on = [ "<Delete>" ];      run = "backspace --under"; desc = "Delete the character under the cursor"; }

        # TODO: useless without selection
        # Cut/Yank/Paste
        # { on = [ "<C-x>" ]; run = "delete --cut"; desc = "Cut the selected characters"; }
        # { on = [ "<C-c>" ]; run = "yank";         desc = "Copy the selected characters"; }
        # { on = [ "<C-v>" ]; run = "paste";        desc = "Paste the copied characters after the cursor"; }
      ];
      completion.keymap = [
        { on = [ "<Tab>" ];   run = "close --submit";                            desc = "Submit the completion"; }
        { on = [ "<Right>" ]; run = "close --submit";                            desc = "Submit the completion"; }
        { on = [ "<Enter>" ]; run = [ "close --submit" "close_input --submit" ]; desc = "Submit the completion and input"; }

        { on = [ "<Up>" ];   run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<Down>" ]; run = "arrow 1";  desc = "Move cursor down"; }
        { on = [ "<S-Up>" ];   run = "arrow -5"; desc = "Move cursor up 5 lines"; }
        { on = [ "<S-Down>" ]; run = "arrow 5";  desc = "Move cursor down 5 lines"; }
      ];
    };
  };

  xdg.configFile."yazi/init.lua".text = ''
-- https://yazi-rs.github.io/docs/tips/#full-border
local function setup(_, opts)
	local type = opts and opts.type or ui.Border.ROUNDED
	local old_build = Tab.build

	Tab.build = function(self, ...)
		local bar = function(c, x, y)
			if x <= 0 or x == self._area.w - 1 then
				return ui.Bar(ui.Rect.default, ui.Bar.TOP)
			end

			return ui.Bar(
				ui.Rect { x = x, y = math.max(0, y), w = ya.clamp(0, self._area.w - x, 1), h = math.min(1, self._area.h) },
				ui.Bar.TOP
			):symbol(c)
		end

		local c = self._chunks
		self._chunks = {
			c[1]:padding(ui.Padding.y(1)),
			c[2]:padding(ui.Padding(c[1].w > 0 and 0 or 1, c[3].w > 0 and 0 or 1, 1, 1)),
			c[3]:padding(ui.Padding.y(1)),
		}

		local style = THEME.manager.border_style
		self._base = ya.list_merge(self._base or {}, {
			ui.Border(self._area, ui.Border.ALL):type(type):style(style),
			ui.Bar(self._chunks[1], ui.Bar.RIGHT):style(style),
			ui.Bar(self._chunks[3], ui.Bar.LEFT):style(style),

			bar("┬", c[1].right - 1, c[1].y),
			bar("┴", c[1].right - 1, c[1].bottom - 1),
			bar("┬", c[2].right, c[2].y),
			bar("┴", c[2].right, c[2].bottom - 1),
		})

		old_build(self, ...)
	end
end

setup()

-- https://yazi-rs.github.io/docs/tips/#user-group-in-status
Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line {}
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	}
end, 500, Status.RIGHT)

-- https://yazi-rs.github.io/docs/tips/#username-hostname-in-header
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line {}
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)
  '';
}
