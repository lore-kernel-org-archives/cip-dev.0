Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252C3C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 22:00:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19814.1783548028488061490
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 15:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=s3R1bc8m;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783548025;x=1784757625;bh=GUUcTIjL0RU3rOb6HCH2xjxuBMasNYNaFV/UO
	3norMM=;b=s3R1bc8mdM8MFWtszBvvzxRZkLXU7vVvIsPoYDuVmfUExUF/xF4b3mJJ9RixvRvx7y/
	Ms4wfKItCHoOEuK/hTidVGdt62Fj6JYkW2NUAxsoCoCxnE682Mfdz9Vx0GdwKePurgpooT3P/VW3D
	rTnHKtt/7FNusVom44HxiFMRlyQCDoMPXKlHlSGHcaRz7cLx4uxmLs9mFz/jcdEPHTbwETzrA4V6w
	R5WUoInryH/RNbCvmCFKfXKl8jpXCq5O91r8dSHYawaHxknWTXiNyJ4wo5zJrMZ43kl1ZXs/tYxRT
	au0qilLTnqDJ2E1krSFrT+2ONPT4NxFgHKBxh0wt7Fkg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 668M0OsS867936; Thu, 9 Jul 2026 07:00:25 +0900
X-Iguazu-Qid: 2rWgAjg6w4phn5HFrC
X-Iguazu-QSIG: v=2; s=1; t=1783548024; q=2rWgAjg6w4phn5HFrC; m=sa2e1q6NYOZL7LGROFvFat0OZm60WCZeFvMZSayMOoM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gwX8S2b5mz4vym; Thu,  9 Jul 2026 07:00:24 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0/ZqIxJy0DdVdkftqQbUDMh2pqUiXsur0idd7yO6i3bi9EeOK2jfwfxetXjffcSG11rmXqRJwGvAObgkZ3JR+CE1bb9Kz1y20nV+7arRaNXUAo1AC3KjAjtifjrUGkSE7emkfGXNydrcp0FWfwrqcV44T3TthVbr0SL85d1U7CcgxR0lesruZ76MabU1TuAWe9vBgBBsIr+Q5s3mDXMYVQ4JFoHfFICsadxvCZSJkpKixEx20HsGH+DUbelgF8JVXlhusM5q594kjsSGh0ip5gEvIRaK37ybZJSZgknutyl+RPoNP8GaXFdd9eYnQBHCKDY1YxURlR/5fsHvV/viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FJbQOQr8pT0bYM5RFgjxIh7x9lVYfAvQNXZULGUgk0=;
 b=e1vxO3Bcm/vKXkmAMrjoFyEDr07nPRLoJTkGTrrF496bwrrQygSAg7tym3t81oEjQQg4pu2l+FAtrLlPekempqnuT8fb+kMoA9K7uQYZe7KHPYgxEfjVyfYlU6h82LsUsGFkEpNlNW2HMRic76y7GqH35j5xm7K2HVfhdxZurHCy1PzNz+0DfX7AWbgQqjfSG2t55RaSnJTWqB2w1xZCNlUBbnlZrcqdcg3GLGNOo8VY5ua5u9la6DRtPA5P8aZLzlWFxfjWj9zh6EXTWm9aUAdca1P9sR1Y4b91kRnqmz1CXNWaDFdQhwZZpIQ/gJyAiFKrujlvByhAxbBTyV0cLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/4] Add PCIe support to RZ/V2N SoC
