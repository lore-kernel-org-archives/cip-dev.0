Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90616C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 20:47:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.7.1639687620520125960
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 12:47:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1BGKkona025078;
 Fri, 17 Dec 2021 05:46:50 +0900
X-Iguazu-Qid: 2wHHIL40Q0TkzCVms4
X-Iguazu-QSIG: v=2; s=0; t=1639687609; q=2wHHIL40Q0TkzCVms4;
 m=/9Ad/2LAW3IJW/O8l/pFBG9sf14YANQ7PMD5AMDDlrM=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 1BGKklkI026333
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 17 Dec 2021 05:46:48 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id D087C100459;
	Fri, 17 Dec 2021 05:46:47 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1BGKklJB029192;
	Fri, 17 Dec 2021 05:46:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaWZMPZmSdKDFCy6GSW4EIGpJucdbpoADBanHM/1Ea5bFSET+Yv7Mh4jx8SS8qvc5sxkgTPzv6QD1p5PULzaSz2y8qxhzwXgVDt6z00IG7x6c0zcDV7H8GXhVpW3m2Za4TqgyIPnkX/Biku9yvMF+WdidYpaWBmge1xBBnEzTmLhvNOpgivuOKKhM2lugVOOuAfGNqr4q2wzDfeqh0D3nfW7fx56aYgDFTW7EvFM25hTBJDNkLLSWQUyVxswrohd9kgp9bN6Hq7H0CbMKWTyKxcAk/7ulMohQenhs8W35037nS+qaSEnEy8r03MRNgezKUJemEgxavJXA9QMEoDbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoaqFCKYx5IkgNJo50ovQTZbIu7CtLlNjBLKJtXxAZU=;
 b=ZiEXFruYWJ6wfSgkSzP1yX2S0qwMazpkAWVIySSoUJGlxteZHPZbjfJ3GXF2VLVStNfk+paYrV9yY6A/sIiBmOK74qx5WD/1uJ+hY8ZCV6tWEBs1Vg2tL7Cga0JM9LmgPxD2jmYPbC7DcRhgpyLvfOZewL8IALzVb9NHyJSt7nBCgBHWoCefRBetEf6LFrykjqzFfiWFu4LaO2X0w9FiZYOHfSBxycRhatnWECzfY1NMjhcvC4SPoyzrnjidSHuURrPiRPQkm/zeE97L5zBo5fDRK7PWTmpLHsW0C+L3ip0unsVCLxxq6x+kUCX30G3QIXCnBH9Pw3Q1va/sgmqtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>, <cip-dev@lists.cip-project.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC
 identification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK
