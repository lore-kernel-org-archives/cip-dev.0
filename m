Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00887C4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 10:42:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19808.1784630559153724985
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 03:42:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=cHYxzT1q;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1784630554;x=1785840154;bh=+JyFB2KVaJoUqquOYujmIaFq0JLayifOMaZg5
	83tmaY=;b=cHYxzT1qx/zrovnsjf52UGszO0t3bnuqCHq5hnCILHS6LzPc61KU8+cy8utOFksY3DS
	ARJvDuKwSuTsz8bA/VEoDhoRJQ/OVfq5MDWPotn/HSpXUAj7yplWKjeT0El5KJq+vMjuHq/vtHfbJ
	6nCCzg+na18i8rRQ8Mbup5yDXD/eTPSnXs6IDsml2ihfMZWzUCzaOsKPtrty/E8v57Y7bKkKGO1bV
	YK0vu3HhTyKofwauGrpl2CunyYiP2MDl9hZ+Yg71YoCUSehcAaAvvQXmcQ0O3Q5TCsJv3PSV4wp/V
	BPWjgc6EBhBspQaFBg0wPKnXcQDU+7XfXQ/a5S0QBq+A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 66LAgXic4136904; Tue, 21 Jul 2026 19:42:33 +0900
X-Iguazu-Qid: 2rWhJyGIBmylLR9EY7
X-Iguazu-QSIG: v=2; s=1; t=1784630553; q=2rWhJyGIBmylLR9EY7; m=LAThr9LaiXwJu6DtlmgDBtdNtc427Q1ngwZR+zy+OPk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h4DVJ4PQ1z4vym; Tue, 21 Jul 2026 19:42:32 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRlaHwQLyn4QW/kDCrRCRvrIGn4CqVtLHoU8pSOLoydlm1PxjpXZLogL+RCLIQBPQccOJmc+qkK1rO35nOo4r0o53moAuWL2xpcdB4iXdIx47wceG4V23bxlLzeDsnpfKcehLYhvRrEbYILhTHD2SmeHJT3U4FIUBBOTGJVioCjSLf/3avg2HyJ9bVXKLRjx/GLvApGhseBZft5zUnVeaBMGj+IWP6MmpT5btX7vOIsy+y7AB3jRq8YMO6+h4U4RBtD1qTTuSjDIe3rujEmKVOAOuuPJaqm4AImGJ1aU60LrZZnsQAQjJn/wvZiTUo+oZ9vzXNfpUu1n3wxVEboe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpEOFZPt/YlOGyAvuR5RfjYL/rIab8i07GAcru95flM=;
 b=loc+B73OsATRzXpBpX8DwxphHTGBw0UqDjq0GWeXPa6+jfaYRTlrezQbcpt5EgGWchGe3a0sWx3YFZq8W4Z+v2QERjsTfWvXWLpK/BFp2rSS/ItTKTJZaPm6QIfLyRUAXqB1hd/+n/5LxFT+SkqbWwAQi2/pOyrR1LMW2x5WFyX1EtYb1oTEqayKSLGbv+GAd+0rl6mRfylTIi6DXbE36OtYvRJxZL27oLvEStK3sgnsQhMDhBta9ei4NBSrz7JkuMpwmesn2EIM5N1xZeWux5S5iueoI5XJFw9W1MH5qUY2AXeEztB7GJBwXic3/wWB/tVb3pxOS6wMxuY3/JPc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <tommaso.merciai.xr@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH v2 6.1.y-cip] i3c: master: dw: stop hardcoding
 initial speed
Thread-Topic: [cip-dev] [PATCH v2 6.1.y-cip] i3c: master: dw: stop hardcoding
 initial speed
