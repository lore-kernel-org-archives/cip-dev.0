Return-Path: <SRS0=gub+=EQ=lists.cip-project.org=bounce+64572+5784+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC846C388F7
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 04:24:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021202068D
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 04:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MBzz8JX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021202068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5784+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aeI6YY4521723xezM6OrmMZs; Mon, 09 Nov 2020 20:24:14 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web08.23275.1604982252933640741
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 20:24:14 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0AA4O4ps007130; Tue, 10 Nov 2020 13:24:04 +0900
X-Iguazu-Qid: 34tr8pqEIxnFRzp2n6
X-Iguazu-QSIG: v=2; s=0; t=1604982244; q=34tr8pqEIxnFRzp2n6; m=hwiihB09k0+fvX5kxzR5DOsBZKM8eB9iCAJ0YgMOJn8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 0AA4O3tX012436;
	Tue, 10 Nov 2020 13:24:03 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0AA4O3Zo002901;
	Tue, 10 Nov 2020 13:24:03 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0AA4O2GQ006490;
	Tue, 10 Nov 2020 13:24:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+MOimnSxYTLbSsqSyKH6yx04Sa0JmO0ZyDlNJ6yAJnUi+2d6C8GxHbJX1p5nWwvp9NQfr/0MT5cMH6iBTYfjodAxhocmmjse7ucBr0QQ8xyF36eeCBC8HJDdayZRXQxbaNBVSlhbJTUwd24At59yQJRfxqptxjs5iWHlkWZXtbJorQpcaer9S8e5Mc1kZhNQW59vfJY9D9GH6/wUjlMahRxotNb6ceYoWRA9o01ZD6Ux+8CrmaBR5/Xp9y2G+HyZwlWdVQzfGmVCg2ss7JQ3KkNpzp8qDcqaylFylgKSwgOln5GWspO3fJB1T9EKSZIGiyVyuphUlz/QnxyMINY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUla+iKTxVcGUkI6ipd15Urr/nZfTYgH0kxoBl4e0mg=;
 b=k6ljefXbV+lPRxhCL9OM09Fzs8lBDMlr0vD9Jw5dUvoaVwCRtfzq4UH27exE68P9NAMgJ6jKTsLaiv7R2y+qLxFBYMT7it6agSR9TvHxkIjh3AQs6ZWY/YqoUTY/H+SIe8hllR/RCqCV3YZhwcV51bpBak28gsiAJ4ZLgJ6VmQi+rRmGrQ28fP40mZnBEkyPSA61LsR6WClCUVMzCHtiyxzRhVVef3I9qUJq9evdUxlT0Tz802TtoVhjHm7T/YeiTy0jUM//Mx8Osf+q688XLb+/6sre5PPTPY2uRA1SESFTSrU8GK+GsxUoYXWOt0e4auWUcj0hST9z8YnHq0BaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN, IPMMU, QSPI, RTC
