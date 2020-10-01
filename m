Return-Path: <SRS0=YzQi=DI=lists.cip-project.org=bounce+64572+5483+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23FC4363D
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 00:20:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A04F20780
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 00:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="F6aPvxCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A04F20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5483+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LcNuYY4521723xrsXCmCI9Nt; Wed, 30 Sep 2020 17:20:44 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.1177.1601511641872371154
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2020 17:20:43 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0910KcPa001504; Thu, 1 Oct 2020 09:20:38 +0900
X-Iguazu-Qid: 2wHHJOhcBApMlS8KGn
X-Iguazu-QSIG: v=2; s=0; t=1601511638; q=2wHHJOhcBApMlS8KGn; m=EJB0EiJFqrHVbiNhl+6FmCTgnIXPeWE296EHm2GDkVY=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 0910KapN027910;
	Thu, 1 Oct 2020 09:20:37 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0910KaU2007988;
	Thu, 1 Oct 2020 09:20:36 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0910Kask019145;
	Thu, 1 Oct 2020 09:20:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj3JRmRcyIAvG5j9gLK2Xa9ZwDNzOSU/3skYxSO2DIR34ZTkKMPXDbqWzDrVCwjZSRUeuI57Jjm1Vd6AGi9Tce+eu+ton4Pj5iCt9IsWkXhgJmGkeN6XFWzRofgOpp/PfvRlH9vMNka8G5USokS/8wvqujpH+fldRveVA2WK6Hlyw6MDw22wUzQGWv6S7QzOoPlQuMTHG+PPkKtU63grzxKuyhXDexZSKENQcoS/FLbqUQNa7OISAsARAhsJrklptmdw4cqljP1eZLEQvoK9mOL5rU8+Zsc3mH2UXqF8gODbQ1ZuzEvqblNThH02KeZ5iS8DlQqAueoFO1CYDumFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy4GiMbNpr3bfmya/tstW3KxVAERxyu3xCVqlL1Wvf4=;
 b=mMLTEIGHbe09zeqZgCzmJrcbSGdxLe4J5Di9TDIe7SC372AH0X0CZys6JKUpge00G1/FN4C8mSfo23WVoL39VyTGU3lFYWY9fqpbPdYFbslQnSOgT1/KSQ0QtSpopFuI412gZZyLyBIoVpqudW0f1lpmcXQA1xUDa1N/vMsBtRm3s5l7vVwbarZkW7NI82bLLiS+asgTBZcSPjp/IfTHlvxRspWoW7QT2Ggg1ikQjvZ9VrTw06T8bCzQzb3Gafp+Tqwd7wJGSYKDN7IEK2Q/O+l73VAZMFwqwmxeMd2fQBgg2qIgl4byCSeXMVK/ktOxUnCqQ/2luLNBASz9DttW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <jan.kiszka@web.de>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core] image: export dpkg status file for debsecan
Thread-Topic: [cip-dev] [isar-cip-core] image: export dpkg status file for
 debsecan
Thread-Index: AQHWlvjz2mwSipOuB0+WVfLbj9/OM6mB4+4A
Date: Thu, 1 Oct 2020 00:20:33 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053D9A590ED2C8F264206CDD0300@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <20200930020815.2474349-1-daniel.sangorrin@toshiba.co.jp>
 <20200930020815.2474349-2-daniel.sangorrin@toshiba.co.jp>
 <7596cf39-b8f9-cedc-3b51-b164553b3ee4@web.de>
