Return-Path: <SRS0=wTMI=FF=lists.cip-project.org=bounce+64572+5911+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57551C64E90
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 00:59:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929D520809
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 00:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GUQY3bK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929D520809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5911+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id X3aqYY4521723xpUrujiyklM; Mon, 30 Nov 2020 16:59:36 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.3242.1606784374933816941
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 16:59:36 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0B10xSMs031269; Tue, 1 Dec 2020 09:59:28 +0900
X-Iguazu-Qid: 34tru22SmZbeyXzeLg
X-Iguazu-QSIG: v=2; s=0; t=1606784367; q=34tru22SmZbeyXzeLg; m=1hYWoPfgVbmznzBJrmKoiLNW6uRNu2P+aoUHuCYo7uY=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 0B10xQNV024899;
	Tue, 1 Dec 2020 09:59:27 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0B10xQF9001494;
	Tue, 1 Dec 2020 09:59:26 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0B10xQ3d009571;
	Tue, 1 Dec 2020 09:59:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDFqfjLFLeU0TekRIRocKHxOyH6DmBhBQL15JkF729tx5Sk964QbBgxV9xv6r11BT0GsNS7GnyUulM7iac4xgcex8eNkqtkxPCdIAcHS1w1uuiRNUbGxmeQWFT1fFMri+HlP/qG9tYw9VH4pWTj8stoQICQ//mKR/PMesRnv5/RqWbOHlYkt0BRfZ7ZPCgZ0OPJYO9uMPVafei5Xn0Jsx1a5VrwqNeMa7K0kR8hb823FkIxxT0UcPSc3PagV8TCS87WxLJPtYXTYXwRutIe6ZfxA/c7O8CbDsVJzF6dh7qj1AKiUp6Df/Es27bAG9qMdi7Iv4k/7QaXqYMFHLpMbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am2aVqvTxGPYXcKg8HVDBcF3FMSJIaA82NUqIB/ij30=;
 b=P6gMcq8iju+GumA6Sjh7Gj5QThFiFFkqdVeBk7MaXnNF4qIZeMfyf2WQURq/DnJvk1iUqEIOjS0GNKOSV4wwz4cFWZiO5wI/dAh5rFYsNlCharP8E7DgUdVt0wvVID87WSbubcoUeJyIvKgjPbE+g56XIGMrFPXF6ZOrNVGNX3kWur5Witb9xCyH+Xq+2fG//TejEkwvBYQQQSuWrGewIwfyqj9eJIcH2rIDCrVER3ozq9zTNic+tHdYaPMLyd+Myj4ecY5Tg5iSJ5M5fjYJ/XHcinVgvvTI4p46nCEF3EOlypqh/e8ZjSyNWAt1+4Av7bq0SpH/uLNPcE03V0XcNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection support
