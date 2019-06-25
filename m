From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 25 Jun 2019 12:26:30 +0900
Subject: [cip-dev] fixes and support for tags
Message-ID: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

This series contains a few fixes and support for reporting on tags.

- Re-sent patches

[cip-kernel-sec 1/6] check_git_repo: add checks to the local

I decided to remove the repository creation code from the shared
function, because it is only used by prepared_remotes.
I have adjusted the exception raised, and I use .exists() instead
of .isdir() to account for git worktrees (which I didn't know 
about)

[cip-kernel-sec 2/6] prepare_remotes: helper script to prepare local

I have put the creation code here, and added remote update code
for the script to be useful.

[cip-kernel-sec 3/6] report_affected: fix code when branches are

This allows reporting on CIP branches. I have removed the
get_stable_branch function as you mentioned.

[cip-kernel-sec 4/6] report_affected: check user supplied branch

Small check to make sure the user supplied branch names actually
match the configured branches' names.

[cip-kernel-sec 5/6] report_affected: add support for reporting on

This is the new big patch, where I add support for reporting on
tags. Tags can be specified in different formats. For example:
- linux-4.4.y/v4.4.107
- v4.4.181-cip33 <-- linux-4.4.y is inferred from the tag's name
- linux-4.4.y/myproduct-v20190612 <-- product tags

[cip-kernel-sec 6/6] pep8: fix pep8-related errors such as too long

I fixed these ones because they were annoying.

Thanks,
Daniel
