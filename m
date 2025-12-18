Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64EDD6E2DD
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 18:57:33 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1524.1766084252899203854
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 10:57:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=WmEqNWFN;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 054E710092114;
	Thu, 18 Dec 2025 19:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1766084250; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=dW9gsH45JViJrKKpuIMZ8w640llZTcpOgIu8wIOt86w=;
	b=WmEqNWFNvliqsN8gtPn1vK1OJ6rxnvENlGJ3qfpCkF0jGjYKKTw5ztBFlf8NSW3yA3WzFQ
	kdcb6c4Ofs+ajFngQ40/BIsTsgUvpW4KiXJLJ0oLjMdOFIvSbe/Pvx3WqNug80FwbcN9Sk
	ZLdcnc5ou0h9rLHPgFOeLQyigC5wCuNuVOTY7OcHLB8kZWFd4rICMCHaJVLgkW7c491t+V
	QgLo5GGeJJdpzQMjoED3HQWNpZK8gQTJJQNYwXDHCl7CufiGCTfI/DdpvBXmUdXEvhF5TE
	AZItMuZIY5rhZLlljsKqOn1vZ4asA6TAtvu93j3JwI5u8/8luIXRqWkgT9uEnw==
Date: Thu, 18 Dec 2025 19:57:26 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.19.325-cip126-rt45
Message-ID: <aUROloZ6XG9t6DDS@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A7e4F9gB+/mm7+uE"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 18:57:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21163


--A7e4F9gB+/mm7+uE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

During creation of 4.19.325-cip126-rt45, there was conflict between
changes in -cip126 and the realtime tree. Essentially -rt rewrote
cgroup handling in commit 8990cf9c6a "cgroups: use simple wait in
css_release()" while -cip now contains commit 79f919a89c "cgroup:
split cgroup_destroy_wq into 3 workqueues". We currently don't know
how to fix the conflict (or how to test the result), so we reverted
79f919a89c in the 4.19.325-cip126-rt45. 79f919a89c is also known as
CVE-2025-39953.

If you are using cgroups with realtime tree, or want to help
debug/test/fix this, let me know.

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--A7e4F9gB+/mm7+uE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaUROlgAKCRAw5/Bqldv6
8icaAKCcPfxpD6Qn1Tr6sWYpf+I4qfH4/QCePZOGM4w3tA6Xd3UPFTpxQEsUqhE=
=0QP5
-----END PGP SIGNATURE-----

--A7e4F9gB+/mm7+uE--

