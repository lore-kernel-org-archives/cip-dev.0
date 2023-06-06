Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74637C7EE23
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 01:31:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.970.1686015080361861547
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 18:31:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 3561V16R017048; Tue, 6 Jun 2023 10:31:01 +0900
X-Iguazu-Qid: 34trPsC3EEhD48uEmh
X-Iguazu-QSIG: v=2; s=0; t=1686015061; q=34trPsC3EEhD48uEmh; m=/kO09fkPs0KeErjJLC4gdmb3mI1ogddFIlf0Bk2YYmY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 3561V0Ug002427
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 6 Jun 2023 10:31:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxSUoAh3R9jT6/mSor0nRnrLpHkHACnRRiSl5MzFBKsGBSKern/fDOQaDEVmXS5C4jXACIo2jOh2VTnjfBn2/yMYetHSujUn720NbabNds25YSOuCSXBjDu9hLksG6pR+o8IK6Ebx//ElILFvRezGoPleXWYbWeA4GXhxFlQa4gUumQiNbrvadn88Rh8u0sWuDA9Q6CPtRIVsJWO67uvPAeg6jC2LJH78RpqYK6xCiUwSApB/LmYOqkiiY+6xDsHqmmLCcsyZHSsOszYWvqxBhtRC/8aen54XkxGuNyK2sX17h/K3uciZI/KXqXQJGjWxX/a+09lUEQ7vIaZAt7nlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQK01dcu5fXH+W1/OuLptZBW6P1gEwU9uptF3SAW7MY=;
 b=Yhhdc2ScdJXcOFaaIwrrgmlAnAWNVk9lgn3qjGAARRoPrAOMf7rdJUtMWlPp/Es7t1U0SVN5MgiC7YnB/K9vkG3G8GNhKVmrHhlpWXERYAJS5hog396vkYCVTllUWDy20chLrUa72YeMqhPyv11+6M6pSu5FD7jaTidpZ6pDpIJN8FM9abDnEvWSqhqhFQgxSHNb9Ug7aN9kFv2cDaUHaC2UakEhYkB4g96hlXVsoFuOaonvdXHQqMPpTtBo/hBwL4FCoJWFNkg4oaB6H/bIOc1/5JOc1wl9h0OngKGlUqAZZMa6vapznfr8M5IaxZNoiKouOn1bn+527v7GP5mckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/7] Add SCI support for RZ/G2L alike SoCs
