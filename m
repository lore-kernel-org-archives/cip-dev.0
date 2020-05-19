Return-Path: <SRS0=sVkV=7B=lists.cip-project.org=bounce+64572+4634+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B7C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 19 May 2020 10:55:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF0020709
	for <cip-dev@archiver.kernel.org>; Tue, 19 May 2020 10:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oQj+3N9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF0020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4634+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 86shYY4521723xddrOIblbHD; Tue, 19 May 2020 03:55:39 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.9279.1589885736366080686
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 May 2020 03:55:38 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 04JAtX14016550; Tue, 19 May 2020 19:55:34 +0900
X-Iguazu-Qid: 2wHH6kkKqkTKbYcyob
X-Iguazu-QSIG: v=2; s=0; t=1589885728; q=2wHH6kkKqkTKbYcyob; m=hJBh4kxdBsioEWqBU+Wi+cGqALnEBJqlQ+1TDyTNz/o=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 04JAtRoV010682;
	Tue, 19 May 2020 19:55:28 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 04JAtRMe007470;
	Tue, 19 May 2020 19:55:27 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 04JAtRBe012489;
	Tue, 19 May 2020 19:55:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbyVxAue0YlF1SYusFjXqXmInQbO7srqV9493otzLxs/eGeZS7OxNOGvdC9uy9rgynDyURHREHGHKwj/rJxmjsDDiT/676m73/4O0r3pkPQSs0fMGp27OQA0cZayE/HvTshuNCKSXjFfvXABly6I3Z9s6NSQyasvuq4ATashp7mxyhyMXwbdYu8BBM7BZOJRNbwx9jqnD4WjufaHLNk0ABLsAbkk4Lit7I5cLcF6tjbydpvqYbQvCL4vVC4246d8QmgCj+N4+XA9QYUqDQB4LTI7d3MiDSF3+m+l+fLDAQ+W9x1y2d9dXZid3uhscQSPDaMVN233O4sBu7zJqkf0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPO7AJ6oKTk4JQJ/OY2tHI/vyX/mrafaCMdCNAKl4vI=;
 b=O21ufws0fukB3CIHaiFHabpmdYVnmNgmBt8bESRmm5Q9WeW4HMROtjk8kH/D8CcXI7wEvUFmxWM2ZGfoLx2dXsps5AeHe3Zrls010xC5S+UP84R7ZiXy9fpNTEqQLjvajAxNZgH05kvWoMSAKLoA86Nw1FVmwficWcg4RU1StQcZVYEd5Jt/byxdGLZ3DgKrlJvkE6NIuZVzphOxBml9RgYlNe/AyCrDjhdAKfR4JOpGm4TfJdziGnQabWtSDzLo1kIAAkjvAuD1OAoEkuOtO5q9r2NlcO2eXi1mNBgXKe/doZg3Xm0xF+BMpvpxBarX9TQWDrxSNWTk2lHUQS/ggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <dinesh.kumar@toshiba-tsip.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core] version management
Thread-Topic: [cip-dev][isar-cip-core] version management
Thread-Index: AdYthqu0kcefdkDOSNuvyCjETy2KPAAFnVAAAAo7bVA=
Date: Tue, 19 May 2020 10:55:23 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB20647C7B02A56814049A5521D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
References: <TYAPR01MB2064041238490898AD56BF62D0B90@TYAPR01MB2064.jpnprd01.prod.outlook.com>
 <8b13f4ba-2ab4-1b7f-94a5-65aaabd11620@siemens.com>
