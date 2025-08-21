Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE2CA0EDC
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 10:42:11 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.6458.1755772924435965861
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 03:42:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=RdhQLifg;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5EAD1038C11E;
	Thu, 21 Aug 2025 12:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755772922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9gs81Hv4+HCFerN2znBFqTIWlJxkv4i1gE+1q88fJtE=;
	b=RdhQLifgcQSw269CwfoeDJomeQnaA0vz7URdO451bgzHG3NN1toKRUH2A5DKSdJJZzp1Tf
	wqlaqejQIYscNysxxM6ibU9kYD42b9ybo3uic4bHLDJ5CCZpJolumiKNVxFyv4uMhStw/p
	FsP+KFNDZcQdHb5XCaKs3H2Vt4T7+/ei/e5x0DkL7g3kw0gL773Cj68ASBcg5Il+U4fuE5
	0wcWeONFSggSNM7nceGD98yGtNCx+Ih6gejQwhe5m+eIoJcO1cQwMuR3JtJ74TYL5FO9JC
	vdmngqThDShKNiDjlyaDYzdQhvS4FZ7pIfxmuCQ9vrSeRn1Tf6yZ275XC8jSow==
Date: Thu, 21 Aug 2025 12:41:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Ulrich Hecht <uli@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] gpio: rcar: Use raw_spinlock to protect
 register access
Message-ID: <aKb38+2Q49y8kzBl@duo.ucw.cz>
References: <20250820141305.4841-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="izn5hd05Kysitznb"
Content-Disposition: inline
In-Reply-To: <20250820141305.4841-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 10:42:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19932


--izn5hd05Kysitznb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
>=20
> commit f02c41f87cfe61440c18bf77d1ef0a884b9ee2b5 upstream.
>=20
> Use raw_spinlock in order to fix spurious messages about invalid context
> when spinlock debugging is enabled. The lock is only used to serialize
> register access.

So... this patch is present in 6.1-stable, and the patch looks okay
for 5.10.

But as far as I can tell, this also applies to 5.10-stable, and that
is still maintained by stable team. I believe this should be submitted
there.

Then we'll backport it to 4.19 and 4.4, provided it applies there, but
I assume it does? (If not, you should re-send those versions after
5.10-stable accepts the patch).

Reviewed-by: Pavel Machek <pavel@denx.de> # for 5.10-stable

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--izn5hd05Kysitznb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKb38wAKCRAw5/Bqldv6
8tyDAJ97GEI1ZZcHTJFon1FS+prcZ6yMpwCgg3NZbJUgDot/pvXvGOGfbWoPz84=
=x7I1
-----END PGP SIGNATURE-----

--izn5hd05Kysitznb--

