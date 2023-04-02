Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48388C7619A
	for <webhook@archiver.kernel.org>; Sun,  2 Apr 2023 16:30:39 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.48422.1680453032079810972
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Apr 2023 09:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 538B91C0AAC; Sun,  2 Apr 2023 18:30:28 +0200 (CEST)
Date: Sun, 2 Apr 2023 18:30:27 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: Re: [cip-dev] [PATCH 4.4 0/3] ALSA: control: Fix locking around
 snd_ctl_elem_read/write
Message-ID: <ZCmtowC1mia0A1Cx@duo.ucw.cz>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NCZtlEvxRNuyUAS/"
Content-Disposition: inline
In-Reply-To: <20230324171812.221086-1-theflamefire89@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 02 Apr 2023 16:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11142


--NCZtlEvxRNuyUAS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I found a bug in v4.4-st38 caused by e8064dec769e6 "ALSA: pcm: Move
>  rwsem lock inside snd_ctl_elem_read to prevent UAF"

One option would be to revert e8064dec769e6.=20

Second option is to cherry-pick these:

> Richard Fitzgerald (1):
>   ALSA: control: Fix memory corruption risk in snd_ctl_elem_read
>=20
> Takashi Sakamoto (2):
>   ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations
>   ALSA: control: use counting semaphore as write lock for ELEM_WRITE
>     operation

They are in 4.14, it is probably easiest to cherry-pick them from
there.

Thanks for submission!

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NCZtlEvxRNuyUAS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZCmtowAKCRAw5/Bqldv6
8qNYAJ9VqMVtNeTy17FqGBXYQjM2mU/OMwCfVf9pewrbjl7FMKFazWSSLzki+kc=
=CpqZ
-----END PGP SIGNATURE-----

--NCZtlEvxRNuyUAS/--

