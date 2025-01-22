Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F5C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 20:06:26 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.3626.1737576381270358866
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 12:06:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=QL9Ky8YC;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBD35104858BC
	for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 21:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737576379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JRuZ7K89mrZ3TmwkfFT7yob3LMTDZ1WuQdfVJBcHWI=;
	b=QL9Ky8YCEv5Hs/HvjSNblOxhzzjcMquI9OmcTJB6zptrPu9Z02huTJC9Q9iBILeNTLJl+7
	rhfi02az7XYdKxU94IozXD13elbQ9Kk7ncRnXleZT88XqILpDvnQ2jUbKTAK/xnH+1dOIX
	uToxo/nle98K6PsEgigKCwj1GTX5XghxbJurMqlNRT6jjAqR0t9jcnL3XchGnv3w6yd5YS
	wn5jNdlWv0WflgIP5kFEyXn9/YlP+PHJWoH2yFSTrKXbLTjsgTDS8YEWtua7O31xhIMb/E
	KUNj4b5n2yt6EeMy/VqTggG6R/DPVD+lAGtXUXUAgLyrr7ZMR2xd2/Pn9fcP5A==
Date: Wed, 22 Jan 2025 21:06:13 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <Z5FPtY4aUHqMoL4w@duo.ucw.cz>
References: <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz>
 <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AUeWypp4NJpcUk9T"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 20:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17598


--AUeWypp4NJpcUk9T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thank you very much for your feedback.

Sorry for the delays.


> > Ok, so you have a series that should fix the problem. Can you verify
> > that it indeed fixes the warning in your case then post the minimal
> > version of the patch here and to the realtime lists? No need for
> > series in submission format for now, just "this works for us".
>=20
> Yes, I have a (draft) series for 4.4-rt, but it is the same one as the at=
tachment
> in my previous post[1]. I attached the patches again in this post just in=
 case.
>=20
> * 0001 - 0015 : Backported from v4.14-rt patch set [2]
> * 0016 : A change picked up from diffs between v4.9[3] =3D> v4.14[4]
>=20
> (A patch for arm64[5] is missing because it requires dependency resolving=
 and
> does not affect my case (x86). I'll try to backport this as well if neede=
d.)
>=20
> I already confirmed that the repeated WARNINGs in unpin_current_cpu()
> do NOT occur in my x86 environments as I reported previously [5].

Ah, ok. So... this is the real fix, everything else is just a
preparation, right?

+++ b/mm/slub.c
@@ -1412,7 +1412,7 @@ static struct page *allocate_slab(struct kmem_cache *=
s, gfp_t flags, int node)
        if (gfpflags_allow_blocking(flags))
                enableirqs =3D true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-       if (system_state =3D=3D SYSTEM_RUNNING)
+       if (system_state > SYSTEM_BOOTING)
                enableirqs =3D true;
 #endif
        if (enableirqs)

But I'm not really comfortable applying this to our rt trees, without
it being applied to 5.10-rt and others.

+++ b/include/linux/kernel.h
@@ -481,9 +481,13 @@ extern int root_mountflags;

 extern bool early_boot_irqs_disabled;

-/* Values used for system_state */
+/*
+ * Values used for system_state. Ordering of the states must not be changed
+ * as code checks for <, <=3D, >, >=3D STATE.
+ */
 extern enum system_states {
        SYSTEM_BOOTING,
+       SYSTEM_SCHEDULING,
        SYSTEM_RUNNING,
        SYSTEM_HALT,
        SYSTEM_POWER_OFF,


So going through RT mailing list would be needed there.

> Do I need to send those information to the both cip-dev and RT mailing li=
st?
> Should I create a new thread or is it sufficient to add the RT list to CC?

New thread, I'd say, and it may take some effort to get that merged.

> It's true that the bug is present (the repeated WARNINGs occurs) in
> v4.4-rt .. v4.9-rt, but I cannot declare that the "bug" in v4.14-rt .. v5=
=2E10-rt
> because the WARNINGs never occurs after v4.14-rt (i.e. with the attached =
changes).
> The most important thing would be to know what the patch 0016
> intended.

=2E..that will not help.

Alternative, AFAICT, would be something like:

+++ b/mm/slub.c
@@ -1412,7 +1412,7 @@ static struct page *allocate_slab(struct kmem_cache *=
s, gfp_t flags, int node)
        if (gfpflags_allow_blocking(flags))
                enableirqs =3D true;
 #ifdef CONFIG_PREEMPT_RT_FULL
-       if (system_state =3D=3D SYSTEM_RUNNING)
+       if (system_is_scheduling)
                enableirqs =3D true;
 #endif
        if (enableirqs)

+++ b/init/main.c
@@ -412,6 +412,16 @@ static noinline void __init_refok rest_init(void)
        rcu_read_lock();
        kthreadd_task =3D find_task_by_pid_ns(pid, &init_pid_ns);
        rcu_read_unlock();
+
+       /*
+        * this corresponds to system_state =3D SYSTEM_SCHEDULING in mainli=
ne
+        */
+       system_is_scheduling =3D true;
+
        complete(&kthreadd_done);

        /*

Which is same thing but less intrusive, right? I'd like to see that
submitted to -rt lists, too, but it may be less scary.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AUeWypp4NJpcUk9T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5FPtQAKCRAw5/Bqldv6
8kf1AKCgF+YepdDMjObFV+mzzTbTgTuolACfcMKuxt4qhO5x5zDNuKfwn1FdYik=
=43uX
-----END PGP SIGNATURE-----

--AUeWypp4NJpcUk9T--