Thread-Index: AQHX8U08XT1uNy8MwUSTHJk1/2W6AawzVAKAgAAILACAAOotR4AAnHSAgAC2Pt8=
Date: Thu, 16 Dec 2021 20:46:44 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252332467837CD4ED9101BA92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211215100537.GA18047@amd>
 <OSZPR01MB6877AA575BACD21ED96F9B53B7769@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <TYAPR01MB625203ABE988E764E38A8C5592779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <OSZPR01MB68774C867A33E8AB5B82EBC9B7779@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB68774C867A33E8AB5B82EBC9B7779@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4e8d8ce0-b832-c545-c631-d67cdd5cc262
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a879f31-40d8-4a2a-33ca-08d9c0d52b91
x-ms-traffictypediagnostic: TY2PR01MB3595:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB35952AE3C9D1C8180C3E785D92779@TY2PR01MB3595.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fJAktTnsWlWthQRApntTAYvrd9Kcq322b6T4axTN5IqnlNTp1NDaMrv0T7B0Kszqkns3zOHFzo5WSkbO6hmw8S4hVRm0kNkiF1x3nFhiWanlrQafmQo+8Omv1nUaDG/ylYNJNUvaYGv3+3fm+doCExSUnkf9+qSBA0QM6U5uIZ3i1azmtiOrVbl8wE6PWZQZ/j4PHpNljoYj4yLdVYspUPebkJwPZj+wnVhbds8eL06qRYlPiD4HSMdZygeVgvzvIqW8hmhtFSZR7o8mykSc2YQrQqpoMDI92XJhs3TdJUgmP9UYiSNEsOr0iugEMSTh2hHeAXMYyWj/U4h55N8ROFTg43wetcVTeZXX3GmujaTNjwMZMM2AJ57M9cY4n/dlbXhsoiVTkhUdfygS77CSRc9Y2yZkS47VakWBdemtAVG5UMh4F/0nBECL1fjMOKnEig+RxIrBwvXw5g/ZLMhj6N3IvuGdTDUSMWUMekf3+oqYB47BEb0TsYQbnYxcsU+KY1kEfxPkBPmJni6CVhf8ziPn2lHQLubyyhQfG6Lhlkh6ZQrE/mbEDTJzyrnHciDzurnrMQVGblEJwM2MxmGOejBCd0A++vB/pDfH9uH3Ye4ryhHqdxQ4+z8WbiBqxsN0HJFenxQ9qGwwmkz5mW20/x8zUmrbk5SrxoNMlLMU+P+L2Ckf5KxHB9vs6QBxOSYXNnKX2ThZToj+hjurmNLsYw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(55016003)(38070700005)(66446008)(9686003)(508600001)(4326008)(55236004)(33656002)(86362001)(52536014)(8676002)(71200400001)(186003)(64756008)(76116006)(26005)(66556008)(66946007)(66476007)(54906003)(5660300002)(110136005)(316002)(8936002)(6506007)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UURQUUVKTHQxSE8yTExPUTFGa0pJNHRoY2pkNVBNNS9rOCtZWjVBWjBI?=
 =?iso-2022-jp?B?V3BXTXVVa0ZVYm9hVnRMQ1hZM3hjeXBTWmYyMS9CK1FIK05tNTczV0hN?=
 =?iso-2022-jp?B?aTFyWDZTSW12TXJUcWZoQTJYbzJDZ2E2bWNRMURURWk5QnJRemM4QnpD?=
 =?iso-2022-jp?B?V3hTdFF0aVNsNFN5QkVkU2Z3STIvZ1FSWWlEeUpqVmFUMjJwVFhzT0tq?=
 =?iso-2022-jp?B?UnFpTVFETDlKTFByNFE1djVDWUVvQVdzVkdrdy9DMVo5Q2ZrYzF4KzFi?=
 =?iso-2022-jp?B?WjV4Uyt6a1p1SEZzY0VUWFgwNzFLdVJIRloweEpGMDBnSG5BMWNvc0w4?=
 =?iso-2022-jp?B?M2FsTG9CUU8vSmV6NFRMMmZOSjlLY0ptdGJNbU0zVGNpM25Ra0FHZ3N3?=
 =?iso-2022-jp?B?THg4QUlaZCt0c3BnT3YycFBxK1JSRVYyMk4yMzFFVDBQMHhaU1N4eVh3?=
 =?iso-2022-jp?B?VXJJTmRpK05lU2JEcWNoeVlhN0JTbDBNb3l2Qk5ENzZadWl1RWRMWTFw?=
 =?iso-2022-jp?B?WVNCaGk5eFArTFRWbjJxQ0Fwc0k1aWtPYVRHdlkra3paZGdZNG11a1ox?=
 =?iso-2022-jp?B?NXNGdXZRMFZKRG1Xc3d4M1kzcUl6YTBSeEgxYUNDQmFTYkRVdVNqK3J0?=
 =?iso-2022-jp?B?NEZHY1BSZUJoak44VVYwQ0U3MGNFVmJXa1lkVEdQTlhWa0hsWVpjOTJh?=
 =?iso-2022-jp?B?eDBIbjgxUnBwVExGeVFJUDhEUDFVVzczc011TmdhekVGenNPbXNMV0JE?=
 =?iso-2022-jp?B?OG14V1hibnI5S0lwSGdvWHRKRlRwQXVia2NUcDQrL0JLNVByeU1HNmxP?=
 =?iso-2022-jp?B?V0ltZDFldVA2ei9OL2Z2dE1rZHdrQURaM2p2MmtsYWVSdm55UW9xdVlu?=
 =?iso-2022-jp?B?VUp2cW9NQmlabVRTOXF4OEdYeXpxQjMrVjArVmhGcnFEczJ1bS9NQ1c4?=
 =?iso-2022-jp?B?bzhleGEyQXA2dXZNRThlMlZMOTRCM0d1WWhxSVZ0M3M2YTBrTGVpL0RD?=
 =?iso-2022-jp?B?NW5Oamsvc3E2L3BUQkVCc3l4Z1IxREdFSzBhVUdIV0U1SURhSEwvMGh6?=
 =?iso-2022-jp?B?dzg0MnE1S09FZ29hNlI5eEg3bFRTelVocCtPK2RWUjJMa0tjOUpPdUlB?=
 =?iso-2022-jp?B?WTdvZDFlN3BsUWpDZ0Q5QWxrWVJ1SW9ha1Q1NERRc0ZJZTdyVndPQWp0?=
 =?iso-2022-jp?B?T09samJ4dkRIcy8rNjVQd0xVeFBTTllsY1hRb3JRTnhaeXpvbVJkaTJl?=
 =?iso-2022-jp?B?cDdtaUJtc1Q1a2ZiLy9XanRzOENEYWlCTzhyMXh3Smx4SW1HUXE5UStI?=
 =?iso-2022-jp?B?Z2d3citEbTRmeFJweUpsUjQ4TGZuSVFtVFV5cXF6T21yZDkvWWptZmZ3?=
 =?iso-2022-jp?B?Rm5aZDdjRHQ4ajhxM0dNSytJRndiVitnQXJ0d3dya1J6aTFVQ2F6dFlI?=
 =?iso-2022-jp?B?bkhyNFBQdUFkd05GYTJacElhNlowTHNwV0pValJmZzFWUTNOSXhJNTdt?=
 =?iso-2022-jp?B?WWJBK3pQdTEwUU14YTFpNW5oWmIzSGhtTXZEWWdGSWh6U0RRcER3T3J2?=
 =?iso-2022-jp?B?THRhTGsxS0VxSHhob3F2Zm1MazNMZ3VGUE4zUktvZzNEdEpVK0srNUhG?=
 =?iso-2022-jp?B?QUQwTDAweU9ET05FU05nOHNkVWlQQmV3bEg3MXRFVFR0OU0wQ0ZiVmNa?=
 =?iso-2022-jp?B?KytSWk4zV01taU9zOW5JV3hUdzVNM1pqZ2FOYzlrS25ZNGV5MHo5dDQw?=
 =?iso-2022-jp?B?THdEZ1NuYi9BcythS01qL0dhR0xQZnlYOEZwblhsL0F4N3VtVVkzeVdj?=
 =?iso-2022-jp?B?cStLUnhCajNQUkZOMHVGQ2UzRURmNjZiM2hFck9ZSDhzbGo3Qkd6L21i?=
 =?iso-2022-jp?B?eDE1MnNDZ01oWXl5KzRCS1V3MnoyWjdxalZTRUpGOHdRMGswaGJwbS83?=
 =?iso-2022-jp?B?RVU3S0xoU3AvN3R3M1Q2Rm50WHF0T3BtYk84STY0RHBQMnZ2NURzakhT?=
 =?iso-2022-jp?B?cmp5MExuQ2txUTc3THkvd3owTkZQV3dXWUFMbVJMR3d3M1NRckNLQmJs?=
 =?iso-2022-jp?B?UWdSR1BRRlk2VmNueEhpZ0pad0xQYUo5RVNPbEFKQjYyZjFacHRVT0VT?=
 =?iso-2022-jp?B?cTVIRXdIUDY4N1pVWkZtWmVESzZWTVN3TGFhaHdoelVFOEg5Qm5GNDA0?=
 =?iso-2022-jp?B?MFJLdGhYc0JxKzlxTU9vL3Yxalc1L2hmMXdBdFR1NEZtZnUvd014SW9j?=
 =?iso-2022-jp?B?eXV2ZHF5bW9RcnpXdzkzUkYyczJZdFAxUUJkaGJtVXBlUlZUbDg3RkJr?=
 =?iso-2022-jp?B?WEVET1IyN3BvYW45QlNKWVR0OTdkVGhncnIrbjJPenpjbFNvVnlpVnJY?=
 =?iso-2022-jp?B?Vm9iZFpBQWdzRWg2WmJnM1ljZmRLYzNyRVkyR3ZPMVlMNy9RRmd4a2Zj?=
 =?iso-2022-jp?B?REE0U3FPdmEyN0tzUmhFQ2M0ZXMyWkJ5Rkw2bHJYYlFVTEd1cXRzSWFJ?=
 =?iso-2022-jp?B?aE5vRVZM?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6a879f31-40d8-4a2a-33ca-08d9c0d52b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 20:46:44.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 zoQVcbjbQAwiXFyGA7mNiTv+swJ1eFeYTdbdNFJPCIhju4UR4kFoaUipVE4dZ/mIx8es2GJDezhJMIBQ0T3z7+IB6OvZSF/7lgPd+JKhRHCSRK2O6hG4EDyanc4Y7ySS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3595
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 20:47:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7167

