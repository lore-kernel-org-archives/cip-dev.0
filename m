Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B97F433C7
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 04:47:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6266.1776314864993787272
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 21:47:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=fc9hHUsK;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1776314861;x=1777524461;bh=uzSsGn1EPC4XQJLm+X1ro3su1UcIWsavPiEwz
	UMwams=;b=fc9hHUsK15FylsdfMqBtsNpqXPJUTVd+4hUbu+F4/UirolePIOypfURa/4+JHo6MAPq
	Iw4v/ZY0zIQpiR5F3+ROOZFRCnFrd0gnUkQzvQfUSEHAoVstZMT1tXKiUR4HBfQ72hBZrh2Wwrj/P
	SJpzXnCDZhDDiQ54yyLbQYLQTgc+i9hdCQCMCD5hhhwCfKroad/HniQPGk4VjYR2txWZd2sJvL3KH
	q8q3vYPAs5RMd08lT5j688nIUan5idW6EfjaZ3trYA3hJWIy4l+BVUIdWG3iZBPcndrl8QCjVTM5p
	H+eyXB7GjvXvKvQ05GAh3Cim9tpO3MP2QX1xrgHO81sA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 63G4leq21436562; Thu, 16 Apr 2026 13:47:41 +0900
X-Iguazu-Qid: 2rWhSUPmUCihhG0zVp
X-Iguazu-QSIG: v=2; s=0; t=1776314860; q=2rWhSUPmUCihhG0zVp; m=vTOX/9RScJK2EsCHr28h7aCojg6WjlONRJjgL8OpcJw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fx5981TJ1z1xnZ; Thu, 16 Apr 2026 13:47:39 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP36wPuRLoK76nEMOIT45qqzMC4LjwIhF53QoLJhyniMYV3GDOQ4TlrIRnfiB9rs+xDttKpeZWNRTWrHI1xPKMNba5pvOHeZj85H5TIzXvBFexAQ0Ru8b0EW9j62obVus0HTuKkevfzlgDmG3Q4t83TIGfzA/L5AbdlQbP9IPeFXSI//pd9bnUsqIZ6BWzsWB1U77rAZy2FR3aJG37ykXhI1O7zuMtOwwxGWpXoE4iLlpKFi4Zlu4QnpWZqiPIup+c9iBkcr20JSSKZb8ADwDg/vBanlkYfheA/zIO4j0BJxDyhlE66JRQ6XGihM5mkeJL8+zOOiIjXbLGllvRg+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rj830o2NcnEXM4wcp6WfljQXQY4gxGE+bqjh0YH7l0=;
 b=e7S+wHK8F4vp9Q7h8oAcY5WX9wHDSo62blNpAIgjrH7bHCJ2ot1kfiuJqYy2YHSHvbJKGBQ2m0PyKjS7JD1nUW9zJ75Mn/EdoHITPgKjhe0543NiZCXgegvR/ImZSjmqaXGkF1Sr7ve0qm2kgi5S02bmRHZp78xznWgi1LpuCxfi5o1yfaIa5PNieDKO1DvTms2wNSzwtFbzVC7qaYYyvzCEC/lR7Kv1HCk2iIuvw1sCzMdmbSJhlVxK7HC+7yaqtduyffGKLEuPoaghh3dnlEbvX1QixXAr0pe4NtNpE26Ceu+XQTXQku219GOL8btWMjTghTik+cEOJTbjioZ+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>
CC: <cosmin-gabriel.tanislav.xa@renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2H and
 RZ/N2H
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2H
 and RZ/N2H
