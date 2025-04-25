Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196BEC369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 08:46:47 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.2487.1745570800790957000
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 01:46:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FkDZpkCL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 814E010275AF8;
	Fri, 25 Apr 2025 10:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745570798; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=q2AnNmeC2euUos/IALbKS7nvWBDm9YDARcRU4YP+SeE=;
	b=FkDZpkCLLGFFiqgkIH7eGo3Z8NcT4RwOGehBrPrc92ljjnBAKpdeNw6oaxziVmo6vVHiu3
	Xti2UwPUI6WIvTpXQpY0wT6w8IC1hfQqZ3DPEgVMliVg4rY8WohUMhJqib5ihAvHjdr4Bo
	GW/n2AWrdnMxbRSWfUumtIO20hwwQfsxGZoCfRqarzjjRBgRekod25U/IkpNEijNOGPJ7z
	A+kNFhuPGl/jk0NKy0cotQScI3xkFbv8zIk3/WrAvzYgWHcENTGUHNw9Llafqe6MOGKCKl
	AeQBFxNPP1D9P1no1Ts5VrXzu8RGlS9BsqR+9L7F6Noy0iRyxlaeIpssPJnzMA==
Date: Fri, 25 Apr 2025 10:46:31 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] i2c: riic: miscellaneous code
 cleanup and improvements
Message-ID: <aAtL50fkTs8tJaPu@duo.ucw.cz>
References: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vh3yS9GTFUFAOvtR"
Content-Disposition: inline
In-Reply-To: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 08:46:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18603


--Vh3yS9GTFUFAOvtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series includes miscellaneous code cleanup and
> improvements to RIIC driver used by Renesas RZ SoCs.
>=20
> Note, all the patches have been cherry-picked from v6.15-rc3.

Thank you, applied.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Vh3yS9GTFUFAOvtR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAtL5wAKCRAw5/Bqldv6
8ksWAKC+jaiKl4VQu8qjyDXy9QtuGZZ50ACgoWivHlHIgs7hLv+12xgXeHtdG7Q=
=owox
-----END PGP SIGNATURE-----

--Vh3yS9GTFUFAOvtR--

