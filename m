Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42049C04A94
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 00:31:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.77970.1691541087604709549
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Aug 2023 17:31:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3790VLb01885857; Wed, 9 Aug 2023 09:31:21 +0900
X-Iguazu-Qid: 2yAbeDFf8kXHsLIG8R
X-Iguazu-QSIG: v=2; s=0; t=1691541080; q=2yAbeDFf8kXHsLIG8R; m=NXsm/gwQQC6712ET0CRuXF/yhXYHOlO3HvSpa5TXziI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3790VJp42140619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 9 Aug 2023 09:31:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2lZTfaQCZYXiYSzD8L0g2+l2rprcZlV7C8Vi9pa4igriQ+qjZ/djFhuW0Gj6toBqt4L9Kb2w2nx5yBUU96o63AddvKdBn+TAAjl68rcCVp+5DPdeWok4yvvOO2lvUAWOLRJ6URHMo29uE3tC43RDYKDTVu+VGlTDP1IvpI+67p8gbBw3tshdnYrPQO926sl9DsOLwskndmA7xPjK//+0yRajiogo8dYWg/QZftRVljred3wXBsWm3dZ1RM2JlKGIXrm9dQXu+rPT0qPXcaDKzaIhqKckeWAMSTDYLkgna0WqNVq3MJ38SviTEprAPAqsFoK7IcEkMuPao1jMGeUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9ONi+y+bmVrUI5/yC0UCHz4mSVlzO39jNaaYCxi0yo=;
 b=LTjHJrtgdhusI1ABfU8pOM26CSQJQO+N9X00HvCI84SV+4B26DAcZ7wOVr3nCh3YLCjdwh47gShqISRgrt4VdGKtlw30ntT+O12Xi2Ps2ireSZI8FYcumJEGyx21NPLjYElM4JOp7hYYBoA6FHEwXpPFqbiItPyBhOvllzndhBzFKbv0zBsaQxS1g8UA9GdPxXWHH8h2QVtusq46wtoNE5myj/PNAz0DP21bFwmnjIjcXNJLUwv+xRNhWXMSB1sZhLMwFulwT6Aka/gDA2fkyCULTcrJKSHc0+qenu0zKaBMLv535ZsVJsSP+vQCT3vt0cAc/UxsJVThS4dWaTTLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l: Update
 overfow/underflow IRQ names for MTU3 channels
Thread-Topic: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l: Update
 overfow/underflow IRQ names for MTU3 channels
