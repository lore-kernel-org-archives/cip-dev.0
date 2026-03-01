Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DCC5DF6E
	for <webhook@archiver.kernel.org>; Sun,  1 Mar 2026 23:35:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.149169.1772408127270716680
 for <cip-dev@lists.cip-project.org>;
 Sun, 01 Mar 2026 15:35:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=gM2M6TV+;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1772408123;x=1773617723;bh=OZrkYsZth9eCzlokreRgYV8s64piVzCryTdx2
	5WQyEQ=;b=gM2M6TV+mxwRZFZtwsecpgu2Jr7snGFGivC7/IK2oD1PUZUeB4fUERyt30rU0jRKm1y
	DalQgC1Hsd2hq/CmkuGE1VjYSjpLDOpwRkAuYBcf/6tBo/8M7QK2dHHfPH+9l3kjUhsbqydRDDqZ8
	WxYYb3sqWV9mFmHShZ6bMHFqQuyBDCIqZjMlJHYYbZi/nKmcLHSk3e2F98eLew0DQ8sdvqf0tp3SF
	IfGRKevEzgJ8Mz0hPqm8+u+qVMIsxgjhD+WOWQ0sJ0AgM6Ry6+svv7Gi+XIbnGdV+8HOsud2jqGor
	nYFWWIW6Dx2ottlXxRP0k0R+WPzXZSfuUdsbKUvs1W9w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 621NZMde2669704; Mon, 2 Mar 2026 08:35:22 +0900
X-Iguazu-Qid: 2rWh7Ml5jkXQfpIXjO
X-Iguazu-QSIG: v=2; s=0; t=1772408122; q=2rWh7Ml5jkXQfpIXjO; m=sraIMGAfsRWfKOHdPBAfqJffElnI1hNplPvhv5UxzE8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fPJMZ1r1zz1xnm; Mon,  2 Mar 2026 08:35:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUlmofkaAg6+hxLVh+fJ/6V5Hr7aRvMw2T48DWf3pTlXevEX2CXZ0zMv333xZxTGu0HGdkKAFOV8aZ6BCUamETJXaewoq/4zMneiCtSREteMgUCu4lM3tJnV+m4Noh7Yo2jMS8qxpUHxAijmd6BIcp8dUy5uB7c9BGqfxX7nyTNXo+JGbOk7PWMLgdUSrS+UtVr2mYECuBs3p/wUs/yzC4KwmjU9GVmyfxvnNo72qTNE+hdHeG95ipt4GJ0PxZRldwr4ixp2P2/vYbk5jKVS8XZJqMnZikhmCiOT1ZaQ8sJp7sUochXhySMecW3hN4pvfLHUUtdncXRtpDt5iQVooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x3EufYWffsNGj2SRPx5c8UKybHo8m7oAz2L2lYrkzk=;
 b=VfXEr0N3/AHZz5X0Jh6FsKTbdt7+ebQpFdkZIgg5ziMwYkqzhLX9jpoxJFO5/ci8uWMHnZBarCR9fOCTcu0lTuZor8trfCfDY0dEcYaOHkWZUjyUwy4L9n+cSGiIOCUn2Pz4fQG+PQSQHnU3CV7ECyBdq2HfN/WXX+v2q9tYc+nJ3X0klxpvlGooNVA6FcB4h4/grWd/RsgNsV/aGfTl7b14HKym3ii+BrqyirHq1sAzWiFQsIeHQNHaUHa31FzBDf0Lhr5EyZ/CnQX1DwBA7q9fw4I1Vtl97ZQNc17VWE0SucF9WqjhlX6Cusa+GW/3ZoT7XTHmKzOuNbaUUvStiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 0/5] RZ/G2L SSI Improvements
Thread-Topic: [PATCH 6.12.y-cip 0/5] RZ/G2L SSI Improvements
Thread-Index: AQHcp1YplxgXk5udXk6xYXfoZPjr6LWWTyqAgAQKNRA=
Date: Sun, 1 Mar 2026 23:35:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A3C18FCCBA76DFEF8EFACD71A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
 <aaFpl8z2owBm/444@duo.ucw.cz>
