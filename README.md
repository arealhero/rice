# Rice

This repository contains my personal config files for some of the programs.

### How do I use `<package>` configs?

Install [`stow`](https://www.gnu.org/software/stow/) package for your
distribution:
- Arch linux:
  ```
  sudo pacman -S stow
  ```
- Gentoo:
  ```
  sudo emerge -avn app-admin/stow
  ```

Next, clone this repostiory. Technically you can clone it anywhere, but the
easiest way is to put it in `$HOME` directory:
```
cd $HOME && git clone git@github.com:arealhero/rice.git
```

Now you can use `stow` to create folders & symlinks:
```
cd rice && stow <package>
```

Read `man stow` for more information.

