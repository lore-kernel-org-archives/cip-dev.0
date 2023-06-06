Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7966EC77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 11:07:00 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.127])
 by mx.groups.io with SMTP id smtpd.web11.6165.1686049617088053027
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 04:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=R3To7Stt;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.127, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCOJ1+pkMZ3iWXEIU5z2uxkbB3+a8dyPFu1aTbvxg6QbWdaVgDdgTEdODl5gCOlGl0WQN4XemSws2kFkk/C0JYFxMQwcoeNN+UFLsg32gAoD29gDkCyRoDljtmcK+nuSsTD5RDPcU1Cb20Rh4Ov66IuyG2xYiJbHz3IZGuhup+kI7DWzf92OpEK1TLCXqOGjDPDhU9WJj7+ayhFsZe+8rHXJ2t26wZ4Q5Q2G25k5Z6vUtJzV/16anKcx7EVv5Ul/ZExmzxBI5G7AmeNpPkUBg7cRmm8c8SvqHM45UadPaxGUAVhAWvok8zJwLCLYaS1+YppRxAmpBpB0QUUJYvEsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4m/OcFEEsYzWQdbx2Nibx+sVd9C7XDa1lQoMt+KDJY=;
 b=JM3g4sh4EumbmUQ20+gi/PU3pRSZ0C4UXYdIyjqA8/zwoxcVfJhyoaLzNoI9TmiqifTESBXMJcfCBgmRRMUWWcPEQ4lzSkydYDVDcXffL8LLpBLVIdcpjfG/yjaleFtnoCmKEL5ei1pJIugdoHfB7GRjqAxCb1spPlbbt+sGM4cIQNNvWWIPkyVYOlixk+UPW5bTFzCfY2g3EQINAjq/aADv/LKzbhoY+5GqU+9V6TwZR4BVMr/hfCCmgfp2iLLBBiRqTF3mebufeDO3To0VXuslJfQ3M68jK5JSRaGw1kfpbWbj0LtPImFsNydkHGKB56PJKsyXpwBWkYUNmsON3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4m/OcFEEsYzWQdbx2Nibx+sVd9C7XDa1lQoMt+KDJY=;
 b=R3To7Sttf6g4ubvFDfVHmyHRfA1wvBz72TWzuXc74RCuRQILqvIMFQD7qERUVYHThEX5PuELGP1KvFN+zZUq4SX3qcifUXNkrhCSrIOnhPvq34XqX8vq2jCHBoxYH72hyxBbqL/jf2BBAYzW52b18/9rQLHEJwLFea9v2iJa/4c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB10423.jpnprd01.prod.outlook.com (2603:1096:604:1ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:06:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:06:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Chris
 Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] v6.1-cip: state of forward porting
Thread-Topic: [cip-dev] v6.1-cip: state of forward porting
Thread-Index: AQHZl++bJ6zLyclMYUeS62j6oSuDmK99WhJAgABBp4CAAAIzEA==
Date: Tue, 6 Jun 2023 11:06:52 +0000
Message-ID: 
 <OS0PR01MB5922A997E9DDA882D3A217AD8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
 <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
 <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZH8RSUqIcbd35Dmx@duo.ucw.cz>
