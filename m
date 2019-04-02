From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 2 Apr 2019 03:17:05 +0000
Subject: [cip-dev] isar error log
Message-ID: <OSAPR01MB3763A7998474AB7ABEB3DDF3D0560@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

I am trying to show CIP Core ISAR to some guys in Linaro Connect but I also met a binfmt related error.
I am using Ubuntu 16.04. Do you have a hint on how to solve this problem?
I already installed qemu-user-static. The system service for binfmt seems to fail.

Thanks,
Daniel

update-binfmts: warning: unable to close /proc/sys/fs/binfmt_misc/register: Invalid argument
update-binfmts: warning: unable to enable binary format qemu-aarch64
update-binfmts: exiting due to previous errors
2019-04-01 15:37:22 - INFO     - kas 1.0 started
2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
2019-04-01 15:37:22 - INFO     - /work/isar$ git cat-file -t ee5518cc6ecdade53dcafabfbb40ba4b0c505777
2019-04-01 15:37:22 - INFO     - Repository isar already contains ee5518cc6ecdade53dcafabfbb40ba4b0c505777 as commit
2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
2019-04-01 15:37:22 - INFO     - /work/isar$ git status -s
2019-04-01 15:37:22 - INFO     - /work/isar$ git rev-parse --verify HEAD
2019-04-01 15:37:22 - INFO     - ee5518cc6ecdade53dcafabfbb40ba4b0c505777
2019-04-01 15:37:22 - INFO     - Repo isar has already been checked out with correct refspec. Nothing to do.
2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
2019-04-01 15:37:22 - INFO     - /work/isar$ /tmp/tmp9u5m9ths /work/build
2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
2019-04-01 15:37:22 - INFO     - /work/build$ /work/isar/bitbake/bin/bitbake -k -c build cip-core-image
Loading cache: 100% |######################################################################################################################################| Time: 0:00:00
Loaded 19 entries from dependency cache.
NOTE: Resolving any missing task queue dependencies
Initialising tasks: 100% |#################################################################################################################################| Time: 0:00:00
NOTE: Executing RunQueue Tasks
ERROR: isar-bootstrap-target-1.0-r0 do_bootstrap: Function failed: do_bootstrap (log file is located at /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/temp/log.do_bootstrap.77)
ERROR: Logfile of failure stored in: /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/temp/log.do_bootstrap.77
Log data follows:
| DEBUG: Executing shell function do_bootstrap
| W: Target architecture is the same as host architecture; disabling QEMU support
| I: Running command: debootstrap --arch amd64 --verbose --variant=minbase --include=locales --components=main,contrib,non-free stretch /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/rootfs http://ftp.de.debian.org/debian
| /usr/sbin/debootstrap: 1454: /usr/sbin/debootstrap: cannot create /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/rootfs/test-dev-null: Permission denied
| E: Cannot install into target '/work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/rootfs' mounted with noexec or nodev
| WARNING: exit code 1 from a shell command.
| ERROR: Function failed: do_bootstrap (log file is located at /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/temp/log.do_bootstrap.77)
ERROR: Task (/work/isar/meta/recipes-core/isar-bootstrap/isar-bootstrap-target.bb:do_bootstrap) failed with exit code '1'
ERROR: isar-bootstrap-host-1.0-r0 do_bootstrap: Function failed: do_bootstrap (log file is located at /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch-amd64/temp/log.do_bootstrap.79)
ERROR: Logfile of failure stored in: /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch-amd64/temp/log.do_bootstrap.79
Log data follows:
| DEBUG: Executing shell function do_bootstrap
| W: Target architecture is the same as host architecture; disabling QEMU support
| I: Running command: debootstrap --arch amd64 --verbose --variant=minbase --include=locales --components=main,contrib,non-free stretch /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch-amd64/rootfs http://ftp.de.debian.org/debian
| /usr/sbin/debootstrap: 1454: /usr/sbin/debootstrap: cannot create /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch-amd64/rootfs/test-dev-null: Permission denied
| E: Cannot install into target '/work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch-amd64/rootfs' mounted with noexec or nodev
| WARNING: exit code 1 from a shell command.
| ERROR: Function failed: do_bootstrap (log file is located at /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch-amd64/temp/log.do_bootstrap.79)
ERROR: Task (/work/isar/meta/recipes-core/isar-bootstrap/isar-bootstrap-host.bb:do_bootstrap) failed with exit code '1'

$ systemctl status systemd-binfmt.service
? systemd-binfmt.service - Set Up Additional Binary Formats
   Loaded: loaded (/lib/systemd/system/systemd-binfmt.service; static; vendor preset: enabled)
   Active: inactive (dead)
Condition: start condition failed at Tue 2019-04-02 08:04:31 +07; 2h 1min ago
           none of the trigger conditions were met
     Docs: man:systemd-binfmt.service(8)
           man:binfmt.d(5)
           https://www.kernel.org/doc/Documentation/binfmt_misc.txt
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190402/ef3601f3/attachment.html>
