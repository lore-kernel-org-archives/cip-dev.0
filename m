Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521CFCC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 10:17:48 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36564.1792059463678778196
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2026 03:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dYsQtEHq;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17AAC104E32;
	Thu, 15 Oct 2026 12:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792059457; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=68KYSLmZncDzWG1r/ZZwcuYLf8tLRtQ+LVslVgJf1Ic=;
	b=dYsQtEHqhyJGtAPgkyNQWG5piyiUUvBq67WBTbyrNTohkZwBoGOSYuCPS4NHqubCmm/yXP
	Sj5IEeSg0V27zTCHE+pN6Jl7TM819Bho5mZenZqEYqsO4OJDNF8Z/iTrOWc0u9tKOWeyBP
	rgiuf0WPWoxVRIui27p4UwS6Qx201AKcvHR/X/vzJlnGjit9bD39oo46coTLUNDRya7Y6n
	lcLp5hUuUSdAM92xd6TVTMZ1YlPMh6tU8JBMLFDDQ+0PDbbnwlR9GsWSYbinqrpjX7m16s
	LHL5ht4YJUcsREWjgYL0ZbV+p3q0MqbBjRWxsxP0zIzN22zi9RGDVJpR0dSNyw==
Date: Thu, 15 Oct 2026 12:17:34 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v6.1.189-cip61-rt32
Message-ID: <atCoPkcisXbOVj7Z@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6jCCPvkjSoo98cjh"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 10:17:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24473


--6jCCPvkjSoo98cjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--6jCCPvkjSoo98cjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatCoPgAKCRAw5/Bqldv6
8vDtAKC0zm37GrghKyCypTKmRX47bluqWQCgqfTu+lks2VffEPOIjQHY12edT7Q=
=kkFC
-----END PGP SIGNATURE-----

--6jCCPvkjSoo98cjh--

