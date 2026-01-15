Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577ECD41147
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:51:02 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31461.1768467060261078492
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:51:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=IYUZ9Fsm;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8577A10D69F;
	Thu, 15 Jan 2026 09:50:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768467057;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yb4rsTDXNnagiYBycUVKqd6ZQVLRZCxTstSZH0ewK8k=;
	b=IYUZ9FsmsedLrZy2uSu7+2UOx60w2Rsp3C3wrUICVk52FgurvqSjGH7MbSNYYqEp8941BS
	Ydc/CgJlbC+Rgmr4ydvd/4pTDNNx2UFRZuaqpphbLq2CnRDENl7txesRSIBB0WD4xUiywb
	hsZoJsOmSMUn59hjUBgpHDqKsBNpgovPQ1SktqUZXeQ8dvDfQAlQj+7hQXdrtHWYyjjR8i
	Eh4HU+hcnBewIPnpXRaPvh/NvlCCl9+Uc56VV4y+KmARiMAtG9feE4EblvappdIY6QL++w
	3AYEE+sCHJznVph9VVDjQwJcgCwcK1J2eBnjaLW/RvOnzxGWIbKVEXtRXd04Uw==
Date: Thu, 15 Jan 2026 09:50:52 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: tommaso.merciai.xr@bp.renesas.com, pavel@nabladev.com,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/22] Add I3C support for RZ/G3E
Message-ID: <aWiqbGg9K6wPDxbo@duo.ucw.cz>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
 <aWDa/P7QVLdqjKrA@duo.ucw.cz>
 <aWDvp3CFQIiO52v9@tom-desktop>
 <TY7PR01MB148183E8B139F71C9C853E40CCD8EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q7FuLQdEDO6+D/Yw"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148183E8B139F71C9C853E40CCD8EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:51:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21620


--q7FuLQdEDO6+D/Yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I had some minor comments, but those should not block the merge.
> > >
> > > Reviewed-by: Pavel Machek <pavel@nabladev.com>
> > >
> > > I can apply the series after 6.12 version, if it passes testing and
> > > there are no other comments.
>=20
> Looks good to me too.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thanks for review. I applied patches up-to "Add the I3C node to RZ/G3E
SoC DTSI."

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--q7FuLQdEDO6+D/Yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWiqbAAKCRAw5/Bqldv6
8lneAKC+iHwmG59iAfz/E1EpteCvXvyLNACggY1bwMtxQyszJXsOdHTsdnK07F0=
=blhh
-----END PGP SIGNATURE-----

--q7FuLQdEDO6+D/Yw--

