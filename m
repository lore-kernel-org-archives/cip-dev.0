Return-Path: <SRS0=HqYO=A3=lists.cip-project.org=bounce+64572+4931+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBFEC433E1
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 08:28:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9BC20771
	for <cip-dev@archiver.kernel.org>; Thu, 16 Jul 2020 08:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ux+uSnQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9BC20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4931+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OgPJYY4521723xX6U5OPd0Ug; Thu, 16 Jul 2020 01:28:25 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.11139.1594888102822537409
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Jul 2020 01:28:24 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 06G8SJT1015654; Thu, 16 Jul 2020 17:28:20 +0900
X-Iguazu-Qid: 34trSYR0gGkBNJp1V8
X-Iguazu-QSIG: v=2; s=0; t=1594888099; q=34trSYR0gGkBNJp1V8; m=LoqVTXGP/0aZq10AQBXgyfYB7WZyLiQqFLnsNqATkiQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 06G8SJxa037286;
	Thu, 16 Jul 2020 17:28:19 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06G8SIgh016159
	for <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2020 17:28:18 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06G8SI10017995
	for <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2020 17:28:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsJyzs4uOj85ULCmU5rwRPl4DMbuDJHNJf5gIkuQsaMZ86YI3mi6Kcb0X36isMsrsMl31XF9oedxWR4gI2JyJ1lrgYp8iIekCUq2xhtixfFbnuH65NbSEIxrMiucSBg44OWh8aNNGp1H554FOOK/PNtCsV8eKlJCKIr+3VIElS+YB5RvK6jSrMbcPXMqOw6pKtmREjYEnJT/h0Yx/4J8bkg//56NwGQPpuu6UNKUWxIkN81vIYN7xAJMhntrZI6T9JHEJ8EwUBa4/tpLng3V+DDQXxT5de1Tbgqk179erzWdEuuIEYAUmHeqzJ1hImrnVzF5jB+aJ4ybEZUSwIUk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/ZQgrhtEoJpSB/lT+XTWlXceHjziX3hkwLuomJupeQ=;
 b=kzNejZPAVg3kTBc1SitRlvKHRo6+fHZSzFnMpTJ8FgLTDX5BwNpfA1V24uJRjyWSmcRZ7ZfMfsdLRny787zNG+7WfZ6r/MJi2eKkWn7qJCIrNLRaPW79n6NiScz5aCMdLAAB4YmFoblbnJYRM+m9e0HqUGjIW+zVPJ2bKvNqPXRFD1GZfW2l1UBL4Qf6/sMOOSHAdu3TgLKRiDxS8AlpvJQxBnOJv/0Zqs552huN3Dl0O9UjEfqFZ8Un8UoLOCBBzTspzBhHv4ekChBC4iLv6Mi6tRFiyYSGfO05IkMu1yCoKpejraVGnK7lldJlutq32YF9jUXVr4G46eNore5zfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdZbEHjVmr+4nIOmTZuqD6Y282OipAAOlHGg
