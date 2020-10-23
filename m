Return-Path: <SRS0=kGru=D6=lists.cip-project.org=bounce+64572+5668+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB600C388F9
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:46:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EBF2192A
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gAVF2yQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EBF2192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5668+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id h7X0YY4521723x9RfkxUmSpj; Fri, 23 Oct 2020 12:46:44 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.97])
 by mx.groups.io with SMTP id smtpd.web12.1975.1603482403094336531
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 12:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RigZ6+6uUJAZjm/WDPNf/PODvXphstdxnDWMncFQFPoYnxEZY3KztE3GVzwPFs8Odnef6q2orCVxcurb2KBZSwCyX0cT7HSY40bPeuCu2VILpjkZQbR2EehzNjYoTyG7302lb3DiT/MKvvi1vEW9q+8T1FhhgARjHUavZlT8Tpj+xT7BEt+LUzIfVMtr4DtWH/s3nz11Uj/eISYx+0nH/X/DKvISxUWLZfDWYwTa67XNaUjHZacw9r8+UA+gosy9CHCGmq0/l0AeIdqQCjOrhR608LQvon8lMnWlpH3kAuOL9Re5PG+gaPFxqxVxLlQ0xJoCGe0Z+1jSc7pyGGuirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDLozkMoGiATgqnfPPRTVcVUjExtMV5mLrH0jdT35Ps=;
 b=eYe5FkxZTxuRbS1V9tYGEBE5fe/QTmQ8DiMxDRp1cdtcjMzevpcOT0CxNngQlHnc9aRrO3eGkOb4au2bPoreZ5eHL3/j7pcpxGZH/vQS7BzF1K0nfJub7PL0k+99tzqwqdQwqgbHGWyRRqAc0RBOHtRfdGtOmuzLbkfpjV1k8yQL/o7EgvqSSVLVanvQxvQ20qkeRkz9RTn9be8oVCGyDq8Pa3i++ljCdUyUqL7ZSGxBur7MR3p9OkdVkKx/FY2ElF41GvuIXms1uLk1q1+emFi6p7Jkofs1fdgjk15VeympipYsCADhWroGU6oyUbB78VyfuVxjKwhuqmFu4gnK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB3574.jpnprd01.prod.outlook.com (2603:1096:604:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 23 Oct
 2020 19:46:38 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 19:46:38 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/6] Add PCIe EP driver to Renesas R-Car Gen3 and RZ/G2x
Thread-Topic: [PATCH 4.19.y-cip 0/6] Add PCIe EP driver to Renesas R-Car Gen3
 and RZ/G2x
Thread-Index: AQHWqXPVuG/zflr7XkeeKbzBAh4K06mll1UA
Date: Fri, 23 Oct 2020 19:46:37 +0000
Message-ID: 
 <OSBPR01MB5048BF5FEDA0B4A8ED45BF43AA1A0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023193634.GA6002@duo.ucw.cz>
