Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA1C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 21:33:00 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.55435.1643751179212374087
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Feb 2022 13:33:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 090D51C0B82; Tue,  1 Feb 2022 22:32:55 +0100 (CET)
Date: Tue, 1 Feb 2022 22:32:54 +0100
From: Pavel Machek <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Subject: 4.4.302 is going to be last 4.4 release
Message-ID: <20220201213254.GA3001@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 21:33:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7562


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Greg says:

# Message-Id: <20220201180822.148370751@linuxfoundation.org>
# Subject: [PATCH 4.4 00/25] 4.4.302-rc1 review
# ...
# NOTE!  This is the proposed LAST 4.4.y kernel release to happen under
# the rules of the normal stable kernel releases.  After this one, it will
# be marked End-Of-Life as it has been 6 years and you really should know
# better by now and have moved to a newer kernel tree.  After this one, no
# more security fixes will be backported and you will end up with an
# insecure system over time.
# ...
# Responses should be made by Thu, 03 Feb 2022 18:08:10 +0000.
# Anything received after that time might be too late.

(He sometimes releases kernels before the deadline).

We may want to make any announcements now or just after 4.4.302 is
released... so I guess we should start working on suitable wording.

Something like:

CIP project is committed to maintain 4.4.x kernel till January of 2027
[1]. We are maintaining -cip branch [2], that is stable kernel with about
1000 of patches to support our reference hardware [3] and -cip-rt
branch, with is merge of -rt and -cip trees.

If you for some reason need 4.4.x with bug and security fixes, and are
running similar hardware to our reference hardware (x86-64 and armv7),
-cip tree may be good base for that work. Testing of the -cip tree is
welcome, as is joining the CIP project.

[1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-4.4.y-cip-rt
[3] https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting=
/cipreferencehardware

?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYfmnBgAKCRAw5/Bqldv6
8oXPAKCSYT47wJzSQ//3/t/75PCTpQ+m7gCfShNALVOoLYrqCqSEbuSaC+g9xSM=
=OKWE
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

