Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79ADC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 03:21:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.14002.1702524062051919894
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Dec 2023 19:21:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 3BE3KtiP3370676; Thu, 14 Dec 2023 12:20:55 +0900
X-Iguazu-Qid: 2yAazcX0IntZMj2boL
X-Iguazu-QSIG: v=2; s=0; t=1702524054; q=2yAazcX0IntZMj2boL; m=1ipf6dY0JKt7qbq40+NX45BvlZZcEIc+eAqarBsR3jg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 3BE3KrXP2212912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Dec 2023 12:20:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahCm5c5LrQXhLmmcS52BWmd+kJ+B0iLtyDFOSI1uN5YHKuUSzPewDX3H9wBgNjSxNPvKyT5AxZFRdfudpTPp9WEZZm39LArrtVbLOyfZz0RB97jcdYkj+c7sRo0R32G5vZ00iD/Jwo2F8NkQZW0yx9zSIWnxtsqoZxU/cb0Tr+kWYdwEcBF8XTLXbrD7w3okDD3u12mxb5l+HW3Av4nfTUU/HMpvcnPWWK5YoskpVp9dqKyQLYFwOPV1+lOdT11pZiGS6QaNmiQIYJW/I0TZLFhniG08iOOV9dx6UBTHMCmM9/EabIkolChP855j+qXzCDrmD4oIS/nU+GH/uq+JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3b12KvqKJu2iFuCOOXV0SvqUbYdS1/wZyzhmHO7O24=;
 b=UewHtodHavZ+HFoiyqSPn2L66zJQo8FVHR7BxtoqZ1YeBrJhi5G1+noNO/ks/Y3IqbI/3fO6PVSWFRbk/WYIWa2wH7g48eYaIGw/nElCM0JjxyrGOhX9VGmaqqpihe/29hXRvYCcSSl4gUpC79XHs/rcZccM91cdEpi1ZBuJFGyv6aepR/qyMAhHQOv0tGEs9wwUMl6Liet/xsKpOp2GcgNk9ENkGyRBczOFqY0nqakB3NUv4cBCR4bXuZedcsbKBu2uP+UiZPOsLQjR0zwlQ3cNWcTbFSRfaN/nVP1IhUmDOWtBTZeumurWkjrF57udPT1UPBB7eZZ2k7Okr/uXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip] ASoC: dt-bindings: renesas,rz-ssi: Update
 interrupts and interrupt-names properties
Thread-Topic: [PATCH 6.1.y-cip] ASoC: dt-bindings: renesas,rz-ssi: Update
 interrupts and interrupt-names properties
