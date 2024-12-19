Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACBE77184
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 11:16:13 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.127067.1734606964069485244
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 03:16:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=cdiCVjwj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C960E1048B8DF;
	Thu, 19 Dec 2024 12:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734606961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EUxDx+csBF7FGxMxYRQWK54JStgfLjM50yiXRIbviLU=;
	b=cdiCVjwjL2qVarpnO9V80yf6QTICzJ2rI7YCViLKREBf+XcPNzGPtU/lcUz5O72nBjPAuZ
	tf8oh8V4npZv5vay75MVOPQseqnIKCRzruYQ28gTBhlY+aviQMlFZ+Vn9BbTSpsSsmhTIM
	2iQ2ToAG7KefSlLZWuBvW+AF4b9XTnQjv31C4EubpG/RTZ17cBzPPI0TnDbDYAGR4SFzxl
	IMO++8a5YHIfs1rTZaQH2bgfSEz+OBnIXswlFyrSH2JGazQmoCfH14zjWqr3zcLZll3hEg
	N7yGqbrFoVdcFIvHFvKiw0/fSAqxBGrPjsF40dCmpIXW8ccZ6S1rc14HbZ4/Mg==
Date: Thu, 19 Dec 2024 12:15:56 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip] clk: renesas: rzg2l: Fix FOUTPOSTDIV clk
Message-ID: <Z2QAbBZtNQo20qnJ@duo.ucw.cz>
References: <20241211181524.28027-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB6388CA1D73AFD934D86A3FEE92052@OS0PR01MB6388.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="frzrwdqmWgzU1CbW"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB6388CA1D73AFD934D86A3FEE92052@OS0PR01MB6388.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 11:16:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17478


--frzrwdqmWgzU1CbW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Sorry for the delay to review and reply.
> I reviewed this patch, looks good to me.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, applied.

Best regards,							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--frzrwdqmWgzU1CbW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2QAbAAKCRAw5/Bqldv6
8hGUAKCsNXLHcVZedHjxLob/1qAlrb9vxQCfR2Uxz3w40Y4sIeXXSc79WMwRAjA=
=QSxl
-----END PGP SIGNATURE-----

--frzrwdqmWgzU1CbW--

