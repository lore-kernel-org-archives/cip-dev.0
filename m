Return-Path: <SRS0=BaFl=E5=lists.cip-project.org=bounce+64572+5828+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC712C2D0E4
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:38:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CD020721
	for <cip-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nwTDS7nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CD020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5828+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wIAeYY4521723xEUC9mq9cdG; Mon, 23 Nov 2020 11:38:35 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.40616.1606160314520642959
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2020 11:38:34 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 009D51C0BA1; Mon, 23 Nov 2020 20:38:31 +0100 (CET)
Date: Mon, 23 Nov 2020 20:38:31 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/7] memory: add Renesas RPC-IF driver
Message-ID: <20201123193830.GB5619@amd>
References: <20201123120354.26413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201123120354.26413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201123120354.26413-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aymjq39tOuwlal255BMDwf8Zx4520388AA=
Content-Type: multipart/mixed; boundary="pLn5qgIHCCHnKBvu2tUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606160315;
 bh=kkZ3FufwGHd3eeOnbl8mdXiiQyWNXmmRNsu6PeC4oGE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nwTDS7numf5gDJ34XNoWf+qZLOm1qyLI5WYWt94GR7Wza1WTQKPW3B+Dgaq30qZYFx+
 9yrY/aTB76F9E+GkVl2XUY+MVhrztkuR82mamrf4At1phfoWqqtUF98SqPj8gQs8rbh2Z
 SWkeuXMKF/8OEUMwhkP4Cn9rwnX76GbRJjQ=

--pLn5qgIHCCHnKBvu2tUX
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> +int rpcif_manual_xfer(struct rpcif *rpc);
> +ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void =
*buf);
> +
> +#endif // __RENESAS_RPC_IF_H

Oh and I'd use normal C comment here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+8D7YACgkQMOfwapXb+vLVIgCgrwvIm9c7btTunj75LRurpmr7
p+kAmwePIbcmWnIolouBf0vIAjo2qXTr
=eMQj
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

--pLn5qgIHCCHnKBvu2tUX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5828): https://lists.cip-project.org/g/cip-dev/message=
/5828
Mute This Topic: https://lists.cip-project.org/mt/78451541/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pLn5qgIHCCHnKBvu2tUX--
