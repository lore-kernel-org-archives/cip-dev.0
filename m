Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C13CCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 19:11:41 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5877.1762456295722838994
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 11:11:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=PudLU2+Q;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89CD31003CE15;
	Thu,  6 Nov 2025 20:11:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762456293; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=A07nYQXgFyYg5B57LKOruYBE3E3M7ShlwY6ndb9VSps=;
	b=PudLU2+Q4bc97IwI7cmzBV1SkQKV5rjKw8YXQIEjwuautbRO9gGuBvhf06qRsMXGYZIYAk
	zIbjkE0EgGqzSGNYudNJsy1UL6DxzmCHcPct/tHUq11dg+m11TCXBH5UApc0mt45h5+ypd
	3I21w2JXAs8TmJ+9UIamea/d1SY5C0rYzbGVD+Fl+6cByca8N4oTgShGzH//0eQCrKC2QJ
	cGS7PiCyr8DtCj6tfc8zQd6Af8ngsKgnc/y2+Uq2q+Pkzm839Uee082/TVW+hKj6JSNHmL
	wzfaMn0weJTqk7a2ao/84m2b0VgWdrXTFTESrz7lWL5q+ZnlMvxbDYIDcnJyNw==
Date: Thu, 6 Nov 2025 20:11:27 +0100
From: Pavel Machek <pavel@denx.de>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 6.12.y-cip 00/22] Add RZ/G3E GBETH support
Message-ID: <aQzy31RLGPfUqpUb@duo.ucw.cz>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="339YQrgn32VtWiLH"
Content-Disposition: inline
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 19:11:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20463


--339YQrgn32VtWiLH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add RZ/G3E GBETH support to cip-6.12. While at it, also backport RZ/V2N P=
inctrl and
> OEN dependencies.

Thank you, applied.=20

> Lad Prabhakar (11):
>   soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC

As discussed, I dropped this one.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--339YQrgn32VtWiLH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQzy3wAKCRAw5/Bqldv6
8tiVAKCRDses0Ywi51fGHQGd+rORxASpRACbBGPgASCpXhDotma5Uly4X+B+l3I=
=AzLk
-----END PGP SIGNATURE-----

--339YQrgn32VtWiLH--

