Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB1C433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 10:12:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.5579.1654251133662267866
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jun 2022 03:12:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 195A71C0B9B; Fri,  3 Jun 2022 12:12:10 +0200 (CEST)
Date: Fri, 3 Jun 2022 12:12:09 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Kernel hardening / security documentation
Message-ID: <20220603101209.GA27465@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 10:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8483


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Below is document about kernel security I have mentioned on the
irc. But looking at it some more, TSC might have been looking at
easier "turn this CONFIG on and this off" kind of hardening. I'll look
for those kind of suggestions, too.

Best regards,
								Pavel


---

Good and bad ideas w.r.t. kernel and security

Kernel tries to provide many security guarantees at different
levels. Still, some things are easier to guarantee than others, and
some security barriers are really important, while others... not so
much.

Kernel should be secure against remote attackers.

    And it reasonably is, when not, we get it fixed with high priority.

Kernel should protect itself and other users against local, non-priviledged=
 users.

    Tries, but attack surface is big.
    People don't care about DoS attacks much.
    =3D> Running untrusted code is a bad idea. Forkbomb is few characters i=
n sh.

Fast, out-of-order CPUs leak user data via timing side-channels. Those
CPUs should not process sensitive data. JITs can be used to extract the dat=
a.

    We can try to work around the problems and apply vendor-provided
    workarounds, but there are likely more problems in future. Similar
    bugs are hidden in CPU microarchitectures, and in particular
    Spectre workarounds are whack-a-mole and thus incomplete.
   =20
    Hyperthreading makes those attacks easier.
    =3D> Use suitable CPUs to process sensitive data.

    BPF is in-kernel JIT
    =3D> Don't use BPF, make sure it is disabled on your configurations.

Filesystems are complex, robustness against malformed filesystems is hard.

    Some filesystems try to be robust against filesystems corruption,
    and some don't even try. Some perform checks during mount, but
    that means that malicious device can work around them.

    =3D> Don't mount untrusted filesystems. If you have to, use simple and
    common filesystem. VFAT might be good choice.
   =20
Kernel should protect itself against local users with CAP_XX.

    Yes, there's capability system, and in theory capabilities should be se=
parated.
    =3D> Don't rely on that. Noone else does.

Some systems try to protect themselves against people with physical access.

    Laws of physics says it is impossible, but people can still try to
    make it more costly for the "attacker".
    =3D> Please don't rely on that.

Coredumps are useful for debugging, but random processes leaving files in c=
wd
may not be welcome

    Consider disabling coredumps, perhaps with RLIMIT_CORE=3D0.

    Consider putting all coredumps into single directory with /proc/sys/ker=
nel/core_pattern.

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYpneeQAKCRAw5/Bqldv6
8p9oAKCWb5CdFTjGe9jk/hLB5ALV2VM92wCbBA+wf/KBva2V2jnNRbeGiRbgunM=
=RDf5
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

