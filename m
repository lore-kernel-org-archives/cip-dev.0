Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4760.1794256464395631171
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 12:34:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=P+PFw5O8;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BAED10CBBD;
	Mon, 09 Nov 2026 21:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794256458;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AHOBF6hFHsBR4zRvuf/tMk4Voeny7XmFyHPEk+wZg8U=;
	b=P+PFw5O8in9MHgz0UZ5HUhr6N6H6tRcn7pepCi1/9pR6N/l2W87DrgQC/ItqoK6sh3BQDP
	BxD9qXpfHeHnExKGT0Kwi0jnl8Dps3dOG8Jc8QUNH2yvwU/wLee0DjSunPEwypmChzSanb
	sYuCkJGyy6aN/ApaFIsYD2/e5qV+JFDwuKoVdiR3Fzx/6J0aZKCmu7/BqI/ZB80NmWosxV
	qJT+TtNcZeKCfyl//H0e63QbiEVTn8FJepb5TCXVKBlKhw7Id+2tg5+cxdkL+6Zt9iWyax
	xcIT1Wi6ELPdlRVJpssOE3jy7J+KNbBOM9ORMMvW3dnFrxw8f310OZc+0Rg0GQ==
Date: Mon, 9 Nov 2026 21:34:14 +0100
From: Pavel Machek <pavel@nabladev.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org, uli@fpond.eu,
	biju.das.jz@bp.renesas.com, tommaso.merciai.xr@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches
 backported to the CIP kernel
Message-ID: <avIuRasd_bXMXCez@duo.ucw.cz>
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <avGOCF83NRdd3Nk4@duo.ucw.cz>
 <8780b8c1-1fb8-4d95-b526-4e49bf7f869e@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jET2U66gXryxCqCV"
Content-Disposition: inline
In-Reply-To: <8780b8c1-1fb8-4d95-b526-4e49bf7f869e@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 20:34:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24732


--jET2U66gXryxCqCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is patch series that fixes CVEs related to patches backported to
> > > CIP kernel.
> > > The following CVEs and commits are addressed:
> >=20
> > Thanks, I will take a look.
> >=20
> > I don't see these in 6.12 (c8fba74056). Should we get them into 6.12
> > before merging them to 6.1?
> >=20
> > > Claudiu Beznea (2):
> > >    i3c: renesas: Check that the transfer is valid before accessing it
> > >    i3c: renesas: Fix out-of-bounds access for newdevs mask
>=20
> Just to let you know, I plan to backport these (along with other renesas-=
i3c
> fixes and improvements) on CIP v6.12, v6.1, v5.10. These should be done by
> the end of the week. If you can wait till then, I can handle it.

That sounds like a good plan. I have applied the rest of the series,
and will wait for you to submit these.

Best regards,
								Pavel

--jET2U66gXryxCqCV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavIuRQAKCRAw5/Bqldv6
8gdcAJ98tkMJgzeLAgEOL1vm9lyk5nLiIgCeMKwrSdbB0nTIiwLrRBfVoG2m02A=
=ao7T
-----END PGP SIGNATURE-----

--jET2U66gXryxCqCV--
