Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971F0C9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 21:15:39 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.458.1790198133084583765
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 14:15:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Lyl+xQ9X;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42989105ABF;
	Wed, 23 Sep 2026 23:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790198126;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3NTcmo5S3o9g3XcDcq6fFORwNazd0pLl6J6na9V/hvE=;
	b=Lyl+xQ9Xw+1roP4J9PXVf5PRCssnGqZsmoYxQ/8WYsH530wQFHo50JLMDeiTnfahLWFKWO
	VON7YGFfPMN7bOMKAgH6L1TjBV38EwNN39xa7viAPo6mqgCKAbCm8krd0URU6T9ioNmUrH
	nt5ytBODfOpenUULTFOG/5pAb1iXgXt3h3DcbK2V4p5F+HMr3vnAqshtTXuurb2rnLRRes
	4GKbq3oP+j7PLiRWtAAf69cNv2XtpavZ556vIFQdwI1N0BVuvxUjr0biRj1Fj3EeNOCOk1
	mh6EL2UgdI1tTuJ1lUfV+pZlZgAq8Z1I4vx8repjKF+v/fPz3e7fdH56yz73/A==
Date: Wed, 23 Sep 2026 23:15:22 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH] Add SECURITY.md for the CIP kernel
Message-ID: <arRBapEdmwCS7snS@duo.ucw.cz>
References: <a1cfc8d4-5fb7-4f75-9600-92ebd7dbbeda@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8qcfaSQxlz/8IQb"
Content-Disposition: inline
In-Reply-To: <a1cfc8d4-5fb7-4f75-9600-92ebd7dbbeda@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 21:15:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24282


--c8qcfaSQxlz/8IQb
Content-Type: text/plain; charset=us-ascii
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
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> First proposal. Please review and provide feedback. If we all agree,=20
> this should be merged into all CIP kernel branches.

So... latest kernel already has
Documentation/process/security-bugs.rst as an entry point for security
bugs. 6.1 and 5.10 have Documentation/admin-guide/security-bugs.rst .

security-bugs.rst tells people to basically do normal bug report,
Cc-ing security@kernel.org, avoiding mailing list cc. That will be
unencrypted email, and they offer up-to 7 to 14 days of embargo.

The "linux-distros" mailing list is mentioned there.

> +++ b/SECURITY.md
> @@ -0,0 +1,37 @@
> +# Security Policy
> +
> +This project is supported under the Linux Foundation CRA stewardship fra=
mework,
> +as described at https://www.linuxfoundation.org/security. Security
> +vulnerabilities should be reported through the mechanisms described belo=
w,
> +which we will coordinate with our CRA steward. For actively
> exploited

I don't believe all readers will know what "CRA" means in this
context. I'm not sure, for example, and knowledge will be even lower
for people outside EU.

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

Ok, so here's security@cip-project.org , and we make promises
different from what security@kernel.org promises (90 days vs. 7 days,
for example). I'd suggest adopting policy from security-bugs.rst with
different email address.

Plus there's cra-steward-something@linuxfoundation.org, I assume.

I guess I'm quite confused at this point, and whoever hit a security
problem is confused, too.

First, what do we people to do? My understaning is:

if bug is actively exploited:
       mail cra-steward-something@linuxfoundation.org
elif there's misconfigured gitlab, someone stolen my passwords, malware in =
the repositories:
       mail cra-steward-something@linuxfoundation.org
elif bug is in -cip specific code in kernel:
       mail security@cip-project.org
elif bug is in 4.4-cip or 4.19-cip:
       mail security@cip-project.org
elif bug is in 5.10-cip or newer:
       mail security@kernel.org
else:
       # there may be bugs in self-maintained kernels, in parts we
       # don't support, such as arch/s390x. What to do with those?
       # Can we document we just don't care? Or do we need to handle
       # them?
       mail security@cip-project.org

Does that make sense? We probably should include real address for
cra-steward-something@linuxfoundation.org here.

Best regards,
								Pavel

--c8qcfaSQxlz/8IQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCarRBagAKCRAw5/Bqldv6
8tL+AKCnifgjHFqqJ2jSFj5sciaM6rcjuwCfRln9ENEittuyQ70t21PsvKncIL0=
=myB3
-----END PGP SIGNATURE-----

--c8qcfaSQxlz/8IQb--

