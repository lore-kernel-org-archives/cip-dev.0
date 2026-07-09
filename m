Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE19C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 05:30:39 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2575.1783575032262826216
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 22:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=ma6ku6wo;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.56, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUo+uouCp3Vr4tbicqxKXFELRw4x86LLK8k5RP6hRmOiQqXBB+e/cc6FZPGcufsHsqy0g9GyXbLwQB6PPt1FQ44/mDCY4PS5Ne4EsmmERALWog4J0O9WHEzBhmwZGuNxpRcg7E0IurGYfHFarxYUj9vOwA6Yda4QQmsEZuyh8ZorawgbVlUMnNHAD8Of4Lpc4vQ8qCqkh9FRwnlVg7GX8csqzZV07H8zres+DNpz6hnS4LkwWXo8KAekvBgR8Mvc516ok7gNubWPvWPOqXlCUM95q36MsBuBDQUVrFK76/PUmvQxdKC65UCUmwPaC8F7P2OdlHYVTmB3rCr0vkWNKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZwFGpKkLF6YTQqO7ULjazukwWZ6WcStG6hQOZkHbf8=;
 b=jwvkaXgLii+yfh1mSbtyFhJ0mialux9aqEz7uL6EjmuDM4lOkG+11tR70ZhFeyU0pg7Sf2EOwg6U1kZJvWe0c1/9UHIMqg0N9H/Bci++pnrWNgLN4pWbH/SCkAJVPhd3+vqnapRHDtEivr+K44NgkH2G8lP/vSGyamc+vnM83wq5JiqIxmcYOjp0F+lIm3C22UJ8Fa36IHueX2A57JtvLHvTKRkl5QdRiNl2ED6qt2OB+U3911Lnj3qppKEu1K08q5O/kUCsu4PASSC7joGC/jEZCuLHNiekpJNQYdyn2x531Z62NqdUKCryLYvI0cExyEosnZVh8q1Ktmf4d7Ct+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZwFGpKkLF6YTQqO7ULjazukwWZ6WcStG6hQOZkHbf8=;
 b=ma6ku6womcJw8v1+kOfR7Jt+4zwcjzX5VVqm4Pk0qy1xelTstgalf4EC5Cx7SPArMBjLmyuTj+X7QjhpWF6ePdTR9EgEer0NWoagQih28HSuSDI5ixVcV4eoqiOCOMHjDmjmIMddT/xGr41BLEBGb+yfr1e3dwM8eZ/UcCjgw/Q=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9306.jpnprd01.prod.outlook.com (2603:1096:400:197::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:30:26 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 05:30:25 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>, biju.das.au <biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Topic: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
Thread-Index: AQHdCtPWsMs8VrsotkWPsXOF4HAik7ZkGlaAgACXALA=
Date: Thu, 9 Jul 2026 05:30:25 +0000
Message-ID: 
 <TY3PR01MB11346ACB656A21973831A248086FE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
 <ak6yWxbsPgT8X18c@duo.ucw.cz>
In-Reply-To: <ak6yWxbsPgT8X18c@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9306:EE_
x-ms-office365-filtering-correlation-id: bbd8fcaf-0c7e-4f31-abd5-08dedd7b2e20
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: 
 lOcABn5kun8+sc4QflUh848QT9/7xQ6/0nfCchOknXvJ6ubO3kTbBh1OZ4HfPvDEp7yy+v9n1LQgVBy1qdV6QtGVH84EbNdEqY22ejwWVoCy3Wi8DUpUCwQAo9rZ5mktdGHrsLBbWLyWQrpMkyWa/kpIjpp/es/5NfrxCpxtp0+o0GiQObq/nqX6I67Ser3jfK76xGhPWiCTiE6mjfrE6/u+AVO0RyaO2vQmryVZIGYtHeWXAqLoVV3fp3gUgYT1HGlk9yo/NCJVnCcyz8WZv7OeI4oTJOtCHPHD8vzBziGFHtrg0koqa3Ki7mUHSeMjTLoC+OA0HAMmDV4/BMB0gUKmlQ3JbpkC/XLCZN6/AOux2S+eLEJ0Sd7qsq7lw6cPElWmWVoznvR/jMv64IUeK/Y/ZjCiFy76Ro7+BCqaZxhFmTvakSC7CDvfEDG3701yjebXPIbF9OF5YJ562GHS80iCPct50LDBUyGNs0nfxAt+LEQQRVeaUVCYw12E+CXo2zDo7tBa5EoZehBb2L/YLHkz53DgwJvNsYp9SKHibdM22IxF/w8mJP5WpeGWTILAlQTHRtEWZ0M+PP0ud7JBeewT/4Id1HvqpzT+/YjFIZq3lQOAlfA4+osFMSIKmbx83VN7/6MWcz6SreIWXh87Szb/Wk7t8DtZaJTKPBmIj+vAIhpefeg5QJoWLA4JBszh
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wXHlkMCA1mPV0LkKqvDjlnmGKTJ57O5qKaQdkxNnkShlw1nkwrAUxP6VQ4+7?=
 =?us-ascii?Q?Po3te7KfVCMn+METMs4bFULUfZFWL5PdBrmp4l98NPhp7MNsdw7l4zqLvI7J?=
 =?us-ascii?Q?LkOkEbeW+1I0x9QJiqieSeXTrjTMCD2FUcA5TtpNs4fdTASjyCKU80eDCvXO?=
 =?us-ascii?Q?29nd8WTuqqcU017WB62xFdU68VYExt/UnZ0h2WBng4yM+WTiJofCdZ5SKa9E?=
 =?us-ascii?Q?j9tBVNS8jixXUZxYl6eu2yIJHCJGWW8AXDpTdWIECkwsz/iHOwV1cyi63i3c?=
 =?us-ascii?Q?GaVctVM2dg/cQw2N4sxo9YLtgm6HgQv/7C+C/3HfTqnQ3GNFz5QqYNV9mwC6?=
 =?us-ascii?Q?w4JGwezIXIB3EtJFToSTCZrcWFYxUupZ/j3SFewsU1BEVoLz9DCnZ0ekVKo2?=
 =?us-ascii?Q?2+Hy4MYiXET/PBfzzWpVd3LxLIigAVY1P+072RZgH279e8YSmHqcgVBDqO2L?=
 =?us-ascii?Q?nngKACsg0sSCvfaVraNgOmhJiz2CwsaCZXo8TPHZ/F5ov4VjMvKwexT3odEs?=
 =?us-ascii?Q?1tXmjtP4TUDPZCWCizRm9hxLWilSzjmsYFOOPaH4uNOS7GRTXwR1pb2weGoW?=
 =?us-ascii?Q?qjwQmHmkkIKM38Yqz7/f4DbSReYLtIOlCcI6Ng8zlvlF+P7gU3mlsJwpn7ic?=
 =?us-ascii?Q?U8bJlHU0pQdfGAI4ARemvUA7AReF3Fi+UiUnghOKoHSNb9wWylKDLGdEdAjw?=
 =?us-ascii?Q?RiQT9kcPG3GlhrVHXdGjfoxy7R9kKcQxdc9HkdZOE/KNw6ryl2JJT3Sq2J2P?=
 =?us-ascii?Q?ozwYGehZS+/HOQE7vwhR4rI1BzgMiuNDJKk+5Y8T4xIkh6GTalavourQWv1c?=
 =?us-ascii?Q?4xDZIbEjsiAH8P6glgee3TuxDRnxZHZiVXdKI6rWyi+B7M7dHeY5MxajDSIg?=
 =?us-ascii?Q?Y92o7OqNIqVs5NibcqfeyTNgEMTSRgwqYisfOlm+O1JEO4oc4O2Cf6xlIDPx?=
 =?us-ascii?Q?ciLsa8Y992PKJAc4tQTdgCUhYDoU7REzZnOiM5Pfg+/Wo8EBkLp94K++akwg?=
 =?us-ascii?Q?5W6YB6ukm10NFAhV1dG/nB7gamYvQXNrUSkSY7s33Tb0cBFG2NT7nwhNxqpF?=
 =?us-ascii?Q?6d7b6Rg3XlnaqsURLhR80TaHWgKOzG14vSpS44yzCTRYn8znsBJJo/LNyp/f?=
 =?us-ascii?Q?9DBrTpgkuKJ/j4fmbrHPRDaHG4xmOSgh3TZOcHh1RqRst21uwgWvGLPh2IZF?=
 =?us-ascii?Q?kGmeaM1wk7zlvNYWoCuWn6+2Ly55M3ias55PHRjRgOues0A74Xd0mh3URCG7?=
 =?us-ascii?Q?kSGyEJfJeirQDGiVxbEj/k4xguNKYKnCZSDrKW8JcFSj0pmRLOifxR+6hvpI?=
 =?us-ascii?Q?CwYjXXHFvORhNp39r1rtigQJv0H1C0CIEcJcKFH//TOuEjhgzF8uC3tQlNNJ?=
 =?us-ascii?Q?ytX7Yqxb7gUZkR+PpWVQG3qOr4jU+HOb7B63rLg0vhzaBkvcn3CNQLVkvqrK?=
 =?us-ascii?Q?2CIKAGe1oo39kcdWhoD9iLuXlgyxUFEHnK2/yBPuC1OHZHFj/LV3C/T6VvAT?=
 =?us-ascii?Q?W/84CLqitRwNaU27zFjJ3CdAgCKUC6ZkLkNOMb0WjiLCLlc5z9NEHLJxV3fu?=
 =?us-ascii?Q?gWNiyX6Dz7RcmGD3SlVxUTq/uxSBB1Tre1Qd4gwfMFWCPRQet6tdwhgyov57?=
 =?us-ascii?Q?h8a8vMLlRu2BcjiHBXlP2LHQIWJWE4GBoyeFOJ4olJS/A1H9vRP854sTN9DS?=
 =?us-ascii?Q?aLDWrSjyqfPUtWvA5AnXpB9477aspwb3JvyIiTBYjcWVg5cEVqj6qHkv1/rf?=
 =?us-ascii?Q?GhVTkeTR9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd8fcaf-0c7e-4f31-abd5-08dedd7b2e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 05:30:25.7655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xqc9tMhrt2Vv1MsY6hx+QX0pU3GJGBMRT5G+nW79aZ/2owFh6g9TaZ3ysWTT6nVd1BscfLuuiYFlDii8E2YAu6NEXfzqwgBbyjhwgt/dGd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9306
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2026 05:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23553

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 08 July 2026 21:26
> Subject: Re: [PATCH 6.12.y-cip 00/26] Add RZ/G3L IA55 support
>=20
> Hi!
>=20
> > The IRQC block on the RZ/G3L SoC is almost identical to the one found
> > on the RZ/G2L SoC, with the following differences:
> >
> >  - The number of GPIO interrupts for TINT selection is 113 instead of 1=
23.
> >  - The pin index and TINT selection index are not in the 1:1 map.
> >  - The number of external interrupts are 16 instead of 8, out of these
> >    8 external interrupts are shared with TINT.
>=20
> >  .../renesas,rzg2l-irqc.yaml                   | 157 ++---
> >  drivers/irqchip/irq-renesas-rzg2l.c           | 627 ++++++++++++++----
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> However... this is unused for the moment, right? I don't see dts changes =
that would actually activate the
> support.

The NMI support in this series is a new feature for already existing RZ/G2L=
 SoCs.

The later patch series[1] will make use of this driver for RZ/G3L GPIO and =
External IRQ interrupts.

[1]
https://lore.kernel.org/cip-dev/20260703105923.251255-1-biju.das.jz@bp.rene=
sas.com/T/#t

Cheers,
Biju



