Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F1C433F5
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 04:47:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.1879.1639975639090088806
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Dec 2021 20:47:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1BK4l82L017825;
 Mon, 20 Dec 2021 13:47:09 +0900
X-Iguazu-Qid: 2wHHDv11KAwzgbfVUw
X-Iguazu-QSIG: v=2; s=0; t=1639975628; q=2wHHDv11KAwzgbfVUw;
 m=I44qjj3UKVfK80MUkQDUChE//G2rSp1Dt6biwXzz/MU=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 1BK4l7oe000914
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 20 Dec 2021 13:47:07 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 28BBB1000C2;
	Mon, 20 Dec 2021 13:47:07 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1BK4l6GA020281;
	Mon, 20 Dec 2021 13:47:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHMG0VdJKoX7hdjWo02+7LRG1ct4UBU5tHXXSaPdH92M2dSou5QOEcQmId/VhRgdUC8Bvt7EJU7kKJOMRTzoPXEaTa2h4pZq+ALbHpoOG5jYPlfnFvEG0wOF9wUDSPo4Akz14kc/wZo/FkywVOCBdg4m+pPBG/Vk4rMLN+vQLHWmO0WE16qTuyVsRhkc+chK2lpcfoabEFf5rQapK3n+7CYENU97Mb6IAMeJgutJz+PlJ+SQNR4YOr4q5/nTK7pFOCvgmSXh0lTj5kXgYtBPkpR9MiRk7T+BAj0o1VNJ4rC+clcAlQVyyeTjilsYsiaVtcUK78zCteTJrwkU4JnCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DySkhAxO9M3qZ8Zgk0gkzLl1jogKQ7/EG52LxmbUiRc=;
 b=ES3i6rgy6hC8u/eo2gfTMgoMogdwnuqXK0FHCkdrl0a9vmaqB2GDD8G5UbewpPr7cXFcFq4mz3hC8cIt7MFe5TdGxi5qbWFEYbde57+R8xQDqF0M6TYILU2edLnhy+lYv0xm0LielYR/JolW1zQH4mPYrE5pkC24dW8wzlhGAXjezeNPeKQLWhWyXNXykVv1IOUgvuacrOHv2V5QTOKxpLhkn2FkmQNxd45hmIqljIcu8yTF/jFU6Jk4RDiNnTe8lErJsW4uSg7o9hawRrakOoNYXypTZTRbVVPDygt7CRojUqasugLIZ9+Rwmkts18JY4QxhaR1RmSgwnqHmPu3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for
 Renesas RZ/G2L SoC + SMARC EVK
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip 00/24] Add CPG and initial DTS/I for
 Renesas RZ/G2L SoC + SMARC EVK