In-Reply-To: <8b13f4ba-2ab4-1b7f-94a5-65aaabd11620@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0afa62a8-6b26-49db-3346-08d7fbe3217f
x-ms-traffictypediagnostic: TYAPR01MB4623:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <TYAPR01MB462303CDC1A5BE94B0AFDF9DD0B90@TYAPR01MB4623.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qi3JFoH4MEAALiFSL9XX9GcMXzfvO9L5uEFSdX4A/IYUOQLbAuq5jyUlSje2nkvGWply+/LEyV6+zMFln5f4A+7bFKjwyF4Lbi0O5lQvEggNW39ZUAxeKHmawWkxRvB+eG3MF96LrsA5hPLhfHgFQJBza36LGjHNur+OiZne9OZI1TUSvBozkBpPCi+9p3VD3+96ikjLvbTZ23YwZK5yP3g2G/Vkly5yZ/OKhUWP11cQLhRugv3FVI3WmAgrhPGjeGi6tYXH+/c2Vk8hAd9c0ZSxYp7TV3S6zLf3yYcSCyT0PnPzS3rMZh3y60wfz1Fuu8fjCgI8XIrCLu68JFWtYDVvHdP6g+kXmRaXqiPzk9RLz5bYePVVsMS2bTzXrzSuSURky8owE2Rj7Xy7Af22s1FKgXzRIfjG5syY6YK38rKGYOiQNcKv/arNyRAPMdP88sdp3AUBCt7gM/wAQQGHQ34eFkhLN3Ga/yvui1IljILpnNQeicU7k/2dBbk+bopA0Bq5XCFH93uuFVdRFo0XW53p1es1Lfcai21UrkI2MU66sKEddilOpcUWdmc/ixA0
x-ms-exchange-antispam-messagedata: FapCBUgaFxRZwyZsszuSlU5etfbhnbyXqTw6mUEUHJFd6X1UmpjEWCAoq9G5KL2eTerQH8qwDkep7VDWWcWu7apOrSoawAKI9BIlVvVsYtfRAgeu51Nh+3jsP2EU0hjdAVYa2hta7kHYuGzoWoR2iRdh59Mgdfhn7qVzZ5aVuTo+7ahlBO4BA3FwSlCxlXsvjADPWrMQRUzRvvsyyoOWtyi7hZgXBHzkH29cJjZrTaq9APPSJzgHuytUuf1IzCzspweHg4nHsi2r3xhFX9usdaFRYgWr0wCTziUC3u8d9SUfQfRi0EzdFLGp4WWK5xV4GrWbZ/Iz2nmYrJQPO3GVr2084xPTad/Uz1z7kE8nkNOYVnW3WNZjjGrQgrqX3jBFv1HTzIhQZ33UHbRtGYoYbpTi1+c+RyuDVXg+SUFDHnhUhOL+uoLdf+vNPrzMDlkN4szTLjDRUN5uiKlXTa0R9M7TW/5jpwdMkrlXhpmJB9A=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afa62a8-6b26-49db-3346-08d7fbe3217f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 10:55:23.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9LqaedIVFB7aMGAGClEIqdOWEQYCMIUPAVNhelvIWMDoCQ5T5mWBYcc2nDhi4s714UVEGyqAa8yYjx2T/PsiCpUH9cV9oofhmNQGDE3nlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4623
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qGMvJMoNukf5Eqpk2YNFyvVdx4520388AA=
Content-Type: multipart/mixed; boundary="l9Swai6riycyeZF60PHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589885739;
 bh=ZjzrJFJ4IlekVxKkbM4JHIE0rY/vjpNeJnH+kIW4bIQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=oQj+3N9In2M3lrdPSbCGmVl9rNcKR4EpmQWVm/UUlzrkUVBCBCg59+zZ83d44xk2aKx
 bx2fMGHQiQvZkFWtPOqzAOuTZJ6zdRBh/bxK+xSdWcdbBB9dC50cH4043eCkSnF1lg4xr
 9EiuVheXXGaKC0Q6UptRDr9GGw5FWfRrzEU=

