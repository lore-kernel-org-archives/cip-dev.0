Return-Path: <SRS0=tHzx=4L=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB1DC35666
	for <cip-dev@archiver.kernel.org>; Sun, 23 Feb 2020 20:21:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFEC206ED
	for <cip-dev@archiver.kernel.org>; Sun, 23 Feb 2020 20:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFEC206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 041A1862BC;
	Sun, 23 Feb 2020 20:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vMAAhM-471tf; Sun, 23 Feb 2020 20:21:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F4143841DA;
	Sun, 23 Feb 2020 20:21:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D84FAC0177;
	Sun, 23 Feb 2020 20:21:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B173DC0177
 for <cip-dev@lists.cip-project.org>; Sun, 23 Feb 2020 20:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC14220430
 for <cip-dev@lists.cip-project.org>; Sun, 23 Feb 2020 20:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CDj9GmgjTzEW for <cip-dev@lists.cip-project.org>;
 Sun, 23 Feb 2020 20:21:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by silver.osuosl.org (Postfix) with ESMTPS id 1F2A920414
 for <cip-dev@lists.cip-project.org>; Sun, 23 Feb 2020 20:21:25 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 9C7CE1C0370; Sun, 23 Feb 2020 21:21:23 +0100 (CET)
Date: Sun, 23 Feb 2020 21:21:23 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200223202123.GC24510@duo.ucw.cz>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
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
Content-Type: multipart/mixed; boundary="===============6807438811623803768=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============6807438811623803768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the second version of USB Type-C backport of RZ/G2E board, named
> Silicon Linux EK874. The first version was reviewed by Pavel Machek. All
> the modifications included in v2 were recommended by him.
>=20
> This patchset revolves around the following patch set from upstream:
> https://patchwork.kernel.org/cover/10969899/
>=20
> Unfortunately, the driver is using a slightly different version of the USB
> API. In upstream, the connection between the fwnode of the USB controller
> device tree node, that is the connector device tree node, and the USB
> peripheral device tree node is nicely done via some new function calls th=
at
> are basically some extensions to the graph traverse and graph discovery
> methods for the device tree parser. This is needed for role switch featur=
e.
>=20
> I tried to create the minimum set for the USB API extension and it should
> not affect at all the current behavior. All the modifications are additio=
ns
> and some rewritings of some of the current functions.
>=20
> I also backported some fixes where I have found them.

Series looks good to me. I submitted it to the test system:

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/120342056

If it passes and there are no other comments, I'll apply it.

Thanks and best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlLewwAKCRAw5/Bqldv6
8hG9AKCEcBBBkGxO/27S9b01uq8AqAjRRgCfWcAeM1vIZeUfTd8IfLs4HzrXPQA=
=tEEp
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

--===============6807438811623803768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============6807438811623803768==--
