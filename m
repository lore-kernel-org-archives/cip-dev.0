Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49836C88E5C
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 02:03:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11325.1789351392780044260
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 19:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=sEbwma37;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1789351390;x=1790560990;bh=zgRDZKuKyoLMVlYvExvhCRQVEKWpvKESL1DVO
	Sjf+0k=;b=sEbwma37lMiPywXkfKhdTCNEX9s9sIcApyPOVErt9D78MR5iGJH0QuHEoOp/UNoOI84
	M2oTRwjNVuUApBUiyxqLi+iGt+Nfb+EA02DzPJQmW2clrZRIpGNetkRNpMa/A5eUOFtxSuS/7BNQX
	31epy971kVw0kidwXmDcBaec6oi8/UepvVEtkgf06FiA88o1G9foJ3PjisJkay5oKshc6pLz1e3Om
	EGke84PkRkF8YhTVymjVv3JUkNWrCO+MOZG2rk4icPODSfJciFsaEUZzDX4oPkJ4LgrVW5YHqRI2c
	CcUWzmg+re4aHMWFFiQ2SRpwU8aNzS3U+JTUFojZ37pg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 68E2390R1572903; Mon, 14 Sep 2026 11:03:09 +0900
X-Iguazu-Qid: 2yAaDenV1Dxw9ZvRHl
X-Iguazu-QSIG: v=2; s=1; t=1789351389; q=2yAaDenV1Dxw9ZvRHl; m=EGmyTeKrmyFTzq+wSwaQAnnvIYl+/vFh+CJHkYV3tEI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hjpMd0T6rz1xnZ; Mon, 14 Sep 2026 11:03:09 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wl1xZ+Z9u+FqB253amRAbRSSO3KC2nEFRDlFAfnzZEjYrY/Wd9WeHuqP58uXG+5mEphN3FQy+CrHQb8EJwXsp4PZ5eytUCS74CBhF6o1LCkKgoDnIZvvEYjtkvRStkLdFfGTXzs3OIVcvEGcOvfjORcurFYLIBXCPHH/6dKlejPGCsCO9KGXGcJumwWtNfIj8EGs9b3IKu/FIDNQjLhJQBWhbpUUJKLfMKCwVdz3tegK0Skld0RHLrrBv5P378Ox5gBeSbi+jGAN+UkUctD/DK+HCs+lp4KnkhJb+fu7+gOFODDmTZwF8vSco3rI+WEnZVdN9asTkuimZIXCipPDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wwZT56wau4/fBRQIQ1tOcn3ChbubWbFk5KQNmduqpk=;
 b=CP3uUISvJTjzcwpbq0k1Z8HNLBPKmekbOQbjDaPc+JQJQnF/IYEhqC2wLgcQdWT+DUIUj6zQvNKFb+vVUcc3zuqNQdfF7hDLl+vfbtNz4l3Rx60CzwH8qBxGomjah44IyUonv+ZEhS8w7TzCMgDg2IDksJwxIWCcQCDfgzrmQ4deJFqwWIij2h3l4NPfR7p+wHwzJtbZ5wV6QQJi0G0ZT/TWslM4lnx4e7bLCVx/ZoNOtazDWxYfHbzIL+rwcvPJ88I+2Ab6oov0f51U+VeHiOlsUHX/s7427z6bFaD9tGaxHocl7ruTDvTQ/3UFduVD6F5++zwwXMGWxgRGGPRLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/8] Add DMAC support for
 RZ/{T2H,N2H} SoCs
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/8] Add DMAC support for
 RZ/{T2H,N2H} SoCs
