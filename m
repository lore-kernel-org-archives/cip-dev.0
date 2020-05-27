Return-Path: <SRS0=KmoQ=7J=lists.cip-project.org=bounce+64572+4648+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF1C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 09:15:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C7920890
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 09:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Jez2W40C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C7920890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4648+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZnqLYY4521723xRywDa7QuRC; Wed, 27 May 2020 02:15:41 -0700
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.103])
 by mx.groups.io with SMTP id smtpd.web10.2490.1590570940035501375
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2020 02:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpjFewWxDuuXgvxracEOpFy1UtVPLMmss73T92THiccG5LNucod0BFaEqKPVc4cUPiGd9N12+rj1BRkaLPfem1UfkQATnCmCeNq85rVlQsUCeggK4nvdNMRxNKQlTbZHBOC4QmqXFTEHLU2ltZY0hESE0b9MaZKbbbYJBwID8eDmZcEQR+1EjJEqujMkcEgALliAyllYPa7k1BzGE5tVobv4QF9oh+8k4O3Aq4uYdimoYju0MzYblhfMM8XxubowGUFfw1e5BCh3tHkMY/IS6QxZoRnghra8OaGwvPfY8Z4t1Uz75ctxYgxagyvr2Udg9m30zdFYLVZl/97Q2Qf8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjkn+FlPp+QrsMmGrs6fflB8dNFsidOYMTmhI7H+Hw8=;
 b=ZKFC6IZz1OXl408Op+LjNu0xEPNTraZxwuRyq+pBrA757SdjQRLjuJoq30MpQ0Dmld/nb7SbXQLNf6vhprtVw6v2cSVdbDEVEdVSXwLPbp7EXxH8rWYoyjnoDQVVLgpvMxQwZDsw3ZAVMIg/5b0xdmg5iN0YJ+B6uce/Xeujt2rywYmuureSgggQu8+EP6zpv2xY6UodZt25Z/Dnl54H48JpLdCGRtnsmrKL3zYvm0t9u+dSKADr6JaAhQMeRlY7KWMmJpyPByRUWttnnfX98wM7g7sGzltsfUmZqfZH5+BsiWQgHU0WhH58h8any9JNunGLSbsrxp2Ui5o6YNjFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB4202.jpnprd01.prod.outlook.com (2603:1096:404:d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 09:15:35 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::d9d9:60fe:a138:6752%4]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 09:15:34 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
	<hiroshi.mine.vd@hitachi.com>
Subject: Re: [cip-dev] FW: Needs of security patches on reference platforms
Thread-Topic: FW: Needs of security patches on reference platforms
Thread-Index: AdYvCCtlcLXwbkOIQ0qYRTqGFX3KBwE+OHCQAADhioAAAFdc8A==
Date: Wed, 27 May 2020 09:15:34 +0000
Message-ID: 
 <TY2PR01MB4972ECA4D0B47CE664EFB2F8A0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB497299162A4205C540691913A0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TY2PR01MB497220F7BDB51660FF9B221FA0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <e6529e13-4bb7-1105-9bc8-f84bc0b3132f@siemens.com>
In-Reply-To: <e6529e13-4bb7-1105-9bc8-f84bc0b3132f@siemens.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 073b2ccb-bf58-4baa-6f4d-08d8021e8365
x-ms-traffictypediagnostic: TY2PR01MB4202:
x-microsoft-antispam-prvs: 
 <TY2PR01MB4202A731B6E2150AA1A0614EA0B10@TY2PR01MB4202.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 J0Mw1MCOJt6QcnzbH0TfsTFnpS2EZ/MhNRM49ephZBIYNNo/iW0p1plYlfxsavdCAyql+BGmnzOg+dfmD8qgLb3oR/8mpPfZZxUdJ7Ega9lng1z9vO0nlR3cjoYN53T5SLGleJVJy1sqe4TEkA3ZhvEI6hauOwZ12wlIRqB+r8lV0IIU8vp/NeQJgQLIImmcsPEC8O6ciMysVsDmGGG6qYSxS7YTSjaWCfPOSCkGQvZB7gJgECEdk6/NFbvl2l9xC9rvr5b5hTgPPOTshvMdXprnv0RMGbKiAsbBuhOrPjEaj0jw/p624J2pL/ayrgoWAKkc+8zVuLqO64fTgMXebQ==
