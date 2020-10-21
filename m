Return-Path: <SRS0=/eVB=D4=lists.cip-project.org=bounce+64572+5637+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B58C388F9
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 20:28:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309CE21D6C
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 20:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GYU+5qmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309CE21D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5637+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id b1L4YY4521723xOg8qCfgsvE; Wed, 21 Oct 2020 13:28:20 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.119])
 by mx.groups.io with SMTP id smtpd.web12.29.1603312099425782656
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 13:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvQrJ/KkzjaD8Q+G9ngnW4yAPfSuqGmtuoYBvcHhLeFITEt6Hf0TdO7dFSeSFLxZD/CeDhwiixevHeh0koUXeIBoG20zIdFrLMVZWxR14FF5bS9dtK/XPQNf2N9pQyGwIrf4Ket/b1GmB//kPOJfphnHu8YHCplKeG8mUhwRulKOzXNcMUUiBoy39d13qastYifKDSIaCVnmDJYWfnqSJHIju0Hv42pVwiIoeL3EuGt58DcUH2iosRwgNSRjYVNq3XqDA2KBAziuFOTyv5GOKwON3Ag0m3c/+cr3olvUgbrMLgGI0iGXqNSQYQhx1QjRdne8UVZstjzl1zw7N7YRpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84EfL3QbifHI4D/T/UF7n4vpCuEILHUjVNuCuGwXTDQ=;
 b=EYuGHJ2ne7MHu02OqnGWG0RPXYOfpldEtddYVJMu7XzKDkDrc4pB1zzNoYTnDbnBhP0U8hHKjUCwpG1KsVztrn85JuxBwRAftWgoFE2ctqzfifAiyRa1vd3LQTkuGvJTwvNFv5aqo0+7JnBK7JzCAL0Pl338nE8ckJqV0C3KtnHx00F+KJ94ofXqwqF96ApPFo7NWWiWMi1+eQ/mXHfwj79oZLT6uruQltr8Sb5tly97yKeliW1KnYvzU0oU0qNfYlLviVo2hN+MXApgwCuREUa0itTCCPVQUuaCIsVeG5dY+nrMV4ILNBcUyJWDyE6m4rQeXS9NwDYlKaOQNJEwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com (2603:1096:604:38::10)
 by OSBPR01MB2520.jpnprd01.prod.outlook.com (2603:1096:604:1f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 20:28:15 +0000
X-Received: from OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70]) by OSBPR01MB5048.jpnprd01.prod.outlook.com
 ([fe80::18f:c7ea:e9e4:db70%3]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 20:28:15 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 38/50] PCI: rcar: Move shareable code to a common file
Thread-Topic: [RFC PATCH 4.19.y-cip 38/50] PCI: rcar: Move shareable code to a
 common file
Thread-Index: AQHWoKLZqF0hXIlV6kmWVoC7NvgPKamieV+AgAAToWA=
Date: Wed, 21 Oct 2020 20:28:14 +0000
Message-ID: 
 <OSBPR01MB50481EEBB85828E725126E51AA1C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-39-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201021190647.GC10468@duo.ucw.cz>
