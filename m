Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663D0FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 13:05:03 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20163.1777554295026072587
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Apr 2026 06:04:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=JyqI17Tz;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEB9A11507A
	for <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 15:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777554288; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=BTlmGJfSVUOEGENBjRUIkyzC71NW0AL2lEFJGgC3xn4=;
	b=JyqI17TzOVc7iuyvtUTOW2MrEY40w5G2psP2LDT+n5X3S8MQXdmUwtP+bhiyO3xKRegvve
	gYjL3WVxmiwksZXxeW/22TMUSYzPoE3Qet49TpjXHBPW7A2RIcxnuBAAsVOGajHBnb8alp
	c6Kb06lgsZ18kwpZNle/KyoxF+hCcKNkGhF/Gqb0bxfAe16t6RqckoBzW3jwk05VVS8vK5
	vwfxyGV9YSjo+mXQjK5nEWNjmClSz11VAxIHjfQRXTq1jlWGIPep5Ut5ldA4WOwhqMuXSk
	0RvWjEaCcrmP36AQTmV27wCOMDfhBcBf71pE7rZpxtim6tWLgmA8p9HGA4+n5w==
Date: Thu, 30 Apr 2026 15:04:44 +0200
From: Pavel Machek <pavel@nabladev.com>
To: cip-dev@lists.cip-project.org
Subject: CVE-2026-31431 aka "Copy fail" allows root exploit from local access
Message-ID: <afNTbMBYYVXVvTYF@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Te+SNS0zbJZROETg"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 13:05:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22831


--Te+SNS0zbJZROETg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Apparently there's new CVE with a name:

https://nvd.nist.gov/vuln/detail/CVE-2026-31431
https://xint.io/blog/copy-fail-linux-distributions

You may have already heard about it, or likely you'll hear about it,
soon, as it is widespread and easy to exploit for local users.

If you don't have local untrusted users, you don't need to do
anything urgently.

If you don't have CONFIG_CRYPTO_AUTHENC enabled, you are not
vulnerable and don't need to do anything. CRYPTO_AUTHENC is "Authenc:
Combined mode wrapper for IPsec. This is required for IPSec ESP
(XFRM_ESP)."

4.4-cip is not affected, other -cip branches are affected. If you are
running affected -cip branch, have CRYPTO_AUTHENC enabled, have local
untrusted users and have security requirements, you may want to
investigate immediately and let us know.

[This may be another reminder to disable config options you don't
strictly needed.]

Current plan is to release 6.12-cip, 6.1-cip, 5.10-cip and 4.19-cip
ahead of their normal schedule, followed by -cip-rt kernels.

If you believe you are affected by this bug, let us know.

Best regards,
								Pavel
--Te+SNS0zbJZROETg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafNTbAAKCRAw5/Bqldv6
8rklAKCWPoRHTAdg7l6wwTLpfsolGpRuCQCfXwtXcTC/UU6PI82lynxFxENXDLw=
=D14A
-----END PGP SIGNATURE-----

--Te+SNS0zbJZROETg--

