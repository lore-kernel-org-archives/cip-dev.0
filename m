Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D574ACFD376
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 12:16:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14730.1764332185580206003
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Nov 2025 04:16:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=M8/k+UJB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EF041038C12D;
	Fri, 28 Nov 2025 13:16:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764332183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vJwSHNsG3sPSpYZlZelp1eESl7h+EWnbA5/MbT9xdtc=;
	b=M8/k+UJBjkX9BWOaPsM8sVzWgx9AAjIeVyE+ear3wvPBKIxHhnJfqIRHq1T7X65LQQ/IL7
	pmQ6VoXo9awp4jYm28R5JtilJ8Kk7QCIcdcVpLt8UUGdNDUuWOivwWKFp31KZbrjdCy8qd
	k2RemxpHvBS3C9/GoUcf6ksrAjRXjBVqK7F0Z5L9w8v3DvsseTPDGBC5kzhj63cz3KHcyX
	jCfpiuxMS/VZOxclSYqAegBK6tNKdAa6YYGxFJbJ2knS442NO8Vctl1rj5eAn7LnkQc7Up
	dBPe8e6K8mxmY8s7mXsccrJsCOvBlqDkt+CICaKm1/KFga03z3hPzqFH37zK9w==
Date: Fri, 28 Nov 2025 13:16:00 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
Message-ID: <aSmSgFotymZ+FoaP@duo.ucw.cz>
References: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P9tmYBrrZmAmIwJN"
Content-Disposition: inline
In-Reply-To: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Nov 2025 12:16:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20766


--P9tmYBrrZmAmIwJN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds DMAC support for the Renesas RZ/V2H SoC.
>=20
> Upstream commit 1b86d3ecde5c ("dmaengine: dmatest: prevent using swiotlb
> buffer with nobounce parameter") was cherry-picked to allow dmatest to
> validate DMA controller functionality with and without swiotlb. The
> remaining patches add the actual support for the RZ/V2H DMAC.
>=20
> Patches were cherry-picked from mainline kernel.

These look ok to me. I can apply it if it passes testing and there are
no other comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--P9tmYBrrZmAmIwJN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSmSgAAKCRAw5/Bqldv6
8v7YAKCfg0kHTpTdxvAmXwvJfR4jOnH6NwCfd72MKY2Nsd6WN6X8ZALgsQ2QnG0=
=LjiP
-----END PGP SIGNATURE-----

--P9tmYBrrZmAmIwJN--

