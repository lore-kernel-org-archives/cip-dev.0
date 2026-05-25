Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B34CD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 10:26:44 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13256.1779704797154274048
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 03:26:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CKcstjFE;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 741DF1122F6;
	Mon, 25 May 2026 12:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779704794;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FJyc+qqYzLKjnA9Il135Ot4LiAMCm1yn0PcvoCMjze8=;
	b=CKcstjFEQzK8/mHSVp358sJ0tvOeLQAigo8AtyEgwwtcZOrOG/hI5jCch/TZOHDVgqwWQl
	ZwqmJAivX3rD525xKpA7Prhou2ICxaTvFuntRYzkf/IOl26kIwdwDygiuprDMZcmp/7iwr
	1hbTadQo5FdM+m/H2OJuARJVmBqTXo8VSz9T6mOHaIA7ZqU+CBeWqzE+23psbRcfwptEaz
	Be0jgUDwFBGdX7a7AGqvuwe6I9EqyOoAjxahCFKdJf1ZYWCOzNCSZ2xrlh74k2y+YsRAvo
	ZVRsyF+nlXI0canFE5sbsIAly6BKazsgTBtMRAMqboazaz7TlqkKdgJwq51FKg==
Date: Mon, 25 May 2026 12:26:33 +0200
From: Pavel Machek <pavel@nabladev.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, john.madieu@gmail.com
Subject: Re: [PATCH 6.12.y-cip] PCI: rzg3s-host: Revert generic field
 helpers, use a local field_prep()
Message-ID: <ahQj2ZBXKQh1MadU@duo.ucw.cz>
References: <20260525080034.3818992-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/6XyCZjpBEG0MAnl"
Content-Disposition: inline
In-Reply-To: <20260525080034.3818992-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 10:26:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23007


--/6XyCZjpBEG0MAnl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Commits 10566a8001e0 ("bitfield: Add non-constant field_{prep,get}()
> helpers") and 32b1a8f287d5 ("bitfield: Add less-checking
> __FIELD_{GET,PREP}()") introduced warnings, as other drivers already
> carry their own local implementations.
>=20
> Revert both and add a local helper instead:
>=20
>   #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))

Looks good to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply this if it passes testing and there are no other comments.

Best regards,
                                                                Pavel


--/6XyCZjpBEG0MAnl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahQj2QAKCRAw5/Bqldv6
8t1MAKCaDyubsKpn8rmA6xex7is1M29blACdHtgCPQvJQb5M/hkfK48rZKKRp0M=
=kpZl
-----END PGP SIGNATURE-----

--/6XyCZjpBEG0MAnl--

