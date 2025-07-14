Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7D1C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 09:38:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.74396.1752485901545311024
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 02:38:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FWeVxmo/;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7112B10397286;
	Mon, 14 Jul 2025 11:38:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752485884; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=r1jcRuyHGS60mcC0kGNea5kuYJwpY3P6PJFgrri1zYA=;
	b=FWeVxmo/uRdSFty/SswAthyC7q6tsaMS93U7nbgPCvGEAvcL2VV6HMDOPhIho4Z0pN/pbk
	hA3yjzu7Ta9O95grcmkZVu5X84FfmZYC2RGrHJkOGN4Ua8uIM8bVN1dYuyAKEloAT5N91s
	OqwxtYD/+ysv5riHSPrCTbU3vtGr+/ipW36zEGFv/1g0bJRRQYDMWP+4F27SJsI6lJzDcy
	82a4FR5iIgsxSjxZvvXi2oogeZ6K/Zo/f0MCnrRaSpKspvYAUe8uGWcX+u6Eub7wL4TS8F
	KRawDB6RyunxKYFY5k7Oi6qsn0WotWtgKcgiZ3/Feg3BbMUF4bIf1sNL932nUw==
Date: Mon, 14 Jul 2025 11:37:57 +0200
From: Pavel Machek <pavel@denx.de>
To: biju.das.jz@bp.renesas.com
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Message-ID: <aHTP9eVpJPmZOYh+@duo.ucw.cz>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oISpQH2PGFp3CHjg"
Content-Disposition: inline
In-Reply-To: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 09:38:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19427


--oISpQH2PGFp3CHjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series for enhancing RZ/G2L DU driver.
> All the patches are cherry-picked from mainline.

Thank you, applied.
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oISpQH2PGFp3CHjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHTP9QAKCRAw5/Bqldv6
8l8yAJ0fwQ82RTt1UL3VKBQrAaTKOFNFmgCfQ5uPy9baS+mnWDsGZ+HFL+yh/M4=
=GIrW
-----END PGP SIGNATURE-----

--oISpQH2PGFp3CHjg--