--l9Swai6riycyeZF60PHu
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIFBsZWFzZSBjaGVjayBtaW5lIGlu
bGluZQ0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+ID4g
SSBhZ3JlZSB0aGF0IHdlIG5lZWQgdG8gdmVyc2lvbiBvdXIgcmVsZWFzZXMuIEluIERlYmlhbiB0
aGVyZSBhcmUgcG9pbnQgdmVyc2lvbnMsIGJ1dCBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdG8gZm9s
bG93DQo+IHRoYXQuIE1heWJlIHdlIGNhbiBqdXN0IHVzZSBhIG51bWJlciBzdWNoIGFzIHRoZSBk
YXRlIG9mIHRoZSByZWxlYXNlIChlZy4gMjAyMDA1MTkgPC0tIHllYXJtb250aGRheSkuDQo+IA0K
PiBPciB0aGUgbW9yZSBjb21tb24gcGF0dGVybiAiMjAyMC4wNSIuDQo+IA0KPiBIb3cgb2Z0ZW4g
c2hvdWxkIHdlIHJlbGVhc2U/IFdoYXQgd291bGQgYmUgdGhlIHJlcXVpcmVkIHF1YWxpdHkgY3Jp
dGVyaWE/DQoNClBlcmhhcHMgb25lIG9wdGlvbiBpcyB0byByZWxlYXNlIGF0IHRoZSBzYW1lIHRp
bWUgdGhlIENJUCBrZXJuZWwgaXMgcmVsZWFzZWQsIHRoYXQgaXMgZXZlcnkgZmV3IHdlZWtzDQpo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgt
Y2lwLmdpdC9yZWZzL3RhZ3MNCldlIGNhbiBzdGFydCB3aXRoICJubyByZWdyZXNzaW9ucyIgYXMg
dGhlIG1vc3QgYmFzaWMgcXVhbGl0eSBjcml0ZXJpYS4NCg0KPiA+IFNvbWUgcXVlc3Rpb25zIHJl
Z2FyZGluZyB2ZXJzaW9uaW5nOg0KPiA+ICAgICAqIHNob3VsZCB3ZSBhbHNvIHN0b3JlIG1ldGFk
YXRhIGFzc29jaWF0ZWQgd2l0aCBhIHJlbGVhc2U/DQo+ID4gCSogYSBwYWNrYWdlIGxpc3QgbWFu
aWZlc3QgZm9yIGVhY2ggcmVsZWFzZSAoZHBrZyAtbCk/DQo+ID4gICAgICAgICAgKiB0aGUgY2lw
LWNvcmUgYnJhbmNoIGFuZCBjb21taXQNCj4gPiAgICAgICAgICAqIHRoZSBjaXAta2VybmVsIGJy
YW5jaCBhbmQgY29tbWl0DQo+ID4gICAgICAgICAgKiBtZDVzdW0gb2YgdGhlIGltYWdlDQo+IA0K
PiBXaGVuIHVzaW5nIGEgbWV0YSBsYXllciBmb3IgZ2VuZXJhdGluZyB0aGUgaW1hZ2UgLSBsaWtl
IGlzYXItY2lwLWNvcmUgLSwNCj4gYWxtb3N0IGV2ZXJ5dGhpbmcgaXMgZGVzY3JpYmVkIHRoYXQg
d2F5IGFscmVhZHksIGV4Y2VwdCBmb3IuLi4NCj4gDQo+ID4gICAgICogZG8gd2UgbmVlZCByZXBv
c2l0b3J5IG1hbmFnZW1lbnQgaW5mcmFzdHJ1Y3R1cmU/DQo+ID4gICAgICAgICAqIG1pcnJvciBw
YXJ0IG9mIHRoZSBkZWJpYW4gcmVwb3NpdG9yeSAob25seSB0aGUgcGFja2FnZXMgdGhhdCB3ZSBu
ZWVkKQ0KPiA+ICAgICAgICAgKiBjcmVhdGUgc25hcHNob3RzIGZvciBlYWNoIHJlbGVhc2UgaW5j
bHVkaW5nIHRoZSBzb3VyY2UgY29kZSBwYWNrYWdlcw0KPiA+DQo+IA0KPiAuLi50aGUgYmluYXJ5
IHBhY2thZ2VzLiBTbyB0aGUgc2Vjb25kIHBpZWNlIHdvdWxkIGJlIGEgdmVyc2lvbmVkIHJlcG8N
Cj4gZm9yIHRob3NlLg0KPiANCj4gVGhhdCBjYW4gYmUgc25hcHNob3QuZGViaWFuLm9yZywgbGlr
ZSB3ZSBkbyBpbiBbMV1bMl0sIGJ1dCB0aGF0IHRoaXMgbm90DQo+IGEgdmVyeSByZWxpYWJsZSBz
b3VyY2UgKHRvb2sgbWUgaG91cnMgcmVjZW50bHkgdG8gcmVidWlsZCBbMV0gZnJvbQ0KPiB0aGVy
ZSwgeW91IHdhbnQgYSBiZXR0ZXIgbWlycm9yKS4NCj4gDQo+ID4gU3RvcmluZyBtZXRhZGF0YSBz
aG91bGQgbm90IGJlIHRvbyBkaWZmaWN1bHQsIGp1c3QgYWRkIHNvbWUgc2NyaXB0IGNvZGUgdG8g
Z2l0bGFiLWNpLg0KPiA+DQo+ID4gS2VlcGluZyBzbmFwc2hvdHMgd291bGQgcmVxdWlyZSBtdWNo
IG1vcmUgd29yayBhbmQgcmVzb3VyY2VzLiBJIHRoaW5rIHRoaXMgaXMgbm90IG5lY2Vzc2FyeSBz
aW5jZSB3ZSBhcmUgbm90IGdvaW5nDQo+IHRvIHJlYnVpbGQgaW1hZ2VzLCBhbmQgaWYgd2Ugd2Fu
dGVkIHdlIGNvdWxkIGRvIGl0IHNvbWVob3cgZnJvbSB0aGUgcGFja2FnZSBsaXN0IG1hbmlmZXN0
IGFuZCB0aGUgdXBzdHJlYW0gRGViaWFuDQo+IGZ0cCBzZXJ2ZXJzLg0KPiANCj4gVGhlIHJlcG8g
aXMgcmVxdWlyZWQgaWYgd2Ugd2FudCB0byBiZSBzZXJpb3VzIHJlZ2FyZGluZyByZWxlYXNlcy4N
Cg0KT0ssIGluIHRoYXQgY2FzZSB3ZSB3b3VsZCBuZWVkIHRvIHNldHVwIGFuIEFXUyBpbnN0YW5j
ZSB3aXRoIGVub3VnaCBzdG9yYWdlICggMSBvciBtb3JlIFRlcmFieXRlcyksIGFuZCBodHRwZCBz
ZXJ2ZXIsIGFuZCBhIHJlcG9zaXRvcnkgbWlycm9yL3NuYXBzaG90IG1hbmFnZW1lbnQgdG9vbCBz
dWNoIGFzIFthcHRseV0oIGh0dHBzOi8vd3d3LmFwdGx5LmluZm8vKS4NCg0KVGhhbmtzLA0KRGFu
aWVsDQoNCj4gDQo+IEphbg0KPiANCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9zaWVtZW5zL21l
dGEtaW90MjA1MA0KPiBbMl0NCj4gaHR0cHM6Ly9naXRodWIuY29tL3NpZW1lbnMvbWV0YS1pb3Qy
MDUwL2Jsb2IvbWFzdGVyL2NvbmYvZGlzdHJvL2RlYmlhbi1zbmFwc2hvdC5saXN0DQo+IA0KPiAt
LQ0KPiBTaWVtZW5zIEFHLCBDb3Jwb3JhdGUgVGVjaG5vbG9neSwgQ1QgUkRBIElPVCBTRVMtREUN
Cj4gQ29ycG9yYXRlIENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

--l9Swai6riycyeZF60PHu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4634): https://lists.cip-project.org/g/cip-dev/message=
/4634
Mute This Topic: https://lists.cip-project.org/mt/74318282/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--l9Swai6riycyeZF60PHu--
