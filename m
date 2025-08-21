Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E51FCA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 17:05:25 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.62])
 by mx.groups.io with SMTP id smtpd.web11.1919.1755795919637913686
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 10:05:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=gCHww4FP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.62, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaOOG55tiUFze1OWmiwc1FzjyBEU60FWCxPdMiEZ0cpU2w3OifTHd/9ePUI4TxDu6r/hI+jQY2Htym+rBeHkTyWqPHn7BmLFN4+19saVEu1UI9qFFZbyxeRmnkOc4FsuEd8N3117wzusWM43kVpbihpOPiakloEPVOTcY5CrWy3l2oGf7Llmno8A1C9W4vTvfQVuXe/5mrQ4Kgd/l+reGBCmLnQ4Pa2s0xnMDqtAnBaZB5ZZU/Mfg/OA92u2pCh/Kb/w3Cuzor3UdqBfyLVb7rg0rqdmSDzdPuPE5DImNeINY9sXaJgJIs0WHtzhKZ3P0aeJuk0700oGBpwKD0MMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uuxAJo3wxLjqtS4Zglu/Gp2VR4TuxdA907trz5v2KQ=;
 b=H9ytwEzZfN9OBFR2/kx2a1wP0fKc6KclMSSaiG+ojgB3W8Q7vY5Kcf2YTHdZhOeoO/Ly3fdBn1OiR8N0SeD+9J8y8LFAHRq+hjQRcMtVaYAJ0eDrzATVnK8B37O9VoVoud5db4nEMRooJRT0jpONYk07F7WhFWh5C2xaYovEa9flt7NjyobIEwIcUWp7MLpDaH5gZHG0m4l7agTsuayjo+TeKr2+lojhjulnY+tEMmnkJ3Fy4siWORNnm9wRHaKbREKNmF7SgReXBRd3gHuW3PSVGGodxdF5T25itlRcjhZIifcOryaDrRWsULDLjdf9V801CCwO2sJYeyXFE7CkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uuxAJo3wxLjqtS4Zglu/Gp2VR4TuxdA907trz5v2KQ=;
 b=gCHww4FPkB5wOmZwFaM0XFaDTCSmHy+8LBk4UZu6zGKhfA6LNv/FD2SvKQ8NjGgI3GkNp4SvC0s8/ylBaTtHqJPwZvm+qsQHn2SWQAbklNXPRsoJRn8E1QrvBmNUu+fcLomNcD/AFvNRaQtQUcYjyBgLcYvsI+aPxuqsoeV3fxI=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS7PR01MB14431.jpnprd01.prod.outlook.com (2603:1096:604:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 17:05:15 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 17:05:15 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Ulrich Hecht <uli@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] gpio: rcar: Use raw_spinlock to protect
 register access
Thread-Topic: [PATCH 5.10.y-cip] gpio: rcar: Use raw_spinlock to protect
 register access
Thread-Index: AQHcEog+XECMTOQRMUyaHcsKXiGeW7RtVb6w
Date: Thu, 21 Aug 2025 17:05:15 +0000
Message-ID: 
 <OSZPR01MB70191CC24A9467931A33E42CAA32A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250820141305.4841-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aKb38+2Q49y8kzBl@duo.ucw.cz>
