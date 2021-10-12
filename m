Return-Path: <SRS0=7JMe=PA=lists.cip-project.org=bounce+64572+6806+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A6C433EF
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 08:12:29 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CB060E05
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 08:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7CB060E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ipEiYY4521723x1ug9vWvluC; Tue, 12 Oct 2021 01:12:28 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.10664.1634026346804443824
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Oct 2021 01:12:27 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 19C8COjF012923; Tue, 12 Oct 2021 17:12:24 +0900
X-Iguazu-Qid: 34tMQoLjdr4i1AcWwb
X-Iguazu-QSIG: v=2; s=0; t=1634026344; q=34tMQoLjdr4i1AcWwb; m=Ge8wqgg1Gh9oPSphnWFKhokDlsMQXZIxgC/rw+COol8=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 19C8CNPv009480
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Oct 2021 17:12:24 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 81B0B1000EE
	for <cip-dev@lists.cip-project.org>; Tue, 12 Oct 2021 17:12:23 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 19C8CNgV019506
	for <cip-dev@lists.cip-project.org>; Tue, 12 Oct 2021 17:12:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSMGbdxCqG1eVe0oG0A/wiqgnj1YBvBY+NuZzIuh8M+7Y+D/EkbbPcN94jkWNIDY+tUdSKA8tvHaeEfXMDMpfh1+y23ptS0a82Og4fnlJkZR9ZPYjJCNlG4NkO2i/hB2tPKDeItqFhSl/9b/YK9LEguV2WD4G7qsac2vX/l1R4pyz86OEmZmZd/+wCcnNQNQG5rItlY8aNoQcvzfFWyf3etOt+lSarvRqJWnMSaYc6E07le8herQK7V1fEvZRn60HlRdTUxWVmSEkIMzXFpzKRVKjrzPzPcH6U3ucmaf45RJ49U/hlhCYa8U7Wvr6xQrsLw6Rff2fSfL35Fv3TTiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCqJeBL7hm3/eNaPFsXO6XOHkVtCkv1cP4lGxRcYxAw=;
 b=ERHkhJvvHjSdjLZf0PNw6LfwJ0UpsRR9ZeTUyJibNItMg5u+1C5pIswNKHxZfCIEPfu4r1jb2rWtRpxEr00Ak+ZLZhoCYRlHiSWOV/PtXH6BV6cdkK3gqjVUpLZfuu58j0QAH5zbDR/wpEbER+kMWnrg/jiZYmSkfs4asdb0bvrglel7aUI4gAUy9ehqLyMUNvLXyrW66Vyu8EPGBrbuMKFkCyErHrmlMtwpv2fWxt4oHn/cR/0u6UqUdJkB1W8ySXit/m6h5kruCewtMidmniL7sBq/XBp96I9bFs/vv7kvAJOwBldnO3Pow/OycQu0pXxoRG3Mzh1tAPuxxRrujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Kazuhiro Hayashi" <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] deby: No certificate for https://git.yoctoproject.org
Thread-Topic: [cip-dev] deby: No certificate for https://git.yoctoproject.org
Thread-Index: Ade7OMEs7++K4DmQRUmVdlSdGp4zSgAF4piAAPv1hOA=
Date: Tue, 12 Oct 2021 08:12:20 +0000
X-TSB-HOP: ON
Message-ID: <TYBPR01MB5502ECEEF2B8CE6E9F5DCDA2E1B69@TYBPR01MB5502.jpnprd01.prod.outlook.com>
References: <TYBPR01MB5502233ADF8F0D953396F0C2E1B19@TYBPR01MB5502.jpnprd01.prod.outlook.com>
 <CADPJy8Xaoe14O1CtKShe90qf839tX9w2DzQJkVR_4edoXbrVAA@mail.gmail.com>
