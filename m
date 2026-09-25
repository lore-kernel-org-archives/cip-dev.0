Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AFBC9830D
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 08:24:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3556.1790324681975862307
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 01:24:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=k4moWM2O;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1790324679;x=1791534279;bh=mj9N3s4Fx040NkgpRs+J1tEki8LuNYy7v6f6y
	sLKwfs=;b=k4moWM2O97jfnrskh/X6UNenUCk16zDh5csWaHeeZ3WtYX6JFdM21T7lEln+F/dEErT
	dBiY6ngapbQfZaUkvwu0rxpDmqT/YER+SDvwnyXt91O8zrsKqpXPgn9T15cLQ0uAKp+JWPlQpZ5AW
	CQaBKmUPJOHOPLOfqyv5PedOhv7bG9Cz/wd/taz7cACnd7UTwGBwdno3RvF9VI3OIXZIhRfiZu0Y6
	KSzNd/1CH1pHsFL7qrhJu3XkYne1UsHBfUiskb0rP7ps8s21p5mM+ssECxBfznR7gL+RlVrs8gU/e
	QG3hloSB+ZUhuOjPVkccoiq0zF6QotruEMCB2XHLbqew==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 68P8OdpZ2355055; Fri, 25 Sep 2026 17:24:39 +0900
X-Iguazu-Qid: 2yAamyCKsudy57rluE
X-Iguazu-QSIG: v=2; s=1; t=1790324679; q=2yAamyCKsudy57rluE; m=ngiy1UOKWR2/SPSsF945JFlWnnY02OcSfro69n5M3PU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hrkJl0H6tzyPQ; Fri, 25 Sep 2026 17:24:39 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuBbwaL5dgiXrio0Rmr+mrtgMCioye8eH2U3BMlsTgtAlJglV9Ybn3qi5nQ3qKKfdgOKYDqUnCwDvSBXcDseo5gNqn+3ce/3oWu1sWEzHsqJuct/tyqFqNxJDx5ceUwElKsjgt+BpWyd2EYCdbnZsY3uPVi37GVadayp41ESa0eTdhkrEyO9t5+HsSKmeTFmuA35H4OL/pZTEDTmxWRlDgNBROSTQ9QvT0Lb5L/iEg3Pi/GsWW5OW1bzTUtyWfAVo32sMav+8LWkZ8Muw07+/FLfyi8C7u6EPtvfQ7tUkHDltdh3lXgINDh+V98RuLVbRQVTAGFp9f4MIy89cycklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL0cwfBR3N6GG5oZC02ZA8QPHvPkkICIr0tVXjkQJ4A=;
 b=VP4CVe2+61rRF+8TUqZTnyHVx9h3BRgBrETMyL6UhHjYrNfGt6TT/g40aP4XB4kXU2xHwQpfgAum3N64YJVm7YirJ1nNSPsDoeLms7IJRJ5D0WfRbofLB2TrJ5gO9Bh2VVMR8lVFy1kHMD0D2GtmCvg5tOvmOnMKcMu1xqmEx/Iwhfzd8f00R9WssgBBFO4HzFCtnj6ST7jqe9/IR7QV3Qh5FZNLkwm3H94/uz5eTM5giyh92FLknaOC/jomQfL910uoxnNlTXBg+FxISMIa/USBHU0ImmWon+WT0cwMQh2PMoNuVudB7DExPW5N2KNdj3g2QbhXN738aw9kvZPQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@nabladev.com>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Topic: [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N SoC
Thread-Index: AQHdRoTpJGNwLYH/pUyse3FxathRzbbfAWuQ
Date: Fri, 25 Sep 2026 08:24:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184F29618545209EEF1699CD802@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB16045:EE_
x-ms-office365-filtering-correlation-id: 2293b2dd-d0e3-40a9-c8f7-08df1ade6ff2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 CCOcppaZTCJtYize3YefJNuKRhYGLu9C0bj4YTD3WPhSlaJv+WPWu1GaGw2sqsariYgXxfxwZDHOG2BpPrvjtwHW3mIqZEaoLvka3qItkOFVR4SKO5pmILioQ1/ldQxHzr6nQWCdb0wXhmqQ5MMWrIhJOxtCPolYaVl2ecEIcim4Sx3mJoPJgIP1TalGsYEnZsDIKAs9RwHoJ7gQrw9/v81mgEjHWvuZSTYyMQ5+ChHHR2gCgSIPl4ac3WPCq7Da4EwXwk43K02W2fVE5oxiQvvJLdpa91tEjagupqlkq8UUakXN7zhxQdp4NHbqbwsFv/z1Lps797REeu9YMXZffn4J/kQH1kK5rL2Nd5zpPB4T/5IPz8oyGy4Xqvt4/bCtOIpN6Yn5jDkkt90vYl5UCU1GKHFhrIbS/HkK8yonTgeRFGyDfsBNfLkeZQFiGINiIQdReCNh/LohDat5gQOZF1DX7jgyp8KupYeq7+IfdZmlQjlTud4dP1gm8DCFKayRRhiE6Nyu6XPAGPbgpAt5+CmpNNtroGoMkgKjZ31A/rqccd2bO6U/bc4DFwpHIqjGF5Y0zQCXvXV5E/mWCfMvg6JcXIibmxrIJhjTfRKDtHkWuvwGtbUld+QC2IH6ZTdU6sw+PUqcRWOR5rnXcVTkOHDyU5DaodI5pdZVCsaMBJc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OE04Um0wZ013bFhyekI0UFV4QkU2dmFIK0JvL1IrcW9VZWpXTm9kZm5q?=
 =?iso-2022-jp?B?V1ErMlVqS0twT3phamMyWE9GdEh5L2JhK0g5VEVQalk3M3kvWDZuQTRn?=
 =?iso-2022-jp?B?MXd0M0FWbC9ETmprTnk3LzBRcWZKTnlqYmE1ODJpSWtFOGZnQjk2Qjkv?=
 =?iso-2022-jp?B?UG1BTUNhNVZOQlhXQ3YwYnZKWE03MDYvanBrREhiS3dsK2JEWUgyMms4?=
 =?iso-2022-jp?B?T1Y4OUFoWXhpdUhLalNRMkY3QXh2MENNaEVZL0MycXdHQ1VPcTE1L1p6?=
 =?iso-2022-jp?B?bHlJRkhLbVhIRk5ZNlQ2bGYwenRaekd4anhtTGo1UEpVclBVNGJnM3k3?=
 =?iso-2022-jp?B?b1FjMUJ2ZVdkalB1ZlAxakhSYWNpVUNac3dqUHBIN0pobXBnQ3ZyeElv?=
 =?iso-2022-jp?B?WTJuc1NUSnExNTArZGVhZUNNY0FQRFprbEpucndlRnYxb1VSUmxpenhn?=
 =?iso-2022-jp?B?bm5xRnF5RzVkQVhxOC9YdDd5V1VORENiVVo2cFZTdVBoZEFIU0RyTHF0?=
 =?iso-2022-jp?B?TFJPY3dPRWZxNjUwaWZBakdzZ3ByZmFNcGM5cE1HZGEzaXgvcjFxMFN1?=
 =?iso-2022-jp?B?WXRmRk93UkJTOVVKd3N2RkRDaGxUaDk5c2wrNi8yK0ZvK1ZQZjRsOEFN?=
 =?iso-2022-jp?B?WFZIbzlIU2NjQ3hDd1A1My9CakhlZUpnTDF6WmIraDR5SGlScFFQeXVT?=
 =?iso-2022-jp?B?eXBDRFp0Rk4vZDVoaUh3VjFqYVhybmFmdk9maXZQdlRiTGpqSFNxNnlC?=
 =?iso-2022-jp?B?c1NjWS95aVlib2ZsMTFTVm9wbk92MUFFMUF1SUJaT2V2R3FzU2Y3dzdn?=
 =?iso-2022-jp?B?aytta09YdEhPT0ZleWxMSkxqaTVQK2F4KzROWmlucGc0c0hsdnJzaFh3?=
 =?iso-2022-jp?B?TU1WWGc0ZGZiN0RFYUEwZDlQdFJkdGRpNm9Gdkp3d2pJVk5JS05JOURx?=
 =?iso-2022-jp?B?azVNeUROTXFPYWM4M2NoVHpnS0t2UXY3Y1VybTkyVWxOU1picDg5dTgr?=
 =?iso-2022-jp?B?NGJtYTZEbG1aTkZIUnZBZkdBbGlNOVdkdHBvSkhtY2x3TkVROStmMk9a?=
 =?iso-2022-jp?B?d2IyalJLKzY2c1ljTWNWTTlNS2dDdnpDQ2NtbjMrUWtuSENHS2NYaDA2?=
 =?iso-2022-jp?B?N1pMZnhaVi9VbXdMZW44VlpKWDZVRWRnZit4cjY4MWUwdThsWjVidDNr?=
 =?iso-2022-jp?B?MFBoMC9oYnVTSUpWN0wwVGZrdy9paDdBUXM5dkI2WGRVWUpZdEJ4Nlpq?=
 =?iso-2022-jp?B?eW1UWENNQnBRS1JtSkRJaUlrWW94NE0wL0g3YXI0VGk4MjZoR245Zjlz?=
 =?iso-2022-jp?B?bjFSWjI5dkNwNGtvdDJnK29NNkZQOFNPMGZ3bU02SXNlcDJqdk5ZQWpq?=
 =?iso-2022-jp?B?Uml5RHY4NTZKUFZ6ZXFxTitLTkp0ZmxITGJEZEhCT1BUeWgrYnpoaDZE?=
 =?iso-2022-jp?B?VVNrR3JMWHQybkNuQzBrRWxWMmVseUN6cUJoUXp5WHcwSjQwelNPMDlV?=
 =?iso-2022-jp?B?S2FaRkJpVjljSWhEd0grM3lHU2xuZHoveXNHcEgyRXFWQVJkTDdUK2xu?=
 =?iso-2022-jp?B?MlRiRC9zTCtlV1dQeitkeSt2OUd4djBwMVVDMGFRV2xrNFg0YytkUzMy?=
 =?iso-2022-jp?B?NFNSVGNwa1VEWDlGSm5CM2hvdVpqYnB3aStGYm9iYzBHKzdKV1lOcHBO?=
 =?iso-2022-jp?B?YVB1WVU1TE83bWpsc2tqd2lyT1FoSWVtUTlLNDlrWFRUNFNFM2IvZE9P?=
 =?iso-2022-jp?B?MHpyMm5jaGtRWkVzRk8wb1gzQlpQd0pTVnFod2tsdFE3ZHFjdnYyL3NV?=
 =?iso-2022-jp?B?UHpoSkkvMzNMUHlSLzNSTEd4dWdlVjhTYkQ5MGNLU2dmMVJJNG9ZTHds?=
 =?iso-2022-jp?B?N2w2eDZPRjZQcmZIM3hBWlhHRTlIbVV2eENmamp3UXlSRXg3bkl5bXVy?=
 =?iso-2022-jp?B?eVlNMlpUTWlDT1NVREswMGtuOFM3YW9HM1RoajVqU2V0WXJBbCtSdHJ3?=
 =?iso-2022-jp?B?eHF0T1VIUUMzNzM2TWIxM0p6SjZjcERMMWE2YmZXMFh4eTVQRDdzZVY2?=
 =?iso-2022-jp?B?RXpiQ1A0T0RIcmtpNmlBbHJqMStITG5taU1RSEZMWWptQXNUMmFvR1hx?=
 =?iso-2022-jp?B?TEdTQkhibDFUZ21ubWsxS3cwb3lyek9rU1BDNXhFbWttNDdYTDRLZVF6?=
 =?iso-2022-jp?B?WnBhTUI2UTl0ZDFoTitJQ05oL291aEhhYWl5UDFPdHBNS3haZ2c3TEhN?=
 =?iso-2022-jp?B?WFZ3THpicHdncHYvNGVqcHVKaWppaDVPSURIOWdCbU9jUzdmZ1dQMk1u?=
 =?iso-2022-jp?B?VlcvWUFqRHJFMGlscStuejNGWjdGMndEUDZWekNjQzVNN0wrR0s0UXhx?=
 =?iso-2022-jp?B?MGZGajQ0RWRVQXJpWU5qeWUxT1ZXVklWQ3h5SzF0VWlvbkVzQjE4eXNz?=
 =?iso-2022-jp?B?TXR3U1YybHp4bldkN3Vyd0wvbWE2ZWFSY2UyeXJobnRzNnkrK0xqa0Vr?=
 =?iso-2022-jp?B?SnJpSk9qMUVhbzBqWGozWkNDNWQxVUlWWHBCL3RXWG9VRTZVdnlMa0FO?=
 =?iso-2022-jp?B?Q3ZPL0dBQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	jLiBXpJir9LpI5HRnHDRApsAlKoOvamO0djo3jMfb8iCofXVD2YWTnO1+i+wVelVqlW87WSpyQ2RaEnHOMilqL/KZe9A3ALxYJ9erj9VrYKTPoUHCvsO/VhiMnUKJi6er8gh0p369AJl8398VpiqnLb3s6YZgtbFr4DS/AjWMP46DaDdQswrDBw06YLmw21P2byAAdVYUgEvLCchdjG0VtwqGC0YAirSU4F56rI3Rf0ykbk0U818IELu+aTTZnMmNyWzpi0IG8j3m0rpxUpL4xlwV21PrusOjm+qu9x7ND3FDliYjvFTlTYrQdWssrcYP6vMPWPFJxZOGO4+eItXhA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2293b2dd-d0e3-40a9-c8f7-08df1ade6ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 08:24:37.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obm4nHvxrxDreqMiJi05L2aY/YmtPtLLl3xp0fGrRAAJWhHyFemkR2PnD6gBzfP1ukD6cw+ioQEZJ7D632sGltEnDWqXElKDYwsfU0iUUaF/luzr4k/FRk+DE/7xF4B0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16045
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 08:24:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24345

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, September 17, 2026 6:14 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 00/10] Add RTC support to RZ/V2N SoC
>=20
> Hi All,
>=20
> This patch series aims to add RTC support to RZ/V2N SoC. The RTC IP on
> RZ/V2N SoC is identical to one found on the RZ/V2H(P) SoC for which patch=
es
> have been already backported.
>=20
> All the patches have been cherry-picked from upstream kernel.
>=20
> Cheers,
> Prabhakar
>=20
> Lad Prabhakar (6):
>   rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup
>     error path
>   rtc: renesas-rtca3: Check RADJ poll result during initial setup
>   rtc: renesas-rtca3: Fix incorrect error message for reset assert
>   rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
>   rtc: renesas-rtca3: Factor out year decoding helper
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC
>=20
> Ovidiu Panait (4):
>   dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2N support
>   clk: renesas: r9a09g056: Add clock and reset entries for RTC
>   arm64: dts: renesas: r9a09g056: Add RTC node
>   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC

I reviewed this series, looks good to me.
I can apply this if tests are no issues and there are no other comments.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/288=
1561788

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


