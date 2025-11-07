Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA93CCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 13:37:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11545.1762522644449823284
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 05:37:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=E8X9DAP3;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 68804103D145E;
	Fri,  7 Nov 2025 14:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1762522642; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=YSQtPbTZ8KLalTUuTJ3FvqJ/d6gp9noNc0nW1nzKeTA=;
	b=E8X9DAP34ofoOq2azyThonqOyD8Z8kg3f6nn+9wdq8ZbksgDxwRtmHVI0P6Zpf9/Yikfc6
	gnYwZ/e8rz7VkgI3iIaPyrDmHubnTJxlp+vepY3R9F2AKodGTQLTosJo/tiwfRiHLTaX6o
	9LIkx87q4bFUyKyPn432IoABDYeozV20zs2bBlwxFGZj+DEOLw901VADS65M7DShbxEHvT
	43XBgIublmjX4r3pyFVcAuHuJ5O5odpwFa9k5MAlQF9QyxRLOv53yBIRi6rDZp8XnRhttj
	gOIJaE2vho4O3PBDrHKo9IzQYayaw3RPOoT3e3559wYL+/dQxekchVCuv//x/g==
Date: Fri, 7 Nov 2025 14:37:19 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: [ANNOUNCE] v5.10.246-cip66-rt29 (rt140)
Message-ID: <aQ32D+zxGIDRvijW@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hMtLSu6VowXGXytj"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 13:37:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20473


--hMtLSu6VowXGXytj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-5.10.y-cip-rt-rebase

And their content should be identical. There are also tar archives, at:

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--hMtLSu6VowXGXytj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQ32DwAKCRAw5/Bqldv6
8nmGAJ4lnpmYTzMLoDVfVilqTSzMTfJbKgCeNUaVyQmK6unvI3m+lChb59uqqVM=
=vGmP
-----END PGP SIGNATURE-----

--hMtLSu6VowXGXytj--