Thread-Topic: [PATCH 5.10.y-cip 0/7] Add SCI support for RZ/G2L alike SoCs
Thread-Index: AQHZl52g1VGdN0SxCUS4qvKA+2hijK98/SnA
Date: Tue, 6 Jun 2023 01:30:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942086A48D86FFF4117256C79252A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS0PR01MB5763:EE_
x-ms-office365-filtering-correlation-id: ec9f0c1c-6dfa-4bb4-88f0-08db662dadfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CXkYEQEdfrkD7b6txV40kC3WTvuN7L9oA9IFXADIoP/lYecIQf+Y1ylJyADOf2kEG9p+rtUTMosjlbGBOrRg7kHsxlaKvUk4tao92fDUfw9X0e3MlDMptOu6Lz72Sr7vDQskmIIQqTdDKIjAuURCDPO4TMCx88S++AROVvpaELxCWo/2uGIg7Fgc5iyPWoPQfJxEsBPDdPx8QUuZurubS5nz9eId1os2UrSRuJGA2+2zEX1vakE/U1vFE01yO0siQR1XZwMQ1MdBjhOLPOCR78aA6KAI8n94xYqIwwu9pDXtVTu9jfcu5IgDKYH9b/xesRZBnHD7Y6dftwTHFHfQ+udlIX+Pa4tPohKtHbuyDOS0Us7X/yOqSQVNeKn+RRYFgV4SN1OEbmCUXoOa9wY1x7hwwA4F6sXAVuGv0z8TZNSmvfsQIdknJYtAe2CX/2oiTiz4+EaeP1YGqoWtAP0AfD5KXSif1Krxyv09boUUEtvdDD+rt9CF9V3jgb0JnukrxAsTWn2vXFFK56g4wgH/gOcD2/tJTIsMfa8Zu4JWsaMEJnjk0wzbTAUFSYJwManOtUxLhNrMWnEyeFNLXhY1NysEAEhSDb7cwkaai3UUPBhBF1GIDYmfBLkE3605BX2hv9DPODg//wx9PM16bIbIEg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(83380400001)(110136005)(54906003)(55016003)(33656002)(478600001)(8936002)(8676002)(316002)(41300700001)(64756008)(66946007)(76116006)(66476007)(52536014)(66556008)(66446008)(122000001)(38100700002)(4326008)(5660300002)(38070700005)(86362001)(7696005)(2906002)(71200400001)(26005)(186003)(6506007)(9686003)(53546011)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Ykp2L2hKSnVXbEFXb1VtRTZES1MybDVwU3R6WWdhY2NVVFlCR21FWks4?=
 =?iso-2022-jp?B?aDJTZzQyczdXWHJIbEkxbWlFOHVBc3haeDhyalZrOU1qM2IzRmhRQWtQ?=
 =?iso-2022-jp?B?OXR1R0FVQUdYR2RsQTlXVXhTZEQ3SllSQWJzYjV2cVJ5MEVXYm43cVpI?=
 =?iso-2022-jp?B?bERJeVgyM3ZzUVVxaXhXRWlmY29YSFo0MzcrMU05bEVSN0Q2SmpObXdj?=
 =?iso-2022-jp?B?K0RxWnBIY3g2ejFiNUZaZTZvUW9MT3Y3TW4zVjZvWXRSdkk1SExTbFNl?=
 =?iso-2022-jp?B?a3Jtd0YxWVVTaGZQdHpaVm04T3pDRm02dE1MU2NJamRsZ3VmN0dBWW91?=
 =?iso-2022-jp?B?R0pySVN5NExtL0hRelpaa2FrSENTaDZpOFYxT1krd0JvRTVsNmhFdnNn?=
 =?iso-2022-jp?B?Q1NnMnk0MUhyNG9PWng1MXZpbUJBanpOSVpzNnRHQ0owQVNCZWg5S1lF?=
 =?iso-2022-jp?B?NFNaRlVHWDlhQTVlWnFVRFdudHFCM0VXUWtMdi8rMVNuZnNNVytaU3Ew?=
 =?iso-2022-jp?B?QzI2bmJFaXB0QzFia3dFZmZCWERQSFNtazFtRnVnekRmMXBVMDBXN3FO?=
 =?iso-2022-jp?B?bVZRc21XQm1wMkdJNzNKSXVoT0dON3NndEdyMUJpZEdVWjlDWWlQeStT?=
 =?iso-2022-jp?B?T1pxaks1ZFNVMlNtL1RmQm9EbG92dXpsOExYUHhzaHAxWFoyUFlWTlZp?=
 =?iso-2022-jp?B?d1Z5SDhyeitCbUhNcmg2S1VUSDNJeUgvcGxkR0JsYWhtV2RCdzVuOVZX?=
 =?iso-2022-jp?B?Q3VzelFpWnpvbm5aeHlVNUhHYWs5S0FSN1p2SmpDbVVwRkF5bzI0bDRB?=
 =?iso-2022-jp?B?NlhIQW5tWjVDZGptbDZNSlVXSjB2M3JJMkxzUGFMbnc2QW1UQTE1M01W?=
 =?iso-2022-jp?B?TzYwbkVGVW0xT3Y3WUtFV3JjWFFQVEkrY2s0dEVmbUtlWWFxWnhXbTlL?=
 =?iso-2022-jp?B?clZUekQ1N0JLV2d0b2sxVXFPc2pqTXAzWWNQenBhcG5wTUQzZHRFczgw?=
 =?iso-2022-jp?B?NWdqeHU0b3pSblEyRFNuMTV6cGFBczluUWltUTgraDhlU3dua3E0L0wx?=
 =?iso-2022-jp?B?enlCWnl1RFBTR0hMbHJkRW1lakhST2pTTlRtaXBVZDM1elBqZWwySnVw?=
 =?iso-2022-jp?B?ZlZRNXRUczBvSjYxclBmSzNYTG5GamUyL0NPTTdwRUdiYXdaL0RrMVlV?=
 =?iso-2022-jp?B?NVE3b3UxdjlQbU9NL2Y2SzR6TjgwaFNPL3o2Q0ZpRDEzblI1djFseDhL?=
 =?iso-2022-jp?B?VEV5NEFMTm1kZ3dJd29aS1dJd0g0NmY4cVNkcHNoNXdLL2Z0dDNZcE12?=
 =?iso-2022-jp?B?Y1BpVUtGQmE4aTZ0d0IwWFZvVkRQSkFTMnF6NHZ0aVhVNjVFWEM4Z3g5?=
 =?iso-2022-jp?B?QU1aZUFqOTNHNFIyWU5POTAvTnZPV2JQMnZwTTl0VGNubk5xQjFFMEhq?=
 =?iso-2022-jp?B?WHFIaDVESk15TXZsNmJVMWpRWmFtRUZvc2tZUnd3cWJLcEY2Z3o4aGg2?=
 =?iso-2022-jp?B?ejRHdE5lN3dJS2UwUUdSVGF0cXZsc3gyQTBRZ1NKMm9sYWQ5UGtFYmhx?=
 =?iso-2022-jp?B?VFltb2I2bmRnQ0RCL2x2T0RySGNPNHdLcWg5U3I1K1JGV0ZTRG1jRWw1?=
 =?iso-2022-jp?B?MG1TcmNVV3luRjJKWGJJWE45NlIvL3Q0WmFjMzVvOTRnaDQ4WVFkWGwr?=
 =?iso-2022-jp?B?SGJGQTlPTEhVclRybm5OanprdnNWQzNSS21ocUdIVmNuakI0THpxOTZu?=
 =?iso-2022-jp?B?TXZDY2laR29nTGNobmdORm51R0dBUXR2OWRRcmRFY3ZrOWdZVkFBZ2p2?=
 =?iso-2022-jp?B?dmlWZkdVcFVsN2JlWWpzQ2hTMVppMzNSRlBMeFdYbG1BRUpFQW5EQ3hY?=
 =?iso-2022-jp?B?RDFzL0hXSGlTVDNDYkZMWnd5VndTOWVWUFhVOTVrWjhxV2N5U1VtaW1X?=
 =?iso-2022-jp?B?SWtQQ3VzQksyeUhTWWhYU2ZIUTNua1dXYURTc1FYcWN3eVBWZURtSDR4?=
 =?iso-2022-jp?B?WTA0cHY3SEN3aDhoWkRMMlJVZHcrM1lpQ1o5UkN1TlVnZmxVS2pGUVcv?=
 =?iso-2022-jp?B?dDhYbDBxL0JSM3d6dkMxcGRiS2VDYTU3N2pzUUJ1S2lNeHlrdXYvc2dR?=
 =?iso-2022-jp?B?Nm9KTXg0Y3VlSmVKRWY1WHE0UGxiUnNyajRPdjZTUDloUi9VdmhEdyt1?=
 =?iso-2022-jp?B?RnRiaGxHSmE1MEVKaDdwRFJHUTh6b2FabkVGZG9FSCtxOEQyU0RVY2RD?=
 =?iso-2022-jp?B?dWxTNlFRMGR6UU5Ca29kbENpL2tlaXVpYmFUb01qVEtMM0Z3RXZDbVBQ?=
 =?iso-2022-jp?B?a1l0ZmgwRTNzem50V3NEdTRLUTBDUnh6YWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4tjDEM03wF0TuqA3klwU5D+eNRNSHR9qSQ6V8ietoHh0BvfKzdO1aRw87M/sz1CJ8AIurCGMeZ++aocw6y5UOG23DhMx9IdqJtVkyjbUKx2xg2WicQCyHrQkgwtZ7iRPEx0xHDI1POCD7DZ9hfUFnSjTwn3kcqFAoJMtDgTyxQmw6ERjZl4ghBoZrUrZlVlslOMvvC+E4MG4/M5HUrF/+uuNkZJgryHDxkvtXBD7hF6YYEZCfTAzjRkUnq7YleDS3/Uv3qiSwLC5PYF6w4Ha2p934M8A2s9f1xUkRqZaqEiVNWKIrID2tCm+ZQtlRXJoVegKHHzonoDeBdFU6L3Rpyr392+MVX6TYUzpC7PdCkk7htIAmzac7KCSzXPr6EJ7mJW+1sdWHqIcEhvMbW7DOkvWquMLIAH+M/bdb7nah69zpCkMqpvzWsLrIO+58jsdmhPsUVBcKp3nBvDbWmrMY6quVuqT640aaF/yO259XQV+Ny+CDfLBliNoOFlp7uv/TZiOhh0QWacqtGvExce/3QmKmEIZlm3rs/WpES+zQD2ePHaD0oib+BNaNEuI0mvtvw9TUrioDzYt/2XZ82TfhG4F99WAHu01yifDprVcUr+cUz39GIt80vMPp+nQOGRSeVEm938ZlMqODbMQNCkQQhOlguB9kR0L+AhqS+1SwjtVti9Sb9kpuQvdZYIP8WRs8rJKeqXF0gl3qfO3tFu8lVBsvTulqcq9WQspwv061834QLtnU/qMfSEvJ/rH59kr65peWyCOq/5NWgAmbtkXHwBiKvy/8CaaXRFmcUneN8oIGWUUmuXCNqly5PSUtRlS9sCDZ92XPz99bWMrAyx6Y4ZoU3xcbv4iT4eYeOsY2lPpAOmSL/+nx4MPfQUm0/utT09Gl6acbCvnkWXV/yN6ZQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9f0c1c-6dfa-4bb4-88f0-08db662dadfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 01:30:58.1281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FC+fs4qEGqsmlqZqrOwTWcqTRhHhzo0De3div5yhn1fiPCDdxInRnjMGIRuuznIq0yPxN8Qw9O1xXM+JJhY0yioxW3GueWKqwGehx/9Kb8kTxoohG9pILvWJxFxdZgEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5763
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 01:31:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11836

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, June 5, 2023 8:05 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/7] Add SCI support for RZ/G2L alike SoCs
>=20
> This patch series aims to add SCI support for RZ/G2L alike SoCs.
> While at it, added DMA fixes for SCIF IP.
>=20
> All these patches are cherry-picked from the mainline except patch#7 as w=
e
> don't have proper DT overlay support in 5.10.
>=20
> Biju Das (7):
>   tty: serial: sh-sci: Fix TE setting on SCI IP
>   tty: serial: sh-sci: Add support for tx end interrupt handling
>   tty: serial: sh-sci: Fix end of transmission on SCI
>   tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based
>     on DMA direction
>   tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
>   tty: serial: sh-sci: Add RZ/G2L SCIFA DMA rx support
>   arm64: dts: renesas: rzg2ul-smarc: Enable SCI0
>=20
>  arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  26 ++++
>  drivers/tty/serial/sh-sci.c                   | 111
> ++++++++++++++----
>  drivers/tty/serial/sh-sci.h                   |   3 +
>  3 files changed, 117 insertions(+), 23 deletions(-)
>=20

I reviewed this series, there were no issues.
I can apply, if there are no other comments and issues.

Reviewed-by Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


