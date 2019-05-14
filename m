From: diego.ml@zoho.com (diego.ml)
Date: Tue, 14 May 2019 09:54:26 +0200
Subject: [cip-dev] CIP software updates report
In-Reply-To: <OSBPR01MB3128362A42B0941DC95C9478D0080@OSBPR01MB3128.jpnprd01.prod.outlook.com>
References: <16a9e7146a0.afd6a3cc10954.9216279613248465781@zoho.com>
	<OSBPR01MB3128362A42B0941DC95C9478D0080@OSBPR01MB3128.jpnprd01.prod.outlook.com>
Message-ID: <16ab555e50e.1097db4e619453.8424266922782967007@zoho.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel


 ---- Attivato mar, 14 mag 2019 04:27:39 +0200  <daniel.sangorrin@toshiba.co.jp> ha scritto ----
 > Thanks for the update Diego.
 > I have added some comments to the CIP wiki:
 > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report
 > 

Thanks for adding the note.

By the way U-Boot master and future releases (>= 2019.07) will have the Makefile target "u-boot-initial-env" that will automatically create the default env file.
https://github.com/u-boot/u-boot/commit/bdaa73a5b3923257add182b4ab8058dbfa33421b#diff-b67911656ef5d18c4ae36cb6741b7965

Regards,
Diego Rondini

 > SZ, Iwamatsu-san: what is the status of the libubootenv replacement on the Debian package?
 > 
 > Thanks,
 > Daniel
 > 
 > > -----Original Message-----
 > > From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of diego.ml
 > > via cip-dev
 > > Sent: Friday, May 10, 2019 6:13 AM
 > > To: cip-dev <cip-dev@lists.cip-project.org>
 > > Subject: [cip-dev] CIP software updates report
 > > 
 > > Hi all,
 > > 
 > > I've seen your CIP software updates report published here:
 > > https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report
 > > 
 > > One thing I'd like to point out regarding SWUpdate's "bad point: depends on libubootenv which needs to be rebuilt
 > > for each target" is that this issue is well on its way to being solved.
 > > Stefano Babic, SWUpdate creator and maintainer, started a new project called "libubootenv", a standalone
 > > replacement for U-Boot built-in libubootenv:
 > > https://github.com/sbabic/libubootenv
 > > This project aims to solve the need to rebuild SWUpdate any time the default env changes.
 > > 
 > > Building SWUpdate 2019.04 with CONFIG_UBOOT_NEWAPI like this:
 > > https://github.com/Kynetics/meta-updatefactory/commit/c4c25b21d3ed4ae15f9716769c2644953e8eedb3
 > > #diff-6a1eb0b91b36c4c636f9fa5b23f5514bR53
 > > will make use of the standalone libubootenv library, and will read default initial environment from
 > > "/etc/u-boot-initial-env".
 > > 
 > > Regards,
 > > Diego Rondini
 > > 
 > > _______________________________________________
 > > cip-dev mailing list
 > > cip-dev at lists.cip-project.org
 > > https://lists.cip-project.org/mailman/listinfo/cip-dev
 > 
