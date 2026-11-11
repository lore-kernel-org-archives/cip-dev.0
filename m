Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3767.1794429870139287934
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 12:44:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=FdGlE4LF;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C0CD10E1C3;
	Wed, 11 Nov 2026 21:44:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794429863;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=e/WXR/LxS+UisbNKBhZJ21/QxAVXGQ+2gPrOl071TxU=;
	b=FdGlE4LFww6UISCrirBCwSQRQoDC5Xd0gl4H4x71nJPCNBXDya11fCCKX2X54ok6+abgxS
	9Opu4i8XJhwdMNdDXYHQchmAk1vyrzgbAhRJWNVlb4eDUTRTQAreZJ2Yk/wwNSgRzR9wJF
	DMgtYRtqSnyuoXquDSlAoElazPFXxXpZ1o4GVjPTdDFAcIK6lBGHAH9pqzJohPoNu1a8QC
	2JUZCxOPY0V/aQjzqu2vuafhtBZZG66oLIoR6Yv9+mQQ1DaLTc2mYuzG3KFtNwZToDvH6x
	BJXI0jJKFs7oKhDf+XLcBotwqXdnKFuS+BrrYdapDofLkkb/RVVaq03aSIaJtg==
Date: Wed, 11 Nov 2026 21:44:19 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [6.12.y-cip][PATCH v2] Add SECURITY.md for the CIP kernel
Message-ID: <avTTo3NICDkmFgEO@duo.ucw.cz>
References: <be8e94d0-45da-4f96-b60e-20b45c9f865c@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/QM5QDL9OFyN470a"
Content-Disposition: inline
In-Reply-To: <be8e94d0-45da-4f96-b60e-20b45c9f865c@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 20:44:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24766


--/QM5QDL9OFyN470a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This describes at which time which ares of the CIP kernel are handled by
> the CIP security team and how to report vulnerabilities to it. It
> furthermore state the this projects falls under the LF stewardship
> framework.
>=20
> As the original kernel documentation already contains a reporting guide,
> leave a note there which one applies to CIP kernels.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Okay, so poor reporter starts here...

[A--starting palce]
> @@ -3,6 +3,12 @@
>  Security bugs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +.. note::
> +
> +   If you identified a vulnerability that only affects a CIP kernel, ple=
ase
> +   instead follow the reporting process described in SECURITY.md that ca=
n be
> +   found in the top-level directory.
> +

Goes here:

> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 0000000000000..f39a0178338ee
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,37 @@
> +# Security Policy
> +
> +This project is supported under the Linux Foundation CRA stewardship fra=
mework,
> +as described at https://www.linuxfoundation.org/security. Security

I would not mind " " before ".", so that link can be clicked (here and else=
where).

> +vulnerabilities should be reported through the mechanisms described belo=
w,
> +which we will coordinate with our CRA steward. For actively exploited
> +vulnerabilities and severe incidents that may require CRA escalation, pl=
ease
> +use the project=E2=80=99s emergency security reporting mechanisms as
> appropriate.

=2E..and follows link

Sending an email to security@DOMAIN where DOMAIN is the domain of the
project/foundation. For example, Linux kernel security vulnerabilities
should be reported to security@kernel.org as described in the [[Linux
kernel security bugs page]]. In some cases, different email
address(es) other than =E2=80=9Csecurity=E2=80=9D will be recommended.

Link makered [[]] will send him straight back to [A--starting palce].

Well, problem does not arise if someone goes through whole SECURITY.md firs=
t.

> +## Security Context
> +
> +Open source software can be used in various contexts that may go far bey=
ond
> +what it was originally designed and also secured for. Therefore, we desc=
ribe
> +here what the CIP kernel maintenance is particularly covering and what i=
s out
> +of scope.
> +
> +Unlike the upstream kernel, the CIP kernel is maintained with the focus =
on
> +architectures and configurations defined by the CIP project members, see
> +https://gitlab.com/cip-project/cip-kernel/cip-kernel-config. Vulnerabili=
ties
> +found in code paths not covered this way are considered out of scope.
> +Furthermore, vulnerabilities that are affecting the upstream Linux kerne=
l as
> +well are in the responsibility of the kernel security team, see
> +https://www.kernel.org/doc/html/latest/process/security-bugs.html. In sc=
ope for
> +the CIP kernel are issues caused by patches not found in the correspondi=
ng
> +stable kernel (linux-6.12.y-cip vs. linux-6.12.y) or that are related to
> +missing backports after the corresponding stable kernel went end-of-life.
> +
> +## Reporting a Vulnerability
> +
> +Please DO NOT report any potential security vulnerability via a public c=
hannel
> +(mailing list, gitlab issue etc.). Instead, contact the CIP security tea=
m via
> +security@cip-project.org via email. Please provide a detailed descriptio=
n of
> +the issue, the steps to reproduce it, the affected versions and, if alre=
ady
> +available, a proposal for a fix. You should receive a response within 5 =
working
> +days. If the issue is confirmed as a vulnerability by us, we will reques=
t a
> +CVE, publish the fix and give credits for your report if desired. This p=
roject
> +follows a 90 day disclosure timeline.

AFAICT what we are saying here is that:

bugs in -cip backports in 5.10/6.1/6.12 -> security@cip-project.org
other bugs in -cip for 5.10/6.1/6.12 -> security@kernel.org
all the bugs in 4.4/4.19 -> security@cip-project.org

That means that SPARC bug in 4.4-cip, for example, goes to us.

Good news is, that we have CRA contact at linux foundation that can
help, if we need help. Ok.

I still believe we should publish GPG key for
security@cip-project.org. I know sharing private keys is usually
no-no, but that still seems better than potentially no encryption at
all.

I guess I'm ok with the patch.

Best regards,
								Pavel


--/QM5QDL9OFyN470a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavTTowAKCRAw5/Bqldv6
8nmHAKCJuSVaaRiv8FtVYFp0Aycng9HXiQCeKNu9+sdCp2xEOPczw+6FkjZR/hk=
=ZAOT
-----END PGP SIGNATURE-----

--/QM5QDL9OFyN470a--
