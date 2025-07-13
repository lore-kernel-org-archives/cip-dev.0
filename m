Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C5C83F17
	for <webhook@archiver.kernel.org>; Sun, 13 Jul 2025 09:59:12 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.54062.1752400738038341853
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Jul 2025 02:58:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TXJ+HAYc;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D30A10397286;
	Sun, 13 Jul 2025 11:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752400735; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4HS6Dx2R9YIWjhPqrcL672vaDUHSZ9KZnjfiW/a6dDQ=;
	b=TXJ+HAYcXoayL1o2AMxnsvHo289Lz9oTAVgeuoloDuih8bmPjg2pRkZxjv7d7/L5A8GpBG
	vr7I9P5b6EsSABufZoacWSc4e+Ui/GWFP9y4OR+vV0nY/HK/a1eGr+Lsf+jbMbP+8RmHIU
	Xr+Aj+rYlAtpEOokqz27iiPul+aMy9u0pQzV5CQlvBvXCYv0doUARNEiBRXHGowk/Lvg2T
	eJKObf5Y597lJ7XRrKvR4ya0D74FNpA9QoDJg3VcPczAunP5YQFDdnm4fAR69x8LodYggR
	JH8oc7JfAIt5Wq98xp/8HnzDIzOAR24avEaJJ8fXEbxIB5Hs6VZbPs7ZGsWP8A==
Date: Sun, 13 Jul 2025 11:58:48 +0200
From: Pavel Machek <pavel@denx.de>
To: biju.das.jz@bp.renesas.com
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] RZ/G2L DU enhancements
Message-ID: <aHODWBPDTudaoNV/@duo.ucw.cz>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VDDjDlYu1uiVv7+q"
Content-Disposition: inline
In-Reply-To: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Jul 2025 09:59:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19423


--VDDjDlYu1uiVv7+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series for enhancing RZ/G2L DU driver.
> All the patches are cherry-picked from mainline.

Thank you, looks good to me. I assume it is same as 6.1 version?

Mailing list damaged the patches, but 6.1 version came in ok, so I
guess I can just apply that instead. (Assuming no other comments and
okay tests).

(And I guess we should think about sending patches as one series "6.1,
6.12 -- subject", when they are identical).

I also assume 5.10 version is identical, with the dmabuf patch dropped?

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VDDjDlYu1uiVv7+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHODWAAKCRAw5/Bqldv6
8s8HAJ956oz7mZ/m6tRt/Z6+RIoHwnNbqQCeMXhBgi7nA2+P9wfuuhVnLZn9pbU=
=VA/K
-----END PGP SIGNATURE-----

--VDDjDlYu1uiVv7+q--

