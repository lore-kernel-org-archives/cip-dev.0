Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8F7C982D2
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 06:13:27 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5220.1789711999997726125
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 23:13:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=SOT9GUTq;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789711997;x=1790921597;bh=vwSjquqvr2eM7y/6dU+ywwrH4NXEZE5zwCQIf
	wBVNLE=;b=SOT9GUTqh+mrQO9Veb003/seXHjIQpVElfjSAvJhfTtyl/Vlaw0Kml0h+LdkdJ5Cjjm
	1gb4tz25vK9yTDvcA6lxH0nqNLVevlEdAAaC2TnMRMbAJP5lDJs0Ok6C4RFNk6VxEWypyREAk1wPj
	njbpzMFQhxx+2liyknQlx3YO2iW7XpDybXpTJePMOyUqWMpUOSKgvfoi0QIx4h1LO3osRNI6Dx9eC
	klEHjxXtybM574NoIle5JxKMMda3QpiHFO97iV3PCzs1pOPOBuquH/uVaDxLDzYGO9nUdjs50bK+U
	o6qJrIDGj6WePeMLK802I1wcJoF9mf0oueAqPNtwt5Tw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 68I6DGnK466756; Fri, 18 Sep 2026 15:13:16 +0900
X-Iguazu-Qid: 2rWgSEmgZL1zpLihCW
X-Iguazu-QSIG: v=2; s=1; t=1789711996; q=2rWgSEmgZL1zpLihCW; m=+AlA12T3TOfKNOOAiWe1gmOunmWC9I9hPR+pIuaI34E=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hmMkM6yxzz4vyt; Fri, 18 Sep 2026 15:13:15 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwZGLvevfN5AatPbOaCMIISkvvVrmi0yPi7VTyKl9qUXGdgZeS4r3pX2XH385v3W5Atj+XZAQBnu577ZLj13VtCR1lMFj8Z/qzVOc/TrhUqOnz1Z/1FlcXZsungbg21dvFg/zwVa5YUQHro+nKPpy7TFdKQJ+5Vc8rzVLjsSI9HdAItKKPShtp80IDCjU81BsK/BfYPNOxOPQ8kLOoquBscfZxge8e5Gf/ctu6ixx/FTYsIKijsvgTgXGCPba3Wj93Y9DMlGui/nPBuwHlyDzJ+pm9bA00MRdRzvx9VKjpzcCGWmXQBexE/T4bXJ7vEyYuEIEERsQNJW6V/3QFAvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL714CM3Cp1pHsOtA8OwMXtaYqzvZ0054hp9+czpcMM=;
 b=d0fseM9Pr1qVI/iteBPtM6m9e07R5Es61IUktKKh6qs9s1tIBG9BVUGFYotvSJec9fVo9UaL/MS0gff+ZzPHlcm/74JP02lqSRaCgC5fnhYU6qH+dUvK5SYbV3yIDRkm0MQLK2IxWqazJuqg9fxa+lY3iDVDpb9ODOLudAAxiguJzkhHnkdglm0ouSAzXwF5KYvssfpg7JZXxceCc+4uFTe/LuPnKcgUNeIYIGPwhnmjwWFZLT85zcutlRbNzsD7aaBzuK4Uxavxe5s9LKHHKo+XLKttev7v6MXUcv4siDk6jrUBjC/3z25v3ZlZz/NFeElIIR4kX82D9lwSx4qv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <claudiu.beznea@tuxon.dev>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH linux-5.10.y-cip 0/2] Backport RZ/G2L GPIO
 set_config functionality
Thread-Topic: [cip-dev] [PATCH linux-5.10.y-cip 0/2] Backport RZ/G2L GPIO
 set_config functionality
Thread-Index: AQHdRQ0I8LsQC/Ah10GMkBDXUBpyRbbPpWeAgAQ5zrA=
Date: Fri, 18 Sep 2026 06:13:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181C06A929C4E81032994ECD872@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260915122321.2531353-1-claudiu.beznea@tuxon.dev>
 <aqlKxV0w0aV6z3IM@duo.ucw.cz>
