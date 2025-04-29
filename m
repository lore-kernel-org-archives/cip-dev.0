Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5DDC369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 09:53:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15596.1745920405463876846
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 02:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BHvHCDsV;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D3D71026A6DE;
	Tue, 29 Apr 2025 11:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745920403; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=nSoQGFKXQywWtHa5tV3gXCq6x707vroNxjzD+OtiYT0=;
	b=BHvHCDsVM5c/WeFVekY2kcpyglDsIzT/JGOXPhepM/13Bt7toLinekUI35uf9ZzPRbwjDD
	OPMc0nNFzc7Ua5yVAOot+BjRsELOfqcYxp/WqXinnpbC3xlI/xCt2HWvZ83pwDAsutihi8
	1znrPAImviLGLFQxySXeifnZktyC0VoZC/xGyPLsLen54cNN62/U+AHqXzN7mFif5LXyJU
	jxmGTzNmTSoMzKCk8vSac/2sDcX4mSv0czQkNNdMzZTR6Da/ymP23O3Fy4WRLWSIbg3AGU
	YLXqjJCqgFqwkPIT6/w0BjUpWW6WppcW6aHeWxhAsg1Mv8AWVUyIylX8yN9zUw==
Date: Tue, 29 Apr 2025 11:53:17 +0200
From: Pavel Machek <pavel@denx.de>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH v6.1.y-cip 0/3] RZ/G3S: Backport DMA
Message-ID: <aBChjSNF4X9pEdot@duo.ucw.cz>
References: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/kYM9PCokBUcpnb5"
Content-Disposition: inline
In-Reply-To: <20250428050051.3081705-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 09:53:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18709


--/kYM9PCokBUcpnb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S DMA support to v5.10.y CIP.

Applied. I had to fix up 3/ patch as the dts changed and it no longer
applied. It was trivial enough, so I believe I got it right.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/kYM9PCokBUcpnb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBChjQAKCRAw5/Bqldv6
8mnoAJ9SrkjtSRqhy8A+rJNlPvRedibN5gCgijiEgdxaJak7LyNZkkhd25BbP3U=
=DVyw
-----END PGP SIGNATURE-----

--/kYM9PCokBUcpnb5--

