Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A3C001B0
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 11:23:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.11428.1689765806453509057
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 04:23:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3D04A1C0A97; Wed, 19 Jul 2023 13:23:24 +0200 (CEST)
Date: Wed, 19 Jul 2023 13:23:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 5.10.y-cip 0/2] watchdog: iTCO_wdt: Backport patches to
 enable handle_boot_enabled=0
Message-ID: <ZLfHq5APB5ME5IYC@duo.ucw.cz>
References: <cover.1689699632.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DgTKsb139WUWfYKU"
Content-Disposition: inline
In-Reply-To: <cover.1689699632.git.jan.kiszka@siemens.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 11:23:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12420


--DgTKsb139WUWfYKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> These patches are needed in order to make iTCO_wdt respect
> handle_boot_enabled=3D0, i.e. to step back from a running watchdog until
> userspace picks it up. Up to 5.16, the driver simply stopped the
> watchdog which could have created a non-monitored window during boot-up
> in the handover from the firmware starting it to userspace (typically
> sytemd) safely driving. E.g., any infinite loops in the initramfs would
> could have created a locked-up system.
>=20
> These patches were proposed to the watchdog maintainers for official
> stable integration  [1] but received no reaction so far. As the issue is =
critical for
> CIP's OTA software update integration, let's use the CIP path
> instead.

So... these are mainline, but -stable failed to react. Rules say we
can take them.

Both patches are in 6.1, so we don't need to port it there.

And I don't see anything horribly wrong; I propose we apply them if
they pass testing.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DgTKsb139WUWfYKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLfHqwAKCRAw5/Bqldv6
8shzAKCwMb2ONkcAVWQWSY0D5LTJN/lruQCglM/QSw+lv9aWrG7B6Ejp2Hy2Kqc=
=lP6j
-----END PGP SIGNATURE-----

--DgTKsb139WUWfYKU--

