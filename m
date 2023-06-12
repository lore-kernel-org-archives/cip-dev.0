Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9833C7EE2E
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 07:19:11 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.131])
 by mx.groups.io with SMTP id smtpd.web10.53349.1686554347607206445
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jun 2023 00:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Z71iwNDz;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.131, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQhugo9aStFVLVH5VpLQ59leJzfn9VK+xuQYhwMSYAriFroC/ZSNm+In/cgGGNAsAdJsWedt27skYeH/Vs/7jJcaEiOOzLMPT4qpoO2/H1RQeEA19oy9fXXmZ1WJIGh85AmmiiOAeDEeV4wXXe92FlevyHoKzQHPlhU0InACojsqkGHeHcK9U0/TBUwzQWGPB7AloDIrS43C9GSE6T+Be/3zJUvnQyphvc1gYSkdl8l7m3OZ5KoE2uaCeQ+UNFSuGdbADw0327XJeJNCDEjVIixhDYRdSxB4adC9XgG7wMuTnI1mWo+ArPq7LDCZnMZSIRyZILNuP1kE66D9cXDRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO0oSwMoG2MSLAycRn0ZRTMet2creHykJ2g3sQBWjOY=;
 b=Nxh2hdwOoviuBYn+q1KWuqyR3sPAgqXVdnTfKfp4mhr8jYlvs4AH4bp/N1FZ32//PERNYnDXZe/zjfSoBwbpaiizV1ykFEQYKb7lF2qxG7b3MrPG9c3/OyKh6PRMJAvmyRabSYwg2yOgPwRVypCiA/6yLa5wY9Eypssn1Ni34h0eTrCdYARIFypHCq5EVU14MX9vIcZKHMxLdJ5e1m3ickqS+1FwEgIt/Ak52oPrTho/wfVxJwJrsJ9GTsRs9loyZK/Gd9Qy5Zr3rCBQaRY3p2KQ2n2ZiiP/j92hKWgtgEbVBVP+LTqIjDVQCrEbdSaPMTf4JInEm/1aJNDt9sgXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO0oSwMoG2MSLAycRn0ZRTMet2creHykJ2g3sQBWjOY=;
 b=Z71iwNDzOqTCKgyiitBJKtraVTu0josuimNeEVSZ1IWw2A++WpDo8sEEED7cOEGaCOS74ncLAORCF9HLZ2RrOSSeikWcBQ69gJGNdbUitNedooDA9ur8P1eNvH+G3oxnolZfQFRDWGBzMcOmNcAkuU2tkrZqff/hi4uueYy/U6I=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10941.jpnprd01.prod.outlook.com (2603:1096:400:3b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 07:19:03 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 07:19:03 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] v6.1-cip: state of forward porting
Thread-Topic: [cip-dev] v6.1-cip: state of forward porting
Thread-Index: AQHZl++bJ6zLyclMYUeS62j6oSuDmK99WhJAgAZsA4CAAwWj0A==
Date: Mon, 12 Jun 2023 07:19:03 +0000
Message-ID: 
 <OS0PR01MB5922503BBB3D0DA3B90A6BCC8654A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
 <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
 <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZIQ9Txvw5Nh9ffEg@duo.ucw.cz>
