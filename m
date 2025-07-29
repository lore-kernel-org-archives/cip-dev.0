Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937EC87FC9
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 13:45:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.7207.1753796747819608287
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Jul 2025 06:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 56TDjiNk728209; Tue, 29 Jul 2025 22:45:45 +0900
X-Iguazu-Qid: 2rWhEqwpnRWrFv1KaG
X-Iguazu-QSIG: v=2; s=0; t=1753796744; q=2rWhEqwpnRWrFv1KaG; m=G+nNwcuZiZnN/20HaMNAhwOffKKSGPs3Jz30WHg1S5I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 56TDjhNa2235921
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 22:45:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1kPLz/i46hKLol8eakHVM2LnfDtsqlYJhZyeNJ1r9/2UJrjn2QqOmteUrB2o19erOlswxYpEtrkKj3bbnQ7D7uj8/uiBpEq8/XIRbX59v651id3ID7g6xHZvo+Eszna9VnKUOL8E050cupwHIK4qmqlRb2v8wWAoL9vOHP5oCdSTlgHNJPOCGkLgvMZ4b7oAhzrihIY4/7UGXB+XKD63MjLFnPiDZ1C+8ROU61UzwbxPGb/CNiUErt6OosnvIHszY5gRjFu5UjFHQPIUNhKvdB9ZvBWv1VHPvo/CEbD4OEm159mkQyyg3D2Y7lXkykVoPXIwgG8FR1ra3WKgVaDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCoqIfDiSO1dy0qUAqpatSUS6RtQ3wLDXn/1g2PcRm4=;
 b=rJxl0bDnGzRZsJj0SFhNwEX7IWmc9GC9dlep5wbJeMi2v8zlnAW7xA6+yV0dog1avlde/sHVag/Bi8zKTEIv4R0Rvj3PIskHY2VV/oUflqXNp4E3uyRPW6Nxv1X2QOQAXwtgg9cUzu+o16/Xn7dNntKnJiMAdADw8/19LHZOF1GHcDRWWFARVVAZChtTG5eYS4WhTPQbX0znNfq4bIR480c2lPxnJNstxAM8LY29HySL1Rp+Xw0aHRbl2YYXX8koMagg373ukxs8PzPZBv60zdaZXUJ5poBTIxSCDU38+x5xITFO//Q55tHSYSuqwhZD6nGvD0ms8kgeLWTAkvLt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <jan.kiszka@siemens.com>, <Adithya.Balakumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: File server for zchunk swupdate update
