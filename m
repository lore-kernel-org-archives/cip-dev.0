Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F41CA5FB3
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 10:17:21 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7700.1790849832569356606
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2026 03:17:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Waty7z7T;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 497381072D3;
	Thu, 01 Oct 2026 12:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790849826;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gA3+nkDizXiF08c4Xqw7U2J0vYacMW37BLnX33VSNNM=;
	b=Waty7z7T8D2pDJrBqnwqb+JMIS2It3Lh8FTfvJXb/twFsHopL4XLrEwNdQQYti1IpzRjD7
	hxh6TGS5SiGHGjoMROquHse79EN95RHSoCc4+JpnBuhOrqRyF5VC+fItGrryN49ffwa+5U
	82/kOcdBFA8r0F4YupGILsEVI+b9oN7woIMRDin0Gd71cs7CfCRLK2vk0cKRWbVcsX64EQ
	8xPOkFbPFiisigXvhSBfl2YQnwt8xgoejL7ERp/Jsfgk8yegGG5N+tG1q2AolbLuDtf74v
	vdM4cMdWtiC23cj8SC2x4F7NNjNj2FjQWQwUI1oMM/NNPC9BcoGM1FpQIN/xfQ==
Date: Thu, 1 Oct 2026 12:17:02 +0200
From: Pavel Machek <pavel@nabladev.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu
 properties
Message-ID: <ar4zHjT3PnfpYR62@duo.ucw.cz>
References: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K+tc563aHPflslFz"
Content-Disposition: inline
In-Reply-To: <20260930150941.597025-1-claudiu.beznea@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Oct 2026 10:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24393


--K+tc563aHPflslFz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Series backports the missing IOMMU properties for RZ/G2{E,H,N,M} SoCs.
> Without these, some boards fail to boot when CONFIG_MODULES=y and no
> other modules are enabled.

> Patches are present in v6.12 CIP.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--K+tc563aHPflslFz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCar4zHgAKCRAw5/Bqldv6
8tUqAKCFQdrRm9QWa49SnysNEqx2xHpAmACfZzTezE/vUbjIGJ3ZLj1/por/Bwk=
=ZKHQ
-----END PGP SIGNATURE-----

--K+tc563aHPflslFz--

