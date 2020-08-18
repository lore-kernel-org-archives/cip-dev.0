Return-Path: <SRS0=05f6=B4=lists.cip-project.org=bounce+64572+5131+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC08C433E1
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 13:48:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC10A207D3
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 13:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SI6hWRQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC10A207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5131+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LcRrYY4521723xWbLF0SJJeI; Tue, 18 Aug 2020 06:48:08 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.66623.1597758485250458844
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 06:48:06 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07IDm3Xq025346; Tue, 18 Aug 2020 22:48:03 +0900
X-Iguazu-Qid: 34tMJPQphY05A6T2lV
X-Iguazu-QSIG: v=2; s=0; t=1597758482; q=34tMJPQphY05A6T2lV; m=iD7dw8VblWkOzfGONFPaW0VQiEpwlhI6oXh/1JjwGMA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 07IDm285025720;
	Tue, 18 Aug 2020 22:48:02 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 07IDm1kX019083;
	Tue, 18 Aug 2020 22:48:01 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 07IDm1ZD025068;
	Tue, 18 Aug 2020 22:48:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U31nVIkXzukiDINNFIqdMAPjlkLQZOiIrsSormEzTJsyslCKukCe56JY/V+21QEZHJjF/15PHI0TpXjm4wEY13RMWc+W3xb8fpE+jSqtLNOoBeGJlPbB247I0OyvuWCGt9XUu/hZmVJo5jt6/tvKSzDi8eU+Yl7FevVy33B6QGEAZJyMBUoKA46TR0dTHuO1J9/F0wfkQw6vgQ/PfvQEh27FstOCL6HqW8RaUQ4m08+yHl/MMzk14DZLCja5JQcXlHJklqh4zdBDfV1OYKoWJAbPBr/aDOtfeHmKbaRi1E/bL+GiJLTCnafenkBow3HebcbMTjc4NI2mH7AdAG4rcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH6VJ1i1j3KCV3a15klHeuLiwBzkL8cMgT8SVcxw0GI=;
 b=Lc6DTv6Jzq7wJEFhw+yS/OFdzkXUoqpoq8IqSpaoIgnB9ZWmu9RdJJwBs34pCH0Bo3A632Fi0H2I5PxgF7aiQtixzjxElWPb1hJ+5FF1pHsQ7NIhV4cw3wo4ThZQije/aId+Rki8Hw9xHSB0V6WeOGlCFJjvZ9TIVf+SIWjCfscnN47yz4Xou0oriSRVOMeeWVqVjreDhLN3k87MSKydcKF6jzXUU1EmZfXYBVbEUUEgBO+di19E7ijTKC2wdwIdALjB7rhGFVyjIbwvB1QDiG6uH8pH5QvDJVvk1UD1zx3qf83f7Y+S0Nk4o7miKXLcRctVNxj79p+63a+juDwQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add recipe
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add
 recipe
Thread-Index: AQHWama7Of7RBEN/RES+OIG1P/Dsiak9YsAwgAAJkoCAAIpqcA==
Date: Tue, 18 Aug 2020 13:47:51 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983367B30C868D82CA6B7AE925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <16281511DE955BB5.19258@lists.cip-project.org>
 <OSBPR01MB298327233BFADC291456E190925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <b2289205-5f7e-9f57-ba0a-496a4c8749b3@siemens.com>
