Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011B9C61D85
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 21:57:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.108265.1700776660209192355
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 13:57:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3ANLvTBd2700969; Fri, 24 Nov 2023 06:57:30 +0900
X-Iguazu-Qid: 2rWg9lIczyCxX7JPLE
X-Iguazu-QSIG: v=2; s=0; t=1700776649; q=2rWg9lIczyCxX7JPLE; m=vVSrCH2U4CUff2oaxIZc8/RoWq2FEYw+kU3gBcCwf9M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 3ANLvR60947366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Nov 2023 06:57:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+eR3xvBN1BDYxoXvshMytuFdZ8sAY4a8xPv6ttV3426KDWmgzSQ+f7iX4s5glSZ48dmYmippUFsJRGECEz1xaZvSt8X9YLy1cVmeAKI0sn5i6NQ2QqD0gNMzvg/J9plE3EaKYah/g/QvNQu/xwMt4mfmS3nrdRlSL2p34vKFykP9g5cgXHPb8lbBoczaTI6vkHOYPkr5KlI53VnG65bT2AZ5xBplK5rotS58TbLqeCTgpRv9ncIWgcjMNuKiJKb4dOePUhrGL25Utat3lTDB3/jNc1tcLMl2Y/8XUs7GEsI+G1Di91utd3n1VStlU8SXXL3AtVMld7M00w2HC7qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymOqulkYezUJjRDSKsOGujoBmzIVNNxO3+piuh3nRYg=;
 b=ZsbhwwvPWiVZjuyu9K135xtVSso89rWrrDuZLusYq+en7pUl0vw/5GcSV9AU1wH0U5HG5lxAYlqqKXcStVAn+2dRnmbArwkmuTlJgTdbsTXDEIS0ZbtTjJOIiPH2d0KyGjRDO0+yyZE/rkJeKdtU9jcr5z/PQRK6qgyFsogQAVJbefkn719dsQxjFnv+1rJ7gYOKrQlRGflRVzA0lCBXpoJkAkmFf4Ja9Jf4nR/4lBcFKJ2bCuc54ftBFu0ms6tKMQqileFowPz5pPjRbI/8QkhvXMPZGDaJsy4gaOcwpq75qVG45qs7XpvNcnOYb3bRXVR+bTBAV5V9/WGrcCpRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Topic: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
Thread-Index: 
 AQHaHVCr674e6wgZ4kuDDDp23YUTYrCG1g8AgACwpoCAAFPHAIAABxswgAACiQCAAJAJMA==
Date: Thu, 23 Nov 2023 21:57:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB1124513AF13C5D46BEDA3541292B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <20231122143156.204055-1-biju.das.jz@bp.renesas.com>
 <ZV5uUFDxiawBZf30@duo.ucw.cz>
 <TYCPR01MB11269C30D597F7C0F2EF3A00E86B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ZV9Ixu5W5AYWGzVb@duo.ucw.cz>
 <TYVPR01MB112459EC45FD378EF879F18B992B9A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <TYVPR01MB11279801899313A2F2AA7B28C86B9A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYVPR01MB11279801899313A2F2AA7B28C86B9A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYWPR01MB11894:EE_
