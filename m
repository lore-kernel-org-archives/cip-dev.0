Return-Path: <SRS0=z47B=EZ=lists.cip-project.org=bounce+64572+5807+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC86C5519F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 03:20:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC2620679
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 03:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DYbLZX8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC2620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5807+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GNZHYY4521723xBqXB4YsnLD; Wed, 18 Nov 2020 19:20:21 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.4175.1605756012140302108
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2020 19:20:13 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0AJ3KASE013091; Thu, 19 Nov 2020 12:20:10 +0900
X-Iguazu-Qid: 34trXZNYeXYU6y3VCy
X-Iguazu-QSIG: v=2; s=0; t=1605756009; q=34trXZNYeXYU6y3VCy; m=eCOL3KIgwbFeBwOCyR4sbY20iUSA6vLVAmqG+MmuUrI=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 0AJ3K9LR022442;
	Thu, 19 Nov 2020 12:20:09 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0AJ3K9Mg018316
	for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2020 12:20:09 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0AJ3K8E0023303
	for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2020 12:20:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOdfAvzor0GJVLa+xyRal+Vm6CcVkRMYB44dCoRZzyg1tDab5rBAPcw1tECbgCUjZ3nUd1u6FbatBLg7JCkufVlBWzheQBTKVRxndTckYFh7BwhUpl7x4MjCAh6EQhiEdmRtxJ4d2Kfj43Rk1B0UcareP6SECy52185lGtpMi63DEoDjrApHId7hUt/fnDZaGd69BUszD6rQgKT0Rg8H1EBfDXx5tlBGJWXnw0ZAwNK/CHVm5UWtVIwNOC6pZBakEJX80fqdZhmBZ8+OjBh/aiKRsTdWJzQRMBWbWJB2/wsGnTAjk8qnNduig++2hMgpNRcVmKHMQs4EzsvtayVHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeV2WCEi/Z2j8Mrj3rRyUzYS/BAozKnf4AFyMz7WWOM=;
 b=Sf8gSy5ueSZpv2iF9y2a1HWx6t/G2bz8af7uZTPw9oVnPEHTSyIdWVLORP1LZjcBaP/LobytyDxEfDlLsv8h07Ft+BPY12WD8H3NEHQXkQ6v+I3SjEWoUnmgSiuFETLD1ax2pEvg82hFLAiEYW3InOqtBQcr1kib01nCUrvcqJmOVgJgb8qo6jQRXthT+I/oXI9z/CeiZobANGWu1Mhyb0aMTEgNqb5UvRbvRUahrLq2ii34saZ0zCdduIDUS3yjkhpOZBjQK38PyjM2H3TDgD9O+zFBbfjM3s9Bcmp1HmD44IRftVDmbe25QxlblKRRYXFgOD/hJix4+kULbMYyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Ada+CY9Fxe+/1yZYSDWZKbr3HXyz7wAF58Mg