In-Reply-To: <aqlKxV0w0aV6z3IM@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY6PR01MB17410:EE_
x-ms-office365-filtering-correlation-id: 80998b64-1167-4426-190c-08df154beb58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 I/ToqP0xf+V3WP8UiXNQEF6OE8EbLlZM9y0FH71DINTPMmKuoU084c6q1ucJykF0giNcafWkNLwV6/QmRr9gwWPQ1cUPaL5EQQHIA9ToxoR7QgQbvqDBlTnS6yC7py2hlH7OcFik0SzWqcpDHg0+NId3HKTs5N0XjD08xjVORLgpDhJqEnMMwXfLGNfS4BVToyM1FfCaUccbw8T7B4dJ67dEhE76TZhYsgigZ3z5rUWUvK1RnSZkwywsKzwE45OGlk6bS0nt1+o8zWqzryRvXdqtes+OFKecVS18jhjalRmshUfsaVsV23EomXD+s1V5hVF+zrjMw1YgsG2NqM5OnVbzgoF3MbKbHxEvNQRdpyRexeGVzCbPkuvTjiEyg7KvGPigkjbWswanHVZeV28OtsaomrRCyvnvxHDf3cVT2zOoSO9f+qDm/79XGzZS0AQA3rPnGjDf/cPquczNa2e0KF2a87E2xOENx1/pZa4iY1v1xHUoqjb9LXoOZQ/OBDv4rdYhxE9ILdWGKHNcj54OQ5FxHdACi8YaTCKaoStSTerep48ELo30iG7xihJFAAgbnJGofC2CRWjHlDVC7NFhUiMsWI8O/2IHkePlnN4dPPrPMnPFMB+X2UVL52Bz3umd81QRcEp8TqCj7ME5+zgzcBNbNefYlU2wwS9TMV15j1AmBwUKgH8EEQqNECEGyU3KgnTtqmVwfBfDhRh2252yyg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?elRRQ05MQ2cySkx2WGhRbk9YajZPZUR0VGFMb0VRUGxveTRCekNQcjYy?=
 =?iso-2022-jp?B?eUxuM1kvUm1lTkkrazZJWSs0L0ZqOWRtVnFJRWNFZmk2WlVaRXNpL29V?=
 =?iso-2022-jp?B?NXl3TWU2UTl4WmZVUDcxNjBzdUFsb0Rkb0hBUThHTlhyblhMYm1FczlW?=
 =?iso-2022-jp?B?aEJUODJSZVZUb1RtekhYaXpHMWJUdmZBeG5HS1ZvcmNuREZ4UU4wYXkv?=
 =?iso-2022-jp?B?ZDE3cXBBSEtCNldLaytBOGN1dVpMbUVpV1BpZ0JITS9XMUVsSmdTdjQw?=
 =?iso-2022-jp?B?ckZSNlFTTWFKSWVnaTBNbzdJemRnbUZuRGNOMW8yZWUxbS8vSnpLeEpa?=
 =?iso-2022-jp?B?K0txMUxDbG9admNTeitnKzNaUHN0L2hiQzdaUndjQzAwaHhvSGljSm1L?=
 =?iso-2022-jp?B?eUtVUVQ0Q1R4WUVvZTVaUEhucTJUajA5OTVrV0wxU21abnFPd0Z2cWZH?=
 =?iso-2022-jp?B?ZlhrSm92NnVzWGdPRFNGRFV1ZWJSeXFDTHVwYUNsMlBxOXZrbmRkOWQr?=
 =?iso-2022-jp?B?V1lTR21yb2ZnVFdkNDFGK3dEdXdDeWY3NWhINWs5RWhBM0gzUnJ4dFdv?=
 =?iso-2022-jp?B?VXM5bm16eGtBZllHOGhucjJaYzRPU1hxWGZZeFBVSmxUOEs0Y2FQTmIz?=
 =?iso-2022-jp?B?S0MvKzFJSUxrSFNKMXJRYUhDb2xYNlNpc1hxNkJpMmh2ZVdVYXhvNngv?=
 =?iso-2022-jp?B?bWhON2NEQWVMZjE3MWo0ajlKeDV2MDhocGhCRHplTVpVaW1MMzdsT3Ay?=
 =?iso-2022-jp?B?ODlrTS9QWXQ3dDJTOWl2N3JHc0tWYmorZ0tLOCs3dEs1eHBkWmhkMGVQ?=
 =?iso-2022-jp?B?KzJQK1Z5YnJDUzMxN0Q0YkJMTzZ0b3Y0NUJtanJRQjRKc0IyVFBTNkFu?=
 =?iso-2022-jp?B?ZkF5SWFUV2JPK1I0TWlKeVIycnhaU3h4YjdsUTJlWFliL3hVSllZZ1Jq?=
 =?iso-2022-jp?B?VVNnU3BGdlhhd3dvMXJ1RjhZK0IxK25CaHpzL3VOdHlsdU1zaFRseU5B?=
 =?iso-2022-jp?B?TXA3V1d5MzMyZVNzNkpWQ1VVNEFza0pneHhPYjc4c2x0NGhYVzFVNnYr?=
 =?iso-2022-jp?B?L3BtTXJIWE91L24yRlFLeVcvWlNmWE1LRURraU9BaVhwTERReVBVcmsr?=
 =?iso-2022-jp?B?MHEzRk9DVmxzb1ZRUHcxTDBwcXEyWmhhLzhYTitXdEZIMHc4VVZhdmVT?=
 =?iso-2022-jp?B?amx4TXIzczI0dGk1SG5PanRITEFvQXg1TzZSOFVZWUZCQ1ZxT2VveVp5?=
 =?iso-2022-jp?B?dUd6M3JSeitaOElHWnVCVlR6YnhjNnZrU3U1Qi81WHdiamtnbXozTWtR?=
 =?iso-2022-jp?B?OTdUTjVZMmlFT2pQQkR4VGRodEhxb2s1N0Fla3ArdDRtTUw3ZHprdVpF?=
 =?iso-2022-jp?B?ZGo3QTNzbEZIeW5hb0tlWEpnMUlJdUplUGsxUnhoVjdFMThuQ2tHWHkw?=
 =?iso-2022-jp?B?blc2bHcwbm43ZUdNb2ExYWJqd2NyT2hSa2dRQ1FWaDZXT0wwSm1EbFhn?=
 =?iso-2022-jp?B?TzJzWjRoemNhTlp3REJpWnJZVVJNaDdEbnJkSUZ3V2w3cXltVFc5djVq?=
 =?iso-2022-jp?B?NVpHajI1bm9JYnhjbzFqMytMUEhGNkNaMjhGU2EzY3UvV24yNlNZbkVw?=
 =?iso-2022-jp?B?V3k1UEFDcTZlTU81ZGJMaEQwalRMdHVYcDRJcmxjUmdDekJ5bFlhRUdq?=
 =?iso-2022-jp?B?WHlUZDBxUHArWGI1Q093ZHBnTmZkWmF6ZmVoektNL2toZW5IN0E3UVhE?=
 =?iso-2022-jp?B?RkF6THUvUHRtbFRzMzdHRmtGdnE0SDI1RUtxZ1A5M2hNbU1EbkJLYUNk?=
 =?iso-2022-jp?B?MTZkZmxCcVY1QUlxYU5qcWJVdWwxMWs0QkZYQ3UveE9ZcGwvWGpRamI3?=
 =?iso-2022-jp?B?c1l0czMxcmNtNUZpV1hKQkR3R1FpQ2NET1c0b0JaZHFSWlduRUMrUFF4?=
 =?iso-2022-jp?B?QVhDQndjZWUyVUpTZEJ1cklReTQwa01Zd1p5VzgvcjZzeGd2VCs4Wlcx?=
 =?iso-2022-jp?B?MW8rSVlzVzdGU0tjbkZJZVBib1pRMmdIVi9pZ0hBamVVWTM4UEs4WmQw?=
 =?iso-2022-jp?B?djBRMnRSaFdKczM5UEpVMHRmNDdTOUlpZThvU2k2dGpLT1h1N3B3RU8w?=
 =?iso-2022-jp?B?RzlzeG9IUkZOb3QwaWNEUFRUZGhveVhrSzdrb2ttMkFKanh5bXp2N2hw?=
 =?iso-2022-jp?B?aDU1M3JPejRCTXNxWkV5dGdzbzRZY3g4Vmx4T21YYVhzRmlmSldrTzBi?=
 =?iso-2022-jp?B?U3Erb0hXc2RvbnNvMENkbU8zN29FVW12aitsRkNhR2hXaFBCY3FIRnVp?=
 =?iso-2022-jp?B?UGxtcng5ajArTk55TEtBbFd3ODdRd1dlSlFRaXhuRnpaRjFrRHMzSWFn?=
 =?iso-2022-jp?B?QjBqQmYxVWlCRGpSN0JzTWQrVWM0UCt1c0k4dnNXSWtmWnN1ZnNyVEFm?=
 =?iso-2022-jp?B?YUpCUThsb2oxWUJJWkl4SnRtZXlaL3RzWGtBRDd5NnNFMFlPZjE5WENZ?=
 =?iso-2022-jp?B?YkFsNWtYSTRpYnAvVGRuVFplUkN4Mk9jSG9oZFR4b1ppTUoyTXZ3aGRZ?=
 =?iso-2022-jp?B?MXlYamRFWT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	l4XegtNuwFUhPpsQmA8zz0OtnNuH7XwL5bq7uybq6Mv4TCC9DPWbNbJkOTMsFDq+JF+kFxX5CEpyYs9DNAveoe9tyCs+hFVfCTtqhLNMfeJ3k0HTSp33zPeOCUHHU5chT8/+S9MomEfuQjRFIqrD6QvgvrkFLMdh3WO3pYN1hRzVqZG7YwjcqNiJKrwt9zdFZNW9+t8AsGolnA04vfanlgXVrJqJg+7dwp8GQYD+oz2ZdbnR55ZDXZ1NS9CY9ikP/Sw3EIdeWzlUgVJuNCv9jtUlfZK0vBTjwXRCL7M4amNPaprNhaDLlz0Y6qUA5yDrHt7yNRJnbKgF4mRyem1aVw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80998b64-1167-4426-190c-08df154beb58
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:13:12.4414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7pvvlinUthsa21jfoj9qawf6E6pQ6zx+tCgNf2qxqRMNhBqiAlNGnjhSJmuYP3U5MO2Ggl0iFNODcu5F/vERNMeHzECY2eF9FhCwO6YnVYoXov9GcswsOkchv4COs4c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6PR01MB17410
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 06:13:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24233

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, September 15, 2026 10:40 PM
> To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@nabladev.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH linux-5.10.y-cip 0/2] Backport RZ/G2L GPIO
> set_config functionality
>=20
> Hi!
>=20
> > Series backports RZ/G2L GPIO set_config functionality.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks good to me too.
I applied with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


