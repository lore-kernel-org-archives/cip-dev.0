Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80110C02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 16:58:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.21132.1739379489580100310
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 08:58:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=IPdJGZ8f;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7245103718C4;
	Wed, 12 Feb 2025 17:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1739379487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bMBNxt44MN0Txni2vhLwsmHf5PqHyt4Yf1JNfw6Mo/Q=;
	b=IPdJGZ8fdhHWuuIzcjFsL8nV1Qu9DFSyjAMGmzorBQGsg8eXEEW9izB0iOc++RsaSGWR3U
	eIS/anv18CkftA3cVf/BBiABllG4ciq3kIUH2LgT9Zan3kR4ITrDyz46Yb/pG8xSq2joLg
	aAqPYry2W4i1EuKsFKnJxK2DDG438JwwtUUTIwpcx9bKoFtySsSM6W0l27dfDZGtCfTMDd
	GEM4tR5+3+tKD+ox/BQBIqfHWovq81HX4xqlWJxByOPnu2UM0KCUDt9T+6h6+pYpllctPX
	+DnKgz+y5l74X/X+7XeTFnmb+iYg+RWkCOcK+C6CoH2HoDpqguFdXm5Vgeg2Ww==
Date: Wed, 12 Feb 2025 17:58:04 +0100
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st61, 4.4-cip96
Message-ID: <Z6zTHNwhODhmeQId@duo.ucw.cz>
References: <707882010.596091.1739240064075@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YV32cqMCuVO9UxIK"
Content-Disposition: inline
In-Reply-To: <707882010.596091.1739240064075@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Feb 2025 16:58:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17818


--YV32cqMCuVO9UxIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports for the next 4.4 kernel release. They can be =
found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/=
log/?h=3Dlinux-4.4.y-st-rc
>=20
> Seems like all manual backports to 4.19 applied cleanly, so there is noth=
ing to re-review.
>=20
a 65a3da457f648 phy: core: Fix an OF node refcount leakage in of_phy_provid=
er_lookup()
a fbb00ee18cfb9 batman-adv: Remove uninitialized data in full table TT resp=
onse
a b317a37e42dbc leds: class: Protect brightness_show() with led_cdev->led_a=
ccess mutex
a 20e3dfc5e6312 net: inet: do not leave a dangling sk pointer in inet_creat=
e()
a 9f3769378767d af_packet: avoid erroring out after sock_init_data() in pac=
ket_create()
a dc4d74d36b1bc nilfs2: fix potential out-of-bounds memory access in nilfs_=
find_entry()

These look good to me.

> e2f28a0cb0a81 netfilter: x_tables: fix LED ID check in led_tg_check()

It is strange to use memchr for this, and memchr second argument is
integer. But if the patch was good enough for mainline, I think we can
live with it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YV32cqMCuVO9UxIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ6zTHAAKCRAw5/Bqldv6
8sV+AJ9GcpuAWbRtUIjxEcO6m8XoPAWuYgCgvRd/AtzxAA+DOSZJDc/URjWyBTM=
=/SYE
-----END PGP SIGNATURE-----

--YV32cqMCuVO9UxIK--

