Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F55CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 11:54:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13665.1762430072749145615
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 03:54:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hycKz8IU;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E90A103CF2A2;
	Thu,  6 Nov 2025 12:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762430070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ou8gttLqTcSZYZgNDO71Aaap3F5w9Zj5i86EXfjGaTA=;
	b=hycKz8IUozlN6KpLj63/3uiAgSDW1OiIPKgZD5r34enqURIYYGnXJVTBymX2M1s7QQSQG0
	crFE+ParVtwhrQdygr5Wv4Q14QPopFwhpKOenFeUBHDdSDCV/PlERy19r0i2oBF0qTZ48a
	PTcI5G6r0I5jAqB5qLV1satdlX7tcct2u1ydH4RD8ybaB/ju7jcHmB4e8EfAq1n2oGFrAj
	bkYD1ofHAr9JebANE/hl1i5P02wG85mv8VDMwyI7S6DYYeSO3vI0ZEsTm+kZRXj0gCVlsu
	/jI02eOEtbodnr7syeTWduLGsl0W/AnxHekwGyv+K7TYGONWBgTr7kbCo7YJNQ==
Date: Thu, 6 Nov 2025 12:54:25 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Message-ID: <aQyMcVqnx3ODjc6n@duo.ucw.cz>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <aQsW7v7fTWuS5Zi9@duo.ucw.cz>
 <TY3PR01MB113467095AF7FBC653DD1A8C586C5A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aQsrldDm96rIxlNU@duo.ucw.cz>
 <TYCPR01MB11332F6D8A88A738C4F65BC4486C5A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="If84Ob/TRLcxcNWQ"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11332F6D8A88A738C4F65BC4486C5A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 11:54:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20460


--If84Ob/TRLcxcNWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > What I'm saying is that having kernel with
> >=20
> > +config ARCH_R9A09G056
> > +       bool "ARM64 Platform support for RZ/V2N"
> > +       default y if ARCH_RENESAS
> > +       help
> > +         This enables support for the Renesas RZ/V2N SoC variants.
> >=20
> > but no working rz/v2n support seems to be confusing to me, and I don't =
believe that's a way things are
> > usually done. Can you correct me or explain why it is required here?
>=20
> It is just added for build coverage for RZ/V2N pinctrl driver. If you thi=
nk it is wrong
> Please move it to last or drop it.

So this builds and tests okay. I'll apply it with the config option
dropped unless there are other comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--If84Ob/TRLcxcNWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQyMcQAKCRAw5/Bqldv6
8utsAJ0R0Q9DzmMqkJHkcwUOTfaEUPaaagCgre6EeohO/f05wCGQBvoZr4qlXMo=
=w5hk
-----END PGP SIGNATURE-----

--If84Ob/TRLcxcNWQ--

