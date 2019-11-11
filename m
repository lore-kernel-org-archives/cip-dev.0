From: pavel@denx.de (Pavel Machek)
Date: Mon, 11 Nov 2019 10:42:26 +0100
Subject: [cip-dev] Build fail for linux-4.4.y-rc
In-Reply-To: <TYAPR01MB2285C54E0BFE44F1970EFA7DB7740@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2285C54E0BFE44F1970EFA7DB7740@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191111094226.GA15737@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> I've seen a failure this morning with our linux stable-rc build testing.
> 
> Version: 4cb9b88c651a2fff886dd64b6d797343e7ddb4dd Linux 4.4.201-rc1
> Arch: arm
> Config: moxa_mxc_defconfig
> 
> Pipeline: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985
> Failure: https://gitlab.com/cip-playground/linux-stable-rc-ci/pipelines/95016985/failures
> Log: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> Config: https://gitlab.com/cip-playground/linux-stable-rc-ci/-/jobs/346974180
> 
> All other configurations that we build were successful.

Thanks for heads-up!

I see warning during configuration:

HOSTLD  scripts/kconfig/conf
arch/arm/configs/moxa_mxc_defconfig:745:warning: symbol value 'm'
invalid for RTC_DRV_DS1374_WDT
#

And this suggests a way to debug it. I'll try to do that.

  MODPOST vmlinux.o
  scripts/Makefile.modpost:97: recipe for target 'vmlinux.o' failed
  WARNING: modpost: Found 1 section mismatch(es).
  To see full details build your kernel with:
  'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  FATAL: modpost: Section mismatches detected.
  Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
  make[1]: *** [vmlinux.o] Error 1

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191111/57fcb6e7/attachment.sig>