x-ms-office365-filtering-correlation-id: f706472f-1792-4c13-4ad3-08dbec6f2d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qpAArcrg7tjicYzJx2ro/+52IR2XfdR/Qpk+zHKx1WUxUDa5vL6SzhIVuk/SjihA+UaNuGTfgsuO+DIQivVxriA5IO1pwuE0L8RWkbN8y/8uWtodJgH8QcdcfOtKT7x+0kmtHesMXrj570cvFBMLaD3XaeFaWq+ll2pNuBngD3hH5SEcion2ZGLWNFVsiE9THh2JuoPPGVN/VfaH2LSNYWPwF7BYc7pTUnQwQffF83OPzbVKXcJ4tf/Ls/GRA66aklJ5x+/Rgaoa02n2hYvPr7sTBy4SisIx2CMr9pYc3qDuEgmzfCS2wUCOPmjLNrUJQcGERWIvaofQCCUgIPt+pCbFUCVlriL4xme6kfOMfVupxSs40mskflmQE9l52f06ztwCiOipNkd0RyI2urOCWI43VICa53QKVPB3FLulCxtyBjecFSmGLFovDmTbPjxeLTjxIMkMqNKXYTX7p44usFysEEOLERtydRyiF82bP4n62sGUKNjrFpCBOGnDX2/WaE28pq2mBVrC39JsfKIuMesdnBkPHclHSDOPIHyiSGjDnFwANClP0aVlqIP2YDx8m+0IdV7hlNxaXiM+folWfLqgPqY0Fzz+o9TpVcUO+S1QZtoAZJeXOiAhZrJvcQQP2QxXzkiaf34/wo+jkmzpNA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(9686003)(55016003)(83380400001)(26005)(6506007)(7696005)(53546011)(478600001)(64756008)(54906003)(66446008)(66476007)(66556008)(76116006)(66946007)(110136005)(122000001)(38100700002)(52536014)(86362001)(33656002)(5660300002)(2906002)(41300700001)(8936002)(8676002)(4326008)(316002)(38070700009)(71200400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NnRxNFRZT0NHUjFyUzZ2MzNLMGJheVY5YnBDWXNWM0tXNit3QXBVQ3dT?=
 =?iso-2022-jp?B?ZldHNkxFZ1BZZ0F1V3E0VTdQV0F6d1luZVRaYkxxbjh5L09xMTFuUFQr?=
 =?iso-2022-jp?B?c0lBaGRtZzlIN1l2NmZEeno5dUxMWkZVQkVOVUo4UDF1bnB3R043UkxI?=
 =?iso-2022-jp?B?ZmlwZ2dhT01EazJYdU5YZk50c3l5aWtCU2hCbHBTbmhTR2FWQkNFR1dN?=
 =?iso-2022-jp?B?WFZUNDE1bDQ4dk0yTVVuQ1FQRXlOMjIxREgrS2NLL2RtcXY1aFdodER2?=
 =?iso-2022-jp?B?bk5UNDljR2RJaHlJTWxZTGtvS3IrT3NPTHF3a1liVGZ6dmtUeG9sNTlj?=
 =?iso-2022-jp?B?N1RBZGJXMit0M0FZSkdITFVYZWRWVjF2NmtYSVlaeDFiZXpDSWdWVlRD?=
 =?iso-2022-jp?B?SHdmWUdBYnRzS2J2VVRzb2J4VWIzbXlteXpjL0N3R2JZVHE4ZlRPcEhR?=
 =?iso-2022-jp?B?ZHEyMkhDSXVQZWJRVUJFM0xJZ2RJU3ZCTkIxaTc5MlZ1cXpLZHowaktH?=
 =?iso-2022-jp?B?MHhlVldMK2t2aUdaMFNIcCtPaWJUQSsyTU5yT1VGdWJaWnQ3Uzg2VjFQ?=
 =?iso-2022-jp?B?VjB2QlJ4OHZvSkE5aHRmbWNWK2dsUmdYZTVnMW9SQk5KbFg4N1hnUks3?=
 =?iso-2022-jp?B?MmdsUVhUdXJtbFFnZmxHaG9nWEh5ejVRakxaY2dtTy8xcU1GeDNDTmUx?=
 =?iso-2022-jp?B?WUlEWlVMS09NY0xpd1RqRENEMUxSWHRSRjJENU5JNDNER0tFNWg2L0tk?=
 =?iso-2022-jp?B?YWV1djA4R3FOMmIvT1lRZDFSNHJUVlBVdzhXRk5EcWhxbEZqK05FYzNl?=
 =?iso-2022-jp?B?Wnc5RnlKZnFucnFGSGRMRTZNcGFxZlNxZ05oZEtBcFZyQzZXcGlWM0Ns?=
 =?iso-2022-jp?B?azM4L09qQ2NQNDh4dTVnRUtnV1hUVjVPZ2dEU3Fya1lIR25rQ252TytW?=
 =?iso-2022-jp?B?RlRRcjZoRC9iNU5rb3BZSlM3ZUIwTHgyUHRwVjVPUnJ1eDNpYXpzYzR0?=
 =?iso-2022-jp?B?N0tDV1o1SGdOeWFONGZuOG9KNCtOR2lvK0ljSG1Xc1UzcTY4bUpWVDF5?=
 =?iso-2022-jp?B?eFJEZ3FjYXhoY041RW5tVktISUp4Q09XMm1XRGdrZk9GS1pYKzRxRkJr?=
 =?iso-2022-jp?B?akpLczJmazFWcTI3cS9lM08yWlBFZXhNK0ZKamIzUHpHejJSdHh2K2tN?=
 =?iso-2022-jp?B?M0hkcGpUOUhTcTZWOHcxT2E1M0MzMEgyMGd0empzeVdzWlBVSjdEMTht?=
 =?iso-2022-jp?B?U0VYbVd0Z0FTdDVJdVdDMXBUOXFaT2xKT2tCbXVkdGpnTDZJTnFJaE1k?=
 =?iso-2022-jp?B?S3d4RmZnM3RURGs4ZlNScmROSnBtVk9DZ0w0WEVjSm5mZStCM0VXZzhu?=
 =?iso-2022-jp?B?OEpjNnp0WmFpdmtYcVFxTk5JUlY5TzZ4cG9UTkFEdFNlb3ZWWWwrd2dk?=
 =?iso-2022-jp?B?bDZDdFY4WC9JQW4rQmpFSHFKaVJROWVaUXozZm03VGVPZ08wSWZiUlFt?=
 =?iso-2022-jp?B?ZVdUbXh1SW5PUHVneDBjTERBL0M3bW9NTURsSTZ4VmZIYk1icGtWY1lh?=
 =?iso-2022-jp?B?YUJHVjlwSll5WFY0M3Frd0NpTXBtQWtLWTZONGEzeUhYUkRybFJpOXNL?=
 =?iso-2022-jp?B?VVN5VHZDYnFveDVCQ2hxQzdMcnRKMXRmWHJWUmE4Wk1TWnpEVkxvV1pO?=
 =?iso-2022-jp?B?VnFWTnoxcWNHYkdYemhmZXpmVTJnNCtPaDZObmxpeEtDdHRxZ0N2c1pY?=
 =?iso-2022-jp?B?a2did0wzc2hYN0ZmZGpWMXlpSCszZVowWDVpdTcwV2dYdTVMdG1ZdUhX?=
 =?iso-2022-jp?B?d3hhL2wvWXJxTmJUcEdYQzhqNks1MndBVnkwVGNpNUxQNGZYTzBJU1BI?=
 =?iso-2022-jp?B?REhkVHZMUjRySjlMMTJyZWdmSmY1bWhKYjlXMVV4WUE3RkxmR2RvQ2Qv?=
 =?iso-2022-jp?B?Z1NHeDR1ZjdycDJiOEU3SHR4MVpMcXJQUTZ4Y2JQN3FaMFphN3J6bVdL?=
 =?iso-2022-jp?B?Sldpb0UyeE96US9VUW9qc1BVZkJmR0hDWXg5ZzZJcE1SNk9RYVZEcSsw?=
 =?iso-2022-jp?B?U1EwNDNZblRJb24rZ2pNOHphNC9sd1dQZ0NmMC9MdzNDd3VKT1RQU004?=
 =?iso-2022-jp?B?VGNCNFFvem16MGwxUitNTEdJM2xtSTRoUkJVdmZNdnlmMWttZnVObVhO?=
 =?iso-2022-jp?B?eTZ0VnQ1QWlEVmxHN3I3aEhiZDZGSnRpM2JSM1RWbERmWE1vRmtidHcy?=
 =?iso-2022-jp?B?RllsNDV5TUphK1ladlV5TmJTVHhLVzVLaWZ4MUl6ZGpIQVMwUWk1NGxG?=
 =?iso-2022-jp?B?SkFOUXB2dG0yU2ZydEtLVE5ZVnh3VkhuQWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f706472f-1792-4c13-4ad3-08dbec6f2d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 21:57:25.3390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmpUpnpG3IlIIkkHvpkwYIIMLWH1uSh4GZ+vdkEn4xsunGLoNbzmqAmNp7zGfy4zhwWxsbTFBMkF5WL8o2XFRcMj9UI0Bgfkr1Q3RJLakLRimynAyOWG7lQRIx9r8s5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11894
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 21:57:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13687

Hi

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Thursday, November 23, 2023 10:17 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
> Cc: cip-dev@lists.cip-project.org; Claudiu Beznea
> <claudiu.beznea.uj@bp.renesas.com>
> Subject: RE: [PATCH 6.1.y-cip 00/10] Add versa3 clk generator support
>  >
> >
> > I haven't confirmed the working tracing, but the compilation error
> > requires the following commit.
> > ef13f8b64728c clk: Store clk_core for clk_rate_request
>=20
> I have ported perf patch just to avoid conflict with the subsequent patch=
. I can
> drop perf patch and manually fix the conflict.
>=20
> Is it ok for everyone?
>=20
> Or you want me to port the commit "ef13f8b64728c clk: Store clk_core for
> clk_rate_request"?
>=20
> Please let me know.
>=20
Sorry for the confusion.
I reconsidered about it, backporting commit "ef13f8b64728c clk: Store clk_c=
ore for clk_rate_request" have a issue.
It has a large impact on the clock framework and does not work properly.

I think it would be a better to modify the perf patch without "ef13f8b64728=
c".

Best regards,
  Nobuhiro


