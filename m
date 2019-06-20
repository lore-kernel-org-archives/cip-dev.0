From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 20 Jun 2019 19:08:05 +0100
Subject: [cip-dev] [cip-kernel-sec][PATCH v2 1/3] branch: fix remotes
	mapping
In-Reply-To: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
References: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1561054085.21054.49.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

I've applied this and the following patch, as they're obviously
correct.

Ben.

On Thu, 2019-06-20 at 14:51 +0900, Daniel Sangorrin wrote:
> Probably a copy&paste error that never got checked because
> nobody is using the mapping functionality.
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
> ?scripts/kernel_sec/branch.py | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel_sec/branch.py
> b/scripts/kernel_sec/branch.py
> index 3ede64a..10f3339 100644
> --- a/scripts/kernel_sec/branch.py
> +++ b/scripts/kernel_sec/branch.py
> @@ -212,7 +212,7 @@ def get_remotes(mappings, mainline=None,
> stable=None):
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
