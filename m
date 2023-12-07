Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426DFC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:49:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.84033.1701956965589217501
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:49:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3B7DnHQk3977709; Thu, 7 Dec 2023 22:49:17 +0900
X-Iguazu-Qid: 2yAbKbmwFzW9vc7Sx0
X-Iguazu-QSIG: v=2; s=0; t=1701956957; q=2yAbKbmwFzW9vc7Sx0; m=kcsbLcvAbWJiAerxsE4s3rVTqvWg5K276Y0VDtVKtyk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 3B7DnGPb616862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Dec 2023 22:49:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDZHmOgf9j9OybE5UmwCgnpS3aD8DQGLC4xKWfnLPkxhNGWSPuu/gKMGiHfAh7ZZZD0mDg7GMtMmxrqcLtgNNQVoMNvOGjA5bXwu6gfpwMaziOQEcDWiC4gdVV13yzUEUQf3Xm+nFdbK0gtjCqU2jYfjBP/qHVI0qNhH1RaGDdx7QafF5bgrtOLRFqw6VpvdH1uPPpPqE7S72rdmHS4NTKX00cYyAPHejVAlg8ikHHUiPXF8JvQxS1Hs42q4jDg6ytNNhii1fnaTU8Syu684VtGjzZgVkyjsvdV/Jj79Z+cJEY8voMhK6U8J4329m5Rb/d1xjSTpSnwg7Zr131hnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9tvHelQVG2R251KraMQO+vF+K6iH6O1Jb3IS7FPEwo=;
 b=BqYjWsnNL+cenb5U8bHfz2a4ensQtqNIFl3fS2lmp65MdpyNfW/Wxi1yEPpD36Gf7+i8R6ykR7UNbOG+9hlUWCsQ1lS6ol1ixnV2VLjrU6icqk0Jsi6wnI7Pso8Cjm7GAAytEQRzGmB6uvZYAoMCifAFl6UKDK1eHpgwDQqYUzguoMK8e+uZWJ6Pn9Ns/emt3b9WWePYV76oZr2iF+bL9asol2wKqhMdHUBRYvBY8aFB4rduTYCxqbaqPqTXblsEeKyfK8bDUfgxjV5ZqL1yp9lnNUCoB9devwvjSOyQw7t7h5VwkcZ5xvY3Y5lDOlgNP9qVfByMJgnH3zdtL81Ywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/12]  Add display/dsi/gpt/poeg clk support
