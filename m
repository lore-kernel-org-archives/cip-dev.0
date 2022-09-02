Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E082C38145
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:58:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.4697.1662112681644160867
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:58:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 22ADB1C000B; Fri,  2 Sep 2022 11:57:59 +0200 (CEST)
Date: Fri, 2 Sep 2022 11:57:54 +0200
From: Pavel Machek <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: Realtime support for 5.10 on RISC-V -- not there
Message-ID: <20220902095754.GA18026@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:58:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9453


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In rt wiki, RISC-V is not listed as supported.=20

https://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch#Platforms_Test=
ed_and_in_Use_with_CONFIG_PREEMPT_RT

That may be outdated, but it does not have corresponding config option
in 5.10.

pavel@duo:~/cip/10$ grep -ri ARCH_SUPPORTS_RT arch/
arch/powerpc/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK=
_WORK
arch/arm/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
arch/x86/Kconfig:	select ARCH_SUPPORTS_RT
arch/arm64/Kconfig:	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_W=
ORK
arch/Kconfig:config ARCH_SUPPORTS_RT
pavel@duo:~/cip/10$

I do not think we can or want to support realtime on RISC-V at the
moment.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYxHTogAKCRAw5/Bqldv6
8lEPAKCHtOVGTSVPKheK85XruiqfIB9ZCwCfX+0pDTJIYE+a06DsCR6JTaE4/p0=
=J01A
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

