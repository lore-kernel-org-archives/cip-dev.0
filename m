Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F4C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 07:53:52 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.25211.1750060422786504220
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 00:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BNMwhcRm;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 326B21039EF14;
	Mon, 16 Jun 2025 09:53:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750060420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Jh2ExOykoPuJ80LOz/266dzfbIQOZngP2ssaZbGf66s=;
	b=BNMwhcRmvJlLrPjDJmSZtaLSJfsg3aAIFalLvgHVugVzStXioIDLytI6HpFyAUBPydFMVG
	MKXGx6EHdvKSYXC2urceQiV/55ptkB01y9wZD/psgIdrWb7BCASRU0j2h1ia/x0wkrThBG
	KPt14vC+qQ+e42Csm3TwiwyLkdTvAeSMobnMqOCYnsxDtnrYVsryrSeHfe6pAU/sa9D9uR
	M+eXAWnd0aw9uW4bcp4++PpAb08Oc92RBbyX/F38Fzw58O8n331OHJJwvvAo/fU3WmTiOx
	zkDNQAureNZb+Otc8bsGGwpVtJ5RXNP2gBlujp6OfRYLla3zIBD+7QnCnTfWFQ==
Date: Mon, 16 Jun 2025 09:53:35 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/12] RZ/G3S: Backport ADC support
Message-ID: <aE/Nf0GBgpJRLN4Y@duo.ucw.cz>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818F570BA2356DF7ACB80E89270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EFc3D1k1B3uQinvW"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818F570BA2356DF7ACB80E89270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 07:53:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19097


--EFc3D1k1B3uQinvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, LGTM.
> I can apply, if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EFc3D1k1B3uQinvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE/NfwAKCRAw5/Bqldv6
8sPLAJ9Xh0MR0CBkoStm6N7F2aP+yyMWHQCfUh1JVcCjNXeFOLDzoZEVWAJgans=
=fbJc
-----END PGP SIGNATURE-----

--EFc3D1k1B3uQinvW--

