Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1BEC433F5
	for <webhook@archiver.kernel.org>; Fri, 10 Dec 2021 19:02:31 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.11906.1639162950354110845
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Dec 2021 11:02:31 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 84C251C0B76; Fri, 10 Dec 2021 20:02:23 +0100 (CET)
Date: Fri, 10 Dec 2021 20:02:22 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>,
	"A, Srinuvasan" <Srinuvasan_A@mentor.com>
Subject: Re: [isar-cip-core][PATCH] linux-cip-rt: Add 5.10.83-cip1-rt1 recipe
Message-ID: <20211210190222.GA4864@duo.ucw.cz>
References: <c434a1e4-5298-ec95-1b8b-b4fdcba52ffb@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <c434a1e4-5298-ec95-1b8b-b4fdcba52ffb@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Dec 2021 19:02:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7089


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Pavel, does the resulting preempt-rt.cfg (still) make sense?

I don't see anything obviously wrong.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbOkPgAKCRAw5/Bqldv6
8of5AKC666/3hWrfN346l0QRPpqdBgijCwCfaMr4V1VDYaCcSmKT9MzsyVlYsn4=
=+mOT
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

