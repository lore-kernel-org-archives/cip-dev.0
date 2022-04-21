Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9912C4708B
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:06 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.129])
 by mx.groups.io with SMTP id smtpd.web12.19936.1650538520179075726
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 03:55:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=HhlIdNzm;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.129,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZpSxHmFBERO2rdknYbSR9NZWRs54hrL4eS2fADOt9AglMdCgiKYrR4I92g3K+ZV81JgykxSfKoMcmAgIigT2iJdMUYzHnRmyKLFebRheyrLr+gdWdkAoyoOun4iMtIxkGEJ257FafKCbF5H2PqUhcjG7VMv0smK35YbJK8i2imLZHsDdM7hn7pCaaoNV17cWNnmCHpXtmc2jD1qtqt+Sqkl0IS7MkCC5HdwKccwu4TO0KaObGVzfkG5D3RnhjTBHBFCEEz42Xsz8QcqigRQbfR6l76L1lJjF1KZgZ2no1cPDfpxRhdcezsDYCe8ujpIsQshZyxUvxiVqmURuw4AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmL4mBJRQkGbaQOGBdZMzSwOlku1UgTgEXUWVgRnz/4=;
 b=ECXx3SodURDjJglSchxNRRqw50NRLAkFaAyLUeilCORGA8rm1OdbpZ0DJZbQlnfpQu7XIAmJSKAJ1vTlZs2VscadOIrGzfzsKi5gfCD+eXOMC+YjiaZkP7VA0VSudL566ECeJ2nIEtyxEjPgEvUrhEX8wNvkcUV/PCZvQcx6Edtrwv5wklRy2skPShXfY9fQni2IBncoYySgR6+Bp/jB1GCEaSz9NBdFM8Sn3J7i/UDVZ4GIv8GgJ+0fUutZBnpRqQ+JfrlyC4Y+VwD/n96TbM/Jegrq1j/Sc3/U/IgdVLxq5kliwUYLaogxGCMVR7Td6fFB9C3yekNmmylI3aJxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmL4mBJRQkGbaQOGBdZMzSwOlku1UgTgEXUWVgRnz/4=;
 b=HhlIdNzmek09iJeY+tKfH6gCI1HXYJds4xhOVF85qzlSTYcgxm2Sc2x5bXK7tdb3/e0jjAOigFZAKHsrfwf8a0sRBjVPPb6A8Eg6XU35+ZWOl4avCObKPWpIAFK61N/sbF4uVcu/lRfCamIOOYsvicLH2SbzHyRgcX91QXRXK6E=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSBPR01MB3077.jpnprd01.prod.outlook.com (2603:1096:604:15::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 10:55:16 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::f40f:460f:2222:3dd1%4]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 10:55:16 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 03/24] ASoC: dt-bindings: renesas,rz-ssi:
 Update slave dma channel configuration parameter
Thread-Topic: [PATCH 5.10.y-cip 03/24] ASoC: dt-bindings: renesas,rz-ssi:
 Update slave dma channel configuration parameter
Thread-Index: AQHYVVpmLC9RlATB5UKWSwvdDdMM7az6MVCg
Date: Thu, 21 Apr 2022 10:55:16 +0000
Message-ID: 
 <OSZPR01MB701973AC012FE5E43928743BAAF49@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220420213424.27837-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421083248.GA3269@amd>