In-Reply-To: <b2289205-5f7e-9f57-ba0a-496a4c8749b3@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54ced4eb-6a87-443e-8e7e-08d8437d4d3f
x-ms-traffictypediagnostic: OSAPR01MB4995:
x-microsoft-antispam-prvs: <OSAPR01MB4995CBA1E2F14D120A43E876925C0@OSAPR01MB4995.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iebt8FtXN6OmhUWsZ+luHSuqn5zq3OJgG446XBKDzEdlfeSWi4W4i8tt4IaZHZfcCJCI2PqIrsPdHsxNPiuzXqNvqPVG7zxCbPI323eNXUzmx/UAsdK7HUVDMd6iwnddiRKbJh6FS069mG0bfIdFEMtr5uP8Pb7AtRqkFihQdrxtzV7xEnHVUQldmrCLEtVj/pX0+CcZfbLkJ9qnNtFvzTfDDqYQK+znT2IyGGeos9P1g2q1FSS/193fpZoMOiRU/MSvohIWCCq1+XAc5rrnecTA46MFtnUjWhwvzhlgP47hJrFVz8BAEqnzRlrAyD/+y/ykrLy3NlNW2InRuC+z25j6LdbQvN68SvFKoUiyGANIe6XObZmidfxnqRxd17IGdl2oskG1idNaWmilDLTcOQ==
x-ms-exchange-antispam-messagedata: UFMuZpKIX5Elub4rlwdK17QNjr7jPNdhKH773EsRTnxgwsShFZIvH2Z9l4HRI8QsvXqpEGpmQE1eez9YjHxJkilyw4OkhMUQO8FngeCj20mm3XaoDSUl4F6lSThQwSlEKAA1A66hDanFm+ISh66MgC7S99oQvfJ+3aST826GUBgrffL6eVmdj3d/MzY7KWSzeEXeLiGvqPIo6lfCJRlkNJnf89T0+WfBVUFMz0CGUPRbiRV4YDYXZg/ivaeVqsgahqTbjMaLUNpOHhc6qgfU08lxxv3e2MHKEhWtknUTiy5NCfWpR7ZVXtSeEX7z0JXVI8h/STDdzn8+IYrET/DHwVnGvOeWYcrNoHjFaT9AtRImvozOxh10BFovI2KduMmp5GIO0d3gss2IGjX2n+Vz41292oh4BEZTTDp00X0LDW1V7cFfh9UKRrGSwdcz/GFBbnGYGt90kwoXWrAx4/aujZnobqpJH1IR+WXD7AEz6dzcoNSddERKEtnzAM+BYlhTJD8dTvannm35qKiYNoxiG1l3MeqWdLdUYGH+ZoVFd7D3lgBCjmomR72T1WcvtVG9tpAUQBnpbUAIYA6YFROt6x0LPaIQiqZE6AE+THcS7CHb3XHO7yyRMHtL4A59xggorf+o1snQyjLC+DoAardF6g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ced4eb-6a87-443e-8e7e-08d8437d4d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 13:47:51.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAsbqFNh2UKpGj1BT1bnf4lqLq07FKn5l8toIuvMVr4Hi0YxdZ75HCie13PWYW9zcbwNzEzNtCGz4ZT5GqdoKICpRRnpnTLC5empkPCFHrntM0vrxzEGSC5/lccx+BtO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4995
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: W9gJT5xO8CC0rlJa3ej2TTXjx4520388AA=
Content-Type: multipart/mixed; boundary="uMPbk6qJQhy3IGLNKT5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597758488;
 bh=iCEwmRj25Cw7g6mWoww0ZOEOheBa4HkKtaba71aRAz4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=SI6hWRQlWeJOBMmiBFN6Gxkw0Dzp0Luv0H8BPLX1cZLt6gITSAfCK7xA3GMrROhcNz9
 URI5F0HIVQB1tPzKhKvJHq4n/teyNDsZURQGm8lEH0iuUWE7FwZbC0N87EAjA4Y4C8U/u
 M8KZDDLXnnSFq5sMkWyZkhNzyyVoizgAMig=

