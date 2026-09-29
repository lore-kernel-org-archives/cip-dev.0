Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E53CA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 12:54:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7135.1790686487989283757
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2026 05:54:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=orcpNjmF;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790686478;x=1791896078;bh=KBiD7F44GHcFqv6FiFsH8KlKzsFFPUxUIvDAz
	+uCcFg=;b=orcpNjmF4X3Irk3sbIfdAonuNwoPjmVENsA4UQwTte0GEprFHaRz48JwxOjETyS+gz0
	TYC0Yu6bLNwdufkqmEKfDA6Ue3AwHqPn5QJZMaXfTZI9hgAH0czVkjm0Bv7dXGy5OhCaRwdPU7nMP
	3xJrTgLvccIINSwaasleHgkgfey5yC2BJ9UmdT/uNKQYFeCakpee7/TkC7DDjePWA9+aH5yWwf96G
	GCqOVfA46z3YoM9pLkZ6iOEzPR40AEp5NZn5xEVNv49tOGbyGvcdYwHonWBOqKCptW0eukB0q8sZG
	luMM+uT4AVdb4BT+7e/1A1AFWJOhNN4uu+MIBDwjYvDQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 68TCscir3028674; Tue, 29 Sep 2026 21:54:38 +0900
X-Iguazu-Qid: 2yAasLCAoIUeOheNTl
X-Iguazu-QSIG: v=2; s=1; t=1790686478; q=2yAasLCAoIUeOheNTl; m=IxSb8nOMoRkd3EzsWCowVFqM9qtrpX6qCeeSApea6R4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hvJ6P6rVJz1xnZ; Tue, 29 Sep 2026 21:54:35 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqOLvz0zn2seTGXt2lSnslPB6m9i6mkIq2hSDYlJ9JeS9cE72KjpkZnC+q7x1NQNTQ6wGc9XGGXVeIBpbDKj6EEhrDrcvDo5pvAvBwsS19h83FDTTHxC4pzU4CjnFPzr3j1HzSmkU9mXhpjYAojp62YQ5P0Aip07iVPwD7zyc50q7l8qHrKt1vcydTYzJPrsRrWUbC7waEOu+Zq5Snblhbsp5Ir1SHBFSVabrTevlV7WyE1R9DlNeyFLBp5LRxU5mech7AXzRXYgf3bE6Dcbl0IjzHdkF9tBmj3IiMErXz6CyMg2mD3I6Uiki8BVKFIpYYQRhZswPycKwVJF4dIe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpB2Du63/2gCx0zFRYItvjJ9gaPSwHtAMQOfyI5qX1Y=;
 b=CsylNQDXH2kquIdL3w9oDiEDcNZ4RCAz3uflNKZrTHuVc6cpfYYB3oBHGZPIK0hOnv0N3aQ4tDo+aRZAcmfcVH83SIw4f2vfaAeaq5mLoqJtAIeciEiyGnlSwQBSqffRi0n8HFJ5gjtbH/yNwWLKp2WL1LKeeuAWqJRB0tsVTeSiDXmHoOCrGW6SLWYksRmZvA45Tg7XXwt4aexzeYBGhKRLTAmtSYHxo7A2DfSAx0fl4659YEuGVniFVYJKl/KAbAblSi2g/ZAl2li8iw7dGS1M3SdRmqbhPzWYUybqjVAIWfKoSvuJMHAfbT3b9SNB4LyfSv2M5nQOvsI8RiH07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <Chris.Paterson2@renesas.com>, <jan.kiszka@siemens.com>,
        <pavel@nabladev.com>, <uli@fpond.eu>,
        <arisu.tachibana@miraclelinux.com>, <masami.ichikawa@miraclelinux.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: CIP kernel lunch
Thread-Topic: CIP kernel lunch
Thread-Index: AQHdUAkf73ILST1siUS9ScCCs9G8UbblctwAgAAP9xA=
Date: Tue, 29 Sep 2026 12:54:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148185AB8949B8F4D3F56F100CD8C2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
 <OS3PR01MB9738E9D0D4A0C5B0A1C65D7EB78C2@OS3PR01MB9738.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB9738E9D0D4A0C5B0A1C65D7EB78C2@OS3PR01MB9738.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10004:EE_
