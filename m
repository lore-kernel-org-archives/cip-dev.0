Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E214C3601B
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 11:24:01 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.11014.1743679432141829520
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Apr 2025 04:23:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=TnqRhgpt;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 790C61029837A;
	Thu,  3 Apr 2025 13:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743679429; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=QY3FEXoFeDKUgBjOtR9zQ9/AV+g6B/lrbDCbZkUaxJ4=;
	b=TnqRhgptUaAba9xdmPe4ScG3ZCSmEk8WTBMH8f7JvdAMu8qkXvGRc1WkLDKbA/ld22/ZF+
	58CnpWVGnshHhxe8N8TWE9zkSONfL+RT68h5SRwe4MRhvcPdjvwUWXKIdJCXkXZ1rTu77P
	cyc7Lvw/iX9VxPfEZkxKgS3nqnIG+DQkXTweIhRTVLIA5v2w+j75WjzAXn9JbppxTwm/GW
	W8Umg+JG4y6qQAKoHgkMUKJ6D8Nib3t/vCY2oTicsdbQ6jbUQ1/QuJo6x+wPH+8QkcxR06
	UN1yCSA8J8Q51iYz+zbQHC5BZQ9qTwxcuefnTR0CldmICzbjKbd/cY/EcVqfNw==
Date: Thu, 3 Apr 2025 13:23:43 +0200
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v6.1.132-cip40
Message-ID: <Z+5vv5Epq7oW0Dda@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cJhD/2hPMuH4e1mk"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Apr 2025 11:24:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18461


--cJhD/2hPMuH4e1mk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New -cip release should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-6.1.y-cip-rebase

And their content should be identical.

There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cJhD/2hPMuH4e1mk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+5vvwAKCRAw5/Bqldv6
8vqaAJwNvzg0G9CdorQGBV5G47xeVcL2bgCfb7GJJbcHgl7b4SINRp7u2M9/Cd0=
=0VVg
-----END PGP SIGNATURE-----

--cJhD/2hPMuH4e1mk--

