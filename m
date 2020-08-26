Return-Path: <SRS0=2T/k=CE=lists.cip-project.org=bounce+64572+5256+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198A3C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:25:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0C62071E
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 07:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="qC9Km+/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0C62071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5256+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id djfbYY4521723xRZ9PqJ9YO6; Wed, 26 Aug 2020 00:25:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.7668.1598426702754298045
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 00:25:03 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1F75D1C0BBC; Wed, 26 Aug 2020 09:24:58 +0200 (CEST)
Date: Wed, 26 Aug 2020 09:24:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] Everything failed in gitlab
Message-ID: <20200826072457.GA6645@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: s5uLss1tEdLJzV302iw5ITXyx4520388AA=
Content-Type: multipart/mixed; boundary="SnxjxbOwOE5Bp0awExRb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598426703;
 bh=xRjKPS4ZyPL3ggkEzsd6/NM6E/gF9aru6vpMjYNMXfM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=qC9Km+/XPAjJRYhEU20KoY4nDIvH+eUwtbU8O0CWYMg/EXLFEdCnunwjvHgDAKBgoNt
 M0zGHV7RQpwnOKxEDZ/RgEjh9zTLddWwUoxS6QxGRLht1dJC3txItt3yFQcNGrYQNEEkn
 cvAqzqvsGC7v4VQd014+LnjWzy26ava0n7k=

--SnxjxbOwOE5Bp0awExRb
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I tried submitting kernel for testing, and got "everything failed"
result after timeout. I believe something is wrong with testing:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/181945390

Any ideas?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9GDkkACgkQMOfwapXb+vKEMQCfW3rm+am7WpzBbCNyfZK6Maan
+zgAoJwjpthNkLz2chDoaUJoNCEgYu1e
=O3la
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--SnxjxbOwOE5Bp0awExRb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5256): https://lists.cip-project.org/g/cip-dev/message=
/5256
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SnxjxbOwOE5Bp0awExRb--