Thread-Index: AQHX9VyOwyDcO4RDcUuc5e9hLdrVOA==
Date: Mon, 20 Dec 2021 04:47:04 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB625257A29259B7C8D6ADFAA5927B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 4e743831-e6bc-59e9-d427-c3fff350dc28
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b97df05-c140-4665-90e1-08d9c373c52d
x-ms-traffictypediagnostic: TYAPR01MB6395:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB639510591E3E8BA5F6D01F99927B9@TYAPR01MB6395.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KQNusN1Ral4XA6LaOt6DLW/PxYLLdHARJq+dYfworp8hmKZfzByu41cDN6scwB6W5Kdm5eQZtDIRwELenh7p4QolbaIcqE9tJYWqidp7envzuqFa7g/iEP8oJSgRkEzwUKjbtnqiCdjQIpOei8Pq5J/HN4rDpdHVoSmxTg5R57WSrO2s+gjP7AKyW6usVeYOoJ+PgYTMGZId13d6LMNgUUUlOUVM2p0AozsbU7weQvyv9YlYAfoyfyE/U3kxaJC8RssuwIHR4PTPiGF5pvJJOt70UCLSVhgOFiGG/7U3wMvCJ8PwF3ZJ1dZhdok+SZBD7PIThN/WDzr7PoqlpKjEKPD2pSpZf2QxU1Qu5f99Zp5+yJgDWhBG5EIQ50wfwYaRLS5LtejCe9DHRN7xZyudra+dSLorUEyzM7IlYxQ58XbItrPVY3/ll8ccB6bqOQMHo2k68GBIignWKBvjLJHlvqEDw2oGyMfYOTTIvYlw456tmEscMtrqrVsqnssuHLF8ZYz7kFB7XHoeiZom8qeq5YC7MYX3sZxzaNm3MhwlkdQ7m8YK/7oIh+MbIs4uGNrJIDIzkcsHHP+PAhlNmIG3419zwkgfxXNnIEQbZGrYsmPto1veQQ7DO/M7CA/EdAdif6t+0NPlIezP2i8bf+in/AGDgEg93TRzF2WAcIwAAeEqofv9H0miGzjzwLvMq/BrJAFncgO8MkTXJhupgPGifSWQyPbMHsP46ibgPy5sAE64gRXsfomQGNHwj1lqWOwsaRdJBv/f03Nojn7/MSIL0HhUxmJOyYNrV+AzxXk8YRA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(86362001)(5660300002)(186003)(2906002)(26005)(71200400001)(6916009)(33656002)(83380400001)(122000001)(6506007)(38100700002)(55016003)(52536014)(4326008)(38070700005)(966005)(316002)(508600001)(66446008)(66556008)(64756008)(9686003)(54906003)(8936002)(76116006)(7696005)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NFpWZDlCR1lSbmlUdnFoVGNDM1VnNVlPWk45VmREeitqNXhpbllzb1V3VXJI?=
 =?utf-8?B?WHpMd2FFcHhNUjE0ODJBWlNCQktOaHhDZHB4QTk1UHJURmIyVVZnZllaS3lX?=
 =?utf-8?B?bnBpMXM4azJkRng3RElSbEpScTI4QnRjaEN2ZHYxditPbHU4SjJsWFpMeEYv?=
 =?utf-8?B?T1NSbzB3N2dTYXF6RVU5cHNUanVROEtua21lVDM3QkgyVUZ1aTVDSnZ4RVBD?=
 =?utf-8?B?ZnZpNnZQOThKYzZTZytBZ3NwbVplQzZqbkZpOVVHOTFIZ05qMjMwU0ZrZ0Ir?=
 =?utf-8?B?Q3pBeVJFenFSd0laczZzeGFISHFJZ1IyaVkzL3lGUE1pL0JEbTVpSUtoZENh?=
 =?utf-8?B?YW5vMUxINitLR29ic2ZIWUZtSDE4UUduS0x5MnhHN21VV3ovQy9yWmNieXF1?=
 =?utf-8?B?eEgwRlhVVUE3Q2l0bVhaNjFiSVpBRFQ0Z2VDMUdSTDdyYWZEelJDK0xBWlN0?=
 =?utf-8?B?MzlTUHhGbUppd1VWSndWSnZRdTNqLzVTM0hZT1pETHNUbzdTYUxDMVUyR1Zx?=
 =?utf-8?B?dWJOblpaYm5PcUM2RWhrTG1ZdEdrRVhYbkZrVUNadURxcSt1YVZGLzdNQXVp?=
 =?utf-8?B?UlB4anhWTlpaMUhvbStTVGJIV0I1dWhnR0gzUVNsLzk4cXpRdklRZE41S2J3?=
 =?utf-8?B?VjF4aHE4ZFFwZWx0cGtYeDNPY3lKRk5mOWdMSFZhYUlhYmY2T2ZuRmVnVzVO?=
 =?utf-8?B?ZHpUU002Sk00aHhNeEY3ZzlmREJ1TG5IZUowWW9FR0lqZUI1WjVxT0NBRG1R?=
 =?utf-8?B?bVQ3SVVYemhITTl1QlFMRExLTk1MYno3N2FlZnJ0UDF4cm42NVpIVmcxU3Nw?=
 =?utf-8?B?QW5rLzJqRWx3Y28vUm5WWHpPOWlYTXZxano1a01KaTdQYmR4TU9CSXpGdmxD?=
 =?utf-8?B?a3RPNEVpVFNqZzJJbkl6N1MvdUxoYkNDTlUrU25pMGxCNVR4ODBqMWk0cUhW?=
 =?utf-8?B?WnVrRTB4ZDlScktVU3VtQkNobXR2MVF4OVlUdFhzU0xONUdHdTFNUmxsS0d6?=
 =?utf-8?B?UmZiTXpmUVhWTHp4OHdvRHJQeHAzbnpacVM1M3l3M2ZJS1poNTJobmpFckRu?=
 =?utf-8?B?SE5aMjNYeU5XQ1pyKzZTMmxxUEtNejlzZ1N1S0RsMkZpamZSdWc2VHJvb1Y1?=
 =?utf-8?B?Y0xPc3llOVNJZHB0T0dPWWc2eGtibmxvdk9YYUJlVDFTSTZSbzNrWmxYTFg5?=
 =?utf-8?B?ckZqTWNWc2lwMWM3bWQzb281bE1nazErNHRuVjRUMHJ6b3ZScDlRaUNtWkRv?=
 =?utf-8?B?YmxaNEtJSjRMc2hiUW1MSndWenNub1FkRnlDeUJwY2R1WXBXcVpzL3lLaTl5?=
 =?utf-8?B?YmtnUG5rU0VueGZGY1gwSEVGdzBZV3liUzZPeDVvN2JjMU9QZGhQWkZ6Tzhh?=
 =?utf-8?B?T2hGSkloaHVLb0hnVi9peTZiZldUWnhWTGxCNHVQY1BENE5JTktmNTdQbnVr?=
 =?utf-8?B?VGd0ZjAzdDk4TzZvNGlKcEV1VStoSThpbXJIQlA1eHRtUFJlT3Y2T2lwdDF0?=
 =?utf-8?B?bXpaandCdVg1ZnJxNm0xQUszbUZnclJIUlFWK1BNS2hReXpHVWYvdjFiN3hJ?=
 =?utf-8?B?Qk93NzdkZUlOOHhVTk9ya2NTbzZHbWdKcXlwbW1UMm1Va3FGMGVETUkvRUEz?=
 =?utf-8?B?Vnp2b2VtQkRqK2w1TFFrRmQ2K0ZWM0p6Wk00MDNvSzN0Mm1sL0c4aXRFdnV2?=
 =?utf-8?B?UzY5RmloTnVhMlk2OWhKKy95QVpKdE00QnBXWERNdHN6VHRFS2VSeDZQM0h1?=
 =?utf-8?B?TEtiNm1lODdHZkY3S2p2aWl4TlpuQlpUaGcvbzBJUm9EcFAwVy8wZXNkRDNM?=
 =?utf-8?B?a1hLVW95eGhURVJFNFFRZzA0d1ZYWFc4bCt3TkVNQytlS2NOS3ZFR2Q2VGFT?=
 =?utf-8?B?NVVDeWZ2NTlETmdyTjdSV2xBaGpxQ1JkMmpWaHI1QXZzQWJ3SE12RU5tajhJ?=
 =?utf-8?B?RCthOXR3bElxL0JTaFo2SGZUenBQM0xwUTdnMXdkV2tUcTZ1a3dKRDU3b2tv?=
 =?utf-8?B?OWx3ZTF6VUpCOFhXYzFFbW5oVXZ1OENsc2RLbmNSaTMrMUkzVDVqeEEvaXhF?=
 =?utf-8?B?RVQ3TEl1eXVxTzJuMUhVcVVKek4yTkRNbHZxbHlUQzN0OWNHbzRxclJ2T0p3?=
 =?utf-8?B?N2I5SitLOVl0MUlaVFBHS0pGdVFzKzNKM1lEcnZieTd3eFcxTEl1ZFlDUGpQ?=
 =?utf-8?B?WjRrRmZiNEdkdFREVG5PbU02MS93UGhIMVNtdUcyYmNVRHN4cXI1M0VVN2Mr?=
 =?utf-8?B?SG1UT3huTUR6a1dWd1lYLzc0bHZNUk5DWk9RbjRSS0k5MHN5eWErOXh6Z05G?=
 =?utf-8?Q?WWAaxqsmZIGODVcLqH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0b97df05-c140-4665-90e1-08d9c373c52d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 04:47:04.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 UX8PicYKcFRKfZz6I480dv6x21zhg7Ob16q+HoE6+hsrq9N3q/yp8/nLB6wBQia+Pd1F7S6PqFY0n07Bv2V9aYMyNVfu7ihJp2zkmmfKyrkRSUMQR9lBcX+GYEhzfuRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6395
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 04:47:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7190

