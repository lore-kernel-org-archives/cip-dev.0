Return-Path: <SRS0=V8lO=II=lists.cip-project.org=bounce+64572+6267+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CD0C433DB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:37:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7AD64FF7
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 09:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7AD64FF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6267+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NeVCYY4521723xJYWY0l4Zor; Wed, 10 Mar 2021 01:37:57 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.119])
 by mx.groups.io with SMTP id smtpd.web11.6671.1615369077015796759
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 01:37:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D86BUkHm+gyC486wkoYllD8guaEBJFUKnqmf1aFN3VA/p8UIqc8HlUWRabukzUKlPr2q8T6kcjfcW/Tc7rJHukQ2qVuL7mQIC23NhFzilyipH49lgpHfJ8FWdwA+xh6eXYfwloUvD/CSr3c9NkXOScW28t5EtTAp2ZI2hJzuN3UF1gg4kJDLfzZ9YL/3I5OOwksXr4diMcTMS19+n6LLYFw24Yxj/bQ4Q7IE7cmvjhIjxJYvwR7n97wBH8hI40bhvQcfQEK96d7wULAglPO47HvXbKBQvpCPI65j09hEH9Al4jFtgtqAn2NVtycn+Sxm1uxnldeTfJc6VV84bhGGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnTi1wb4BfHeXNgVeOkqfwmZ4Gx8gYNonsGT/xc5S+8=;
 b=NWDthADQNSR+7SfRmmeeaS6ouy9SqndfVOfgNg8AczWKiU1c6x3BRvwyw3O3Ib3igm32L8XAnwqEV0dg8f6WlNt0LGw5JmsXsNc6MXNqM0h/6XpzRzB4wegJBFPn1jwc99OL2USwD/k1oZtgy6RXzy2ssimARyPRWQ/VdRTOwH3ZIausYg+OwoPYwKQNoIYUvAQ2bWF4KUCXS1GnYNfMJY/Zp9kbMoNUbTTtLA+eMZfMEj+HqW2tn6u+EQcBzytGfal0XEIj0O4SLzzQh/asN3+GATPt8noBMGluVJtxu5mL0CXpnQ3bT8nPbnwhar4TSZ4NKbp+OUcwpxbC2v0fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com (2603:1096:604:6f::14)
 by OS0PR01MB6161.jpnprd01.prod.outlook.com (2603:1096:604:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 09:37:54 +0000
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede]) by OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede%4]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 09:37:54 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 21/40] arm64: dts: renesas: r8a774c0-cat874: Add support for AISTARVISION MIPI Adapter V2.1
Thread-Topic: [PATCH 4.19.y-cip 21/40] arm64: dts: renesas: r8a774c0-cat874:
 Add support for AISTARVISION MIPI Adapter V2.1
Thread-Index: AQHXFSRItmwTZ9H/IkumVzYz+U1bGap8941w
Date: Wed, 10 Mar 2021 09:37:54 +0000
Message-ID: 
 <OSAPR01MB4867A795E20CF656CF3FFA6DAA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309203914.GA9574@amd>