In-Reply-To: <CADPJy8Xaoe14O1CtKShe90qf839tX9w2DzQJkVR_4edoXbrVAA@mail.gmail.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a7742ad-8de8-48cf-b6fd-08d98d580394
x-ms-traffictypediagnostic: TY2PR01MB3450:
x-microsoft-antispam-prvs: <TY2PR01MB3450BE3F4FE075F8B7D34E33E1B69@TY2PR01MB3450.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 2EmRmZqBejzxa7YB5/TbNov6ka+agbFghI1ze2HHGyU/zvEHK6eFFukQIZpOHMNVZpT6xr/ljfJ814Lage/Y/tNj0M/7OGWfZdsJ8w2htzrVYqgAsZ2vFz4tqeMP4X/JvECZ7QpiiPVRHUWDpJzxoA1HPANg3KPu3/tWZN0wKStSHPX0CoSzCutpaVv8Ce7dv9W9RoCGHkRNk+KtmU+6fnYKsp/f8NeF8ZjoubsABWNcjMaVZtTwwsNaGP2ZXso0OxgCOTuEYBkwI5OZSWbUh0qAoDRmcE0NgaHVeb63CRvS8ibkXtxEKXti4K7ooyJiMANpezfKRr5fjoqRxBQoPlVZY3esYEI8O4ee0C6INk5oZ09p5dlOQXKUQauaazucD3UYuwRZS1Ul0MkhoTZ0jM6eHFiaA78Qx7Ti9lCupobn3VPDywK2H+taHVq5z76xOhnEaoEGgL1A9PMyFVO2A0YFk4vhC5Zy0vcV2KvkCnRcvzyU8y/Q163IuniowrnNdVZaCnlj5okEYA91WsSS7CrasxePs8HIFeYpo/UoNsnjTTNLwcBrU0ZrVMMLgB8nYvMgPXVt2hiS3xpeG0pH/gVS0uMJH9rPEI9un+5z71zHytxV+3LLZPBsKT2JTOJIwWzGRT69LeXWRZfZPexGAjYsIkZzNj1ziR1arRZ9a541vNnS+M04CyN8FXUGUYu/FsQhqn+97TGM6lcVJ3eMtKveKTyyXbE6qIH+B8IUs13qh/8VMs/oL5sU3zIJiI2tzJ+qwZTtK2n7Ewku9H28n04I1O8Xb70pSdksWZweyW20j9smtRF56Jsv/xtSWYjVVgplVXSzCRMp/sqt1A4mWQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MS9pc1h0S1cyU3VwYVlhaHA4NHlxaUJ1Und3T00xYlJaTTd1MXZiUm90b0tw?=
 =?utf-8?B?VEc4TFVjb0lFMFg1dkMyTWhIQVBDZC8rTXYzY1FMeWhzMHo1eEQrY3EzY3h3?=
 =?utf-8?B?NkplVVFqU093a0UwZzVDclpSQWRidUdJZm1BRHh3V25OUGNidzg0UEcwY1E3?=
 =?utf-8?B?KzVPMGwwR1h5N3R4OC9ZUG5yMlliNjJ2M0hsZ0ZmZFRrK2d0d1lpRDJndFRT?=
 =?utf-8?B?dFo4RmVOY3VxdEZERnNiQ09aeUVlZDdrOWIwdWJibGt3VmxzTEdOWEJHcXZu?=
 =?utf-8?B?bjJHK0JQbE1TVktOcU1yT3VYemxIR1Z3MFp1VUltOUNET0QxOUdPcDZEeXJD?=
 =?utf-8?B?RWVTMW1Hc1IvdFE5emtCYm0raWJDMmdqY1hjVmFBUmlMT3pxUzZaMEtvRVdm?=
 =?utf-8?B?WU1uK2lOL0ZsNlBjSm1pdlpjZEpDSW4wb2F1OGt4MzdUMEhuZWZQMUw2SFlo?=
 =?utf-8?B?YThINjBSQkJ2WngwcTJyWEgwWmR4Z3RERzZsT25yOThBSERDRTU4cjdLK2xx?=
 =?utf-8?B?c2R4WWNpelR1WVozRWxKd3FvWFVZbE03YVpOSjVVTU9CQUZRcXNRdUtlWnli?=
 =?utf-8?B?bCtraHg3NDFmeUFUTnNVTy9NNGNtU2xkM0prQXJ4anRLVktoK0QzTk9jazNE?=
 =?utf-8?B?QkpUalZZVlE1RkVadGtlWC80WmJvZldmczlsdEI5SXY1YmZHamI5OXZoOEk3?=
 =?utf-8?B?TjI5RThtOC9WOXRZR251TldIQm5iam0vajBoZXVBYVlvRVphKzRvY2RYMGEz?=
 =?utf-8?B?Ulp6VE03eDVUM1AxZFY2bXdUaVFBd0pNWi9pVW96elUyclczZFh6UE8vTzFI?=
 =?utf-8?B?KytxTnhscUppNTVIWXEvYngxQkl0cWRWSU9Nb1RHSHlWaVlmMGVyNldvZzZX?=
 =?utf-8?B?SllvT2tYOGJmQlJuMHBvVjVsQVJsR3pRZ2hhcGpwSU1ud3FRN2JCKy91cVlT?=
 =?utf-8?B?YkllV2hXeWdDYzZhS2IrcmJnZjRoakhQbVY3Szh5UEtEM0RjY1VYRDlNdmx1?=
 =?utf-8?B?WDdXb0tTV29tSC9TWmhpL1Z3aHViK3NzUlowcTE3QTd3eHFvd1F6b2o5NDNK?=
 =?utf-8?B?V3FUMjhUWGVpd2JqZDZKM3FoY1FqYVpVV2dkelJ0ek9GcnkrYndpTWs3bDZi?=
 =?utf-8?B?cmFWSmJBeGJVZkhadGFsUVRMeXZhMmtyRmFYL0xmRGRWMjdQclBnOHZLWVh2?=
 =?utf-8?B?UTcxY0tsYU5vLzFxc1dXeEZpT3hjck5OUmxaUmVDNjFWcXdTMG1LUWF6NVhN?=
 =?utf-8?B?MXJpVnR1RmVPZVVrL0ZhS2NxanNVTmZYUElENVNVTVFWcU5kSFBJWHcxckZQ?=
 =?utf-8?B?bGlENnVMRnBGTUk3bitBdGFXc1ptUzZKUGErcHZCblhuOEtvck1ta0ZLYk5y?=
 =?utf-8?B?eTl4b2FEclFvUHNMbFlNZ0RmUTgxZmZRaHZEVStXeWlCVFJlWE43TE51dVB4?=
 =?utf-8?B?clpIYmtEMzFuSHM0WDZRemRlb2hnYlVtTW9DS1RVME9MMnQxbWorbEYzNXhu?=
 =?utf-8?B?cUN0c28zWjBNQUI5MEZoTG1wSXR0VVE5R2IxcEplMGk5ckpPOFBJVUg4Q0ls?=
 =?utf-8?B?Q2wxL0VVNUVnc3Foamc2RkNYblVjR0xQeDFOU1FvK3NlK05tc0pkSGhWeldn?=
 =?utf-8?B?eHlaTFRCZ2plTnZsNXBFOEdpbU1SblZXdlVUWU9QWExFeDFUR1FZQWhvdmtR?=
 =?utf-8?B?RTJuNUxVNUlyRzZQcTZuVldjSmZKK3VFNmFLUmhzd2dVcitUek1ORGtZVlhL?=
 =?utf-8?Q?1F8A3Sy/28QRAHsaiLTWN8QtiVeNph1na/X6WSu?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5502.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7742ad-8de8-48cf-b6fd-08d98d580394
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:12:20.5306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMlT7DpuPIIZ/7NWMYZ6srJ49Ml+UHoCfg45WfDVtyrrv9lRKeGcVoPudnYV/ehm3oF1/mdSNZeLRs26HBcWf49fDF598kig/1oCcmZD3Fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3450
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SWM7uZ1SoA570GSLw5s5wVrpx4520388AA=
Content-Type: multipart/mixed; boundary="aVGgqBjTZTJkXVr5ezVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634026348;
 bh=wjm849dYLmDCyMwM23hF7wxq7NULRbmwjS9tTMOxIGA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=okTLHJi1NuDtjI49NIaz4RJvxgyEoFp8RPt3sUnDAK5Qlk+5RmRV1RByZxHY96XwAEr
 E1Bbuh/5nh/qZiQLdN9khjpuZLxFF1MeJ5lvsgpjRqhdGPRDHQ4mB+z+97C3c0Qba2fca
 B6Kwh5YtUvyd9TmQqQWoj59OQls8CSMOeV8=