In-Reply-To: <20220421083248.GA3269@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ab14dfc-3db1-4ec4-e915-08da23856b83
x-ms-traffictypediagnostic: OSBPR01MB3077:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB30777A547011566F0AFFE35BAAF49@OSBPR01MB3077.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Cu1ZFGVeEJNv46kwIqOmXUYHZLBL7OlKulhmgaH2V4X9MB3TOp+XS/jJJb88QQtvYNdm+ucHQAVNHRU72EjzOXg5ec0haxLQyfX9/E7UshNEjBF4LGvVywrb696OgFfKYZB1wI7mB8DbO2HTG6sGeZmWMAukc4/e8bhFXijXW75gyQxx87KTiYtr6CS9lXxK+HgV2NNm3jURfiivwkZ4o9VORfgmYvxzACGUSRfxmj6ruv8NDZWlKzDxlKMjO+kWeq9FjDn+oVx4OliUX6wy/5MHwK3+KOg8sJxyiAe5tH4PJ1PoJKh5+GbVB0N85EMLefDkoO8e0oNQyWr9FfNUSJB/tXyHHBhZdxrddTvgCvInjty8fr4A5NsgkI7/8om+QKUd7VXZ3ObNASnsLfgHL1efo7TBL3x6dzWldccUdYhUkrJU/9wlV3lLp5XLvNfmgfutQN+5rPWYSWz/si7Ch1yfY+qHwGOyNig+DIjeZ79NClRrWCyX2Mn2bmuTZGCULh0iV6uUMsuwtTJZP1FuGnpQptBbY/x8Aenw05WTbMimSo6viORTdUW/49atztPGqORRgoytIxYCk6MqD6iIOhrcuEVh9wOTEdySVy1kDHBqmhYbAoP7BuQ9p8pzc/2HgBoyxcgXtMaykz715MbrrFnlznWb7CoAA1uFInCmeEvWPXmmSRVcY2P5VKEWm1Tpof6SwbUgWvBf/C5Xqm9oZQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(26005)(6506007)(9686003)(7696005)(66476007)(76116006)(71200400001)(66556008)(64756008)(55016003)(66446008)(86362001)(33656002)(53546011)(4326008)(83380400001)(8676002)(66946007)(508600001)(107886003)(38070700005)(8936002)(122000001)(2906002)(38100700002)(54906003)(52536014)(15650500001)(5660300002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Y2+4IEoSTXG+GaF6dyEmfchmrlcCINHx2RfxSpCkZUmYgGpmwIuPUlrSE4Xt?=
 =?us-ascii?Q?43rojUMNHuEoZ5QHGxgnUwZH8andpJKGTKcVx2SjiGsu/xYYJ7BS8Uvx5jhx?=
 =?us-ascii?Q?0hgKghDffFAKE3KAVNKuS3Zgu2a3G4tHC8XijkrttBg1WSZKid2o2HtnBreU?=
 =?us-ascii?Q?zbxqgjByRQq4pNcv3XjwmYOu6QNGxueq+bzKKAjGDSTd9N5PrJntoJEaKxNC?=
 =?us-ascii?Q?Nq9BfN1wP25WITuo1z2T+cdLET7g7hiH5XqKq0pAJdWuI3D0IuIBQ3B075dI?=
 =?us-ascii?Q?bWCQOTdzYv1kEckuyhLBIusyB/GztaYDuXlidEPeWQVXzlXMuDPi/WKLOx/7?=
 =?us-ascii?Q?TdSLecsGGu5FDHsNmhM0OudEJLlvij02kLQDH5e7fvMxw20zPMij9a1Rec7R?=
 =?us-ascii?Q?NiDB2FNpXPpFXSq0t3ZcKMp6ozSFXPKQXhM5fCFGq5ewR22JIOEDxKhYM0dD?=
 =?us-ascii?Q?MyvuqkmMacjuGXs+R53Zs6qRIRNggGh54w1UL3CTkKOKGYTHr0ozYdc4qH6I?=
 =?us-ascii?Q?8TwRLtHB7mEZbEuR6U4HMsZObknUNIR53lKWH7XoW8vuOeesXvhSzGkVW1Xh?=
 =?us-ascii?Q?Ayl/yh1EL8oQZfWQoHMWq7aKOKim+XuN3LnydNBtuTYjZK/X9zEsvx0qNeZH?=
 =?us-ascii?Q?pT104NTBIciCSHvxdgjjFzj5zldnj40qsPkSxEM2gepeUIei+jlc6qrPgliN?=
 =?us-ascii?Q?+JsZe9Sih/ixZsVINUnG8Ra/1FNwB0z4DdBLs7BzZNvLU0iI8d/WxgpYe3pc?=
 =?us-ascii?Q?57O5qyUImr929eps3+zXU+4l1m5t2rnNCi7V2l2FVrXRpQncZogCJ3joOSGI?=
 =?us-ascii?Q?Q4Wj66aUMVXt5lQlvBk/9NNjMvF+2Ap717ovmGW7bIch878Xr5sT5RYiyMF5?=
 =?us-ascii?Q?EhRm8niCM56n0dszFP4nNq+6UkgrXxzv0CiXGzQA+F1g8mLGwxw75kvO9nJR?=
 =?us-ascii?Q?lTY281bHZUsKdkLKoaT3/XRjv94y4nr/aVkvBZtQp3h3Xx8y1l/3hwLuQet4?=
 =?us-ascii?Q?49uwCGQt2x2G5MhBMeEJnqw918rYn/IaaHB7pHNK+ZJA9U5gWus2OhY7OqUp?=
 =?us-ascii?Q?POCh0Ljyso8P263H46uCRvdfIIGRwU8l3+EFchEm/e4Jrmsi1Pyo42C5OQmF?=
 =?us-ascii?Q?7ynGDPgGG8zKnBWUhMCKMyxbhYH9T3GQzX8ssCi+GCgerXNf1ZDr9kAw2q3C?=
 =?us-ascii?Q?wVzRn7rSzyIN8Dp2VntvLlhACTTTKLWvSBqtbIaDSZZFdydnZQDQmTKhEu5X?=
 =?us-ascii?Q?YSL6d1e3KTFwL8OHOuV7I9BO4T0dPAd0lexfVfHmk54xgJchDycgG3iuRz5G?=
 =?us-ascii?Q?q8gapszZEUn/Ec7untjArj4EzINIkWKx3cwdIkwQpYXZLAYeUUz5lX+UTQNX?=
 =?us-ascii?Q?qdWy2ozMq4iCt/5AdRpesm/ChsLDOTgxbZ/lJc/4En2G2ufZBS0JKiV9n6v3?=
 =?us-ascii?Q?E7zocK49ut9HjCKJMDivyUuu7H7NLa8MavrN1F/ZKHviPvNqCv4VusZKI5G1?=
 =?us-ascii?Q?M9BdwpUKrlnMVHLj2PtF0E1XLWJx4Gh/aKI3NvazEudU4a78KxaQaHNe2/Oc?=
 =?us-ascii?Q?0cBOBGWlMbjRMBqFaa+ESp+c32dgnSBlNuDtbO0KR8yM4WAvu3TvSPYjT5Ce?=
 =?us-ascii?Q?b66DTO2o5McD85w64m7zQ2Y2p/aG3URMh6EiBRce2Llmv1tRo/pwF8W1ah0E?=
 =?us-ascii?Q?Ls40ZB9atbg88S9e2f+JbOOKmNOxMSwGeTXCvARRJbLPq71W0zawKdP9JQIP?=
 =?us-ascii?Q?jTxAL1K5IMpWmGCclCsLx1sN7Rz5GELuxusMg35Ki3+zY8w4yTUQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2ab14dfc-3db1-4ec4-e915-08da23856b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 10:55:16.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Vc7ZhJoH0E1SKRoNnWv5x31A/Cou0FJt9sd9x4U+xImy/LiKn5c7AMRjrY3s6LjMmeOe0miWSuIf0C9z4jhh4w5p5DxbrB0p3hrAmG2i/bcwQZKsxIJ2/9R6TDiAlufB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8158

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 21 April 2022 09:33
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 03/24] ASoC: dt-bindings: renesas,rz-ssi:
> Update slave dma channel configuration parameter
>=20
> Hi!
>=20
> >  .../bindings/sound/renesas,rz-ssi.yaml        | 22 +++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> > b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> > index 471937cb8d05..414ff8035a4e 100644
> > --- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
> > @@ -48,6 +48,24 @@ properties:
> >    dmas:
> >      minItems: 1
> >      maxItems: 2
> > +    description:
> > +      The first cell represents a phandle to dmac
>=20
> I would not mind . at the end of the sentence, to be consistent with the
> next paragraph, but that's really a nitpicking.
>=20
Do agree, if there are any updates to this file upstream I will update it.

Cheers,
Prabhakar

> > +      The second cell specifies the encoded MID/RID values of the SSI
> port
> > +      connected to the DMA client and the slave channel configuration
> > +      parameters.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

