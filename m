Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D47C3DA6F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 11:03:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.8105.1692874983758960367
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Aug 2023 04:03:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C67551C0006; Thu, 24 Aug 2023 13:02:59 +0200 (CEST)
Date: Thu, 24 Aug 2023 13:02:59 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: CVE-2022-40307 was Re: [cip-dev] New CVE entries this week
Message-ID: <ZOc448J0V1kIRFzl@duo.ucw.cz>
References: <CAODzB9orgFUeGCfjL4BeDmEazgTDSJg_SNrtCxbvOSDcoFiviw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/XgZwn3WDnSEpN/r"
Content-Disposition: inline
In-Reply-To: <CAODzB9orgFUeGCfjL4BeDmEazgTDSJg_SNrtCxbvOSDcoFiviw@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Aug 2023 11:03:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12846


--/XgZwn3WDnSEpN/r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> When I was reviewing CVE-2022-40307, I found commit
> 7f7838c92740fa423a5a3f12c00ed02d92851254
> ("efi: capsule-loader: Fix use-after-free in efi_capsule_write") is
> not in the cip/4.4-st.
> However, this commit exists in both cip/4.4 and cip/4.4-rt.

Let me investigate. 7f7838c92740fa423a5a3f12c00ed02d92851254 is
signed-off by me.

It is in v4.14 as:

commit 233d5c4d18971feee5fc2f33f00b63d8205cfc67
    efi: capsule-loader: Fix use-after-free in efi_capsule_write
    commit 9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95 upstream.

According to our scripts, our configurations do not compile this, at
least in 5.10.

It is in linux-4.4.y-cip: 7f7838c92740fa423a5a3f12c00ed02d92851254
(not having "upstream) marking. My fault, I guess.

It is not in linux-4.4.y-st, but we should have it in our -cip trees
and it is not that important, anyway.

I propose we leave it as it is.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/XgZwn3WDnSEpN/r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOc44wAKCRAw5/Bqldv6
8sDdAKCPDFV7fHWSeMowMK0g1HNUqSCAeQCgo5hPvIrGr7d5Z97jS/+qI3uZEgw=
=g2TJ
-----END PGP SIGNATURE-----

--/XgZwn3WDnSEpN/r--

