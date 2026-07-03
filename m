Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A1C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 21:11:54 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.101731.1783113111797630367
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 14:11:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QwowBepL;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60DCB118CBE;
	Fri,  3 Jul 2026 23:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783113108;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=j+Zr+z0j/ekNcnxh5JR5TSAAPK9CD9u1J9qj3qSK0aA=;
	b=QwowBepLQ7DJoU87l4WecjEWMyrzpFonoZ3N7eIkU6A15WYnJIrGYP6eYjNHEha2pF67Xg
	K1nmzcBGpEUkM9sg+XzBetD04J2nFLLbMWGq42mPvwEYgfp5A3rfzv5KiejYhI/DWRx/fF
	OZa9kbNVroeed4kwaNHWhP9Qv92q34LzwBkZsSfunqXzQoPRc+7HGWXGuZAa9k+uIyLa5o
	9PVIpjCUgyXVeF0/b9P++5xn8kChfB2EEkVYA4NLPSmr0Kni3vk6TRSGuwefDZ2MRf89DE
	VrzGJ8PtS3xSz0jk73yakDae8cej9ULkp8MLQ9tMu9vzbmtmJjEiwYhBSvNS9g==
Date: Fri, 3 Jul 2026 23:11:44 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Message-ID: <akglkLO6jCOYqG4D@duo.ucw.cz>
References: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Ft/JgOdKotXETfp"
Content-Disposition: inline
In-Reply-To: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 21:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23453


--6Ft/JgOdKotXETfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series aims to add PCIe support to RZ/V2N SoC.
> The driver patches have been already backported. All the
> patches have been cherry-picked from upstream kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--6Ft/JgOdKotXETfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCakglkAAKCRAw5/Bqldv6
8tZUAJ4kSzW/+jqhiKvWWlEwDudtuU6knACgp+vVXY4/T5nac80tjD4Fx4tgozg=
=vn6s
-----END PGP SIGNATURE-----

--6Ft/JgOdKotXETfp--

