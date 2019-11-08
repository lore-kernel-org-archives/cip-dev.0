From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 22:29:01 +0100
Subject: [cip-dev] [isar-cip-core PATCH 3/4] hihope-rzg2m: Add board
 support
In-Reply-To: <d41024b8-0d3f-a4e6-fef3-76dc350dfc62@siemens.com>
References: <20191106124439.10532-1-Quirin.Gylstorff@siemens.com>
	<20191106124439.10532-4-Quirin.Gylstorff@siemens.com>
	<TYAPR01MB2285255EF4A6521577D5F789B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<66a2849e-bbf8-7e67-0da3-490b052f18cb@siemens.com>
	<TYAPR01MB4286445DBFE0BE6FD3D9CC49E1780@TYAPR01MB4286.jpnprd01.prod.outlook.com>
	<d41024b8-0d3f-a4e6-fef3-76dc350dfc62@siemens.com>
Message-ID: <20191108212901.GG23750@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > I will look into it using the cip-kernel-config instead of using copies
> > > in isar.
> > 
> > Are you planning to "fetch" required config(s) for each target from cip-kernel-config?
> > or, keep copies of the configs in isar-cip-core then synchronize them at the specific point?
> 
> I try to fetch the configuration for each target from cip-kernel-config.
> Currently I need to patch the config as Isar doesn't allow setting
> CONFIG_LOCALVERSION in the kernel configuration.

I have feeling that configurations in cip-kernel-config are a good
start, but it is what we use for testing, and production needs may be
slightly different.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/7f6a8ae8/attachment.sig>
