Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75AFC2FC0E
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 10:56:58 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.184422.1692269815828886875
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Aug 2023 03:56:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A034C1C0004; Thu, 17 Aug 2023 12:56:53 +0200 (CEST)
Date: Thu, 17 Aug 2023 12:56:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/31] Add Renesas PMIC RAA215300 driver and
 builtin RTC support
Message-ID: <ZN389JxOHsu0Cnbt@duo.ucw.cz>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vNzvj6ez3voyufnA"
Content-Disposition: inline
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 10:56:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12752


--vNzvj6ez3voyufnA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thank you for the series. I'll have minor comments on 6.1 version, but
I don't think we should take these:

> Alexandre Belloni (9):
>   rtc: nvmem: remove nvram ABI
>   rtc: rv3032: fix nvram nvmem priv pointer
>   rtc: fix RTC removal
>   rtc: introduce features bitfield
>   rtc: add alarm related features
>   rtc: expose correction feature
>   rtc: rtc_update_irq_enable: rework UIE emulation
>   rtc: expose RTC_FEATURE_UPDATE_INTERRUPT
>   rtc: isl1208: quiet maybe-unused variable warning
>=20
> Bartosz Golaszewski (5):
>   Documentation: list RTC devres helpers in devres.rst
>   rtc: add devm_ prefix to rtc_nvmem_register()
>   rtc: rework rtc_register_device() resource management
>   rtc: shrink devm_rtc_allocate_device()
>   rtc: destroy mutex when releasing the device

Changes are not huge, but this seems to touch every rtc driver, and I
believe is too intrusive. Could the isl1208 driver be made to work
with 5.10 APIs?

Thanks and best regards,
								Pavel