Thread-Topic: [PATCH 5.10.y-cip 00/12]  Add display/dsi/gpt/poeg clk support
Thread-Index: AQHaKPvgpDxlFQBG50CE8yaE6n+o0LCd1fVA
Date: Thu, 7 Dec 2023 13:49:14 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245FE499E04243865C3667E928BA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OSRPR01MB11772:EE_
x-ms-office365-filtering-correlation-id: 97814bcc-4cac-4a1a-7e6f-08dbf72b4cb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QCVeXg9JenE3d56gzJOZAJO0r7Bg3axQYX6nNushQ09F/OETNWQcuXsS6ssSy1YC6B5Q4PN6Y8SsfzVE8xZ5Nqf+8LGMqZ76a86jz5EUNOkT24iNhAb2I/mmAxLWfWUrUFSpnxiuj2F8jsddnG5sfD7Hr2BrjjgLXs0o5udzIpNsvmCk/L+EcuqcisPaZ0hFXmWQEoyJzkSa6Pg1EDpeRSsXT+T8vezvmDY52Za7gNJY3Yin2N2ORZIR2gZDsBogGbkQ2LD20rkYOQMbwAvu0dTMab/OAdDLtEVnOOEig7sYDrPtR6csTGnmFUFd1xoyFeeyqi1Tfgf3sKiDW5HEul4IRjv7OCsePxQjHZxCmDTtkTtLexcS6ZjY0jIWO1Iezl6GU6FQxpUekKGEexTp5HJ+ZbGYChewqInHGn0AsluDuZ8I8z+EAjCI/VXwOTaI2mC7XGwvUj/oM2woifVFU2RW3MVKiV+BPOaVAi0lepdbpf6/nbHQkdqRpj5kkMHOK0VIlh0Gg6HQvDC+YT4vZJ4wm3X+Yqiz9pfrwm2ngIxAUIFD73ssvLX6Oh7IJa41X63+MN9g3D5KsY6FXNBRFnxqgripoe7c+ODmFS94GwApU9B3JaX/tosR/xaA65uuY6h06Y5da2fyGwmyQLS+GA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38070700009)(2906002)(83380400001)(41300700001)(122000001)(38100700002)(9686003)(52536014)(53546011)(7696005)(6506007)(8936002)(4326008)(8676002)(86362001)(966005)(76116006)(66946007)(66446008)(66476007)(66556008)(478600001)(110136005)(33656002)(64756008)(55016003)(71200400001)(316002)(5660300002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WGlOK1Zxbm9FQWZpWStiRGIxNXl1V3h1dFhWdHNubFI1RklMYitMR24r?=
 =?iso-2022-jp?B?Ylk5K25WL2pZc3ZOLy9VU3NNSTdsTlBOd09Gc01TNU1xSUFiaHYvU0U0?=
 =?iso-2022-jp?B?eWNQbUQzLzA1QWNxVW1KRTFUN3I1dU45aGgwcEJ0ZnV1NW96YUQ2bFl4?=
 =?iso-2022-jp?B?UzBnd1BQQ015NzRIOWJRdHA4c3h2ZmNQQVJYS0NhU1FXRUpNaTI5RWlP?=
 =?iso-2022-jp?B?S0FaQ2NUQkhuYW5OM2Jyb2h3Ykk1akFWMmVhQXhaWUFwaW5vVEpWWXV6?=
 =?iso-2022-jp?B?K0pMNnlzUWx3SmFES0UxSms4ZmpweW9oYWxWbGtPT1Z0aHluY2VCb3JZ?=
 =?iso-2022-jp?B?eklZUm9mMldDZzBmNWdLS3hNb3dUeGNKbmdQK2lSQVBSQjZpcU9LQ1Fj?=
 =?iso-2022-jp?B?WUpZL1NLVjJVY3ljdnJpa0xtZHRtTFlZdmk3djk2Rzl1SzhRbGFPeHkw?=
 =?iso-2022-jp?B?V2dWQi9ndlpEdGRWNldPcVhDVmtVT09vbTU4SE82S041UmRKR1lwY0pK?=
 =?iso-2022-jp?B?RUJvMXJ2aktoYXdJRWFrYVV4RFZIdDNRM1VwZ1Fpa1IySjRONzVLbEV4?=
 =?iso-2022-jp?B?RVU5THBzbkU5SnVhdmZmZGs5cTFGWmp3cC93VkhiYVJ5ZFdXTFRxMjd2?=
 =?iso-2022-jp?B?Y3lqVHhyOGY0ejhqcnI0bllEVVczMld4ZG56aHJLRnRET2tZcXM1ZEZu?=
 =?iso-2022-jp?B?SllwcWptdWVac3h3d0hjdTlKQ0VNRlgrS25ZL3JDZmFTU1ROa1VrR1Ns?=
 =?iso-2022-jp?B?QklTK1B4ekhFNG5qK09hRVZ1TG94d1N2ZzdKK2cwUWY3NnFLM2V4NUQ1?=
 =?iso-2022-jp?B?bi9yNit0UFE1MUJwVVFNMjlwQ0pRRi9ESWUwY1hmR2tFT0lmVHg4MUlM?=
 =?iso-2022-jp?B?dXk5WUtSeTYxTUhGNnExazg5cUp3M0VGVCtrZkpDQVdHQkV0UVJGTWp3?=
 =?iso-2022-jp?B?ZEIwWXBTSFc2bDUwa2E0dk1MQVZ5dEI2VUpHVmV6b0tLMHp1QWZobWFL?=
 =?iso-2022-jp?B?RGhvNHp0bU9NTkd4QWZ1VVlyZlZaS0NOZ2ZSdEhDbnBDOHdTYmVKbzJV?=
 =?iso-2022-jp?B?bmhjb1Jqa2UrODgzbWRiUXZ3MmRDcjZCd3k4Z1AvOCtkUkJVcXdvOXFD?=
 =?iso-2022-jp?B?T3RPLzZhN1pWeG90MHRwQXl0MUV6Qm8yd3V3ckFmc0w2VndZc1BKZ0M4?=
 =?iso-2022-jp?B?d2Z3aEZFSTNaRXNQYkwrajNQYUgxZVJCaUZwcFJKRFFKaGNjUGdBNFlI?=
 =?iso-2022-jp?B?TXlla2JobXZSYkNRNGsrOHlwU25oWU9UcDV0aG5SUFNndGdFaTRZL2dl?=
 =?iso-2022-jp?B?WEJpTG5xVStURXJPWE9wYjlFNllOa3B5R1ZCMG9pN0ZYQUhhaHcyc1c1?=
 =?iso-2022-jp?B?TDFwZ3B4MjB2Q05qT3dzZk14OHh4N3VPZUhlSmZqSWkwdmd5cjJ1VkpC?=
 =?iso-2022-jp?B?eTJxVzVwQzV6cG5EVzZsbXYvWDF0MHR1TGMwNnpIOWpXdGp0N0lONUN4?=
 =?iso-2022-jp?B?NUR6c255VFBTK1JQSmtFN0hnaFBpa1VnS21KV1hENGh3MSs2K2Q1RS9l?=
 =?iso-2022-jp?B?ZXhkR2kvdjlJV0g4T2lOU2k5YnRWNnhST085N1FxWVBPZjIvRHVRUFVm?=
 =?iso-2022-jp?B?RjgyZ0txUDRKRjFPM0VjeTJiRTJiWW5icnVsbGpNaGNRSWZoZ2tuYkdL?=
 =?iso-2022-jp?B?VVZmbWtlZlcrRHVJMDRucEVjd2lkNEpwK2lJREdzaXVCWUdpY3FYemNk?=
 =?iso-2022-jp?B?SDVYSHgvVlVXajJyUVJjV1E2U2JRejVQSnhIdmM5aVFIajFPWU1BMkFO?=
 =?iso-2022-jp?B?WGJ5bXg3NStQTGNKdUJGVmdLT1BLbXZzSmp3YWl4YWhlY21HbnZnNE5o?=
 =?iso-2022-jp?B?WDNjcitxWU41MlF0cGgxL1pBOFdUYnVUTUVYbTlraC9jdVNySnZ5ZFpJ?=
 =?iso-2022-jp?B?TCtmT0ttS0I2Slo2VUZrNUJ5OEhla01sTzU4WGVwbjgxSUlWSWdpYm9S?=
 =?iso-2022-jp?B?Mk1yOG9mUUVxVDJSSmp5SXRZTFVsV0xHUkNWTExqMTNJdGhwL2JYU0ZW?=
 =?iso-2022-jp?B?aWVyTEUvNHpxTDhDbHp6VXhCOHVkdnE1UUkzZ2kzdW43NDFhYW9mNXZR?=
 =?iso-2022-jp?B?c1FuNFJhd09kbFpzeW01bGpzQ0h1RXVLMS9iUllLcFV0MGQycXZqRGp3?=
 =?iso-2022-jp?B?WWlmSVFCaExXbTM5VktKMW1jVFYxOEwxNXNOM2dnK24vbUNQQUFaRWky?=
 =?iso-2022-jp?B?djJoZVhBbzlnVWxURGhQSCs0K3ZIQkVwSWtjQ2VXcTFoZXBoWGhVb3I2?=
 =?iso-2022-jp?B?U0JhNHJYYXVBNm9oU0lWMnN0OUlPUE1jNk1xM0RrTWRTNkhreVJjMHdR?=
 =?iso-2022-jp?B?SmNqQ2FXRW9ZT0w2MEdLYko2aS9GaHd2bm84QzRINzhzKzZHRVBFQitR?=
 =?iso-2022-jp?B?TlNWQXNIMnNqRUl5RlBieHMwWndCVnlPc2I4PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97814bcc-4cac-4a1a-7e6f-08dbf72b4cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 13:49:14.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TcKJkoPB/a1NHYd56TG3/HYAwGhjvlGIlgvwGz1GJZKENeD1oIOcVxyud4uZpKdi1rth5VI/FtYV2Meo0MZ0+hRY89EHmWrumWfzFXYrgXgf8Nmln0lor2pgU00+yRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11772
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:49:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13862

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, December 7, 2023 7:55 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/12] Add display/dsi/gpt/poeg clk support
>=20
> This patch series aims to add display/dsi/gpt/poeg clk support support on
> RZ/{G2L,G2LC,V2L} SMARC EVKs.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Display is tested with these clock patches. Will send DSI/VSPD driver/dt
> patches soon.
>=20
> This patch series is depend upon [1]
> [1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D807162
>=20
> Biju Das (12):
>   clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
>   clk: renesas: rzg2l: Add PLL5_4 clk mux support
>   clk: renesas: rzg2l: Add DSI divider clk support
>   clk: renesas: r9a07g044: Add M1 clock support
>   clk: renesas: r9a07g044: Add {M2, M2_DIV2} Clocks support
>   clk: renesas: r9a07g044: Add M3 Clock support
>   clk: renesas: r9a07g044: Add M4 Clock support
>   clk: renesas: r9a07g044: Add LCDC clock and reset entries
>   clk: renesas: r9a07g044: Add DSI clock and reset entries
>   clk: renesas: r9a07g044: Add GPT clock and reset entry
>   clk: renesas: r9a07g044: Add POEG clock and reset entries
>   clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write
>=20

I reviewed this series, LGTM.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



