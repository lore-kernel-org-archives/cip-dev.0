Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDDC11D05
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 15:50:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00F32071E
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 15:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00F32071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADEA78742D;
	Thu, 20 Feb 2020 15:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hz5WSHqZFErr; Thu, 20 Feb 2020 15:50:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 24F6B86C1A;
	Thu, 20 Feb 2020 15:50:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C0E3C013E;
	Thu, 20 Feb 2020 15:50:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68C86C013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 15:50:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6490687E37
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 15:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJj55ZBIyKFp for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 15:50:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EE8B287E0B
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 15:50:21 +0000 (UTC)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id DD7651C0195; Thu, 20 Feb 2020 16:50:19 +0100 (CET)
Date: Thu, 20 Feb 2020 16:50:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <20200220155018.GB26735@duo.ucw.cz>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-18-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219081627.GE31996@amd>
 <OSAPR01MB5028AA819CCF2EF35A68E18AAE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB5028AA819CCF2EF35A68E18AAE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 17/23] usb: typec: add dependency
 for TYPEC_HD3SS3220
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
Content-Type: multipart/mixed; boundary="===============1238526569718157700=="
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>


--===============1238526569718157700==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On Tue 2020-02-18 14:05:14, Marian-Cristian Rotariu wrote:
> > > From: Mao Wenan <maowenan@huawei.com>
> > >
> > > commit da4b5d18dd949abdda7c8ea76c9483b5edd49616 upstream.
> > >
> > > If CONFIG_TYPEC_HD3SS3220=3Dy, CONFIG_USB_ROLE_SWITCH=3Dm, below
> > errors
> > > can be found:
> > > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
> > > hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
> > > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
> > > hd3ss3220.c:(.text+0x154): undefined reference to
> > `usb_role_switch_set_role'
> > > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
> > > hd3ss3220.c:(.text+0x294): undefined reference to
> > `usb_role_switch_set_role'
> > > hd3ss3220.c:(.text+0x2f4): undefined reference to
> > `usb_role_switch_set_role'
> > > hd3ss3220.c:(.text+0x348): undefined reference to
> > `usb_role_switch_set_role'
> > > hd3ss3220.c:(.text+0x390): undefined reference to
> > `usb_role_switch_set_role'
> > > drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
> > > hd3ss3220.c:(.text+0x5e8): undefined reference to
> > `fwnode_usb_role_switch_get'
> > > hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_pu=
t'
> > > make: *** [vmlinux] Error 1
> >=20
> > I guess it is okay here, but for more serious bugs it would be nice to =
merge
> > the buggy patch with a fix -- not to break bisect.
>=20
> I kind of forgot about bisect. I was mostly focused on keeping the origin=
al patches
> from upstream (in this case, it is more about the commit message as the f=
ix is trivial).
> I will send this patch in v2 also, since you mostly agreed with it. Pleas=
e let me know
> if otherwise.=20

This patch is okay.

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXk6qugAKCRAw5/Bqldv6
8gxJAJ0bMTmOf5XLhfDBZKskNNZ/cstevgCfUC4NYAGC67i7++Ob8+O+2Gl8NNg=
=D9q6
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--===============1238526569718157700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev

--===============1238526569718157700==--