In-Reply-To: <20201023193634.GA6002@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7660d4b6-c2d8-4bdb-b6c6-08d8778c5b42
x-ms-traffictypediagnostic: OSBPR01MB3574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB3574978ABAC483E405FD724DAA1A0@OSBPR01MB3574.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 HcKon8APpgaoZ4uMZaCkA11n9/P3jRVDFHHtqSTMEo3ljpND8Wn12GKb1QZBxrrtazTPk9IX1QFfisowEg3ZSObLhp0RzlHef6HE51NE/s8kFNoTCEbuNv/OiYbRNJFJ5VF25fdRNAS1815ECjPdEG8uP6f0NK3YyXA+NX4I2B8aVfuTvWYjbLnfc8nuHP/EqhDFSfRWr+iYsIUfRSpGpityRTm2DZVryNYAhA7pvXwK1lQeEYKwzzyT47EkLP1GI6MyHRdlJVhExjJfcXPGDegBZKjNDMKDQnx0fNkoAzTEOGCxpSnDf5E9aRizF8VH
x-ms-exchange-antispam-messagedata: 
 yj4G39ZBW9YWSb2nHV8DKkutx62GM/3HhwrO4CWSe+2hdP8go+O8TApwQ6YCMknKyAfJnfR7i/0FnOSomNpGoAZlQdzak0e9gOOO075RQCtDJdTft/TMwCI2rd1ktGG6wYXEQY2xEp9ITsOz0FLkQH9w0x8Eh9bams0OBYznZ0AmxMOEiuG/hqzCSZZV6+uqckdpKGr8eqVsYCWvO3csUQxBDaLjOsx9+dUVoSMCprta/YynIP7Mj+6jP+DLHIVwiUWNSo3ND+ZJaZncZDzimKAAsQrd/yVrtFX0bjtlKD4IAfMNYCa1Qg2bQJiTDZmBFRmnI3zl7eyinLICXC4IDJbSEX8Xz/iYRFKK/8nXvmsZ81tNOtmEvvuwGoWfk7y5uB/sBxlqdeJk7HkP1/HF2Y9fCBidekEj5/q6m6izIXMOqqPd00z8cTojR2mWHXPrsPyQay632uq4Uxv21MN6xZ4Vt8y9YaLlB/AQmANbWzIwleLkC4rwhlWIELFwkOnRVCoiyFt/MqbXpQoDMFXnvzlO8+HMKu0a9+r25ixqriEQtSUQ81VQB/tI/gFbu2tWLA1Qk0hvkCxYthp2PoVed+jjPWHqEHo1k25zKCMZ5snKhbwJwkhINKwQp/pD+GJj/WwwN091TPTdFdUyGNqpbQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7660d4b6-c2d8-4bdb-b6c6-08d8778c5b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 19:46:37.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36ZGZdVty+8DcDfwWXyL009tBJPH4ZnxUH9BOG9TjvDt0sHOE5FIZuRGVhPJY4BILszNvvqmaGAKF/q2fLmqu7yjSk/ifCl3zIhPh1bN5NT5Scp46lx2BhKoD/zXgzOH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3574
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SoTx5Y9kMymjwhj0ZrKVvBVFx4520388AA=
Content-Type: multipart/mixed; boundary="EvYVkr0Vprdq8tuzMgxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603482404;
 bh=HmxE7l2iDxsn7HrdlgqGgQk+hsoy7xI5Bg06jGeZEmE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=gAVF2yQ1YjzgpNRQoZ/e6c/XDvB2J9E3qFAM6NQi+HDg/H40ZE1o8Zc++BvYue/ewht
 Pi33vTK5QV3X4ADFRdcbZ3XZvRtemQjVF1cENjnfRvv1WvaT2T8N2TOG0S1XsKCIyFpPb
 wVmd1IpXOaUQs3kG3zB/azSSLgu2ueDP+A8=

--EvYVkr0Vprdq8tuzMgxy
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 23 October 2020 20:37
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 0/6] Add PCIe EP driver to Renesas R-Car G=
en3 and RZ/G2x
>=20
> Hi!
>=20
> > This patch series is part of RFC series [1] ("Add PCIe EP support for
> > Renesas R-Car Gen3 and RZ/G2x").
> >
> > * Patches 38-42 and 47 from the RFC are included in this series.
> > * Patch 1/6 (=3D=3D 38/50) now have changes to pcie-rcar-host.c driver =
which
> >   were dropped earlier in RFC series as per suggestion from Pavel.
> > * Rest of the patches are unchanged
> > * I have dropped patches 43-46 and 48 from the RFC series and will re-s=
end
> >   them once it hits the -rc (currently they are present in -next)
>=20
> Thanks, patches look good and CIP testing did not find any problems,
> so I applied them and pushed out.
>=20
Thank you.

> I'll have some additional comments, but those can be solved
> post-merge.
>=20
Ill get it sorted.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EvYVkr0Vprdq8tuzMgxy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5668): https://lists.cip-project.org/g/cip-dev/message=
/5668
Mute This Topic: https://lists.cip-project.org/mt/77756292/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--EvYVkr0Vprdq8tuzMgxy--
