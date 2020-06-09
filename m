Return-Path: <SRS0=MstX=7W=lists.cip-project.org=bounce+64572+4791+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF577C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 11:25:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1393C20812
	for <cip-dev@archiver.kernel.org>; Tue,  9 Jun 2020 11:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="G2iAlYXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1393C20812
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4791+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id d3aWYY4521723xxIkLvSgkAc; Tue, 09 Jun 2020 04:25:31 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.4996.1591701928588283068
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jun 2020 04:25:30 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 059BPPMM021628; Tue, 9 Jun 2020 20:25:26 +0900
X-Iguazu-Qid: 2wHHidEfETbCXAmnmW
X-Iguazu-QSIG: v=2; s=0; t=1591701924; q=2wHHidEfETbCXAmnmW; m=U+71g/5tRws5bHgRevLVU7zszFsFubWgcMkCr8VhH44=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1112) id 059BPONv014202;
	Tue, 9 Jun 2020 20:25:24 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 059BPOBl001569
	for <cip-dev@lists.cip-project.org>; Tue, 9 Jun 2020 20:25:24 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 059BPNpC022660
	for <cip-dev@lists.cip-project.org>; Tue, 9 Jun 2020 20:25:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSxbrDH7DrBWUdp8fKbiIlCXf7tD1ZBy4fGIFnurkQgNRubhyYo8TTMIH7o9rMTNDX+nc4OzHT6SPz9VW+Qz2sRUuGTIIyOqe1601oO++647HtHuxVvJnf+Ijj9ysnt2rmNqZzVJtbRA1DmwGT6UoSCa2p0borpBqHa/DjnayRyS0dFCKKPSTLfFrJ86YqcltZGQSw3aS8OPzu1PDkATJzso7q0FK9MSwP/cavyFJs25KVeTvoToODUQC8cjDmndbx3YcS850SfvWVdRMVOa7NZR6tQdDRRqZe7VulvGXVvlhsLdpSQfGP5j36Ug++7NX6ZUEsI8twUUIyroL4fiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IOvKoq/7LHWakLlQgrSHcunnLl8lLSN2hfly6dmRIk=;
 b=OpHkitnGEbTeIN9iWVcjfw1Ij+DXD/KjFnhKyQujblFpWcpanV6sTYWgtBndIMK86SyxE34/TEyQY8sUoU6mDTsKR4QKzNmSn+EtP+YNt65pWOVHpNvZT/5EfwvvWeLzTB0WuOl4JNP9+fhSJJlXzC6FzUwfU1DYZmsWOJFr9VutVxbSz0NDDtPikdwHkhy6b18hJOceUrKRb6xNl9IEv7avycnzZBHqOMWK/FOjCCvrvTojlwennc5+thlDFuIUztFvwTe9BhakFpWCuCCV6limUXKYvWt09g9VCOwL6x45zZZXIaKqc0lVK6YjpH8hKgK2SaPRgryRuFUJPxwL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] isar-cip-core and cip-kernel-config
