Return-Path: <SRS0=RNk9=CE=lists.cip-project.org=bounce+64572+5252+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B519C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 01:18:31 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA4D20737
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 01:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cnP7hWja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA4D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5252+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VN4MYY4521723x5gDdXZEStE; Tue, 25 Aug 2020 18:18:30 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.3483.1598404707331779521
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 18:18:28 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 07Q1IO79002920; Wed, 26 Aug 2020 10:18:24 +0900
X-Iguazu-Qid: 34tKSwRU8rJwW1w4e0
X-Iguazu-QSIG: v=2; s=0; t=1598404704; q=34tKSwRU8rJwW1w4e0; m=oWpz7oHGCfUqyaRfmkXFSm6e61TKPwR0CHrw2HE/y9E=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 07Q1INaG018392;
	Wed, 26 Aug 2020 10:18:24 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 07Q1INsS005202
	for <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2020 10:18:23 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 07Q1INL4017760
	for <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2020 10:18:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+lDi8R0mu3YSzWE82CbWXBCrOcdMB9JariS4sTHeAlAf3vzhFQ0yu8IGYxc0VcIfWuclOen9B6y4p7PghMhln0lyjfUFZnU7kY7sbvpuZasjy+cIi+PkxF9uHD2q9iklMhXQTEFgdMPE7CtDNzfJpBPMOCo7JU/65foYUf1fywDQM7VXRn2KlKDlfuEfERJr1x0KY6YvoTrNRdt9P3nV17gAmmAX2yO/93mRYAadn+7YMkXeBNOi6rgDVAr1MZZ/GBGqkzEHoOpVMphsSB3kRrHAb3zefeZL1AA4X6oiMQV70FPBZcQcLTjHAJcYzB5g+ZcAzxeg6xgWoZdZ4N7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPBPHSH8u+hGoufv1RWJhPu5/qW9VRT7UaR3fnPSSjE=;
 b=RZgYcxClfzbJvvMSqZQ6qFvNZtyI7m/lyh7rHmhhg5Doj5g312fj6Q8kY3TWRZ606fVkfJOCU9c6TnJeJq1yNPEmL5+u65lkn6ahoaYSNJqG51qTB7iXkaEznL1HR6dwNKTdomLHDbsrRbjMFwM31bW2hXh6JMXP+KLZ2A5SOi05rLyWMsZaiLeH+vmgEjEfQvGH7IpEk2KFCMG2Bwf177L8h0/5ezlbC/K7nhtPHyTpOm0Jn5428ieBzsd6xsDcibM40+DCwue9B1UFYiogH5VzbxO43SrS598uAxOmff9/xIQMdUE5nv5kTSNfJWlR0mTbV3OglWsskx9WCJMnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
Thread-Index: AQHWdstrqupfwJHHTUq10neeZGUu7qlCq0mAgAAb2ICAA5IEMIACAv+AgAFC5RA=
Date: Wed, 26 Aug 2020 01:18:20 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983301A51054F67C4866A9892540@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <4f1fd7b8-4fc0-714b-8205-e6a6b93929d8@siemens.com>
 <997dba20-23b6-a170-6a89-b6a894b13e69@siemens.com>
 <OSBPR01MB2983B674E98AC8D3B5B960E092570@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <77b391e2-3438-88dd-3df6-b9d8e9c37420@siemens.com>