x-ms-exchange-antispam-messagedata: 
 oUNy+RwK9KGfOKPjh4MwbRAxJI3QpdM2wvxSUdvQD0KSkQgFbWVFKh9AdhAAq09majQ9LcjfGBKzK/GdGF1vZzCSMau/dH1ILPc8W1txzpkh67w/Qqe6XY3MZ1J4GmOdqwwVdjKFi4XMITSarDOUjscnL+qh9e2tkzhToiaLG4y5x/EF07mEJ/DFHVSze2VqlGOVdHVuF5g4FryXPxTvyAzM3PB52wG9LYMCmll5XdGIyy1ykw2ofk7tWM46PDEVxEW3KNdMDB2DeuF8r6Qlbkq07/JFz/qCDesZW1vm1C6csEB0SbjOuB4UsN5pn0EmMTmxtN2vI2XyYCXvH2L5SKN1Fpq5k9nxZRXNFXeyxMx1SDONtGXE9Mi0AeVU21bB347qy2RwIltNoSsMBjFe7Rs9YEO+PGIA4OfAucV3NB6svgmQdFlzy4NosPC0bQlfdaMPrzWNAVDxCXWRhkFqX4WCLlq4+bpd9yf83ED/0GrTRzsTu/G+la3lsk22RAE/
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 073b2ccb-bf58-4baa-6f4d-08d8021e8365
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 09:15:34.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qExkbOSO4f2qW0OA0ep6xuPYbLgVxaxfDHNsiJ+WcaVuIkHxCbyEVzNqQG2fxFgH0WO0xG5J644la5drQGUFGPQuPbh5C0gu0q77SY5Qsi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4202
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8pYYeJiGgkOL3KFXJS4epYKmx4520388AA=
Content-Type: multipart/mixed; boundary="bEK4Mp5zCQcZrzSPY5an"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590570941;
 bh=V3aBMVY19A5JKRQEiIy22dSDxtM+eaQhl0rMOaFk+Z8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Jez2W40CT04mjvdyJx7SNLUE71mrcu1yswTvIpyZPhSctklkZCVwzAhYOcTsrEmGB1U
 BY5eDG4g7aqMooLy/ENwp+JiniJORnv4pIHsIlOFcUOA0sTJ11BcjP4geNg7S5ld1UpNV
 kXSDHOdyVhAeEXayaX4eAEVHXQZi8VUgvJo=

--bEK4Mp5zCQcZrzSPY5an
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi, Jan-san,

Thanks very much for your comments and pointers.

> Why did not stable pick them up? Because they require active backporting =
work to make them apply?

Can anybody from Kernel Team respond to this?

> >  a. CVE related to KVM SVM on x86,
(snip)
> That said, I'm not aware of active use on our side at this point, but I m=
ay not have the full overview, and I can't speak for other members.

Thanks for your comment.

CIP-Members,
Please speak up if you need this patch. Otherwise, we will *NOT* backport t=
he patch.

> >  b. XDP sockets enabled for Cyclone V
(snip)
> XDP plays an essential role in deterministic networking, thus is absolute=
ly an embedded thing as well. But that usually goes along with TSN, though =
it may not be limited to it.
> For the Cyclone V, you likely need to ask the config contributor for the =
concrete background.

Thanks for your comment and a pointer.

CIP-Members, (or maybe Mine-san?)
Please speak up if you use XDP on Cyclone V. Otherwise, we will *NOT* backp=
ort the patch.

Best regards,
--
M. Kudo

-----Original Message-----
From: Jan Kiszka <jan.kiszka@siemens.com>=20
Sent: Wednesday, May 27, 2020 5:56 PM
To: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B <masashi=
.kudo@cybertrust.co.jp>; cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: FW: Needs of security patches on reference platforms

Hi Kudo-san,

On 27.05.20 10:34, masashi.kudo@cybertrust.co.jp wrote:
> Hello, Jan-san,
>=20
> I wonder whether you can respond to the following query.
> If you know an appropriate person to answer the below, I would appreciate=
 it if you can point him/her.

Just CC me on the list. I'm not receiving all emails of the list directly.

>=20
> Best regards,
> --
> M. Kudo
>=20
> -----Original Message-----
> From: =1B$B9)F#!!2m;J!J=1B(BCTJ=1B$B!!=1B(BOSS=1B$B;v6H?d?J<<!K=1B(B=20
> Sent: Thursday, May 21, 2020 9:52 AM
> To: cip-dev@lists.cip-project.org
> Subject: Needs of security patches on reference platforms
>=20
> Hi, board owners,
> =20
> At the IRC meeting (May 14th), the following two security patches were di=
scussed.=20
>=20
>  a. CVE related to KVM SVM on x86,
>  b. XDP sockets enabled for Cyclone V
>=20
> They were recently ported to upstream, and we would like to decide whethe=
r they should be backported to CIP or not.

Why did not stable pick them up? Because they require active backporting wo=
rk to make them apply?

>=20
> Regarding a., SVM is for AMD CPUs only, so it might not actually be used.
> If it is the case, we would like to ignore this patch.

In general, KVM on AMD was surely a niche over the past years. Since Ryzen,=
 this changed again, also for embedded.

That said, I'm not aware of active use on our side at this point, but I may=
 not have the full overview, and I can't speak for other members.

>=20
> Regarding b., XDP (express data path) is used for network intensive workl=
oads to bypass certain parts of the network stack So, it may be used by big=
 tech / web stuff, not embedded.

XDP plays an essential role in deterministic networking, thus is absolutely=
 an embedded thing as well. But that usually goes along with TSN, though it=
 may not be limited to it.

For the Cyclone V, you likely need to ask the config contributor for the co=
ncrete background.

Jan

--
Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence Ce=
nter Embedded Linux

--bEK4Mp5zCQcZrzSPY5an
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4648): https://lists.cip-project.org/g/cip-dev/message=
/4648
Mute This Topic: https://lists.cip-project.org/mt/74496040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--bEK4Mp5zCQcZrzSPY5an--
