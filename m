Return-Path: <SRS0=buwH=DO=lists.cip-project.org=bounce+64572+5502+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE798C4363C
	for <cip-dev@archiver.kernel.org>; Wed,  7 Oct 2020 05:56:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD56120B1F
	for <cip-dev@archiver.kernel.org>; Wed,  7 Oct 2020 05:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fP+JXgoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD56120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5502+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y9zLYY4521723xpL6jZB1uCf; Tue, 06 Oct 2020 22:56:54 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.6834.1602050211490656612
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2020 22:56:53 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0975uNns031255; Wed, 7 Oct 2020 14:56:23 +0900
X-Iguazu-Qid: 2wHHOqOUeWxYGaTy78
X-Iguazu-QSIG: v=2; s=0; t=1602050182; q=2wHHOqOUeWxYGaTy78; m=Yt04C2wdnqEpdtBbiweVxWuzkGFRx/uOQ5yIEO0+4rA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 0975uKi8014119;
	Wed, 7 Oct 2020 14:56:21 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0975uKa1019695;
	Wed, 7 Oct 2020 14:56:20 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0975uKl9032012;
	Wed, 7 Oct 2020 14:56:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCSPF3fDT3cYsuXcBKRpFEL3dhpb0aVkESJqpt/eCfWlvUXQAY/vcEsloCi+QtnwYAyKMU8ppargQwoRtoelWP3I1xrBZap4jfZd8RRUqXm6eDatv4vwm9qJJlsmQyVX3LX5Gt++/nk3IiP/RSmmmHxxE5U1FqrtRhLSwYWsySLOlyCJF8HdlCB/YLAX5JIlNpTQSCcnOWbRPM3rBHjfu6qlP7Rdl7m5WFLx7D0YDYpFV2otugeju+5NDOFjxmOrxdy2k2Gu6AlvPjrQJjNOdXnCPOwtcU9nb1XyU4kRlMUkaAkU+/uSUJ9Z6lLhTtiZZq5+Qk8WQUE2rqFMM06tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51CVMOpSJx9Flw0MJp9a6VK57ZdeQtP613xOtRyl5/o=;
 b=FhgtaMpXTdOdTSLUaTZawYUMkWLkkTqeYx2Ow6v3in2NLKVvg5oGVfqgocLsPTDEOEIqphnvSpnP9gdUMnTHH0pBpwo0Ryd6FtHt/JBqX+D4QGzGT+wMqLe8gLwdpIMu4VUvEr5jnh9KUSolsHZof0O4Djlxxyj2aUfic19rCAFtufDlhgY5TCXrQ9CuEO+9g7XqlcKZE76EpGCkbTBZBNBDMqSR2AT7RZRB5WBSmD0lH26cjoBVFSWJPxWRnShnAdS8UgPILwfvTHM5MsPbGyzPrMr6e+aBwoTzYc5tzVzqrLluFkeJIsKEPvGckcBctSEjj02sAmnuHgFGCX+kUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <ben.hutchings@codethink.co.uk>, <sz.lin@moxa.com>, <wens@csie.org>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [cip-kernel-sec] reports: add script to convert reports to csv format
Thread-Topic: [cip-kernel-sec] reports: add script to convert reports to csv
 format
Thread-Index: AQHWnCeW10jK2EAi00i+2mqbs8i/PamLo1sg
Date: Wed, 7 Oct 2020 05:56:18 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB205396C4BC68DD9166A449A6D00A0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200925050756.1960978-1-daniel.sangorrin@toshiba.co.jp>
	 <20200925050756.1960978-2-daniel.sangorrin@toshiba.co.jp>
 <5ed0afedad32a65488c6ae6184560bd6d02b37b5.camel@codethink.co.uk>