In-Reply-To: <20210309203914.GA9574@amd>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d660b352-c72f-4255-8715-08d8e3a82e45
x-ms-traffictypediagnostic: OS0PR01MB6161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OS0PR01MB6161FA20605876918CF2121CAA919@OS0PR01MB6161.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 4cSOd3YIKRpHWjacFiklaq1LvTT+gUGHobUWYCb8/BSOBuadYbKezjQf7GygVmN4vkuItlaVejUjp6BAegFoil9Hc+F8H1HNdWHIFRqnfv0D2Xo1N13mzS8NHNbp31cG9DNFxfMj8QQD3zyVGwfv3ZWkkESt3ouvMyHgHov4dvJ7IwFdUkfyv1uDzgx4FT69D/8UxD2Xtl6t4r4c/ldtI48wmKxuTTfs6Bpd64AqfeYogAuyvGGzPfO2Xlq+lHphtuaYugPpWFCmv8zcUQZ210Rje+kQ63KfMesMhOpor9nloRXK+HU343xDg9YRvWvwaBxlA5lVl5u5Szq98PyPz0VBRZNipSqNbGCqugRQB6OAMCKZgL79gYddCVnPx2lolE1XvYbTs0oWBF1yFERp+6YaEsrUy9o17/EN5kQrS2eJh0tE/LUgjqtDbvQbRjW9eag5HYDuJRZAimvaW267T+DASVJm4D0s1qbg2dSgln/LowF+kLMMl0Yc6fJu5CJt1gIBkjmTu2FkXpa23VJ3ew==
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?FixK6+8lHGylIrwlqgadkCXztuHjqMGmzKW01EDXHqno+jfdYVxQQa6vw5+Z?=
 =?us-ascii?Q?/wKtAmOEyGE2zHciHsyvplylHaYRarPdj+r0sofZSYLN4Xd5Nee7YgUNLT3W?=
 =?us-ascii?Q?9ISrd1wcJAWyCNM1yTohs91NMUVVv63v8X2FgARapdpvEJMjeHe4eEoV86gS?=
 =?us-ascii?Q?fvMWR/F6dQ1JrTIBsZlzE37ImBjMzG5b9hyhTDg3GFqrr74/6H8pGq6fj3PH?=
 =?us-ascii?Q?6D/BPRTxYBIFVDkxVJyFYycyy8rtgNTv/fCzS3kSiQ5IeReG2RkVBeF2AJvs?=
 =?us-ascii?Q?gwnueBfcGEXnAiV52t4pBpvSl2n1lQCU++54RALGzvpnbRqGWR+Wsvn+Yt7X?=
 =?us-ascii?Q?o6MsDDBH2HyExbXO5lPe7ybyFxHrsN+cIpoDYdvnr6a9NdFou38SdpogngPp?=
 =?us-ascii?Q?mebtwstnWFAy4LSxAESG3gwvgpDLV07UMf4WtCFVKzCQoVCbnOcATwF06rOo?=
 =?us-ascii?Q?mKr4VsnDecEV++eaOPl8leurhknmuBuTRd/qrmPvdRyG1hNIsPpwpk7Wg3v5?=
 =?us-ascii?Q?biSZUhB0aKvxIidXZQvUW12ujf6lGGwaQZhsWmMv/RB3AbmD8M7jCj4/nKIv?=
 =?us-ascii?Q?Kp5yPE1WOysU2hPxY7oW/5nDAfy0uNMiuSYiDxnsjrqDtVhJK6xX26YqxVrL?=
 =?us-ascii?Q?98ltlPZCLxSamBgllkvhZwGHIQiwe2k+0Dqm+NPQXesJRtFUbLKQ5ySGtD/+?=
 =?us-ascii?Q?akZA3QCuxTfInljq/hUp2jjTqVR9wuNcdiRtA6XsinPxYsYOp3YRmALrtEB/?=
 =?us-ascii?Q?FZlBoOrpBoMWbOKkamdQEiBtV6njuqskPnfMUF/fDm4erPbAxhq3Kr6zEX6W?=
 =?us-ascii?Q?kqO3VbOT18hRl8vaz6YGp++snAxnoBHd1RlsCCXHBvEnL/MdEZwYWh4C7m6w?=
 =?us-ascii?Q?tObaFu1kRFe0oFOtLfYxOMTii9hl0InPB/3FJd190DiijaZVEKFVho3xcTUC?=
 =?us-ascii?Q?lyPhgrSxFRDTMKiQAejSi55X9eG4FtTo2LkB4LBWqOxypuePYlPdIjZN5idV?=
 =?us-ascii?Q?/aGgHtvhNCuWaehvQe9YRDeIIFtcd0SZoQ7q/jzZ8GuuaTTUjO5ghrkvgdo9?=
 =?us-ascii?Q?Bce291XOGdHGTZfxbJLRmolcwFMOMTLskN/Xks8hvUqAorXLdllZB6qnAFPR?=
 =?us-ascii?Q?/wIAtlMEgPkXIVwtYeSWoBcBaCYbMVrg3q0jNxD0Me/ikwixzyRyOgx0PpKJ?=
 =?us-ascii?Q?JnBxkbffq+SDL4A3BLwprEmc0T4EgHH5m/nt1bmjmV0+RUgamui2Z1owpG+C?=
 =?us-ascii?Q?LlzdJbLNye3DtibyynTVlZm25oYqe6+6aI8eY7KZ260Ewcywpjv/lM4D6MZR?=
 =?us-ascii?Q?LEvJZ+qAMfC815NLoINIYFU4?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4867.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d660b352-c72f-4255-8715-08d8e3a82e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 09:37:54.2654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyFXCFvZQeQuUw+k2Z1ZTRo62eXezC2R6FTrzikM4CFDV5ASZQSSnlXcod2QnTkz5l+ugDsj5CWkat7tRl4SYol0cxxwdb4u4Yf3fdOXgEqJmlesTXBxBFqjmcabNFbd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6161
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kp4GJckbV1opHmEMeNPuCP6Ax4520388AA=
Content-Type: multipart/mixed; boundary="ZiDISxe54WuDq70xVm3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615369077;
 bh=2be6QBzX1LLADlAn5TLW+CWhBMzTSbkkT1tM7trdTyA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=fY0BTqRSC80AkE1DmrMt45SylBPKOT8QrtWfDqOfcpqedk7X8Z2nqtT8WWxODUoNDXJ
 tu5XvHTnBUH3Stw4VoqL6masL8Scxn7wlfagjdgn4jDfdVxKxYGqxwHr6N0PI8Pds3cjn
 b3NAv1wEjeB0AupUliOd6aPCV12wBz4lo9w=

--ZiDISxe54WuDq70xVm3W
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 09 March 2021 20:39
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 21/40] arm64: dts: renesas: r8a774c0-cat87=
4: Add support for
> AISTARVISION MIPI Adapter V2.1
>=20
> Hi!
>=20
> > +		imx219_ep: endpoint {
> > +			clock-lanes =3D <0>;
> > +			data-lanes =3D <1 2>;
> > +			link-frequencies =3D /bits/ 64 <456000000>;
> > +			/* uncomment remote-endpoint property to tie imx219 to
> > +			 * CSI2 also make sure remote-endpoint for ov5645 camera
> > +			 * is commented and remote endpoint phandle in csi40_in
> > +			 * is imx219_ep
> > +			 */
>=20
> This needs to be normal comment style, and it needs to contain
> sentences. And it may be better to provide #ifdef for the alternate
> configuration.
>=20
Agreed will fix that upstream.

Cheers,
Prabhakar

> > +			/* remote-endpoint =3D <&csi40_in>; */
>=20
> Best regards,
> 							Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZiDISxe54WuDq70xVm3W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6267): https://lists.cip-project.org/g/cip-dev/message=
/6267
Mute This Topic: https://lists.cip-project.org/mt/81205369/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZiDISxe54WuDq70xVm3W--