>  drivers/rtc/rtc-88pm80x.c                     |   2 +-
>  drivers/rtc/rtc-88pm860x.c                    |   2 +-
>  drivers/rtc/rtc-ab-b5ze-s3.c                  |   2 +-
>  drivers/rtc/rtc-ab-eoz9.c                     |   2 +-
>  drivers/rtc/rtc-ab3100.c                      |   2 +-
>  drivers/rtc/rtc-ab8500.c                      |   2 +-
>  drivers/rtc/rtc-abx80x.c                      |   2 +-
>  drivers/rtc/rtc-ac100.c                       |   2 +-
>  drivers/rtc/rtc-armada38x.c                   |   2 +-
>  drivers/rtc/rtc-aspeed.c                      |   2 +-
>  drivers/rtc/rtc-at91rm9200.c                  |   2 +-
>  drivers/rtc/rtc-at91sam9.c                    |   2 +-
>  drivers/rtc/rtc-au1xxx.c                      |   2 +-
>  drivers/rtc/rtc-bd70528.c                     |   2 +-
>  drivers/rtc/rtc-brcmstb-waketimer.c           |   2 +-
>  drivers/rtc/rtc-cadence.c                     |   2 +-
>  drivers/rtc/rtc-cmos.c                        |   5 +-
>  drivers/rtc/rtc-coh901331.c                   |   2 +-
>  drivers/rtc/rtc-cpcap.c                       |   2 +-
>  drivers/rtc/rtc-cros-ec.c                     |   2 +-
>  drivers/rtc/rtc-da9052.c                      |   2 +-
>  drivers/rtc/rtc-da9063.c                      |   2 +-
>  drivers/rtc/rtc-davinci.c                     |   2 +-
>  drivers/rtc/rtc-digicolor.c                   |   2 +-
>  drivers/rtc/rtc-dm355evm.c                    |   2 +-
>  drivers/rtc/rtc-ds1305.c                      |   5 +-
>  drivers/rtc/rtc-ds1307.c                      |   5 +-
>  drivers/rtc/rtc-ds1343.c                      |   5 +-
>  drivers/rtc/rtc-ds1347.c                      |   2 +-
>  drivers/rtc/rtc-ds1374.c                      |   2 +-
>  drivers/rtc/rtc-ds1511.c                      |   6 +-
>  drivers/rtc/rtc-ds1553.c                      |   5 +-
>  drivers/rtc/rtc-ds1672.c                      |   2 +-
>  drivers/rtc/rtc-ds1685.c                      |   5 +-
>  drivers/rtc/rtc-ds1742.c                      |   5 +-
>  drivers/rtc/rtc-ds2404.c                      |   2 +-
>  drivers/rtc/rtc-ds3232.c                      |   2 +-
>  drivers/rtc/rtc-ep93xx.c                      |   2 +-
>  drivers/rtc/rtc-fsl-ftm-alarm.c               |   2 +-
>  drivers/rtc/rtc-ftrtc010.c                    |   2 +-
>  drivers/rtc/rtc-goldfish.c                    |   2 +-
>  drivers/rtc/rtc-imx-sc.c                      |   2 +-
>  drivers/rtc/rtc-imxdi.c                       |   2 +-
>  drivers/rtc/rtc-isl12026.c                    |   4 +-
>  drivers/rtc/rtc-isl1208.c                     | 146 ++++++++++----
>  drivers/rtc/rtc-jz4740.c                      |   2 +-
>  drivers/rtc/rtc-lpc32xx.c                     |   2 +-
>  drivers/rtc/rtc-ls1x.c                        |   2 +-
>  drivers/rtc/rtc-m41t80.c                      |   2 +-
>  drivers/rtc/rtc-m48t59.c                      |   5 +-
>  drivers/rtc/rtc-m48t86.c                      |   5 +-
>  drivers/rtc/rtc-mc13xxx.c                     |   2 +-
>  drivers/rtc/rtc-meson-vrtc.c                  |   2 +-
>  drivers/rtc/rtc-meson.c                       |   4 +-
>  drivers/rtc/rtc-mpc5121.c                     |   2 +-
>  drivers/rtc/rtc-mrst.c                        |   2 +-
>  drivers/rtc/rtc-mt2712.c                      |   2 +-
>  drivers/rtc/rtc-mt6397.c                      |   2 +-
>  drivers/rtc/rtc-mv.c                          |   2 +-
>  drivers/rtc/rtc-mxc.c                         |   2 +-
>  drivers/rtc/rtc-mxc_v2.c                      |   2 +-
>  drivers/rtc/rtc-omap.c                        |   4 +-
>  drivers/rtc/rtc-pcap.c                        |   2 +-
>  drivers/rtc/rtc-pcf2123.c                     |   2 +-
>  drivers/rtc/rtc-pcf2127.c                     |   4 +-
>  drivers/rtc/rtc-pcf85063.c                    |   4 +-
>  drivers/rtc/rtc-pcf85363.c                    |   4 +-
>  drivers/rtc/rtc-pcf8563.c                     |   2 +-
>  drivers/rtc/rtc-pic32.c                       |   2 +-
>  drivers/rtc/rtc-pl030.c                       |   2 +-
>  drivers/rtc/rtc-pl031.c                       |   2 +-
>  drivers/rtc/rtc-pm8xxx.c                      |   2 +-
>  drivers/rtc/rtc-ps3.c                         |   2 +-
>  drivers/rtc/rtc-r9701.c                       |   2 +-
>  drivers/rtc/rtc-rc5t619.c                     |   2 +-
>  drivers/rtc/rtc-rk808.c                       |   2 +-
>  drivers/rtc/rtc-rp5c01.c                      |   5 +-
>  drivers/rtc/rtc-rs5c348.c                     |   2 +-
>  drivers/rtc/rtc-rv3028.c                      |   6 +-
>  drivers/rtc/rtc-rv3029c2.c                    |   4 +-
>  drivers/rtc/rtc-rv3032.c                      |   8 +-
>  drivers/rtc/rtc-rv8803.c                      |   5 +-
>  drivers/rtc/rtc-rx8010.c                      |   2 +-
>  drivers/rtc/rtc-rx8581.c                      |   4 +-
>  drivers/rtc/rtc-s35390a.c                     |   2 +-
>  drivers/rtc/rtc-sa1100.c                      |   2 +-
>  drivers/rtc/rtc-sc27xx.c                      |   2 +-
>  drivers/rtc/rtc-sd3078.c                      |   2 +-
>  drivers/rtc/rtc-sh.c                          |   2 +-
>  drivers/rtc/rtc-sirfsoc.c                     |   2 +-
>  drivers/rtc/rtc-snvs.c                        |   2 +-
>  drivers/rtc/rtc-st-lpc.c                      |   2 +-
>  drivers/rtc/rtc-starfire.c                    |   2 +-
>  drivers/rtc/rtc-stk17ta8.c                    |   5 +-
>  drivers/rtc/rtc-stmp3xxx.c                    |   2 +-
>  drivers/rtc/rtc-sun4v.c                       |   2 +-
>  drivers/rtc/rtc-sun6i.c                       |   2 +-
>  drivers/rtc/rtc-sunxi.c                       |   2 +-
>  drivers/rtc/rtc-tegra.c                       |   2 +-
>  drivers/rtc/rtc-test.c                        |   2 +-
>  drivers/rtc/rtc-tps6586x.c                    |   2 +-
>  drivers/rtc/rtc-tps65910.c                    |   2 +-
>  drivers/rtc/rtc-tx4939.c                      |   5 +-
>  drivers/rtc/rtc-vr41xx.c                      |   2 +-
>  drivers/rtc/rtc-vt8500.c                      |   2 +-
>  drivers/rtc/rtc-wilco-ec.c                    |   2 +-
>  drivers/rtc/rtc-wm831x.c                      |   2 +-
>  drivers/rtc/rtc-xgene.c                       |   2 +-
>  drivers/rtc/rtc-zynqmp.c                      |   2 +-
>  drivers/rtc/sysfs.c                           |   2 -
>  include/linux/rtc.h                           |  23 +--

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vNzvj6ez3voyufnA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZN389AAKCRAw5/Bqldv6
8vhJAKCQGG/YY4PXC/YOGy18rqHxC6/UyACfZ8hldgaQ4hw6p5fUNCUJzNVqaug=
=p4sL
-----END PGP SIGNATURE-----

--vNzvj6ez3voyufnA--

