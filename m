Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B238E93703
	for <webhook@archiver.kernel.org>; Thu,  5 Oct 2023 10:50:37 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12437.1696503031524110879
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Oct 2023 03:50:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 253681C004C; Thu,  5 Oct 2023 12:50:29 +0200 (CEST)
Date: Thu, 5 Oct 2023 12:50:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: Request for reviews for 4.4-st45, 4.4-cip80
Message-ID: <ZR6U9Hx0wHasJ1Y7@duo.ucw.cz>
References: <809419142.671756.1696317771828@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1T0/fVRk6AdMt+qB"
Content-Disposition: inline
In-Reply-To: <809419142.671756.1696317771828@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Oct 2023 10:50:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13294


--1T0/fVRk6AdMt+qB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's additional patch, 67c786df30255e5d38e62852bcfd434168ed1e6e
"udf: merge bh free", 02d4ca49fa222021988b2791c8efefd70d3228ac
upstream, but does not seem to have upstream marking.

> Here are the manual backports for the upcoming 4.4-st45 and 4.4-cip80 rel=
eases that should be reviewed and that can currently be found in
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinux-4.4.y-st-rc
>=20
> As usual, most are trivial or near-trivial:
>=20
> ** m-| dbcfa782d 1b90af o+ | ipvs: Improve robustness to the ipvs sysctl

I don't see this patch when going from 48d33e0df7175b69a683cece4408dc61d3da=
f8dc.

-- ** m-| 69197b2b2 30188b o+ | rtnetlink: Reject negative ifindexes
      in RTM_NEWLINK

It should do "goto errout" for consistency with rest of the
code... but it will not cause any problem as errout: simply returns.

But... it looks like wrong function is patched..? I see a place in
rtnl_newlink() where I'd expect the patch to go?

a just a robustness > ** m-| a345df7a7 19fd80 o  | udf: Handle error when a=
dding extent to a file
a-| dd59a78d3 0c8b0b o+ | regmap: rbtree: Use alloc_flags for memory alloca=
tions
a-| 76b08ed96 a1db7b .+ | media: dib7000p: Fix potential division by zero
a-| 4573b3a8b c05ce6 .+ | dmaengine: ste_dma40: Add missing IRQ check in d4=
0_probe
a-| 2f2a59053 3a21ff o  | ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

!! |
   b2f54ed77 7bf744 .  | media: dvb-usb-v2: af9035: Fix null-ptr-deref
   in af9035_i2c_master_xfer

This patch is wrong for two reasons:

1) it puts if () statement before declarations, that's not valid C89.

2) it returns with a lock held. It needs to drop the log before
returning.

Both problems exist upstream.
  =20
a-| 50abe4b37 e110f8 o  | btrfs: fix lockdep splat and potential deadlock a=
fter failure running delayed item
a| 58a3d1d4b 531076 o+ | ipvs: fix racy memcpy in proc_do_sync_threshold
a| 29410001f 9baeea .+ | serial: sc16is7xx: fix bug when first setting GPIO=
 direction
a| 82e36f0c2 6372e2 f+ | NFSD: da_addr_body field missing in some GETDEVICE=
INFO replies

> On the surface, this one is trivial as well, but I can't shake the feelin=
g that I may have missed something here:

a| 72a1ad58c b888c5 o+ | igb: Avoid starting unnecessary workqueues

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1T0/fVRk6AdMt+qB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZR6U9AAKCRAw5/Bqldv6
8otEAJ0TvlsoQw3XfDnsQY+3Qk/6ml2fJgCfTG87XgT5iie+aWzaRA2P0amkTJU=
=H17T
-----END PGP SIGNATURE-----

--1T0/fVRk6AdMt+qB--

