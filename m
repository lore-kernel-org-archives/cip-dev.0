Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2332C369D9
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 07:03:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.42250.1745823753617232313
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 00:02:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=a72ZtWZT;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57BD61026CE85;
	Mon, 28 Apr 2025 09:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745823752;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=hXVJqGQiKmrAl+kMcR92Svm8Yayg/N9t5Dx5u9DH7k0=;
	b=a72ZtWZTRj6eEIUwYFZoGkpe3xhHH0wpsGOg0TBMXq37Siw4SJ97j/RM4iAd7jGi1QGbAV
	RMBqt8VgmnRlG12Rl8BUdooa74nPZyZRzIsFqvrc075vLtlZgHBg646y9B2JXQsSEOzKyd
	StNt4G/EPA6pddB5UOtMf5qTJXcgA2XmwGFZcOQ6yLpe65bEiJohT7yuGYhnaVLTmSxjOL
	lgZjw0iG0ijQHf05M/4qWemOqHdkjTcarlK2f1kLmfIgWNtId/sq/NsTYzcAvtBXPVn9/w
	dQFYAw1cxk4SDOHJZkUPa8mKwI5ZG9m4YNHl0Ncj110gJuE9Rcc4/Mgy9RBnSQ==
Date: Mon, 28 Apr 2025 09:02:27 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/16] Add initial support for
 Renesas RZ/V2H(SoC) and EVK
Message-ID: <aA8oA0Qe9hybNv/A@duo.ucw.cz>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <183A672739828D38.938@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1mJVYAEgep3w86PH"
Content-Disposition: inline
In-Reply-To: <183A672739828D38.938@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 07:03:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18683


--1mJVYAEgep3w86PH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2025-04-28 08:20:17, Pavel Machek via lists.cip-project.org wrote:
> Hi!
>=20
> > This patch series aims to add initial support for Renesas
> > RZ/V2H(P) SoC. With the initial patches in, the EVK platform
> > can boot up with the below features enabled.
>=20
> Thank you. Series looks okay to me, and I can apply it if there are no
> other comments and it passes testing.
>=20
> > Note,
> > - All the patches have been cherry picked from v6.15-rc3
> > - There are some RZ/G2L SoC family patches which update
>=20
> If you wanted to help me, adding note "All the patches are already in
> v6.1-cip" would be nice. (I checked few, and assume they are).

This should be "in v6.12-cip". Sorry for confusion.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1mJVYAEgep3w86PH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaA8oAwAKCRAw5/Bqldv6
8pt/AJ4qxzNiTJsr9Dz9iOySZ/THDWGWLwCfdvcPjSpwvKDnbCt0QGfj6gGNtJo=
=ZQRc
-----END PGP SIGNATURE-----

--1mJVYAEgep3w86PH--

