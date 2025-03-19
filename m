Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFDAC35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 19:40:29 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.3741.1742413222441570318
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 12:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dZacrn8k;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D892F101F63AE;
	Wed, 19 Mar 2025 20:40:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742413220; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=CP6koBk+V+2mLGOOwkHcHrt/rGWSbl3GsKy9km/2uIo=;
	b=dZacrn8kqcKgDIhVqQo8Hn1jUzxzH9/Tq6BrpCd2FmiRf0bjFb/XpZUsHW2Q/eiYqq50TN
	1EuzsfzqS9Yr3hffNbQ7XxEN8hKqMjj6/jRPkEfmfmo/Qijg2FpjnBuxSiRT7uHogWzB94
	Qt5rUIkPk89dv+8PBpXzK5T0TMf6rN1y76UJXH+/1KP4VD8d6xCSB8wgfy3gcyFK3Wdbdq
	JPCPo5U709GYFRWAq97xRXrgK94AWX60naU3gnoejPDm1VBE7ZSFh6ZFeRE4VyqMXDX6Fn
	qT2uo4Tw4PXCYH04VdfcDu6IC9gfEqVxdrP+7DYhnn1k8RVFpFpsRhiSK/jJqQ==
Date: Wed, 19 Mar 2025 20:40:14 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip118-rt41
Message-ID: <Z9sdniB0LsqGLeN0@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oszmdyk9TJcKqSM2"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 19:40:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18280


--oszmdyk9TJcKqSM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

This is first self-maintainance release for 4.19.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oszmdyk9TJcKqSM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9sdngAKCRAw5/Bqldv6
8tYlAJ9aQ8616BO/HthUwS+nxIuSvtX4swCfQ9eT7TfDE4E0y4/uS2/bgpUc/F4=
=nqds
-----END PGP SIGNATURE-----

--oszmdyk9TJcKqSM2--

