Return-Path: <SRS0=qBpK=5W=lists.cip-project.org=bounce+64572+4556+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C3CC2BA1A
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:51:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0729120768
	for <cip-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SbQKxOwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0729120768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4556+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IhIsYY4521723xkrBKqjFljr; Mon, 06 Apr 2020 15:51:09 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.80.1586213042041937438
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Apr 2020 15:44:03 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 394EA1C484C; Tue,  7 Apr 2020 00:43:59 +0200 (CEST)
Date: Tue, 7 Apr 2020 00:43:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: cip-board@lists.cip-project.org, cip-members@lists.cip-project.org,
	cip-security@lists.cip-project.org
Subject: Re: [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
Message-ID: <20200406224358.GC14162@amd.ucw.cz>
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hzNnY1LabVSPxzfDvhkT0Omwx4520388AA=
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1586213469;
 bh=rGLJfmgC11o2TynzkJy3HL3sZYok/aeiVX4nARDO9H0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SbQKxOwLHdhBL3CUzso8Ik0gNrwjsn8rOtapda2Ld9a2sDE7nWMMDI6OICWB/r5a1ax
 XQHWyLVUEGDaq7Ef2ejQF7yy82yuVUm1CJ+OmVCKaucyuysZu/8e5JIEBTgis8PWbrb4H
 tfYVnzFxxwAe6h5uGMmSzpxBKlgO8q+1k+I=

--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The migration is complete.
>=20
> You should receive an email shortly asking you to log in with your email
> address and set a password.
>=20
> One important note, please do NOT unsubscribe from the "main" list. This
> would unsubscribe you from all of the CIP lists. "main" is an
> administrative list used by Groups.io as a parent list to manage the oth=
er
> lists. Please let me know if you have any questions or issues.

And we have first problem.

>=20

They seem to add this kind of trailer to the messages, breaking GPG
signatures :-(.

(I won't quote full trailer as it seems to contain some secrets?)

	=09	=09	=09   =09	Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4556): https://lists.cip-project.org/g/cip-dev/message=
/4556
Mute This Topic: https://lists.cip-project.org/mt/72837893/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXouwrgAKCRAw5/Bqldv6
8uwkAJ4vqFz3JJsUq0N3XwtpBAhiP/3CMQCeKS60UDsWsXVSySax+Icnq4oD/qQ=
=fOOg
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