Thread-Topic: File server for zchunk swupdate update
Thread-Index: AduXPMDwGbkQ98swTHSVcGfABwDcxwFaGtzQGPn4QcA=
Date: Tue, 29 Jul 2025 13:45:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107501396B71E71A49B7A7C8C725A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB11075908DA987ADCDE33DD899C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <OS3PR01MB58966EB75B7DC1FEB3851792B7A42@OS3PR01MB5896.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB58966EB75B7DC1FEB3851792B7A42@OS3PR01MB5896.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY4PR01MB14526:EE_
x-ms-office365-filtering-correlation-id: a0593967-2948-472e-3197-08ddcea630e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZTNOZVJZcyt3SWxhRkVZc204TlRnNUZXc1lnMGVhaHU3ZnlHYW5sak1R?=
 =?iso-2022-jp?B?L0loakIwYU96aFRiNFFCSGdMRmZnWjZCa3MzMEpJUFp2a2ZpL0JkSzVp?=
 =?iso-2022-jp?B?RlVTMWtGbkgzb1dTVlBnSHpRZW5TRnNRdm04a2JYbXhVNFhIVnZ6aXEx?=
 =?iso-2022-jp?B?OEV0NHVWNDVsK2JTOHNhNUg3Mk1BcnhUMHJTaVdpTHlSM2t1YXM2YXVE?=
 =?iso-2022-jp?B?d1JQUEdRaHdwaG1ubHpyakk3MDhIdEJkRVRUcko0WExzR1pBbFRBTlNs?=
 =?iso-2022-jp?B?cHJCNDlvNDRYeDVqempQR0N3bWs2dStjQkdLTVVwYTMxM1BoNzZ0MVRH?=
 =?iso-2022-jp?B?b0FkSWNOeWprWVd1RXJDR3dxRkxkdTZ3aGU0dmFJVDhuSFRyY1VHeWJh?=
 =?iso-2022-jp?B?eE00MEhHV2RjMHdtMEZ6Z1RVbFRKMXJPMWJPOFJHMmhRdUdvL2Yva3Ji?=
 =?iso-2022-jp?B?b21MZ3Rka09GMkI5cDVqSEJqNTR3QW9JREhsWWc2TXV2ZFR4M2FWZi91?=
 =?iso-2022-jp?B?WUJOSzhyWTMzV3g0WGQ5cDFaU20yYitWc2lPWmk5UlZjbElqK25NMGtn?=
 =?iso-2022-jp?B?Q3JaQ1ZVY3BFMzdOUGRHam1sbFc3ZzZlOWgxLzdvWVJ0dXVYNTU1V3VM?=
 =?iso-2022-jp?B?TkwxZzlrMC8wdWRWUkZCbFh5NTJadzJEUk9XSlVEV1FLU1JaaGNIcFVh?=
 =?iso-2022-jp?B?UDZaQm4rT0dLYlVweEpGOE9IVnk1TWsxd1RjelQ2TzdEMVV6QzJJZDRL?=
 =?iso-2022-jp?B?dU5pSTg0blFYSmFKdGMwUDVtVHlneVZmM2dlTEp5akVEdUJkRTNDTjhU?=
 =?iso-2022-jp?B?QjBreHVsTXMyaTQwMkM0eGQzbVczSHFCSVVLVmJPeE9Ic0RIMFZpa1ZJ?=
 =?iso-2022-jp?B?NmtRWjdrUDk4eDhySnJ2SHIxRFNEYjVHNHE3QzZ6aXRwd3pKOGlVaGI1?=
 =?iso-2022-jp?B?TjIyK2ZJYlBLb3hVRGZKSGhPeXp2aS9LM3c2TE5YVXg0Z0hYd09pem5m?=
 =?iso-2022-jp?B?bE4xSFBrNmhUYWw2V3hadTJpWS9oYkJuME9ia3ovOHZpRjVKT3VXejF5?=
 =?iso-2022-jp?B?NUgvRnJTVFpJeGtLWEdkamY2WW1HZHYwbnJjN0k3RzdtYzVOYmVsbk95?=
 =?iso-2022-jp?B?M0RCTXRpb1RMbE5vSVVweEcwajNKNXpMeFFVOVFTVTNBMm1tZXFLWWpP?=
 =?iso-2022-jp?B?VGladzk5blN2Wkw3ZThYVWlPOUNhTlFFWlp2SVhnMUJFWmJySkR6YXU0?=
 =?iso-2022-jp?B?U0ErM0R5ZTNhS0djU0cwSVN2dmlkNnc4Z0dkZEUxSE1nMUo1YW93TFBr?=
 =?iso-2022-jp?B?dkREeDE4bE5jYUswNi9rTXMyNmpGdWF6Uk5DUWgwYlAyWktMM01vVWJy?=
 =?iso-2022-jp?B?V0Qzb3paL3hNdWFmVlNQMm1yVU10ZURoTEpqeGVCSGtZNjBXVE4rWmtS?=
 =?iso-2022-jp?B?OU1WOE9mdG5pOVRYSkRvZkVlbkN4TTJibCswYUpyK1YrOXBJUkNlbHds?=
 =?iso-2022-jp?B?NHNiRTJKVGswb3lqdUNnL25ndm1RdjZqZHFwbWJ4cEdsMlJ1TGxsY2hy?=
 =?iso-2022-jp?B?d0hFL2NZRkJxTmpUTkFxbFc1cmxJU0ZOMHh1Z0MrSVZLaEZFeE0zQjEw?=
 =?iso-2022-jp?B?VzF1VEp1dW5lVmJvRC9TMkFGdXMvMHdKcVhxci9HWlJVRi8zTk1HN3JY?=
 =?iso-2022-jp?B?N1VHUUs4Z0lkL1pOclgxMUV6eVlENWZ3dDlUNlU1V3BJamo4VWc5M0hu?=
 =?iso-2022-jp?B?NFMwVW1YWm9sL1FKcE5BV21vZDVkLzhkWjYyT25HMldqWDJuMk5saDZp?=
 =?iso-2022-jp?B?bU5QYXpyOEJUb2dMc3hXaTFTWGZzeGNaN09UWmdUR0RQdmdUZGRmKy9S?=
 =?iso-2022-jp?B?S1NkQXFUYXlZYXNrYUdpZlAzSlFXOUJVZEVhNFhWdXFNZzllTHFnTVcx?=
 =?iso-2022-jp?B?NlZReXp6bTBsUFdFV3BFcStMd0lhUXJzd0s3WTg4YWdXNmlUQzlMT0Ji?=
 =?iso-2022-jp?B?RkIzUFdwdXAwQzZ3QktWNVpUZ0dRR2EvVW9LVk9qRVEvaUtaUFRBT1cv?=
 =?iso-2022-jp?B?Uk54MWwremIvVkpjeSs2T2w2YmZIYTg9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(7053199007)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?anJoVFd3R2w2UmRNZi9OZFZEK2dybjd3Y2M5ZHRSYXFXTG40VDZZNStm?=
 =?iso-2022-jp?B?ODF5cnFUcjZ5Y2xJZTBIRkVpZm9pZGI5N0EzK2RQTENXOHVQMEFiM01p?=
 =?iso-2022-jp?B?b0RpV0ptOVRrUmlGMDFrR1JVcWNXTUwvc00yRmkvWHZQRkxOQkRSakZU?=
 =?iso-2022-jp?B?UVI0aEpBT0xxS2dDMmxSNE53dDl2L2xJdzNJUGt2ZTQ1aHdGTDNxM3g3?=
 =?iso-2022-jp?B?VUNKVy9IYk1jamhLTnk5YTczU3VvVm5EV2VKWXh1OGVxcWVBdHpwM1cr?=
 =?iso-2022-jp?B?ajlObVJWcFQ5LzNsbzk2WXhwRndUODJwSHhjR1lvaVFwdHJlQklvMDlV?=
 =?iso-2022-jp?B?eEVBd2NEUmRuQTF2dHhYcGFRVktNOFVFekNIN21wQmR1aDRWVU1WaHAx?=
 =?iso-2022-jp?B?OW95V1p2bVBxWFVUZDBtY256MTVoTmxFRGNwaE45bm1TbFI3RDBMaHoz?=
 =?iso-2022-jp?B?RkRVbjZONk5SeFkycGtabVYwbEVCQmJFWERxMTlyMVcwM0JWTjRUU1M1?=
 =?iso-2022-jp?B?NW1oUStpQnByNnZqdGxxTGJRT25jaXdRMngxT1B2UXFhSjVRbXpZMDZo?=
 =?iso-2022-jp?B?RlVMUFB3ZEFDdjJpdVh6NHE0ZU15dFVoVk1ta25Hd2h6bWRyYzRMc0xD?=
 =?iso-2022-jp?B?WnhmM3hFTjdKQnd5aWRmZ2Y5TEx0MXhKenZTV1dPclF4VCt1eGJMNm0v?=
 =?iso-2022-jp?B?QTdsazFNQmYxUEZ3RFhOamdVUDc2dVRoeEZSQ1JlQVlTTlg4SXQ3RUg4?=
 =?iso-2022-jp?B?c215OXJlamp0ckZKWGVLRUJCWjJvVFB2NEh2OUh2cTJZcEN5VUhrOVZi?=
 =?iso-2022-jp?B?VmJIMHRhSGx2UUsvdVZiRC9RM3VhbmdiblJyWVVpS0c4TjNIS3dUdnhr?=
 =?iso-2022-jp?B?emlZN2dIaFFLN0l0Ry9mOGxCenVqaFZlL2lzTXE3TnkrTm4wYzF0TUhl?=
 =?iso-2022-jp?B?RXdBcWRzOUJqQWxUWTN4REwxbkhjRGg0MnBGc3pRd1drTldvT3ltZ1pC?=
 =?iso-2022-jp?B?WTFQVTFubktCNk5TQ0pvNEdOQVVHS3dxdXpPSTNuNjc0QVNzUlVHV283?=
 =?iso-2022-jp?B?QzdsMnE3Y0FwblJDRkhFMU9xSWhCaUxIN2hoekpETE5ZeTlkbEtkOXdJ?=
 =?iso-2022-jp?B?SXVyT3RUSkhsLzVUTHVWai9wM0psUUFVNkN5a043Z1ViYXkwTW9mWlhm?=
 =?iso-2022-jp?B?R0g4Z1V2THlPQnJMc2xhSTVEY1VXZWptaHM1Y1dUWHF0dU5EL2hoMjZo?=
 =?iso-2022-jp?B?a3FWTHg4N0ppeW1OK1dzSlY1WWozZVVNazk3NGN1ZWxjaVdrQ0l1VTR3?=
 =?iso-2022-jp?B?NHJqd2FpL0VTbzFkblA1a2NpMDRQV3lJRkdOSnpMdmp1NEVXaERIWVVB?=
 =?iso-2022-jp?B?RmtaNlpIWmNvajhiVmQvL2lSVDJrNHdLYS9YaDFDQW1IOCtzWlJOWlBC?=
 =?iso-2022-jp?B?UnFYcDN5eEVMWjJrOEpVUDU2VWVacGZTTTVPWEhpaXoyRWY5dEplTEY2?=
 =?iso-2022-jp?B?VHJzRkZ3cW0wc0Q2U3lBakFHZDltaWNKZUU2bGJZOFNydzEvWDBWNVNJ?=
 =?iso-2022-jp?B?eDk0VGhhZ0tCS2ZUUjFDWW1Pa2dEQXpubjFuaE4wVG11Q283R3FTUXh5?=
 =?iso-2022-jp?B?M0NCcjZQWm1ENmJvVHkzSENBMFRMRmlwVVB5czNVVE5oZWtOb0Zya2RI?=
 =?iso-2022-jp?B?bGc0cmhyR1JDcDBIVGErQVF2NG05bC9TNEx3a3NHMTVyb013Z1JJcWR0?=
 =?iso-2022-jp?B?Nk9GRzJncFBkc2hxc1BvVHRXZVB3d1gvWTQvY1hXY2V1Y0R5blVZSXIz?=
 =?iso-2022-jp?B?VjJwYmlXTXpyU2NEWkJHMUVTYjljYkgyYWdtRWFibDFkb3crbFRta0JJ?=
 =?iso-2022-jp?B?aXdXN3pjUW5MRWFwZDZUYUlldmhWWU5RdmJ0UlJOa2t3N0h1VUpmRm53?=
 =?iso-2022-jp?B?cVUwd2xnZFRDN0VIR21EVkZOZ093S2c2a1V1ZVc2V1J4d3o5UVhtaFZZ?=
 =?iso-2022-jp?B?WmJzVUhYcmpHNyt0YWYyQ1pWMlVsSlEyVjlTaU9jRENBVjZmU3pjcTNI?=
 =?iso-2022-jp?B?RU9XY1UzZ2hEUlJNaWF0TXo4QXE3QjdXZ3U2dks1clVyd2FOTzBscWph?=
 =?iso-2022-jp?B?aE9oZWp1bUlnUmtuN1MwYk1XR0ZEK3FRSVBmSGNHUml5TDBlNmJkSlFj?=
 =?iso-2022-jp?B?NlUwZEMyMHNnSkxiRVpzUU54ZEtUcWVpRmtOTWpyZ0RZemRGM0xsUW9o?=
 =?iso-2022-jp?B?dzVrbE91eWFPcEh1cHArTGM0eTd4NUQ1YmRiNjAzQVJzZmlBOHJlWXpr?=
 =?iso-2022-jp?B?VnpIWkR3VU1xRDFmWkNiZGVudUxabUxUci9iTThwY1dRY1dsNTl5Uit1?=
 =?iso-2022-jp?B?WmdpcmM9?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB1107501396B71E71A49B7A7C8C725ATY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0593967-2948-472e-3197-08ddcea630e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 13:45:33.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+OoMGxdvZEZ4EuTSWeb7JBgnYpIOuqgX1/Zbh8b5uIU/N/9C08tNczNXrFd5EGjLWuPzFQGVLXSHFxE4b+ApDNJyk0WccC/vCDuaXQo098TmJf8rRvnk5Cbo+KwW/me
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14526
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Jul 2025 13:45:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19615

