From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 3 Apr 2019 07:55:04 +0200
Subject: [cip-dev] isar error log
In-Reply-To: <OSAPR01MB37634FC9265275C1F909D27AD0570@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <OSAPR01MB3763A7998474AB7ABEB3DDF3D0560@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<0c1b977d-cd7e-34aa-8d7e-1569b313f75d@siemens.com>
	<OSAPR01MB37634FC9265275C1F909D27AD0570@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <043f0dda-7df0-36d1-c9ae-d9d08d3298d5@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 03.04.19 02:56, daniel.sangorrin at toshiba.co.jp wrote:
> Hi Jan,
> 
> Yes I am following the Readme.
> 
> The docker image id for kasproject/kas-isar is 9e9fe44e68d3 (I am using kas-docker script). And I am using

That's the same version I have, and it works for me.

> kas-docker --isar build kas.yml:board-qemu-amd64.yml
> 
> Yes, it seems there are multiple errors:
> /proc/sys/fs/binfmt_misc/register: Invalid argument
> /test-dev-null: Permission denied
> 
> Probably this is a bug or misconfiguration in Ubuntu. I will try to figure it out.
> 

Adding kas-devel: Would be interesting to understand this so that we can fix it 
or at least document a workaround. Maybe you need to be in some privileged group 
in order to use privileged docker containers? That's how things work on SUSE.

No one around is using Ubuntu, so that distro is likely a blind spot for our 
testing.