Message-ID: <20211012081220.c97bRynQpWuZnimDBir2OShISJHtWsgA0bgwxWB3-DY@z>

--aVGgqBjTZTJkXVr5ezVR
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gVG95b29rYS1zYW4sDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgaW5mb3Jt
YXRpb24uDQpJIGNvbmZpcm1lZCB0aGF0IHRoZSBzYW1lIGlzc3VlIGhhcHBlbnMgaW4gRGViaWFu
IDggamVzc2llIGVudmlyb25tZW50DQphbmQgaXQgY2FuIGJlIHNvbHZlZCB3aXRoIHRoZSBsYXRl
c3QgcGFja2FnZXMgaW4gRUxUUyBbMF0uDQoNCkkgd2lsbCB1cGRhdGUgdGhlIHBhY2thZ2VzIGlu
IHRoZSBjb250YWluZXIgdXNlZCBmb3IgYnVpbGRpbmcgY2lwLWNvcmUvZGVieSBpbWFnZXMuDQoN
ClswXSBodHRwczovL2dpdGh1Yi5jb20vbWV0YS1kZWJpYW4vbWV0YS1kZWJpYW4vY29tbWl0LzE5
ZTAwYWU1OTY0YzI2OTFiMzVhOWYyZjljNDk3MTM1MDA3ZjZjZWENCg0KQmVzdCByZWdhcmRzLA0K
S2F6dQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVo
YWxmIE9mIEhpcmFrdSBUb3lvb2thDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDcsIDIwMjEg
NDo1MyBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDog
UmU6IFtjaXAtZGV2XSBkZWJ5OiBObyBjZXJ0aWZpY2F0ZSBmb3IgaHR0cHM6Ly9naXQueW9jdG9w
cm9qZWN0Lm9yZw0KPiANCj4gSGkgS2F6dSwNCj4gDQo+IFRoaXMgc2VlbXMgdG8gYmUgcmVsYXRl
ZCB0byByZWNlbnQgTGV0J3MgRW5jcnlwdCBjaGFuZ2VzLg0KPiBQbGVhc2Ugc2VlIG15IGNvbW1l
bnRzIG9uIHRoZSBpc3N1ZS4NCj4gDQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9j
aXAtY29yZS9kZWJ5Ly0vaXNzdWVzLzE1DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEhpcmFrdSBU
b3lvb2thDQo+IA0KPiBPbiBUaHUsIE9jdCA3LCAyMDIxIGF0IDI6MDggUE0gS2F6dWhpcm8gSGF5
YXNoaQ0KPiA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5jby5qcD4gd3JvdGU6DQo+ID4NCj4g
PiBIaSwNCj4gPg0KPiA+IEluIGRlYnkgQ0ksIGNsb25pbmcgcmVwb3NpdG9yaWVzIGZyb20gaHR0
cHM6Ly9naXQueW9jdG9wcm9qZWN0Lm9yZyBpcyBub3cgZmFpbGluZyAoZm9yIGEgZGV2ZWxvcG1l
bnQgYnJhbmNoKToNCj4gPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUv
ZGVieS8tL2lzc3Vlcy8xNQ0KPiA+DQo+ID4gSXQgd2FzIHdvcmtpbmcgb24gQXByIDEzLCAyMDIx
Lg0KPiA+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9kZWJ5Ly0vam9i
cy8xMTcyNDI1MDc1DQo+ID4NCj4gPiBEbyBBbnlvbmUga25vdyBpZiB0aGVyZSBhcmUgYW55IGNo
YW5nZXMgaW4gY2VydGZpY2F0ZXMgaW4gdGhlIGNvbnRhaW5lcnM/DQo+ID4NCj4gPiBCZXN0IHJl
Z2FyZHMsDQo+ID4gS2F6dQ0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+IA0KPiANCj4gLS0NCj4gSGly
YWt1IFRveW9va2ENCj4gQ3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg==


--aVGgqBjTZTJkXVr5ezVR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6806): https://lists.cip-project.org/g/cip-dev/message/=
6806
Mute This Topic: https://lists.cip-project.org/mt/86138478/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--aVGgqBjTZTJkXVr5ezVR--
