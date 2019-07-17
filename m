From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 17 Jul 2019 18:58:37 +0100
Subject: [cip-dev] [cip-kernel-sec][Quickstart v2] docs: add a
 quickstart with practical information
In-Reply-To: <20190711060415.17484-2-daniel.sangorrin@toshiba.co.jp>
References: <Quickstart fixes>
	<20190711060415.17484-1-daniel.sangorrin@toshiba.co.jp>
	<20190711060415.17484-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <3d59654fa1c9a78d8c0a869b41606f93ae06b79b.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-07-11 at 15:04 +0900, Daniel Sangorrin wrote:
> Although the README already contains all the information
> that users may need, there are some bits of know-how that
> are better expressed through a step-by-step quickstart or
> tutorial. This files tries to fill that gap.
>
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>  QUICKSTART.md | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 QUICKSTART.md
> 
> diff --git a/QUICKSTART.md b/QUICKSTART.md
> new file mode 100644
> index 0000000..c79af41
> --- /dev/null
> +++ b/QUICKSTART.md
> @@ -0,0 +1,132 @@
> +# Quickstart
> +
> +## Overview
> +
> +This project tracks the status of CVEs in mainline and stable kernels. Each CVE is described in YAML format that includes data such as:
> +
> +```
> +$ cat issues/CVE-2019-1999.yml

This seems to be in the wrong place, as the command to clone the repo
is further down.  (Though, I wonder whether it's really necessary to
say how to clone a git repo in the documentation in every repo...)

> +description: 'binder: fix race between munmap() and direct reclaim'
> +references:
> +- https://source.android.com/security/bulletin/2019-02-01
> +comments:
> +  Debian-bwh: |-
> +    Introduced in 4.14 by f2517eb76f1f "android: binder: Add global lru
> +    shrinker to binder".  Backports of the fix to stable have incorrect
> +    metadata.
> +  bwh: Backports to stable have incorrect metadata
> +introduced-by:
> +  mainline: [f2517eb76f1f2f7f89761f9db2b202e89931738c]
> +fixed-by:
> +  linux-4.14.y: [33c6b9ca70a8b066a613e2a3d0331ae8f82aa31a]
> +  linux-4.19.y: [6bf7d3c5c0c5dad650bfc4345ed553c18b69d59e]
> +  linux-5.0.y: [bbb19ca082ce27ce60ca65be016a951806ea947c]
> +  mainline: [5cec2d2e5839f9c0fec319c523a911e0a7fd299f]
> +```
> +
> +## Quickstart

This is the same as the document title, which seems wrong.  Are the
sub-headings needed at all?

> +Clone `cip-kernel-sec` and install its dependencies:
> +
> +```
> +$ git clone https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec
> +$ cd cip-kernel-sec/
> +$ sudo apt install python3-yaml python3-html5lib python3-cherrypy3 python3-jinja2
> +```
> +
> +Prepare kernel remote repositories according to `conf/remotes.yml`:

That should be "repository with remotes", shouldn't it?

> +```
> +$ ./scripts/prepare_remotes.py
> +```

A ./ prefix is needed to run programs in the current directory because
the shell looks in $PATH if there's no "/" in the command name.  Since
we are running programs under scripts/ that doesn't apply and we don't
need the extra ./.  So please drop that from all the command lines.

> +Alternatively, you can do that manually:
> +
> +```
> +$ mkdir ../kernel
> +$ cd ../kernel
> +$ git remote add torvalds https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> +$ git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> +$ git remote add cip https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
> +$ cd ../cip-kernel-sec
> +```

"Alternatively, do it the long way" seems out of scope for a
"quickstart" document.

> +Download CVE information from [Debian] (https://salsa.debian.org/kernel-team/kernel-sec.git), [Ubuntu]  (https://git.launchpad.net/ubuntu-cve-tracker) and Stable:

This should probably say something like "Download new CVE information
...".  Otherwise someone might infer that none of that information is
already present in kernel-sec.

> +```
> +
> +$ ./scripts/import_debian.py
> +	-> import/debian
> +$ ./scripts/import_ubuntu.py
> +	-> import/ubuntu
> +$ ./scripts/import_stable.py
> +	-> import/stable_branches.yml
> +```

That's rather misleading - the main purpose of the scripts is of course
to update issues/*.yml, and the import/ directory is just a cache.

> +Check issues that affect a linux-cip branch:
> +
> +```
> +$ ./scripts/report_affected.py linux-4.4.y
> +```
> +
> +You can show a short description on your report:
> +
> +```
> +$ ./scripts/report_affected.py --show-description linux-4.4.y
> +```
> +
> +Check issues that affect a tag:
> +
> +```
> +$ ./scripts/report_affected.py v4.4.181-cip33
> +```
> +
> +Browse kernel branches and issues interactively:
> +
> +```
> +$ ./scripts/webview.py
> +$ firefox http://localhost:8080
> +```

This example doesn't work.  Either webview.py has to be run in the
background with "&" (in which case, ^C won't work) or the second
command has to be run in another shell.  Realistically the reader
already has the browser open and is using it to read this document, so
you can put a link to this URL outside of the literal commands.

> +[Note] Use Ctr-c to stop the `webview.py` script.

Please use a more standard notation for the keystroke, either "Ctrl-C"
or "^C".

> +## Kernel maintainer workflow

I don't think this section is "quickstart" material.

> +Import or update the latest CVE information:
> +
> +```
> +$ ./scripts/import_debian.py
> +$ ./scripts/import_ubuntu.py
> +$ ./scripts/import_stable.py
> +```
> +
> +Edit by hand the newly created issues if you see that some imported information is incorrect or there is missing information:
> +
> +```
> +$ vi issues/CVE-xx.yml
> +```
> +
> +Validate the issue files against the YAML schema.
> +
> +```
> +$ ./scripts/validate.py
> +```
> +
> +YAML allows the same thing to be written in different ways, e.g. bracketed vs bulleted lists. Use `cleanup.py` to make the syntax and ordering of items consistent with the importers, to reduce "noise" in diffs:
> +
> +```
> +$ ./scripts/cleanup.py
> +```
> +
> +Check if the current issues:

If the current issues do what?

Ben.

> +```
> +$ ./scripts/report_affected.py
> +```
> +
> +## Changelog
> +
> +- 20190614: First version <daniel.sangorrin@toshiba.co.jp>
> +- 20190618: Add workflow information provided by Ben
> +- 20190711: Add tag reporting <daniel.sangorrin@toshiba.co.jp>
> +
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