Date: Thu, 16 Jul 2020 08:27:59 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29834DE6190B597ED44FCC96927F0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB497247C1E04F817F6E364E73A07F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB497247C1E04F817F6E364E73A07F0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c366d85-9fe0-413c-efc3-08d829622620
x-ms-traffictypediagnostic: OSAPR01MB4817:
x-microsoft-antispam-prvs: <OSAPR01MB4817F076AF0D9D4AA4A646B3927F0@OSAPR01MB4817.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JrH79Mv90N0t9Y6tW6mZsCCmYc+mEDOpYTlKQg56j6nFY1cuy7quuINW7FEXK1StuEWC8ElVaUvFhvjZswq1FvCkBIHaTP8xlwaeDPKsEgcA5AFCTW/KR0WyHcvCmsdMbpwCDMJHMm/IGHqSEbVbJih5NcPz1cFLzRps+lwkRu/xG0La9WPaeK0NnCU4ChP9NnI8kP6WfPfmt5a6YdN/2J/8V6C3dCjSDLi5l5I8gEThhl9glis6WzmEmXchCEfvcTuqrZbmS22yKKkHI84lGToiPH+AuxHq6AI0pGTWKlGgF78lq/jNERmosCiKN+kN0g4HBOBCkD6mZdo1McUPyL/Q5NGVvjhyzz3bf1hh7Cxr9TueRCOtCw/0yiSx0CGvcBTlrdiiiI7llCeFZdrvGA==
x-ms-exchange-antispam-messagedata: L1qqLzMDuX7oxurx7/81iODE2a/2WkamJaqbITy4ukSXgqIC9+vdUvQ4JUPVmcy170EWV6n2UgZ+U8QhoMTHNPhvw8bfy62GEhA66JDFV67qdkH5CVurwoKvBHS1T6x7PdfI5YNTI3qmQ00HEr6Gk87PYfccbs0lrKyOtzO4ipabKkKJkVNf4cGQGhgOBOYIyBvT9alXb8GN3A6sFALWGB1rjHP8KlN/jQBI7Hqqu0wPEHZzdGqpVNPKzniIxPT3Dgm+I5v0ynGeZKG551EGyy4YfyOVOflYtVSETn1QnxfrRsjPtEC3YFNPAE52QZBEpN3EUOdpgRJdXzf9vTfNqYONewcXEWgCwv/FvV+V+n2/eVZYRq+s9GBJHhUHRYXBQi/zbCS6mSGjNvZemyBqJFOfFU020AKz5s0yWyp5GYwgOPEi+/j2D2n3mN5wGJGEHdIoGnUWJsbqzgovjVKu4y/fpPMNql+3tqBe8Hl/i4Y=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c366d85-9fe0-413c-efc3-08d829622620
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 08:27:59.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8omSRvI0PIVgqCKuzISXLvqkndd83xFu8GLJnxN1snP8AHzl+LjxrxbsDjvNjpQqGQOYkB4uQW5teu16yAjCYk/uFjJt3N9zYYwKdLhf4j3FG1Yra2kzeNBzWdU5ltRE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4817
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0VbVHCkY0rdK9QVtgEzQiiW7x4520388AA=
Content-Type: multipart/mixed; boundary="V9WpG4CCCR0B0uzthKuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594888105;
 bh=VGibqKr6zZa2kuzQr+k8JFfQwr2mAAVYPtI8S1bKIh0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ux+uSnQx/3i4iAODNuuZtyIjgAGl4xNTb1hzUJ1HL9Di+zltkPtoS9IytfWjoQmg+Mm
 CYKz5is29Ay1qdHhVsUN+Jgf18Dc8ZeVSTXQ5VKBdW6CADFqhPfWMSQw3smAaGw/QUENi
 vA3oGGKNjvsGsCZPJP5Jb6LfFBXEnt+OP0w=

