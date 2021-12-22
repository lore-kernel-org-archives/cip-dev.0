Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B5FC433F5
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 01:22:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.13868.1640136146701027695
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Dec 2021 17:22:28 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1BM1MIZX015840;
 Wed, 22 Dec 2021 10:22:18 +0900
X-Iguazu-Qid: 34trLe71PAW3HDZO1G
X-Iguazu-QSIG: v=2; s=0; t=1640136138; q=34trLe71PAW3HDZO1G;
 m=MYuPZjpLUN9bxmqQ/53AnALFrEuZesuHj1Gru5jURyI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 1BM1MGLX002468
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 Dec 2021 10:22:16 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 987A61000A5;
	Wed, 22 Dec 2021 10:22:16 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1BM1MGPh024187;
	Wed, 22 Dec 2021 10:22:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrC1uAkOIaaOYihv2TbC/sBLT4Ca/r+I/9Rq4Ts94M4B4pgn6dYKFDyELlPJJqZ6GhuqoP8Jbf3bAVIGxBTSGYpYaxubmAiZg0w2bQXAGjJd0NRJnFV9a0M/8BfyHZMzTePbgZs9dGg4AMFU3xYUNtSVrK4qcQFtAe0ZnAgV6Gv67YzTqfQAbM32+hflIHSzH94IkDmcyEJFlJSTxeXEd9DSI3XWN4h42qtilscF/Gmos4QT7Y4UXs8jHdcLCE8VV01TDbVgfvez62jJy71Dc+SE6QRTnwybKln5DWZ86Drz+OOIcOUYXALZJz6RppfCtVTm1GrQNcdkwMPp+m5ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyJvFbVXH1d1ma575xRmwKFKShmSRUd/WestDngGqk0=;
 b=IcHeEHE7AXJTZ41foKibbQQ2EXvzjryUAVeih6cUTUxibZdjRCtaYErpafngUNh5BhkMI3WPOTrLOY2i2JX0uNbrWYOHxKZTLF4ftjn3s2ZIxNMG3bu/yfG77NOb7fkcTKDhkBRQ45NsyCirvtcRKxo69cBrEHAzXJci/oJf1kDNcO/wubL5XgXSbvzia6TIhfTuhbNxXUGagiFY/ell3w391iWc4ETXfnzMAcou4/7ej1nmrLSQEvDeQXdsJ0FauLwyt/71S6qh9SMJuA+Mg5ObPoClBUedMkK3NMjVPMh5pLXvOZyr94pWq/apqiWGcMLfc9LqgXo+1LBCQ/GCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for pinctrl/dmac/iic
Thread-Topic: [PATCH 5.10.y-cip 00/22] RZ/G2L: Add support for
 pinctrl/dmac/iic
