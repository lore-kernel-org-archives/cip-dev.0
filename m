Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A165E77180
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 19:15:56 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.1873.1733858147916625746
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 11:15:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Dwy6vX6c;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1545F103B8FD5;
	Tue, 10 Dec 2024 20:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1733858145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7Mpi3tJ8KF8cr5V71A8C6+xTsRsuPKXDIm14M84sEI=;
	b=Dwy6vX6cTaS5uiV4mGWmrQWsgpO5mTNfdco5UBOMSyUyo43EyjFmDz+3Sl/+WIXPfZ3KSI
	dYQw3Bai7npw8dn9rk3IlMJgOc+Mv9L+zASGu7K0doSZQBEmKKZLSGhPJmf8t6J3sr8awE
	L5i6upimwG7kutSJf8lZeTPuns80LtYoMNg8SD8pzigd37I8YGC821axRkT0GBFB/pBHJx
	kFwC2Ahbvl6yE4+CRvE90IUhskQPq/WL3fxUmOGb3cpsNZf5Ky/E8AurQ9TY7feh9LMOl3
	wnPvZiv3JgBvCBMKTYAMCnxSwdRLbQUCbeXx4+XMMSL9Kb3hVcpVdOzt0h6mIQ==
Date: Tue, 10 Dec 2024 20:15:39 +0100
From: Pavel Machek <pavel@denx.de>
To: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg2l-smarc-som: Enable
 4-bit tx support
Message-ID: <Z1iTW1Tao2v41eq7@duo.ucw.cz>
References: <20241209175611.20172-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JxfaUwrEcQLcEpqo"
Content-Disposition: inline
In-Reply-To: <20241209175611.20172-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Dec 2024 19:15:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17392


--JxfaUwrEcQLcEpqo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit ce3adea16612a677dd50bdad6861f37f5dc878c3 upstream.
>=20
> Enable 4-bit tx support for sbc node.

Thank you, both 5.10 and 6.1 versions look ok to me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JxfaUwrEcQLcEpqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1iTWwAKCRAw5/Bqldv6
8iGLAKCfdj0lDIICnCt0jXdVL/7JEvVCvQCgkE321lTphNlIVMZV6s1k76bOHI8=
=4bN0
-----END PGP SIGNATURE-----

--JxfaUwrEcQLcEpqo--