Date: Thu, 19 Nov 2020 03:20:06 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29835AC4F2D486107716905C92E00@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972BCCD6681428DE908F4C2A0E00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972BCCD6681428DE908F4C2A0E00@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e928bd10-229d-4141-7d0c-08d88c3a03ab
x-ms-traffictypediagnostic: OSAPR01MB1460:
x-microsoft-antispam-prvs: <OSAPR01MB1460781015BCFD8DF06E82E592E00@OSAPR01MB1460.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hVJiN4jPOOmMKu6G/RjOLDyLwV7taS4ph+2KLQXwNru7um/e24TKK7yNP1+mnvm1J79bsadh7wyXe0GH1Fez1BcWqav+Nkrq6FFejzaBnCzyvCJSpK0NTQtUderKJ4Jav6I43bDIRjfGv4ENNu0Hs6QENJ4I8Vri1bydPY4L4+6NnMD8UpvV1Vg9QwzY+5v7ER9UA4PP5hHdFArvW+HmoG813gi+okrtPTgrCfltAY+L9jxRe0OEag9hyd38U4hYOH0Te73rXUD1pf3mvGWvtA6/SASG0ef/B3q0GlKu05fKZYCuJGK7foCh0qV2ecM4vB7uIRDcJTqiSFBETkh9fD2JrZNX5MI5f2O76rEUGRy8urMzMT9AzGY3WONUOcSeQVKAiy46PIg0hB6a24ylwA==
x-ms-exchange-antispam-messagedata: qOhHmx8D56HSxNY1cyqj5Ph86xxSGx/I12Uc+RhrAuKvh3ClHkjC5DptlFgPYV/3HcwQGsieYmsj+iW2Ig4ijpSR6YatRN0pL5XovtLXRYUppfYoTMuZfEd+MnlqvKRxg21//GHXNeOpxWeOwZS0Yy2SKYRgQIW8LRvQ4VZGi26Qf6bH9/JRSac/xM0zUJZQMuS6tdKSemtU64efC8vhdIFiiGQmkAwc5QqjtE01YcE/4d7tlXQg3xir/KPPT6a3iOAiFWFz6IwxsYVztvTlQYxrozteXjTnjSHsgwXEFDcFGJenYk6ii32lRArNXkqmk4lfAA1kvJaM+eswnxNNk+7XbMPmimvCuErj6hbPXM5Pwr3mJNXvYeVrjGQS9TLqRZCgVbE8Z+zdwckRVtlp0V3NwgmsmNpQxNHbc0WV/0rhepEHsHM/ckToa6ID3TT/9JHkk5lDzHV17JMEc6UBNlWlCBQwJ1v10Tt6VsW2+V65UvswatNmtEyL/aT5bNFdmk5UlsOJj0InARQD+5K2lqcHzoG8/AFl+rADpAfXLByzqdblU+V5XTys3WM3kXkspJnX4cEBZyG5+eM0kpxHGLmGie7SM+FpN1NiiCEa+D2Cn7cWnnVNy5YFTFtIFDVABxPMSRjNnqQ64fQe6yEWFT8q/tgyoZSwI4K6qWg0EbOc341vOomyG9Oc6G/YyU1KIlnQ6wzNcDAtBB1YE06+O0K+kmU81UwghiF0ZVdLRIv+IYJ9Y/ms1EqKq1mcNU8wKfjxlp+UpbTJiUWv/nCKxcGYFfJQRuxxuMmMSd2fmy3u6iDmQ8JnCgBWQ7lKOpS7PwwRLSNa865F6MLIuqv1pQwZSX2/yBOtrxC1/UlJ9HMcdU9EBmWEzWd8Gvk91E4/jc+K8LRa5XIOXgbH64OW3Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e928bd10-229d-4141-7d0c-08d88c3a03ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 03:20:06.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6Uklolej7BEugcd2I26tcIJMi43fh1XGuxbim/O7L4/flVuMREoG1B4t8dCb6z66hULTzibTR0bJGYI4H1U7Me7JNbOSxdBy/W0u7WAF6WbuxTtY4D93GR3K2isLGXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1460
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gWMmS75nXjSwgUqDvoqVqZj6x4520388AA=
Content-Type: multipart/mixed; boundary="N1zDWXzamj8Zbqi36b6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605756021;
 bh=EvPMdmIcRdvbby7oD0Lwgmdlb6NZJMkEpzkT0xTeMhE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=DYbLZX8kj0M8zfyc2M0mGilulRn5+hQka0SgtRLST3fRSSXYhUycW74Jkg69Ndzu/XJ
 1zzLoEvF8sXunLd5hJxmWKMftQJrQ0dDwZOGkqKvwL2QWg3BmrNBjsekVt0XWf+C4Nrxr
 nR3ieY0Cpgq/yhfxPGG/XGKji/SAG/A/kO0=

