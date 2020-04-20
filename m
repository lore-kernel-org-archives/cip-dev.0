Return-Path: <SRS0=tiQK=6E=lists.cip-project.org=bounce+64572+4584+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A0DC3815B
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 07:57:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91B121D79
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CZoFnTZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91B121D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4584+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MzKvYY4521723xTTaRXgRgDg; Mon, 20 Apr 2020 00:57:58 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1714.1587369476702217183
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 00:57:57 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EEC521C0192; Mon, 20 Apr 2020 09:57:52 +0200 (CEST)
Date: Mon, 20 Apr 2020 09:57:52 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.115-cip24-rt9
Message-ID: <20200420075752.GA18467@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sjR3USk1xNvDBDbKcBVUTO0Ix4520388AA=
Content-Type: multipart/mixed; boundary="W7g5FsBMiOMRkuQK7R3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587369478;
 bh=et0BDpl9QbCcBfiN8zNbg00JC/9j9PntaAGn9feZRVY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=CZoFnTZOt2f9RwHtUqt+vVTrOB8WhS4+BPB5d5oijH27+dqBV8IonGIzm/dTSZqbEtk
 F+FIrGL7OSwUJDZqSJnROFdN1B/4f1a9d1fjOHBAxiylzLx9gGDOqXxSd+CgZxuhRotWV
 h8niEDaDdrZp3t6azU3ts7lxaTRArz14cRc=

--W7g5FsBMiOMRkuQK7R3L
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.19.115-cip24-rt9 should be available at kernel.org.

de0-nano boot problem should be fixed in mainline, so we are now back
to zero realtime-specific patches in the CIP project.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXp1WAAAKCRAw5/Bqldv6
8v5dAKC2ts5ReyHwV7go32QksF3HZJkNxgCeNhGVagmfMTqRnHzbH8bMaq9PG8A=
=icIr
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--W7g5FsBMiOMRkuQK7R3L
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4584): https://lists.cip-project.org/g/cip-dev/message=
/4584
Mute This Topic: https://lists.cip-project.org/mt/73144859/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--W7g5FsBMiOMRkuQK7R3L--