Thanks
Jan

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Tuesday, April 2, 2019 3:14 PM
> To: sangorrin daniel(????? ???? ????????) <daniel.sangorrin@toshiba.co.jp>
> Cc: cip-dev at lists.cip-project.org; isar-users at googlegroups.com
> Subject: Re: isar error log
> 
> On 02.04.19 05:17, daniel.sangorrin at toshiba.co.jp wrote:
>> Hi Jan,
>>
>> I am trying to show CIP Core ISAR to some guys in Linaro Connect but I also met a binfmt related error.
> 
> It's supposed to be fixed in the :latest kas-isar image. Are you using that?
> 
>> I am using Ubuntu 16.04. Do you have a hint on how to solve this problem?
>> I already installed qemu-user-static. The system service for binfmt seems to fail.
>>
>> Thanks,
>> Daniel
>>
>> update-binfmts: warning: unable to close
>> /proc/sys/fs/binfmt_misc/register: Invalid argument
>> update-binfmts: warning: unable to enable binary format qemu-aarch64
>> update-binfmts: exiting due to previous errors
> 
> That indeed indicate broken binfmt settings.
> 
>> 2019-04-01 15:37:22 - INFO     - kas 1.0 started
>> 2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
>> 2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
>> 2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
>> 2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
>> 2019-04-01 15:37:22 - INFO     - /work/isar$ git cat-file -t ee5518cc6ecdade53dcafabfbb40ba4b0c505777
>> 2019-04-01 15:37:22 - INFO     - Repository isar already contains ee5518cc6ecdade53dcafabfbb40ba4b0c505777 as commit
>> 2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
>> 2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
>> 2019-04-01 15:37:22 - INFO     - /work/isar$ git status -s
>> 2019-04-01 15:37:22 - INFO     - /work/isar$ git rev-parse --verify HEAD
>> 2019-04-01 15:37:22 - INFO     - ee5518cc6ecdade53dcafabfbb40ba4b0c505777
>> 2019-04-01 15:37:22 - INFO     - Repo isar has already been checked out with correct refspec. Nothing to do.
>> 2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
>> 2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
>> 2019-04-01 15:37:22 - INFO     - /work/isar$ /tmp/tmp9u5m9ths /work/build
>> 2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
>> 2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
>> 2019-04-01 15:37:22 - INFO     - /repo$ git rev-parse --show-toplevel
>> 2019-04-01 15:37:22 - INFO     - Using /repo as root for repository cip-core
>> 2019-04-01 15:37:22 - INFO     - /work/build$ /work/isar/bitbake/bin/bitbake -k -c build cip-core-image
>> Loading cache: 100%
>> |######################################################################################################################################| Time: 0:00:00 Loaded 19 entries from dependency cache.
>> NOTE: Resolving any missing task queue dependencies Initialising
>> tasks: 100%
>> |#####################################################################
>> ############################################################| Time:
>> 0:00:00
>> NOTE: Executing RunQueue Tasks
>> ERROR: isar-bootstrap-target-1.0-r0 do_bootstrap: Function failed:
>> do_bootstrap (log file is located at
>> /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/temp/log.do_
>> bootstrap.77)
>> ERROR: Logfile of failure stored in:
>> /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/temp/log.do_
>> bootstrap.77
>> Log data follows:
>> | DEBUG: Executing shell function do_bootstrap
>> | W: Target architecture is the same as host architecture; disabling
>> | QEMU support
>> | I: Running command: debootstrap --arch amd64 --verbose
>> | --variant=minbase --include=locales
>> | --components=main,contrib,non-free stretch
>> | /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/rootfs
>> | http://ftp.de.debian.org/debian
>> | /usr/sbin/debootstrap: 1454: /usr/sbin/debootstrap: cannot create
>> | /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/rootfs/tes
>> | t-dev-null: Permission denied
>> | E: Cannot install into target
>> | '/work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/rootfs'
>> | mounted with noexec or nodev
> 
> Hmm, there are more strange errors. Could it be that you forgot the "--isar"
> after "kas-docker"? That would mean you are trying to run unprivileged which is doomed to fail.
> 
>> | WARNING: exit code 1 from a shell command.
>> | ERROR: Function failed: do_bootstrap (log file is located at
>> | /work/build/tmp/work/cip-core-amd64/isar-bootstrap-target/temp/log.d
>> | o_bootstrap.77)
>> ERROR: Task (/work/isar/meta/recipes-core/isar-bootstrap/isar-bootstrap-target.bb:do_bootstrap) failed with exit code '1'
>> ERROR: isar-bootstrap-host-1.0-r0 do_bootstrap: Function failed:
>> do_bootstrap (log file is located at
>> /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch
>> -amd64/temp/log.do_bootstrap.79)
>> ERROR: Logfile of failure stored in:
>> /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stretch
>> -amd64/temp/log.do_bootstrap.79
>> Log data follows:
>> | DEBUG: Executing shell function do_bootstrap
>> | W: Target architecture is the same as host architecture; disabling
>> | QEMU support
>> | I: Running command: debootstrap --arch amd64 --verbose
>> | --variant=minbase --include=locales
>> | --components=main,contrib,non-free stretch
>> | /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stret
>> | ch-amd64/rootfs http://ftp.de.debian.org/debian
>> | /usr/sbin/debootstrap: 1454: /usr/sbin/debootstrap: cannot create
>> | /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stret
>> | ch-amd64/rootfs/test-dev-null: Permission denied
>> | E: Cannot install into target
>> | '/work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stre
>> | tch-amd64/rootfs' mounted with noexec or nodev
>> | WARNING: exit code 1 from a shell command.
>> | ERROR: Function failed: do_bootstrap (log file is located at
>> | /work/build/tmp/work/cip-core-amd64/isar-bootstrap-host-debian-stret
>> | ch-amd64/temp/log.do_bootstrap.79)
>> ERROR: Task (/work/isar/meta/recipes-core/isar-bootstrap/isar-bootstrap-host.bb:do_bootstrap) failed with exit code '1'
>>
>> $ systemctl status systemd-binfmt.service ? systemd-binfmt.service -
>> Set Up Additional Binary Formats
>>      Loaded: loaded (/lib/systemd/system/systemd-binfmt.service; static; vendor preset: enabled)
>>      Active: inactive (dead)
>> Condition: start condition failed at Tue 2019-04-02 08:04:31 +07; 2h 1min ago
>>              none of the trigger conditions were met
>>        Docs: man:systemd-binfmt.service(8)
>>              man:binfmt.d(5)
>>              https://www.kernel.org/doc/Documentation/binfmt_misc.txt
>>
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
