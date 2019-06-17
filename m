From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Mon, 17 Jun 2019 21:16:13 +0100
Subject: [cip-dev] [cip-kernel-sec 2/2] remotes: call
	_get_configured_remotes
In-Reply-To: <20190617022039.7197-2-daniel.sangorrin@toshiba.co.jp>
References: <20190617022039.7197-1-daniel.sangorrin@toshiba.co.jp>
	<20190617022039.7197-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1560802573.21054.30.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2019-06-17 at 11:20 +0900, Daniel Sangorrin wrote:
> This is probably a copy&paste mistake that had no effect
> because the contents of _get_configured_remotes and
> _get_configured_branches is the same.
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>

Maybe it would make more sense to merge the two functions instead?

Ben.

> ---
> ?scripts/kernel_sec/branch.py | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel_sec/branch.py
> b/scripts/kernel_sec/branch.py
> index ae1ca2c..3ede64a 100644
> --- a/scripts/kernel_sec/branch.py
> +++ b/scripts/kernel_sec/branch.py
> @@ -209,7 +209,7 @@ def get_remotes(mappings, mainline=None,
> stable=None):
> ?????remotes = RemoteMap()
> ?????remotes.update(_get_configured_remotes('conf/remotes.yml'))
> ?????remotes.update(
> -????????_get_configured_branches(
> +????????_get_configured_remotes(
> ?????????????os.path.expanduser('~/.config/kernel-sec/remotes.yml')))
> ?????for mapping in mappings:
> ?????????left, right = arg.split(':', 1)
-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
