From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 07 Jun 2019 15:41:09 +0100
Subject: [cip-dev] [next] iwg20m: add support for this board
In-Reply-To: <20190606074829.8104-2-daniel.sangorrin@toshiba.co.jp>
References: <20190606074829.8104-1-daniel.sangorrin@toshiba.co.jp>
	<20190606074829.8104-2-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1559918469.21054.3.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2019-06-06 at 16:48 +0900, Daniel Sangorrin wrote:
> This patch adds support for the iwg20m board to isar-cip-core.
> 
> - Kernel version notes
> 
> This board is only supported by the 4.4 kernel. For that
> reason, the preferred version is set to 4.4 and the user
> doesn't need to specify :opt-4.4.yml
[...]

This really shouldn't be allowed to happen.  All the patches applied to
4.4-cip to support this board were already upstream, so this must be a
regression.  If this board is used as a basis for real systems that
need to run beyond EOL of the 4.4-cip branch (~2026), it needs to be
possible to upgrade them to a new kernel version at that time.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
