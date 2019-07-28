From: pavel@denx.de (Pavel Machek)
Date: Sun, 28 Jul 2019 10:49:20 +0200
Subject: [cip-dev] powerpc build with Kernel v4.4
In-Reply-To: <20190728074044.GA19089@amd>
References: <TYAPR01MB2285895BCD78ABB88C823A5DB7C30@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<20190728074044.GA19089@amd>
Message-ID: <20190728084920.GA21045@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > I'm trying to build the toshiba_defconfig [1] for the powerpc architecture using the CIP v4.4 Kernel but I'm hitting some problems. The log from the build can be seen on GitLab [2].
> > 
> > Has anyone tried building this configuration recently?
> > 
> > I'm using gcc compiler v8.1.0. I mention this because I've see a half-related discussion [3] when Googling. From this mail thread I wonder if there are some patches we need to backport?
> > 
> 
> Is there chance to use different gcc? Because this looks like gcc
> bug... but workaround seems simple enough. Let me investigate some
> more.

Workaround seems simple, but won't easily apply on top of 4.4 kernel

Can you simply set

CONFIG_PPC_DISABLE_WERROR=y

to make the problem go away?

Best regards,

								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190728/5452933b/attachment.sig>
