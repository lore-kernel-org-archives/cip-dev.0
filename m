Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223CC369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 10:02:34 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.36318.1745316147105573872
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 03:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=ZbFfl4P4;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D279102E13F8;
	Tue, 22 Apr 2025 12:02:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745316144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XY3bpltRv21xkfIi157jQYfi+kDeZ2knqhuDSooQAxQ=;
	b=ZbFfl4P4mzcfDGvrxR5377OXnzewcA8USCaUzlg9ajrT8KFqs0FidC/kr5B5TGTZ18I5ox
	ULOP6aviOedWPmMZubECnIX7cDVpirDBCf+t8JHYTGKiJNC7ut/Zw+AAgxtn7LkbUEV+fl
	+4yfXd+lIfYcshGLvXocbxqFEUo1EvCRcpVwh3cMz7n6CRL6a2CTZ2jiw+kAmb0URtYOAk
	IsCty7ERHbqaf/OD6Ee8Y+yV1zyIRm2WyZqC+0DBjxB7iDbmPp35KZQfvpI/q49/gjr1bH
	WctZSKV+jIwaluwOLP4VtisDZxd1uzAA/og/bE9tQUypGnV4OLyQoBNbKXms1w==
Date: Tue, 22 Apr 2025 12:02:17 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add clock and reset
 entry for DRP-AI
Message-ID: <aAdpKSG1uUgP3QzT@duo.ucw.cz>
References: <20250421184657.633352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RxP0qvrTRkEIpDRu"
Content-Disposition: inline
In-Reply-To: <20250421184657.633352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 10:02:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18544


--RxP0qvrTRkEIpDRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 989d673ff7c461b2abd472227fdb7df69860d23f upstream.
>=20
> Add clock and reset entries for the DRP-AI block, which is available only
> on the Renesas RZ/V2L SoC.

Looks ok to me. Both 5.10 and 6.1 versions:

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RxP0qvrTRkEIpDRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAdpKQAKCRAw5/Bqldv6
8jlLAJwJjywOUItAsPA/BDMaPILEetwE2wCfSP7PQCMFBDKai5v+LLvnOilRQvw=
=I3K2
-----END PGP SIGNATURE-----

--RxP0qvrTRkEIpDRu--