In-Reply-To: <5ed0afedad32a65488c6ae6184560bd6d02b37b5.camel@codethink.co.uk>
Accept-Language: en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 343736db-c2d0-4073-6292-08d86a85b5d9
x-ms-traffictypediagnostic: OSBPR01MB5157:
x-microsoft-antispam-prvs: <OSBPR01MB51579C429AE172814D7BC5E1D00A0@OSBPR01MB5157.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lD7EZcn2nLLIMrToTiyWo4EJRkfDO4FUD3eLx6c0UpLVFjBEpndMucyOzBAMDPppq3WozOKg5OqzDbffXZ5exujXuhX6PWNnJONUM6e4Zf2ZU7HxL+vQsvbK/2YPY2IZEYDbAKgcGNE+V4+0yApZWsq5c6OV++ACh/lCArHiXHpBgvJHSHwich2AmVaYMlDkjrhTDiVfmOHlOj67yrng5MAjWQryrRAIASrSARcZsbgobFPTE38QZ2ZwIiQ3Yv40LoNJWKwpxcujact7mxCuE5RBh6IKM4XAZpYt8dtoLYOs8vEbJVtIdXS0MgL9vs0AgBEEBmpt/1JqPSJLijHgCrU2xZtu00xDwADirMNLbCWR4snmX5lzCFOuQqaW+3+IaSmmz11nUpQpdXwgrZUJKA==
x-ms-exchange-antispam-messagedata: Qh1Qjp9IYYTzd6E1CnUwFzB2feLg7yL8TcvDxtd7QxRk589TZmIUdlpjAoP09h1v4r07C1FUX+oFf6VtXgLIX49r2MSdEjbGq3O53oG9m/fPE3y34IHm3mvCEFj4xQSFK8bRdfs+uRj3ISJIN33EtvgVb4wWsGROhYSx7S4f5WCT58ooOiT2van5HivqjXZWW1Llb9cRs4qkAgkfI6i/k2spD3H4w69iZWsY7MhS4gHuoik9MQO4cRGAgVai2hF5XTMFUxUsXabJYMDj9uaGCFGC+cAvGAdFWw26UsJFBdXICx2vdJpwQHcSA055mEJ05XzU6UV7qBwkx0CM0ZlpXKCK7zjVldapE4T+5tY3eBMKQ5HltOw/1DtOrHZQZUB3A70h27upTlhtbTZEe4zqFy2u00XA9gWovl6QiqD9ltjfEm+YCI6gZXL0dQP/S9ILBoiNptdBjKBSKUD4bBAKnxwA3LHGmkl9A/HeshpdZoE7b3S+1rd1MyVoovLLJKUuW650z3gsln7Hh5+tc0jPyB+kFdAwXzMjqqWre5BF0nKnt52i8Ft/bF1Z6Vp7BveX4xywYYdwNAEqij1ElraqLG7zYr7qymsbt5ycF7aXGKXZLSkkFA3cbn/clLx5eYxHAvIcKWxkGAtlL0EucX39pQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343736db-c2d0-4073-6292-08d86a85b5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 05:56:18.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EdoJcTnnCQFpzMS/QQeBSDyMuB8LbgqB/bOxxS5DvaQl0oYTEQk5jQnfmmBe2VksGyJ73GFp9tqIsNRu8ftJAs/Q0DaaOf6PF8ItO9y+ncs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5157
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jDSVZkXIIZUPNpXsAzPBtHF3x4520388AA=
Content-Type: multipart/mixed; boundary="bxpsBmBocjMrlKna7zod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602050214;
 bh=yw5eddgAOIhhRXdkvQHQIuifYZJyb/7iOBxNc388QWw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=fP+JXgojXpBb1iYXlYRf7zgGFyb8uOSuszJXjEEUB9zi/nRGXOfd5g3JfvegDYCVZg9
 hxk0TXIZBUDV2R/EZOKUf3mBiJwRLM6lZIqTv/9IaIl6QHJoDGa63LoEnLmrGtUQ3iZRU
 kfQOSkMztSttJ4LvEpQf6Ps4JNCLIcZFzfY=