Thread-Index: AQHcyQvqXNHIv8jd0E2M2H2Ro/oRfLXfek0QgABrDgCAAT/W0A==
Date: Thu, 16 Apr 2026 04:47:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148182B9B2CF6C624DBCB7177CD232@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <TY7PR01MB148184B2C1FBF41C6718DBD1CCD222@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <ad9cxLietTNoOoZ2@duo.ucw.cz>
In-Reply-To: <ad9cxLietTNoOoZ2@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB13997:EE_
x-ms-office365-filtering-correlation-id: 526f7925-985e-4a8d-73da-08de9b7348b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 PmykshNfy0twpsbsC5ZY7aSCosVXOQYnkUGXF6Ss2uaH/VJguGcmvmF3WQCippjFdAOnmIHFPeUTxZJ+Dg7UTtZzDv3Vdp+Wg6HtyIuvsdgIMrGsmzeCH5DlHI7wd6di2e3XCBhT2oXoh5xScAVEDJR/hq7iwrjVj6jzQ+8e/P29OXcZGH/EHVKdl8ekAMTXB0wCfSewdPeHKpBJMvptiBHSXi4hjGfmitoXe/qTtUWGO8Nya+kkbRSx/cbUva6UnJBJp/D2IxSR0lanWMizklQq1pNp5e3nMNZZYmTPD/p0oehdIiiELTJZSmQqeLn1tfUUsWgaRO4gUjXyzpKHGxIyiOza+rYMz8IFFn+S6SHKC5uur48iptRa5ooSpXhlf6ZDzfERuVKikF07oaLSwc0DznAoYXG8fj6kykbKtJ9xRIjDKyRlPjp2a3nAgzQB9QgF9tcxVI5XDiNw7v3383Zc9vt3406YwmUSJGYkP3mQIg9hL8iT1stclpAo0Vbh+asf/uZkbGiGZdtrOheCISOSz42Q+3LkZOBGN/8uIM8PgZ2AoisJhMIuOfJs3Sqp30mQHdEaTp6AVkA/MG2xCpoAsG5QmSd9vJvTHNMrzJIxmlppYgEHaJYbJioD6fE7bqT63Pf9kLY9KvyGJnFSQWBMIZyiil+CWpUrtoYQNmEK0UzVo/85cRpDrIe0MXMTxhGuRZfYY6MZan3Y2EledjcavK5t9A7gkGT3ejEvBvzJl3qokyiHrgcvVMAwdTNzNj7yTLjJEx0+sj+h0rQnGJRoF0wcb3p23CFfvAw7isk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cmdRRkdZZkJzc09YQlprMzh1alp1Q2UxdkZZNi8vTGtzSkc1bTZiQmxo?=
 =?iso-2022-jp?B?UXJLeDNVb0dEb2VPMHAzemhuQXdaRTczaDNNc1dpemE3b0kvdndYSmFn?=
 =?iso-2022-jp?B?SjZzL25ETWI5dlRQUEMwVHZuSENQMkljVHZBcWVWNHZWYmUwRFlxVnI0?=
 =?iso-2022-jp?B?aVhvZUQ4QnpmZzdsbmVPV0tuY0dsakN1YVZWMDZ5RFJPNngwMjM5SGRB?=
 =?iso-2022-jp?B?S0lOdUJ1eHkxbHJUWHh0WlZqWnd1Sm5rZGZWbWczMFIreWZyQTlFb293?=
 =?iso-2022-jp?B?bkExWXhXeTVQYlU1bmNJc1E2LzdVc3BFeTRQMGJHZnF3UFlFT3ZGZE81?=
 =?iso-2022-jp?B?QXFXbHZwQTVTY1pzZFlVMWxKalptSERUekdEbzVOem45OVd6ZXlSVGtZ?=
 =?iso-2022-jp?B?QjZLckNnejZ5ekhWVG9CMGJDclgwWFJ1aDhHUVJ6ZVkwVFk0NStKa3Rj?=
 =?iso-2022-jp?B?dnN0SHJWMGMzNFdVNWJTWTlnRlFET3ZOT0JwckVjVVJrMUt0QWJxdGUw?=
 =?iso-2022-jp?B?SW5jUGlibTBLQTlhWThIZXErWGllZkZXMllLSk1uNFRNRGtXMVVPWEJ0?=
 =?iso-2022-jp?B?dlFyY2M0d3RzWlRMQXR6ZEw1L1dBNDU4MWhTR1ZLWi9OeXF5YVpsTkxv?=
 =?iso-2022-jp?B?S2lDMGVXTUV2a2NIa2wrNFVSbnpMNDNPdmFQemgrN0ZIeDRhOFI2U0pk?=
 =?iso-2022-jp?B?OTI0a0M0SFAvbGxMdmcwU0RBUVRxVHV6VEUzUmxmOGlWcVp6VWhBbGhi?=
 =?iso-2022-jp?B?eHZJMkhITGFsc0dGQ083OUlKZlJTQ3FzRmpEbm5RWXl5OUFuMkVwYnF0?=
 =?iso-2022-jp?B?dTdtY1N3cWFQRjdKQm44bTMzL0RsVU1XR1lFaW51eC9hcGhOSldUYnJO?=
 =?iso-2022-jp?B?OVRCUzk1ZXhYOU9zN3R4NVN6WmNKQXhhYlpwd3BKZ280NktERjZoREJF?=
 =?iso-2022-jp?B?NGJqQTc1UHlRUTZJL2ltQWZnbTM3azFncmYrQkRiZE8vTzYrV1ZVVk5p?=
 =?iso-2022-jp?B?MlgwSngxN0E4bDhnb0tIK3dUa1EyUWd0Mm9kUnJNdnkza3lNSnVXSFNP?=
 =?iso-2022-jp?B?MUp0Vmp4QThLSytsaGswd01peEVhWjYveDhUc1dWRXcyOEVsdk9TWm1U?=
 =?iso-2022-jp?B?RzRHMFhKai8rWHloNjVjSlNnejArbEdDanEvdEhKZGJCZXUrbWVsbjJV?=
 =?iso-2022-jp?B?NDNPR3NVVUszN0R3TG44R1pTNlZOcERUWVBFYWJwLyt5SjBtYXgxbVV4?=
 =?iso-2022-jp?B?WTFYNFgzc3hRM3B1QWNTenVMTC8wOHRWNVVLYW1MT1dxTHIxcitrNTMw?=
 =?iso-2022-jp?B?YzRYMFZzL0dEZU1oSU9nTmd3Z2tFNzgwWXZoaHZIZ0pFQ080Y2F4QjJk?=
 =?iso-2022-jp?B?UDE3Y0s5bmg0TXFFclNTMnJTbWx1VHZtQVc4MkxlOEtYQkx1VGFwcXM2?=
 =?iso-2022-jp?B?UGJTenN1cWoyaExuUzVtelRVK1hiTUwyZjVRWG5WTU9odXVkbDlod2Q0?=
 =?iso-2022-jp?B?QUJGYVkvVjhkR0pLK0Vjc2JWa3g2VjRDSU4zckdwOUVlaHVBcm1saC91?=
 =?iso-2022-jp?B?T0h2d0dVTjNtNjhRbFpTRGFXMVZZVU5uMXlWaFJFMGI3K0hFZVhITHlN?=
 =?iso-2022-jp?B?dkY0Q3NjakloQTZOWmdxa1lJT2lGT0pvSXZrYXNXUFdBcjJ4aDY2eWsz?=
 =?iso-2022-jp?B?U2pCU29vNDduY1BEMTRIaEdiMmRqNVpsaHFVd1lGY25BKzFQYU4vVzd1?=
 =?iso-2022-jp?B?enNOQzZBcmFkeHRMTXBqM0N3VUtvRzdJRzQ5VW9ROUxiRmRqMXc4U3d5?=
 =?iso-2022-jp?B?Ukx1NW5oSkpEUHJGb05oemsvWHU4TzRyM0lFa0JHNmF6KzY1SlVPTHl1?=
 =?iso-2022-jp?B?TWt1bTdDOVArS3l6ZEpxZmxVY2xwVm5WMVFOSVRKUFU1MHQ3UDJpR1Jl?=
 =?iso-2022-jp?B?YVF0Q0lhY09ZT0lLV2l4MWU0dDBZWU4vME1tWExVZVNLYXhmTlhWQTVw?=
 =?iso-2022-jp?B?RFRoWVJZc0I2Nk42c0JHNnJvN2ZNY3JkUjhEZW5jZzg5QmMxckpuMkcz?=
 =?iso-2022-jp?B?c3U5RkgweEZRTmcycjBoaWVYNFJKdU4wSUU1Qk0vc1JBVUVOWTI0SWcv?=
 =?iso-2022-jp?B?bUtSUmRSM1I5Q1FVWGkzS1hYYUhKejFlbzhUNXVsSmVTQ05WN2N1VWd6?=
 =?iso-2022-jp?B?aHRXNHdEUXhYaUlESHVWWGpueXdCdm42ekVPTmZtZ1lwVFphTE9aYS9V?=
 =?iso-2022-jp?B?RmhOSmhRZXlHc2M1SFpYbU9KTGszcUJ0dUFTZ2pObXdTL1hQeVdDVGdn?=
 =?iso-2022-jp?B?VWJ2SHNNK3RQR2duemNXTUNadU5Yc3JQdTJrQTNTMTVFZm5wUENsWnY4?=
 =?iso-2022-jp?B?WWVIU2NGZlBKanR6bUcyNDRiQWpLWDdCaGZLQitTb3IwQmRhMnZEazdq?=
 =?iso-2022-jp?B?VzFzdElxbE9ub1p0WGxOSHZRQ0RMZWtTaEJVWVFxVlRhVWdIc1RLalpY?=
 =?iso-2022-jp?B?UDltTmRTSWNEOE5VVnlCVXNaVkdudFhYVStwbkJNNnlONWhmVHlJamJU?=
 =?iso-2022-jp?B?bTdzUUxOZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	eERVBmz4/1MewU2N5UQjj6SumR8Rg3qA33qx//qnjTqDRUZhZyVHff2BgYaxDkztdzhZn6sXIkaaBELRvbiuJnkTGhoZgH/9lpVLWxfAZ8AttOzLBjdrw9X0Z2ucc2Y7IDHCw0wg8BVECdunTgx6aSP3q+TZfCCRYtCZ72oa9JK+uY3OX4LQAAYWUfUe74ZUa2XDuHpIJ4E1aEA74RLcZzqZ4/Su2xyaxRaupG7Y5Sgyq2/o60iIppmywdTRAEKm/ImIapQhfqIJ5Dvtpi9C0yFe4mo+NsJXtjdqO0h0Q4ynrTshuuWXDfcuo4wcgc+xS74I0DgrKvuRMNiYB5SIfw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526f7925-985e-4a8d-73da-08de9b7348b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 04:47:37.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZjxF8nyMGvO6ubjBYHVs3FigIUMHTPbLCo9odWM+rnPruOHbw2ekUTmqy7/kRjXvmCEM23+1rwSfXfz7KFFryuCDdz2IkSHnwUSn+whvK7QhmsfYtencrUSuLlnih54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13997
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 04:47:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22734

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Wednesday, April 15, 2026 6:39 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cosmin-gabriel.tanislav.xa@renesas.com; cip-dev@lists.cip-project.org=
; pavel@nabladev.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2=
H and RZ/N2H
>=20
> Hi!
>=20
> > > Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
> > > temperature calibration via SMC SIP and do not have a reset for the
> > > TSU peripheral, and use different minimum and maximum temperature val=
ues compared to RZ/G3E.
> > >
> > > Patches were cherry-picked from upstream kernel, except for patch
> > > 7/11 which is needed to fix asynchronous aborts during unbind.
> > >
> > > See the MSTOP series for more details:
> > > https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.bez
> > > nea.uj@bp.renesas.com/
> >
> > I reviewed this series, looks good to me.
> > I can apply, if tests are OK and there is no comment,
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/245384
> > 4182
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> Best regards,
>                                                                 Pavel

Applied and pushed, thanks!

Best regards,
  Nobuhiro


