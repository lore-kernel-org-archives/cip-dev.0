Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C08C44501
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:44:40 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10081.1784198676330589601
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2026 03:44:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GhpxfX27;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCF59119FAA;
	Thu, 16 Jul 2026 12:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784198673;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yF0bSI/2WKIOvF3AxXFn3O7FM06vWXAmFyhEZdRuxK4=;
	b=GhpxfX27x9VpRmYd4Hjxe/IUnrUnbA6AfIQY/lt79haCNAWVwvTpbuDRuBdjpOcNIVIxtx
	u7ziaHMc0LlCm7L6ZtpnddZo6zq18vF8lLx5r/DU0q07RjfHlQulsbdmJG6zVbvRfJM3b4
	W/7BxnzYx636NWToZE9meSF2lY1WZkjDu/WBCR+4RDpaA2Z/cMfL+VHE57dGzLiZOFKH4V
	/EcKiXE6pv8PclSD3zXTuP291mSVZBtGbQko5jLsgMNyIiM+ncf5/3f8LK8WSNTqO6ecuo
	k5phzcc3WmwvcZvjlWjXbvGDyYvh2a1v1J3by7PDvR9UGPlp74M0G9IHbEjtLQ==
Date: Thu, 16 Jul 2026 12:44:31 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@nabladev.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/23] Add support for RZ/G3L
 pincontrol
Message-ID: <ali2Dxj8ySfAX_m8@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
 <18C26F8AB223D098.2287905@lists.cip-project.org>
 <aliOuduY4Em7AIBQ@duo.ucw.cz>
 <TY3PR01MB113464BDAE2112B58F3ADECDB86C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EEu8cO9OptBzQGiU"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113464BDAE2112B58F3ADECDB86C72@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 10:44:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23614


--EEu8cO9OptBzQGiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> > > > This patch series aims to add pinctrl driver support for RZ/G3L SoC.
> > > >
> > > > All the patches from this series are cherry-picked from mainline
> > > > except the patch for dropping "syscon" fallback compatible from
> > > > sysc/sys nodes from RZ/G3S, RZ/G3E, RZ/V2H and RZ/V2N to match with
> > > > the documentation after backporting the commit ba5095ebbc7a ("mfd: =
syscon:
> > > > Allow syscon nodes without a "syscon" compatible") to 6.12.y-cip.
> > >
> > > I had some minor comments here, but those should be fixed in mainline,
> > > first, so they should not block the merge.
> >=20
> > Aha, as noticed in patch 02/23 by Iwamatsu-san, this is actually wrong =
backport, not mainline problem.
>=20
> It is issue with 6.12.y-cip. Same binding patch applied twice created dup=
licate entry.

Aha, thanks for explanation. I verified the end result indeed lookes
okay, and as I had it already in the tree and tested, pushed the
result.

So... Series is now applied, sorry for confusion.

Best regards,
								Pavel

--EEu8cO9OptBzQGiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCali2DwAKCRAw5/Bqldv6
8ntIAJwOphatVUItBwxYFCyfG1UNW/jB/gCeJaIVq+/xelLLg+eKRsltvJmvHDU=
=tUEX
-----END PGP SIGNATURE-----

--EEu8cO9OptBzQGiU--

