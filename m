From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 18 Jun 2019 16:08:05 +0100
Subject: [cip-dev] [cip-kernel-sec 2/3] branch: fix remotes mapping
In-Reply-To: <20190618024025.8274-3-daniel.sangorrin@toshiba.co.jp>
References: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
	<20190618024025.8274-3-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1560870485.21054.39.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Tue, 2019-06-18 at 11:40 +0900, Daniel Sangorrin wrote:
> Probably a copy&paste error that never got checked because
> nobody is using the mapping functionality.

I thought I'd tested this. :-(

Ben.

> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
> ?scripts/kernel_sec/branch.py | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
> index 6542415..fb8785c 100644
> --- a/scripts/kernel_sec/branch.py
> +++ b/scripts/kernel_sec/branch.py
> @@ -214,7 +214,7 @@ def get_remotes(mappings, mainline=None, stable=None):
> ?????????_get_configured_remotes(
> ?????????????os.path.expanduser('~/.config/kernel-sec/remotes.yml')))
> ?????for mapping in mappings:
> -????????left, right = arg.split(':', 1)
> +????????left, right = mapping.split(':', 1)
> ?????????remotes[left]['git_name'] = right
> ?????if mainline:
> ?????????remotes['torvalds']['git_name'] = mainline
-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
