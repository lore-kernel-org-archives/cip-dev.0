From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 14 May 2019 02:27:39 +0000
Subject: [cip-dev] CIP software updates report
In-Reply-To: <16a9e7146a0.afd6a3cc10954.9216279613248465781@zoho.com>
References: <16a9e7146a0.afd6a3cc10954.9216279613248465781@zoho.com>
Message-ID: <OSBPR01MB3128362A42B0941DC95C9478D0080@OSBPR01MB3128.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Thanks for the update Diego.
I have added some comments to the CIP wiki:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report

SZ, Iwamatsu-san: what is the status of the libubootenv replacement on the Debian package?

Thanks,
Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of diego.ml
> via cip-dev
> Sent: Friday, May 10, 2019 6:13 AM
> To: cip-dev <cip-dev@lists.cip-project.org>
> Subject: [cip-dev] CIP software updates report
> 
> Hi all,
> 
> I've seen your CIP software updates report published here:
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report
> 
> One thing I'd like to point out regarding SWUpdate's "bad point: depends on libubootenv which needs to be rebuilt
> for each target" is that this issue is well on its way to being solved.
> Stefano Babic, SWUpdate creator and maintainer, started a new project called "libubootenv", a standalone
> replacement for U-Boot built-in libubootenv:
> https://github.com/sbabic/libubootenv
> This project aims to solve the need to rebuild SWUpdate any time the default env changes.
> 
> Building SWUpdate 2019.04 with CONFIG_UBOOT_NEWAPI like this:
> https://github.com/Kynetics/meta-updatefactory/commit/c4c25b21d3ed4ae15f9716769c2644953e8eedb3
> #diff-6a1eb0b91b36c4c636f9fa5b23f5514bR53
> will make use of the standalone libubootenv library, and will read default initial environment from
> "/etc/u-boot-initial-env".
> 
> Regards,
> Diego Rondini
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