In-Reply-To: <77b391e2-3438-88dd-3df6-b9d8e9c37420@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d5c14fa-0880-4d36-bbfd-08d8495debab
x-ms-traffictypediagnostic: OSYPR01MB5301:
x-microsoft-antispam-prvs: <OSYPR01MB5301CA83410EC99B104D3D2492540@OSYPR01MB5301.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D8lyeNl2UhQzOR/fye+8fqjyS2cdCmM2ZgPTqxjXN32j0igvPdfmyHSDgXfb1E1XN3wdRsldQj5YmFf1jz+Cczq/njCLmH/m+dahevQmX9A1s4B1pJ0U+x9S7TsgReywH/PnRRcglExPBUvBysAArvKwaLt6p37Lm1YksEMXWfhPHmHjMdIBeJHR8+z8gwOk62P78NUPgv/DgHqTEcSKrC++t5squHeqDtEHbMyBtUCS12+q8acHMrLYbdKXIJeNA1R7Cf62dDqdgbklxm0Hmaj4snSDdtM91E0MCZgrexeFu6sVxpmhB4ha2IX7dDR+IKvoLFSdhsVT1egHr4ToPlHTjBAwwLFEU+4brHu0P7zIHo4+ZOFyFOursIKGPatPkR39WUyngLNYlS4jwo+YMg==
x-ms-exchange-antispam-messagedata: VY9KpT80qpzaWlkPLtuIRCIpB6vX75PIhR7rocg2lG/glJi/1hbCY9Rdweok/XY+wL/b4jZJrutC+albn9EAiGB5Gg3zN/HsRdQmRilyRe4yffk8PL+u1YLFL/XEnHEI+UOgJ1INrLjAO0/yDGS7Xg73CyLDDeJ4HhWu5fMBZBefOGNuNWxNLjKFm93y+/3YSzw3bvehcWZ56DYZ5ZwgzVK/q228d1rcbxnuycbWkLfckQfuKPhbKxXvL/caBFhJ+y20pzhK9gHU55/W2ut6ivQQBX6by08lZQOorsH9xReldG/F9Y3rQyniCGbi5Oh44A7vqrcGMTK/tSGP4lntGzQjW2g6zsx4PD3S+mV8qctw5WnXcW+Y5uKdSXycyaMGbr6o48soFGS+EIun6EhwG+C/CcNawVYJEEm5f6WOtCimay6Ym474wwJuCu6svZeP91GplHaAaFKw4D3lUtfzJHn3vfJk+IWNzI0LRDZmuMpFQmdmKS1q0a87dMQclLvD/l34vbnTOeX4UrpWh5pQBxB2Gas4gRDkvG3MSJGd7b8PxDgoaxJF1dtP6t0dlU9i05vSt/cc/vLs1Zq26FkCocjiqUpqiWrtv/Lw3xXUPCyS8dmzHfLQoqgzlZV+okfnlhsR6HtPociSv8CmzjQOew==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5c14fa-0880-4d36-bbfd-08d8495debab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 01:18:20.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKrdY3EVR+7+rynfGJcCCAsntguM938icDc2RU5XE0ZH3DQzn9HlYTFXRZjKNp71D0YZybzFNabNcfoVSXc1drBMYAy7izsoLlCjockpchCYLCLaLBnsX0WhRFa8iqkl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5301
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 183jClSRUbQqWlB8znVr7jWkx4520388AA=
Content-Type: multipart/mixed; boundary="H9X4a6nK33oSPpCBRQTr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598404710;
 bh=XHSyzHCRZ2av0TMEL5653q0lPbJZFeVNx3nJK/U6IIk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cnP7hWjaOxQJe4/KZpjgf1tjfn4HzL0/SO5rqUmKNJK4Gwi7KnznlNGrh8d2SyOy6fw
 Sk5hgdvxh3lJ3c6zQivX7aU1O0PREEUS8BBQ2vbTDRzh7FjXXkgXeGMbLQ88KcdLGy1Up
 pP+DYdKEYY8ewgRQH1EUSvxVINgepUqj/XY=