Thread-Topic: [cip-dev] isar-cip-core and cip-kernel-config
Thread-Index: AQHWPkTxVR3D2hSN9E6dp3Qwbhm+7qjQJLZQ
Date: Tue, 9 Jun 2020 11:25:22 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB2064955529EA8A3DF3B90702D0820@TYAPR01MB2064.jpnprd01.prod.outlook.com>
References: <e9ae3b47-7f38-0da3-b90c-b0b4dbdf1eae@siemens.com>
In-Reply-To: <e9ae3b47-7f38-0da3-b90c-b0b4dbdf1eae@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3a42bb0-ada9-464e-fe2b-08d80c67cc60
x-ms-traffictypediagnostic: TYAPR01MB5151:
x-microsoft-antispam-prvs: <TYAPR01MB51518A06BD08C6B758CE15FFD0820@TYAPR01MB5151.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OJ7VqjCPB1G9JO2+ZY0aZMwjNpmlaAH9Z9VG/sEK2y1TwUyrcIFkNxDt1V+O2LVoCAbDoRW2zU2FhBdDvgba98Es/JWyEsrkLU162YNiS1NklYEkfCSF01loIaXFbQs5WIBg4fF+94cwdSRxJa1E5nwz/gH9jV/Bd/FNq49P4cz6SLKFLQ3UgRnVR+w5xL2O2S9KmMP8ZTsUbq0i0kUKrFjt2fOP1ug2USUFdxU8B2TIslb11DYYSCo5OlQGqpeJwAxi+z44a+CwB4t8IUhfym5g7xJiD7jONgPbu4NMGcZr6G8pyREyVysWJgedsJRQ
x-ms-exchange-antispam-messagedata: EkpYpBa96UUoNSpIiNrunL1S3qD2o0GcXG7dYcJl75j3ZXSnhECueCEjeVGaAdVmSkXbk4nZ4ME2IW8vsLU1bP85GKifpDy1jnSBCikHOSnxgFCVdCKUPc9okRFVQf6Whvvp1QIu3zc2/VhHJqtKsSFe9fwEZx6kGfXPsRbYIh+RtT6qp2i8UzBG0UotMWZmx9dqYVLDRZ28YmM+S0vrzkIw9V0BYu4aVeSVqwqTtiWVfwxRCw7VvjhrVFdqV6tqSL+j6SmLY0qOu3vDedl5YII05b6ws0pPMMPM/g7+snSR+neT3oynYnGyVL+fg9a+M84wiKAG+eFTZ6hZdbxuQGgVZbayp8WPFSI+Xx6xQ+htTQS57P97/5bPcD0pPrHskfMs3Gf6NAlRqfuAwydMUWJ2RQns+K5LslalgnpCfEhGb9P4Q+8YTBsgsWsFOvMKFbjepHYLUCXOlKJ8xPL12zy29bOsAfRKdeBx29A/g4g=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a42bb0-ada9-464e-fe2b-08d80c67cc60
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 11:25:22.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcI20EzjBNhJUnZkuuzDHgjhH8dvxU/qVnrPdcRIkAMc8YO6h+/Ja1ZMJleyWsmWtyNAIBPzS0Qy0qtDvJBeSqpR04nW7LtETZ+mpWx4ICI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5151
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6ECa7GJI4bZmiVeycRvD4BXgx4520388AA=
Content-Type: multipart/mixed; boundary="z5XbRcelTuwFbfzokkeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591701931;
 bh=blyACrmPAHSVFViN27dI7XsYnu7TeQK2vyjpFpdPf1Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=G2iAlYXAmCVmrgrYJ5gMgIcrmZ7yJdNQtBIzOd7ebEjWZp85mcFciNMnO9VjfSDiChk
 K1hOm39Gujxk2D7r9HoYf2yzYwqkQ7qHTzNWTuMET7PWtmkSGBnPE232/iucW1/JJ9Liw
 0XCA+DhkAVu7Q+zppav+A4ijSXuI1EE8m6A=

--z5XbRcelTuwFbfzokkeX
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

R29vZCB0byBrbm93IEphbiwgdGhhbmtzIGZvciB0aGUgdXBkYXRlLg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4g
U2VudDogVHVlc2RheSwgSnVuZSA5LCAyMDIwIDc6MDEgUE0NCj4gVG86IGNpcC1kZXYgPGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gaXNhci1jaXAt
Y29yZSBhbmQgY2lwLWtlcm5lbC1jb25maWcNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IGEgcXVpY2sg
Zm9sbG93LXVwIGZyb20gb3VyIGNpcC1jb3JlIG1lZXRpbmcgdG9kYXk6DQo+IA0KPiBpc2FyLWNp
cC1jb3JlIGlzIGFscmVhZHkgYWJsZSB0byBwdWxsIGNvbmZpZ3MgZnJvbSBjaXAta2VybmVsLWNv
bmZpZy4gSXQNCj4gZG9lcyBzbyBmb3IgYWxsIG1hY2hpbmVzIHdoZXJlIFVTRV9DSVBfS0VSTkVM
X0NPTkZJRyA9ICIxIiwgaWUuDQo+IGhpaG9wZS1yemcybSwgaXdnMjBtIGFuZCBzaW1hdGljLWlw
YzIyN2UuIFNvIHdlICJvbmx5IiBuZWVkIHRvIGNoZWNrIHRoZQ0KPiBvdGhlciB0YXJnZXRzIGFu
ZCBzZWUgaG93IHRoZXkgY2FuIGJlIG1pZ3JhdGVkLg0KPiANCj4gQW5kIHdlIHNob3VsZCByZW1v
dmUgdGhlIG9sZCBkZWZjb25maWdzIGZyb20gaXNhci1jaXAtY29yZSB0aGVuIChzb21lDQo+IGNv
dWxkIGFscmVhZHkgZ28pLg0KPiANCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBDb3Jw
b3JhdGUgVGVjaG5vbG9neSwgQ1QgUkRBIElPVCBTRVMtREUNCj4gQ29ycG9yYXRlIENvbXBldGVu
Y2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

--z5XbRcelTuwFbfzokkeX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4791): https://lists.cip-project.org/g/cip-dev/message=
/4791
Mute This Topic: https://lists.cip-project.org/mt/74770939/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--z5XbRcelTuwFbfzokkeX--
