Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA360FEEF2A
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 11:50:37 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.79434.1775562629977533861
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 04:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=IV58f3i7;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E6F110C6B8;
	Tue,  7 Apr 2026 13:50:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775562627;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iJLZ9Nezanl1Uyqrpq7pHrEy+e6KYQq2x0/Aobdehwk=;
	b=IV58f3i7PKQr01NLSCG+9TFO2TEjthUas8L6FNckCtdHma7YZS21sLUrxQqRHHS1m2KNRt
	58PObrQgHwaNtXnezPQyk1RooQpiYhMIpwOK4zgMii0aUOmP1N/zK/vPJEiN7KTa8KU3Dy
	o2veY+zzWSIscItMaqQczW5t1FvSbEOCWlnELVuo08iS+0zOvm7EGPZ48sZ3sAzib8z1Zs
	J2QednI2Ji3+8EVU8CK6zft15QXmhP5hQ1IC9BwFI6UMLtr5/BVGaZEmfaWszb0CHIwoKd
	hcrmOr9aLd8MlxbRoj1JPk+/1zBobgVY6wDRGbvKowEnGir1zhlh1LP7HakqJQ==
Date: Tue, 7 Apr 2026 13:50:24 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/10] Add CANFD support to RZ/T2H and RZ/N2H
 SoCs
Message-ID: <adTvgIpQ8U4hKUxL@duo.ucw.cz>
References: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oq+gBd8580iQfZbP"
Content-Disposition: inline
In-Reply-To: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 11:50:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22633


--Oq+gBd8580iQfZbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add CANFD support to the Renesas
> RZ/T2H and RZ/N2H SoCs and enable it on the EVKs.
>=20
> Note,
> 1] All the patches have been cherry-picked from upstream kernel
> 2] Patches apply on top of commit-id 7c78ffe0f95bf.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--Oq+gBd8580iQfZbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadTvgAAKCRAw5/Bqldv6
8uteAKCauAGx7Eo79pMNJI6AjaoS2nxR5ACfWZQjqs/mekgQlw6JcOdvBuzVMek=
=BE4M
-----END PGP SIGNATURE-----

--Oq+gBd8580iQfZbP--