Thread-Topic: [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN,
 IPMMU, QSPI, RTC
Thread-Index: AQHWtrAIwObsHxvcdUqdstTA37mDuqnAxM/g
Date: Tue, 10 Nov 2020 04:24:00 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983D2D88A4E9CE78F41627692E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e2e8369-3d9e-4fc6-4393-08d8853072f2
x-ms-traffictypediagnostic: OSBPR01MB5064:
x-microsoft-antispam-prvs: <OSBPR01MB5064CC0198D75D75C869400B92E90@OSBPR01MB5064.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aYQmwljBgtK8Wvg/z40UyXJb0uwhEax7DcRmOSRY+oBCJwV/cLxhg/NPda8m4t9cgpl+aP0JIgvdSBsRbXUeUsKd30Z8HrMMLUQoSyHA2NcYJoiZpF/kQ9DXKooigYkRPg98viph15cHPaTrACzA+SgX5jyzhPjxCm9RCD/GhfHGOKFf0FRgRjXcP/AHxog1T3ackfgBqd/oHbepnyY3KcVBmWLSZjabQN3YDAImfFCzPHog/fQgXlM8xO6mOmHlIdidZPuheA6aEjT5/0P34yN1/nqRXtrcWcO17cYp8STqQJZ65rVWJ1CSX+uU4JHjcQ4AAQxD4J4NViJrK50yIg==
x-ms-exchange-antispam-messagedata: mqC/Qtnj2yeNpR3jfcSwrSJ+gZomhOINg2+8gv/q0N1ZlugM5SFJ1+LAZ1uNdqCUUHt/j/PiGaeG4jCr8R9h2VewBcQqat1x/wvJ6tlitvY667eZF4wTnZSKB/CQ0UVgZyjK1M5RM82jFHXHZyrb+tqkhJ0GUKiGXgqTc4QaN0KlKY9aNi6SrZ85dK0IM7kSKIwuTpc7Im/c57t6Nq0AGEdEKc/QGVDBHJrCnBnae1Vu/ZR87uv1EFgMQWNmceNmIAzShvm5WQX+jphngGWAhPFJ4IWT8Y5mYY1c+GhQEgytOxf67WwPWdgsj+cN5CPMotcqQNSFg5JF0qyJ50AOKkxis6bFjcH1N+HQYdwYo5D9F/GpSeEM1oE3SWP8urTbm+iojoDLUqUHpTMj+RTKWSO5H+1ExZFnvrL5jXdF2xzt0Si9Wr0QF7eAiH8hqoEdpFMmjJrmjJTB74fLIGCdvX2QU+2E3TU+ZaunZYOZSC4R/zk2Oh34VaG1yhbcPw9YYD9mtJI7R2ta5eBJWxujfcXErgnRKrrfc8DE+pZ6goi7oNi0AbM9DTsSsb3js+kKUdkIICDFmdUKsxrmHkEVGfTshPl2POilvNbEAec009alvgELOTc+sXV19RTNN2tdq7tLBihjuXMdGUSn9hfj02nWK2YfL93Knr6ltXP2NhLdh3GwQZJ7iwONHA6iq6DRYJcs7kEjQId4P2x4F8C9We1vY+KQduOqI97G7VyPB59k2rdQfMSsKrD8s2uubA/AO3GyulI9DIEKS8lAm6QhkCTJ3qTcEJZQBnIlYzQiTWue75TKQo+A032U95H9Zvmyt/8kYlR1+8c7SAuLJVNHMLPlV0C5myanzYKZnTKerCxYJ5SqH27OvCc9TdBq7MyvWEk/RbHfCp5n7OhssF9jUQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2e8369-3d9e-4fc6-4393-08d8853072f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 04:24:00.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LM+Rli7orFpjN3+MzLCeu4o/AxTinNq/ixYFsKctXBKc5t0tN+RvHdSWanlS4w/Gdr2OUooomZT+3zUmXjNZ+WGrMMPuGoABfSiiOK8bMWwqxHGcdU8O34ovAtUI0rU2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5064
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Vk8J2rZd10YNlIjxZJhYscHax4520388AA=
Content-Type: multipart/mixed; boundary="f2uUWuI9OiLuQYodExbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604982254;
 bh=bkZSTHHwn2JZ2hGhzJK041HQYYV1vUYCE1lD8iaUumA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=MBzz8JX5t5e/o9Kq3YnHc86GkKkkZI2XYKPI4zv/fFV7rSS3wIrEY/dff3gbErhiALC
 Avp36+ty+UXP//HYa4emBJAd7ADrTS7/8WBu1NlENYc5m8oEFL09ZM6XPUoZQiOut4Ude
 h6YEEl7Mowox0G/JJdlr2wMmboB2z6Kcnf0=

--f2uUWuI9OiLuQYodExbO
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkIFByYWJoYWth
ciBbbWFpbHRvOnByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbV0NCj4gU2Vu
dDogVHVlc2RheSwgTm92ZW1iZXIgMTAsIDIwMjAgMTI6NTAgQU0NCj4gVG86IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8
s++8t++8o+KXr++8oe+8o++8tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
PjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPg0KPiBDYzogQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggNC40LnktY2lwIDAwLzE0XSBS
ZW5lc2FzIFJaL0cxSCBhZGQgc3VwcG9ydCBmb3IgQ0FOLCBJUE1NVSwgUVNQSSwgUlRDDQo+IA0K
PiBIaSBBbGwsDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIGJlbG93
IHBlcmlwaGVyYWxzIChhbG9uZyB3aXRoIGZpeGVzIHRvDQo+IG1zaW9mIGRyaXZlciksDQo+ICAq
IENBTg0KPiAgKiBJUE1NVQ0KPiAgKiBRU1BJDQo+ICAqIFJUQw0KPiANCj4gQWxsIHRoZSBwYXRj
aGVzIGhhdmUgYmVlbiBjaGVycnkgcGlja2VkIGZyb20gdXBzdHJlYW0ga2VybmVsLg0KPiANCj4g
Q2hlZXJzLA0KPiBQcmFiaGFrYXINCj4gDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAoMik6DQo+ICAg
c3BpOiBzaC1tc2lvZjogQXZvaWQgd3JpdGluZyB0byByZWdpc3RlcnMgZnJvbSBzcGlfbWFzdGVy
LnNldHVwKCkNCj4gICBzcGk6IHNoLW1zaW9mOiBJbXBsZW1lbnQgY3MtZ3Bpb3MgY29uZmlndXJh
dGlvbg0KPiANCj4gTGFkIFByYWJoYWthciAoMTIpOg0KPiAgIEFSTTogZHRzOiByOGE3NzQyLWl3
ZzIxbTogU29ydCB0aGUgbm9kZXMgYWxwaGFiZXRpY2FsbHkNCj4gICBBUk06IGR0czogcjhhNzc0
Mi1pd2cyMW06IEFkZCBSVEMgc3VwcG9ydA0KPiAgIHNwaTogcmVuZXNhcyxyc3BpOiBBZGQgcjhh
Nzc0MiB0byB0aGUgY29tcGF0aWJsZSBsaXN0DQo+ICAgQVJNOiBkdHM6IHI4YTc3NDI6IEFkZCBR
U1BJIHN1cHBvcnQNCj4gICBBUk06IGR0czogcjhhNzc0Mi1pd2cyMW06IEFkZCBTUEkgTk9SIHN1
cHBvcnQNCj4gICBBUk06IGR0czogcjhhNzc0Mi1pd2cyMWQtcTc6IEFkZCBTUEkgTk9SIHN1cHBv
cnQNCj4gICBwaW5jdHJsOiBzaC1wZmM6IHI4YTc3OTA6IEFkZCBDQU4gcGlucywgZ3JvdXBzIGFu
ZCBmdW5jdGlvbnMNCj4gICBkdC1iaW5kaW5nczogY2FuOiByY2FyX2NhbjogQWRkIHI4YTc3NDIg
c3VwcG9ydA0KPiAgIEFSTTogZHRzOiByOGE3NzQyOiBBZGQgQ0FOIHN1cHBvcnQNCj4gICBBUk06
IGR0czogcjhhNzc0Mi1pd2cyMWQtcTc6IEFkZCBjYW4xIHN1cHBvcnQgdG8gY2FycmllciBib2Fy
ZA0KPiAgIEFSTTogZHRzOiByOGE3NzQyLWl3ZzIxZC1xNy1kYmNtLWNhOiBBZGQgY2FuMCBzdXBw
b3J0IHRvIGNhbWVyYSBEQg0KPiAgIEFSTTogZHRzOiByOGE3NzQyOiBBZGQgSVBNTVUgRFQgbm9k
ZXMNCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3JjYXJfY2FuLnR4dCAg
fCAgIDMgKy0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktcnNwaS50eHQgICAg
ICB8ICAgMSArDQo+ICAuLi4vYm9vdC9kdHMvcjhhNzc0Mi1pd2cyMWQtcTctZGJjbS1jYS5kdHMg
ICAgfCAgMTEgKysNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3I4YTc3NDItaXdnMjFkLXE3LmR0cyAg
ICAgICB8ICA1MiArKysrKysrKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0Mi1pd2cyMW0u
ZHRzaSAgICAgICAgIHwgIDc5ICsrKysrKysrKysrLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhh
Nzc0Mi5kdHNpICAgICAgICAgICAgICAgIHwgIDkwICsrKysrKysrKysrKysrDQo+ICBkcml2ZXJz
L3BpbmN0cmwvc2gtcGZjL3BmYy1yOGE3NzkwLmMgICAgICAgICAgfCAxMTIgKysrKysrKysrKysr
KysrKystDQo+ICBkcml2ZXJzL3NwaS9zcGktc2gtbXNpb2YuYyAgICAgICAgICAgICAgICAgICAg
fCAgOTIgKysrKysrKysrKystLS0NCj4gIDggZmlsZXMgY2hhbmdlZCwgNDE4IGluc2VydGlvbnMo
KyksIDIyIGRlbGV0aW9ucygtKQ0KDQpJIHJldmlld2VkIHRoaXMgcGF0Y2ggc2VyaWVzLCB0aGVy
ZSBpcyBub3QgaXNzdWUuDQpJIGNhbiBhcHBseSBhbmQgcHVzaCBpZiB0aGVyZSBpcyBubyBvYmpl
Y3Rpb24uDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K

--f2uUWuI9OiLuQYodExbO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5784): https://lists.cip-project.org/g/cip-dev/message=
/5784
Mute This Topic: https://lists.cip-project.org/mt/78138424/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--f2uUWuI9OiLuQYodExbO--