Thread-Index: AQHZyd7noR1GixKel0O5d0s6kVErrK/hHcLg
Date: Wed, 9 Aug 2023 00:31:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942094BDC5C8FBA0EC632B299212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230808095825.136589-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230808095825.136589-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5856:EE_
x-ms-office365-filtering-correlation-id: cf35d666-3412-49a8-ab50-08db986ff13e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EFJ/3dviZNbD48LR60LXB+VMR6rH09ELT3eCzkntf/XsaafdjSYY4JC/v2C8nLFXn/jBgq1VMXar4fF1JP4GlbahX9ZYUrv7uhA8L2aY9qPKADqct4MYRNzN1ugCxVsJMcj3KU9sRSjAgl2SwYNQNH5GqCEfll5FeffpJ+OTV0dZQwoCdnUnvangjWKyZH1sy8ZFkpOt+CakQ9iRpwCcu5RXZkwnnS2thTXAq9tDJd3gYIujAcARZ0ySsAOHiHVXO6XtAxYvPRzy/caQA9FVxrvCKjPxJMF4EATut17UuIIBf6NLNaCyTE4Ht3ggWovP5PqNXjGb3o+rVALZElAi9/Jf7sqAhyg7DcteZHUZ+R1qbGiawsVTuxhbaXyD0SPAFYjNN+VdwiManWe1+0rhak16m2RKSNSUwS2sLtx5O3pZTbJS7lV6PAERmtwNf3FTBStIsYWRwFdY8L0CZTPo9pAjEW/BVbZPh/XpxdEzHtTD46vfqlX3/i629o+LD5wb4xKiXn8nJaY3Z1DQAlFWchK9L9Z+Fc6aB3EqWy0mhyDCVtbRTe5mxeBEsJ8qCm1gJVmJROvrGzTPS9o1fSTY+y3lfKpj3HXIzOIFbgGN1VMDRmTbqWCopXnVfKwDeAst6M9fJzzLfazOb3H/Z8ougA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(1800799006)(186006)(52536014)(8936002)(38070700005)(8676002)(5660300002)(122000001)(55016003)(38100700002)(15650500001)(2906002)(86362001)(71200400001)(7696005)(110136005)(83380400001)(478600001)(33656002)(26005)(6506007)(53546011)(9686003)(966005)(4326008)(64756008)(76116006)(66946007)(66446008)(66556008)(66476007)(316002)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z2d6S3I2VCt1RTJUbXFlakZXSUoydzdtVFNPakNYOGIzWUdvUlJvTlBV?=
 =?iso-2022-jp?B?elpIekpETUh0UVBWNXpaUjY5bTRpL3hJaWhjK1h5cjc2QXZvNzh4NFBR?=
 =?iso-2022-jp?B?MGR4RzBvb0FxM1owYWU1TUVmYlJyR2VOOForT0ppREdhN2NYeGZvWkVr?=
 =?iso-2022-jp?B?T3VLWFVFeVFaK1NNMU9vdG51MGcwUHZEOC9TTXJtRVNzbHlTVTFITkYx?=
 =?iso-2022-jp?B?ZEFWNTQzdFJBM1pVZlZodnhLRDdMSjZ6dmZFdDQxd2VnN0ZtdkJQd3JR?=
 =?iso-2022-jp?B?SlRhbk82eGlKazFFeXN6S3BQb0lpQU8zZ0dDWndjOGwxRFNZVUtDYXg3?=
 =?iso-2022-jp?B?THdpNkd3SDVjTmQyRlE0dTU3SHJYVklBZGpBb3dnZ29WY1hvWVdJeGdo?=
 =?iso-2022-jp?B?THA5Nm55OVVKTmY5L2s0TFlXb3JLSHNHRG1teG9LWXlGQUk1bVdZWkM1?=
 =?iso-2022-jp?B?OWtwRUMzZFBScjNQUnF2ZU92dE1zUlJ4djZjZlFoMmxHWmVPWXJ0bHRH?=
 =?iso-2022-jp?B?eVZrNFViSTJ6dGNLcjc1WG1jVjYrOWtUVWt6UlV1emtyWGxlR2Ixdkw4?=
 =?iso-2022-jp?B?clNjMDAzelVMRzlkSlM5ZUlJU3RyekQva0ZqaUhQcWFvZ1R2UEpURzht?=
 =?iso-2022-jp?B?eHN4VldITzNwK3Ixc29wbTVxd0RTWXRUWVpyRy90eGVSMGxycHIwRDN1?=
 =?iso-2022-jp?B?R0NOaFo3R1NyaEJkQzZqWVo3ZDZ5d3lVamZoRkVEazQ5RkJHMiswdUN4?=
 =?iso-2022-jp?B?bzhSTzBDN09sZisrTUk5N0h6RTFaRGpPd2dwY3JMM3lVR0UzTGk2Z1JG?=
 =?iso-2022-jp?B?YzQ3YWw0aGw3SDByU3lwbU5PU2JzR3ZhbkNJendiekUwOEhDamNZalpl?=
 =?iso-2022-jp?B?cmRud2s0azlMVzIvVFlranRVTlFJaU5zQW5vT0tiK0h1VUZjV25nMU8z?=
 =?iso-2022-jp?B?cHprQ2JRZVpSZjZTSjJGN3pXcEtWSHYrcm9Lamk0eDlIS2M5ajFLSDJL?=
 =?iso-2022-jp?B?VHVJZkYvVCs2RW4vMVZqNC9lT3d2Qy82MjlXd1JvQ0VIZVBXU1QyRVhu?=
 =?iso-2022-jp?B?cng2TXQ4dFJGQTN4NXFIZDhjTUgzYnA0N1RmcjNDQytJZFVWYXVIc01L?=
 =?iso-2022-jp?B?dytkSlF4Y1BVai9BSnVUbGhaTmh0cWpic3FDcWlvbllYNFV3VzFsTkg2?=
 =?iso-2022-jp?B?SnNsK1V0U3VpdXV3YUtVdy8rOHR0UElvL2ViYlZ3c1BvRGk5ZU8zU3Zp?=
 =?iso-2022-jp?B?V0hQS1ExYmtJSWJwR0FVTHVqVjJmSjBIUTlmTzY1eG5GajBZYVZCQ1hF?=
 =?iso-2022-jp?B?UUxjT1hYczQxa2RrS1FBT1p4eWc2VzB0S21zaUluKzMxTnNmZDVQNUJQ?=
 =?iso-2022-jp?B?VE5oWE1Ibk1uUzVQQ2dLbUVoMFcvenk3ZmovalNtOExsRTB4ZEhWMjU1?=
 =?iso-2022-jp?B?OWlTM1N4cytSd1dSZVZIVmFIRWNXWmVFakRXOFg3aWxPMlFqMnlKTE9B?=
 =?iso-2022-jp?B?Y2dBUW54Ykc1TXcvK29KbkNzN2lOeER1QVJERS9kSTBoT09OSzYySkcw?=
 =?iso-2022-jp?B?VzhzaFdFa05WRUZXR0RNa3dNSVFYMTBYMitDTXZIY2lVVTVUY2FMQ1g4?=
 =?iso-2022-jp?B?cDRDbXJ1Z3ZZV2JSdGF0UnZVbzVPSXIwODdvN0crNGFSOVZBWGpuaXY2?=
 =?iso-2022-jp?B?ZTRubnNGU3BnV2VpbVlHZSs4NnVXbC82QXVQYStaVkpYYUNhUEcvRGY4?=
 =?iso-2022-jp?B?dzdUd2ljYlJBS2dCdG1pTlYzRWdGdlI4N09ySFdjaVYrVjE1N3BwZlNu?=
 =?iso-2022-jp?B?RWNFbWtoYnp4RlZTV0dENllzZjFidnY2c1dZMlhmOVFIZWpSS2JBN3k2?=
 =?iso-2022-jp?B?eWxacUROenkxc3BKSVlrT21UVjFaMFZtcUhHOE9STFVLcGhhQ0h3VlNp?=
 =?iso-2022-jp?B?U0ZDa2QxaGlxM01BdENKWG9iRzlpb0R6SlRocXFZWjlvbWRiUlVZeFY4?=
 =?iso-2022-jp?B?UFFRTFAwZlJmK2JaaG5vb3ZCQ2owWWU0ajNQTWRuZ3ZWeG5EcGJkb0Iw?=
 =?iso-2022-jp?B?Z3Q4dEdXNVdJa3pHbkNpWVJ2SitiUXpURTlmVmRNWWFnZUN2endBaENS?=
 =?iso-2022-jp?B?NkVFU25USzRjaHNxa1ZwV2pxa3JlRDFnaUtnMXp5RmxoeEtuUDFxYVBD?=
 =?iso-2022-jp?B?TXlmSGZVZm9rUHczbldIeVQ3UHRrUm04T2U3U0FYOFBoTkJqTnJmeE10?=
 =?iso-2022-jp?B?eDBFSnBqSG9oWUY1SXg4Y1lEdUgweEwvN2hqaldCTjhvdVBVdlNicnBZ?=
 =?iso-2022-jp?B?dDVVQk9LdU9xeDN0OWNEVTIrdFZlMTM1aWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JmZNS8NHh9F7YEbIY1jc1dw3+9qSURcgSJAnabdQLCuEDQ5e1kU+v4Zr5BnnnxzqlVkF/sB/HQQF+EL2WodIf66lGuqUJmHusU7vNA7gJNX1gB/CVWnguAbhz/s7qFnmJ9VMFdqq3ezJB3enPHSSHK7ZgAJZter2ZnFpeGdIbHv1WonifgEK4u+nqdFIBq3sRdcMtXX4w4D+uHlOvcQqSQOMuuF/ZJgLEQf+P/kiHTtUV7ehI4ttto/gVPWmhg5qRhyjXQjHpy2kWmUZpHhJIln/JyH4FPfR+mLDlktzrqErB5x+mPVqhl6zGBArTxA7kWo9fJIcnR2seB70kQDEAljVpB8/KYl91BvuX6Ylfo7wlTEjc5rszJ4Y8S/1JIbP+MaAzTEN/Gn0kMgOEVGEh1aLfvYyEvBXtkJuPGX7wAyG+t9/l7fIeBK2bTPCF+BhMDm25kDWmtgJUfkRQpH/6B4abHHmhogNzltPmvkSes3IQh3NIZp0eFXJ9/MgYquqlyCS6rsacPq9aaUnAEq091jqGFC6tOhDjBPoj4FYLiGLf38p4imQ0v1+txNnCcILoD6iAMIwcuUM7eELubxkpI4U2Pawp2cFwKB2Uvaq0Voj9qH0wv+2Qen1pg0k/2mHQ7JKfv4HnUDfABH6LYCAG685hL/xAlKbaBxbyTTW96WCgRp7Edjxw/Pmc9OXmIl7pWE83fE82HpyXt5LxiAitvDei8EFL7jDXncxsxhckxp6PZPopEVXVhtcanF9UJYu4lDq58J7F4u1ZmhyrxC/IqLZF/Hv66m87g4cKIrBVAmztBDu6oOPzZC+3BvcEOa3Jnjv3UL1hflJZ3Rpg3KfrtARrZ6dGB2hrh3E+zZtvGl0nTJSSxgkcWcjctV45Oe+
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf35d666-3412-49a8-ab50-08db986ff13e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 00:31:15.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: webmiTVjAAzek5FQ7J3SC5Ohn3ET3O7QH07WN8Szy4Xu1a9ao4n1HQM7lP/be6awJZlfPUBVJs9h+LuqZeGnM0AFfjZ1zS8KbwHlV7la7PdyyQ527sRLuzm1HwMCpVjf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5856
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 00:31:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12566

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, August 8, 2023 6:58 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip] arm64: dts: renesas: rzg2l: Update
> overfow/underflow IRQ names for MTU3 channels
>=20
> commit 4c188fa183ebb45238ef16504c4c7606955cf9d4 upstream.
>=20
> As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
> interrupt names start with 'tci' instead of 'tgi'.
>=20
> Replace the below overflow/underflow interrupt names:
>  - tgiv0->tciv0
>  - tgiv1->tciv1
>  - tgiu1->tciu1
>  - tgiv2->tciv2
>  - tgiu2->tciu2
>  - tgiv3->tciv3
>  - tgiv4->tciv4
>  - tgiv6->tciv6
>  - tgiv7->tciv7
>  - tgiv8->tciv8
>  - tgiu8->tciu8
>=20
> Fixes: 26336d66d021 ("arm64: dts: renesas: r9a07g044: Add MTU3a node")
> Fixes: dd123dd01def ("arm64: dts: renesas: r9a07g054: Add MTU3a node")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20230724091927.123847-5-biju.das.jz@bp.renesas.=
c
> om
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 16 ++++++++--------
> arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 16 ++++++++--------
>  2 files changed, 16 insertions(+), 16 deletions(-)

LGTM. I will apply if there are no comments.

Best regards,
  Nobuhiro