In-Reply-To: <aKb38+2Q49y8kzBl@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS7PR01MB14431:EE_
x-ms-office365-filtering-correlation-id: 3e714692-6bad-45e3-f7d9-08dde0d4e607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?HAuIcXooJ78H0+yhduQaD8vS/smTvwLhWrx+VCZll0wdc817CPOE6SKKG6?=
 =?iso-8859-1?Q?8fSDqSZPUtfky+lvmZ8xqMozr5nfY9rU2/skrNJv9kCLlyzZMy+Jf6oaMD?=
 =?iso-8859-1?Q?0WxxhhSgfDFyuU+uwrUTd4NkvL7U9lBZnHdrmSxuJMMqv9Fu2i7gvozf82?=
 =?iso-8859-1?Q?C20MrmS/ZC3NRV/I7g4EiizseGdYSlOBsQqTERi9/2gkhV3l9ue6fmqomd?=
 =?iso-8859-1?Q?FgwIn7kj565wT6iR5lT2/RZtlikHMiIIfRpGM95SfA2O2hGbgUrI1Tbdu7?=
 =?iso-8859-1?Q?P/gpvBFhBFjsxufJt2T+4VVdDbGGvu9067OkdG4jlwQYG+mlGSBuY4wE4a?=
 =?iso-8859-1?Q?6iN969bhKIkjx1CJijD9vaKJC0R4es6/ihAbdr6LBzapwTXdYdV0PsyEGb?=
 =?iso-8859-1?Q?Pnw5chtvXRf384SfPOvhnnw7J4a5NhXtyfk7xrIY5fE0NaROkyY7z549DV?=
 =?iso-8859-1?Q?XFc2LkUKKm7/u4DnlRx/0DH/RjTf52aY8+mbNN8kSDRe7s//M08Dpb27Qj?=
 =?iso-8859-1?Q?slXebo6NriCyeNznL2VIym0Hvzpv4gGlyAVQXZ7tPhHcgHSZytVzPY0PV+?=
 =?iso-8859-1?Q?yXuhyICP9iO/1uZ7w+XUbZB0//xOIEuXRCIaP05EjkK9EXN/OF03Qk4ykk?=
 =?iso-8859-1?Q?uLH0txiDnRKI1bAuAMmJLFUHp4axAYfFBwYL9aEmqU5pYv6kCfGHU187CT?=
 =?iso-8859-1?Q?3DBpIoZ+Hs+3DhCtcf95DRxNdJqNbUF/hp/l1OTbnx/uwlJcmton5ToDp3?=
 =?iso-8859-1?Q?zNAfze047sCJO9BnberfQrnco/mpSQULhfOwchoB2noVnmx/pGDf/VGoDt?=
 =?iso-8859-1?Q?3Nd8ecy6xHXU4ebF9W3xzcNHYQvdzhsX3SI9WGq2ngYAqRpq1HxW9rHW8J?=
 =?iso-8859-1?Q?H+1+7V9iiHwJLYjgz42Fky4KI4srPJll7Xw6UVfHhdpy1mYnAkLVp1rkT6?=
 =?iso-8859-1?Q?fqsFYh4Jj/Ctk0xzP+8H4oRtag5PEiSsD2DSe9xO1CgUUeRNJaooRTJCnQ?=
 =?iso-8859-1?Q?0sPFDPEiZh/yZrFX4ZYfZlo1LPnUXOWIuxrfUR7LE1lOakS1EJANweSecI?=
 =?iso-8859-1?Q?g+0pgUPB4SCPGNF2vGS5mNCjFk8vmrULZmsX/HHypAejP0PpoyYQhbnsWY?=
 =?iso-8859-1?Q?itQcQFlQuvOnlD0qvJmo4a6qEz4oLNgx28bWaRnJ+kT5W1kmKwBWpWadwk?=
 =?iso-8859-1?Q?HfRVQgw8Se4VUHcL3QyqcUAULMhUXgs8OJDnF9rYmgJFeCMu9UfRwjzcta?=
 =?iso-8859-1?Q?mbysvV9pO8X00XbnWNlMOHxkWqjfTrOTQmCErnxB1ySdpf77LlspwaWhRT?=
 =?iso-8859-1?Q?1Ku+bW4TyMrEA4RMhoF/eeik8po389vKdZY2VjaXsVZxk0H4TXI1XOLp4e?=
 =?iso-8859-1?Q?HlcZzQE1+dtM68+sstz7+Cs76BOIrBtJ3+5s5QSeWCv1ppffZ7YT2DH14Y?=
 =?iso-8859-1?Q?SSICcx3nw8GymmCI+OvjksTnnKn4lpMJbmOeWU6PBHSDS9TjqkeB/MLK2q?=
 =?iso-8859-1?Q?PI9B21ZpUTgxbOXikkoJmQ6qpGRL8hNcr0olxvq1FdQuFKFtGhg/J0q5Uc?=
 =?iso-8859-1?Q?UIG9MWo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?58MY7Ih2OR6NyM+PEkToXyXdFqS5GCC3QSPL9bkBA//r6H/ZG2djRfmm7L?=
 =?iso-8859-1?Q?9nzna3Q/y3ktz9GzFyUlJKRnFMnb5ttop77rHa9Bm5pDdREhLserFen0t/?=
 =?iso-8859-1?Q?gRMzdt0TyCgNJTO8k19QLr+/Qsg/dp1U144Uku0Hrzu5Q1UZC5XZ7xb/my?=
 =?iso-8859-1?Q?STxCqVRJ3XxoktnncnmR/IFvvKly5EsmXytrI7FaDGRXK18fEIsEVLV16O?=
 =?iso-8859-1?Q?g77Htw+bCMBEBkMlSUiBmWTQjAW0jxTnBe+QmY1XXXGsZYiHKcQyNmDR5j?=
 =?iso-8859-1?Q?ZNz2ZnAtEvM92kG1sjHBb6RBZNzudPr8MydpCyLCTzx2xrZYg5Kb4XntkF?=
 =?iso-8859-1?Q?+ecK8IwJGZ+TfZs5vNSUtk+jGPDRwXX0BolweYGeuvJMpjAx12lJ1MCsCd?=
 =?iso-8859-1?Q?fPeeDWhai4VY9KZEDbcRajsBK7TvXMQlwBJHPyMRRwur0WX/YCU7s8IxEF?=
 =?iso-8859-1?Q?D17ZH7Eyf0gD3mh9sBldwc5XyRlDVJdmkjjx79xLwslE9+6MRkQa77d8Ak?=
 =?iso-8859-1?Q?ZXxg4w2du0z0/AjxcoWtRaWqVj6fVk1gE+dYehGlJdX0G06OLB/C0YO5LJ?=
 =?iso-8859-1?Q?lN8jS1T8yCJwuxF42S401CyI+vnAMYicm2+UiU+vdV3RBX5lR+/alBl5P5?=
 =?iso-8859-1?Q?mgBslzw8jYc894w3sgEuo5OGGas2ZuRLHqP94hAeByD7NrvbGTVvzYr4sg?=
 =?iso-8859-1?Q?b85Hn3eY1sSMQyIn8LMn6Uu1nKeZboaSGAmX0m6KB0yCUCI7NKe0HxM0JF?=
 =?iso-8859-1?Q?bzK5tdjL3jcVVB88panVseCFoKZUYG2D6Q6mK6VeH4t2qI4jkWd44Iq1fu?=
 =?iso-8859-1?Q?QWQ1qGV5/7EgyN5GkLsYE8tiwTk97ISvN+2Wg23ubpPaCYdPIm/peq1XBw?=
 =?iso-8859-1?Q?vlKsOarHrv/8n4h33YBgQK2FNy9it1xlFDADhpVquL0Cy0vrsJvf7wNGtd?=
 =?iso-8859-1?Q?CP/IQzjUlmpCsRb7zZsZXo2+AqsxTq+u9+C8g9doJ1MMsI9lRZVBtGgiIb?=
 =?iso-8859-1?Q?2HKxsHmv4ZLjjg1mihZS1b+69EVXw+PTXPhKGJbrTHHlSPQZyomldOhOGi?=
 =?iso-8859-1?Q?kmvysftiRJjHHgs+9RvDd3XMznc4TxjuAsTT0RZMVECYoF+hJyDy6b4RUA?=
 =?iso-8859-1?Q?IuGByY+9nxQm5MKrxea1qJHJ21zDII4G8ygnxrOAWpCDo3C941tdycQQ1l?=
 =?iso-8859-1?Q?0G4r7izQZoSgcG+kWwjPrMDzdjCb+4FEylO1w9td5/HqPZ61/4jUW4Che/?=
 =?iso-8859-1?Q?CD87z84tPuxN0Gi0MXZwTb97SCKDnz120QFnr4uqys3lc8LtYgDSJUOkjC?=
 =?iso-8859-1?Q?vlOVZflb/DS6y+k/8gYJzVAF+YSO63JkCTdVIYDYYbvoDEsvJ54NZeWK/E?=
 =?iso-8859-1?Q?/iwQe34tgbblAfVJqIDnBGZbH5l7mU39ir3BEriEsdQ9gdOTTUXYqc0HDI?=
 =?iso-8859-1?Q?uOIXlynMCEb3BDcgYXPhysSiZoG3BjOgEShxOsr6Hy7tgTn4T/c2Zo2mE3?=
 =?iso-8859-1?Q?sLnojpCBiJPbkbz4P684e6FOQHr6w7NAPmDpQ+C8YxWo5L+VGZUFtcP6Kg?=
 =?iso-8859-1?Q?/Ame2tZVzdKiBnwlQu4ru4b4qExRsWict5CvqpcrGNsec6gt6SLdgBiZ+o?=
 =?iso-8859-1?Q?TbpNWH5TjcqP1GEoPjHp21rI92cRSEnaJtSyzBOw1/UPwDB/umxFh2LBou?=
 =?iso-8859-1?Q?OtvMqE3qzKDtbTBRQVM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e714692-6bad-45e3-f7d9-08dde0d4e607
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 17:05:15.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7b8Jdn67De2xlUnmMBZI8dZL8d4xTFw1bhXUUA7afAIaYuQV0IcrbxbTA4BGqhgoMUge9k6e6Td8HCegahoZWOOWxmhbuf1NNisJ2pTHQRHC2EjR1L7eapAvrSNNOID9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 17:05:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19938

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@denx.de>
> Sent: 21 August 2025 11:42
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Ulrich Hecht <uli@kernel.org>; Biju
> Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip] gpio: rcar: Use raw_spinlock to protect
> register access
>=20
> Hi!
>=20
> > From: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
> >
> > commit f02c41f87cfe61440c18bf77d1ef0a884b9ee2b5 upstream.
> >
> > Use raw_spinlock in order to fix spurious messages about invalid
> > context when spinlock debugging is enabled. The lock is only used to
> > serialize register access.
>=20
> So... this patch is present in 6.1-stable, and the patch looks okay for
> 5.10.
>=20
> But as far as I can tell, this also applies to 5.10-stable, and that is
> still maintained by stable team. I believe this should be submitted there=
.
>=20
Agreed, I've a now submitted this patch to stable [0].

> Then we'll backport it to 4.19 and 4.4, provided it applies there, but I
> assume it does? (If not, you should re-send those versions after 5.10-
> stable accepts the patch).
>=20
For 4.4 and 4.19 the patch doesn't apply cleanly. I will resend the 4.4 and=
 4.19
Versions once the patch [0] hits stable.

> Reviewed-by: Pavel Machek <pavel@denx.de> # for 5.10-stable
>=20

[0] https://lore.kernel.org/all/20250821165920.1145912-1-prabhakar.mahadev-=
lad.rj@bp.renesas.com/

Cheers,
Prabhakar

