Return-Path: <SRS0=XmKI=B4=lists.cip-project.org=bounce+64572+5127+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94490C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 04:57:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FF12076D
	for <cip-dev@archiver.kernel.org>; Tue, 18 Aug 2020 04:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gu/tNCfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FF12076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5127+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vD3GYY4521723xctZfEMaifE; Mon, 17 Aug 2020 21:57:30 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.60244.1597726647716872824
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Aug 2020 21:57:29 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 07I4vO2L018351; Tue, 18 Aug 2020 13:57:25 +0900
X-Iguazu-Qid: 2wGrGhpI0JJ8udWgl6
X-Iguazu-QSIG: v=2; s=0; t=1597726644; q=2wGrGhpI0JJ8udWgl6; m=RZkf/WBZxLIe0Wl9+5UkY9XSmQk88PVrHKl5wguPHPw=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1112) id 07I4vNUk019768;
	Tue, 18 Aug 2020 13:57:24 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 07I4vNws001318;
	Tue, 18 Aug 2020 13:57:23 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 07I4vNCq019433;
	Tue, 18 Aug 2020 13:57:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2mbmKO1PINm8/ZUe0d0yKzhNAYp3Q7eztoq28qmQq9r6WJP77TpqJcQ/WN5pMKmCtfqf+hx2lNxfuBz+4+UAAVeyIcu491Es8eId0WwpYRJeB3+UDpgCYXM9+5HCdGsDbR1OsHgNiLRvT8xxl1HVULIwWT6qCnay6+v1ppk5DdSIoeAR9O4NVaaPtBoehg1YJngXRQpzxLDIowS7ZyhWV1+YczSJARlpeoqXZ/Pvv2ZaRbV1oHQMLbZBo1PF8ngYix+Vm3Nydg5Bm6Ptml9bDhuBNcr+ps/LPHhtSVgMTYnbg4mKz+KQqlH0eXZW3oQ/G398YWmNQ1H4wEm28D02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CR3XcRWoJapA2+cWPCSV7dP849YqybAcX27+GINeBI=;
 b=mYWNE1WFkPx8oLHPAvhx5mq0Y4+1qclQXRvIbTx0YB/tEhLNWFUUJGvOgvOJM9HT2PeDiLp3lCStxPdb9yaTPeEysmA2vZC0SBeR6pGXW7bjJ23XmtVYnkzE5gLi5SiUbjSdimt4ruO3iSRcd7BfwcPw8/a7Pcw0xQh7XTM7Iz6AXsBmUku8p+Gi48me0VN51B08nmdP6TvVW+xxt8Slcz1bHkiYG6wePFmN2QpWDyNglkmejqp+UrqVxRe42aiJeo8jGEO95/C4gq22ZatGSmmOjoM85KwgctVvPw/GWmYNUBuw4riVT9aGtDTN1+G5vvlbwPuDjfDAmeVfI4NPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add recipe
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add
 recipe
Thread-Index: AQHWama7Of7RBEN/RES+OIG1P/Dsiak9YsAw
Date: Tue, 18 Aug 2020 04:57:09 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298327233BFADC291456E190925C0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <16281511DE955BB5.19258@lists.cip-project.org>
In-Reply-To: <16281511DE955BB5.19258@lists.cip-project.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 681d12fb-6dc9-4075-4057-08d843332982
x-ms-traffictypediagnostic: OSBPR01MB4136:
x-microsoft-antispam-prvs: <OSBPR01MB41361DF4A09D33B7386B3089925C0@OSBPR01MB4136.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NNS5/Garx+jEuieT088nGp+kBn8GUU6Cn6Tqx2QgBmWLhQBgbNNgj24gDmUkR0vV6LAWAWw76sFbISg/McxGMpJuNB1n7WB5fp4AZuekAqyGT3jl/9n1cc5jDNFZuOhNXcdpgwoUtR3Paa5xkORRb56MG1IP3A+nbP5fho6y6BzqDs0FU3GD1yZZJZL/BVdOwqDN7mWiwbyrBmOBcDodLPPQkvGLroaLrFj02r1bDcwNjQiH0Skwl9ZVVUKU0LcbX25jxPj0eM/aCD37I2ZIHxypwNf4SYjN5FG3I1viwBRjRQoNk5vKmL7i6y+sHESO
x-ms-exchange-antispam-messagedata: qxxt4vJCdt2RfBfWz67kzuauCNfYglMQ/G6Zz5NIkbbGby1LW2UpJizZchy0UyENbYS+jSZ9x+tFlWFhKjm/dNb3Me10ncNGLP6ZfPfBcdqhu1NsGGYpD8cTolFF7pXcZeF6uvf5qzwxMXfL5kgOVOK8sqhV3er+Ru1Vc6W06SbtE/bThpBi1UM02SzFqY+kibn5VP5VtHo+4q0ywMACA+xISy5EsuEASlND/HfVWsqlIPSw3laehEZx6oPUEA2XBF/oD5m2WTEVOCQA7fmbSqCNPmL7niQyBbBWVamaNS+s2bhbC36ujT8WihVDUNzlTWxV/PV1cK+8nsAjC+wj6Pflgo9DdGVeAjJPsGcQhdMul2aW8DSdkYiMBHrRGzESmbuqaRS0Vu0rGaN2CQLL0+kIm0sAEkQmqiwbVV37cq+wtyLD7u/aszjdzUmofI/I9urJQU3BO5fYyem6MsbUJbYRkaVDCrb2XAXo54C+w+vdsPFGkb21GazoXCAhQBn83GstsRPnq1pL+cfvO9lAUZ/dos15XwO6TPrp2jozRk6G1WHyfeSkgrRDqJgW6Xky/CieIgyWOxlQ2FEtKkZUAd7kCbEQBPoRhKYAI6AfpN50LyMS2Q9Hb2qGNsM7Fo1hf3B9Ea2yg4PLLUejntSV3Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d12fb-6dc9-4075-4057-08d843332982
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 04:57:09.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkmqsJool0r/QKRlf88plY7MsyZMW2AS5UIRXXLUki+38e2gC3Wlg09688vgmVac5E2+yfYfaJefRR5IC38Nn5p/CCDIvHBHrd1xNZK1MilKwaZnnbWl25HJYg6cNZis
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4136
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hheATEksIkduKZHJOZiL90OVx4520388AA=
Content-Type: multipart/mixed; boundary="dVDciHtSnTCKVrXOX9NN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597726650;
 bh=p89iEx+5EXldJQoM4c0h65/XoGvjzzR82iV57FBKWts=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=gu/tNCfbXLwOH52ZuztLAwhg0KF6bCa2j10wzRW+Xk4Wqa9hf+ikc2bfTct2Mm4b1hf
 kTGeAVpdiETdfa/ZC6C2uziNsCfZudg3NcV8L/vBVgeD1unGTxV8tv5Q94FGgtxzYgzQD
 W+tIv5ZGFjQQI+mkGeRVvEUgBg5M4jKvWYs=

