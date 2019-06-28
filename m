From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 28 Jun 2019 21:09:03 +0100
Subject: [cip-dev] [cip-kernel-sec 3/6] report_affected: fix code when
 branches are specified
In-Reply-To: <20190625032636.10694-4-daniel.sangorrin@toshiba.co.jp>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
	<20190625032636.10694-4-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1561752543.21054.80.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2019-06-25 at 12:26 +0900, Daniel Sangorrin wrote:
> The previous code could not handle branches with names
> other than stable branch names. For example, passing
> "linux-4.4.y-cip" as a branch would return an error.
[...]
> --- a/scripts/report_affected.py
> +++ b/scripts/report_affected.py
> @@ -18,14 +18,17 @@ import kernel_sec.version
> ?
> ?def main(git_repo, remotes,
> ??????????only_fixed_upstream, include_ignored, *branch_names):
> +????live_branches = kernel_sec.branch.get_live_branches()
> ?????if branch_names:
> -????????# Support stable release strings as shorthand for stable branches
> -????????branches = [kernel_sec.branch.get_base_ver_stable_branch(name)
> -????????????????????if name[0].isdigit()
> -????????????????????else kernel_sec.branch.get_stable_branch(name)
> -????????????????????for name in branch_names]
> +????????branches = []
> +????????for branch in live_branches:
> +????????????for name in branch_names:
> +????????????????if name[0].isdigit():
> +????????????????????name = 'linux-%s.y' % name
> +????????????????if branch['short_name'] == name:
> +????????????????????branches.append(branch)
[...]

This results in quietly skipping arguments that don't match any known
branch.  The current behaviour (failing with a TypeError) is not good
but I think failing quietly is worse.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