In-Reply-To: <ZH8RSUqIcbd35Dmx@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB10423:EE_
x-ms-office365-filtering-correlation-id: c3c3d446-3a7f-4035-f0a9-08db667e221e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wIETblVspRNJdlxnN03Ja8+sfa0bcJeb0Bn2UlFUKKn+UyHNG0SW+GyFiRkcDx3jNhdNTAo301O/e9NFTwCr6dn7KIApG7MyO4vntWyRFOUGad32S6NlzUF3zgBlkahcQh3rLSR3ee6PIZMj48BAyYcZ+eTlPDSL+iUFseaqGJbLXzMeATu9uRBWpSa4CMfZav5eDLQD+JAFCi+pENNBWbwdEc0dDdL+lbABjESU0UYHqTQ8MZPui6ecbuOexjyQ4IB2WC1ZdZJexqGAW+Ot196L8PaCgl1lSWsXHE59UvfMFAGdhsEvRyJTjbDmZbRntXRQVjQvXyuoKNKDeX6lbBhAKXmIAeJXH9ZkB907m1bSFobOId1GLomYePFkuYHioKRwljydsutsawXy7X+yzband5wvtfCulUM/aBJtHmOiPOxEvjHwpHpSE/ec3FT1XV0Yulkq300m1Av6CvOkdrzwtAlZ81YFeS5409Vt7a3c0C9RRi96VZmIZA8KMhM9zxvbbSnmf7rYEbvRRo+s31u2I5OCwrkFDjTEPvfkkCfqQmJCzVKKyQLc0CbeQ6UZIPP2kVjBgofC+hz4xZge3nXyq2yhcT+yTk+fsY4qHqaASDUICbxZke1SyVUMIzZN
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(55016003)(186003)(54906003)(478600001)(6916009)(8676002)(8936002)(4326008)(41300700001)(66946007)(76116006)(66446008)(38100700002)(64756008)(316002)(66556008)(66476007)(122000001)(7696005)(83380400001)(71200400001)(26005)(6506007)(107886003)(53546011)(9686003)(86362001)(52536014)(5660300002)(38070700005)(2906002)(4744005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WBvyNyTy4P8/g4cCJBVtuAhqxyBnDB3N6Rmlf9SXrXuwL3exNr4j3goiwrgz?=
 =?us-ascii?Q?EityFwmsBuyAXuP/vsbK0zsstERG08mfa4GpkQ2dF12HtEh7DKO+Zlru10JQ?=
 =?us-ascii?Q?k42svBNFMGlem99bVh7u+9zS2lVqnvp5s2bdt0o92zUU9olWUl5Yhm+Pgjbt?=
 =?us-ascii?Q?Gt2CQCIbWAevVoSl+D/+o1NcPBqh80m4LyGHXok7B8WB3t/AHVIst4kZFRfn?=
 =?us-ascii?Q?XQ5Ms4GM2LKi2Xlb41AYbDxCOX9a2NhdZB7BlezBSWV9VgW+y6L7XXsigFf4?=
 =?us-ascii?Q?/eBgJuhYhXbX2qxP0J9usDVDWwp3Gb1977+KwhJRXEX6bHLEZkraqjLDxuX1?=
 =?us-ascii?Q?mc1qsE2nfN1Tky55H6dd3YC/uKrEBWCC+Y9QS8dOaANP2BWORJaYZvdaiLma?=
 =?us-ascii?Q?CIWpot9DJrkEK1yBnNhu+KO8FngMs0olMMUygkBQQiG1UOYWEsfcyEtpLLlk?=
 =?us-ascii?Q?3P7+bmY0tQsN47yGFDAUUAm5bol37BQYxjn/aPvSfqA60JE+9GKRyWsuCCZu?=
 =?us-ascii?Q?S/fehrVUP83ezmAzwQgeBnsiRPnrCQp95bi+fXzXkXlI5LyoVBY80XdmOlIC?=
 =?us-ascii?Q?gk6RlJ6SqOVVdBUDDMkiCtrRZUtG0ah5r1hS/CJp8lfl04AeOlym2pi+Rrfe?=
 =?us-ascii?Q?D+APbNPnFuXKmn2gVv9On+Zauv2FR9+ooks2NMh8+cF1AhZi+1Kh0FH8MJsI?=
 =?us-ascii?Q?bNZQ8hCbCjTdWEe49CkpXyN6ocqS20f3vOFNInNJKS3z7CAyp1wucB/3UWD7?=
 =?us-ascii?Q?ziOF7VfV8Lw1VkhmaEjIZtY+0r/CfKRRNA3neP4nhvkQ8yUjA3khFsPb3P6u?=
 =?us-ascii?Q?Kf9GVeUJ85iwKZBrr1qB1vMTqqbQRq9R/JNUT5zZk844wU6PL2Lof1L6NWol?=
 =?us-ascii?Q?2DTZx4z2YqnjfuF8Eyf9O5wPjIJaNCKzW42rhQecwzkwLCLE4ImLNrrvV5K7?=
 =?us-ascii?Q?zGKNdnVG18hN4cZiid0adDLwmmjmxbJ6hH18+5v9hFjH/h/NdRNLpCLGuUd3?=
 =?us-ascii?Q?6AU6xHfxADJGDjGQbldenyEnzylkz1AHzdh5mqWuuGlWXiWi+H5ogM4C9Dc+?=
 =?us-ascii?Q?Th/7U6mhPaAJN34P3js414m5beUWUQ/9Dpi4dtwcY96OHbuCU1WjvFB3AVsp?=
 =?us-ascii?Q?q0LRPL70ZDpK2kU8nQQ1zWdxe+GsajKYUQIoMgGUqTml0sWGmaHPCpYCcMs4?=
 =?us-ascii?Q?dry/i2b9ASLTeYwOnjar6yRi8O3rVxcf9oWta4DIfDPiJA3qCB9Zv1iQvI4S?=
 =?us-ascii?Q?4NglWT8mf2bUczeeUPwp3h1yz9hjuLRJpHmn6GZLlWkurUVC7qhwHmseuVC5?=
 =?us-ascii?Q?xx5MmKwXaRFLEMe3SKCIVvj2jkw0Rv3fjJeUw3Mn6sGUC1wWD8dD9XKRNQuL?=
 =?us-ascii?Q?LS/VXlHre+qq/RPDZRXyMWua7AOQZJTLmnc7wzZ7S50duy5UMUrBY+XSOwLC?=
 =?us-ascii?Q?lQntF2bTjn8bZorW/wInhTOjHKR7BoJZwYqAc4eLFrFBnwzJ434v/8NMJBPM?=
 =?us-ascii?Q?16AcRK08PwESd52AQj9DPzX7JNVTHF2MCx80S8tCS1Bayvmjketl9QUUwOXB?=
 =?us-ascii?Q?X3HvKw976vVFCS9oYjs1DY3cB8dtTDPJi6QN3tbvjPEYP9+ufiwtSYFCW0nV?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c3d446-3a7f-4035-f0a9-08db667e221e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:06:52.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +AxyrGgQIa5cOWiBXgEwD2II1znSBrDIsziTygFxEV26GrG8sGHOjD1IFogMHC5pd49WSfnlqcmtFwOHORYAGnmelDyw36AkPFnIwegf+0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10423
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 11:07:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11871

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, June 6, 2023 11:58 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; Chris
> Paterson <Chris.Paterson2@renesas.com>
> Subject: Re: [cip-dev] v6.1-cip: state of forward porting
>=20
> Hi!
>=20
> > Thanks for the 6.1 porting.
>=20
> I forward ported serial/sh-sci patches, up to "tty: serial: sh-sci:
> Add RZ/G2L SCIFA DMA rx support". The last one can not be picked from
> the mainline, I guess I could pick it from 5.10.

I am ok with it picking from 5.10.

Cheers,
Biju

