Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACEC3ABC5
	for <webhook@archiver.kernel.org>; Sun, 11 May 2025 19:46:17 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.35110.1746992771162977954
 for <cip-dev@lists.cip-project.org>;
 Sun, 11 May 2025 12:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=MNIRS/rP;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F8AB1048C2EC;
	Sun, 11 May 2025 21:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746992769; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IrWSS8cFvvODanNGU/A6AlNAzgLuovt83zHdRX/HT+g=;
	b=MNIRS/rPRWu8L8qh4z1aR36dWJBHvkgM16Y4Jo18/ZVpOEU1cF/z/NGLi/TJEuNi0s8KGj
	veyJqW/6WzuNh/zTHTqA5Lt4GY1Z3vqIbSogjQpFobo7ZFM+z2Dt8noLxgGdWfdNez9Yu9
	ugBLXJx9whQyS435DgG1nA3KtKI2F7tUpVnQy4/Y3w/TedS0nhI45e7Z4Uhj7A3knLnze4
	WYPJP3e6qivUvZg4Ge1HTasgnTQabg+YY20dsOqcP9QksIDEb1bFsfeXyBTkdaSnuTS1xE
	h7eqUv65ox1vE0zPo6+wDOuBCb5ECKc6jeygZ2YZRat34mCRaHawOBU3LYkZmg==
Date: Sun, 11 May 2025 21:46:03 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 00/37] RZ/G3S: Backport audio support
Message-ID: <aCD+e3pU+eXKkzso@duo.ucw.cz>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0arEV1c3kHzOrhsO"
Content-Disposition: inline
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 May 2025 19:46:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18888


--0arEV1c3kHzOrhsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S audio support to v5.10.y CIP.

I went through the patches, and it looks like I'll only have minor
comments. So I can apply this if it passes testing and there are no
other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0arEV1c3kHzOrhsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaCD+ewAKCRAw5/Bqldv6
8k+4AJ979QwWBzgAd2joKsheQjNUoGfexQCgk1k3V6siSYO6ixG12CSUU7YM3sk=
=L3gC
-----END PGP SIGNATURE-----

--0arEV1c3kHzOrhsO--