Hi Chris,=0A=
=0A=
> We are planning to propose it as a CIP reference board and we plan to add=
 some hardware to the CIP's LAVA infrastructure.=0A=
> If the board is not accepted as a CIP reference board, we would still lik=
e to add support for it in the CIP Kernel as we have done for other non-ref=
erence boards such as the iWave RZ/G1E, HiHope RZ/G2H boards etc.=0A=
=0A=
I see. Thanks for the explanation.=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: Chris Paterson <Chris.Paterson2@renesas.com>=0A=
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B16=1B$BF|=1B(B 18:52=0A=
=1B$B08@h=1B(B: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W=
#C"~#A#C#T=1B(B); cip-dev@lists.cip-project.org; Prabhakar Mahadev Lad=0A=
CC: pavel@denx.de; Biju Das=0A=
=1B$B7oL>=1B(B: RE: [cip-dev] [PATCH 5.10.y-cip 0/7] Add binding and SoC id=
entification for Renesas RZ/G2L SoC and Renesas RZ/G2L SMARC EVK=0A=
=0A=
Hello,=0A=
=0A=
> From: nobuhiro1.iwamatsu@toshiba.co.jp=0A=
> <nobuhiro1.iwamatsu@toshiba.co.jp>=0A=
> Sent: 16 December 2021 00:40=0A=
>=0A=
> Hi all,=0A=
>=0A=
> >> I have reviewed patches and they look okay to me. I'll proceed with=0A=
> >> testing.=0A=
> >>=0A=
> >> Do we have suitable board in the test lab / is there plan to add one?=
=0A=
> >=0A=
> > We don't have any boards in the CIP labs yet, but there is a plan to ad=
d=0A=
> some.=0A=
>=0A=
> I think I need to add the board to LAB first. Of course, source code revi=
ews=0A=
> and=0A=
> build tests are possible.=0A=
> And If my understand is correctoly, I think this is a new board that is n=
ot on=0A=
> the=0A=
> reference board list. I don't think this has been discussed at TSC.=0A=
> I think it needs to be on the agenda at TSC, whether it's a reference boa=
rd for=0A=
> the 5.10-cip kernel.=0A=
=0A=
We are planning to propose it as a CIP reference board and we plan to add s=
ome hardware to the CIP's LAVA infrastructure.=0A=
If the board is not accepted as a CIP reference board, we would still like =
to add support for it in the CIP Kernel as we have done for other non-refer=
ence boards such as the iWave RZ/G1E, HiHope RZ/G2H boards etc.=0A=
=0A=
Kind regards, Chris=0A=


