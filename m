Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2D5CA1002
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 11:36:20 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.36935.1756985771071247837
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 04:36:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=UbqnR920;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 133771026E156;
	Thu,  4 Sep 2025 13:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1756985769; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=//GK3OLqoeng/zf2wdcO+qqSudcyk61XfUv7BpZekjc=;
	b=UbqnR920uZ3ZOT3gUSApW6J09seyhOQnMIdaPlP6VNOpuxbVVFr8ZdctBuatUB5YsAq8/s
	0YJPoQ8LKikr9tGrgM6b7cRWF83dOzC0099/cn+n0U1FWx9dogF6mWUchiN0gQy1GWoUJf
	1YiR+aUH+8/FHND1JtehoaT9/8TrsMrvArXn8LDxUa0yHukBjSEwLOyqOjJbULUl1bV66/
	URWfknS0qXwSlnT2j0EN3eBW1MwxiJ92v6PFrxahTzolMn5YRGmLMFCymX3vP9GswYgigq
	VlAC6mck+xdo7VnPvhBY+j7KlBYebUG9RBpDBMtae+VCBVtzeFzv7b2HiGp4MA==
Date: Thu, 4 Sep 2025 13:36:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/55] Add support for CRU/CSI2 on Renesas
 RZ/G3E
Message-ID: <aLl5ogXyxHq/35yw@duo.ucw.cz>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TpEdnmJVKZqxT8ad"
Content-Disposition: inline
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 11:36:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20016


--TpEdnmJVKZqxT8ad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support for the CRU/CSI2 IPs found in the Renesas RZ/G3E=
 in
> Linux 6.12.y-cip. These IPs are similar to those found on the RZ/V2H(P).
>=20
> In addition, it includes patches required to successfully run the v4l2-co=
mpliance
> tests against the OV5645 and the entire media pipeline.
>=20
> This series has been tested on the following hardware setup:
>=20
> OV5645 image sensor (Coral Camera) =E2=86=92 RZ/G3E CSI2 =E2=86=92 RZ/G3E=
 CRU

I'll likely apply these in a hour or in few hours, so you have last chance =
to
comment here :-).

Best regards,
									Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TpEdnmJVKZqxT8ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaLl5ogAKCRAw5/Bqldv6
8uouAJ4mavI8Htd3ghnbU3psflvTZrlxGwCbBpJ1nh4kmS3pn4c2Lv6lSg8UnUU=
=HXeW
-----END PGP SIGNATURE-----

--TpEdnmJVKZqxT8ad--

