Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3336FCCA47C
	for <webhook@archiver.kernel.org>; Thu, 23 Jun 2022 18:13:36 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.397.1656008009962463688
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jun 2022 11:13:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B7A2A1C0C05; Thu, 23 Jun 2022 20:13:26 +0200 (CEST)
Date: Thu, 23 Jun 2022 20:13:25 +0200
From: Pavel Machek <pavel@denx.de>
To: alice.ferrazzi@miraclelinux.com, cip-dev@lists.cip-project.org
Subject: KernelCI reports
Message-ID: <20220623181325.GA747@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jun 2022 18:13:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8586


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First... what I am currently using for testing: gitlab; I simply watch
for green ticks there. It takes ~15 minutes to get results. Red cross
in compile stage is pretty sure sign of build error. Red cross in
testing means I need to look at the results, but it is pretty easy to
see "network timeout" or "board unavailable" problems, and mostly I
can just hit retry and get the green tick.

What wories me about gitlab is that we have single board for 4.4-st,
and just two for 4.4-cip.

Now, kernelci.

https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-06-23-1=
2.01.html

I got this link in the irc meeting:

https://linux.kernelci.org/job/cip/

Lets start with build results.

linux-5.10.y-cip      v5.10.121-cip9 bd24696dd7ad23517733728da675a00cd30739=
16 169 7 3

I click on "3" and get build error summary:

Errors Summary
2      arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3m
2	arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=E2=
=80=99

=2E..but those are not kernel problems, that's buildsystem incompatible
with config or something like that. Nothing for me to solve.

Let me go through more:

linux-4.19.y-cip	v4.19.246-cip75 38ce181ac6ca9f3decdd389cbfd0a38fecdb28c7  =
111 8 1
linux-4.19.y-cip	v4.19.245-cip74 0be9d6774be9b192bcea6fddada917ae3d22f22e  =
106 7 1
linux-4.19.y-cip-rt	v4.19.245-cip74-rt25 c80ee3077a4ce344cf1cffa23af767c9fd=
75d52c  181 16 6
linux-4.4.y-cip	v4.4.302-cip69-296-g52de9431d314 52de9431d314a28c4aa66d8f81=
144c9958c11168 164 18 5
linux-5.10.y-cip-rt	v5.10.109-cip5-rt4 b41186882eaf0137277045da13ea649577c4=
2c11 177 8 3
linux-5.10.y-cip	v5.10.112-cip6 c8f6747dcd02a8f87731c324f4bc37bd120a8982 18=
0 7 3
linux-4.19.y-cip	v4.19.239-cip72 fdf770b2db8080de95dcf74cc7547319034a4a56 0=
 0 120

That's 19 errors total + outlier of v4.19.239-cip72 with 120
errors. None of the 19 errors is real. KernelCI needs to fix their
configs/build environment.

120 errors are reported at https://linux.kernelci.org/build/cip/branch/linu=
x-4.19.y-cip/kernel/v4.19.239-cip72/ . Wow. Except that I don't see that ma=
ny errors there. I see lines such as

cm_x2xx_defconfig =E2=80=90 arm =E2=80=90 gcc-10  0 warnings 0 errors. When=
 I click for details I get "No test results found".

https://linux.kernelci.org/build/id/6266a495d40dfd0dacff948c/

Nothing for me to debug, either, agreed? So lets look at test results.

Branch	Kernel Commit Build Status	Test Results	Date
linux-5.10.y-cip      v5.10.121-cip9	bd24696dd7ad23517733728da675a00cd30739=
16 169 7 3  2457 256 21 2022-06-12

21 failures.

If I click that, I can see that most regressions (11) are at baseline
test plan. The machine that looks relevant to us is
qemu_arm64-virt-gicv2 defconfig+arm64-chromebook --

https://linux.kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kernel/v5.1=
0.121-cip9/plan/baseline/

New regression, last pass: v5.10.112-cip6

I get to
https://linux.kernelci.org/test/case/id/62a333452713980006a39c13/
which looks quite useful, it lists successful run and failed run,
v5.10.121-cip9 fails while v5.10.112-cip6 works.

Eventually I get to https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10=
=2E121-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2.html .

And sorry, no I don't see anything I could debug there. Did the docker
fail to start? Hmm. Lets compare it with the older results.

https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.112-cip6/arm64/defc=
onfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.h=
tml . Aha, 404. No comparison possible.=20

Lets try one more.

rk3399-gru-kevin defconfig+arm64-chromebook =E2=80=90 arm64 =E2=80=90 gcc-10

https://linux.kernelci.org/test/plan/id/62a337700aadba677da39bdd/

It gets me to:

https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.121-cip9/arm64/defc=
onfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html

I see some errors... Like missing firmware (not a kernel problem). At
the end there's "tpm-chip-is-online: fail" . Is that what I should be debug=
ging?

 1368 12:21:39.212881  /usr/bin/tpm2_getcap
  1369 12:21:39.251829  ERROR:sys:src/tss2-sys/api/Tss2_Sys_Execute.c:114:T=
ss2_Sys_ExecuteFinish() Unsupported device. The device is a TPM 1.2
   1370 12:21:39.261387  ERROR:esys:src/tss2-esys/api/Esys_GetCapability.c:=
307:Esys_GetCapability_Finish() Received a non-TPM Error
    1371 12:21:39.272254  ERROR:esys:src/tss2-esys/api/Esys_GetCapability.c=
:107:Esys_GetCapability() Esys Finish ErrorCode (0x00080001)
     1372 12:21:39.281854  ERROR: Esys_GetCapability(0x80001) - sys:Catch a=
ll for all errors not otherwise specified
      1373 12:21:39.285316  ERROR: Unable to run tpm2_getcap

Userland seems to say that it does not support this device. I guess I could=
 compare it with older boot?

https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.83-cip1-178-g2cf1d1=
2aab81/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html

Aha, no, could not, 404.

Now, let's go through Jan's
example. https://linux.kernelci.org/build/id/61fbabe0cb6f27a6ce5d6f03/logs/?
=2E Again, errors look like missconfigured build system, with

arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=E2=
=80=99

Full log https://storage.kernelci.org/stable-rc/linux-4.4.y/v4.4.302/arm/rp=
c_defconfig/gcc-10/logs gives 404.

I spent quite some time trying to click around to find an error I
could debug. I could not find one. All of above looks like kernelCI
configuration problems. Can they be fixed and/or filtered out?

Thanks and best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmK0rUQACgkQMOfwapXb+vKGswCgpVPVQpZPNEVixTgd1lsFFFHn
LTkAn3gYfJtfWV0+KEp2phOjMAAU48F7
=LZXE
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

