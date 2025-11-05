Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2061CCFA05
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 11:20:05 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7296.1762341592237279324
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 03:19:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DIKj2q9T;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 177EF1003CE06;
	Wed,  5 Nov 2025 12:19:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762341590; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=KHUeFJW0VKgDyuSStaEL+NLkJKYj61u45kWyG2HNFp4=;
	b=DIKj2q9TSqmAVIQFPwodwAk6QPs7/dYAfWXi1Ux3sfktUqrrdaFY1P9wMOCmkOKVQ/u9jv
	rIGL+PHmcDKMA6L+FAoK0vNHO9sEx29Xr5rYVoQi+5eXZ2TyywwjJSyQJJcPh5ippXRSAn
	T6PAnCmtkIcyRPd4LHJKt6HjVn1l1KEih6m7TEXC3dRmhNEdp5AXSMuK3XKlhQ4Pxgf1XL
	oRuqmcizPLC5mi5jLu5Y5sNJXc+811MSMb71zZ+2S/BbLnCWQzZDkpAP0W1Al6Vxs4bToJ
	+Nju6QByKk5wNKIxSoyb0uCEn+6EZ3gBQF1Z1lg6pKAIGVaFBlDSvD6Gs+lsxQ==
Date: Wed, 5 Nov 2025 12:19:47 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip104-rt58
Message-ID: <aQsy08U/g/BBrhZo@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hJ5iSX2EfDddFGQE"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 11:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20360


--hJ5iSX2EfDddFGQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.4.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hJ5iSX2EfDddFGQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQsy0wAKCRAw5/Bqldv6
8rz5AKC0A6RnWJPR4NNWwW0yIbsKZG1PDgCfXSRAFdQQ+3daswhr1fuOzeq3Wcw=
=qa1n
-----END PGP SIGNATURE-----

--hJ5iSX2EfDddFGQE--

