# Vim Configuration

![Platform: macOS/Linux](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-blue) ![Status: Maintained](https://img.shields.io/badge/Status-Maintained-green) ![Vim 8+](https://img.shields.io/badge/Vim-8%2B-orange)

## **Description**

This is by no means a “final” programming setup I kept it simple with just a touch of modern flair. Don’t expect built‑in autocomplete or automatic error checking just a few handy utilities sprinkled in. I’ve published this on GitHub so I can grab it wherever I go, but feel free to use it yourself!

---

## **Features**

* **Lightweight & simple**: core Vim settings without heavy frameworks
* **Modern touches**: GUI colors, termguicolors, custom status line
* **Optional utilities**: auto‑pairs, Clang‑format integration, whitespace trimming
* **Smart editing basics**: relative numbers, smart indentation, incremental search
* **Clipboard & mouse**: seamless copy/paste and basic mouse support

## **Plugin List**

| Plugin                                | Purpose                                    |
| ------------------------------------- | ------------------------------------------ |
| auto-pairs                            | Automatically close brackets, quotes, etc. |
| vim-clang-format                      | Format C/C++ code with clang-format        |

## **Key Mappings**

| Shortcut            | Action                          |
| ------------------- | ------------------------------- |
| `<Leader>s`         | Save file                       |
| `<Leader>f`         | Run Clang‑Format                |
| `<Leader>t`         | Open terminal                   |
| `<Tab>` / `<S-Tab>` | Next / previous buffer          |
| `<Leader>/`         | Clear search highlight          |
| `<Leader>h`         | Open corresponding C/C++ header |

