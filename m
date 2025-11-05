Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D3CCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 18:36:38 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16946.1762367795145048375
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 10:36:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Z1T5DjY7;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A2ED10398810;
	Wed,  5 Nov 2025 19:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762367792; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=zCCPuJeGUT733a8tnC0/3r/q/TqxKT9OCHcEpOqSRWc=;
	b=Z1T5DjY7QrWuyiNCAGD7DoTWf25w6MQU+Zu4oC7N5VbdxWkMn0X1QM/9MrAMu5/rLQwQRw
	OF6Ym5cTUuQRo4RweOb61OE6QjmnBiRncl/l3fLTB9cMRnG5XxIU0AJR/Vv5f9zyqbVOhk
	+/qOzMI9aVCvaLoqjmRM0Z2mehNy1tXNw4mVRrOFz4NDKljJyIIXS7mkBRLvdEfKZQyTZP
	BCLv+jR30LVYCZYug3x6BP2FRFbsdey9tIWpbhqE33geDoARS4vIC6r25r5hsd1YlpTUk0
	k4iaveob2+JpqXEohBQHu17MIY2z0pRSaHvoN8IVPqoUKNQeWUvZx3KUqP7BzQ==
Date: Wed, 5 Nov 2025 19:36:26 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [ANNOUNCE] v6.1.157-cip48
Message-ID: <aQuZKup+3SGfd1KE@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LSaPOXlgnMB0G1Z"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 18:36:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20365


--1LSaPOXlgnMB0G1Z
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
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1LSaPOXlgnMB0G1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQuZKgAKCRAw5/Bqldv6
8klFAJ9JDowf2qALkJqnPrUeaoZKTJbu0gCgh6zsgS4hRTNAuAeUI7KggsbGWHo=
=4hsb
-----END PGP SIGNATURE-----

--1LSaPOXlgnMB0G1Z--

