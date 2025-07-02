Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C49C77B7C
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 20:13:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6060.1751487206011892271
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 13:13:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=HW6dV0Up;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70BDE10380104;
	Wed,  2 Jul 2025 22:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751487204; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bf9/Nprky7kfp2zthSIZo+zlaKeVRYtF3D7ZJfVo4gw=;
	b=HW6dV0UpX2ITgtleiIU/U4Hstoe8VQMpUo85DVJUODmPJ+kjkxo6NGWxL9t0B65iu2bhpj
	a/kfWLnQJRxJ01w9R2PL/1S8ubHOeD3ML4Ku8FvzxcZl0IWx9s6rpmihDrLnEPecJ8OfW3
	0u9d6PdOABEKkJ1t5wt1Ru4rUb61K3qAmhJsQpSu80njZxTM60XbPztK8rhhpS8Fm7u90T
	PSqf3Z3WvwShMKGdvo/Jz9YNa4RFuMAKhl8tXPVaXCDae/RutMK+A1SuUKsYlADKol8Yra
	pkdAYEXwpG1Qk1xg2nvWf0di75D0uABflRpzI1qqIIkKPBAXocsTJhsHvWu5Ag==
Date: Wed, 2 Jul 2025 22:13:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Message-ID: <aGWS32HBkCy06W9M@duo.ucw.cz>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf2+5Lx1J3udd2Qc"
Content-Disposition: inline
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 20:13:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19316


--Qf2+5Lx1J3udd2Qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for the Mali-G52 GPU on the RZ/G3E SoC into
> linux-cip 6.1.y Linux Kernel.
>=20
> The changes include updating the device tree bindings, adding the GPU node
> to the SoC device tree, and enabling the GPU on the R9A09G047E57
> SMARC SoM board.

Looks good to me. I can apply it provided it passes testing and there
are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Qf2+5Lx1J3udd2Qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaGWS3wAKCRAw5/Bqldv6
8iP4AJ9GJ6Y/KgZx84NV9CNQoMZ8RHmZmgCeLSny+7WcQCNl9iPzoNQSKLd2iEg=
=DT3Z
-----END PGP SIGNATURE-----

--Qf2+5Lx1J3udd2Qc--

