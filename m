From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 17 Jun 2019 21:54:47 +0100
Subject: [cip-dev] [cip-kernel-sec 1/2] remotes: automatically add
 remotes from configuration file
In-Reply-To: <20190617052127.9571-1-daniel.sangorrin@toshiba.co.jp>
References: <20190617052127.9571-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1560804887.21054.33.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2019-06-17 at 14:21 +0900, Daniel Sangorrin wrote:
> Currently the user is required to create its own remotes by
> hand. This should not be necessary, because the information
> is already collected in conf/remotes.yml. For that reason,
> if we detect that any remote has not been added to the
> local repo then we will add those.

I'm not yet convinced this is a good idea.

After this change, we would still be assuming that there is a kernel
repository or working tree next to kernel-config.  If we wanted to be
really helpful we could create a new repository if it's not there.

But realistically, a developer using this probably already has a kernel
git repository, just not in the expected place.  Isn't it likely that
the developer also already has the remotes we want, but under different
names?

Aside from that, I have some specific issues with the implementation:

> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
> ?README.md????????????????????| 5 +++--
> ?conf/remotes.yml?????????????| 9 ++++++---
> ?scripts/import_stable.py?????| 9 +++++++++
> ?scripts/templates/issue.html | 7 ++++---
> ?4 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/README.md b/README.md
> index 4c5808f..dda94a8 100644
> --- a/README.md
> +++ b/README.md
> @@ -77,8 +77,9 @@ These files, if they exist, contain a mapping where the keys
> ?are default git remote names.??The values are also mappings,
> ?with the keys:
> ?
> -* `commit_url_prefix`: URL prefix for browsing a commit on a
> -??branch from this remote.
> +* `git_repo_url`: URL of the remote repository.
> +* `commit_url_suffix`: URL suffix that gets appended to `git_repo_url`
> +??for browsing a commit on a branch from this remote.

Although it's now common to have a single https: URL that works as both
a git remote and a web view, there are plenty of git hosts that don't
work that way.

So these two things should be kept independent.

[...]
> --- a/scripts/import_stable.py
> +++ b/scripts/import_stable.py
> @@ -35,6 +35,9 @@ def update(git_repo, remote_name):
> ?????subprocess.check_call(['git', 'remote', 'update', remote_name],
> ???????????????????????????cwd=git_repo)
> ?
> +def add(git_repo, remote_name, remote_url):
> +????subprocess.check_call(['git', 'remote', 'add', remote_name, remote_url],
> +??????????????????????????cwd=git_repo)
> ?
> ?def get_backports(git_repo, remotes, branches, debug=False):
> ?????backports = {}

There should be two blank lines between top-level definitions,
according to PEP-8.

> @@ -140,6 +143,12 @@ def main(git_repo, remotes, debug=False):
>      remote_names = set(branch['git_remote'] for branch in branches)
>  
>      for remote_name in remote_names:
> +        import sys

This import belongs at the top level with the other imports.

> +        current_remotes = subprocess.check_output(['git', 'remote', 'show'],
> +            cwd=git_repo).decode(sys.stdout.encoding).strip().split('\n')

This doesn't belong inside the loop.

> +        if remote_name not in current_remotes:
> +            add(git_repo, remotes[remote_name]['git_name'],
> +                remotes[remote_name]['git_repo_url'])
>          update(git_repo, remotes[remote_name]['git_name'])
>      backports = get_backports(git_repo, remotes, branches, debug)
>      c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