Thread-Index: AQHdQcUxCFgXCCmlAkqyswnU5cSwkbbJKHyAgAQt9EA=
Date: Mon, 14 Sep 2026 02:02:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148189B00035066B9DBA0751FCDBB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aqPT_RBxXJlRX4co@duo.ucw.cz>
In-Reply-To: <aqPT_RBxXJlRX4co@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB12166:EE_
x-ms-office365-filtering-correlation-id: 73b7452c-d31b-487d-581f-08df12044d27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: 
 PCTH3sLC0MKZ8cT+bl9CxrG/2LhLIzd4mDJj7wHueRk4tS4KrkERxMnVjuaOiLhQTU6NMVsViNyFG+uEILhoRhdzmY2q66C4HdU/5+PLRHt5PhcxsqUjHo8j8y1/5kqKLIFyXrBcZ6hXYwz+lQbAnwjXAc5Rz5jl0UGMHDhmIjbVFHYr8Bok3uIV/yvND4N7fAUxRkxuODD5xwoKsn3dPnSTUcPu37VnNsle1dn8bSzriCNJAO6r7ObSY33l7qyLUghsxscsZbVzdz9V2VBYLP0TkO4RZQLWvqAPfYjHnK8Kh9uPY8g/7GbGUChcRDX8rViZWy4odOC3oA28SJH+ors3Czo6rXhodxS4l5n70uVn1s89OYD/2p+3M645qZoXBwoyhyN2BeBjEI7okcur/iwgYaaiJE+4hef9NRMw9pNM3ec5M+smiOb8nNc0EM+6m7HH4taxsQttUgMwxD6N9MKfGYb2jNEs48oed+qnGdi14UZZlZeDaPFOziMWH/82tCfGpmQ+0DUkcx6614WUTU32+19riQOvL81PyVEZo1oUgCkuSawUgvgoV3iLvZO3LKxmFDVuLrcuIltfoi9tlQhIhn5/HKCaygxj4AfldcMIWooCtm8ntSZwYX5B7UkI4M0uPY9+cj8rW90QqwEqEKO9AGs2KP9vKD/oOXMl17+Txg1ER/rk8i+tl9bE32oCOc9QWU8QiIAoBb8PZusfxBtJiMh66wj+xCsmdIiR4Jc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cEF1UlB1ZHgvMkpwSEViMXBpNVpHK2d4dFdXdVFPdDlaYzRPYnJJZjd2?=
 =?iso-2022-jp?B?U1plcmhWcFJpbEYwWUNEeWx4Q3JiQWhJMzl0Mi9xeDVaOFFta0NNbmlh?=
 =?iso-2022-jp?B?RWxiVUZrNjhRQnIzU2xreWZPeVlXbDNQRlJ1c3NhenFrOWV1a0dKaVBi?=
 =?iso-2022-jp?B?aUREd0MwVUpRWURHR2dwNjNndm9QOGJEb2ViV0RFa0M1SnNLT2g4UjNH?=
 =?iso-2022-jp?B?NitxUVZSTGkrdnVDM1VNUFNvMEV2VGJmTVpPU3hjODdoYlR2TVNhY01M?=
 =?iso-2022-jp?B?TERRYTFjalNNVVVSWjFyZW5LMjIrL3dsLzczcUtieHFJdW1iaUN6Z0wy?=
 =?iso-2022-jp?B?SVlyb0FRWWgxYkVrQkRWMEZhOHAwaExIakxKcStWd0M3NU5BNkpXQXho?=
 =?iso-2022-jp?B?WUJqV3hNUXhTczJWTUhHc2VFVmc2VngzeWZncHJqK2FlNGFSNElUaTcz?=
 =?iso-2022-jp?B?NUNkV3RuVTZPckVQZVFFdHZrdU5taGlzQXN3NlRMWldtWkVOdHppa1U5?=
 =?iso-2022-jp?B?QURVaGlDNmY3MUIrcVJYVURsdEFmRGc4cGttRysyWXdVN05vTC9GK3FD?=
 =?iso-2022-jp?B?cEVDWEVyeEpNM0ZqY3ZseVlGRkZETUhsc1dObVZzd3o3ZTNuN0hLQlJt?=
 =?iso-2022-jp?B?SzZyeDJWTmxOZ3BSUERWaENaK0htNFU2U1NtTFF4RmhGbFRHQkFVbHdX?=
 =?iso-2022-jp?B?RWgxZVI1YzNpeVlyZlVzcFkyRXQzM1pGR0VDb1FHQlVqNTBBWnRpdHoz?=
 =?iso-2022-jp?B?WFVKV3JvTjBDM210R3Rxc3gxdnpZbmsrcW11YWhMclprQzE4WVB5KzdT?=
 =?iso-2022-jp?B?d2JERW5yWjBoSUw5bGRaeGFGUGgyUGd4RzJoVkh1RGlZRmN5aHh4eXpk?=
 =?iso-2022-jp?B?ZnFxVnRkbmdrRStQbWdFUHZDTEx0TEk5b1BHZWlsYlFvL28ya01yYUZz?=
 =?iso-2022-jp?B?Q2RhWmU1R3BSQzNaZXZKYVRzaXlVYnY3ZEp3Ymw0V2c3ZkxuVVlaZDln?=
 =?iso-2022-jp?B?VnErV01qcm44YXFDcUtqT09WSVh3NVhrUmJObjFTZndJYnpyYnU0eUFM?=
 =?iso-2022-jp?B?SEhLcXg4NTh3ZURRNWJLUnowbk1obW01WGRXUFlLZXMwT2c4bDNhN1FD?=
 =?iso-2022-jp?B?cDVZMWNkdm9OZ2ZEU1prdm5CRENuc0cySXFEVldITDdacm5NM0lmdTNs?=
 =?iso-2022-jp?B?WlBySVBlMUpRcy9yMVZBNXlFdUozUHZ2WDVmQko0QVI1Y2drWmljR2RH?=
 =?iso-2022-jp?B?RklXd09rcmk2WE1veGdIWDF3SmRqaE9yOTBQMkhFa0Zra2lBcE9FZmEx?=
 =?iso-2022-jp?B?Sk1KS01oak04NUZuRmtWSlVhZFZmZ3RFTit3UldIdytacG5FR2EzMlZp?=
 =?iso-2022-jp?B?WVRjcWhsbUVreEQydlo5dGdGako5MHNBMEhHT25LV2VpL1dLNTJOeTFY?=
 =?iso-2022-jp?B?U2RwT3c0UXhac2t5YXcvMFZQbUlJcFRSdDEreFhhU1k4d2hOdm9zSXhk?=
 =?iso-2022-jp?B?Rkp0T25jQ0Fnc212QTV2ME9PSzcwVUcrYkZGMkpqRGdhTU9SOFNmQUtN?=
 =?iso-2022-jp?B?S3V2cVhWNkZCK1RYR3RjNUY3QzFObEg3Y0tPTXdqNkFMS0VaLzNhS2Y5?=
 =?iso-2022-jp?B?aE5WSitwMy9MYkZzaHVlNkhkdlZ3UXpScGg0L05TWXlaWFpsWkcrZTZV?=
 =?iso-2022-jp?B?QzhBUXlEalJyMXN5Q2VHb2U1U3JpVDIvKzR5QS8xdVJqbVorVTZOT0tm?=
 =?iso-2022-jp?B?NDZyeDhvR1hQMlVnQ1hhSFhtRUE4eVgvaUxaYTBoQlo0OXhURFVrcU5R?=
 =?iso-2022-jp?B?MVVTVlZvSUIreUxvd0x3SWRUZ1NmMEpPVkI3L3V3WXNaekQwUGs1Y01z?=
 =?iso-2022-jp?B?R0R5cTBDNG9LVTRjSDFBYk9pbFhKMnNHTWF4MHVKSmJGUmJRQmsxb0U3?=
 =?iso-2022-jp?B?cTZBUWJIUUI0ZmQxRkZ3dGhuOWtzMEpmL2E4S0dpTWlTUGU3cU1ZeW80?=
 =?iso-2022-jp?B?c1d6NisxUWdhTFcwNkhST1JVaGRrNTJrVFVlZjIwa1BhRmc1dlJ1SnFW?=
 =?iso-2022-jp?B?bHpSaksxNy9obldubGNoYVhTNlRzb0JVeHdSTkJJUUhHN3diaVZoS1E5?=
 =?iso-2022-jp?B?a1UzeWU2aWlBYy9tQmJHU2xiQTV3Tll1dStOakVLUnI4YndBT25wejZS?=
 =?iso-2022-jp?B?cGYzRllTOEh1Vm12VWJzNWNHWVBsZnhtWkJrVVgrd0hRWVdZOVlYaFhP?=
 =?iso-2022-jp?B?a0VudXpXWnV5L2h3WHpaeGthRGJBeE9selRaR0xOYnhSQXg1ZTNSUTBC?=
 =?iso-2022-jp?B?dThMR2xwbUViOUMvNkE2TjNVODRCTk5OT0Fxb3o5NGRGRUplaVlSZCsy?=
 =?iso-2022-jp?B?eDV0ZVJETFN6eGVCQUtHUVBQWTRPbENzWG1XalIyUDFIcyszTm9zL3lM?=
 =?iso-2022-jp?B?akdVaVExRk8yWmpvSCtoV0MraFptT0tqRlQxWFBqaTNzM1cvMVhBR1Jy?=
 =?iso-2022-jp?B?eXA2MjIrRE5Kc1ZBL2xuek9pSDN4R0RUbXNpUko2cE9FNG9lUkJlUVR0?=
 =?iso-2022-jp?B?elNLbG14MD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Khym6raIg9W3WVEnoAXkH/uxsjhTBcWzq/6RTtgs5XuA+4ioW3+/ZUq8UbDR6AGrRCOUvPx6+HYhCGIvwx+nO9zG7SVZOyNNktmxqitx0LjxE33Kc+CFXSO3ck/xwz1B81RlVA/Br8+xE5JQ2cU8TcqNvpw7Jh7XVQ19pRqAccrpu2UPhiC+ENLAwq9hSuKkXOSuzCUIxPljMINI3MBgck3oLvBu2DLfQNitOeMPKTYzZtGmWE2jowhJ0WKvJlXbqEfTrfmDrbmvXXzf1XTu+MW8JfQNbO6C5sqHh0NL8hK2igs0gLw7Hm2gNqyF06sNSWxYpIofcOD0s+2Xkihy5g==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b7452c-d31b-487d-581f-08df12044d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 02:02:59.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DhHzivfCQkkPO1Ngodv5+mAr6gWE9JMX+4LSUThYa3wFZrdRyNU6d9lxZO3lswQKptAGnaYUiw6SIkWzNh76ysRXUEdL6F5RW57nffDOeDm43tbnRE3y33bmKIYN+XY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12166
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 02:03:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24161

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Friday, September 11, 2026 7:12 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> <pavel@nabladev.com>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/8] Add DMAC support for
> RZ/{T2H,N2H} SoCs
>=20
> Hi!
>=20
> > This patch series aims to add DMAC support to RZ/T2H and RZ/N2H SoCs.
> > All the patches have been cherry-picked from upstream kernel.
>=20
> I had a minor comments here, but that should be fixed in mainline, first.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.


I also reviewed this series, looks good to me too.
I will apply this with Pavel's Reviewed-by tag.

Best regards,
  Nobuhiro