Thread-Index: AQHdCwn3BJ6vS6QA80GIf8n+R+pltbZcSwUAgAfpCjA=
Date: Wed, 8 Jul 2026 22:00:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481864537FD1B1A1AD9EB7F9CDFF2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260703163515.35831-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <akglkLO6jCOYqG4D@duo.ucw.cz>
In-Reply-To: <akglkLO6jCOYqG4D@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB13132:EE_
x-ms-office365-filtering-correlation-id: 757f75dd-1597-49ae-6d60-08dedd3c46f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 9tkU7BbsTnyd14KKC4+B+yXi1sjsY+7EqeGwm3TIXWN0KuzuFzwt5vSd6bJ96L+3R/m0R0TvFnQZ/j8XGK9A6KN9G5Qk7aA8j6V3wiWr6zHZvtQMB23o4vXltEuuIRC+AJVGD2TTlwNB3mnuBnExKUTPy0ox8yH2kuGUgnOMTqrcIgEZDtj26ad7krMrd8daJjuktfO/Gh4t5tKgiR3q422bu8WgdBoD7Xy1wabZVr1gVymTbdtKQFUPZOGE46YqySTq7ls3tKah1HiuzZEUKI/quf3UgpTRr7tZRRrrRQVdkYmzLyATSDJUnScq7sPJ8drwTk9WHYdKVia59ck+mqGqb1jG6viKYCRKsEZoZPCSjz2uUMe88qGTMQekYSNdhXPu8XKzeV8IVsBDtKhEIo9baSiEAzKrgTxFc1zP09nxhoILjEwQQKEJCPFvx6YnG+MWpCc2FlCgbEro92iAx8Q5loqBO5GG3b/WqHEjXWa9sveAnmVgHySCaT1eQ3tHE/52ekBV9YHH1LYa+/i6oUzYgpfAww8nBSsbpNDB9PkP2urDu4omJJB/7jN+BjPyU6VKz+YflO3fLrVhVQfRNkc84TLqU9rhA2sjPNO2YubW+pLNQl6IwRzNYeTq5bBR154KBmWWyDKFFrCwl4xwqubF1yAYptUCQ0fgFn8qLNW9Dx4h2pMYIlG07x9zZt0Zj38a2OXMufBuBWNaX0oFGGWh4Q6Jwh5TPVA4IiYDRL0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VXErajJYak5iemNMYUlmMzdhNGNIUmlyQmNwR0o3aS8vZzBkdVFFeE5u?=
 =?iso-2022-jp?B?LzEvVVBLRHRIUnNwalhwTDNBTUowQTdsOEZrbVNPd21Ja1NKVWRlWWxP?=
 =?iso-2022-jp?B?K01UcTk1bUdoZkZQMHNZTSs3eGFuNW5RRUd1OWhBaUgvV2xrRVVDb0M2?=
 =?iso-2022-jp?B?OW5oL1lxZ0FyMFovS1dHeUpHcjh5OEtsVjFUNmE4VDlvd3Zwb1ArczU0?=
 =?iso-2022-jp?B?eTNabHU3OW5jODZ0MFFKRlNkQ0s0UnExeklwTER0amtZVzVRZEN3U0d2?=
 =?iso-2022-jp?B?YUplaFlBQlNNU253cUVheHd1U053NjZxTjd0SnVMc251NklqbzlBTnRo?=
 =?iso-2022-jp?B?WUFwdFhXMThJYkFOV3dwZHJ6ZGxtb0UxUW12Y2pRcVp5TGYxZWhVVnNU?=
 =?iso-2022-jp?B?TVdyVXcwZHNuU0dmNWgvU05qWlhGamJVeGRzcXF3OFNvTW81eWVKV2ZW?=
 =?iso-2022-jp?B?Ui9mZUJEM1BweE1HY05lMFp3ckNsc0NjOEU3Szlicktwb2RNVUViRWlM?=
 =?iso-2022-jp?B?eFhhTWhOSE9Nc2VJZDNQZW95ZmQyVjdvOTZLYjFSRGZXd3hkOXFqOWEw?=
 =?iso-2022-jp?B?ZG9oNWZ2QVR1Q2V1TE9NN3YvNWRPUVNQNXZSRUZBSURBRGpORjZlY3h6?=
 =?iso-2022-jp?B?bXcxbDVHNm1jTVhvbWpVNVdsazJ0M1g1enZDWVhzME54R3RiQXRwNzNC?=
 =?iso-2022-jp?B?Tk5lMjd0RjhMUUJZTEM5VXo1OVdyU1g5MWxFQzFLdFJxakhDcnBtWFNC?=
 =?iso-2022-jp?B?Vjg2STM3N2xOWWVhWTJPVzVPekRLSHpYcGpzL1ZWM1EyOXdHei9uVWVR?=
 =?iso-2022-jp?B?UGlzZk5YOE9IaU9sREs3UXllUmVhdDV1M0RzM05TNlZBQ2lFUkRLQ1Nm?=
 =?iso-2022-jp?B?WS9qVjlTSjJoZkRFNEhyY1RCVGhSMzdZSzhDaEhLdnh6akw3U0dXRGFK?=
 =?iso-2022-jp?B?VCtyeWUra25iUkpxM3lhME5ZcUNpbW5hT0VieEhBblFDSWV6UWtvL1pG?=
 =?iso-2022-jp?B?VjN4N08yajV0Smd5a3VyMVM2STdnWm56eG9wUWx5TlNsVnpCc3NvcFJm?=
 =?iso-2022-jp?B?V0lDV0JydE5VZHQ0bjk3amJjRnB0UitVb241NnZpYjA5WTg4TlVyd1Fp?=
 =?iso-2022-jp?B?aXduY3ZXWnhuRjAwbUozd1k3cThiL0gxTklKamhDdWxIWVRNRUM1VkZs?=
 =?iso-2022-jp?B?Y3ZxS2xLcnlrd3hqNnlCTjBXdUxaSmt0dndnOWtvaTZyT1lRSlMyaUND?=
 =?iso-2022-jp?B?TUNlTXl5M3BKMXJocExIR2tIcFhqZVpmTzJ2R0JyZTFIMGhJTitIR1VZ?=
 =?iso-2022-jp?B?U0N3VTYwZFVRWnRQdzdkeGxTUGtFWkMrVE82c2crUEFxQmZBQVUzM0c2?=
 =?iso-2022-jp?B?c1VkdHVxWXY3eExEclFSLzRnY2dmeFNFaTZHM1FOOU1lZkJYOXRNd20w?=
 =?iso-2022-jp?B?bkZsOHJXeWkxNjNkdHlqSGZQSTJNL2RnamdsSWNBQ3NmQzRZOXhQdTdn?=
 =?iso-2022-jp?B?UW4wcjZCN1N2RFhSdGhXZ1RzYmpQdzloOUV0WXNnYUtJdmhPTkF6OE1r?=
 =?iso-2022-jp?B?SitTVkxXQnVvTXFNeHYwOFNocEpNTkk2NEVuNzJLc21ubFdBVzVFajFU?=
 =?iso-2022-jp?B?NDNwYVp2T2UycjMyVEVmUk1hS0J4V0syTjJ2REVJYmhJVHRhOHZ1T2Yx?=
 =?iso-2022-jp?B?RGR2K1JKU1plVGdEK3FYUnVWOG5XSGVBQ2twVFcwdXpVVmhLOHV4NjVT?=
 =?iso-2022-jp?B?U2ZuK1RPdVc0MXhhc3pKQUZDZEJUeXJUT3pYN3VDZ0VOenBEUEE4RlR4?=
 =?iso-2022-jp?B?elY2dExmTDdrYVo0RG9jeTJjSnE5bGViN0NGemFxM3hwWTgvSHVOZFUz?=
 =?iso-2022-jp?B?UnFxQ294SVhXQW9MZS82OUdLUUt3alJCc1dZNG9VaGhUSWhiVTZiZE1X?=
 =?iso-2022-jp?B?bGpYZkUrakVXaDloQlVYMDRDRUxicTUxU0ozTWg0Y3ZGNnZhQ2tLSmFp?=
 =?iso-2022-jp?B?ZHdkMEphZzVqeC93RVVuRmlvYlU0aHdmZUkyZHppRUsvYXp2d3F0aDBh?=
 =?iso-2022-jp?B?c05hMWg5aVBKU1EwT1U2cWN6UEkrcUV2c0lxVG9ZaTJCL0Y3UkV2OUU3?=
 =?iso-2022-jp?B?TEpmN1AyMU1IRzY3aVA3RzN0Z01JR2kzaUF3ZDdLSTd2MXRpcWVEN3JB?=
 =?iso-2022-jp?B?Y0RFVnJIWXlTb0VheW5MMldQejRUZTc2Z2hrYnhDM1ZUbkhtU0JWd1pH?=
 =?iso-2022-jp?B?Y3BzN0RwNWJITC9lclo5d29MWklpdXNRZWtzWEp0U1ppUUhRN0Nqdzlh?=
 =?iso-2022-jp?B?Si9DeGZhV1NoTU9MbE5VOFRzU1lxYjFMbVJhb0xvOVNMTDQydUNhMWpH?=
 =?iso-2022-jp?B?SVpjZ0ZDOUdTUUJmcURXeitwS20zeTQxWEIvOFhheldwVjNKMjFFaURV?=
 =?iso-2022-jp?B?S3F1czdMVVlGcHVyTW1ZMVo1UFE0VzlQRjBNSWJIdk9ZRnpYR2Z6SnBH?=
 =?iso-2022-jp?B?WEdwOXBBd2ZBTDgrY3hwK0V4dGR5SEg2T0tJaWdLS3V5djkrTjAvbmpw?=
 =?iso-2022-jp?B?R1BLTjVNaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	fajkiGTWHwxOwfeQkP9iXRTD1OvSGDOsLYLdGLn6nRouW625M4u2s5phsiyfnvJNa5w0XvV/zZx8sOZB9EEPGL3u9/MMd0kpHpj4ZCZgHgq8Gb+Re3zfNwbbidstI7IX4Hj1VMJpSaRt3S6GmKRWWgGHBr5phsAMzwXgYwrejqUz5OLliAp8uQz5kAdSXEECgFJWhP0aAoGwef2VSi8WZIyHmDTiOJ3/jw+VIG+gXw8suzkkR1HCEfRUxwPcEe1aqkHy/PblJKjEzftHxvAgpmamJEuOuJXprIVLtKx3XJ3aYNKRtFoZJaTeMJ4V8vyayBoa0tjhGWhl1XyBKCZZdQ==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757f75dd-1597-49ae-6d60-08dedd3c46f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 22:00:09.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZxBOKKHsZYmoZbTBdw+GYolQxqCtB/9AyOJDekOyNwsojh4BNlVicaPAJc9EeCdtT8TYAa49ez0PkN6lu9Msl+eqcEs50pejmcSYGw0M5SZh0Yx91e+mSVQmzw0WTq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 22:00:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23550

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half
> Of Pavel Machek via lists.cip-project.org
> Sent: Saturday, July 4, 2026 6:12 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Add PCIe support to RZ/V2N S=
oC
>=20
> Hi!
>=20
> > This patch series aims to add PCIe support to RZ/V2N SoC.
> > The driver patches have been already backported. All the patches have
> > been cherry-picked from upstream kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

I reviewed this series, looks good to me too.
I apply with Pavel's Reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


