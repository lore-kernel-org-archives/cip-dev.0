Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C435AC88E64
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 12:09:04 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18510.1789387736985017072
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Sep 2026 05:08:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Dl4uyUT7;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01F99103055;
	Mon, 14 Sep 2026 14:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789387730;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PxMtgkQ42gci8xTp2x3E1hh9BF3/7VMX3PeVBwNSYtM=;
	b=Dl4uyUT74hH6NygZCDryK1vgY8nbeBOk26A1mncJJnS/XZx2DJpW0fr54JxyeIveVYpYLe
	975eMACtA08tZTsz9e/jD87bc5WzIcW4sWNHPEJuj3XV2hZFkubgLq2bSAev4zgs7lLlUZ
	RS4R+AH/K/huqJBFx46S41FAbpmkSLxb56rckB2HpTqX+LNMD5lBlWv4iqJvdaDZ2Xa7+T
	b8WsQpr/LBcxMAXbP2Sl5H58CjiS4gaL6Dqt7YTITmltpHSM5O6YFwXvQUFUPH/0UE48pZ
	dI1qWVdXmaRJJti1kQPB5FA9Xxjsc9MOpMad7Y4mzCACpFyaLyfKeLpvRHWARg==
Date: Mon, 14 Sep 2026 14:08:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi:
 Backport support for RZ/G2{E,N}
Message-ID: <aqfj0P_vp5Nx4qYM@duo.ucw.cz>
References: <20260911140251.2119701-1-claudiu.beznea@tuxon.dev>
 <TY7PR01MB14818F25644168ABE36216676CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s4y1PtvOC6DM14ia"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818F25644168ABE36216676CDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 12:09:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24174


--s4y1PtvOC6DM14ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Series backport patches to enable SDHI for RZ/G2{E,N} though their own
> > compatibles.
> >=20
> > Thank you,
> > Claudiu
> >=20
> > Lad Prabhakar (2):
> >   mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
> >   mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC
> >=20
> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> I reviewed this series, looks good to me.
> I can apply this if tests are OK and there are no other comments.
>   Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2=
845749371
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

This looks okay to me.

Best regards,
                                                                Pavel

--s4y1PtvOC6DM14ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqfj0AAKCRAw5/Bqldv6
8uhJAJ96xgMwTHEMGctAXvJuyC3CmJIEFQCfahwAE1tiohDV3ahsS2npzsIDkP0=
=NWDr
-----END PGP SIGNATURE-----

--s4y1PtvOC6DM14ia--

