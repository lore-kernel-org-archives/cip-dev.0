From: diego.ml@zoho.com (diego.ml)
Date: Thu, 09 May 2019 23:13:04 +0200
Subject: [cip-dev] CIP software updates report
Message-ID: <16a9e7146a0.afd6a3cc10954.9216279613248465781@zoho.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

I've seen your CIP software updates report published here:
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cip_comparison_report

One thing I'd like to point out regarding SWUpdate's "bad point: depends on libubootenv which needs to be rebuilt for each target" is that this issue is well on its way to being solved.
Stefano Babic, SWUpdate creator and maintainer, started a new project called "libubootenv", a standalone replacement for U-Boot built-in libubootenv:
https://github.com/sbabic/libubootenv
This project aims to solve the need to rebuild SWUpdate any time the default env changes.

Building SWUpdate 2019.04 with CONFIG_UBOOT_NEWAPI like this:
https://github.com/Kynetics/meta-updatefactory/commit/c4c25b21d3ed4ae15f9716769c2644953e8eedb3#diff-6a1eb0b91b36c4c636f9fa5b23f5514bR53
will make use of the standalone libubootenv library, and will read default initial environment from "/etc/u-boot-initial-env".

Regards,
Diego Rondini