Thread-Index: AQHX9tHL4sSRvraIeUKzvjWs8F4LFA==
Date: Wed, 22 Dec 2021 01:22:09 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62528F92704101B24FAC60F8927D9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 838d8329-6f0a-5599-ae09-5f6eaf3094d9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8637adf7-63ee-4203-aa59-08d9c4e9797e
x-ms-traffictypediagnostic: TYAPR01MB4445:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB444592281B623F8C01D55324927D9@TYAPR01MB4445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vR4Jw+0NK7Nq8TmfV3hRttZ6fou7ndjNXm30/Y/xBhXdzs3BfZF61yz1U2TD4C+wIh7iAI6Cs7824nTD+0muleHUjNAuXRz7Irs0k82eKqo686EiLTchZXR56Z+3GAfTZSjl/BnYz4FLabqdDdoM+6GQMNW7X4DvsaL9ekGnq1Z/jU8OTEKYuGhW8THfNNkLqnsGC3mTcWkZXOogwAYmb5YS4GAX+IjaAcoXIx/4kA5O78Icqqj9+PJkrHVO2rTjy/BmwlFnlOb5uolHl7FTHPUeT0aF+LwYJzdT2WUBAG9tu/Ztsk6Gzg/Kfd4vT3ca9JX+jtAeIaYALUHnv49W6vAZLyH9Qw1kwi5+j0aiNAA8cJsKck3V+dMXzv2cRYzO86Z6Vlgpeos8iGCoG9MSxcz1UmDNbiQZT3G5j0TLw7mfo339I+Qfn+OK8JMJC9/Cgw20s0VP4YI7jyBKjnA8ID9icYmcAiSVNibK2if1krOKI4JzvaM6Hj6go8gDbgZIGp8U4B3cYh5d8k/5fzDtfYXCWHVovo6mCLfFkaWxcdw/aKqqslaAy6Vzr2Tw/T/eJcvzD5NpcvnKEK8WC6kV11r/H3Imxs8jNo2WpOv5rNVH455mBGkgt/cOi3bhR8z5LUhOKq7OUtfRLhezh21q4WnlMNz5ffzKlrtiFOxPZ3pv86KriG6uyhrty3zOHsoye7PzbmcUCscHsNLpifv3JZeC9segCcDJcY7inR/gGjFem7gGApMXSjixTomF9ycJ/gMcekPLPgHMzFFPxdXmHKULRhfCeVaELBEh3hcnrsk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(5660300002)(38100700002)(52536014)(55016003)(316002)(8676002)(71200400001)(86362001)(66446008)(110136005)(186003)(2906002)(6506007)(9686003)(66556008)(4326008)(66946007)(966005)(508600001)(64756008)(66476007)(54906003)(7696005)(26005)(38070700005)(76116006)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UlZWVTEvUFpPTUdhcEMwRHlMRjNJR3d3QVZEczFHaGJwYkFjemdzQlNTWUtQ?=
 =?utf-8?B?dzVjWDVnVTI5TzVtNzE0bGNFZUFCd0dLeHBKb1c3YTZ0ci94VUI5T1Z3QWRq?=
 =?utf-8?B?MFNDTURhT0k1TUJzNDVyNlQzSG9Zalg2ZzBxOWUxaVpRRGdFaXFvbG9aNE1j?=
 =?utf-8?B?aGtTUVVBQlo1ZC9CdTZrREZQMEN2MVFVcHMvdlBVMEppc0hpaXVTUHNoaEtE?=
 =?utf-8?B?UFpwSVN1aUs2eUQrNktkN1hNeTNVVjErTnFzMUdTWFBVOVpvU3VlWGdoTmxR?=
 =?utf-8?B?enE2WWFGZm9nZDdJVkUzZHlmdlRNVXZzSnloNnpZQkNUbG40TmtCRndaa2lK?=
 =?utf-8?B?cU1ERVFRak0vejIyVDJSUXdSTkZvcXRQbnQ5c0w3ZGlhSlRpRHRENkNWbnFP?=
 =?utf-8?B?MjZQS0RtcHc3K3dQa3NCRDZ1WHlKUXZMUHIvVkhZemFVNFIwdXZpK09kYVRE?=
 =?utf-8?B?MmJrVm0vMzJ1QUdwSzhtWXplR2dRd1FUSGZqMjE2ZmxwUnlWN0Z2Y3NaZm9o?=
 =?utf-8?B?UVd6RHhSZzNLM2xwNHEydkpHZTZwdXUzY1hyZU1QdHFudys0bnlGYWJ5MEd6?=
 =?utf-8?B?bjRpRGhOdVRtbzNib1piTFVOZldNckdHTXEyTG1VTXJLUHF2YnF6TkJJbU5X?=
 =?utf-8?B?WEx0SXlQUkc0MU4zNmxQc2ZYZG1wTlhaRSt4SjcrdEg2YzdUYnRqNVdoRHdG?=
 =?utf-8?B?MmVRaXl1ZjZ0eW9URHNCLzhHbEpVOVNWV2Ywb1JsTjQrUEJYTkdJRm1LU0hr?=
 =?utf-8?B?aFRJWERyYVNYdS84OG5OaDg1ZGF2TlZXRXJxS2M0c0lnMCtPcGplRjdjZy9H?=
 =?utf-8?B?eFcxM3VXNUVBWVhoUWRsUE5ES3dVM21WSjlGa2pFWkxVUy8rMDBlMmtnbUVT?=
 =?utf-8?B?MWx1UVBjeDQxZ25kYTN0bDBHbG1abGhLMkZ3NVNXU2o2aG0wcy8zVGgwaHRI?=
 =?utf-8?B?S0FwOE9BZmdId2hzVDZobXQ2TnhFc0FnSHRmUWVOdUdqY3BnZnVUK1MxS2M3?=
 =?utf-8?B?dFZ5dVp3M1IxVUJoNXUxZ243RDlpaEZZbjQvb29SVGYydTlPMGh5RkMzYjVJ?=
 =?utf-8?B?OVErUUNlR2xORVViQ1hSWHM2TTJuVEpWenBiY2t1VlorZzVSZVNZOGlqQzVX?=
 =?utf-8?B?dGgrTHVUV05iMjBHaXQrSFh1OVFvUDVraXVpNklNN2xURDVFbFEydmxtb2Zu?=
 =?utf-8?B?aTJXcXhqOXFRZEIzTGxwOWNRL2NsbFhNejJxNmlsV2VtTWhUQjhhREIvSVN5?=
 =?utf-8?B?RE5jV3pvYW5NRHdvb1JGZUUyUmdhU1BZOERNdmJsckFKMTZ2eTIrSFdLNk9R?=
 =?utf-8?B?ZWhSN3ovbzNnS0VucUIzdFRldjBnOHplOTR1ODRocG1NTzRMZXIyQjZhR1pJ?=
 =?utf-8?B?UkhCRG9MNzNwWmFUZWJNUmpZZk5SZ0FuMEJtSVJNeEdIZGRWUHVybVlKSW9v?=
 =?utf-8?B?ZkswcG1tNmhwYXhMYUdZNGcwNU5CWFFUQVhkZlAyS2RCNE81TFNmcjMyajZu?=
 =?utf-8?B?VWFCYUh6dzVhNHBLOWRxQ0xjb3M1aGNhWnNaQUVzVHlpc3JybEkwNlZhUXgw?=
 =?utf-8?B?SnFkYjJmblByaFEyWHJIa0o4cHg3VnVKNi9ZaWZIRGVLWGx2V054ZmV6UG1I?=
 =?utf-8?B?VDFONWhRL0FCZTA5QmpoalBIUmJSNUxyeERzbDZSZDB5cGtFcmJDY0J5YmFn?=
 =?utf-8?B?ZXRnN2YxSElzUHpmTk96MmVTekdEUDByQU1YUFI0Y0tPNVRQdHpES3A3QlJD?=
 =?utf-8?B?VHRiUFBhRDJ0Vm1Na2xTKzlZNlB0VWhvdzEwaHBmcTg0OU1YMUpUaHpMbEFX?=
 =?utf-8?B?SXZyNTNQWGxBRU9mMDgxZDVqZ3IyNDdNbHRCR0JJbXg1V2ZLRDRHa044Q1la?=
 =?utf-8?B?QksxbjlVVzhXV1ZGUjg4NTZCdmhNaHlYbnVaeUNOUjkxZFlyblVOU21rdjRO?=
 =?utf-8?B?ZERSTWxxRVo4M29yQlhZUjdheitDakhYc3ZYOVVxd2phT215eVF0ZW96TEtt?=
 =?utf-8?B?dk9yNTc5U1JVZWR0NHhLYVF0R29zcjVvcFdmSCtGcHF5Y1VsU3FaU0lwSCs4?=
 =?utf-8?B?aWRiZTVvVFRla3hKTkI5R3g2R0lMQTdxVG1DSWZyZGNTNjI2SHBDTEdCSFRQ?=
 =?utf-8?B?Z2o3NEl2bmlCWXNjSUg0ZmlWWjBFRVo0Z0xROWVPaXV0ekZwTnhaakNpT1Q3?=
 =?utf-8?B?SmR5L1F3NGJza3cvenlkZmljY0s1NlprSEtnU29QVGpCRUdNaFcrQktaWDMz?=
 =?utf-8?B?ejdOd0kraEszYUNRT0t6dTlEMTM4UEg2UlBPVUg1WVUya1diNVY5ZmFwWUFy?=
 =?utf-8?Q?oY/wMFVTX37E0m2BP5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8637adf7-63ee-4203-aa59-08d9c4e9797e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 01:22:09.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 gNHXgqkKBg2Aud+fqrE6/RBij5vrj4XMkrY0/jsLOBouo/0SLNp7CCtb39TLdPrAuzRlpxDtK0YtDyKeBlzmA6teURD8OyLqAdoFzfAyi9Xv8AM0seMRIpweDr/6pVuL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4445
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 01:22:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7223