--bxpsBmBocjMrlKna7zod
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gQmVuLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IGFuZCBzb3JyeSBmb3Ig
dGFraW5nIHlvdXIgdGltZS4NCldlIHdpbGwgaGF2ZSBhbiBpbnRlcm5hbCByZXZpZXcgYW5kIHRh
a2UgeW91ciBjb21tZW50cyBpbnRvIGFjY291bnQgdG8gcHJlcGFyZSBhIG5ldyBwcm9wb3NhbC4N
Cg0KS2luZCByZWdhcmRzLA0KRGFuaWVsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogQmVuIEh1dGNoaW5ncyA8YmVuLmh1dGNoaW5nc0Bjb2RldGhpbmsuY28udWs+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA3LCAyMDIwIDY6MjggQU0NCj4gVG86IHNhbmdvcnJp
biBkYW5pZWwo44K144Oz44K044Oq44OzIOODgOODi+OCqOODqyDilqHvvLPvvLfvvKPil6/vvKHv
vKPvvLQpIDxkYW5pZWwuc2FuZ29ycmluQHRvc2hpYmEuY28uanA+OyBzei5saW5AbW94YS5jb207
IHdlbnNAY3NpZS5vcmcNCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1
YmplY3Q6IFJlOiBbY2lwLWtlcm5lbC1zZWNdIHJlcG9ydHM6IGFkZCBzY3JpcHQgdG8gY29udmVy
dCByZXBvcnRzIHRvIGNzdiBmb3JtYXQNCj4gDQo+IE9uIEZyaSwgMjAyMC0wOS0yNSBhdCAxNDow
NyArMDkwMCwgRGFuaWVsIFNhbmdvcnJpbiB3cm90ZToNCj4gPiBUaGUgdGV4dCB2ZXJzaW9uIGlz
IHByb2JhYmx5IGVub3VnaCBmb3IgZGV2ZWxvcGVycyBidXQgY3VzdG9tZXJzDQo+ID4gdXN1YWxs
eSBwcmVmZXIgdG8gaGF2ZSBhIENTViB0aGF0IHlvdSBjYW4gb3BlbiB3aXRoIGEgc3ByZWFkc2hl
ZXQNCj4gPiBwcm9ncmFtIGFuZCBjb250YWlucyBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLiBDVkVz
IGFyZSBzb3J0ZWQgaW4gcm93cw0KPiA+IGFjY29yZGluZyB0byB0aGVpciBjcml0aWNhbGl0eS4N
Cj4gWy4uLl0NCj4gDQo+IEkgdGhpbmsgdGhpcyBzY3JpcHQgaXMgdHJ5aW5nIHRvIGRvIHRvbyBt
YW55IGRpZmZlcmVudCB0aGluZ3M6DQo+IA0KPiAxLiBJbXBvcnRpbmcgZGF0YSBmcm9tIE5WRA0K
PiAyLiBJbXBvcnRpbmcgZGF0YSBmcm9tIERlYmlhbiBzZWN1cml0eSB0cmFja2VyIDMuIFBhcnNp
bmcgYW4gZXhpc3RpbmcgcmVwb3J0ICghKSA0LiBHZW5lcmF0aW5nIGEgbmV3IHJlcG9ydA0KPiAN
Cj4gMS4gSWYgdGhlcmUncyB1c2VmdWwgaW5mb3JtYXRpb24gZnJvbSBOVkQgdGhhdCBiZWxvbmdz
IGluIHJlcG9ydHMsIGFuZCB0aGUgbGljZW5zZSBhbGxvd3MgdXMgdG8gcmVkaXN0cmlidXRlIGl0
LCB3ZSBzaG91bGQgYWRkIGFuIGltcG9ydA0KPiBzY3JpcHQgdGhhdCBhZGRzIHRoYXQgdG8gdGhl
IGlzc3VlIGZpbGVzIChhbmQgZXh0ZW5kIHRoZSBzY2hlbWEgaWYgbmVjZXNzYXJ5KS4gIFdlIGNh
biB0aGVuIHVzZSB0aGF0IGluIGFueSBvZiB0aGUgcmVwb3J0aW5nIHNjcmlwdHMuDQo+IA0KPiAy
LiBJJ20gbm90IHN1cmUgd2h5IHRoZSBzY3JpcHQgaXMgdXNpbmcgRGViaWFuJ3MgZ2VuZXJhbCBz
ZWN1cml0eSB0cmFja2VyLiAgRGViaWFuJ3Mga2VybmVsLXNlYyBub3JtYWxseSBoYXMgYmV0dGVy
IGluZm9ybWF0aW9uIGZvciBrZXJuZWwNCj4gaXNzdWVzLCBhbmQgdGhlIGltcG9ydF9kZWJpYW4u
cHkgc2NyaXB0IGFscmVhZHkgaW1wb3J0cyB0aGF0Lg0KPiANCj4gMy4gVGhlIG91dHB1dCBvZiBy
ZXBvcnRfYWZmZWN0ZWQucHkgaXMgaW50ZW5kZWQgdG8gYmUgaHVtYW4tcmVhZGFibGUsIGFuZCBq
dXN0IGhhcHBlbnMgdG8gYmUgcmVsYXRpdmVseSBlYXN5IHRvIHBhcnNlLiAgSWYgeW91IHdhbnQg
dG8NCj4gdXNlIGl0cyBvdXRwdXQgYXMgaW5wdXQsIHRoYXQgc2hvdWxkIGVpdGhlciBiZSBkb25l
IGJ5IGFkZGluZyBhIHN0cnVjdHVyZWQgZm9ybWF0IChlLmcuIEpTT04pIGZvciB0aGUgaW50ZXJt
ZWRpYXRlIGZpbGUsIG9yIGJ5IHNoYXJpbmcNCj4gY29kZSBiZXR3ZWVuIHRoZSB0d28gcmVwb3J0
aW5nIHNjcmlwdHMgc28gdGhlcmUncyBubyBuZWVkIHRvIHVzZSBhbiBpbnRlcm1lZGlhdGUgZmls
ZS4NCj4gDQo+IE90aGVyIGNvbW1lbnRzOg0KPiANCj4gLSBUaGUgbmV3IHNjcmlwdCBuZWVkcyB0
byBiZSBkb2N1bWVudGVkIGluIFJFQURNRS5tZC4NCj4gDQo+IC0gQW55IGZpbGVzIGNyZWF0ZWQg
aW4gdGhlIHByb2Nlc3Mgb2YgaW1wb3J0aW5nIGRhdGEgc2hvdWxkIGdvIHVuZGVyIHRoZSBpbXBv
cnQvIHN1YmRpcmVjdG9yeS4NCj4gDQo+IC0gRXJyb3IgaGFuZGxpbmcgbmVlZHMgaW1wcm92ZW1l
bnQsIGUuZy46DQo+IA0KPiA+ICtkZWYgZG93bmxvYWRfZmlsZShzcmMsIGZpbGUsIGJhcj0iIik6
DQo+ID4gKyAgICAiIiJSZS1kb3dubG9hZCBmaWxlIHdoZW4gYW4gZXJyb3Igb2NjdXJyZWQgZHVl
IHRvIG5ldHdvcmsgY29ubmVjdGlvbiBwcm9ibGVtLg0KPiA+ICsgICAgIiIiDQo+ID4gKyAgICBm
b3IgaSBpbiByYW5nZSgzKToNCj4gPiArICAgICAgICB0cnk6DQo+ID4gKyAgICAgICAgICAgIHdn
ZXQuZG93bmxvYWQoc3JjLCBmaWxlLCBiYXIpDQo+ID4gKyAgICAgICAgICAgIGJyZWFrDQo+ID4g
KyAgICAgICAgZXhjZXB0Og0KPiA+ICsgICAgICAgICAgICBwYXNzDQo+IA0KPiBUaGlzIGRvZXNu
J3QgY2hlY2sgd2hldGhlciB0aGVyZSB3YXMgYSBuZXR3b3JrIGVycm9yOyBpdCByZXRyaWVzIGlu
IGNhc2Ugb2YgKmFueSogZXJyb3IuICBUaGUgZXhjZXB0IGJsb2NrIHNob3VsZCBzcGVjaWZ5IHdo
aWNoDQo+IGV4Y2VwdGlvbiB0eXBlcyB3ZSB3YW50IHRvIGhhbmRsZS4NCj4gDQo+ID4gKyAgICBp
ZiBub3Qgb3MucGF0aC5leGlzdHMoZmlsZSk6DQo+ID4gKyAgICAgICAgcHJpbnQoIkVSUk9SOiBD
YW4ndCBkb3dubG9hZCAlcyIgJSBzcmMpDQo+IA0KPiBFcnJvciBtZXNzYWdlcyBzaG91bGQgZ28g
dG8gc3RkZXJyLg0KPiANCj4gPiArICAgICAgICBleGl0KDEpDQo+IA0KPiBUaGlzIHNob3VsZCBj
YWxsIHN5cy5leGl0Lg0KPiANCj4gQmVuLg0KPiANCj4gLS0NCj4gQmVuIEh1dGNoaW5ncywgU29m
dHdhcmUgRGV2ZWxvcGVyICAgICAgICAgICAgICAgICAgICAgICAgIENvZGV0aGluayBMdGQNCj4g
aHR0cHM6Ly93d3cuY29kZXRoaW5rLmNvLnVrLyAgICAgICAgICAgICAgICAgRGFsZSBIb3VzZSwg
MzUgRGFsZSBTdHJlZXQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1h
bmNoZXN0ZXIsIE0xIDJIRiwgVW5pdGVkIEtpbmdkb20NCg0K

--bxpsBmBocjMrlKna7zod
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5502): https://lists.cip-project.org/g/cip-dev/message=
/5502
Mute This Topic: https://lists.cip-project.org/mt/77073673/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bxpsBmBocjMrlKna7zod--