--_000_TY3PR01MB1107501396B71E71A49B7A7C8C725ATY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.


  *   I think the CIP core group just did something similar for a WFX servi=
ce?
  *   You could go down the same route for zchunk. Either by using the same=
 server or in setting up a new one.

In CIP core/SWUpdate regular meetings, we are discussing alternate options =
for hosting a file server for zchunk based updates.
In case of new EC2 instance we should also consider the cost of the instanc=
e.

So, Is there any possibility to use LAVA master server as a file server for=
 zchunk updates? Is it also running in AWS?

Basically, we can configure either nginx or apache2  server in this PC and =
use it for zchunk updates.
However, we need to check how to upload .zck file every time to LAVA master=
 server pc before the running the tests and also LAVA jobs should access th=
is file.

It is just an idea so I=1B$B!G=1B(Bm not sure whether it works. What do you=
 think? Is it possible?

Thanks & Regards
Shivanand K
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: 24 March 2025 15:46
To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; jan.kiszk=
a@siemens.com; balakumar adithya(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Adithya.=
Balakumar@toshiba-tsip.com>; ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <=
Sai.Sathujoda@toshiba-tsip.com>; cip-dev@lists.cip-project.org
Subject: RE: File server for zchunk swupdate update

Hello Shivanand,

I think the CIP core group just did something similar for a WFX service?
You could go down the same route for zchunk. Either by using the same serve=
r or in setting up a new one.

Either way the only people with admin access to install things are the LF a=
dmins.
You can create a ticket with them through the LF helpdesk: https://jira.lin=
uxfoundation.org/plugins/servlet/desk

Kind regards, Chris

From: Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshi=
ba-tsip.com> <Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijad=
ar@toshiba-tsip.com>>
Sent: 17 March 2025 13:57
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; jan.=
kiszka@siemens.com<mailto:jan.kiszka@siemens.com>; Adithya.Balakumar@toshib=
a-tsip.com<mailto:Adithya.Balakumar@toshiba-tsip.com>; Sai.Sathujoda@toshib=
a-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>; cip-dev@lists.cip-projec=
t.org<mailto:cip-dev@lists.cip-project.org>
Subject: File server for zchunk swupdate update

Hi Chris,

This is regarding the zchunk based swupdate verification on LAVA lab.

The zchunk based update needs a file server where we keep .zck file and swu=
pdate requests multiple byte ranges based on the requirement.
In manual test scenario, this has been verified by keeping the file in Apac=
he / nginx file server.

In LAVA lab, I also verified zchunk update by installing Apache / nginx in =
CIP image itself.
In the last CIP core meeting, we discussed to use some container to host th=
e file server (Apache or nginx) for this purpose instead of installing in t=
he CIP image by considering the package size and maintenance.

Do you know any EC2 instance where we can run docker container with nginx/A=
pache for this and should be accessible to LAVA lab?
Or do you have any other ideas/place apart from EC2 instance for running co=
ntainer?

Please provide your opinion.

Thanks & Regards
Shivanand K

--_000_TY3PR01MB1107501396B71E71A49B7A7C8C725ATY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1675448488;
	mso-list-type:hybrid;
	mso-list-template-ids:1797717820 2124340810 1074331651 1074331653 10743316=
49 1074331651 1074331653 1074331649 1074331651 1074331653;}
@list l0:level1
	{mso-level-start-at:96;
	mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;
	mso-fareast-font-family:"MS PGothic";
	mso-bidi-font-family:"MS PGothic";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"color:#7030A0;margin-left:0cm;mso-l=
ist:l0 level1 lfo1">
<span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif">I=
 think the CIP core group just did something similar for a WFX service?<o:p=
></o:p></span></li><li class=3D"MsoListParagraph" style=3D"color:#7030A0;ma=
rgin-left:0cm;mso-list:l0 level1 lfo1">
<span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif">Y=
ou could go down the same route for zchunk. Either by using the same server=
 or in setting up a new one.<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In CIP core/SWUpdate regular meetings, we are discus=
sing alternate options for hosting a file server for zchunk based updates.
<o:p></o:p></p>
<p class=3D"MsoNormal">In case of new EC2 instance we should also consider =
the cost of the instance.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So, Is there any possibility to use LAVA master serv=
er as a file server for zchunk updates? Is it also running in AWS?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Basically, we can configure either <b>nginx</b> or <=
b>apache2</b> &nbsp;server in this PC and use it for zchunk updates.<o:p></=
o:p></p>
<p class=3D"MsoNormal">However, we need to check how to upload .zck file ev=
ery time to LAVA master server pc before the running the tests and also LAV=
A jobs should access this file.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It is just an idea so I=1B$B!G=1B(Bm not sure whethe=
r it works. What do you think? Is it possible?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA"> Chris Paterson
 &lt;Chris.Paterson2@renesas.com&gt; <br>
<b>Sent:</b> 24 March 2025 15:46<br>
<b>To:</b> kunijadar shivanand(</span><span lang=3D"JA" style=3D"font-famil=
y:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language=
:JA">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA"> DI=
TC_DIT-OST)
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=
=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA"> DITC_DI=
T-OST)
 &lt;dinesh.kumar@toshiba-tsip.com&gt;; hayashi kazuhiro(</span><span lang=
=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligature=
s:none;mso-fareast-language:JA">=1B$BNS=1B(B</span><span lang=3D"JA" style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$BOB9(=1B(B</span><span=
 lang=3D"JA" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatu=
res:none;mso-fareast-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#D#M#E=1B(B</span><sp=
an lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none;mso-fareast-language:JA"> =1B$B!{=1B(B</span><span lang=3D"JA=
" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none=
;mso-fareast-language:JA">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:JA">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"font-family:&=
quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA=
">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B!{=
=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#M#P#4=1B(B</spa=
n><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:JA">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; jan.kiszka@siemens.com; balakumar=
 adithya(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quo=
t;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(=
B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;mso-ligatures:none;mso-fareast-language:JA">
 DITC_DIT-OST) &lt;Adithya.Balakumar@toshiba-tsip.com&gt;; ashrith sai(</sp=
an><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif=
;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-lig=
atures:none;mso-fareast-language:JA">
 DITC_DIT-OST) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;; cip-dev@lists.cip-pr=
oject.org<br>
<b>Subject:</b> RE: File server for zchunk swupdate update<o:p></o:p></span=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">Hello Shivanand,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">I think the CIP core group just did som=
ething similar for a WFX service?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">You could go down the same route for zc=
hunk. Either by using the same server or in setting up a new one.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">Either way the only people with admin a=
ccess to install things are the LF admins.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">You can create a ticket with them throu=
gh the LF helpdesk:
<a href=3D"https://jira.linuxfoundation.org/plugins/servlet/desk">https://j=
ira.linuxfoundation.org/plugins/servlet/desk</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA">
<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com">Shivanand.Kunijadar=
@toshiba-tsip.com</a> &lt;<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsi=
p.com">Shivanand.Kunijadar@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> 17 March 2025 13:57<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@to=
shiba-tsip.com</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a>; <a hr=
ef=3D"mailto:Adithya.Balakumar@toshiba-tsip.com">
Adithya.Balakumar@toshiba-tsip.com</a>; <a href=3D"mailto:Sai.Sathujoda@tos=
hiba-tsip.com">
Sai.Sathujoda@toshiba-tsip.com</a>; <a href=3D"mailto:cip-dev@lists.cip-pro=
ject.org">
cip-dev@lists.cip-project.org</a><br>
<b>Subject:</b> File server for zchunk swupdate update<o:p></o:p></span></p=
>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hi Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is regarding the zchunk based swupdate verifica=
tion on LAVA lab.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The zchunk based update needs a file server where we=
 keep .zck file and swupdate requests multiple byte ranges based on the req=
uirement.
<o:p></o:p></p>
<p class=3D"MsoNormal">In manual test scenario, this has been verified by k=
eeping the file in Apache / nginx file server.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In LAVA lab, I also verified zchunk update by instal=
ling Apache / nginx in CIP image itself.
<o:p></o:p></p>
<p class=3D"MsoNormal">In the last CIP core meeting, we discussed to use so=
me container to host the file server (Apache or nginx) for this purpose ins=
tead of installing in the CIP image by considering the package size and mai=
ntenance.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you know any EC2 instance where we can run docker=
 container with nginx/Apache for this and should be accessible to LAVA lab?
<o:p></o:p></p>
<p class=3D"MsoNormal">Or do you have any other ideas/place apart from EC2 =
instance for running container?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please provide your opinion.&nbsp; <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_TY3PR01MB1107501396B71E71A49B7A7C8C725ATY3PR01MB11075jp_--