Thread-Topic: [PATCH 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection support
Thread-Index: AQHWxyPT1e9gp8f74UaUKX/EuDT8kanha/xg
Date: Tue, 1 Dec 2020 00:59:24 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298320C565B94544B2E992B792F40@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fadc025b-e116-4d7d-c6ac-08d8959458be
x-ms-traffictypediagnostic: OSYPR01MB5320:
x-microsoft-antispam-prvs: <OSYPR01MB53201D4CF751B5EE5A009CD792F40@OSYPR01MB5320.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SFXoLfRlWdVXJRFoTWkHhEEYw96ebG63+GR3zsQHXc611s5KikxQR+xKn7skCRCNm5LEcbfQ3cjSfoUj8kZRoH/l0IQc8alcRQ/xz0pmykXNxdeb0bJ7pGNcpoZxxazBI3umH7FybQIvXoSBHB9rH8AUuoswXJd5LhtaLixXjI+L1OBeJek0eKybVAWSiTd8JKfhj0tkBYhfN22OdiIBBYwcewhtbVEnq6pmTgkC0ypNUhqIM+QIEk/M3KkPPhcfDtFnrEuYeXqtmoFbYJg2FZAWtRHh6eYsE7WMpiE+R/csY4speyXyNZZezSIVzyjL
x-ms-exchange-antispam-messagedata: =?utf-8?B?RDRUNk9ubEVUQ215eHhyVmFtNDNmWXZNTHptR2xET0lvMVZieDQycnN4QWZx?=
 =?utf-8?B?QXBZdVJPYkJtS3Jhanp1bmdKYXpEZzVsd05XSlBZV21zK3FnV2RaTzdoekdI?=
 =?utf-8?B?NjVjV21YR0w5bWtpSnV2VUFSeGR3Y2NpTmVTQ3dPaWYyNVdoRnZzZGhwTndQ?=
 =?utf-8?B?ZGdWMFBkb29GVFJZaCsxK0JSVGw0MkdaWEdGVW5tTk9jcWRsQnhLRDlNZ1Zp?=
 =?utf-8?B?eldyTW1ZSndOS0lwN0NIN2hvcU9QNnRzQkswWnJXdHV6ZWVQRkpORGcwdTdq?=
 =?utf-8?B?dWlla244N3o1NFpidlRxMHJSUEtoMnJobjVJWjRqVWNJaXBtUzRvKzlPdWRl?=
 =?utf-8?B?b3I2MStGNDlEUlR3YlVBNUg1WkduWktLSDFaVzVMTHg0Yk41SG5pS3RMUXh5?=
 =?utf-8?B?WFdsK0hkYkZOS0l4V1RHcVZhcHI2MGJDYmRRSkR4WWV0aVVOMVFQS0pBZ1hW?=
 =?utf-8?B?UVNzUnRPd1JRdFArZUtWd2U0cW5QVDc4Sms4MWtGeWQ2YXhMTE15SWFsRXJM?=
 =?utf-8?B?VWRwZlF5Mkl4RmkrczhYWGo1TzFSb1Y4MHNGSEJYZG9ncUxFWmxOa3I3MW5S?=
 =?utf-8?B?T3F4R1hZci9ZZE1HSDJKUWNYa21BYmRSdzJCbXBCWHBZZGM2YndPR2dHYkhi?=
 =?utf-8?B?VThBV2VzVllGQi9ES05qK3R5YlIyN01qSXZGQWYvTitDamEycmp2c2c4L0d3?=
 =?utf-8?B?NEdGaU9xNGh2dEQ5dm5XOGVUemxFS3Vwc21DYXlTdVhXZTJYdUxJczZPc01v?=
 =?utf-8?B?S0ZjN0UwQmk3RkRXQm12eEdyODc4MHZ5QUFVRWY4cS9XUG5XN0xuempLVmdy?=
 =?utf-8?B?ZmljeGsreFY4NS9zOSt4Smg4a0tkWUd0elo4MnhUTVUxRWhsNEZ2U3Y2bkJG?=
 =?utf-8?B?UlN5M3lYdG45blJMZTNOeFkxa2VlYlg1K3hrQU0zdFJUOThDY2xtM2Q4MTJQ?=
 =?utf-8?B?YkM5UGJycnZoRDlJRkpzaU9kVWJhM1FqNlBEd0F4YUlyYnRrTjVSRTNyZ3FT?=
 =?utf-8?B?TmJrV3o2ckNTR0YzaThsMXBKanlVclY2Y0lzVzFJajRrdFlXRHgrUXVjc0N0?=
 =?utf-8?B?b1g3ZS91RDNPRWpOdkFQYjdMckVmV1dGbU1qSkxqN1hTcDBnaElDZHBmamZO?=
 =?utf-8?B?ektVN2ZVTVJWdnpZR1k2YXdMNlR3cW9oN21UUEdHTkkvWTlObUI1R0JFalVF?=
 =?utf-8?B?YkkwWHZEdW9lTC84ejVZaWZaL1J5TmtoeU5RLzNJaGMzeWFmTzh0OXNqV3c0?=
 =?utf-8?B?cTdiaHlwU0ttRTdjQ3JoT1ppbUwzWWw5dm9xbExPOUY1YUpsQUMvSnp0QXFu?=
 =?utf-8?Q?yAEjdBuvhgvss=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadc025b-e116-4d7d-c6ac-08d8959458be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 00:59:24.8651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zE+pIfR5L+MkaF7zkWVuuAVSU5p7M+lxdf8Z86qxbhW6/pVDN2L5efxUE7JVqWiHRoDDkZbh10P5BE0DNg4tz4syd6fblblkZ8oIXNPNdCl7n1bPWysv4YqL0yFQnin/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5320
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gW4VbpJUkczKeevDoHwnmiF7x4520388AA=
Content-Type: multipart/mixed; boundary="hprpbmObZMYpBSPVvO4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606784376;
 bh=z3TC66qWI4inWaP/CE2de/QkJSU5lYDtlCjnoniAJ40=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=GUQY3bK0gc/Nt4DABisylebv2ZKmymD/e4YIG9tJiYP4904s9CzTY50hi98t/keKTvt
 VGjvkC+6gwT5zePGkwa5GOrPofj1IMg6RXFrztx/4c4pMqZfVxQV1J5sVYIHbxPlehRqT
 JXgn55xhbIbaxWNCVRJ2OyzeixwKHMYVTCc=

--hprpbmObZMYpBSPVvO4R
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkIFByYWJoYWth
ciBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gU2Vu
dDogTW9uZGF5LCBOb3ZlbWJlciAzMCwgMjAyMCAxMToxOSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz
77y377yj4pev77yh77yj77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
OyBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IENjOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCA0LjQueS1jaXAgMDAvMTFdIFJl
bmVzYXMgUlovRzF4IGFkZCBTb0MgZGV0ZWN0aW9uIHN1cHBvcnQNCj4gDQo+IEhpIEFsbCwNCj4g
DQo+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgU29DIGRldGVjdGlvbiBzdXBwb3J0IGZvciBSZW5l
c2FzIFJaL0cxeCBTb0Mncy4NCj4gDQo+IEFsbCB0aGUgcGF0Y2hlcyBhcGFydCBmcm9tIHs3LCA5
LCAxMX0vMTEgaGF2ZSBiZWVuIGNoZXJyeSBwaWNrZWQgZnJvbQ0KPiBMaW51eCB2NS4xMC1yYzYN
Cj4gDQo+IENoZWVycywNCj4gUHJhYmhha2FyDQo+IA0KPiBCaWp1IERhcyAoMSk6DQo+ICAgc29j
OiByZW5lc2FzOiBJZGVudGlmeSBSWi9HMUMNCj4gDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAoNik6
DQo+ICAgYmFzZTogc29jOiBFYXJseSByZWdpc3RlciBidXMgd2hlbiBuZWVkZWQNCj4gICBzb2M6
IHJlbmVzYXM6IElkZW50aWZ5IFNvQyBhbmQgcmVnaXN0ZXIgd2l0aCB0aGUgU29DIGJ1cw0KPiAg
IEFSTTogZHRzOiByOGE3NzQzOiBBZGQgZGV2aWNlIG5vZGUgZm9yIFBSUg0KPiAgIEFSTTogZHRz
OiByOGE3NzQ1OiBBZGQgZGV2aWNlIG5vZGUgZm9yIFBSUg0KPiAgIHNvYzogcmVuZXNhczogSWRl
bnRpZnkgUlovRzFODQo+ICAgc29jOiByZW5lc2FzOiBJZGVudGlmeSBSWi9HMUgNCj4gDQo+IExh
ZCBQcmFiaGFrYXIgKDMpOg0KPiAgIEFSTTogZHRzOiByOGE3NzQ0OiBBZGQgZGV2aWNlIG5vZGUg
Zm9yIFBSUg0KPiAgIEFSTTogZHRzOiByOGE3NzQyOiBBZGQgZGV2aWNlIG5vZGUgZm9yIFBSUg0K
PiAgIEFSTTogZHRzOiByOGE3NzQ3MDogQWRkIGRldmljZSBub2RlIGZvciBQUlINCj4gDQo+IFNp
bW9uIEhvcm1hbiAoMSk6DQo+ICAgZHQtYmluZGluZ3M6IGFybTogcmVuZXNhczogQ29udmVydCAn
cmVuZXNhcyxwcnInIHRvIGpzb24tc2NoZW1hDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL3JlbmVzYXMscHJyLnlhbWwgIHwgIDM3ICsrKysrDQo+ICBhcmNoL2FybS9ib290L2R0
cy9yOGE3NzQyLmR0c2kgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiAgYXJjaC9hcm0vYm9vdC9k
dHMvcjhhNzc0My5kdHNpICAgICAgICAgICAgICAgIHwgICA1ICsNCj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3I4YTc3NDQuZHRzaSAgICAgICAgICAgICAgICB8ICAgNSArDQo+ICBhcmNoL2FybS9ib290
L2R0cy9yOGE3NzQ1LmR0c2kgICAgICAgICAgICAgICAgfCAgIDUgKw0KPiAgYXJjaC9hcm0vYm9v
dC9kdHMvcjhhNzc0NzAuZHRzaSAgICAgICAgICAgICAgIHwgICA1ICsNCj4gIGFyY2gvYXJtL21h
Y2gtc2htb2JpbGUvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAgNSArDQo+ICBkcml2ZXJzL2Jh
c2Uvc29jLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKysNCj4gIGRyaXZlcnMv
c29jL3JlbmVzYXMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ICBkcml2ZXJz
L3NvYy9yZW5lc2FzL3JlbmVzYXMtc29jLmMgICAgICAgICAgICAgfCAxNDcgKysrKysrKysrKysr
KysrKysrDQo+ICAxMCBmaWxlcyBjaGFuZ2VkLCAyMjUgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVuZXNh
cyxwcnIueWFtbA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL3JlbmVzYXMvcmVu
ZXNhcy1zb2MuYw0KPiANCg0KSSByZXZpZXdlZCB0aGlzIHBhdGNoIHNlcmllcywgdGhlcmUgaXMg
bm90IGlzc3VlLg0KSSBjYW4gYXBwbHkgYW5kIHB1c2ggaWYgdGhlcmUgaXMgbm8gb2JqZWN0aW9u
Lg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--hprpbmObZMYpBSPVvO4R
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5911): https://lists.cip-project.org/g/cip-dev/message=
/5911
Mute This Topic: https://lists.cip-project.org/mt/78608799/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hprpbmObZMYpBSPVvO4R--
