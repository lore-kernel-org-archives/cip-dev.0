Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23979C77B73
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 20:10:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1609.1682021407891058288
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Apr 2023 13:10:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 830FC1C0DED; Thu, 20 Apr 2023 22:10:04 +0200 (CEST)
Date: Thu, 20 Apr 2023 22:10:04 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: CVE-2023-0459: Spectre-v1 Usercopy Hardening was Re: [cip-dev] New
 CVE entries this week
Message-ID: <ZEGcHOWAk8S0zEBz@duo.ucw.cz>
References: <CAODzB9p6MuyqPJeiEpun8CDR9+ZJ9PHhhWG-wyM7f7C0d=krwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nG0PgOPwFuOtt7Bc"
Content-Disposition: inline
In-Reply-To: <CAODzB9p6MuyqPJeiEpun8CDR9+ZJ9PHhhWG-wyM7f7C0d=krwA@mail.gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 20:10:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11264


--nG0PgOPwFuOtt7Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2023-0459: Spectre-v1 Usercopy Hardening
>=20
> CVSS v3 score is not provided.
>=20
> Missing speculation barriers causes a leaking kernel memory.
> The 4.4 kernel _copy_from_user() implementation is different from
> 4.19 and later. So this patch can not be applied.
> It seems as if the 4.4 kernel needs some barrier to prevent
> speculation bug in other ways.

I have this, and it passes basic testing, but no good way to really
test it or asses performance impact.

    Attempt to fix CVE-2023-0459. Inspiration from
    e0fbff18bbcee4f07d46bee172803fad63f6f4dd, but we simply add the check
    to access_ok, as it is used in about gazillion places.

Best regards,
								Pavel

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uacc=
ess.h
index 829fa6d3e5611..ce45b6dcb6293 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -101,6 +101,7 @@ static inline void set_fs(mm_segment_t fs)
 		: "1" (__addr), "Ir" (size),				\
 		  "r" (current_thread_info()->addr_limit)		\
 		: "cc");						\
+	barrier_nospec();						\
 	flag;								\
 })
=20
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac6932bf1a016..ea1e4ef4a4d8e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -95,8 +95,11 @@ static inline bool __chk_range_not_ok(unsigned long addr=
, unsigned long size, un
  */
 #define access_ok(type, addr, size)					\
 ({									\
+	bool ret;							\
 	WARN_ON_IN_IRQ();						\
-	likely(!__range_not_ok(addr, size, user_addr_max()));		\
+	ret =3D likely(!__range_not_ok(addr, size, user_addr_max()));	\
+	barrier_nospec();						\
+	ret;								\
 })
=20
 /*
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index 0c5ef54fd4162..207ef2a20e485 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -9,6 +9,10 @@
=20
 struct task_struct;
=20
+#ifndef barrier_nospec
+# define barrier_nospec() do { } while (0)
+#endif
+
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 oth=
erwise
  * @index: array element index


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nG0PgOPwFuOtt7Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZEGcHAAKCRAw5/Bqldv6
8t9kAJ4zUd+XZBBbfEzNtOsrH+YJRQuhswCfa0leGRaPl/cqF4O2/XDsB822iYM=
=Biuh
-----END PGP SIGNATURE-----

--nG0PgOPwFuOtt7Bc--

