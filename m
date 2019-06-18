From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 18 Jun 2019 11:40:22 +0900
Subject: [cip-dev] patches to check remotes
Message-ID: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

Please consider these patches for cip-kernel-sec:

[cip-kernel-sec 1/3] remotes: check that remotes exist

This patch adds checks on the local repository and also
provides a separate script to prepare it. Expert
kernel maintainers will only need the checks, but
for new users the script might be useful.

*Important* this patch deprecates the patch
"git_repo: add a check for the git_repo directory"
You haven't reviewed or accepted that patch as far as I know.
You can safely ignore it, because this one provides better
checking and takes into account remotes mapping.

[cip-kernel-sec 2/3] branch: fix remotes mapping

This was a bug in the remote mapping code.

[cip-kernel-sec 3/3] help:remote_name: use colon instead of equal

This is just a fix to command's help

Thanks,
Daniel