SGkgYWxsLAoKPiBUaGFuayB5b3UuIEkgY2hlY2tlZCB0aGUgc2VyaWVzIGFuZCBvbmx5IGZvdW5k
IHNvbWUgZGV0YWlscyAoc29tZSBvZgo+IHRoZW0gd2VyZSBmaXhlZCBsYXRlciBpbiB0aGUgc2Vy
aWVzKS4gSSBiZWxpZXZlIHdlIGNhbiBhcHBseSBpdC4KPiAKPiBSZXZpZXdlZC1ieTogUGF2ZWwg
TWFjaGVrIDxwYXZlbEBkZW54LmRlPgoKSSBwdXNoZWQgdGhpcyBzZXJpZXMuCgpCZXN0IHJlZ2Fy
ZHMsCiAgTm9idWhpcm8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrl
t67lh7rkuro6IFBhdmVsIE1hY2hlawrpgIHkv6E6IDIwMjEgMTIg5pyIIDE3IOaXpSAo6YeR5puc
5pelKSAxOTozOQrlrpvlhYg6IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz
77y377yj4pev77yh77yj77y0KQpDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBh
dmVsQGRlbnguZGU7IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tCuS7tuWQjTogUmU6IFtjaXAt
ZGV2XSBbUEFUQ0ggNS4xMC55LWNpcCAwMC8yNF0gQWRkIENQRyBhbmQgaW5pdGlhbCBEVFMvSSBm
b3IgUmVuZXNhcyBSWi9HMkwgU29DICsgU01BUkMgRVZLCgoKSGkhCgo+ID4gVGhpcyBwYXRjaCBz
ZXJpZXMgYWRkcyB0aGUgZm9sbG93aW5nOgo+ID4gKiBTZXJpYWwgc3VwcG9ydAo+ID4gKiBDbG9j
ayBzdXBwb3J0Cj4gPiAqIEluaXRpYWwgUlovRzJMIFNvQyBEVFNJCj4gPsKgwqAgLSBDUFUKPiA+
wqDCoCAtIENQRwo+ID7CoMKgIC0gR0lDCj4gPiAqIEluaXRpYWwgZGV2aWNlIHRyZWUgZm9yIFJa
L0cyTCBTTUFSQyBFVksKPiA+wqDCoCAtIG1lbW9yeQo+ID7CoMKgIC0gRXh0ZXJuYWwgaW5wdXQg
Y2xvY2sKPiA+wqDCoCAtIFNDSUYKPiA+Cj4gPiBBbGwgdGhlIHBhdGNoZXMgaGF2ZSBiZWVuIGNo
ZXJyeSBwaWNrZWQgZnJvbSA1LjE2LXJjNS4gRm9yIHRlc3RpbmcgcHVycG9zZQo+ID4gTVIgWzBd
IGNhbiBiZSB1c2VkLgo+IAo+IEkgd2lsbCBjaGVjayB0aGlzIHNlcmllcywgYW5kIEkgYW0gYWxz
byBjaGVja2luZyB0aGUgYnVpbGQuCj4KPiA+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVj
dC9jaXAta2VybmVsL2xpbnV4LWNpcC8tL3BpcGVsaW5lcy80MzE2NjMxNDAKClRoYW5rIHlvdS4g
SSBjaGVja2VkIHRoZSBzZXJpZXMgYW5kIG9ubHkgZm91bmQgc29tZSBkZXRhaWxzIChzb21lIG9m
CnRoZW0gd2VyZSBmaXhlZCBsYXRlciBpbiB0aGUgc2VyaWVzKS4gSSBiZWxpZXZlIHdlIGNhbiBh
cHBseSBpdC4KClJldmlld2VkLWJ5OiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+CsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBQYXZlbAotLSAKREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILMKgwqDCoMKg
wqAgTWFuYWdpbmcgRGlyZWN0b3I6IFdvbGZnYW5nIERlbmsKSFJCIDE2NTIzNSBNdW5pY2gsIE9m
ZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55CgoK