In-Reply-To: <aaFpl8z2owBm/444@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10879:EE_
x-ms-office365-filtering-correlation-id: 119abab8-9547-4bab-bc5a-08de77eb3379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|14052099004;
x-microsoft-antispam-message-info: 
 qXyJ1v80TE81u5kf8m/IZPyL6LV87rIoXkF/1ptwYaITK9yhist0XeULSG7x6gabMYlBpw+q/ndyCLbTqidmm0DG+DTXZGN0wAw6s/9WJm3kIaRiRP2OsoCnhVN2HQe3u2Ph+rOM/hNWO9H4CHGWIQlV1SzuBflpQ2CC6uOvz1z88ulQBfktmxEnxqY8Rpd5ECrwKKvcG//OYemtCv0IzAwPtuaKKe0/XxDW+RWa8bvb+ceyoqUv3XxhOOUYx873WRu1r3ldPanf72pg9+H6jnP3uheC/jFclYMtpQifvESVQC0Hm0KkYA9QPiz8aVDk95f6D3xAVSXw5XZ/CMvN+0fc572XE9paOhm5Zoe7uj9rZ3I8JLnMJfIlzlhFJ1RtzIJ8wBs7KjLBcXPHzFyD5Y8MCXroGv7L2QGCVjglfMwyiYrGASnhgcrM+16vryjeVjinlqH4SaEVi9GNz6pwG+ITLYnT0XSKpv/RpVmJkUeC0rS2g2T4KWErB24/mpmldcrIMEyCLi8AODREQc3GAnc3JOWByv4shyPW320rppYgBVTLX5vJ0ZxZ4oH+CBYhXru5TtyWYjiSYP5yDQ3twPBoKPz4dZwpD1cuyks+8n2NfioGy1sV0HlgOW6a1b8x1E/sbyIlGh7s7ENsQeWUMckRQWRqcS+Y8LakBZmzKWS1tnxF0YrjulnkiKnlH4udqYSA4HKe0WG57o7TGi70FLg8o52USvq4W4hAtZidzkUFYEaeaY0hzylL1czIiUJuOLAq20TLf8poqAUMbBTs9XLGe6PbFiIkmX4awWBozcg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(14052099004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UVh0VHpPeDFnc1QwdVp3OTRRdDlJRFBpZ3FaMjZqNjRCRm0wRzU1WHJs?=
 =?iso-2022-jp?B?WUZ2UjZ5YUtJaWs5c0taOUlrNUhQSk1mWEVLc2Z6a1dwakcvbnJ6R01r?=
 =?iso-2022-jp?B?VTd6blBwTGtWOHpvTTNRRGpjMXZ5VXBhbEdJa3RxWHU5eTJuZDgyN0ZE?=
 =?iso-2022-jp?B?V0NLZlFMcEJIaFR1TEVJQ2lXYzc2ZGM1MkEyRmFEUkp5STVKRmFDNUxG?=
 =?iso-2022-jp?B?bzhlenEzeGZ0OXVDNWdOOWZmdEZ2NjFUVEMvSFpYK1AwQW1RTFB2bS9m?=
 =?iso-2022-jp?B?WXF5WU0xR3ZibU9sbVFlMXhqSFEybllIdWhwTEgvV0xtZHk4UGlTWEpK?=
 =?iso-2022-jp?B?VGMrbjcxQml0NWt2ZDZKY3BXOGtEY3JldTRrWHNUamNpVWZwZThzaENy?=
 =?iso-2022-jp?B?YTJ0SStleHFlODNiRlpCbnNjeEIxMjZQay9qM2RaR1N6WFBJeldWdHU4?=
 =?iso-2022-jp?B?ZUVkMSt4K0hzYldjT1BFQnFKRmFlamlZK3g0K3JMYjA4ZDIzV0xoTlZ1?=
 =?iso-2022-jp?B?aGtiZGJoTkpuY0tLR3BSdExpSW1Kc1JBYmF5R2ZxTHpneUdKOFJ3TmdT?=
 =?iso-2022-jp?B?VVZSYnh1b2xCdEFIY0RjOEVDMHpYQ1Z1aU9pSXJnQm91RDVka2hpQXBi?=
 =?iso-2022-jp?B?UTlZRUtrYWNYclV0dXRySGN3cHZ6cWJrODk2d3B4aHBuL2J3b1pZL2h0?=
 =?iso-2022-jp?B?Vzc4TC9sM2dWTFRJWkxxbzlXbEFPdmZ5dWZKMHJJZ3MwQncwZnVwRktQ?=
 =?iso-2022-jp?B?ejVJZU9UNnJOYnJDeFNIbWgxdWJwbDNYVnBZSWQyaXVTYWJIejJleWps?=
 =?iso-2022-jp?B?cFVjYldtaFFaSU12SnRWbm80T2dQdSs1dmR3emJteHRLY3pFamRHV2ta?=
 =?iso-2022-jp?B?bThvSGlKTktxMFRpRndiTUowTzBKUUVRZXlqdUZnVUlkVWRBbU1MQUhY?=
 =?iso-2022-jp?B?aXhOY2hyb0xVNlh3eUhGLzZNOXBhT2dTTEFHZ1ZvejI2NzNJRWxsQklE?=
 =?iso-2022-jp?B?R1poZjNzUmJYQ2w0VHBSaVZsRHd4Y3hvdlY5VzVDNERYT2R0MnJUdDlp?=
 =?iso-2022-jp?B?VDdsT0dlMEg4UmNmbXBKdC9JckNPTzBvb0t2cmpoUEZWaTdLUU1xU3J0?=
 =?iso-2022-jp?B?WlVxWjdVazNmNkdEMHduYmRtVlczZjlEYXVrdmU4MVc3WCtGQld0OWVa?=
 =?iso-2022-jp?B?NVg3YmlkREhnRGd2S1g3ZnJOck1NNEdaWmJzR21paE5DWGtuQUo1WDJ4?=
 =?iso-2022-jp?B?ZDRVV2lyWWhmK2pTdFkxdktpaE45a09ReVpvWTI3dW9yaCtDQ1cwdG9U?=
 =?iso-2022-jp?B?ZWoxeUZ2RjFIdXlMYkwvT0x1ZndXTXJPNVlVYUhUUjlaUERzU3hyRHRw?=
 =?iso-2022-jp?B?ZlAzRFN5Mnc0TFp1R0pHV0RUcWJiazFrRk9DUWRRbnBwSmY0STFuaVl0?=
 =?iso-2022-jp?B?RU1jcXhSMmJKa1V2ZDJESGJ6RjMrRjZwdVcrU0RkbWZPQXUzQ0hNM04x?=
 =?iso-2022-jp?B?Wmk5dnc5d2hiWXZmV3VMTWoyOEdFaGZ4NjJIQlJ0djR5VnZIcU52OUVO?=
 =?iso-2022-jp?B?YXpVRG5TaENsL1FTcUFUYzJlU25DSk0wVjE2UlI0N3E2MFNCSCtPVVcw?=
 =?iso-2022-jp?B?MGdYYlAwUjN0Y0NCR2VLaVNPYmI0VS9FNHh6Uk9JWUFZU0hIVlVLeVox?=
 =?iso-2022-jp?B?ODMzSnpBdFcxRUJuQVc5YnUwSG0rc3pVSDIzL0FKSE15TEFSdlc1VXNP?=
 =?iso-2022-jp?B?UnNuOTdvSG5RcW1aeWRFRk5jTllNQmx2SG1ubXRUaUVjUzJlUVpQN2M0?=
 =?iso-2022-jp?B?ZjdISEtkMTY4OGFCREY5SHJLV2lBRzhld2xEc1F6Q3B4YVNRTmlvWWlP?=
 =?iso-2022-jp?B?Yk14TlRKa2p0MTViYXgwM0RoUEFMa1hSQk15SXRpaU44V1BMQnBGSkVv?=
 =?iso-2022-jp?B?WS9xSGEzVHNSMC9OaG1vMk5JcnRQNEJneDFZelBHSXlURVkvbHJIN09H?=
 =?iso-2022-jp?B?Z2tTR2dIM0JTL3lJN28vdkVEZWdZYmEzdllHRWo0djVOTGUxQTdwT2hX?=
 =?iso-2022-jp?B?bHMxZkdhZWVwSFY4NDlvL3ZuR2xhZG40bWlEbVAzVnZMcnhrdm1hOHRZ?=
 =?iso-2022-jp?B?aWx4bWZtd1R4eWlablRlbXFKOXhOb1pEOHd3MEJTQnZCOVozeG90a2Yr?=
 =?iso-2022-jp?B?amlGMkMrRGdzUU1tWU15QjdvdklyQUQxV3d6YkZkRmpZblB4QkNFc01L?=
 =?iso-2022-jp?B?SVh2VXllNms0WXRxRklFRDJhTkl4SjhMcllod2RNdEVZN05nb1hDTGNs?=
 =?iso-2022-jp?B?ZlUrQmdQaG4vMFdBT1k3eHJWdVVPcm12QklCVWlUUVk4a2ZWcCszWnhH?=
 =?iso-2022-jp?B?ZFNVNVBpSHZMNk1MM1RWRG1CQmtjTUVKcGdIbUd3VEh2UElYWEU3akJy?=
 =?iso-2022-jp?B?WTJPVXVMUjhGNGpQRjQyaThpQ2MwWmVONzFFN3hvU0tDSFBIT1RWRzBH?=
 =?iso-2022-jp?B?Zm5hYUZqNFExK3RWV0xYZFFDbkhZUU5UbmZUc2NRbjZyS2ZmSmNKRWJ3?=
 =?iso-2022-jp?B?ekxSWTZCUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119abab8-9547-4bab-bc5a-08de77eb3379
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2026 23:35:19.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqrIDvPqidVEFV65DgkrlrOd0v8EAzU+lS3QgnvkB8tdxuXneroK1eVquChyFLv1jxF7yJb1BS4iqvGH/jUvMJAYa09LkGgvrb2kZDowdicvGrkolNEDkgyeEyeJbHph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 01 Mar 2026 23:35:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22032

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: Friday, February 27, 2026 6:53 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.=
renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 0/5] RZ/G2L SSI Improvements
>=20
> Hi!
>=20
> > Add support for 24, 32 bit sample format width.
>=20
> Similar to 6.1 and 6.12, this looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good too me too.
I will apply and push with Pavel's reviewed-by tag.

>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


