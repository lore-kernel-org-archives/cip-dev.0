Return-Path: <SRS0=/7Ra=GH=lists.cip-project.org=bounce+64572+5994+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C622C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:23:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF8C2075E
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF8C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5994+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dV71YY4521723xult5G0hYc3; Mon, 04 Jan 2021 04:23:16 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.12794.1609762996153059223
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 04:23:16 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A46991C0B87; Mon,  4 Jan 2021 13:23:14 +0100 (CET)
Date: Mon, 4 Jan 2021 13:23:14 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings
Message-ID: <20210104122314.GB19121@duo.ucw.cz>
References: <20210104100452.7424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210104100452.7424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZrMqeioq2MNXRxLenkvRjgJfx4520388AA=
Content-Type: multipart/mixed; boundary="nYB4ysHB23plNO55Qz8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609762996;
 bh=onppt5aTlDRt4VfUSB3l1bwbLsh3aKWBBMT8Vzu84yk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SmxOxwRRB5NnxLXHJYaUPszO0gDwS3mLu5+Rv4QwNWwa4oMonHshrX6HhmURe1PwJLY
 QliaNnfSoKxKPCMAKi4AwMVl8lC/HhiqENARWCgirxZv3V4ruljTU6rsYdHmns4GH5bhT
 4P/vjtCcRoAAiwDlQh/0hKtc16O4VFMPGA8=

--nYB4ysHB23plNO55Qz8t
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch has been cherry picked from v5.11-rc2, note the DT nodes have
> been already added into CIP for r8a774e1 SoC, hence this single
> patch.

Looks good to me. I can	apply it to 4.19-cip if	there are no other
comments.

Best regards,
     								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/MIsgAKCRAw5/Bqldv6
8otnAJ9WcJJodIEUbX7y7UmEPPrzyJ0diQCfThaLi9Gjdt+u09/NvF6YFXgI+lw=
=hZOV
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--nYB4ysHB23plNO55Qz8t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5994): https://lists.cip-project.org/g/cip-dev/message=
/5994
Mute This Topic: https://lists.cip-project.org/mt/79421040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nYB4ysHB23plNO55Qz8t--