In-Reply-To: <7596cf39-b8f9-cedc-3b51-b164553b3ee4@web.de>
Accept-Language: en-US
x-originating-ip: [124.211.28.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed3393c1-8322-4785-7bb8-08d8659fd00a
x-ms-traffictypediagnostic: OSBPR01MB3256:
x-microsoft-antispam-prvs: <OSBPR01MB3256C9ABAAACC0A8EA1C963FD0300@OSBPR01MB3256.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7SWF8k4IfVALdJC5q41WyRUvnF25Eg5yt1wn12ZL7yavTimK7wV7fZkzsUN55WN283cM4oXk2Mal3HCkRYYPGlAes36g490yyTQKEJob32FvaBwzGdv/7KWy1kr3NQvKyOruC7uRBPl/OPDx4YbBv1OFK+xERM+ILHZBgZeRVj5TAK78gb67Y6gckBZZ4Roy8sfKVUKJVvcG4uuPhPaucnBlARuLQZu7MjaG5BwyyapLn481vWUSW7CVXVW35z0LPKcinBvjniPkEnx1HPPJIiJFRDbbo0TqsDnjEmqmuxXGwvfOP4a8Dfy9u+hC9UxHjBV4RRKwnieK6YilLK7cs9oMz/BIbKslp35wZYU/l/QwEIGraqY6w89oL/j4mBoe
x-ms-exchange-antispam-messagedata: LSxj09FFWRBuwIvG7gtTjUHR0fJst3vK7QeBNzzU54CrpdJD+mh8extuVJD4j41Gag4Mqg+cmhyLhlv381FOfYiR/Q4pC4/8qd0K45vaSom+ZbQM3DehE5Vz7LEPnrriRSK1B6EgCgWMEreA7LqKofgvF+Jyqo3QJFaYKmDFofkXqw2w+4ZQgkXhIe9UFZg4rbE4ix06pYIhUa8KU3PGGD3MSagraY+W06+Z4MOvTACst1rbqd/R15HzmDX++WiOEh7s3z4pZeVHP8TxayIyysRdBMegRcNdMAAmVDDhamjW//SMWJ+guWYLoolVMXe0z2ayXhkI54pqxx8FoowWKvR2FUIzd8FRZoqsrHlWFIa4Fdi5mN+ijgsoeeYf/fWJaznTkZkuycUSnS2Wuul92AnXrOhKkV9Nd+l7JUK1DAFe1xv2U65JGqDaA8IJhMYYAp+SfM6yRoNPwHc1hGopyrEc3BbpXwwdR1GB8rPR/kOqYAEF/cuPIxCC0paLsr0xQjyWNtGrdGnUyWCcGs4JPWbT/8A5Cpv69a0GlwsK1kKMFLitnfDuVPMr+1sQcfsxJ8aDt2ZDAC5p4apEtEg/bDZbxQa4hTzJRIR1bjlB/6mXYbMsVDVV96Da1Z3RGGjyLOCsmTn83hds2wZchoJjQA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3393c1-8322-4785-7bb8-08d8659fd00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 00:20:33.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZsblrARCaGsJ6/fw+q8u22oFHcsm8mwtQeTuL031ugb1vUvI9VFA2z5/1zawuMGV2hiWQySIb29ngyUPUt0oNBpJ6YvEgUL9YeDTqXmG2hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3256
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KMVAB2nE6QxQueI83149uePwx4520388AA=
Content-Type: multipart/mixed; boundary="USBu2wi2zm2FiZRLh06A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601511644;
 bh=oIXAgWPuK4WP2EjIHPQQOd45eLsy9hvh1R9fnJqeoYY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=F6aPvxCys5qq3VGqdF5uAZeXBznNejkr4PoCmANdfybWan5qHe2iepA0xnhYMgFe+NI
 We4eDi1WmX8glSv6BgiHgUCHPd1sHfCXiKs8HqWlfILmsm0SuLzf+rc5/Uw4ZWqDr1K42
 gqBHYRB8HnUWZRZTPKJYFEO0ZKl3Jc2Lcz8=

--USBu2wi2zm2FiZRLh06A
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T0ssIEkgd2lsbCBzZW5kIGl0IHRvIElTQVIgdGhlbi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHdlYi5kZT4NCj4gU2VudDog
V2VkbmVzZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMjAgNDoxMiBQTQ0KPiBUbzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc7IHNhbmdvcnJpbiBkYW5pZWwo44K144Oz44K044Oq44OzIOODgOOD
i+OCqOODqyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxkYW5pZWwuc2FuZ29ycmluQHRvc2hp
YmEuY28uanA+DQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdIGltYWdl
OiBleHBvcnQgZHBrZyBzdGF0dXMgZmlsZSBmb3IgZGVic2VjYW4NCj4gDQo+IE9uIDMwLjA5LjIw
IDA0OjA4LCBEYW5pZWwgU2FuZ29ycmluIHdyb3RlOg0KPiA+IEFsdGhvdWdoIHRoZSBjdXJyZW50
bHkgZXhwb3J0ZWQgbWFuaWZlc3QgcHJvYmFibHkgaGFzIGVub3VnaA0KPiA+IGluZm9ybWF0aW9u
LCB0aGUgdG9vbCBkZWJzZWNhbiBhbmQgb3VyIHdyYXBwZXIgY2lwLWNvcmUtc2VjIGRlcGVuZCBv
bg0KPiA+IHRoZSBkcGtnIHN0YXR1cyBmb3JtYXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgU2FuZ29ycmluIDxkYW5pZWwuc2FuZ29ycmluQHRvc2hpYmEuY28uanA+DQo+ID4gLS0t
DQo+ID4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmIgfCA4
ICsrKysrKysrDQo+ID4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2UuYmIgICAg
ICAgICAgfCA4ICsrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1h
Z2Utc2VjdXJpdHkuYmINCj4gPiBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Ut
c2VjdXJpdHkuYmINCj4gPiBpbmRleCA2MWRkYzM5Li45Mjg3NzRjIDEwMDY0NA0KPiA+IC0tLSBh
L3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmINCj4gPiArKysg
Yi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiDQo+ID4gQEAg
LTM0LDMgKzM0LDExIEBAIElNQUdFX1BSRUlOU1RBTEwgKz0gIiBcDQo+ID4gIAl1dWlkLXJ1bnRp
bWUgXA0KPiA+ICAJc3VkbyBcDQo+ID4gICINCj4gPiArDQo+ID4gKyMgZm9yIGNpcC1jb3JlLXNl
Yy9kZWJzZWNhbg0KPiA+ICtST09URlNfUE9TVFBST0NFU1NfQ09NTUFORCArPSAiZXhwb3J0X2Rw
a2dfc3RhdHVzIg0KPiA+ICtleHBvcnRfZHBrZ19zdGF0dXMoKSB7DQo+ID4gKyAgICBzdWRvIC1F
IGNocm9vdCAtLXVzZXJzcGVjPSQoaWQgLXUpOiQoaWQgLWcpICcke1JPT1RGU0RJUn0nIFwNCj4g
PiArICAgICAgICBjYXQgL3Zhci9saWIvZHBrZy9zdGF0dXMgPiBcDQo+ID4gKyAgICAgICAgJHtS
T09URlNfTUFOSUZFU1RfREVQTE9ZX0RJUn0vIiR7UEZ9Ii5kcGtnX3N0YXR1cw0KPiANCj4gVGhp
cyBpcyBqdXN0IGEgY29weS1vdXQsIEkgZG9uJ3Qgc2VlIHRoZSBjaHJvb3QgbmVlZCBoZXJlLg0K
PiANCj4gPiArfQ0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3Jl
LWltYWdlLmJiDQo+ID4gYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3JlLWltYWdlLmJiDQo+
ID4gaW5kZXggMmNlY2RlMy4uMDEzOTgxOSAxMDA2NDQNCj4gPiAtLS0gYS9yZWNpcGVzLWNvcmUv
aW1hZ2VzL2NpcC1jb3JlLWltYWdlLmJiDQo+ID4gKysrIGIvcmVjaXBlcy1jb3JlL2ltYWdlcy9j
aXAtY29yZS1pbWFnZS5iYg0KPiA+IEBAIC0xOSwzICsxOSwxMSBAQCBJTUFHRV9JTlNUQUxMICs9
ICJjdXN0b21pemF0aW9ucyINCj4gPiAgIyBmb3Igc3d1cGRhdGUNCj4gPiAgU1dVX0RFU0NSSVBU
SU9OID8/PSAic3d1cGRhdGUiDQo+ID4gIGluY2x1ZGUgJHtTV1VfREVTQ1JJUFRJT059LmluYw0K
PiA+ICsNCj4gPiArIyBmb3IgY2lwLWNvcmUtc2VjL2RlYnNlY2FuDQo+ID4gK1JPT1RGU19QT1NU
UFJPQ0VTU19DT01NQU5EICs9ICJleHBvcnRfZHBrZ19zdGF0dXMiDQo+ID4gK2V4cG9ydF9kcGtn
X3N0YXR1cygpIHsNCj4gPiArICAgIHN1ZG8gLUUgY2hyb290IC0tdXNlcnNwZWM9JChpZCAtdSk6
JChpZCAtZykgJyR7Uk9PVEZTRElSfScgXA0KPiA+ICsgICAgICAgIGNhdCAvdmFyL2xpYi9kcGtn
L3N0YXR1cyA+IFwNCj4gPiArICAgICAgICAke1JPT1RGU19NQU5JRkVTVF9ERVBMT1lfRElSfS8i
JHtQRn0iLmRwa2dfc3RhdHVzDQo+ID4gK30NCj4gPg0KPiANCj4gUGxlYXNlIGF2b2lkIGNvZGUg
ZHVwbGljYXRpb24uIFdlIGhhdmUgbWVhbnMgbGlrZSAicmVxdWlyZSBzb21lLmluYyIgaW4gYml0
YmFrZS4NCj4gDQo+IEknbSBhbHNvIHdvbmRlcmluZyBpZiB0aGlzIHNob3VsZCBnbyB0byBpc2Fy
IHVwc3RyZWFtIGRpcmVjdGx5LiBkZWJzZWNhbiBpcyBhIGdlbmVyaWMgRGViaWFuIHRvb2wsIG5v
dGhpbmcgQ0lQLXNwZWNpZmljIHBlciBzZS4NCj4gDQo+IEphbg0K

--USBu2wi2zm2FiZRLh06A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5483): https://lists.cip-project.org/g/cip-dev/message=
/5483
Mute This Topic: https://lists.cip-project.org/mt/77210404/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--USBu2wi2zm2FiZRLh06A--
