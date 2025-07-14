Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF23C83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 08:31:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.73695.1752481898407250852
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 01:31:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=YAZoKgAC;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9E4D10397286;
	Mon, 14 Jul 2025 10:31:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752481896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Bi4X4I3z+LmGi67yJps87r/mtxF8VUJdmLvD39zRgQI=;
	b=YAZoKgACVCurpwxE9P5ZUEbmB9Mw0ccMeFmSnuqzPVKioXtwLGMd6Eq/o2BKy1BIa1rXMT
	8LzVh51Mbxs8eNTkrxHbGI0sZyRzycqumyFs4Qp9d9RPn8JPJ5RhPCt+9nqjCO1whjq7nx
	9CbEbv4wQpP0JUF0ObjDw79M6O5Jc93vgBppkKByo3/e7l/1vyCCv149cq4qHdzDOIFJfb
	Bd9ynTpY+HwQXcH1O57Q/4WQZWFxpMQOyaHK8Ws3tJnjj+CdbYiaJyCbm2nPa20d3wMTIF
	o8S33UhL0TTzTsQkREDF0e6vW8cp5u1HbZIjSnzEtbxhHV3hU8Zt60YZ9AaVCg==
Date: Mon, 14 Jul 2025 10:31:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Message-ID: <aHTAYR3/hMFly7p6@duo.ucw.cz>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
 <aHODWBPDTudaoNV/@duo.ucw.cz>
 <TY3PR01MB11346B27385EF1C42125F09AC8655A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QbRVzfIIrUYdDsHQ"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346B27385EF1C42125F09AC8655A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 08:31:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19425


--QbRVzfIIrUYdDsHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series for enhancing RZ/G2L DU driver.
> > > All the patches are cherry-picked from mainline.
> >=20
> > Thank you, looks good to me. I assume it is same as 6.1 version?
> >=20
> > Mailing list damaged the patches, but 6.1 version came in ok, so I gues=
s I can just apply that
> > instead. (Assuming no other comments and okay tests).
> >=20
> > (And I guess we should think about sending patches as one series "6.1,
> > 6.12 -- subject", when they are identical).
>=20
> Yes, I agree. But I have notices that, sometimes cherry-pick adjusts the =
line position for patches
> automatically even though it is identical patches across 5.10/6.1/6.12.
> In such cases, if applying patch fails one can cherry-pick it.

Aha, yes, so that can no longer be automatically applied.

Can I ask for re-send of the patch to pavel@denx.de? Unfortunately
mailing list damaged this set and I don't see a way to easily pull
them out of mailing list archives.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QbRVzfIIrUYdDsHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHTAYQAKCRAw5/Bqldv6
8iChAKDAlILlM8x6yPeFF/sD2+1Nq7KqrQCgo8chAlVjmIwvsZoRf/LQAbNRcvY=
=zet1
-----END PGP SIGNATURE-----

--QbRVzfIIrUYdDsHQ--

