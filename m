Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61595CFD317
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 10:10:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13666.1763979028927915959
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 02:10:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fj7LdfVh;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C45F10074A12;
	Mon, 24 Nov 2025 11:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763979014; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UyNkVnz/uprCNrTFfbli1iGS49ZhTV17OkEc+lkla60=;
	b=fj7LdfVhST1p/7gtajo3Ezva4A7BqYxay1xpT/B4eorNFF3VQHK17oB0SInl59dszEAWD9
	YUBj6JC83r/6OxSQiM1kjO7Ep323/mTU3Ud+S1f3b8I4JhamYfLEW/T3CE/7ROxJuRJHnf
	GIxmixFT/EiwV/L9K50LKa+x8OLsVjKqJhWnUZOdeBJy4Ww9WeDh/mnPO+6YNUJ8KOnFQw
	O7vSOP/jdlsrKnUBPaU8sVc9KXvx5l7Bh7TWraCLFH1dPtMg5M8KlN/RH7TAJPYerITgr4
	KY3LE5YerIjcYZCzX+nl1rGeMG528eCOuTBpVIuSF7C+2MbhKpN4vbfyULh/ow==
Date: Mon, 24 Nov 2025 11:10:08 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/22] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
Message-ID: <aSQvAIPPOVe7dAuF@duo.ucw.cz>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
 <aQz1pgHaEQNgfdKa@duo.ucw.cz>
 <1875B18477989308.416970@lists.cip-project.org>
 <e4137de7-ef22-41ce-b2b5-a1d2762eeb4b@tuxon.dev>
 <aSBslxvWFIij/zGh@duo.ucw.cz>
 <111077d3-10ee-4c95-926c-e81f4c622c37@tuxon.dev>
 <TY3PR01MB113467C7D29D1ACED3381BDB386D3A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <df838a73-788b-4b4d-8c91-e2bbcc827cc0@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8IFKwSWDmyJQ4/xE"
Content-Disposition: inline
In-Reply-To: <df838a73-788b-4b4d-8c91-e2bbcc827cc0@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 10:10:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20707


--8IFKwSWDmyJQ4/xE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>> I'm going to send a PoC patch for the media drivers used by the
> >>>> RZ/{G2L, G2LC, G2UL, V2L} SoCs in reply to this thread. Please let me
> >>>> know how do you consider this approach.
> >>>
> >>> I'll take a look, but if mainline is happy, likely I'll be happy, too.
> >>
> >> In mainline the problem is already fixed by patches 01-11 from this se=
ries.
> >> The PoC patch that I sent is intended for CIP kernels only, and, along=
 with it, all the other drivers
> >> used by the RZ/{G2L, G2LC, G2UL, G3S, Five, V2L} SoCs will have to be =
patched with something similar.
> >=20
> >=20
> > What to do with Mali driver used in RZ/{G2L, G2LC, V2L} ? Mali driver i=
s used by other vendors as well.
> > Maybe special handling??
>=20
> DT nodes for the Mali IP on RZ/{G2L, G2LC, V2L} have Renesas compatibles.
> Taking into account these compatibles, the code could be adjusted to be
> executed only for the Renesas SoCs.

Ok, so we have two solutions:

1) one requires small changes to unrelated drivers in the tree

2) one that is only touching Renesas code, but is not mainline, an is
not going mainline

Neither is good. I don't believe there's another possibility?

I'd still like to know how much power this saves, and if we really
need to have this in 5.10.

It looks to me like 1) is less bad, and we may have to live with it,
but I'd like to get confirmation from other stakeholders at this
point.I t may be best discussed at thursday's IRC meeting. (Do you
want to join? :-) ).

Best regards,
								Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8IFKwSWDmyJQ4/xE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSQvAAAKCRAw5/Bqldv6
8tCMAKCXVYb/N63QahIDDTbWnYFmu09NjACgr2+s/uVc9/8tZdUMF2rRGPQ9UII=
=mzHv
-----END PGP SIGNATURE-----

--8IFKwSWDmyJQ4/xE--

