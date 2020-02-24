Return-Path: <SRS0=bfPH=4M=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F30C38BF9
	for <cip-dev@archiver.kernel.org>; Mon, 24 Feb 2020 21:30:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C15218AC
	for <cip-dev@archiver.kernel.org>; Mon, 24 Feb 2020 21:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C15218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8ADCA848AB;
	Mon, 24 Feb 2020 21:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyHNiZ-30M-Q; Mon, 24 Feb 2020 21:30:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E55E284A0D;
	Mon, 24 Feb 2020 21:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5222C0177;
	Mon, 24 Feb 2020 21:30:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC487C0177
 for <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2020 21:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDDDF20242
 for <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2020 21:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l46gKLXqQY5F for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2020 21:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 373A220131
 for <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2020 21:30:01 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 2AC171C2103; Mon, 24 Feb 2020 22:29:57 +0100 (CET)
Date: Mon, 24 Feb 2020 22:29:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Message-ID: <20200224212956.GA7452@duo.ucw.cz>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200223202123.GC24510@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200223202123.GC24510@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH v2 4.19.y-cip 00/22] Renesas RZ/G2E USB Type-C
 Backport
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7611164836461108766=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============7611164836461108766==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is the second version of USB Type-C backport of RZ/G2E board, named
> > Silicon Linux EK874. The first version was reviewed by Pavel Machek. All
> > the modifications included in v2 were recommended by him.
> >=20
> > This patchset revolves around the following patch set from upstream:
> > https://patchwork.kernel.org/cover/10969899/
> >=20
> > Unfortunately, the driver is using a slightly different version of the =
USB
> > API. In upstream, the connection between the fwnode of the USB controll=
er
> > device tree node, that is the connector device tree node, and the USB
> > peripheral device tree node is nicely done via some new function calls =
that
> > are basically some extensions to the graph traverse and graph discovery
> > methods for the device tree parser. This is needed for role switch feat=
ure.
> >=20
> > I tried to create the minimum set for the USB API extension and it shou=
ld
> > not affect at all the current behavior. All the modifications are addit=
ions
> > and some rewritings of some of the current functions.
> >=20
> > I also backported some fixes where I have found them.
>=20
> Series looks good to me. I submitted it to the test system:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/120342056
>=20
> If it passes and there are no other comments, I'll apply it.

Applied, thanks!
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlRAVAAKCRAw5/Bqldv6
8racAJ9T5O28MW9WqRrbtAqWgIYJzf2S2wCeKkMHP86S3QNDG+yVMbPOIjIwIbI=
=3DvW
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============7611164836461108766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============7611164836461108766==--
