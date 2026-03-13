Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83BE105F794
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 10:31:31 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12842.1773397890751863879
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Mar 2026 03:31:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fqnJ6558;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFE3310C17C;
	Fri, 13 Mar 2026 11:31:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773397888;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3ykTP/w8Yt/dLs0CDifMMX8j8W6xKCwUiyNzrT7xY8c=;
	b=fqnJ6558LgSBA2QP8cKj+SHWMH/7NfQiq4cw/QZKZfWEwEr/viUwHPlw/BAL27GiC2a897
	kolJ8xawA/q93S730RCOwxPtqSLvTWs3nSLXI94i0MhN8svrzEXlSpWRkpsJyqSlI2JFbq
	UD3tnbunBrasGZtfPLZqh44YE1U+/2KHMZ+C3V7VGKEvx+eKDEXceYxi1MXb3Cdf3kzMLl
	pt0xIw+o69Xo3OW+JEvpG6TMm+aGS3e5l9v+s/UctNN/LpIt4VHbmDJ4Z7LbACA0yFVUzU
	2refk9RoiuCMrpbkdwDnLHn18dWiSrMJDUw70DGIJgUyktqev/rJBzHNDvtQ5Q==
Date: Fri, 13 Mar 2026 11:31:25 +0100
From: Pavel Machek <pavel@nabladev.com>
To: cosmin-gabriel.tanislav.xa@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v3 00/17] Add RSPI support for
 RZ/T2H and RZ/N2H
Message-ID: <abPnfRqyoKUL8xxz@duo.ucw.cz>
References: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTms4B8IUJd7Ae64"
Content-Disposition: inline
In-Reply-To: <20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Mar 2026 10:31:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22371


--hTms4B8IUJd7Ae64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds RSPI support for the Renesas RZ/T2H (R9A09G077) and
> RZ/N2H (R9A09G087) SoCs.
>=20
> RZ/T2H and RZ/N2H support is implemented as part of the RZ/V2H RSPI
> driver, and, as such, the RZ/V2H RSPI driver had to be backported.
>=20
> Patches were cherry-picked from upstream kernel.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--hTms4B8IUJd7Ae64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabPnfQAKCRAw5/Bqldv6
8sjkAJ9U2lvt75H0fSAGINtGuzx0fyW4sQCgtY9Iba+D08tPiZbjsSztNKegFPY=
=v+r4
-----END PGP SIGNATURE-----

--hTms4B8IUJd7Ae64--

