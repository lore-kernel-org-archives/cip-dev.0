Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4FAC43458
	for <webhook@archiver.kernel.org>; Mon, 13 Jul 2026 09:10:09 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7100.1783933799646960732
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jul 2026 02:10:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cWUChB+n;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B7AA1199B6;
	Mon, 13 Jul 2026 11:09:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1783933796; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=oqYw9MqrVqgI3uSW0CM3XvJ3YLa1RGiB3MIe5TQzqvI=;
	b=cWUChB+n80S5CQFqDcZw37OR+Ib3en+wBiqVIXygWLSRQAHAp6x3251HtmQjZ0WtDDTJ6s
	KB6B4HjenTV+jCPl+GFpRNhTslZMJDOybmi1joScqepH+SMnxCsPqOvKUIxCWpXA2NpdOg
	Hc98jHEB8H7+t/fKtGvBeLDRgSjAto++M/PRCtniYa7bSuLN/W5PFpsqHBlSMr1xCkkFI/
	WE9iByYlNo7xavzIlwq+yuxbFUyiLzlW/ueN+7CkBvwAbMXDNjNCt4pPfn4MvBWUuwHJ/A
	L4PF9Bmak5XN6JBoiTXGEvQa0S7vcUrxCC1gs6AjRjHmQtxOA+11PuEg1Wyq/g==
Date: Mon, 13 Jul 2026 11:09:53 +0200
From: Pavel Machek <pavel@nabladev.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.260-cip75-rt33
Message-ID: <alSrYfPw-acD7O-i@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F14rDmw2Vv86I2or"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jul 2026 09:10:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23560


--F14rDmw2Vv86I2or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel

--F14rDmw2Vv86I2or
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalSrYQAKCRAw5/Bqldv6
8jNLAJ49IOvbULPbrJBeF91PSOCkuvYTTACfXzsG1Xm6GbI6K7MgkPeqENevXW4=
=bUvR
-----END PGP SIGNATURE-----

--F14rDmw2Vv86I2or--

