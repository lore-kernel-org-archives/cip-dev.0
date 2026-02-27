Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB8FD5320
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 09:37:09 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.91655.1772185025830527855
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Feb 2026 01:37:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HNDLFMQz;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A606103EDD;
	Fri, 27 Feb 2026 10:36:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772185022;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=v16QmeqrB0klm1OKHfrirJ6NOi/Qc3kJ8T5ns3Ayc/g=;
	b=HNDLFMQzlk7MfqBS4uO0eiwaKXLSuQp+pPKAJRlU65LDQEdjzpgPtRu/P3MnNHKIdgwk97
	WJD2IKybzn7U/mjUyYjDRadyUuA1lxB66ilU1+9pEHqTCbYg9HjWB+0APtfikimQO5YkyJ
	35aCyOMDL66DbbUpoTKupIGz5TGKnc1f+z55teL87EGleEqtZH/0CvmoBlSpId6MMHPwLP
	1a7xjlAu+g6YLL2wJZQn063xuYlXs9+wDbUC/N8Y46e86QL/4CqIF3ppgs4mXcrzWCZSl5
	tFC8j5dN28ZgeC4PEjXNcGfbQTFYVp4lXL/f0Cbqcprcju27eYWSzGqiEYbPjA==
Date: Fri, 27 Feb 2026 10:36:57 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 0/9] RZ/G2L SSI Improvements
Message-ID: <aaFluc2RTIQHJGP2@duo.ucw.cz>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="scczkXjoeXv0dHoc"
Content-Disposition: inline
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Feb 2026 09:37:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22022


--scczkXjoeXv0dHoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Add support for 24, 32 bit sample format width. Also fix
> channel swap issue.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--scczkXjoeXv0dHoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaFluQAKCRAw5/Bqldv6
8rDeAJ4rluQTTYP40zWEzfpwM6HnE2zmrwCgwiRFZO/NAusg+HeO0kTUWjti30c=
=14h4
-----END PGP SIGNATURE-----

--scczkXjoeXv0dHoc--