In-Reply-To: <20201021190647.GC10468@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f7efaea-8fa8-484f-0bec-08d875ffd6a4
x-ms-traffictypediagnostic: OSBPR01MB2520:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSBPR01MB252068D490D8317994F9F3F4AA1C0@OSBPR01MB2520.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 Re1UJ93ECB/cR+KotEcHbf3ssbD9dkOyReQsGbKj/OoDIllK6vGF9XObYAU4PyAHi5A9AcrvtxILTazxD7K/fw+Af8QU6CuWWzm/DlF24CRuhEXzneNV/x3fdmQr4OV8QPqPATnbaJKU+W4MQ8xNv0qF/IUD/lA/UBZf5dB0TC1ySgpLqMvnnOgyKxTGbqgG5gSZRzsgZZJbm3H+SmhK+I3etzumq34MlPjNLyJnfGY+TkoGiSPevrETZw7PI33ZzEbNGnpo7eqp9pPfsUvGKTQoRJCPWxfWMd16nweR7deB3RyNk79K+jliV31E1L3T
x-ms-exchange-antispam-messagedata: 
 ghHd8Y9ofAiqFSGRg8+UkD4qIjm9bbDCrMA1ARqr6lyEJ7Z661sRXjtKw0LYyvr0ixnkgqw/aT7Xx2lanzyjZ+eWyhHCN5T6BEDLlNVkW5gi2AwPf71uzRJunQ1s5biW5ifCR6jwU0tbS2mcVp0CMNg2fZ+7POs8HDaKa0f7bk97pYzGOC/igpZ0rP7vXR2JkDBacZZJGnWkvry4SGq6frb+0EX/AIP42UQMXAqWZPHn80pLIPYiBnAaboujQJ4qGbns1a+IvJIPQpp0kn0G11/d5mGeHbyLMlaDoz05fpMMtcfp2Q1po+HUPcjR8xyIqCgmmZs99R62bBLZW83rDwDL3ni5bmMSzKLHBzXJ6lSy/KJUmx4c4FAjr2kDFRtF8prIEV+XAej5+7ADith0swtRAjIO+N7GrCWanK1bz2QBoW0PnmX49REDaqhaPoKsEIPeaPEjNmPFb85YzOgXY3VBLJHzRXOybYTPENkbnRE8xLlsS79WS0wB4Qhh2qdVy+AcvIAv4azjhHKXfqrNlhfcKoVGvR0UQ4Q0Pk0J5IFyIxbntgJL4XClZz609GyFXebaUUBJeLThRpiNJohgsijwFp8Qe76uYD2W5+x7emQxe+aJjQBtysFxkl4UvC6NQWnFjOm820onDZ8XXWaToQ==
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB5048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7efaea-8fa8-484f-0bec-08d875ffd6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 20:28:14.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yk8mvozofFMOd+OT9qjX81UfALZleeBNECGKNcAXFPS6tJFbE/l9PRN3MxrCCWDx+3WxCVIwBB83AnjCTxte16sqyBHUOcgSGMBqWCVjdRDDHxbaFGdDodhjZbLYKx1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2520
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1bF6gaYsMPp0GMdEJUZScmmRx4520388AA=
Content-Type: multipart/mixed; boundary="bJb7rJ7z6DiJAPGjyD2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603312100;
 bh=J1O3XSJ5CmQ2ypT7Bc9rdriBPywSiLEXS+8op8pjMdw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=GYU+5qmAemiF+qbevx9puaVAh5qvuFYSX2SSF7F5UhcQqrH+ViUXWgjqvSnSTxIIwpU
 MySW52mExlApOlUZLqCIHP0W54ChAqw3hi9S/vJNAJ7VeT4fzX/7+i0zf+2I+JEUXaWB1
 dR1UrKlH2cQvznnF83lpfX65vuu0mBxg+/A=

--bJb7rJ7z6DiJAPGjyD2t
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 21 October 2020 20:07
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Das
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [RFC PATCH 4.19.y-cip 38/50] PCI: rcar: Move shareable code =
to a common file
>=20
> Hi!
>=20
> > commit 78a0d7f2f5a31357bce68012d886507b4cf33598 upstream.
> >
> > Move shareable code to common file pcie-rcar.c and the #defines to
> > pcie-rcar.h so that the common code can be reused with endpoint driver.
> > There are no functional changes with this patch for the host controller
> > driver.
>=20
> Whoa.
>=20
> So... original patch _moved_ shared code to new place.
>=20
> This version creates another copy of shared code, probably subtly
> different from the other one.
>=20
> Is that good idea? Won't two copies cause problems depending on
> .config? Could we share code, as the mainline does?
>=20
My main concern was this produces a big diff which would make it difficult =
for review. And CONFIG_PCIE_RCAR_HOST by default selects CONFIG_PCIE_RCAR w=
hich builds the host driver.
pcie-rcar.c is the same as mainline only that pcie-rcar-host.c is untouched=
 here.

If you are OK ill post the similar changes to pcie-rcar-host.c as done in t=
he actual upstream patch.

> Anyway, patches up to previous one -- [37/50] arm64: defconfig: Enable
> CONFIG_PCIE_RCAR_HOST look okay to me, so if you can send them as
> non-RFC version, I cal likely apply them.
>=20
I shall get on posting the 2nd bunch of non-RFC.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bJb7rJ7z6DiJAPGjyD2t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5637): https://lists.cip-project.org/g/cip-dev/message=
/5637
Mute This Topic: https://lists.cip-project.org/mt/77461717/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bJb7rJ7z6DiJAPGjyD2t--
