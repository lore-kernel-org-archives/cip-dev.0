Return-Path: <SRS0=p7oW=5X=lists.cip-project.org=bounce+64572+4562+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ADFC2BB54
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 11:36:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F332063A
	for <cip-dev@archiver.kernel.org>; Tue,  7 Apr 2020 11:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jVMVu3zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F332063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4562+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TJ74YY4521723xV7PHsdd7w7; Tue, 07 Apr 2020 04:36:00 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4733.1586243358204114770
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2020 00:09:19 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 250F11C4A48; Tue,  7 Apr 2020 09:09:15 +0200 (CEST)
Date: Tue, 7 Apr 2020 09:09:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, cip-board@lists.cip-project.org,
	cip-members@lists.cip-project.org,
	cip-security@lists.cip-project.org
Subject: Re: [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
Message-ID: <20200407070914.GA17953@amd.ucw.cz>
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
 <20200406224358.GC14162@amd.ucw.cz>
 <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
In-Reply-To: <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YlNXmT4GNrNiDxbpdFWniFJMx4520388AA=
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586259360;
 bh=HvnsVwrVJQ9tDJs7kSyVxf3vU0vWJao6JfJdM+au7UM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jVMVu3zs2chEHpdUNY/b/vXE9vFEjHzTKLaBMzZ/h8FtQcn25o5MAU/WnxqnGZnfaTp
 WTqeRoNdalgDQfWNoomvrQdtUMUulRAK2d1htSTwjeBwYazd8nH8TLBjWb/xr9QUcAfZ0
 0YaQ85bj8bJhtObDx6tqx7UP2bg6Ty6rGrQ=

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > They seem to add this kind of trailer to the messages, breaking GPG
> > signatures :-(.
> >
> > (I won't quote full trailer as it seems to contain some secrets?)
>=20
> I wonder if it's possible to turn these off by the admin.
>=20
> Also, another thing to test is the impact of the footer on applying
> patches sent via email (git am / git apply).

I suspect footer won't cause problems with patches; there are many
lists that add such footers, and patches normally survive that okay.

But our project is quite security-focused, so it would be good to
preserve GPG signatures...

Best regards,
	=09	=09	=09	=09	Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/bl=
og.html

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4562): https://lists.cip-project.org/g/cip-dev/message=
/4562
Mute This Topic: https://lists.cip-project.org/mt/72837893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXownGgAKCRAw5/Bqldv6
8hJCAJ0VagcpCj4mufmdBvwJ2IiHlzPlCQCgnGaS2Mx28OJInHtHhP4uUuyPqBs=
=7jed
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
