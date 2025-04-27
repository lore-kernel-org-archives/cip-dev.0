Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB3C369D8
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 08:42:27 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.23387.1745743228519047981
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 01:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Knn9vIak;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32BD3102A8CA4;
	Sun, 27 Apr 2025 10:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745743226; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=m4K5Gh+IOW6yg5Ds2b3VbDDqFjYS2w1B2yzHb0i89KM=;
	b=Knn9vIakXFgEN+ony9hWOe+srtlim5ZqtNRhWAuSWOKJZ3hlWf9qbg03DWMnWbuSP2SUuo
	Bshfxvd63PQs5TeBhZtjsL4UfbFS+nWwLghVteH0slkpWd1CK2UpjwE6MWmutKDVG6Gk37
	rSXcLLkZ+nl13XxZycQtBQz5WqCfWLQJ3MbKDt6CVZqORNr8oMUjymejEieqW/QcmBYKI3
	z9Kuz/O7vdVfZo7S1IsUl+1wfrY/xyq9PDUyHne1p/E92DMRTGsbnvgS4rwlw9keHafIC8
	h63xzaSkXMj+AiL5zSCRIPyqSm0IVVDt6D0nkuG1NKFHXmmnpZD6mpZycXQj1Q==
Date: Sun, 27 Apr 2025 10:40:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/21] Add SYSC/MMC/GTM driver
 support for Renesas RZ/V2H(P) SoC
Message-ID: <aA3tc2RKUqz0kBFk@duo.ucw.cz>
References: <20250425121445.62818-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aAyHwQABeRiZtiL0@duo.ucw.cz>
 <CACe6DC7aWeXCt0V1f07hu8ro7cjGfrmJ_vDxKxJzJtgugSumJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v2r5tw0N12XJix/C"
Content-Disposition: inline
In-Reply-To: <CACe6DC7aWeXCt0V1f07hu8ro7cjGfrmJ_vDxKxJzJtgugSumJA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 08:42:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18648


--v2r5tw0N12XJix/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series aims to add below driver support to
> > > Renesas RZ/V2H(P) SoC:
> > > - eMMC/SDHI
> > > - GTM
> > > - SYSC
> > >
> > > Note,
> > > - All the patches have been cherry picked from upstream kernel
> > >   v6.15-rc1
> >
> > And all patches seem to be in 6.12-cip, too. Good.
> >
> > Series looks okay to me, I can apply it provided it passes testing and
> > there are no other comments.
> >
>=20
> I reviewed this series, looks good to me, too.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I have added your reviewed-by and pushed the patches.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--v2r5tw0N12XJix/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaA3tcwAKCRAw5/Bqldv6
8nnPAKC7DV0sjLBSh2UEsR+6FDvGQ7xbzQCfT6Bg2GXDxoxRKaNxrRVIPzsrDQI=
=Wokk
-----END PGP SIGNATURE-----

--v2r5tw0N12XJix/C--

