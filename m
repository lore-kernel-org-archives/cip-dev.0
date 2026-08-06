Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF7C55ABF
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 13:10:57 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19405.1786021848008252099
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Aug 2026 06:10:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CywXpE1+;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E51011AC93;
	Thu, 06 Aug 2026 15:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1786021841;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GZX6hfXaKTzqZxq3Qs5CeQo19DiWVK3O4gNnQkk86bM=;
	b=CywXpE1+PSWK6zp94fQg0QLIhhQ7pvCp1jbrgxlLOg7G2a42qlFZOq/Wni9VMqdgov7vIf
	Lmtt3DoReJZwVFrc3RcxieGBgA/s3B93yTX/HXiZfXQk60NAbBa7LZFYq2qnUcM1l2cD0P
	FNn4+lJYVUmxVEIIuN/8mGYrD+XiLq6BFabzrxvYQ6RDYa/w84G577DucdkjfTLUBF4EoP
	CgNHNn1dXIrGkFivVHwUDy0nkmbgMCuisprcJ3RXzCXmc4hUZNTaMnDSMe1UYEThjdxBA/
	65VwEYihoVOBYbRpKryhCQyrlziztSsr3eBJ5w7FAcuZDUmHLb/boAUGJNPgvA==
Date: Thu, 6 Aug 2026 15:10:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/7] Document RZ/G3L I2C, WDT and SSI
Message-ID: <anSHzBfGZHpkUE56@duo.ucw.cz>
References: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Nt+h4m6FrFOEeJo"
Content-Disposition: inline
In-Reply-To: <20260803145831.91924-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Aug 2026 13:10:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23871


--3Nt+h4m6FrFOEeJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series document I2C, WDT and SSI IP found on Renesas RZ/G3L
> SoC. All the patches in this series are cherry-picked from mainline.

Thank you, applied and pushed out.

Best regards,
								Pavel

--3Nt+h4m6FrFOEeJo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCanSHzAAKCRAw5/Bqldv6
8n62AKCmdpehA6aeCB8lrBbKu+HPKHuztQCeLPaRuyLcuatSJSmmThAz8Jf3F3g=
=B8EN
-----END PGP SIGNATURE-----

--3Nt+h4m6FrFOEeJo--

