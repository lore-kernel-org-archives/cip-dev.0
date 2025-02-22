Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E182C021B2
	for <webhook@archiver.kernel.org>; Sat, 22 Feb 2025 09:42:22 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.43558.1740217333913022014
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Feb 2025 01:42:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=OZn16iMN;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A17E10382D37;
	Sat, 22 Feb 2025 10:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740217331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FcDOPF+IOHTP8Zszlw+5Q1yQ4fD2yJTF+2USdZFRXkw=;
	b=OZn16iMNzQPZzvTBp1zg7l3LKqWtEPwd6LEXenP1K/IuZxde48G7htbRMG/H2PxCZZlc1K
	t8XFtzskUBVze+dxvHiTcYyYkSUE78m3pi9EvJR2TsU9uptCeLsEZw13pkNfQs06OBW0bg
	S5wl+ekF+5dG1/9mQiYtzQ+ga6nRlWAtqyv88bLzcxI2Y8AgLWASSZTkSYgsaBdWurJx4G
	jXXbMxYk/4E6+mMLFlBB/T3j75xNv6Rj3+YxKSTbTBz0S1l57CCVCrHy2Mc/Eatgq1cUNc
	czTwt+auD4+7ao3VamD3HlF9ihIzRLGHuCY5jmSasM89L9xDRYWbRzOQA/Z9ow==
Date: Sat, 22 Feb 2025 10:42:07 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Finn Thain <fthain@linux-m68k.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	linux-m68k@lists.linux-m68k.org
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] signal/m68k: Use
 force_sigsegv(SIGSEGV) in fpsp040_die
Message-ID: <Z7mb7+BXBDSD4a5G@duo.ucw.cz>
References: <72a512bd5463ee04f4840f49cee2f3c3@linux-m68k.org>
 <960544762.1079819.1739441787128@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sZ5btrWbNoOlMKR"
Content-Disposition: inline
In-Reply-To: <960544762.1079819.1739441787128@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Feb 2025 09:42:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17883


--6sZ5btrWbNoOlMKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Sorry, I saw these five minutes too late. Applied for the next release.

I guess these should go to 4.4-st, but I don't see them there. Did you
forget to push?

Best regards,
								Pavel

> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> >=20
> > [ Upstream commit a3616a3c02722d1edb95acc7fceade242f6553ba ]
> >=20
> > In the fpsp040 code when copyin or copyout fails call
> > force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).
> >=20
> > This solves a couple of problems.  Because do_exit embeds the ptrace
> > stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
> > that to work correctly.  There is always the information needed for a
> > ptrace stop where get_signal is called.  So exiting with a signal
> > solves the ptrace issue.
> >=20
> > Further exiting with a signal ensures that all of the threads in a
> > process are killed not just the thread that malfunctioned.  Which
> > avoids confusing userspace.
> >=20
> > To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
> > save all of the registers and jump to ret_from_exception (which
> > ultimately calls get_signal) after fpsp040_die returns.
> >=20
> > v2: Updated the branches to use gas's pseudo ops that automatically
> >     calculate the best branch instruction to use for the purpose.
> >=20
> > v1: https://lkml.kernel.org/r/87a6m8kgtx.fsf_-_@disp2133
> > Link: https://lkml.kernel.org/r/87tukghjfs.fsf_-_@disp2133
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > [ Pass 'current' to force_sigsegv() as was done prior to v5.3 ]
> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> >  arch/m68k/fpsp040/skeleton.S | 3 ++-
> >  arch/m68k/kernel/traps.c     | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
> > index 31a9c634c81e..081922c72daa 100644
> > --- a/arch/m68k/fpsp040/skeleton.S
> > +++ b/arch/m68k/fpsp040/skeleton.S
> > @@ -502,7 +502,8 @@ in_ea:
> >  	.section .fixup,"ax"
> >  	.even
> >  1:
> > -	jbra	fpsp040_die
> > +	jbsr	fpsp040_die
> > +	jbra	.Lnotkern
> > =20
> >  	.section __ex_table,"a"
> >  	.align	4
> > diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
> > index 35f706d836c5..c6f18dc5884b 100644
> > --- a/arch/m68k/kernel/traps.c
> > +++ b/arch/m68k/kernel/traps.c
> > @@ -1155,7 +1155,7 @@ asmlinkage void set_esp0(unsigned long ssp)
> >   */
> >  asmlinkage void fpsp040_die(void)
> >  {
> > -	do_exit(SIGSEGV);
> > +	force_sigsegv(SIGSEGV, current);
> >  }
> > =20
> >  #ifdef CONFIG_M68KFPU_EMU

>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17828): https://lists.cip-project.org/g/cip-dev/messa=
ge/17828
> Mute This Topic: https://lists.cip-project.org/mt/111159546/4520429
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129118/452042=
9/629823354/xyzzy [pavel@denx.de]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6sZ5btrWbNoOlMKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ7mb7wAKCRAw5/Bqldv6
8g0dAJsEGzwMUI7bRHyBHG9FKPfCY/B2YwCgjOa145RAANiVX0xZsMEFg2DIBDo=
=LeLN
-----END PGP SIGNATURE-----

--6sZ5btrWbNoOlMKR--