--V9WpG4CCCR0B0uzthKuh
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkkgY2FuJ3QgYXR0ZW5kIHRvZGF5J3MgSVJDIG1lZXRpbmcuDQoNCj4gKiBBY3Rpb24g
aXRlbQ0KPiAgIDEuIENvbWJpbmUgcm9vdCBmaWxlc3lzdGVtIHdpdGgga3NlbGZ0ZXN0IGJpbmFy
eSAtIGl3YW1hdHN1DQoNCk5vIHVwZGF0ZS4NCj4gICAyLiBQb3N0IExUUCByZXN1bHRzIHRvIEtl
cm5lbENJIC0gcGF0ZXJzb25jDQo+ICAgMy4gSXNzdWVzIHRvIGJlIGZpeGVkIGZvciBzd3VwZGF0
ZSAiY29weXJpZ2h0IGNvcnJlY3Rpb24gYW5kIHNhbHNhIENJIHRlc3RpbmciIC0gaXdhbWF0c3UN
Cj4gDQpObyB1cGRhdGUuDQoNCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KDQpJIHJl
dmlld2VkIDQuNC55LXJjIHBhdGNoZXMuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhh
bGYgT2YNCj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1c3QuY28uanANCj4gU2VudDogVGh1cnNkYXks
IEp1bHkgMTYsIDIwMjAgMTA6MzAgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qu
b3JnDQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5DQo+
IA0KPiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRoZSB3ZWVr
bHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzIHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBD
SVAga2VybmVsIHRvZGF5Lg0KPiANCj4gKlBsZWFzZSBub3RlIHRoYXQgdGhlIElSQyBtZWV0aW5n
IHdhcyByZXNjaGVkdWxlZCB0byBVVEMgKEdNVCkgMDk6MDAgc3RhcnRpbmcgZnJvbSB0aGUgZmly
c3Qgd2VlayBvZiBBcHIuIGFjY29yZGluZw0KPiB0byBUU0MgbWVldGluZyoNCj4gaHR0cHM6Ly93
d3cudGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIw
MjAmbW9udGg9NyZkYXk9MTYmaG91cj05Jm1pbj0wJnNlYz0wJnAxPTIyNCZwMj0NCj4gMTc5JnAz
PTEzNiZwND0zNyZwNT0yNDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QJVVNFYXN0CVVLCURFCVRXCUpQ
DQo+IDAyOjAwCTA1OjAwCTEwOjAwCTExOjAwCTE3OjAwCTE4OjAwDQo+IA0KPiBDaGFubmVsOg0K
PiAqIGlyYzpjaGF0LmZyZWVub2RlLm5ldDo2NjY3L2NpcA0KPiANCj4gTGFzdCBtZWV0aW5nIG1p
bnV0ZXM6DQo+IGh0dHBzOi8vaXJjbG9ncy5iYXNlcm9jay5vcmcvbWVldGluZ3MvY2lwLzIwMjAv
MDcvY2lwLjIwMjAtMDctMDktMDkuMDAubG9nLmh0bWwNCj4gDQo+IEFnZW5kYToNCj4gDQo+ICog
QWN0aW9uIGl0ZW0NCj4gICAxLiBDb21iaW5lIHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtzZWxmdGVz
dCBiaW5hcnkgLSBpd2FtYXRzdQ0KPiAgIDIuIFBvc3QgTFRQIHJlc3VsdHMgdG8gS2VybmVsQ0kg
LSBwYXRlcnNvbmMNCj4gICAzLiBJc3N1ZXMgdG8gYmUgZml4ZWQgZm9yIHN3dXBkYXRlICJjb3B5
cmlnaHQgY29ycmVjdGlvbiBhbmQgc2Fsc2EgQ0kgdGVzdGluZyIgLSBpd2FtYXRzdQ0KPiANCj4g
KiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRlcw0KPiAqIEtlcm5lbCB0ZXN0aW5nDQo+ICogU29m
dHdhcmUgdXBkYXRlDQo+ICogQ0lQIFNlY3VyaXR5DQo+ICogQU9CDQo+IA0KPiBUaGUgbWVldGlu
ZyB3aWxsIHRha2UgMzAgbWluLCBhbHRob3VnaCBpdCBjYW4gYmUgZXh0ZW5kZWQgdG8gYW4gaG91
ciBpZiBpdCBtYWtlcyBzZW5zZSBhbmQgdGhvc2UgaW52b2x2ZWQgaW4gdGhlIHRvcGljcw0KPiBj
YW4gc3RheS4gT3RoZXJ3aXNlLCB0aGUgdG9waWMgd2lsbCBiZSB0YWtlbiBvZmZsaW5lIG9yIGlu
IHRoZSBuZXh0IG1lZXRpbmcuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IE0uIEt1ZG8N
Cj4gQ3liZXJ0cnVzdCBKYXBhbiBDby4sIEx0ZC4NCg==

--V9WpG4CCCR0B0uzthKuh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4931): https://lists.cip-project.org/g/cip-dev/message=
/4931
Mute This Topic: https://lists.cip-project.org/mt/75533779/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--V9WpG4CCCR0B0uzthKuh--