--uMPbk6qJQhy3IGLNKT5Q
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSBb
bWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAx
OCwgMjAyMCAyOjMwIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdh
bWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2
XSBbaXNhci1jaXAtY29yZV1bUEFUQ0ggMS8zXSBjaXAtY29yZS1pbWFnZS10ZXN0OiBBZGQgcmVj
aXBlDQo+IA0KPiBPbiAxOC4wOC4yMCAwNjo1NywgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+
ID4gSGkgSmFuLA0KPiA+DQo+ID4gQ291bGQgeW91IGNvbW1lbnQgb24gdGhpcyBwYXRjaCBzZXJp
ZXM/DQo+ID4NCj4gDQo+IEFoLCB5ZWFoLCBzb3JyeS4NCj4gDQo+IEkgdGhpbmsgbm93IGl0J3Mg
YmV0dGVyIHRvIG1vZGVsIHRoYXQgYXMgZXh0ZW5zaW9uIG9mIGFuIGltYWdlLCBnaXZlbg0KPiB0
aGF0IHdlIGFscmVhZHkgaGF2ZSB0d28gKHJlZ3VsYXIgKyBzZWN1cml0eSkuIE9yIHdpbGwgd2Ug
aW1wbGljaXRseQ0KPiB0ZXN0IHRoZSBzZWN1cml0eSBpbWFnZSB2aWEgdGhlIHJlZ3VsYXIgb25l
Pw0KPiANCg0KSSBzZWUuDQpXaGVuIGV4dGVuZGVkLCB0aGUgcmVzdWx0aW5nIGltYWdlIHdpbGwg
aGF2ZSB0aGUgc2FtZSBmaWxlbmFtZSBhcyB0aGUgYmFzZS4NCkl0J3MgZGlmZmljdWx0IHRvIGRp
c3Rpbmd1aXNoLCBzbyBpdCdzIGltcGxlbWVudGVkIGFzIGl0IGlzIG5vdy4NCklmIHlvdSBrbm93
IGhvdyB0byBjaGFuZ2UgdGhlIGdlbmVyYXRlZCBpbWFnZSBmaWxlIG5hbWUgYnkgeWFtbCBmaWxl
LCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCj4gSmFuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhp
cm8NCg0KPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gIE5vYnVoaXJvDQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxm
IE9mIE5vYnVoaXJvIEl3YW1hdHN1DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA0LCAyMDIw
IDEwOjU0IFBNDQo+ID4+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+PiBD
YzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPv
vLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gPj4gU3ViamVjdDogW2Np
cC1kZXZdIFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAxLzNdIGNpcC1jb3JlLWltYWdlLXRlc3Q6IEFk
ZCByZWNpcGUNCj4gPj4NCj4gPj4gVGhpcyByZWNpcGUgcHJvdmlkZXMgYW4gaW1hZ2UgZm9yIHRl
c3RpbmcuDQo+ID4+IElmIHVzZSB0aGlzLCBpdCB3aWxsIGNyZWF0ZSBhbiBpbWFnZSBjb250YWlu
aW5nIExUUChsdHAtZnVsbCksIHJ0LXRlc3RzIGFuZCBzdHJlc3MtbmcuDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IE5vYnVoaXJvIEl3YW1hdHN1IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGli
YS5jby5qcD4NCj4gPj4gLS0tDQo+ID4+ICByZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWlt
YWdlLXRlc3QuYmIgfCAxOCArKysrKysrKysrKysrKysrKysNCj4gPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxOCBpbnNlcnRpb25zKCspDQo+ID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgcmVjaXBlcy1jb3Jl
L2ltYWdlcy9jaXAtY29yZS1pbWFnZS10ZXN0LmJiDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9y
ZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLXRlc3QuYmIgYi9yZWNpcGVzLWNvcmUv
aW1hZ2VzL2NpcC1jb3JlLWltYWdlLXRlc3QuYmINCj4gPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPj4gaW5kZXggMDAwMDAwMC4uZTJiMTVmYw0KPiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsr
KyBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2UtdGVzdC5iYg0KPiA+PiBAQCAt
MCwwICsxLDE4IEBADQo+ID4+ICsjDQo+ID4+ICsjIENJUCBDb3JlLCBnZW5lcmljIHByb2ZpbGUN
Cj4gPj4gKyMNCj4gPj4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFHLCAyMDE5DQo+ID4+ICsj
DQo+ID4+ICsjIEF1dGhvcnM6DQo+ID4+ICsjICBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1l
bnMuY29tPg0KPiA+PiArIw0KPiA+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+
ID4+ICsjDQo+ID4+ICsjDQo+ID4+ICtpbmhlcml0IGRwa2ctcmF3DQo+ID4+ICtyZXF1aXJlIGNp
cC1jb3JlLWltYWdlLmJiDQo+ID4+ICsNCj4gPj4gK0RFU0NSSVBUSU9OID0gIkNJUCBDb3JlIGlt
YWdlIGluY2x1ZGluZyB0ZXN0IHBhY2thZ2VzIg0KPiA+PiArDQo+ID4+ICtJTUFHRV9JTlNUQUxM
ICs9ICJsdHAtZnVsbCINCj4gPj4gK0RFQklBTl9ERVBFTkRTICs9ICJydC10ZXN0cywgc3RyZXNz
LW5nIg0KPiA+PiAtLQ0KPiA+PiAyLjI3LjANCj4gPg0KPiA+DQo+ID4gDQo+ID4NCj4gDQo+IC0t
DQo+IFNpZW1lbnMgQUcsIENvcnBvcmF0ZSBUZWNobm9sb2d5LCBDVCBSREEgSU9UIFNFUy1ERQ0K
PiBDb3Jwb3JhdGUgQ29tcGV0ZW5jZSBDZW50ZXIgRW1iZWRkZWQgTGludXgNCg==

--uMPbk6qJQhy3IGLNKT5Q
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5131): https://lists.cip-project.org/g/cip-dev/message=
/5131
Mute This Topic: https://lists.cip-project.org/mt/75987091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--uMPbk6qJQhy3IGLNKT5Q--
