Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DE8CD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 20:45:03 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24096.1779741900962484382
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 13:45:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=D6Ri/JPo;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F1BF1129BB;
	Mon, 25 May 2026 22:44:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779741899;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Th32dDizHlol7H590pIVFq48yaHZCjQ/T0yFpSylrjw=;
	b=D6Ri/JPo6qT26No5x5GqDgrTJFERK/mh9+M2L2GLFXwC3iMJrqOChBmOOruGZObfvGz+H/
	HIXK2DhB2hLsXiIfZyj1BGrYFsW+3QrQTWx0QLOZe+91qceMYfR/bbRyrvEV1fuaXcIkeh
	95+U/JXge51Oj9uLI8BTgw/Pt1eSQ+gXT21dS28Q5V2qhI9TeRzqztVdRSfsDDtaOFhLAk
	mEXGPmm+aN90nf+uiHjaCCwCTgHrtx2+W3xaBt166vMvjAtbSoN/nqoHBFTaYbph4RrNwH
	ccZ7T7oO23SuynyNfxFNuCuAcZk3LJ6jm8XvDSPAXLeXNswJ92tGUI2I5RkrsQ==
Date: Mon, 25 May 2026 22:44:57 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, john.madieu@gmail.com
Subject: Re: [PATCH 6.1.y-cip] PCI: rzg3s-host: Revert generic field helpers,
 use a local field_prep()
Message-ID: <ahS0yV7IGsihuYcM@duo.ucw.cz>
References: <20260525075916.3817626-1-john.madieu.xa@bp.renesas.com>
 <ahQjwPfOxYphNczU@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YT0G8xRHY0IkPe63"
Content-Disposition: inline
In-Reply-To: <ahQjwPfOxYphNczU@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 20:45:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23010


--YT0G8xRHY0IkPe63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Commits bd9b74372900 ("bitfield: Add non-constant field_{prep,get}()
> > helpers") and 8f685ab55408 ("bitfield: Add less-checking
> > __FIELD_{GET,PREP}()") introduced warnings, as other drivers already
> > carry their own local implementations.
> >=20
> > Revert both and add a local helper instead:
> >=20
> >   #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mas=
k))
> >=20
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
>=20
> Looks good to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply this if it passes testing and there are no other comments.

Thank you, applied.

Best regards,
								Pavel

--YT0G8xRHY0IkPe63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahS0yQAKCRAw5/Bqldv6
8rO0AJ40/YdudMcBe52TXzkqEOhe92YNFQCgoHN+bUHks8BycTgxQ1EBhMLDFrQ=
=9OZg
-----END PGP SIGNATURE-----

--YT0G8xRHY0IkPe63--

