From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 12 Sep 2018 18:52:05 +0100
Subject: [cip-dev] [PATCH 01/19] ASoC: rsnd: remove platform
	boot	support from src.c
In-Reply-To: <TYXPR01MB1775D760CF6B7FDD86DCBCADC00C0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1533894782-26239-2-git-send-email-fabrizio.castro@bp.renesas.com>
	<1535131724.2902.38.camel@codethink.co.uk>
	<TY1PR01MB17702CAFA22A50A8B7AA62FAC00A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
	<TYXPR01MB1775D760CF6B7FDD86DCBCADC00C0@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Message-ID: <1536774725.3024.201.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Mon, 2018-09-03 at 10:10 +0000, Fabrizio Castro wrote:
[...]
> > > This isn't a sufficient explanation of the backporting change.??The
> > > upstream version appears to remove all use of struct
> > > rsnd_src_platform_info from the driver, but this version extends the
> > > use of that structure.
> 
> r8a7745 doesn't have clock "src.0" leaving a gap in the clock names.
> The fix for this was made upstream with commit de1965159a34 ("rcar: src:
> skip disabled-SRC nodes"). This patch prepares the context for the fix,
> however since it is applied to quite a different version of the file
> it has been reworked to support the replacing of for_each_rsnd_src
> with for_each_child_of_node loop.
> 
> I could try and backport lots more patches to get a cleaner history, but I fear
> that would actually make the code unstable.
> 
> Do you have any recommendation for a better log?
[...]

The above is roughly what I was looking for, so I've gone ahead and
replaced the upstream commit message.  Thanks.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
