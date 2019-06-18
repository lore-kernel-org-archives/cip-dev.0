From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Tue, 18 Jun 2019 16:07:15 +0100
Subject: [cip-dev] [cip-kernel-sec 1/3] remotes: check that remotes exist
In-Reply-To: <20190618024025.8274-2-daniel.sangorrin@toshiba.co.jp>
References: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
	<20190618024025.8274-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1560870435.21054.38.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This mostly looks fine, except:

On Tue, 2019-06-18 at 11:40 +0900, Daniel Sangorrin wrote:
[...]
> --- /dev/null
> +++ b/scripts/prepare_remotes.py
[...]
> +def main(git_repo, remotes, debug=False):
> +????kernel_sec.branch.check_git_repo(git_repo, remotes, create=True)

The debug flag doesn't have any effect...

[...]
> +????parser.add_argument('--debug',
> +????????????????????????dest='debug', action='store_true',
> +????????????????????????help='enable debugging output')
[...]

...so neither does the --debug option.

I think you can remove them both.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
