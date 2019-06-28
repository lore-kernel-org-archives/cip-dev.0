From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 28 Jun 2019 21:12:40 +0100
Subject: [cip-dev] [cip-kernel-sec 4/6] report_affected: check user
 supplied branch names
In-Reply-To: <20190625032636.10694-5-daniel.sangorrin@toshiba.co.jp>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
	<20190625032636.10694-5-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1561752760.21054.82.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2019-06-25 at 12:26 +0900, Daniel Sangorrin wrote:
> This makes sure that we return when the user supplied
> branch names are not within the configured branches.

This partly addresses my comment on patch 3, but it's still only
checking that at least one name matched a known branch.

I think the inner and outer loops should be swapped, so we can do:

????????branches = []
????????for name in branch_names:
????????????if name[0].isdigit():
????????????????name = 'linux-%s.y' % name
    ????????for branch in live_branches:
????????????????if branch['short_name'] == name:
????????????????????branches.append(branch)
                    break
            else:
                # not found; raise error

Ben.

> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
> ?scripts/report_affected.py | 3 +++
> ?1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/report_affected.py b/scripts/report_affected.py
> index bd22e29..7557dc8 100755
> --- a/scripts/report_affected.py
> +++ b/scripts/report_affected.py
> @@ -27,6 +27,9 @@ def main(git_repo, remotes,
> ?????????????????????name = 'linux-%s.y' % name
> ?????????????????if branch['short_name'] == name:
> ?????????????????????branches.append(branch)
> +????????if not branches:
> +????????????msg = "supplied branches didn't match any known branch"
> +????????????raise argparse.ArgumentError(None, msg)
> ?????else:
> ?????????branches = live_branches
> ?????????if only_fixed_upstream:
-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
