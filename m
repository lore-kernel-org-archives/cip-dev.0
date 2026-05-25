Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F46BCD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 20:43:23 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24065.1779741795598267606
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 13:43:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JWqRAhwc;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93F83115D1F;
	Mon, 25 May 2026 22:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779741793;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tqYrNftisF1BvUq3qT5mN7rl5F5WZy/9Qhf1w09ryYI=;
	b=JWqRAhwclNTWOuSH7MvQqbdmAeACfixvINpFrSO4uZFNyopgi1hpNO36+CqCFxshJv+OFI
	RHsq9+7Ik72Z5tqM4Od88awOOZ5HdlTxRlIOufu6mzeNriLfJBRpRtQnzXmO2/kCVsxFaS
	DKogvc9nIBVY2TG/oAMwvPat7xTpjGiD6LYfgB5uHeMdEDZ1Me0p7QbSr1/JUTRFpzZMtC
	eKakGqGsqx0s1VkwIJqKImidll1+Td/WD2q+eliBuC/XcDJ2xsrXu5GS9FeEeuAQ26WJB+
	rBby5QpgV7sPbDlBxlseJCjcBay2MLFt+tqnbqcMK8+u+umIPJabv69Ckh3OZA==
Date: Mon, 25 May 2026 22:43:09 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, john.madieu@gmail.com
Subject: Re: [PATCH 6.12.y-cip] PCI: rzg3s-host: Revert generic field
 helpers, use a local field_prep()
Message-ID: <ahS0XY3jzg2X5HWr@duo.ucw.cz>
References: <20260525080034.3818992-1-john.madieu.xa@bp.renesas.com>
 <ahQj2ZBXKQh1MadU@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="clcInD/SHT5wuxy6"
Content-Disposition: inline
In-Reply-To: <ahQj2ZBXKQh1MadU@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 20:43:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23009


--clcInD/SHT5wuxy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2026-05-25 12:26:33, Pavel Machek wrote:
> Hi!
>=20
> > Commits 10566a8001e0 ("bitfield: Add non-constant field_{prep,get}()
> > helpers") and 32b1a8f287d5 ("bitfield: Add less-checking
> > __FIELD_{GET,PREP}()") introduced warnings, as other drivers already
> > carry their own local implementations.
> >=20
> > Revert both and add a local helper instead:
> >=20
> >   #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mas=
k))
>=20
> Looks good to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply this if it passes testing and there are no other comments.

Thank you, applied.

(I was little quicker than usual because the patch is quite simple and
because it fixes known regression).

Best regards,
								Pavel

--clcInD/SHT5wuxy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahS0XQAKCRAw5/Bqldv6
8hyCAJ0dQJpVNB9Ibzy6wlMmOO45XwBUAgCfSz/6DgjKxYVsxcROwzja3rZuqHE=
=7HZe
-----END PGP SIGNATURE-----

--clcInD/SHT5wuxy6--

