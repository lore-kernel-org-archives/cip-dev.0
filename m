Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B56C61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 09:12:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.132119.1700817139885890078
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Nov 2023 01:12:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3AO9CBtJ3573106; Fri, 24 Nov 2023 18:12:11 +0900
X-Iguazu-Qid: 2yAafrZ6gj7wh0o17z
X-Iguazu-QSIG: v=2; s=0; t=1700817131; q=2yAafrZ6gj7wh0o17z; m=6+0y8rLMBCWzxS3xPG77KSlLBdgjgX3bgBNyUkibnvI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 3AO9CAvK305257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Nov 2023 18:12:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFhfpZtUfDc1qMuIgou/L/FSmVW4MHKF4NFYO+V8OThcC7vCUPKZgHwSm82kM4tOgSDOEoTHBZO4fbqaO+lIxAV1LIEEqZHED6paS1hoDphAjT7O4lpyH+mCmtowyxc5vVxf+uUbsVHWqe/I9G3ciSMFtcPnYKDnV1DRZ12xg7H8UTdtyVIIaU1pXfcEqKHqBJ+0Vk0mzMOyeY++rVNQ10zuBw2uV0rvSczXQYlZMOHw+K0HZ6GYT8eDcI0k9IiENFpm/GJk4tqoe+y8WSN8nJULspWRD6r3YaS/BDMktM9fnWxh7TB3U3ehSVKIlENM/Vu3aWStTlLopM0L9RSpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUKfBdeV57FA1B5f+Exh6zpAFG1EYLVjTIk42HHOhSM=;
 b=JSnkdgewC/bmLJWYp4Pse0F+HfKIPkoebFonf/pVovC5VK9RabREfb8oBYD+2SWu4dRQ/iAdWLCWYrmOKAp8DWHnfEoUZ7XxThBgH8q+htGi2kK3tJafRvm/d8zt85JjHpKLBBPS1qyavwFTdmg2Dc/KMQQBVPlNU+oA28X2n3LFOn8eSwTk028+plvzWVtoOEP7XiNbmQlXpKIc1GWNNRVTE+/Yx1FZmaqZPonOGt4Wb3sgz7JFAh4VUUcoIc7c80aReKySkKlZYUKB6eHpK6bMh0iEcvXbkobZdOhJcgJmxcAHfgTzQMBZ+7+EmN+9VvxmwhWVXSoJR30KPoTUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip v2 00/12] Add versa3 clk generator support
