Return-Path: <SRS0=E4/+=CG=lists.cip-project.org=bounce+64572+5325+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3673C433E2
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:29:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3122075B
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 18:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="O8Q7b4RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3122075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5325+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LW4kYY4521723xgofQK4PFDc; Fri, 28 Aug 2020 11:29:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.974.1598639342095294073
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 11:29:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D99AC1C0B79; Fri, 28 Aug 2020 20:28:57 +0200 (CEST)
Date: Fri, 28 Aug 2020 20:28:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/30] Add iWave RZ/G1H basic board support
Message-ID: <20200828182857.GC10270@duo.ucw.cz>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZYExOQbetlOpztB8r2uI0n6Tx4520388AA=
Content-Type: multipart/mixed; boundary="5OBuMMHW3gvVmUfOfmHV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598639343;
 bh=2BEU4DPJVzi8EdhADq/v6/vKzTpj6qDrb/UUpk/8pTw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=O8Q7b4REvT2k9CmzeZEpkRuBcgwbE0/7Wpi/RvASvN6bnmFcovMjD4xiTYnPkRogNNb
 XXy+oJkpFOicAbX4xvtDnzSwxJurxRJleFl5dcm5Qm/apoxVUh9JHEzzrLMwwei1FkA3p
 A0dfNUK1JUZNuRlUovxI+13QxrK4oTXP29I=

--5OBuMMHW3gvVmUfOfmHV
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline

--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add basic support for iWave RZ/G1H platform based on
> r8a7742 SoC to 4.4.y-cip kernel. Most of the patches in this series
> are cherry-picked from mainline.

Series looks okay to me, I can apply it if there are no comments (and
if gitlab cooperates).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0lM6QAKCRAw5/Bqldv6
8n0hAJ9WtAd5Aj8MkqZrIRxFgcwzjf7jUwCghgOkaQJbgDrV97/FJZzhdX6FB0c=
=665S
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--

--5OBuMMHW3gvVmUfOfmHV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5325): https://lists.cip-project.org/g/cip-dev/message=
/5325
Mute This Topic: https://lists.cip-project.org/mt/76477073/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5OBuMMHW3gvVmUfOfmHV--