--H9X4a6nK33oSPpCBRQTr
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDI1LCAyMDIw
IDI6NTkgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y3
77yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtpc2Fy
LWNpcC1jb3JlXVtQQVRDSCAxLzJdIGNpOiBSZXdyaXRlIHVzaW5nIGV4dGVuZHMNCj4gDQo+IE9u
IDI1LjA4LjIwIDA3OjMzLCBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcCB3cm90ZToN
Cj4gPiBIaSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBKYW4gS2lzemthIFttYWlsdG86amFuLmtpc3prYUBzaWVtZW5zLmNvbV0NCj4gPj4gU2VudDog
U2F0dXJkYXksIEF1Z3VzdCAyMiwgMjAyMCAxOjQ1IEFNDQo+ID4+IFRvOiBpd2FtYXRzdSBub2J1
aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5p
d2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsNCj4gY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
Cj4gPj4gU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAxLzJdIGNpOiBSZXdyaXRl
IHVzaW5nIGV4dGVuZHMNCj4gPj4NCj4gPj4gT24gMjEuMDguMjAgMTc6MDQsIEphbiBLaXN6a2Eg
d3JvdGU6DQo+ID4+PiBPbiAyMC4wOC4yMCAxMDoyNCwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6
DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2Ft
YXRzdUB0b3NoaWJhLmNvLmpwPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICAuZ2l0bGFiLWNpLnltbCAg
ICAgICAgICAgICB8IDcwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+
ID4+Pj4gIHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoIHwgIDggKysrLS0NCj4gPj4+PiAgMiBm
aWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IDxzbmlwPg0KPiA+DQo+ID4+Pj4gLWlmIFsgLW4gIiREVEIiIF07IHRoZW4NCj4gPj4+PiAraWYg
WyAiJERUQiIgIT0gIm5vbmUiIF07IHRoZW4NCj4gPj4+PiAgCWF3cyBzMyBjcCAtLW5vLXByb2dy
ZXNzDQo+ID4+IGJ1aWxkL3RtcC93b3JrL2NpcC1jb3JlLSovbGludXgtY2lwKi8qL2xpbnV4LWNp
cC0qL2RlYmlhbi9saW51eC1pbWFnZS1jaXAqL3Vzci9saWIvbGludXgtaW1hZ2UtKi8kRFRCDQo+
ID4+IHMzOi8vZG93bmxvYWQuY2lwLXByb2plY3Qub3JnL2NpcC1jb3JlLyRUQVJHRVQvDQo+ID4+
Pj4gIGZpDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBVbmZvcnR1bmF0ZWx5LCB0aGlzIHNjYWxlIG91
dCB0byBtdWx0aXBsZSBqb2JzIHNlZW0gdG8gY2F1c2UgZG93bmxvYWQNCj4gPj4+IGlzc3Vlcywg
c2VlIGUuZy4NCj4gPj4+DQo+ID4+PiAtIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9j
aXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vam9icy82OTc4NDQyNzYNCj4gPj4+IC0gaHR0cHM6Ly9n
aXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzY5Njk0
NjY0OQ0KPiA+Pj4NCj4gPj4+IEZpcnN0IHRob3VnaHQgaXQgd2FzIGEgc3BvcmFkaWMgaGljLXVw
LCBidXQgaXQgcmVvY2N1cnMsIG5vdyB3aXRoDQo+ID4+PiBtYXN0ZXIuIElzIGtlcm5lbC5vcmcg
dGhyb3R0bGluZyB1cyBoZXJlPw0KPiA+Pj4NCj4gPg0KPiA+IFRoaXMgbWF5IGJlIGEgYnVyZGVu
IG9uIGtlcm5lbC5vcmcgYXMgc25hcHNob3QgcmVjb25zdHJ1Y3RzIHRoZSBpbWFnZQ0KPiA+IG9u
IHRoZSBzZXJ2ZXIgc2lkZS4gSSdtIG5vdCBzdXJlLCB3aGVuIGRvd25sb2FkaW5nIGltYWdlcyBj
b250aW51b3VzbHksDQo+ID4gYWNjZXNzIG1heSBiZSBjb250cm9sbGVkIGJ5IGtlcm5lbC5vcmcu
DQo+ID4NCj4gDQo+IFNvIHdlIG5lZWQgdG8gYXZvaWQgdGhhdCBmb3Igbm93LCBJIGd1ZXNzLiBC
YWNrIHRvIHNpbmdsZS1qb2IgYnVpbGQsIG9yDQo+IGRvIHdlIGhhdmUgYW4gYWx0ZXJuYXRpdmUg
ZG93bmxvYWQgc291cmNlPw0KDQpPSywgYmVjYXVzZSBJIGRvbid0IGtub3cgYW55IG90aGVyIGdv
b2QgZG93bmxvYWQgc291cmNlLCBJIHdpbGwgY2hhbmdlIHRvIHNpbmdsZSBqb2IuDQoNCj4gDQo+
ID4+DQo+ID4+IEFuZCBJJ20gYWZyYWlkIHRoZXJlIGlzIG1vcmUgYnJva2VuLCBuYW1lbHkgaW4g
dGhlIGRlcGxveW1lbnQgdGhhdCBpcw0KPiA+PiBvbmx5IHRyaWdnZXJlZCBvdmVyIG1hc3Rlci4g
UGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoZSBmYWlsaW5nIGpvYnMuDQo+ID4NCj4gPiBJIGRvbid0
IGhhdmUgbm8gaWRlYSBhYm91dCB0aGlzLg0KPiA+IElmIHdlIHJldHJ5IHRoZSB0ZXN0LCBpdCBp
cyBzdWNjZXNzZnVsIGFuZCB0aGVyZSBtYXkgYmUgb3RoZXIgY2F1c2VzLg0KPiA+DQo+IA0KPiBU
aGUgd2ljIGltYWdlIG5hbWVzIGNoYW5nZWQsIGFuZCB0aGF0IGJyb2tlIGNvbXByZXNzaW9uIGFu
ZCB1cGxvYWRpbmcuDQo+IA0KDQpPSywgSSB3aWxsIGZpeCB0aGlzIGFzIHdlbGwuDQoNCj4gSmFu
DQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg==

--H9X4a6nK33oSPpCBRQTr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5252): https://lists.cip-project.org/g/cip-dev/message=
/5252
Mute This Topic: https://lists.cip-project.org/mt/76304024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--H9X4a6nK33oSPpCBRQTr--