Thread-Index: AQHaLeTX/+ZLuQnMa0uCTZel3LtDNLCoHQQg
Date: Thu, 14 Dec 2023 03:20:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB112457DC7499A4A5A8FBA5567928CA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231213165248.975443-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231213165248.975443-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB9749:EE_
x-ms-office365-filtering-correlation-id: e888f123-81a3-4cae-02ec-08dbfc53ad38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dXY1rNfkXl8H5hTnZGfaXmE+XstCqWz8KkxFTD0qna1gY1VU9GYTjofT0ndhTY3aFcwSoQ1zLx0WN2/Vq6zhXAIEhy0hA9TAPcPKLRQperVnP3YNPqy5JP4xDxRh3/ZeuiDnNqxOaaMhbvZFGa4MTfFcaImdJe6Hj4oDseglzJVLDpmz+8nIc4l00fqrHTsIwRQj5lkZMpUVio2PwXdvf/P1rATCo2d0NNcWLPKB3cViN3Jj5JznIqchf8eT70f8a3uK7UU92g4q44sVmKytkRsH5J51JhwMBt179Fr3jITAq31gQouTtBUHLVUUuRbAPkGOi/+6L77ZzD/I9JZyPjVDWp7fTUiYAKR4cysrj6RKArVRTI4aY9VWrR121lNPyUG2sCs40Y/LTI7Gyrocp2sqm30w2HqAhFJHrrjX+ZFzZuHvFNxIXsdS22s2BKXmtN81NJLMKO+KwtTIB6npofn+OmgZpj/TikDqTWLy1TiaEY6PTpzCIYwVYXlHY5luikFC356OTS8kfIam8dbwZzdN/9dJUYvDXV8FGbdju1oGuW7hto0KMz7GGWesqvCvnwa05FCgCafC7zFYj5rV//aw7aPABnXjDedV/XxJFKKcm7vnInHZRhXTxzNtX0dWxzOP27mYIIe+YbnjdWd2aQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(53546011)(7696005)(71200400001)(6506007)(316002)(4326008)(8676002)(8936002)(52536014)(86362001)(38100700002)(64756008)(110136005)(66446008)(66556008)(66946007)(76116006)(66476007)(55016003)(478600001)(966005)(9686003)(26005)(5660300002)(15650500001)(33656002)(38070700009)(41300700001)(122000001)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RUJ3R0tRVFd4V1ZvWEJZYVJFZ2tJK08xMWRCNU1rb3MrZnEzaGJwMWs0?=
 =?iso-2022-jp?B?OFlQKzBBVWRiUnFnQjBweVBrdzlTZG9TaWJnbUpzRlFLTmI1T2ZrbTlo?=
 =?iso-2022-jp?B?Z1UvZkovaUtMLzVLUEVqak5KdkFoMnAyOUhGOGpSa05Mcktza2dKNjhK?=
 =?iso-2022-jp?B?bE5uRHNwRXZ2clFVSzVvMGprSy96a2JyYW1PZUtyNGRVRVVIOWJHcTRZ?=
 =?iso-2022-jp?B?dXYycFpkUHYxODF1RHUwWDZxcFdpZ2hTTzZwQ3BWL2F0cVJKWWtHY0FC?=
 =?iso-2022-jp?B?bTIxRmxWalo0RkFNV0pjWVp0L1E1Sk9PdlpTb2JUTmo3Q3hoRTZlSXRy?=
 =?iso-2022-jp?B?M2FnNER2aTkweGZxb1RPQmErSkR6MXJCVmp1U09JM3BJbjlTSlE3TWhZ?=
 =?iso-2022-jp?B?aU1nWFFxa3dqN0ROb2d1Z3QrNmJjbXFqUlJ2ek5GUExHRDdtZERBVmg3?=
 =?iso-2022-jp?B?MHpjaEFqRGEvYk40U25kaTdSQkE4Rk1QZzVKWllSck9NSHU2ZHE4TjVw?=
 =?iso-2022-jp?B?eSsxcnFvUmNYTFVjU3BIOWZFZFpFMVowamN2QWNSOTFURGlhd1F1N1dR?=
 =?iso-2022-jp?B?S2xnYXVGNnMyZXB0U25ZWUduVHFoaUtQa2ZWdXpqWWJKelJiT1M3L05t?=
 =?iso-2022-jp?B?QllOSk0vb0oxeDZJRDBPODRmaldzSjBsV2U4VWYzZFQwcXFXYTFEZXZK?=
 =?iso-2022-jp?B?K1pEZmxPKzUxSXhPZ2grYkQySGtXVXZKQURhWjQyM3JDbi8wZkVObjFj?=
 =?iso-2022-jp?B?WWEzamxLUk40QlNjR0djRmFvSzdDa3RTQTB6UHRvL0k2UHhGU04xa1Rz?=
 =?iso-2022-jp?B?UmZ2NTNBZlNubVFEbEZQV1J2R1J6N01kT1ZuNVpLMjgzbFJjQVBFanZW?=
 =?iso-2022-jp?B?amFwZjh6YmRHSCtDQi91czRyWS9RR2ZFOC93SS9leUIvWXdwVUFadzA1?=
 =?iso-2022-jp?B?ZU5XN0lnNkNScytoRjI2QmRMbllNOCs3Wm9yTmhGM2h4QVZvby9KcE5O?=
 =?iso-2022-jp?B?U1pkVktKQTlBRngwRlg1SUptS0pvbkwxbFFkcW1DeUFIUUE1VWNoYmhF?=
 =?iso-2022-jp?B?NHIxdkhHcjdrUTlSTTBqWGtVZTU5QmYveVRIYi8reGREN1hteVZGSm1u?=
 =?iso-2022-jp?B?cy9UcEJoZkU0SC93RFN4aytUaHYwdzgxdVlqQk82TWlhalNsRWoyL2lL?=
 =?iso-2022-jp?B?Q2wwdktYYUx3NjV3WllncDdITjR2M2psbENIRzZuTWdwalJvMUdQU0FR?=
 =?iso-2022-jp?B?RmtpbEdYNEp0QThwOC9nYmRtUjBsNnd6ZGN5VjJtbmFWUGxOemVHUXc1?=
 =?iso-2022-jp?B?b2x1dlBkeVdyamxqS0NrWCs2UHBiK0p2eGJORzQ3VVFoTlQrTDV3WERN?=
 =?iso-2022-jp?B?M3NOTFU1TGlHYmpPc0lLQ0NITFBoUW1lOC9pZEdrb1Y1Z2NiR2NWRE9R?=
 =?iso-2022-jp?B?RTkxWGgxcmJwVm5OT29xemJCTGNoWVdwMXREcWt2WVhNT29yKys4ZUJ6?=
 =?iso-2022-jp?B?aUNMZjBSUjlxSXlTaG0ySkhSQ1hDR3NWdjAwZ1Y3UW1abThIVlRSQU8v?=
 =?iso-2022-jp?B?YWZ4ZWxPWXB4dmwrY1ZmVExzUC80L29uMmtYSWp3ZlJzV3ZZcUxNVnFW?=
 =?iso-2022-jp?B?ZWc3cWNPZlBFYWI2RXF3cm9kUFlheUFWNG1XbjJFOEl2ZWYxRGdwVnpX?=
 =?iso-2022-jp?B?cDNCZUYxTStGcFppUE9BMCtzNUxINDk0NlkreVRzVCtDSDJGMWNkdmRM?=
 =?iso-2022-jp?B?enJaYzJNZDJrVlNNS29HOTNZdHJSczVwTWtaeFJPdENxUVRNWXEwbUYx?=
 =?iso-2022-jp?B?ZTA1eWRKbXgrTWs3a0xYbC94eXJUd3VUWlpuU3A4TS9RMmI3R25zTlBX?=
 =?iso-2022-jp?B?WmNwVFFmSkxDV3JvYWFKK3BXQkxIa05maGNJZ1lFdmtDTlIxVEN3ZW5w?=
 =?iso-2022-jp?B?TXNZTHkwRFA2dGVGUktjeEdIbTlMdjFZdmY2YVlYcGxGaDV2TnZ5V01n?=
 =?iso-2022-jp?B?NlpFWmpySWN6MnJPY0VNUE9JLzYrb1VLL3g2VWFNVDl2M2FDZTZiRWV2?=
 =?iso-2022-jp?B?WmRmR2FFaG01ajJBem16U1phc2pyNXUxQzdjdHQ2OS85RjhkL0cvTHda?=
 =?iso-2022-jp?B?YVBrdDkyMklvcEJ0UEFrTGJWT3J3WGdIN21PWnFHSCtFYTRzSXowUU8x?=
 =?iso-2022-jp?B?bGpTcEFZU01Bak1GN09vOElrc2FWeVVDRE9TaXdaSEIrV1lFUG0zN1p5?=
 =?iso-2022-jp?B?RFVMdk5YU3duOTBqWWovdGQ1aTdleDRqY1VEU3kxTDhIMUQzQWUzcHY3?=
 =?iso-2022-jp?B?NG0zelcxcGhwSTZ6RXRQWkFPdmtRRTFhR1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e888f123-81a3-4cae-02ec-08dbfc53ad38
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 03:20:52.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFcLgS43rMBUCKmccGOsk1PcXQJdkbkeOx/p4qGFOtDeoZ/02RcDQb7U4qUHbSt5GBVAqBxEpnMuOB3niH5IQGqSaF4xc7ppItWNRX3zWr3EtaAsu1tWRR0LoEgYCE+k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9749
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 03:21:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14086

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Thursday, December 14, 2023 1:53 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip] ASoC: dt-bindings: renesas,rz-ssi: Update
> interrupts and interrupt-names properties
>=20
> commit 56a3840486ae22c42176828e25d4073712837bfd upstream.
>=20
> From R01UH0914EJ0120 Rev.1.20 HW manual, for full duplex channels
> (SSI0/1/3) dma_rt interrupt has now being marked as reserved and similarl=
y for
> half duplex channel (SSI2) dma_rx and dma_tx interrupts have now being
> marked as reserved (this applies to RZ/G2L and alike SoC's). This patch
> updates the binding doc to match the same.
>=20
> While at it also updated the example node.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link:
> https://lore.kernel.org/r/20230217185225.43310-2-prabhakar.mahadev-lad.rj
> @bp.renesas.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Looks good to me.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro

> ---
> Hi All,
>=20
> All the relevant driver patches and DT changes are already present v6.1-c=
ip,
> just the binding patch was missing.
> - f3f3218a63af ("ASoC: sh: rz-ssi: Update interrupt handling for half dup=
lex
> channels")
> - e83e635becb9 ("arm64: dts: renesas: r9a07g054: Update IRQ numbers for S=
SI
> channels")
> - 684fecd4f332 ("arm64: dts: renesas: r9a07g044: Update IRQ numbers for S=
SI
> channel")
>=20
> Cheers,
> Prabhakar
> ---
>  .../bindings/sound/renesas,rz-ssi.yaml        | 21
> +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> index 0d9840375132..5bd86a685cf7 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> +++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> @@ -22,14 +22,18 @@ properties:
>      maxItems: 1
>=20
>    interrupts:
> -    maxItems: 4
> +    minItems: 2
> +    maxItems: 3
>=20
>    interrupt-names:
> -    items:
> -      - const: int_req
> -      - const: dma_rx
> -      - const: dma_tx
> -      - const: dma_rt
> +    oneOf:
> +      - items:
> +          - const: int_req
> +          - const: dma_rx
> +          - const: dma_tx
> +      - items:
> +          - const: int_req
> +          - const: dma_rt
>=20
>    clocks:
>      maxItems: 4
> @@ -103,9 +107,8 @@ examples:
>              reg =3D <0x10049c00 0x400>;
>              interrupts =3D <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
>                           <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
> -                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
> -                         <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
> -            interrupt-names =3D "int_req", "dma_rx", "dma_tx", "dma_rt";
> +                         <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names =3D "int_req", "dma_rx", "dma_tx";
>              clocks =3D <&cpg CPG_MOD R9A07G044_SSI0_PCLK2>,
>                       <&cpg CPG_MOD R9A07G044_SSI0_PCLK_SFR>,
>                       <&audio_clk1>,
> --
> 2.34.1