x-ms-office365-filtering-correlation-id: 0a6e6426-68c3-458f-9131-08df1e28ce9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: 
 o/RJ5t+yTzIXkNfva7kb/9VxP3RfzRF7zW/MeKGW0PyMTqDl1lajoOlG4cICAbFX0PcqK7oFQKTvPnlhT6NMLHsw/bd4ci9l7TjMIpsLRxJIs3lg5DMUO/TOHGdxlqyvsUBcy02L+436sGa09PwPEzoWPEQmx+cATusI1nEPx74I5yQd2yk0ketTHNBtR1DEtHC9225s9eWvpqF8HPtS1CHa02kRdH5N+WoHiU9IE53GzT6lLdGDU1dUtKSSTNcZ+ZwYkDtedYdoMCgJUrQdC72tnVOe12yZmZUOW6yLP/ddF4Np6uS4KpcbHDsflXBuclYvrUHxr4jjgiVXfpYKXFeggwQYhdvu6Zw/zqbNlLyJnO8J6XHWLiQto1QCeIdvBzeOmXmIT+ITNnZ6sQZn1WaQOQu960FvUpcs5C4WKiO4yLPBJyBWuOR/XS6/GaN8YeOorJmF7O8MEgpueajIqGXzjhL/4E8wSskyVqMWOQcm/Ug+Ahxc7sG4z2oce9Hd5Jt5oc/toTIfaTvYWwnjS7pXIy+xnz4EANvksR+AcLeh+R1QEmoz0IaCwFl1zq0HCi/A53Q6uKiJ+XA22UegHPwlPvOJ6XGPmTnxLom1it1KUZrq+TIa5gPGABm5ZmqnifloDKW98amksim2maGgo4fAlsRDuGrqeIW5M4mYZzO2U7cfN7ZI7QTii2cYjV+r4YKGI1EzbvDTYUaX0zSM5jnpcF3Bt1J71E9NQvvL06E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WHJub1lGQi9zVTdyYWlPVlgzK0Qxd3pEMzNtRk1KT2tneXh1Z2syb3VQ?=
 =?iso-2022-jp?B?MFlLb3g1ZFlYSjQ0QWd2bk5zMUNaM1ZSNGNwOTZEc2t4MWNRQWhHalhX?=
 =?iso-2022-jp?B?K2pwNXZwaUs1TDZ0K3BuNmhzeU9iQmxhSUdwUVQ1TEs4TzF2SVN6dUR2?=
 =?iso-2022-jp?B?OUFHNURaSUQrU0F1d0pSZkdVSVA2eFZwVExtbGNETFZtQzQrVE05NTEr?=
 =?iso-2022-jp?B?aS82Skttd0J5TjhoRVJ2cGp1eUZtbGJVbDMrbmN3Uk5uQnJaMGI3Wm9V?=
 =?iso-2022-jp?B?MWZrUjRLSDBsSVlQLzFFMlgzcm8xL1ZpeWZtemgxRngrRVdKQUVEOTIz?=
 =?iso-2022-jp?B?cFJMa1c4eEVmaGFzRENab05yVUdhQldVUWNFbzZ1eUk1Z3VZTG82QjZM?=
 =?iso-2022-jp?B?dzJNYmpBbFc4U21MNmVuZWhEMkN1OGRxSnIvMU1RaTBhNHFxczJ1bzYw?=
 =?iso-2022-jp?B?V0U5SnBnM0plY05SWEI5aFkvNml5M1BWQTZ1YVMwUVB0Y0xnbVdHaXc1?=
 =?iso-2022-jp?B?OGZsQ2J4YS94cXhaUzcvcTZTUkdFN1ljZUpidzRQaVJtQ1YwMVc4SytU?=
 =?iso-2022-jp?B?ZWkrRWJHRVhGejJJcjBZVEdCSUxVSHJsMXB2S3JkeEVUaU1YbXhUbGt1?=
 =?iso-2022-jp?B?QnN1eW0vTE9PekJrdHRxNHhydEdlS1NOdWhTajBYMHBNbjVOSGk3MTJq?=
 =?iso-2022-jp?B?NGYyNnRvRXlkK1pIY1FUaktqRGhjZ2g0cFVnWGdQNk50bmNLTk1HY3Bm?=
 =?iso-2022-jp?B?SUdtZkpJQWpNRkttbVJZZzBJRlVuNXNXSlBiYVdwWWtsb0txS3Y1a2FE?=
 =?iso-2022-jp?B?NjNlM1JqUXdIcHR2Z0RWOGg2czFRbjAzTUNYZlkxTlk0KzVmaTdIOGw3?=
 =?iso-2022-jp?B?N01yNjEzNUtwSkZIKzVhM2FpNllJeTZ4b3krSlhPYjREZnkxdStVWC9Y?=
 =?iso-2022-jp?B?T2liSDBzbjl2Q0Q3aVhXY1JVREw2a3FKbVV1VlQyY0QyZXVpVHZ4T3di?=
 =?iso-2022-jp?B?U21RWkFuV0J3MlhlcVhyNFFwMXBQL3RNVkxTQjRGTStsblp6K2ZjZWtq?=
 =?iso-2022-jp?B?TDdJRnovcUlhUm5pR0V4VlFHZWkyT2w1ZUxNeGUzR0lzWHFaNmFGRjFm?=
 =?iso-2022-jp?B?ZGlyZmFZQWwxQlZDcmZscHIwR0duQmdLNzFIVlFicGwydWp4Q0M0emdY?=
 =?iso-2022-jp?B?N25JWlJ6d0p3aHEvaXB0d3VJVzR4d045RDE2dTUxYS9xTnRUTG1hYllD?=
 =?iso-2022-jp?B?dktVdnFsS3I5NWVqbEw0YzZPMmFmd0xCaG1JSlRmRlAwYTBGeWlaQ1Nm?=
 =?iso-2022-jp?B?ME5RWEpoNnRBcm05MkRCeW1vM2dNMy9hTXN1TkNxR3pEQmZ3TjZkK0NV?=
 =?iso-2022-jp?B?Y2JnMnUwWVc2WERjZDRMK3VaRHpWMEMvOE11UndKUEdSb0dvUng3a2di?=
 =?iso-2022-jp?B?Szk1RmhJT29Hei8wL09QcUZQTmp2V3dETFpLbUFGOVQwaitxNFIwYTd1?=
 =?iso-2022-jp?B?dC9keTVaeXdhUXZ3Z0xhbStOU3ZudWlITVgyRDBiaFRBQnlaNk1ERVNI?=
 =?iso-2022-jp?B?S1dBR040em9HZXVIdzlCbDRXa3M1b3JyY2ZrR2sxaVJUQkNHdkRsc1hk?=
 =?iso-2022-jp?B?V2JXYUw5bVExUzcvYWJkSzRTS050M0o0RnA3d3d6VkZGM2IwUFFNZk5H?=
 =?iso-2022-jp?B?cUVVVTIwR0RidkNITVlkbXJHUjB6cWI1TDB3NWIyNmVPd2pBK1d0ZWxE?=
 =?iso-2022-jp?B?TnVLMER6Y0NTZnJSWStzTWQzL24yTzJZbHE5Y3o0MXlZcGt3VWhESHY2?=
 =?iso-2022-jp?B?YVNJMkJTMWdXeEJpZ2loZ1I4dTZSVjNSZlFuTFBwTC9FYUFaa3BrUHA2?=
 =?iso-2022-jp?B?dWhTczFkODR2QWhYOUdCWk44K3Fyby9jOVNMNXpOOS9ualB0VmlkdFJh?=
 =?iso-2022-jp?B?blhQeHk5cjlqY2paTzJDVzZ2TUV1bWpxU1l6QkZDNGpxak9rM28vQVFr?=
 =?iso-2022-jp?B?MjExaG9abDdSb1lJVlo1YXZsNGIzYU5CTkZkaVJJMDlWTkVTNGt6anZz?=
 =?iso-2022-jp?B?RmQrNUJBUWQvTzhOTHRMWTZDZ2NnWmZwUDFpbkcxUWMyYkd0TzRURFRq?=
 =?iso-2022-jp?B?VXpQNUp4bjU1cDdieDhpSjJiTkpiSFNUcDJUTVhEMnFsU2dVZisyQTYw?=
 =?iso-2022-jp?B?TWtacFp0dXF1QlZGcEUwUnc4ZkhjejFSOFRPYlZYSVdaMTdMcDFQeWhB?=
 =?iso-2022-jp?B?dTFRek10YkRKYmp3NTM0aVZyYVJ6NEpPY0QvWEJMYXprNEFWVUE4dGx5?=
 =?iso-2022-jp?B?LzV3akFjRW9HUXovRXN4MjRoQXlBWlZEZHM0eXg3eEVqVEluRmtiM3Vz?=
 =?iso-2022-jp?B?ZU1qMXI5ZkFZcnNnRXFVZjZlUjhYeFNMYTZ4R1hwdzg5Y0RtUkgvUzhQ?=
 =?iso-2022-jp?B?NkhaR3ZtSUZ6ZTBHc3h3d0JHSnlWU2lpNFBvY3cxUmQ4di9wTzRhd25N?=
 =?iso-2022-jp?B?UVVDZmY0YlZiRDY3VkF1YW9zRFZ3NnBMendCMWxiV1plNmpTWlB2VDR0?=
 =?iso-2022-jp?B?a2syMlFmUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	qc6DlM3CSjIlfku6IAySNFB6CY9xCkUoqSNMeX521lKiLY9bHvoPCr8EzAAS6+edOIagvL3ZgYFgXvJJTkvpNNDF1k6JezX1BBkpC1wlV0QNF/K3caO5ntahlMWY9kKkaXdbTrDHuBKuGFQulPM+vg2ZJEpQ6YFgG238qfxOazchy2H14rLZu15+Up9nXUWBiv14e4dPnP85pnmfYAzdnepBuNfvjs3p0YV422ihMDk8NwBvH1UqbEnkgS+EmsTuXKAJQu6U5vfc3rydAYmPj0Ga9l7V2w85mRqTc08TsnMLCv21A+TxF77tcouvGsLCIGiUJibIByzIGp/yrsjB9A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6e6426-68c3-458f-9131-08df1e28ce9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 12:54:32.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cY/UNUW6ld0XA5eWj725ewA3b/8hd9o6NWcxnnCoq88Xub/M3I0ccue8Vlwnj6B4nuiScaujsa5IsBkkDtKwzLlGN3ac9nJgRYmDAsvEpPEWFEAwdK0Gdt27hdUZNOqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10004
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Sep 2026 12:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24376

Hi all,

> -----Original Message-----
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Tuesday, September 29, 2026 8:56 PM
> To: Jan Kiszka <jan.kiszka@siemens.com>; iwamatsu nobuhiro(=1B$B4d>>=1B(B=
 =1B$B?.MN=1B(B =1B$B""=1B(B
> =1B$B#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel M=
achek
> <pavel@nabladev.com>; uli <uli@fpond.eu>; Arisu Tachibana
> <arisu.tachibana@miraclelinux.com>; Masami Ichikawa
> <masami.ichikawa@miraclelinux.com>
> Cc: cip-dev <cip-dev@lists.cip-project.org>
> Subject: RE: CIP kernel lunch
>=20
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: 29 September 2026 12:53
> >
> > Hi all, CIP kernel WG members and beyond,
> >
> > if your are attending OSS Prague: How about having lunch together on
> > Thursday (Oct 8, 12:20) and chatting about CIP kernel topics a this
> > chance?
>=20
> Sounds good to me. I'll keep it free.
>=20

Me too.

Best regards,
  Nobuhiro