Thread-Topic: [PATCH 6.1.y-cip v2 00/12] Add versa3 clk generator support
Thread-Index: AQHaHjrxMWysxWhZDUyOnqYw4YwsLbCJL8iA
Date: Fri, 24 Nov 2023 09:12:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB11245A418FC4BE15C0B427F5792B8A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|OSZPR01MB9635:EE_
x-ms-office365-filtering-correlation-id: 4b6781d1-c1c1-43c2-87da-08dbeccd6fbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 W+wBEmpVvWqtn2ZiFwwGB2PvmSNEc9ni9OHB7PyMmVyQOnyQLP92rhOLs4kMwpRrx/YNB398q2ILMQGUDlJpoxlzH2XmICeVKZYv8RBGxOgkt5HmOAmLr+3uh29d0Z475qetAVEAbwtcRZKvsAXaMLW151jEQPb7gbS8ZpB0UBwC83bzPsMEsR8GXlZ/P7sNYgj2nGDe42uAcGKQ9L764+2YvME6CaXVGVEf2jffZt+jlK1TRR78FbMLXzD81zM/gU1UQVzaH4mVK+NA0nP+RW2ThWStaWlb7jY6R/KMLTYDDnp2L303EMsDdR5qN2On8ECiIkwRA2uAP8vIPb9VnCgIZa+b55YOIDWphKHXh3tRw47njTk7hT/QiDyWk7T+rBhLv1+q3rN36T8tmkyv6bJcL+oXLpjlhCxWH88xkmxXhNYPARET7lCcu61PDqWhFVp6+b7uRwPuKHW3xWdg4giAwsI4KeclOfPyayAqz0hG9gNPkoOogVCapdrbA2mmIsl+ho6HUTp/oBBN+HAKo51JTwvSzoWXtJ00lZjEnrRqzeDKx3i0M5+jmbfjT6lbVdU9qsmmmzSci/LNbvXzOIHoY9V9otahg7/eX5Vj4PDH3icq5vbyxSi6AKNRshEYLfrCN6sj8I/EoX9cGuoaGw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(7696005)(71200400001)(9686003)(6506007)(478600001)(53546011)(83380400001)(8676002)(8936002)(110136005)(4326008)(2906002)(41300700001)(66946007)(66476007)(66556008)(52536014)(66446008)(316002)(64756008)(76116006)(38070700009)(33656002)(122000001)(38100700002)(5660300002)(86362001)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dWVBVXc4WXV4YklDWUVsRWo0d1VydTJmbUlvWEZiRUc0SDRHYUx5cENN?=
 =?iso-2022-jp?B?TmZKN3h3dzJxMFFJWE4wRVhjOU1QdnVtak1EeWZNd1UxSjZaTUthd2lC?=
 =?iso-2022-jp?B?akVqaHF1THc2THlzaGwrNWxBWkNlbitiZ3Q5ZUVwNUhma0lWUDZicTVi?=
 =?iso-2022-jp?B?RDN3OUJDRmlmUCtGUWUyRzBCbEI4QTFMZDFVSVB0cTBpazRoSy9sdFN1?=
 =?iso-2022-jp?B?ME9TNlYrb1VFd1RDYnZvNS9vKy9rM0IyUVhmNDR5MDlxdUMyVUl4cG9V?=
 =?iso-2022-jp?B?d0FLcDNpTlJWQUdVTmRjWlczejRmUWMrSWFGMWhMWEtNUWpUSjEzV3hu?=
 =?iso-2022-jp?B?eksxWUtyVWM0ZkV5VjBJQ2xvR1hHeFhrU1VrTkVhM0t3OTRHa3RrY3Ns?=
 =?iso-2022-jp?B?TnFsUlVqL0hkT0NVaHRMQTJ4WGRaLy9ma3U0OWMrcXpUV0tKM0toVE9D?=
 =?iso-2022-jp?B?eFEwTUcxamh3V1h4bmo5Q2RrRzhqNTQxdkNoemNtK3QvYk5BbENQWVpm?=
 =?iso-2022-jp?B?aHNzOTdZd3A2ODAvSnBLMVhZaHl4MkMzelFDWHhDWEQyVEovL1R4a2J5?=
 =?iso-2022-jp?B?MTczdkFIc1hoQTVleTlOb3gyMzJQQXVnM3F1eEpmK2pJVWdSbXZxOFp3?=
 =?iso-2022-jp?B?WkMwWktMTHRxemxRd001eExzQ2ljaEhlK1FjWUFoSnlIcURIWkI2Y25w?=
 =?iso-2022-jp?B?amg0VDhFaDZpT21zQWJtaFhIK2FpellFZ0ZKdTBOaFkwNE5yUWM1dmVX?=
 =?iso-2022-jp?B?ZWYyaWIrUUF1Rmxrb3Y1T2U1T1lmNnNlOUUzYXNiK2hVUlBrWUNnN3Zs?=
 =?iso-2022-jp?B?c1p3dXhoT1lLT1RZYXFnLzZzMi9KSzd6YzVpR1pHRWFzL0tQZ0htb01V?=
 =?iso-2022-jp?B?MmFFUmVZS2xnYkRJYnlRYjZQM29wZEVtSXBjcWFBNm93ZFVZQ0xBclln?=
 =?iso-2022-jp?B?YmVvL2w5SmU5bHhyUERPMlRubWowenExdndDbHI0M3d2dHpseTFKQko1?=
 =?iso-2022-jp?B?UUMrMjFoYmpGYTZUaE50bE5CYS9IMkJkU2ZWZkYyVkFSTVJiblpKSXZD?=
 =?iso-2022-jp?B?RzA2UGpEL0JDRXBLY2hnLzlWL1pDRTFVcG02UjFqUnd0MW9jWDdzSmZB?=
 =?iso-2022-jp?B?eDgzMVVpVytORVQ5N28yMHNUbmxxTERQSG1Ba0hUVGhGNVVyUElYdlJx?=
 =?iso-2022-jp?B?d1ZSaDVyWVNkSEhDbnpNUFRQTVBFdzlicFFDTEg3NXhHdDNQM2Z1WlFW?=
 =?iso-2022-jp?B?VmJiRkJTWXFqMXEva2dOZE9ybVRkMkFyNDZjd3pXVi9lUitUQk8rTFQ5?=
 =?iso-2022-jp?B?ZEplV3ExN2hxTHUwcTg4OFlmREFiRWhmRU8yRDNDY0VkbTJ1VER2TzJC?=
 =?iso-2022-jp?B?dGp0NGsyY2JPaUdObVExMnlDSm45UUhnc3BWdXJXZngxbGZXTmY2NVUr?=
 =?iso-2022-jp?B?cEliQTJKS3NqUmxtWTNGcFQ5akVyOExzNW9LaVhCS0lqWE52eUlYNnlz?=
 =?iso-2022-jp?B?VGR3V0JHSkkwTGR4QnVjSWhkeGUwYmJTTVErSXNxYUZDNUdkcGp2MlFv?=
 =?iso-2022-jp?B?bVM0M1FLT2dza3ViUTRQSWdSZTV2YTY1c3FBUFJ6eDJLZExDMGl4dVFP?=
 =?iso-2022-jp?B?V0ZqejZkNnVCTksxRDFSS1pDZlRtQWdZRmdCcmlXZ0J6RmdCbXpibDk3?=
 =?iso-2022-jp?B?K1B6YWZVMHZndkpGaENudzc5bnUraE1qZjRHc01pZ2Q1eWVKdi9USW9M?=
 =?iso-2022-jp?B?eks2NjVVNnZNMy9hUExCdThiSmpEMVlCYUlIbGNTTVBJV2l5THBXOEpz?=
 =?iso-2022-jp?B?ZllGVWo1OWZNTFM4bXBrcnE2dkFsUllMcWw5eStvczlHZE01bytTdi8z?=
 =?iso-2022-jp?B?VkpiT1N2Q0Z1RDN6MVpqdEpHTzNsVFpza3JrTUx2VUFmUUo3VkZINEpj?=
 =?iso-2022-jp?B?aGxlT1NFSC8wWlNBSDllUlpkTUFXdnBmODdwOTRGNDdBT1NJdWx0MzZL?=
 =?iso-2022-jp?B?WkMzRGZmNC83TjgwZWY4VW5uVk4yaXBjQ2NNaXRBeGM1dWpMaE0rOHRm?=
 =?iso-2022-jp?B?OEdkNUpoSXh0MkZXWUFOL1lXaHBqVFpsTTdvVCtlT3Vta0diL25QanB5?=
 =?iso-2022-jp?B?QlMxRVhOa3dxYXFubzdrVVcyQnVkdEk1c1Q5QnRkZVVWUzlBTFZ6Q1lX?=
 =?iso-2022-jp?B?cElubGFYb3NsUVZHUFNQbzFNSitzaXZHaXlvaXFkOFlhVSszamVqdnh4?=
 =?iso-2022-jp?B?UENOdHlScGpxdlFrUUFWRVNRZ09NV3QxQXhoSHBHeG9xV0E0V016YTRR?=
 =?iso-2022-jp?B?YjI5Qy9IVlNLNnpmZERMeXNKRGZ6R0lPTVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6781d1-c1c1-43c2-87da-08dbeccd6fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 09:12:08.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfU9gE0DiLjiQl8sohNf7hPspIwPjGN4xoPtHcuC4vUesDIkVXKW1/5Xd9fMHSQWv0am/HsxSfcvs5VDWmfDgcfQ/Z+2VAk52I7bSi9Qbh4rrNzEdLnBctuJS9wLExqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9635
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 09:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13715

Hi Biju,

Thanks for updating patches.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, November 24, 2023 3:29 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip v2 00/12] Add versa3 clk generator support
>=20
> This patch series aims to add versa3 clk generator support on
> RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Also added missing MTU3 binding patches for RZ/{G2UL,Five} SoCs.
>=20
> v1->v2:
>  * Dropped unneeded patch "clk: Add trace events for rate requests"
>  * Added rz_mtu3 binding patches to this series.
>=20
> Biju Das (10):
>   dt-bindings: clock: Add Renesas versa3 clock generator bindings
>   dt-bindings: clock: versaclock3: Add description for #clock-cells
>     property
>   clk: Add support for versa3 clock driver
>   clk: vc3: Fix 64 by 64 division
>   clk: vc3: Fix output clock mapping
>   clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
>   arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
>   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
>     names
>   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
>   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
>=20
> Stephen Boyd (2):
>   clk: Move no reparent case into a separate function
>   clk: Introduce clk_hw_determine_rate_no_reparent()
>=20

I reviewed this series, and LGTM. I can apply this series.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


