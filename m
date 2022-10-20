Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737CDC4332F
	for <webhook@archiver.kernel.org>; Thu, 20 Oct 2022 16:08:57 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.11582.1666282128810731106
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Oct 2022 09:08:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5FC3F1C09D6; Thu, 20 Oct 2022 18:08:45 +0200 (CEST)
Date: Thu, 20 Oct 2022 18:08:44 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org, alice.ferrazzi@miraclelinux.com,
	Chris.Paterson2@renesas.com
Subject: KernelCI, gitlab testing notes
Message-ID: <20221020160844.GA19694@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Oct 2022 16:08:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9797


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

* 4.4 kernelci warnings

https://linux.kernelci.org/build/cip/branch/linux-4.4.y-cip/kernel/v4.4.302=
-cip70-98-g7f7838c92740f/

Thanks for pointer. This looks good. Most of warnings are
"net/ipv4/inet_hashtables.c:608:68: warning: suggest parentheses
around =E2=80=98+=E2=80=99 in operand of =E2=80=98&=E2=80=99 [-Wparentheses=
]" which is my fault and on
my TODO list.

* SMC QEMU x86-64

https://storage.kernelci.org/cip/linux-4.4.y-cip/v4.4.302-cip70-98-g7f7838c=
92740f/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qemu_x86_64.html

Ok, I'll need to know more about the config. Is it possible that qemu
runs paravirtualized -- KVM?

If yes, we are basically testing whatever hardware it happens to run
on. Not good.

If no... the "soft" cpu it runs on does not have those bugs.

* Understanding gitlab results

+https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3184699360

Ok, so what should I be looking at?

-----------------------------------
374All submitted tests were successful
375-----------------------------------
376------------------------------
377Job Summary
378------------------------------
379Job #763143 Finished. Job health: Complete. URL: https://lava.ciplatform=
=2Eorg/scheduler/job/763143
380Job #763147 Finished. Job health: Complete. URL: https://lava.ciplatform=
=2Eorg/scheduler/job/763147
382

I have see. "Job health: incomplete" and that indicated problems. I
see "All submitted tests were successful". I guess that's ok.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3141003858

Now that's pretty evil:

* 0_spectre-meltdown-checker-test.CVE-2018-12126 [fail]
266* 0_spectre-meltdown-checker-test.CVE-2018-3646 [pass]
=2E..
288-----------------------------------
289All submitted tests were successful
290-----------------------------------
291

First, make it stand out visually. [pass] =3D> [ok] and [fail] =3D>
[FAILURE] or something like that.

Second, saying all tests were successful (line 289) when there's
failure is ... confusing.

* LTP failures

I'm not sure where we run this or how. Anyway.

https://lava.ciplatform.org/scheduler/job/763461

I picked up one failure randomly, and that's config failure, not
kernel failure: utimensat01 1 TBROK: can't read /etc/sudoers

Not sure what is going there: quotactl01. Do we have quotas enabled?
syslog01 and friends is also failing. Is syslog configured correctly?

I guess best way would be to run ltp on 4.4-mainline, 4.4.302, 4.4-cip
and compare the results.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1FyjAAKCRAw5/Bqldv6
8q2sAKCSQgwV52NEAVY+8RNWXvV4XsuDVQCfetdqwmgIt8KnCd6pLWjOx3npM0U=
=VBje
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

