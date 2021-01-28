Return-Path: <SRS0=uazO=G7=lists.cip-project.org=bounce+64572+6149+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DBBC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 10:31:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DEF64DD6
	for <cip-dev@archiver.kernel.org>; Thu, 28 Jan 2021 10:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DEF64DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6149+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id w4OsYY4521723xOA3HIZPsKR; Thu, 28 Jan 2021 02:31:31 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.137])
 by mx.groups.io with SMTP id smtpd.web09.22826.1611829890072245257
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Jan 2021 02:31:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7eTzVXeVKxwmofMUz7AWzltFdGjpiq8slxjCmdsR2m0r/WGypcCYoTrvTwWW01f1D55yKSZT32AsmswxDxD0t/Z6PhpItIBUZpsEgSZMKcUD1cLVjRHQ91eV4AqwwUZcCy9LTzFoD1+oR1pK2eUgTa4vShDeXzQDlPbdE35wAurmY/ZyJs5vMOKIWKbdYa1DV6v5WnQNJ4S6RAqh7Vq71uZb2P9Tz+drYarQ2AtBBNRUrm19ObAMfQcD3J3n8qFKCTHI1kkBOc4YuGpuZfHtjG3ZDXDVJsAA3Nx1uHg1O9BThFRkkN36eVuRx1oAKsDIGNGPtGG1VXOw6ej7IhtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbCE5kwKVwb8nVE4vBVeoXjSRUv0u5GLHvlMWHflvJc=;
 b=RiQ+pRcA4D3jByhuOiAfPZaQDozXpas5kT3a7Dl03jZahaYGbMUWdm9XE4wwUb7bpS0qjaTzImJNWZhC+qJLcXMJkjX0SoO2rTJuxMOWStkW5n49hvySNhq2daD18tJXjt8hf09XNvGamez50peC8Lw2bh1zLi57YhEZlTj+AxZNao19gQzbeSb/TZbDgghmTYhE63xJvTgpM+49IM3+RfoZCcV7siA7IaRkkG6usOiqkp4xxlB0dVVOv66RTJiknswW2343nx0GHg+P4R1qFt+M+y6SZXkjVUxGw6YclitiN+uZGp1FeTwT6AtbLWM4wF+N8m88Wm3d3WIhBEObjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OS0PR01MB5699.jpnprd01.prod.outlook.com (2603:1096:604:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 28 Jan
 2021 10:31:27 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::cd38:9c3a:b3f0:a0d7%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 10:31:27 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Bhola, Bikram" <Bikram_Bhola@mentor.com>
Subject: Re: [cip-dev] Siemens board failed to boot testing 5.10
Thread-Topic: [cip-dev] Siemens board failed to boot testing 5.10
Thread-Index: AQHW81cihnjTI4nnkUyletqR3o4VV6o4zvOAgADw3ICAAA2GgIADCUgg
Date: Thu, 28 Jan 2021 10:31:27 +0000
Message-ID: 
 <OSAPR01MB2385C955D107D632983E7112B7BA9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20210125201734.GA26811@duo.ucw.cz>
 <20210125204403.GA4690@duo.ucw.cz>
 <56263cba-5556-4960-a91f-62835783081c@siemens.com>
 <20210126115431.GA28355@amd>
In-Reply-To: <20210126115431.GA28355@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.219.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1f8f69e-923a-4f06-8381-08d8c377de98
x-ms-traffictypediagnostic: OS0PR01MB5699:
x-microsoft-antispam-prvs: 
 <OS0PR01MB56997BF1E97330EFE42EFF2AB7BA9@OS0PR01MB5699.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 raAx3cQ4ftCDdrDW3Mw5vPvS/5Imj2wVKlMiBqZ3vfTExrtgQIiYEkrW/syUtrxVrhaRd6I4XQE6J9E4IwxSMpfjXcb/1xZx0i5bTsygzfZlufyedUiYyC7ihh/lvCUmvgzYC6pchIyjrTMi/swI6+Oz3cop2F9EGHF1Bl7tDTdNW4qNEMVPlrHecO824hZ6uTehalJwg1uESJBgSYXFKMpqy1gKdfj7binCJwaw27iZXPdw6mjgUj6A/ho+xAyum+uKjNZ42AqzrbA5fxZHCu8w+uXe6T+XxRhHbVmBUx1syFQ3yVgjNmWd6QiOPHvhNJvtMdNeqZIBBojN2kCjF06IIxwJCDYW43G6rjiXE48BTFcnIc1U+QcTC1RFML5CQsp3QBdP1thyk6cZGIypk82sFgVpvhk+Sltgei8jPBLTBBODFJKOZL0kaGGDRFT5Y4z3JJEDsHKhLcFLeDNWx7OGNzW7+6QzztlgrJKm/HqHwMsdAzFogdRxYS4sGt/CQJnlqPadZ0h3LvCdp9zv17Wnqr26EmOPr2UcZCGhH1KAluIxoDsxGkhHx9Dqy8euHCnXsUnl4kQLGn48w/hpMazC3NSsd4RSmb8UtqnUI7g=
x-ms-exchange-antispam-messagedata: 
 =?Windows-1252?Q?W5jOrAVfyh2cEOkveVg3xoxUgx6L86QmGfrgwJGhneeHH5BtT07NavHh?=
 =?Windows-1252?Q?df6qkRVtY2TYoujxBYfQtJ9ZNwI9d4OLI0pkFqRrRF22/85uLRS1q/io?=
 =?Windows-1252?Q?0q1Ir/WwghYB9DOp/lbPFSTKVJs/QLBUjSX5AEHuj8ZeP0NCgnewYcMY?=
 =?Windows-1252?Q?Tz00tCvEnStQ4Xic3YTyrNlSvnPf0AH5seheMQw4xNE34xbt3FKgOm22?=
 =?Windows-1252?Q?aFEumFENHgbwpS+LF71rX7XiPUyaHr3++SI6G5ly2TwnJAdMXzgsZPOx?=
 =?Windows-1252?Q?4b3PJwPdMmY1PTgWlEMZJ4/TgDky73KyZj6S8NQ8IxNMxalHz3Lmh2DP?=
 =?Windows-1252?Q?JB3gQB3R7FxouQImYwj9Q9JjkvaQT9n5AYKcPFhlpMw9SMwGKucHPWA3?=
 =?Windows-1252?Q?uXZZgpV1lBALgxrGZcJ2cNtpF/WOt/UZROJk6DJiUJta6pVmwiO1y70m?=
 =?Windows-1252?Q?N0g6vo+ws5KwEMfZt6G/A98OwAPOv6mSWY4goHG1tZoogmUJ3tT5cejs?=
 =?Windows-1252?Q?WUaIVgE84pK8JCj4Lcn9vdoepz4lrn1ZWuHLEGgV1S9AurQmrWpyjbq9?=
 =?Windows-1252?Q?8pUwD5lHrJybgWUktJp7WY2XcG4ZWTxHvRB6MCXeTfHfFzqI9pLsCBls?=
 =?Windows-1252?Q?WG1Vaw2OKI1/gAWZ2nUd34xKBQggSDLMinMaToQNko225yYs+MFyffvX?=
 =?Windows-1252?Q?UOEhJ/8t5nSU1mFIbsqe/nkFD0EhA42gToP3PKIXDULPpc0oGLwr17Jp?=
 =?Windows-1252?Q?cwKJc8t+/EHKMlwTP9Y1/WtyEYZSDsyNBI4Vedt2Hl7MMKQDR9rFUu/W?=
 =?Windows-1252?Q?9bVBgolcPlt0IGt9I3zRZ/1IWTa916KB82gXH0Zqjbr9kbhhRhZWeH/L?=
 =?Windows-1252?Q?9QgQnxmhqipbSUS96nmVCUl8xpL8k6i+7A2NjL58iBB45qm/feSKwgEd?=
 =?Windows-1252?Q?DHsu2PpWJTov9+HjTA+IamkJ/mUQQY8Np8NoYkQPxmn6VPAsCdJL8eAD?=
 =?Windows-1252?Q?IF9eJ+A185oDj/u46C7uFstFR6B3RFCKeKxWBmwg1iijNiuhKaGLoBWy?=
 =?Windows-1252?Q?5hm0fpWboAV46n07Hz6HZul2tc7EQW7Xf8tMRmsWzYNTR9Bg8BRGizzN?=
 =?Windows-1252?Q?1RHetcqj9qlbpMj7dBrce7VO?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f8f69e-923a-4f06-8381-08d8c377de98
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 10:31:27.5087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puAjJRDvE6zLxdbJiEGANLA1lmN9b69XA+P+Lsu+YdV9KtleiXnkqAafHrLIyt4o/u86X+Sz7ohsVcZ0oJmW4tSUco2Yky+Zc4ti1tDySvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5699
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: h79x2FRntGW8RoIBo2guKjWvx4520388AA=
Content-Type: multipart/mixed; boundary="bCEJApoti4haVa7X9d4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611829891;
 bh=mzEj61TXbHVuGprvyaal1aZxcb5tBF4hQUTabbf1mqs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rUcz6r6ZWc4zYu5HWs+5GKJMRCC7o/DNPwAtoZBu/fn4ZOFytQgvAz6Zv6BeuuDSBA+
 mI1B4hHhxyoa01oq+lfHsP7JI/9DvnFHGJNI1kHYy+3B9bFQnD5QIuX6Axfn62QZw6g1E
 OXDFv5Hko2WQF+N1uXfAooZr11VkoUqyqcA=

--bCEJApoti4haVa7X9d4l
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

> From: Pavel Machek <pavel@denx.de>
> Sent: 26 January 2021 11:55
>
> Hi!
>
> > >> Something went wrong on siemens board... I'll try to resubmit the jo=
b.
> > >>
> > >> https://lava.ciplatform.org/scheduler/job/148648#L266
> > >
> > > It still fails. https://lava.ciplatform.org/scheduler/job/148674. I'l=
l
> > > retry one more time, but this looks like permanent problem.
> > >
> >
> > Do you mean the board does not come up with any job, or just with 5.10?
> > Doesn't it react at all (dead hw)?
>
> I don't believe it is dead hw.
>
> > And where is this one located? We have IPC227E at Mentor and at Denx
> now.

It seems a bit random as to which tests fail.
We have three boards and most of the time they pass the 5.10 tests, but som=
etimes they fail.

With all three of our IPC227E boards we randomly have issues getting the se=
rial connection to work, or sometimes another issue prevents booting.
Even our healthchecks randomly fail.
So obviously there is still some work to do to get testing on these boards =
to be reliable.

You can see the status of the latest tests on these devices here:
https://lava.ciplatform.org/scheduler/device_type/x86-simatic-ipc227e?dt_le=
ngth=3D100

So in short
- There isn't an issue caused by a specific Kernel version
- We need to work out why the IPC227E boards aren't "stable" in our LAVA en=
vironment

Kind regards, Chris

>
> I'm sorry, I don't know much about test infrastructure.
>
> 5.10.11-rc2 tests passed okay, but I'm not sure if it has any
> implications.
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linu=
x-
> 5.10.y
>
> Best regards,
> =A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=
 =A0=A0=A0=A0=A0=A0=A0 Pavel
> --
> DENX Software Engineering GmbH,=A0=A0=A0=A0=A0 Managing Director: Wolfgan=
g Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bCEJApoti4haVa7X9d4l
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6149): https://lists.cip-project.org/g/cip-dev/message=
/6149
Mute This Topic: https://lists.cip-project.org/mt/80114267/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bCEJApoti4haVa7X9d4l--