--N1zDWXzamj8Zbqi36b6y
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgS3Vkby1zYW4sDQoNClNvcnJ5LCBJIGNhbiBub3Qgam9pbiB0b2RheSdzIElSQyBtZWV0aW5n
Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmddIE9u
IEJlaGFsZiBPZg0KPiBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcA0KPiBTZW50OiBUaHVy
c2RheSwgTm92ZW1iZXIgMTksIDIwMjAgOToyMCBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRpbmcg
dG9kYXkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRlbmQg
dGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MgdGVjaG5pY2FsIHRvcGlj
cyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuDQo+IA0KPiAqUGxlYXNlIG5vdGUgdGhhdCB0aGUgSVJD
IG1lZXRpbmcgd2FzIHJlc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAwOTowMCBzdGFydGluZyBmcm9t
IHRoZSBmaXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nDQo+IHRvIFRTQyBtZWV0aW5nKg0KPiBo
dHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9jay9tZWV0aW5nZGV0YWlscy5odG1s
P3llYXI9MjAyMCZtb250aD0xMSZkYXk9MTkmaG91cj05Jm1pbj0wJnNlYz0wJnAxPTIyNCZwMg0K
PiA9MTc5JnAzPTEzNiZwND0zNyZwNT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QJVVNFYXN0CVVL
CURFCVRXCUpQDQo+IDAxOjAwCTA0OjAwCTk6MDAJMTA6MDAJMTc6MDAJMTg6MDANCj4gDQo+IENo
YW5uZWw6DQo+ICogaXJjOmNoYXQuZnJlZW5vZGUubmV0OjY2NjcvY2lwDQo+IA0KPiBMYXN0IG1l
ZXRpbmcgbWludXRlczoNCj4gaHR0cHM6Ly9pcmNsb2dzLmJhc2Vyb2NrLm9yZy9tZWV0aW5ncy9j
aXAvMjAyMC8xMS9jaXAuMjAyMC0xMS0xMi0wOS4wMC5sb2cuaHRtbA0KPiANCj4gQWdlbmRhOg0K
PiANCj4gKiBBY3Rpb24gaXRlbQ0KPiAgIDEuIENvbWJpbmUgcm9vdCBmaWxlc3lzdGVtIHdpdGgg
a3NlbGZ0ZXN0IGJpbmFyeSAtIGl3YW1hdHN1DQoNCk5vIHVwZGF0ZS4NCg0KPiAgIDIuIENoZWNr
IHdoZXRoZXIgQ1ZFLTIwMTktMDE0NSwgQ1ZFLTIwMTktMDE0NywgQ1ZFLTIwMTktMDE0OCBuZWVk
cyB0byBiZSBiYWNrcG9ydGVkIHRvIDQuNCAtIEtlcm5lbCBUZWFtDQo+IA0KDQpBZnRlciBJUkMg
bWVldGluZywgSSBjaGVja2VkIHN0YWJsZSBNTC4gQmVuIHdhcyBzZW5kaW5nIGEgcGF0Y2ggZm9y
IHRoaXMgaXNzdWUuDQogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS9mNWUyZTg3ZmIx
YTk2MTNiMTYxZTYzY2Y1NTA0Y2MzNzVlMDk1ZGJjLmNhbWVsQGNvZGV0aGluay5jby51ay8NCkkg
Y2hlY2tlZCB0aGUgY29udGVudHMgb2YgdGhlIHBhdGNoLCBidXQgdGhlIGNvbnRlbnRzIHdlcmUg
dGhlIHNhbWUgYXMgdGhlIHBhdGNoIEkgcG9zdGVkIHRvIHRoaXMgTUwuDQpBbmQgdGhlc2UgcGF0
Y2hlcyBoYXZlIGJlZW4gYXBwbGllZCB0byBzdGFibGUgdHJlZSwgd2UgY2FuIGNsb3NlIHRoaXMg
QS5JLg0KDQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCg0KSSByZXZpZXdlZCA0LjQu
MjQ0LXJjMS4NCg0KPiAqIEtlcm5lbCB0ZXN0aW5nDQo+ICogQ0lQIFNlY3VyaXR5DQo+ICogQU9C
DQo+IA0KPiBUaGUgbWVldGluZyB3aWxsIHRha2UgMzAgbWluLCBhbHRob3VnaCBpdCBjYW4gYmUg
ZXh0ZW5kZWQgdG8gYW4gaG91ciBpZiBpdCBtYWtlcyBzZW5zZSBhbmQgdGhvc2UgaW52b2x2ZWQg
aW4gdGhlIHRvcGljcw0KPiBjYW4gc3RheS4gT3RoZXJ3aXNlLCB0aGUgdG9waWMgd2lsbCBiZSB0
YWtlbiBvZmZsaW5lIG9yIGluIHRoZSBuZXh0IG1lZXRpbmcuDQo+IA0KPiBCZXN0IHJlZ2FyZHMs
DQo+IC0tDQo+IE0uIEt1ZG8NCj4gQ3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=

--N1zDWXzamj8Zbqi36b6y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5807): https://lists.cip-project.org/g/cip-dev/message=
/5807
Mute This Topic: https://lists.cip-project.org/mt/78354782/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--N1zDWXzamj8Zbqi36b6y--
