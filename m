Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C699E7717F
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 12:36:30 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.18606.1734006988588918398
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Dec 2024 04:36:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bQKz196X;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90F32104858A1;
	Thu, 12 Dec 2024 13:36:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734006986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=LguZ8vDTLeRE3zvpnkRS9aT124BGlVg5ZtCCqa2t1po=;
	b=bQKz196XOKxdKqgqlqVs6lI5FFgP78e9KAXa3Xl1D8srBUBE7qalnhP8pj+xc5INxuw1AZ
	yz542rGXFwNXiDt2UserBFpQPoxftE8A9wlH2FUOVxYMiuJ3P5OIGwGWDEAPNuunkRUPjs
	uHduiejgZQVPs8ib1yuKdc0nbs4bmj3pd6N0zC5gR5lq235a5hw2ko/lo5fH/KbEhmV/o7
	5PyQBUULDCjpa/oLIfe0HG95Fpdt2bS+gsfhVs+CT44KcanFALLggHGIEmK9PMc6EQ1+co
	Hdn5vSDcUTrh/FJ1uXeOunVdwzjGlD9cCA8xwiKbjzZ0g1UWQe6LBKJEumEUTQ==
Date: Thu, 12 Dec 2024 13:36:22 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v4.4.302-cip94-rt52
Message-ID: <Z1rYxmxo35/OUe9I@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TzwKGMM/q/uTLpo0"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 12:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17416


--TzwKGMM/q/uTLpo0
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
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TzwKGMM/q/uTLpo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ1rYxgAKCRAw5/Bqldv6
8uu+AJ9KzO7us51Pbvru/NdfmFmKxj9AHwCfRozruNMEZsBLpDmFKJ8jbGT3P0c=
=jEqG
-----END PGP SIGNATURE-----

--TzwKGMM/q/uTLpo0--

