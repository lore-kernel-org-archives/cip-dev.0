Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E60C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 17:42:40 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.29313.1647279758832247895
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Mar 2022 10:42:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7109C1C0B82; Mon, 14 Mar 2022 18:42:34 +0100 (CET)
Date: Mon, 14 Mar 2022 18:42:33 +0100
From: Pavel Machek <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: Boot error on altera board
Message-ID: <20220314174233.GA990@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 17:42:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7722


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I got dhcp error on Altera board:

dhcp
=3D> dhcp
bootloader-commands: Wait for prompt ['=3D>', 'Resetting CPU', 'Must RESET =
board to recover', 'TIMEOUT', 'Retry count exceeded', 'Retry time exceeded;=
 starting again', 'ERROR: The remote end did not respond in time.', 'File n=
ot found', 'Bad Linux ARM64 Image magic!', 'Wrong Ramdisk Image Format', 'R=
amdisk image is corrupt or invalid', 'ERROR: Failed to allocate', 'TFTP err=
or: trying to overwrite reserved memory'] (timeout 00:05:02)
dhcp
ethernet@ff702000 Waiting for PHY auto negotiation to complete......... TIM=
EOUT !
Could not initialize PHY ethernet@ff702000
matched a bootloader error message: 'TIMEOUT' (3)
end: 2.4.3 bootloader-commands (duration 00:00:12) [common]
=2E..
InfrastructureError: The Infrastructure is not working
correctly. Please report this error to LAVA admins

https://lava.ciplatform.org/scheduler/job/647916

This was second attempt to run the test, let me try to re-run it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYi9+iQAKCRAw5/Bqldv6
8pzoAJ40/wcZb1ry8BhJkqk8HhVrZr5x1ACfWb86IFklAWqVRWseoHPxizfb/ys=
=Itgp
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