Thread-Index: AQHdGLN2wpSQsCHphkSxa1L9rAoMjbZ3xigAgAADaXA=
Date: Tue, 21 Jul 2026 10:42:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182DDF779931294CBC0589CDC22@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1784598692-26475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <al9J_Pud3pqoEXBO@duo.ucw.cz>
In-Reply-To: <al9J_Pud3pqoEXBO@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB13241:EE_
x-ms-office365-filtering-correlation-id: 83aac67c-efbc-4562-edaf-08dee714c3ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 oKR0DNDwesAjuztoxt+NMtm8elItclPmP8sfzxgru40zQwAydj7GjM+k4KEN0RMliPs9bM9wunlZamaZFprRwUK6PXDYdLGj2ABVg7OndGt6FZacyWs7mLqKk9OaK7/PfmnrDuH1/nWogcU+SWmF2zyx4RkY1UJqtTq/wuzM9GXcK9jSOSlHZBAbP3XVXS3cQmhO8ah4+DSy7QBeceaYBpj5DzGlKnyMJWhARSR7Wdx1OJJv2N7gGoTOe7dYxhtg5BTWllRfqxVQmwBiy68p70cd+CQjQzS1LMzRl7IuAR5bMUpQy+VG4RiOQtuylZ1Pj3iOsqUh7nQ7K+zy86TjP3WN1oun9/6iWeKMpzPPppyNeXZVKeMK923WTwKySge+fBDG6WnSv0TthUUr5nEa0TGKDLaFPBxSjUzOip2qBXmqqy9CRij1pNTyG/vpH4OpyiutK9i+eTHgjq0YVzVYiUpTXmd8plGL6Y5NwE2nsQjHJKgX4QoSTAuaS4x7cmvymD8YPADa7PFIyhrZ0LeNS9i1zFGywRpW2ww0bI/QilwTPtWkg10jqYT0EZxeCRfSnbfiZ3gKdgMJt4cBhpMPtK59LRkQHB2ZXVrOOUTOF+kJlPn0QX2QB/zJ94Wa70kv16irOas7gv/IX9PcDkHdHHGAJxMXpcBxB4ACP21+LsnsbfUpyX95A12mbJ8VDEdjwJicJ9e8y0bCw3sIwj33iun043OucnGL/3VJYR+lTQo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T2srWHo0TGxNTGhrZzh5a1NEcGdzRk8yeXNSSjJPQ09ZK0FHN3doM2dZ?=
 =?iso-2022-jp?B?VWhZYlJyeHlVc2laZFVEWlBiSnJUTXZ1ejhqV0xnU0UzNWRlWDFhZlpW?=
 =?iso-2022-jp?B?L1lXQUk5OG5kVERNNndUOHR4V1QvZGN5V0tWb05vSHN0R0UybWxqRjFq?=
 =?iso-2022-jp?B?OE9GeXBXZS9ROXhaTGd6ZHUxSVNGL1dhYU9XdXJOK04xKzdVREh6UWtZ?=
 =?iso-2022-jp?B?RG1iZklLelpMbmdDRzFuakNBR29FR2NKMUU3YVBpay90bjB4L0luYUhY?=
 =?iso-2022-jp?B?SVMzUEhDZnQ4OW51UjRtK3Jta0grZ3FYd1RHRlRBbyt6WTJ5Ny9kUUs2?=
 =?iso-2022-jp?B?SE1NeDhnL2dOUFdHT1VpdTdkZUtvUzFYOERRNlVzNUlaV24vc2RBUVRm?=
 =?iso-2022-jp?B?MTBmV3dQd2hIbUtXZy9YSzhEbFg5MTUydkpkQ2lLOTVlazZadGZlUGRC?=
 =?iso-2022-jp?B?bkc4U1liMUdmT3RWYjlJTlhkcm80Nm5rL1NZbFNKUlRqOEFpWTJHVzlJ?=
 =?iso-2022-jp?B?WlppVTRubzNwL29KaVJEN1NhaVZBSnE2UkM2UzgwdjhJNXhSMC8xaWZT?=
 =?iso-2022-jp?B?OTZnK3R3MUhoUlFiVlhvTGdPQ3RxUEdiMVg0Ris4aVpRRnhuYlM3MVFz?=
 =?iso-2022-jp?B?aUE5bnNnOGNUUEtqaDUzUGhQTmRZOHFGYWZZTEV1UHdZd1d0aGRCOEJm?=
 =?iso-2022-jp?B?S0s3MmVVN2RMeU0yV1U5WXBzb1NETnc4WWthK1FwVTAvNytJN3F0S0R0?=
 =?iso-2022-jp?B?UnlhWFFMazhYakwxY01nZ2VXN3llOVZhRmtjWXp2UkhNM2hraG8rNVI2?=
 =?iso-2022-jp?B?MHlzRmZheDRDZGtuQk5zZFZhUzZDQWNBc2VRNnBwVGdFY3hueXJBeHds?=
 =?iso-2022-jp?B?NElkOWNKaFVxQjRvV0VDNm9Va2hocVdDVFFGelMvR1hZUCtDN3lyN2p6?=
 =?iso-2022-jp?B?OVR2R09RY1ppZlNIMnZLL2x4WVB0bldKeTNxZ2RkUklvY21zM0JyamhJ?=
 =?iso-2022-jp?B?ZkZwVm9VMzN5eGVjR0llbDQ5a2N5Mkp4MlZaZUw5WmsxMGh4cks1YUgr?=
 =?iso-2022-jp?B?OTRPTUsxM2xHdXlnVlJkWC94MWdIZHFrdzBJa1JxQytaTjFZb1MveDhz?=
 =?iso-2022-jp?B?dVcyYlZOV1R6VlRaTS9MZ2NLQ1lRSTZ2ZWtUQVkvNzg3TkIyNGNvWWcv?=
 =?iso-2022-jp?B?L0ltTWdlcHhFc0g4WjJIcWZLdzRrSWNTaXJjbkhFSnhlcGdkS0NKS2J0?=
 =?iso-2022-jp?B?ZkUxa0NoQWxBRHJJVlVlTUVjZDBpWVZzVk4zVldvNGxZV0kvQVpNaThR?=
 =?iso-2022-jp?B?ajZwaUlYSytKUzlSTk1hS2YxdHJqeGRvTkkreGxGa2hieFJyaERIUkVn?=
 =?iso-2022-jp?B?UVZlekVQTDAvVlg4RnIrc1czS053VnIrVzFGejZPTUV5eHQwSTlrcVl3?=
 =?iso-2022-jp?B?T1FZRlppejJ5YmJYRExPUHFMa2E3QkhEaEQ5RXlzc0VxV2s2Z0Z1YThV?=
 =?iso-2022-jp?B?ZFJia21KLzBOUGZDaEt5SWhNKzFFU3Y5MzVXdmova2JQdERMeGxoYzhh?=
 =?iso-2022-jp?B?a1IwK2VyY0ZVMkVHU3pIbTBWSkc1MGZkYmt5dy9BTWovc21xSmhzNDRX?=
 =?iso-2022-jp?B?WGZsMmdsTmRQamc1d2VkbXo1dm8weVFmVTBwTHVsM1d6K3QzSCtpK3Az?=
 =?iso-2022-jp?B?N0R3eHZYc3U4Q2hKZTI0MHN0WmFwN0Y5V3pYUU1sSlQyUTRFRW9wYnZH?=
 =?iso-2022-jp?B?cHMweWVRd1BTYVQ5ZFZkNzg2c3ByNnE0djBwQjFYemtQem1GVWhWM1Mz?=
 =?iso-2022-jp?B?Zmt3U0QxQ3VIYnpaQUNEQ0ZDYkNHMGNyQWl4NlM0NjA3NzBaSkhQcU5k?=
 =?iso-2022-jp?B?TC9peDVnRndXNG9sM3BXR0k2S3h5eTM1eFdlczRaVlB3NnNlUjBaR0tQ?=
 =?iso-2022-jp?B?bktRdmhocGpiZFQySzZDWlhBdlBHK05yaTlEQTZqSlZETzN2TjlTKzMw?=
 =?iso-2022-jp?B?SUEwbDNVb2pwR2FxZGVYdVM4cmR2c1NqZmdMOFpWNnc5WWNrYUtPZW9F?=
 =?iso-2022-jp?B?bjRtOWp5UzF4MHgxTGlYWHpzWmRDcXRFcWdEWm95aWdaUlU3VW9MNUU1?=
 =?iso-2022-jp?B?MjVvOUlPbFVlRXJMRkc0SU5YeHVDUXlEdUNZREZlampxUU1YS29qdUQ2?=
 =?iso-2022-jp?B?UE14MEd5RWFCNHVHUDhWMForV3FRclJTN2t5RXZEdTFwdlR0VUp1dzlO?=
 =?iso-2022-jp?B?b3RVK2RoODlOSTZCdnA2cVFtaysvalNrQmxjS2ErMU5ycmRyMGRNYUpp?=
 =?iso-2022-jp?B?dUNPMVV2TzJGMDFwTm1aS3JiOUQ5dmgzaUhhdFZKUTBUME5mYm1kRHdV?=
 =?iso-2022-jp?B?bHJPTlRpN1pMZTRaZnNmK0J5bjl0a0tXMXhmdXBOU0QrMVQyTTRFbU81?=
 =?iso-2022-jp?B?eWN5cEZuYkhKZUJZUnhteFZmbHlnRDMya3dXL29zaTE0aG5Ha3RLTmY0?=
 =?iso-2022-jp?B?TnN5TTBEUWt0Y2Yrc0NkTm10QmlDYUtBMlJUanBYQ0FOVDduYkNEUm9i?=
 =?iso-2022-jp?B?NHg4eENDOD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	SsyBhB0h8Cys9EUjsWiO3POiD7P8kI1jN4nHXs7ppLBLbS1QQf2ftWm6bGXCBthov1cR7BGIXYDvC+FQNLECE5nOvL5zIQvA1HCdLPALoxjXS+b6oxM/sNL8OOF0qGfv6fUIqXlYevwV3Q1hqBYK9PKC1sjE2BnESiTNhxQMM/qFMzaFnfFmr3YPzaee/8e4YyAZqP4ELvB+/AZS9pQuWC8TpIWyWOwbvfaIAXSSaZ25NTVPsgVNhNwaughpMNQ1JUs0sdvJ+IV04VySyR1J3s0E6kzJjzKAZbHTLgUQAWMmiz2GPNcepAxJJqXKv3KDBw+UgEIQjeCRSlAmJ3E9rA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83aac67c-efbc-4562-edaf-08dee714c3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 10:42:30.1790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUffAR+x4RplLUyVIOW6vJd1JGQMPIf85268BbRpdsDRTUqW+siKqJIf59ZXZt2iga1wnQfZApaHpG07ig+6rbT9pcjWUGXejdoVCrjcEpomZPqr3LySt7Tg0U2hS+kg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 10:42:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23695

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Tuesday, July 21, 2026 7:29 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com;
> tommaso.merciai.xr@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH v2 6.1.y-cip] i3c: master: dw: stop hardcod=
ing
> initial speed
>=20
> Hi!
>=20
> > From: Jack Chen <zenghuchen@google.com>
> >
> > commit 510d2358c466bf6588034f0d3b2266eed2bc0a51 upstream.
> >
> > Bus-speed could be default(12.5MHz) or defined by users in dts.
> > Dw-i3c-master should not hard-code the initial speed to be
> > I3C_BUS_TYP_I3C_SCL_RATE (12.5MHz) And because of Synopsys's I3C
> > controller limit (hcnt/lcnt register
> > length) and core-clk provided, there is a limit to bus speed, too.
> > For example, when core-clk is 250 MHz, the bus speed cannot be lowered
> > below 1MHz.
> >
> > Tested: tested with an i3c sensor and captured with a logic analyzer.
>=20
> This is already in 6.12.0, so no need to do anything there. Looks good to=
 me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I'll apply it if it passes testing (and there are no other comments).

Thanks, I applied with your Reviewed-by tag.
>=20
> Best regards,
>                                                                 Pavel
>=20

Best regards,
  Nobuhiro



