function __linux_bwrap
  if ! command -v bwrap >/dev/null
    set_color red
    echo -n "[jail]"
    set_color normal
    echo " Bubblewrap is not installed; install it before running jail"
    return 1
  end

  set -l bwrap_args --hostname jail

  # Kill the jailed process whenever bwrap's parent process dies
  set -a bwrap_args --die-with-parent

  # Do not share kernel namespaces
  set -a bwrap_args --unshare-cgroup-try
  set -a bwrap_args --unshare-ipc
  set -a bwrap_args --unshare-pid
  set -a bwrap_args --unshare-uts

  # Isolated minimal filesystems
  set -a bwrap_args --proc /proc
  set -a bwrap_args --dev /dev
  set -a bwrap_args --tmpfs /tmp

  # Read-only mounts for binaries & libs
  set -a bwrap_args --ro-bind /usr /usr
  set -a bwrap_args --symlink /usr/lib /lib
  set -a bwrap_args --symlink /usr/lib64 /lib64
  set -a bwrap_args --symlink /usr/bin /bin
  set -a bwrap_args --symlink /usr/sbin /sbin

  # Read-only mount system config files
  set -a bwrap_args --ro-bind /etc /etc

  # Read-only nount DNS config, if it's linked somewhere else (systemd)
  set -l real_resolv_conf (realpath /etc/resolv.conf)
  if test (realpath /etc/resolv.conf) != /etc/resolv.conf
    set -a bwrap_args --ro-bind "$real_resolv_conf" "$real_resolv_conf"
  end

  # Mount installed mise apps
  set -l mise_dir "$HOME/.local/share/mise/installs"
  if test -d "$mise_dir"
    set -a bwrap_args --ro-bind "$mise_dir" "$mise_dir"
  end

  # Mount claude configuration
  set -l claude_json_file "$HOME/.claude.json"
  if test -f "$claude_json_file"
    set -a bwrap_args --bind "$claude_json_file" "$claude_json_file"
  end
  set -l claude_dir "$HOME/.claude"
  if test -d "$claude_dir"
    set -a bwrap_args --bind "$claude_dir" "$claude_dir"
  end

  # Mount pi harness directories: rw mount needed for .pi/agent for session management
  set -l pi_dir "$HOME/.pi"
  if test -d "$pi_dir"
    set -a bwrap_args --ro-bind "$pi_dir" "$pi_dir"
    set -a bwrap_args --bind "$pi_dir/agent" "$pi_dir/agent"
  end

  # Mount workspace (current working directory) in rw mode
  set -l workspace (pwd --physical)
  set -a bwrap_args --bind "$workspace" /workspace
  set -a bwrap_args --chdir /workspace

  bwrap $bwrap_args $argv
end

function jail --description "Runs a command in a sandbox"
  if test "$(uname)" = "Linux"
    __linux_bwrap $argv
  else if test "$(uname)" = "Darwin"
    echo "TODO: MacOS not supported yet"
    return 1
  end
end
