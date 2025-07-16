Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B9C83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 15:19:56 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.25208.1752679194074254828
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jul 2025 08:19:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PggBxOC/;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D240B10272374;
	Wed, 16 Jul 2025 17:19:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752679191; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tWr/sC0bFQAUGztdSPhXZxuUhlm1dVh7DOZqSV1co0s=;
	b=PggBxOC/POb8IZk7UfjR+t2WPnp+qqJ3g9W5Z6povdZIRmC9tUBMfAYr385ZTfY/0I+XYh
	TBB2E2zG7QOYWWHvCs3HqDRFebWePfQqWXda2Rc1Oy4s4O63SFH45LBXaRhKd5xU+puKQJ
	we4niX2a2zXn8aV+lUEe/Y14/wUWsztjKHDQbpCGod2D3BwQnOa7J+31q1XibnQkWwgpp6
	Szuo7mw87vusIdV1YCe93yERtn7uEYcV1MgFMOCbx6rx4j+jnhviNoTYK1ZVjyMrocUy2R
	Rz+2XA8lhNnao2MstTp77rwPtnGomyCoKQwFZKA1nJ/WCduFezdywjd1wl1rVw==
Date: Wed, 16 Jul 2025 17:19:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.19-st6, 4.19-cip122
Message-ID: <aHfDEgj+sx7vuTnf@duo.ucw.cz>
References: <261306466.197838.1752596058568@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ob+J/JecaHqn5yAA"
Content-Disposition: inline
In-Reply-To: <261306466.197838.1752596058568@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Jul 2025 15:19:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19549


--Ob+J/JecaHqn5yAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

Most patches look good to me. I suspect "2c6d2af5bfee8 hwmon:
(gpio-fan) Add missing..." is incomplete, mutex needs to go to
gpio_fan_remove, too.

a > c48013043b048 ARM: dts: am335x-bone-common: Add GPIO PHY reset on revis=
ion C3 board
a > 627881126ca62 mtd: nand: sunxi: Add randomizer configuration before ran=
domizer enable
a > 41dc5877485e6 mtd: rawnand: sunxi: Add randomizer configuration in sunx=
i_nfc_hw_ecc_write_chunk
a check, are we at right place? > 78eb0dd7a6ae1 sch_hfsc: Fix qlen accounti=
ng bug when using peek in hfsc_enqueue()
a > 4ba68bb59552a bridge: netfilter: Fix forwarding of fragmented packets
a just _ONCE annotations > 26258f7deffe6 vxlan: Annotate FDB data races
!! suspect call in gpio_fan_remove needs mutex, too  > 2c6d2af5bfee8 hwmon:=
 (gpio-fan) Add missing mutex locks
a > 76a605de51329 nfs: handle failure of nfs_get_lock_context in unlock path
a > dc112be66266d sch_htb: make htb_deactivate() idempotent
a I don't believe this causes real problems > c5ddd5d93f411 ACPICA: Avoid s=
equence overread in call to strncmp()
a just a robustness against fs corruption > ab2fcd0753f0a f2fs: prevent ker=
nel warning due to negative i_nlink from corrupted image
a just a robustness against fs corruption > 4f4c2d50e6a0a f2fs: fix to do s=
anity check on sbi->total_valid_block_count
a > 44215eca75e7d usb: usbtmc: Fix timeout value in get_stb
a just a static checker workaround > 89bc62649598a drm/i915/gvt: fix unterm=
inated-string-initialization warning
>=20
> Thanks for having a look!


Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Ob+J/JecaHqn5yAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHfDEgAKCRAw5/Bqldv6
8uWPAJ92laSQuKqOLcrnrwjummNpfAcl9QCfdnkwGJ6xCDWIgSqMhlrvLrAYir8=
=4+b8
-----END PGP SIGNATURE-----

--Ob+J/JecaHqn5yAA--

