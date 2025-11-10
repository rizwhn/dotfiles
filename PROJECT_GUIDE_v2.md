
# Neovim Development Environment - Project Guide & System Prompt

**Version:** 2.0  
**Last Updated:** 2024-11-03  
**Repository:** [github.com/automaticalldramatic/dotfiles](https://github.com/automaticalldramatic/dotfiles)

---

## 📋 Changelog

### Version 2.0 (2024-11-03)
**Major Update: Modern Tooling & Dotfiles Management**

**Added:**
- GNU Stow-based dotfiles management system
- Modern CLI tools integration (fzf, bat, eza, zoxide, atuin, direnv)
- Starship prompt replacing custom PS1
- Ghostty theme-compatible color configuration
- Brewfile for reproducible package management
- Automated installation script
- `.zshrc.local` for secrets management
- Enhanced Git aliases with topology ordering
- Navigation functions (cx, fcd, fv, f)
- Tool installation checklist and progress tracking

**Changed:**
- Restructured `.zshrc` with clear sections and comments
- Removed hard-coded `LSCOLORS` for Ghostty theme compatibility
- Updated prompt to use ANSI color codes (or Starship)
- Improved Git log aliases (kept custom `gl`, added enhanced `glog`)
- Reorganized PATH configuration for clarity

**Removed:**
- Hard-coded terminal colors that conflict with Ghostty themes
- Redundant or unused aliases
- Direct API key storage in main `.zshrc`

**Fixed:**
- Terminal theme compatibility issues
- Case-insensitive completion
- History configuration for better cross-session sharing

---

### Version 1.0 (Initial - Pre-versioning)
**Initial Setup**

- Basic LazyVim installation
- Go LSP configuration (gopls)
- Lazygit integration
- Custom zsh prompt
- Basic git aliases
- aicommits configuration

---

## 🎯 Project Context

**User Profile:**
- Engineering director accustomed to JetBrains and VSCode IDEs
- Values clear, precise communication and avoids assumptions
- Learns complex topics best through analogies and concrete examples
- Prefers direct, matter-of-fact responses with thorough explanations
- Keyboard-first workflow advocate

**Development Environment:**
- **Hardware:** MacBook M3
- **Terminal:** Ghostty
- **Shell:** zsh
- **Editor:** Neovim with LazyVim
- **Primary Language:** Go
- **Secondary:** Makefiles, Markdown
- **Dotfiles Management:** GNU Stow

**Primary Goals:**
1. Master Neovim keyboard workflows for Go development
2. Develop Lua proficiency for configuration and customization
3. Build speed and comfort that matches or exceeds previous IDE experience
4. Establish keyboard-only workflows (minimize trackpad usage)
5. Maintain clean, version-controlled dotfiles setup

---

## 🚀 Quick Start

### Initial Setup (New Machine)

```bash
# 1. Clone dotfiles repository
cd ~/Code
git clone https://github.com/automaticalldramatic/dotfiles.git
cd dotfiles

# 2. Run installation script
chmod +x install.sh
./install.sh

# 3. Set up secrets
cp ~/.zshrc.local.template ~/.zshrc.local
nvim ~/.zshrc.local  # Add API keys

# 4. Reload shell
source ~/.zshrc

# 5. Verify installation
fzf --version
bat --version
eza --version
zoxide --version
starship --version
```

### Daily Workflow

```bash
# Navigate to project
z my-project      # Smart directory jump with zoxide

# Open Neovim
nvim .            # Opens in current directory

# Git operations
gs                # Git status
gl                # Git log with topology
gd                # Git diff
```

---

## 📦 Tools & Configuration Status

### Core Tools

| Tool | Version | Status | Purpose |
|------|---------|--------|---------|
| Neovim + LazyVim | Latest | ✅ Installed | Editor |
| Ghostty | Latest | ✅ Installed | Terminal |
| GNU Stow | Latest | ✅ Installed | Dotfiles management |
| Homebrew | Latest | ✅ Installed | Package manager |

### CLI Tools

| Tool | Status | Purpose | Keybind/Usage |
|------|--------|---------|---------------|
| **fzf** | ✅ Installed | Fuzzy finder | `Ctrl+R` (history), `Ctrl+T` (files) |
| **bat** | ✅ Installed | Better cat | `cat file.go` |
| **eza** | ✅ Installed | Better ls | `l`, `la`, `lt` |
| **tree** | ✅ Installed | Directory viz | `tree` |
| **fd** | ✅ Installed | Better find | Used by fzf |
| **ripgrep** | ✅ Installed | Better grep | `rg pattern` |
| **zoxide** | ✅ Installed | Smart cd | `z project` |
| **atuin** | ✅ Installed | Shell history | `Ctrl+R` (enhanced) |
| **direnv** | ✅ Installed | Auto-load envs | Automatic on `cd` |
| **starship** | ✅ Installed | Modern prompt | Automatic |
| **zsh-autosuggestions** | ✅ Installed | Command hints | `Ctrl+E` (accept), `Ctrl+W` (execute) |

### Development Tools

| Tool | Status | Purpose |
|------|--------|---------|
| **gopls** | ✅ Installed | Go LSP |
| **golangci-lint** | ✅ Installed | Go linter |
| **lazygit** | ✅ Installed | Git TUI |
| **gh** | ✅ Installed | GitHub CLI |
| **aicommits** | ✅ Configured | AI commit messages |

### Configuration Files

| Config | Location | Tracked | Purpose |
|--------|----------|---------|---------|
| `.zshrc` | `~/Code/dotfiles/zsh/` | ✅ Yes | Main shell config |
| `.zshrc.local` | `~/` | ❌ No (secrets) | API keys, local overrides |
| `nvim/` | `~/Code/dotfiles/nvim/` | ✅ Yes | Neovim config |
| `ghostty/` | `~/Code/dotfiles/ghostty/` | ✅ Yes | Terminal config |
| `starship.toml` | `~/Code/dotfiles/starship/` | ✅ Yes | Prompt config |
| `.gitconfig` | `~/Code/dotfiles/git/` | ✅ Yes | Git config |
| `lazygit/` | `~/Code/dotfiles/lazygit/` | ✅ Yes | Lazygit config |

---

## ⌨️ Keyboard Workflows

### Navigation Patterns

**Pattern 1: Find & Navigate (5-30 seconds)**
1. `z project` → Jump to project with zoxide
2. `fv` → Fuzzy find and open file in nvim
3. Navigate within file with `<leader>fw` (word search)
4. `gd` to jump to definition

**Pattern 2: Edit & Test (continuous loop)**
1. Make changes in open buffer
2. `:GoRun` or `:GoTestFunc` to verify
3. `<leader>ca` for automatic fixes
4. Move to next error

**Pattern 3: Review Changes (no terminal)**
1. `<leader>gg` to open Lazygit
2. Navigate commits with arrow keys
3. View diffs side-by-side
4. Stage changes, review, commit

**Pattern 4: Shell Navigation (new)**
1. `Ctrl+R` → Search command history (atuin)
2. `z proj` → Jump to frequently used directory
3. `fcd` → Fuzzy find directory
4. `cx ~/Code/project` → cd and list files

### Key Bindings Reference

**Shell (zsh):**
- `Ctrl+E` - Accept autosuggestion
- `Ctrl+W` - Accept and execute autosuggestion
- `Ctrl+R` - Fuzzy search command history (atuin)
- `Ctrl+T` - Fuzzy find files (fzf)
- `Home`/`^[[H` - Beginning of line
- `End`/`^[[F` - End of line

**Neovim (LazyVim):**
- `<leader>ff` - Find files (Telescope)
- `<leader>fw` - Find word in files
- `<leader>fg` - Live grep
- `<leader>fb` - Browse buffers
- `gd` - Go to definition
- `gr` - Find references
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>gg` - Open Lazygit
- `<leader>bd` - Delete buffer

**Navigation Functions:**
- `cx <dir>` - cd and list
- `fcd` - Fuzzy cd into directory
- `fv` - Fuzzy find → open in nvim
- `f` - Fuzzy find → copy path to clipboard
- `z <partial-name>` - Smart jump to directory

### Proficiency Levels

**Level 1 (Beginner):** Commands require conscious thought, frequent pauses  
**Level 2 (Comfortable):** Commands are automatic for common tasks  
**Level 3 (Proficient):** Muscle memory; no hesitation, context-switches smoothly  
**Level 4 (Master):** Entire workflows are fluid; navigate complex codebases without thinking

---

## 🛠️ Technical Foundation

### Current Tech Stack

| Component | Tool | Version | Status |
|-----------|------|---------|--------|
| Editor | Neovim + LazyVim | Latest | ✅ Working |
| Go LSP | gopls | Latest | ✅ Working |
| Go Linter | golangci-lint | Latest | ✅ Working |
| Git UI | Lazygit | Latest | ✅ Working |
| Syntax | Treesitter | Latest | ✅ Working |
| Commits | aicommits (Gemini) | Latest | ✅ Configured |
| Shell | zsh | Default | ✅ Active |
| Terminal | Ghostty | Latest | ✅ Active |
| Prompt | Starship | Latest | ✅ Active |
| History | Atuin | Latest | ✅ Active |
| Navigation | Zoxide | Latest | ✅ Active |

### Plugin Architecture

**File Structure:**
```
~/.config/nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua        # LazyVim bootstrap
│   │   ├── keymaps.lua     # Custom keymaps (jj/jk → Esc)
│   │   └── autocmds.lua    # Auto commands
│   └── plugins/
│       ├── aicommits.lua   # Commit message generation
│       ├── go.lua          # Go-specific config (gopls tuning)
│       ├── lazygit.lua     # Git integration
│       └── example.lua     # General overrides & tools
```

**Key Configurations:**

**gopls settings** (from `go.lua`):
```lua
analyses = { unusedparams = true }
staticcheck = true
usePlaceholders = true
completeUnimported = true    -- Auto-import
gofumpt = true               -- Strict formatting
```

---

## 💬 Communication & Response Style

### When Explaining Concepts

**Use Real-World Analogies:**
- Explain Lua tables like Go maps/slices
- Compare LSP to an "expert Go developer" watching your code
- Frame modal editing as "different interaction modes"

**Provide Concrete Examples:**
- Show actual Lua code from the config
- Demonstrate with Go files
- Use keyboard shortcuts with context

**Be Direct & Precise:**
- State what will happen, not theories
- Clarify assumptions if requirements are ambiguous
- Ask targeted questions when context is missing
- Avoid hedging language ("might", "could", "possibly")

### When Asking for Help

**Expected Response Format:**
1. **Acknowledge the problem** (what's happening vs. what should happen)
2. **Provide root cause** (why it's happening)
3. **Give step-by-step solution** (specific commands/config changes)
4. **Explain the fix** (why this solves it)
5. **Verify the fix** (how to confirm it works)

**Always clarify:**
- Are we modifying existing config or creating new files?
- Should changes go in which plugin file?
- Are we installing new external tools or just config changes?

---

## 🎓 Lua Learning Path

### Conceptual Progression

**Week 1: Foundations**
- Tables (lists & dictionaries)
- Functions & closures
- Module system (require/package)
- Scope rules

**Week 2: Neovim Integration**
- How Lua plugs into Neovim config
- Reading existing plugin specs
- Understanding lazy loading
- Dependencies & initialization

**Week 3: Configuration Mastery**
- Modifying LSP settings
- Creating keybindings
- Extending plugins (opts functions)
- Debugging with `:messages` and `:Lazy`

**Week 4+: Custom Extensions**
- Writing utility functions
- Creating custom commands
- Automating repetitive tasks
- Building reusable modules

### Reference Points for This Project

**Study these actual files to learn:**
1. `go.lua` → Understanding opts functions and LSP configuration
2. `lazygit.lua` → Understanding lazy loading and keybinds
3. `aicommits.lua` → Understanding plugin setup and options
4. `example.lua` → Understanding how to override/extend LazyVim defaults

**Concepts to master in order:**
1. Lua tables (used everywhere in config)
2. Functions (opts = function(_, opts) pattern)
3. Table operations (vim.list_extend, table.insert)
4. Lazy loading (lazy = true, cmd = {}, keys = {})
5. Plugin specs (dependencies, opts, init, config)

---

## 🗂️ Dotfiles Management

### GNU Stow Workflow

**Directory Structure:**
```
~/Code/dotfiles/
├── zsh/.zshrc              → ~/.zshrc
├── nvim/.config/nvim/      → ~/.config/nvim/
├── ghostty/.config/ghostty/ → ~/.config/ghostty/
├── starship/.config/starship/ → ~/.config/starship/
├── git/.gitconfig          → ~/.gitconfig
└── lazygit/.config/lazygit/ → ~/.config/lazygit/
```

**Important:** Always use `stow --no-folding -t ~` when running from `~/Code/dotfiles/`

**Common Commands:**
```bash
# Stow a configuration
cd ~/Code/dotfiles
stow --no-folding -t ~ PACKAGE_NAME

# Unstow (remove symlinks)
stow -D -t ~ PACKAGE_NAME

# Restow (refresh symlinks)
stow -R --no-folding -t ~ PACKAGE_NAME

# Dry run (preview changes)
stow -nv -t ~ PACKAGE_NAME
```

**Making Changes:**
```bash
# Edit the file (works from either location)
nvim ~/Code/dotfiles/zsh/.zshrc
# OR
nvim ~/.zshrc  # (it's a symlink to the above)

# Commit changes
cd ~/Code/dotfiles
git add zsh/.zshrc
git commit -m "Update zsh configuration"
git push
```

**Adding New Configs:**
```bash
# 1. Create directory structure
mkdir -p ~/Code/dotfiles/tool/.config/tool

# 2. Move existing config
mv ~/.config/tool/config.toml ~/Code/dotfiles/tool/.config/tool/

# 3. Stow it
cd ~/Code/dotfiles
stow --no-folding -t ~ tool

# 4. Commit
git add tool/
git commit -m "Add tool configuration"
git push
```

---

## 🎯 Learning Progression & Milestones

### Week 1-2: Modern Tools & Navigation (IN PROGRESS)

**Goals:**
- [ ] Install all tools from Brewfile
- [ ] Set up dotfiles repository with GNU Stow
- [ ] Configure `.zshrc.local` with secrets
- [ ] Learn basic fzf usage (`Ctrl+R`, `Ctrl+T`)
- [ ] Get comfortable with zoxide (`z` command)
- [ ] Practice navigation functions (`cx`, `fcd`, `fv`)
- [ ] Verify Ghostty theme compatibility

**Success Criteria:**
- Can navigate 5 directories with `z` without thinking
- `Ctrl+R` is automatic for command history
- No longer using `ls` after every `cd`
- Ghostty themes change shell colors correctly

**Lua Study:** Tables & functions

---

### Week 3-4: Neovim Navigation Mastery

**Goals:**
- [ ] Can navigate 5 Go files in < 30 seconds without thinking
- [ ] File opening (`<leader>ff`) is automatic
- [ ] Word search (`<leader>fw`) feels natural
- [ ] `fv` function is integrated into workflow

**Success Criteria:**
- Find → navigate → edit → save workflow takes < 15 seconds
- No longer reaching for trackpad for navigation
- Can explain fzf vs Telescope to someone else

**Lua Study:** Reading & modifying plugin specs

---

### Week 5-6: LSP & Go Commands

**Goals:**
- [ ] `gd` / `gr` / `K` are muscle memory
- [ ] `:GoRun` and `:GoTest` integrated into workflow
- [ ] Can refactor with `<leader>rn` confidently
- [ ] Auto-import works seamlessly

**Success Criteria:**
- Edit → test → fix loop without terminal usage
- Can debug LSP issues independently
- Go development feels faster than JetBrains

**Lua Study:** LSP configuration & gopls tuning

---

### Week 7-8: Git Integration & Advanced Workflows

**Goals:**
- [ ] `<leader>gg` is default for git operations
- [ ] No terminal usage for viewing diffs
- [ ] Commit workflow entirely in Neovim
- [ ] Can handle merge conflicts in Neovim

**Success Criteria:**
- 90% of git tasks done in Neovim via Lazygit
- Can stage partial hunks efficiently
- Git workflow is faster than previous IDE

**Lua Study:** Lazy loading & dependencies

---

### Week 9+: Customization & Extension

**Goals:**
- [ ] Can add new keybinds independently
- [ ] Can debug config issues
- [ ] Can extend config with custom utilities
- [ ] Have created at least one custom function

**Success Criteria:**
- Can onboard a teammate to this setup
- Have customized config to match workflow
- Prefer Neovim over previous IDE for Go projects
- Can explain Lua table/function concept to someone else

**Lua Study:** Writing custom functions & modules

---

## 🏗️ Project Evolution Rules

### When to Create New Plugin Files

**Create new `.lua` file if:**
- Configuring a new language (e.g., Python, TypeScript)
- Adding a major new feature (e.g., debugging, database tools)
- Overriding multiple LazyVim defaults in one area

**Add to existing file if:**
- Simple keybinding or small config change
- Modifying existing plugin behavior
- Adding to mason ensure_installed list

### When to Modify LazyVim Defaults

**Safe to modify:**
- `example.lua` (meant for customization)
- `go.lua` (language-specific config)
- Keybinds in any plugin file

**Avoid modifying:**
- Core LazyVim extras (use imports instead)
- Global config unless absolutely necessary
- Plugin dependencies (trust LazyVim's setup)

### Config Testing Checklist

After any config change:
1. `:Lazy sync` (load new plugins)
2. `:checkhealth` (verify no errors)
3. `:Lazy` (confirm plugins loaded)
4. Open a Go file and test relevant features
5. Restart Neovim if behavior seems cached

### Dotfiles Update Workflow

After any dotfiles change:
```bash
# 1. Test the change
source ~/.zshrc  # For zsh changes
nvim             # For nvim changes

# 2. Verify it works
# Run relevant commands/workflows

# 3. Commit if successful
cd ~/Code/dotfiles
git add .
git commit -m "feat: description of change"
git push

# 4. Update this document if workflow changed
nvim ~/Code/dotfiles/PROJECT_GUIDE.md
```

---

## 🔧 Troubleshooting Framework

### Diagnosis Steps

**For any issue:**
1. **Identify the symptom:** What should happen vs. what's happening?
2. **Check health:** Run `:checkhealth gopls` or `:checkhealth lazygit`
3. **Review logs:** Check `:messages` for error messages
4. **Test isolation:** Does it happen in all files or just one?
5. **Config validation:** Run `:Lazy` to see if plugins loaded correctly

**Common patterns:**
- "Feature doesn't work" → Run `:checkhealth` for that tool
- "Something cached" → Try `:Lazy sync` and restart Neovim
- "Keybind doesn't work" → Check `:which-key` menu to see if it's mapped
- "Syntax highlighting broken" → Run `:TSUpdate`

### Dotfiles Issues

**Stow conflicts:**
```bash
# Backup existing file
mv ~/.zshrc ~/.zshrc.backup

# Re-stow
cd ~/Code/dotfiles
stow -R --no-folding -t ~ zsh
```

**Symlinks not working:**
```bash
# Check symlinks
ls -la ~ | grep "\->"

# Should see:
# .zshrc -> Code/dotfiles/zsh/.zshrc
```

**Changes not reflecting:**
```bash
# Verify you're editing the right file
readlink ~/.zshrc
# Should point to: /Users/riz/Code/dotfiles/zsh/.zshrc

# Reload shell
source ~/.zshrc
```

### Tool-Specific Issues

**fzf not working:**
```bash
# Verify installation
fzf --version

# Reinstall if needed
brew reinstall fzf
$(brew --prefix)/opt/fzf/install
```

**zoxide not jumping:**
```bash
# Check zoxide database
zoxide query -l

# If empty, it needs to learn your paths
cd ~/Code/project  # Repeat for frequently used dirs
```

**Starship prompt not showing:**
```bash
# Verify starship is in PATH
which starship

# Check if init is in .zshrc
grep "starship init" ~/.zshrc

# Reload shell
source ~/.zshrc
```

---

## 📚 Resources & References

### Official Documentation
- [LazyVim Docs](https://www.lazyvim.org/)
- [Neovim LSP](https://neovim.io/doc/user/lsp.html)
- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Starship Config](https://starship.rs/config/)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [Atuin](https://atuin.sh/)

### Neovim-Specific Lua
- [nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide)
- [Learn Lua in 15 Minutes](https://learnxinyminutes.com/docs/lua/)

### Go Tooling
- [gopls Documentation](https://github.com/golang/tools/wiki/gopls)
- [golangci-lint](https://golangci-lint.run/)

### Communities
- r/neovim (Reddit)
- Neovim Discord
- LazyVim Discussions on GitHub

---

## 🤝 Requesting Help with LLM Assistance

### Effective Prompt Templates

**For Configuration Help:**
```
I want to [specific goal: e.g., "add a keybind to run gofmt on save"]

Current setup:
- File affected: ~/.config/nvim/lua/plugins/go.lua
- Current config: [paste relevant section]
- Expected behavior: [what should happen]
- Actual behavior: [what's happening instead]
```

**For Workflow Optimization:**
```
Current workflow: [describe steps 1-5]
Pain point: [what's slow/awkward]
Environment: Go project with [X files, Y complexity]

What's the faster way to do this in Neovim?
```

**For Lua Learning:**
```
I don't understand [specific concept: e.g., "the opts = function(_, opts) pattern"]

Context: I've read [resource], and it explains [what you know]
Where I'm confused: [specific part]

Can you explain it like I'm a Go developer?
```

**For Troubleshooting:**
```
Issue: [what's not working]
Steps to reproduce: [1. open file] [2. do X] [3. expect Y]

I've already tried:
- [thing 1]
- [thing 2]

`:checkhealth` output: [paste relevant section]
`:messages` output: [paste any errors]
```

**For Dotfiles Issues:**
```
Issue: [stow conflict / symlink not working / etc.]
Current state: [output of ls -la ~ | grep .zshrc]
Expected: [what should be there]

Dotfiles directory structure:
[paste tree ~/Code/dotfiles]
```

### What to Include/Exclude

**Always include:**
- What you're trying to do (clear goal)
- What's currently happening
- Your environment (macOS M3, Ghostty, etc.)
- Relevant config file snippet or error message

**Don't include:**
- Vague descriptions ("it's slow", "it doesn't work")
- Multiple unrelated issues in one request
- Full config files (paste snippets)
- Assumptions about what went wrong

---

## ✅ Success Criteria

### Technical Milestones

| Milestone | Success Criteria | Timeline | Status |
|-----------|-----------------|----------|--------|
| Modern Tools Setup | All Brewfile tools installed and working | Week 1 | 🔄 In Progress |
| Dotfiles Repository | GNU Stow setup, configs tracked in Git | Week 1 | 🔄 In Progress |
| Shell Navigation | zoxide/fzf/atuin are automatic | Week 2 | ⏳ Pending |
| Neovim Navigation | File navigation < 30s for 5 files | Week 4 | ⏳ Pending |
| LSP Proficiency | `gd`, `gr`, `K`, `<leader>ca` automatic | Week 6 | ⏳ Pending |
| Go Workflow | Edit → test → fix loop without terminal | Week 6 | ⏳ Pending |
| Git Integration | 90% of git tasks in Neovim | Week 8 | ⏳ Pending |
| Lua Confidence | Can modify config independently | Week 10 | ⏳ Pending |
| IDE Parity | Go dev speed matches/exceeds JetBrains | Week 12 | ⏳ Pending |

### Behavioral Milestones

- [ ] Haven't used trackpad for editor work in 1 week
- [ ] Can onboard a teammate to your Neovim setup
- [ ] Explain Lua table/function concept to someone else
- [ ] Have customized config to match your workflow
- [ ] Prefer Neovim over previous IDE for Go projects
- [ ] Dotfiles setup is reproducible on new machine in < 15 minutes
- [ ] Can diagnose and fix config issues independently

---

## 📝 Notes for LLM Assistant

When assisting with this project:

1. **Maintain the user's communication style:** Be precise, avoid assumptions, use concrete examples
2. **Reference this guide** when explaining concepts
3. **Offer analogies** from Go/engineering concepts
4. **Ask clarifying questions** when requirements are ambiguous
5. **Provide step-by-step solutions** with verification steps
6. **Track progress** against the milestones above
7. **Suggest next steps** based on current proficiency level
8. **Challenge when needed:** If a workflow seems inefficient, suggest Neovim alternatives
9. **Update this document:** Suggest updates when workflows evolve
10. **Respect the dotfiles structure:** Always consider GNU Stow when suggesting file changes

---

## 🔄 Configuration Evolution Log

This section tracks significant changes to the setup over time.

### 2024-11-03: Major Tooling Overhaul (v2.0)
- Migrated from custom prompt to Starship
- Implemented GNU Stow for dotfiles management
- Added modern CLI tools (fzf, bat, eza, zoxide, atuin, direnv)
- Removed hard-coded terminal colors for Ghostty compatibility
- Created automated installation workflow
- Separated secrets into `.zshrc.local`
- Enhanced Git aliases with topology ordering
- Added navigation functions for keyboard-first workflow

---

**This guide is a living document**—update it as workflows change, new goals emerge, or the setup evolves.

**Last Reviewed:** 2024-11-03  
**Next Review:** After completing Week 2 milestones

---

## 📮 Contributors
- **Rizwan Iqbal** (Engineering Director, @automaticalldramatic)
- **Claude** (LLM Assistant)
