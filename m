Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F262CD6E57
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 10:44:42 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8453.1780569874191593582
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Jun 2026 03:44:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=i9dVZTl0;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3A2D115529;
	Thu,  4 Jun 2026 12:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1780569871;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EYEkPDc+lrIAZxWzcM7dx3ggjKGLKch1z0fmZHcWGOw=;
	b=i9dVZTl0GkFTL/vk22WGkcxMNSZxAsxBI0MWcw+KZGEg6cFpAZBAPWScj2zpMcekPDswNQ
	CeFd5lEorZwkHPBAKs7WSeINCwomeQ/lHUTuolxWoFr4shRK83gT9svqnzv0Ixe6QZytz+
	TaCNH0hIhbd4whKp9IVqkh8M6kUz1nXF5bhmg9TEzKs10nTN/iABXDrPCt63MF8XTZLIDx
	vxy408pdJmedxH2eNG4DJFXEfJFAIlR3mQvcFmPMonHeVgAXOhwZ28CTuM4LfxMgfPH/H6
	wfAnYTV7f44DdJoDrwOS1t0pyDmElkjJ1OPw6eVl3iWkCEQ7vS3jx/FvMjGZxw==
Date: Thu, 4 Jun 2026 12:44:28 +0200
From: Pavel Machek <pavel@nabladev.com>
To: lnasby@intwineconnect.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] v4.19.325-cip133 pipeline failure question
Message-ID: <aiFXDL7eCz-ClAVc@duo.ucw.cz>
References: <CAJ6VbX+9vr3_KsyK59Pr3Nv3g_Tr8yN=ZQ=F78NH_wYxNmoo1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UKgzsjROG6CA0TqJ"
Content-Disposition: inline
In-Reply-To: <CAJ6VbX+9vr3_KsyK59Pr3Nv3g_Tr8yN=ZQ=F78NH_wYxNmoo1w@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Jun 2026 10:44:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23044


--UKgzsjROG6CA0TqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I noticed that one of the tests in the pipeline for v4.19.325-cip133 shows
> a failure that seems non-trivial:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2558173750
>=20
> In particular, it seems like a handful of specific CVE-related tests are
> failing. Is this kernel considered stable for release though? It is
> quite

If you need to run 4.19, 4.19.325-cip133 is very good option.

Whether it is stable/secure enough for your usecase really depends on
your usecase, and it is up to you to evaluate. Start by taking a look
at "KNOWN-BUGS" file. If you are running shell server with untrusted
users (for example), well, that a) is a bad idea and b) certainly is
very bad idea with 4.19 kernel.

Below is generic document that may give you some hints.

Best regards,
								Pavel


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

io_uring is rather new and buggy

    https://www.phoronix.com/news/Linux-6.6-sysctl-IO_uring

Kernel config options for hardened kernel

Investigate:

CONFIG_X86_IOPL_IOPERM=3Dy

https://timesys.com/security/securing-your-linux-configuration-kernel-harde=
ning/

RETPOLINE=3DY
DEVMEM=3Dis not set
PAGE_POISONING=3DY , enable withpage_poison=3D1
GCC_PLUGIN_STACKLEAK=3DY
DEBUG_BUGVERBOSE=3Dis not set , kind of security by obscurity, but may make=
 attackers work harder; will also make your own debugging harder, so..
ARCH_HAS_ELF_RANDOMIZE=3DY
INIT_ON_FREE_DEFAULT_ON=3DY
INIT_ON_ALLOC_DEFAULT_ON=3DY
DEBUG_VIRTUAL=3DY


https://github.com/a13xp0p0v/kconfig-hardened-check ?

Unloading modules is hard and rarely used.

--UKgzsjROG6CA0TqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaiFXDAAKCRAw5/Bqldv6
8vSqAJ0WjuNP/VJCX5um2tUXWoHxP5RqfACgiOvBjH/0ECayflXjI5B4eAHK7Lw=
=ZSR8
-----END PGP SIGNATURE-----

--UKgzsjROG6CA0TqJ--