--dVDciHtSnTCKVrXOX9NN
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQpDb3VsZCB5b3UgY29tbWVudCBvbiB0aGlzIHBhdGNoIHNlcmllcz8NCg0KQmVz
dCByZWdhcmRzLA0KIE5vYnVoaXJvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIE5vYnVoaXJvIEl3YW1hdHN1DQo+IFNlbnQ6
IFR1ZXNkYXksIEF1Z3VzdCA0LCAyMDIwIDEwOjU0IFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiBDYzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHv
vLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4N
Cj4gU3ViamVjdDogW2NpcC1kZXZdIFtpc2FyLWNpcC1jb3JlXVtQQVRDSCAxLzNdIGNpcC1jb3Jl
LWltYWdlLXRlc3Q6IEFkZCByZWNpcGUNCj4gDQo+IFRoaXMgcmVjaXBlIHByb3ZpZGVzIGFuIGlt
YWdlIGZvciB0ZXN0aW5nLg0KPiBJZiB1c2UgdGhpcywgaXQgd2lsbCBjcmVhdGUgYW4gaW1hZ2Ug
Y29udGFpbmluZyBMVFAobHRwLWZ1bGwpLCBydC10ZXN0cyBhbmQgc3RyZXNzLW5nLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3No
aWJhLmNvLmpwPg0KPiAtLS0NCj4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Ut
dGVzdC5iYiB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGlu
c2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCByZWNpcGVzLWNvcmUvaW1hZ2VzL2Np
cC1jb3JlLWltYWdlLXRlc3QuYmINCj4gDQo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvaW1h
Z2VzL2NpcC1jb3JlLWltYWdlLXRlc3QuYmIgYi9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3Jl
LWltYWdlLXRlc3QuYmINCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4u
ZTJiMTVmYw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lw
LWNvcmUtaW1hZ2UtdGVzdC5iYg0KPiBAQCAtMCwwICsxLDE4IEBADQo+ICsjDQo+ICsjIENJUCBD
b3JlLCBnZW5lcmljIHByb2ZpbGUNCj4gKyMNCj4gKyMgQ29weXJpZ2h0IChjKSBTaWVtZW5zIEFH
LCAyMDE5DQo+ICsjDQo+ICsjIEF1dGhvcnM6DQo+ICsjICBKYW4gS2lzemthIDxqYW4ua2lzemth
QHNpZW1lbnMuY29tPg0KPiArIw0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+
ICsjDQo+ICsjDQo+ICtpbmhlcml0IGRwa2ctcmF3DQo+ICtyZXF1aXJlIGNpcC1jb3JlLWltYWdl
LmJiDQo+ICsNCj4gK0RFU0NSSVBUSU9OID0gIkNJUCBDb3JlIGltYWdlIGluY2x1ZGluZyB0ZXN0
IHBhY2thZ2VzIg0KPiArDQo+ICtJTUFHRV9JTlNUQUxMICs9ICJsdHAtZnVsbCINCj4gK0RFQklB
Tl9ERVBFTkRTICs9ICJydC10ZXN0cywgc3RyZXNzLW5nIg0KPiAtLQ0KPiAyLjI3LjANCg0K

--dVDciHtSnTCKVrXOX9NN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5127): https://lists.cip-project.org/g/cip-dev/message=
/5127
Mute This Topic: https://lists.cip-project.org/mt/75987091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dVDciHtSnTCKVrXOX9NN--