SGkgYWxsLAoKSGkhCgo+PiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIFBpbmN0cmwvRE1BQy9JSUMg
c3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9HMkwgU29DLgo+PiAKPj4gQWxsIHRoZSBwYXRjaGVzIGhh
dmUgYmVlbiBjaGVycnkgcGlja2VkIGZyb20gdjUuMTYtcmM1Lgo+PiAKPj4gSSBoYXZlIGNyZWF0
ZWQgYSBNUiBbMF0gZm9yIGNpcC1rZXJuZWwtY29uZmlnIChmb3IgdGVzdGluZyBwdXJwb3NlKSwg
d2hpY2gKPj4gY2FuIGxhdGVyIGJlIG1lcmdlZCBvbmNlIHRoaXMgcGF0Y2hlcyBoYXZlIGJlZW4g
bWVyZ2VkLgo+Cj5TZXJpZXMgbG9va3Mgb2theSB0byBtZS4gQWxsIEkgY291bGQgZmluZCBhcmUK
PndoaXRlc3BhY2VzL2NvbW1lbnRzL2RvY3VtZW50YXRpb24gaXNzdWVzLgo+Cj5JJ2xsIHByb2Nl
ZWQgd2l0aCB0ZXN0aW5nOyBJIGNhbiBhcHBseSBpdCBpZiBpdCBwYXNzZXMgYW5kIHRoZXJlIGFy
ZQo+bm8gb3RoZXIgY29tbWVudHMuCgpJIHJldmlld2VkIHRoaXMgc2VyaWVzLCB0aGVyZSB3YXMg
bm8gaXNzdWUuCkFuZCBidWlsZCB0ZXN0IHdhcyBhbGwgZ3JlZW4uCiAgaHR0cHM6Ly9naXRsYWIu
Y29tL2NpcC1wcm9qZWN0L2NpcC1rZXJuZWwvbGludXgtY2lwLy0vcGlwZWxpbmVzLzQzMzk0NTcy
MgpSZXZpZXdlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3No
aWJhLmNvLmpwPgoKQmVzdCByZWdhcmRzLAogIE5vYnVoaXJvCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCuW3ruWHuuS6ujogUGF2ZWwgTWFjaGVrCumAgeS/oTogMjAy
MSAxMiDmnIggMjEg5pelICjngavmm5zml6UpIDE4OjQyCuWum+WFiDogTGFkIFByYWJoYWthcgpD
YzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqead
viDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KTsgUGF2ZWwgTWFjaGVrOyBCaWp1IERh
cwrku7blkI06IFJlOiBbUEFUQ0ggNS4xMC55LWNpcCAwMC8yMl0gUlovRzJMOiBBZGQgc3VwcG9y
dCBmb3IgcGluY3RybC9kbWFjL2lpYwoKCkhpIQoKPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIFBp
bmN0cmwvRE1BQy9JSUMgc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9HMkwgU29DLgo+IAo+IEFsbCB0
aGUgcGF0Y2hlcyBoYXZlIGJlZW4gY2hlcnJ5IHBpY2tlZCBmcm9tIHY1LjE2LXJjNS4KPiAKPiBJ
IGhhdmUgY3JlYXRlZCBhIE1SIFswXSBmb3IgY2lwLWtlcm5lbC1jb25maWcgKGZvciB0ZXN0aW5n
IHB1cnBvc2UpLCB3aGljaAo+IGNhbiBsYXRlciBiZSBtZXJnZWQgb25jZSB0aGlzIHBhdGNoZXMg
aGF2ZSBiZWVuIG1lcmdlZC4KClNlcmllcyBsb29rcyBva2F5IHRvIG1lLiBBbGwgSSBjb3VsZCBm
aW5kIGFyZQp3aGl0ZXNwYWNlcy9jb21tZW50cy9kb2N1bWVudGF0aW9uIGlzc3Vlcy4KCkknbGwg
cHJvY2VlZCB3aXRoIHRlc3Rpbmc7IEkgY2FuIGFwcGx5IGl0IGlmIGl0IHBhc3NlcyBhbmQgdGhl
cmUgYXJlCm5vIG90aGVyIGNvbW1lbnRzLgoKQmVzdCByZWdhcmRzLArCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUGF2
ZWwKLS0gCkRFTlggU29mdHdhcmUgRW5naW5lZXJpbmcgR21iSCzCoMKgwqDCoMKgIE1hbmFnaW5n
IERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5rCkhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNo
ZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQoKCg==


