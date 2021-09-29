Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C473C433F5
	for <webhook@archiver.kernel.org>; Wed, 29 Sep 2021 18:56:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.1811.1632941790614989594
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Sep 2021 11:56:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D9731C0B87; Wed, 29 Sep 2021 20:56:25 +0200 (CEST)
Date: Wed, 29 Sep 2021 20:56:24 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
	yasin.demirci@siemens.com
Subject: Quality of wireless drivers (rtl8821ae, ath10k, wl18xx)
Message-ID: <20210929185624.GA12171@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Sep 2021 18:56:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6761


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On cip-members there's discussion about quality of selected wireless
drivers.

AFAICT we are reviewing changes to those drivers on -stable series
(good). We are not testing the drivers in any meaningful way, and it
may be good to mark them built-in (=3Dy, not modular) in some configs so
at least probing is tested. Proper testing would be quite hard, and
ammount of changes to them in stable probably does not require it.

To me it looks like wl18xx is getting very little changes; rtl8821ae
gets a bit more, but they are simple cleanups; only ath10k seems to be
under any kind of active development.

I have no experience with any of those drivers. I don't expect much
work would need to be done on any of these. If there's work I'd expect
ath10k to be slightly easier to work with.

Any comments?

Best regards,
								Pavel

* rtl8821ae (wifi + BT)

CONFIG_RTL8821AE
=2E/drivers/net/wireless/realtek/rtlwifi/rtl8821ae
=2E/drivers/bluetooth/btrtl.c

=2E/4.19.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_RTL8821AE=3Dm
=2E/5.10.y-cip-rt/x86/siemens_i386-rt.config:CONFIG_BT_RTL=3Dm

=3D> We should be reviewing it. We probably are not testing it at
all. Single change in 5.10-stable. Some developement from 4.19, but
looks mostly like staging-type cleanups.

* ath10k

CONFIG_ATH10K
=2E/drivers/net/wireless/ath/ath10k/

=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_ATH10K=3Dm
=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_ATH10K_PCI=3Dm
=2E/5.10.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_ATH10K=3Dm
=2E/5.10.y-cip/x86/plathome_obsvx2_defconfig:CONFIG_ATH10K_PCI=3Dm
=2E/5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_ATH10K=3Dm
=2E/5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_ATH10K_DFS_CERTIFIED=3Dy

=3D> We should be reviewing it. We probably are not testing it at
all. 19 patches in 5.10-stable. Under active development, changes from 4.19.

* wl18xx

(wl1837 hardware is handled by wl18xx driver.)

CONFIG_WL18XX
CONFIG_BT_HCIUART_LL
=2E/drivers/net/wireless/ti/wl18xx
=2E/drivers/bluetooth/hci_ll.c

=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_WL18XX=3Dm
=2E/5.10.y-cip/arm64/ctj_zynqmp_defconfig:CONFIG_WL18XX=3Dy
=2E/5.10.y-cip/arm/moxa_mxc_defconfig:CONFIG_WL18XX=3Dm

=2E/5.10.y-cip/arm64/qemu_arm64_defconfig:CONFIG_BT_HCIUART_LL=3Dy
=2E/5.10.y-cip/arm64/ctj_zynqmp_defconfig:CONFIG_BT_HCIUART_LL=3Dy

=3D> We should be reviewing it. We do some minimal testing by compiling
module in ZYNQMP configuration. No changes in 5.10-stable. Very few
changes from 4.19, mostly treewide cleanups.



--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYVS22AAKCRAw5/Bqldv6
8rpFAKCL7CPUHajARkDS4NBFzymflM6q5QCgtvDGNCA2sx2m3GvyyWfKm6xCTZE=
=DZ1J
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

