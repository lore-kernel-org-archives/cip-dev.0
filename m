From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 20 Jun 2019 19:07:36 +0100
Subject: [cip-dev] [cip-kernel-sec][PATCH v2 3/3] remotes: check that
	remotes exist
In-Reply-To: <20190620055143.341-3-daniel.sangorrin@toshiba.co.jp>
References: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
	<20190620055143.341-3-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1561054056.21054.48.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-06-20 at 14:51 +0900, Daniel Sangorrin wrote:
[...]
> --- a/scripts/kernel_sec/branch.py
> +++ b/scripts/kernel_sec/branch.py
[...]
> +def check_git_repo(git_repo, remotes, create=False):
> +????if create:
> +????????if os.path.isdir(git_repo):
> +????????????msg = "directory %r already exists" % git_repo
> +????????????raise argparse.ArgumentTypeError(msg)
> +????????else:
> +????????????os.mkdir(git_repo)
> +????????????subprocess.check_call(['git', 'init', '.'], cwd=git_repo)
> +
> +????????for key in remotes.keys():
> +????????????remote = remotes[key]??# __getitem__ will add git_name
> +????????????remote_add(git_repo, remote['git_name'], remote['git_repo_url'])
> +????else:
> +????????if not os.path.isdir(git_repo):
> +????????????msg = "directory %r not present" % git_repo
> +????????????raise argparse.ArgumentTypeError(msg)
> +????????if not os.path.isdir(os.path.join(git_repo, '.git')):
> +????????????msg = "directory %r is not a git repository" % git_repo
> +????????????raise argparse.ArgumentTypeError(msg)

This isn't compatible with the use of git worktrees (which I use).  In
a worktree, .git is a regular file that refers back to the repository.

So I think this check should use exists() instead of isdir().

Also, why does this function raise argparse.ArgumentTypeError?  The
doc-string for that type says it's "An error from trying to convert a
command line string to a type."  It doesn't seem to be suitable for
reporting problems with the thing that an argument refers to.

[...]
> --- /dev/null
> +++ b/scripts/prepare_remotes.py
> @@ -0,0 +1,46 @@
> +#!/usr/bin/python3
> +
> +# Copyright 2019 Toshiba corp.
> +# Based on import_stable.py by Codethink Ltd.
> +#
> +# This script is distributed under the terms and conditions of the GNU General
> +# Public License, Version 3 or later. See?http://www.gnu.org/copyleft/gpl.html
> +# for details.
> +
> +# Helper script that prepares the local git repository with the configured
> +# remote branches
[...]

Perhaps prepare_remotes.py should also run "git remote update"? 
Without that, the repository is still not actually useful.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