In-Reply-To: <ZIQ9Txvw5Nh9ffEg@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10941:EE_
x-ms-office365-filtering-correlation-id: 651fad8c-7911-485c-7c93-08db6b154d0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +LE5tp4xp7eMfGXoe3XCpeAF9wtd57RSHzeJ2JC29vC1KTqOPQ42pvHddh9SqhHmhUKbJZw7hZTdgCtAUsdUdNyH/BGAi+p0G+ndMC94cFDB5t0pqo122D5MAUuJh8gt8mD7V1Dnm+NieK8R880ydJnrKDD6HiInZTFXYMDCAywZgcXC38tvDXhsBDcr7Sce1siyTa/PLsdNLfk+yzu0BRlrNm4vpEDPC8WvUPh8R2/q5lU+i1siGI+4dzwXHfLVg0i2vPNchCN/MWj0zOgqMkI1rd/vQl8lngzQRKq4HlqPXxluyl54WsyGSLpiw5N5llZ2DD1Z95s3Q2EIfFLPkocanEL9FVUoHYLQWU/wWtTqC9rtLgf9t++E7e8AcCVSR30a7sIGGquTHYxdwnnLf/obUAWd1zZCQtnSsnraRlsvnWsggBkWeSCJSjcWbrUQyYUMQ44/xh2XPy9iEg7DijMJs60NzsYFfB6/Ixaox8+sN5VXIcdpWenaLdpm+2FDTPLHVZoY3AM70Ut4i9nreI22YD84CP2thaK9AZgZ0zc6jtY9KtY21oXgowbW2q6zwfyA/f0Ut8PVmbKBeed7aBMjmJxl9/ylI9N1adHvmx6mQdyAB/x0HZzgYGHvjfIIAJV/g/xQnE0tXjT0l3WzFA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(66476007)(66946007)(66556008)(966005)(316002)(64756008)(76116006)(71200400001)(107886003)(66446008)(54906003)(6916009)(4326008)(478600001)(38070700005)(33656002)(86362001)(6506007)(26005)(53546011)(9686003)(83380400001)(186003)(41300700001)(2906002)(52536014)(55016003)(5660300002)(8676002)(8936002)(7696005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?BGU21NanUzgzv91xoVzwaq5F/+b051DyxkQH3SCSBStcEu8JgeCHAV0vIUVL?=
 =?us-ascii?Q?pyNlbBdxY7IJzR/wnTzz1MsLiGEFKfxlwHS7FKwzTF49fHGVBdHz71E5Q3al?=
 =?us-ascii?Q?uc+LuwF69ppcPtjCH9JZL7/AlxDTP+BmxbVhevMXQiqvwudzhyMOSgj/Ptjs?=
 =?us-ascii?Q?PejT+m8xtke2HU651cWOScq69MkzLMHa73r8BP4O49xl6EjieFF14eH3MfmM?=
 =?us-ascii?Q?lUC3hI1StWsSoK6CKBDB1wqV0oA6Ai132NJYLu3nKMkrJOlvX10RjZ/nNavd?=
 =?us-ascii?Q?j4a+pU5l/+aiD8KHDMoXLUJxnZ8u6fEmz0/ESUeVs99Gm5COq1DoMq+wwPq7?=
 =?us-ascii?Q?wpkvzpAe0EQwar+v8b/phRNDiml0J4Hleg75dtX9OFDPo6kV2dLyXBSbU51I?=
 =?us-ascii?Q?NeN5s/tV2aMZ1KorN4SXvYJK9bLe3w8eAtm/veS6OcURR5skybEYTERVk6aX?=
 =?us-ascii?Q?DUZGctZP18x1zo+MrZK8Kz7o2MK/0+AgN+R/eVZWt44loV4yxzvq53notxmj?=
 =?us-ascii?Q?f2zRwB8LFNWTCBlrrEL61m/DOnTWDZcXYekl2M2+ShEvjkVCTFavywpg4hgK?=
 =?us-ascii?Q?eplgyR9vjt2AUBI81L6i+fZyrK/VNks6agesTNDKJmlahZVLKiwPPLxmuHcM?=
 =?us-ascii?Q?45npwEfCn+z9z70QWsMOTjOUB2FBHUprqERhhHUuNstlX3wa2M1J3+iMGoGl?=
 =?us-ascii?Q?hBplOYx2p2UM9MLxpBJf1FMpAx/ZmGfjn6rY1LCCRm0gOHsmi+d/WBtqxwOt?=
 =?us-ascii?Q?kUjoOb0H4uktuUGeNuKeeAbkRnMCZ5JLc1kYIOPRMJ/51LI31Q05JsRDsQIa?=
 =?us-ascii?Q?Jn6u4J/SYs1P04+KKpC846q+cwx42XAty/pIM8g6q/Ds9/TkiuQ8SeATOios?=
 =?us-ascii?Q?hh1szxc8teL1IYhG3yn9bhkbc7mGwWfUKe3qfr3n/YzJoh5yYyq+LHaOYxIE?=
 =?us-ascii?Q?lLzeHTrh8xih9W4GXMHh7VAgWtL51Q9j6Lk8xdjHiY5ACg7WEaUlu9L68Bcj?=
 =?us-ascii?Q?AIrds0B1mJlE2KhDUE5eN5zKa5JsP31qe12hLNLCbN+xbBnfkRozpDtixXpj?=
 =?us-ascii?Q?4ETsCsNxgOYfaRSlOInch/NaafWe8qqloq883M0YhC8KwircyKdDwXJ4Odp3?=
 =?us-ascii?Q?GwI9TdhhSSLAGt/gEEzhnpytRs067x8mnif8iNnEEZARB0VjsOUwKArnmosZ?=
 =?us-ascii?Q?h4pbQSkhvYVWC1M0XTx6Y8MVYRQqJvXRntsesgd3vvu9NEUnIGRvoada9xFb?=
 =?us-ascii?Q?b8Ni5qm0345opLo7senySZA5oChEf68VMebY48FPmZFiNLmGu/rAu5NJpafp?=
 =?us-ascii?Q?9dC+7X7+pdKq8O4jOSxwPBiVfMfh5fKuKG/UT04hbD17Gs31U6zi59yj3u7Q?=
 =?us-ascii?Q?7gomLh55p+fV03P0ScLI99AYp+MgjCWWMhhnQri7zWG9LuDaEYeywB5czRXI?=
 =?us-ascii?Q?dVYHbW1CM+0ZvY+zm5UCtuf4ZzvwZU2mF1hjDiSzOWFLy8VDM9KQEwbkaQeQ?=
 =?us-ascii?Q?BAhFEWiU89Y9mLi7i1BP9rjbf3cXkDU8T3gzsyD7w1e07uxOWa5I0PFGFsn7?=
 =?us-ascii?Q?ovjZNrK+vLrJ6SJjKICWEWF4ST42EbiMPfj41gFv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651fad8c-7911-485c-7c93-08db6b154d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 07:19:03.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDSwlm4quJyc83f3zoan8Iprn6m5XblNQVqGVfIisMsvfedVOG1O+dxR5GanrxmfKgzWWOZcVCCYngxWUs3YaoAFWOf4cCkCZrjlzAF27lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10941
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 07:19:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11971

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Saturday, June 10, 2023 10:07 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; Chris
> Paterson <Chris.Paterson2@renesas.com>
> Subject: Re: [cip-dev] v6.1-cip: state of forward porting
>=20
> Hi!
>=20
> > > > I moved 6.1-cip branch a bit forward. Below is a summary of
> > > > patches that needed forward-porting according to my scripts. Let
> > > > me know if I missed some.
> > >
> > > To be clear, by "forward-porting", I mean "making sure all patches
> > > specific to 5.10-cip are in 6.1-cip, too".
> >
> > I confirm, It looks good to me. Maybe this patch as well[1], which I
> missed in 5.10.y-cip.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co
> > mmit/?h=3Dnext-20230606&id=3Dbf58a687db232e738105244e34a85d21f5e2598d
> >
>=20
> That's just documentation, I'll let you submitt it to 5.10 and 6.1 if
> really needed.

Agreed.

>=20
> > For CAN I guess we need to backport below patches for 6.1 aswell.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi
> > t/drivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3D34f9e9852b90d7=
be6
> > eef95874500d1fb1b768e7f
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi
> > t/drivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3D841645cfc773cd=
d0a
> > 21c67357c53845f2e972f91
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi
> > t/drivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3Da1dcfbdfd1d0f7=
843
> > f381f7c58cc87a0f8c11f6c
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commi
> > t/drivers/net/can/rcar/rcar_canfd.c?h=3Dlinux-6.3.y&id=3Dea6ff7792203ad=
678
> > 6bda75d1dabf33311c8bef4
> >
>=20
> Thanks for hints, I think I got it right. I would not mind someone
> double-checking the tree.

It looks ok to me.

Cheers,
Biju

