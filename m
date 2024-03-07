Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB90C54E49
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 14:02:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.23871.1709820161513700216
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Mar 2024 06:02:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 05A921C0071; Thu,  7 Mar 2024 15:02:36 +0100 (CET)
Date: Thu, 7 Mar 2024 15:02:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st49, 4.4-cip84
Message-ID: <ZenI+yzYaVc+ENDl@duo.ucw.cz>
References: <595658312.2214847.1709631661765@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x44QzvX7syC26NwL"
Content-Disposition: inline
In-Reply-To: <595658312.2214847.1709631661765@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 14:02:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15263


--x44QzvX7syC26NwL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Due to the switch from 4.14.y the upcoming release of 4.4 covers five 4.1=
9 cycles and comes in at 26 manual backports that need to be reviewed. My a=
pologies.
>=20
> As usual, patches can be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc

These should be kfree(range) in the added path, AFAICT:

!!a just an API tweak for future compatibility, wrong -- introduces memory =
leak | f08405728 173431 o  | btrfs: defrag: reject unknown flags of btrfs_i=
octl_defrag_range_args

There's extra whitespace change here.

!! strange whitespace change | 17c04def4 658a52 o  | ext4: unify the type o=
f flexbg_size to unsigned int

These look ok to me:

a | 2db1c46c3 9eab04 o  | mm: fix unmap_mapping_range high bits shift bug
a | 063f6c37b a1c95d .+ | crypto: ccp - fix memleak in ccp_init_dm_workarea
a | 71ba0d44a ee6e6f .+ | crypto: sahara - fix error handling in sahara_hw_=
descriptor_create()
a | f7f627ac7 d03376 o+ | Bluetooth: Fix bogus check for re-auth no support=
ed with non-ssp
a | 02160112e 53edb5 o+ | f2fs: fix to avoid dirent corruption
a | 14b84d9a2 15e4c1 o+ | fbdev: flush deferred work in fb_deferred_io_fsyn=
c()
a | fef91b68a b3943b o+ | wifi: rtlwifi: Remove bogus and dangerous ASPM di=
sable/enable code
a not a minimum fix | 5733959d6 3ef79c .+ | serial: sc16is7xx: set safe def=
ault SPI clock frequency
a | eafd83b92 78aafb o+ | hwrng: core - Fix page fault dead lock on mmap-ed=
 hwrng
a | 771df0145 None o+ | x86/CPU/AMD: Fix disabling XSAVES on AMD family 0x1=
7 due to erratum
a | 07f181ed6 3ed48c o  | PCI: Add no PM reset quirk for NVIDIA Spectrum de=
vices
a two fixes in one | 0fee6850e d6b83f o  | bonding: return -ENOMEM instead =
of BUG in alb_upper_dev_walk
a just a warning fix | 9d3aeecaa c248e5 o  | ARM: dts: imx1: Fix sram node
a | 81ca80caa dc1cc2 o  | md: Whenassemble the array, consult the superbloc=
k of the freshest device
a | 9eef5de46 90d50b o  | drm/mipi-dsi: Fix detach call without attach
a | c807df25c bfbea9 .  | clk: hi3620: Fix memory leak in hi3620_mmc_clk_in=
it()
a just a warning workaround | 7840b2e4b e3fe8d o  | virtio_net: Fix "=E2=80=
=98%d=E2=80=99 directive writing between 1 and 11 bytes into a region of si=
ze 10" warnings
a | b74c5d0d1 bbc404 o+ | ixgbe: Fix an error handling path in ixgbe_read_i=
osf_sb_reg_x550()
a | b0b2937fd 259eb3 o+ | netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE=
 when putting logger
a | 324181326 5dee6d o+ | net: ipv4: fix a memleak in ip_setup_cork
a | 04b9c13dc c73729 o+ | i40e: Fix waiting for queues of all VSIs to be di=
sabled
a just an API tweak | bcf4a115a 0958b3 o+ | tracing/trigger: Fix to return =
error if failed to alloc snapshot
a | 81c0229f3 741ba0 o+ | pmdomain: core: Move the unused cleanup to a _syn=
c initcall
a just tweaks printk/return value | 42fada9bf 5124a0 o  | nilfs2: replace W=
ARN_ONs for invalid DAT metadata block requests

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x44QzvX7syC26NwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZenI+wAKCRAw5/Bqldv6
8h73AJ9nSTLLwRoXO88L8AnKyFDfDzuxNgCgw0Q7X7/KY0Ss7xSlHK2GKjMLmSU=
=endU
-----END PGP SIGNATURE-----

--x44QzvX7syC26NwL--

