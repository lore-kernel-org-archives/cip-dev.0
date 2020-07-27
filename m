Return-Path: <SRS0=bzaQ=BG=lists.cip-project.org=bounce+64572+5018+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA550C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 05:43:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D23920714
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 05:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hHCJ4m2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D23920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5018+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id C95BYY4521723xhnzC6w1LDq; Sun, 26 Jul 2020 22:43:09 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.92])
 by mx.groups.io with SMTP id smtpd.web10.49575.1595828588362275704
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2020 22:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaYLa1+JxQaxZWIwa5N6Du30HiEcJf36/AeOaBq4IqRfYemwThy/YlKVnPge0dcRj2yp/7QG85lWCjV/HUlKiJeQ2wZys5pPRASDkdvTWlGPe+Da2FcTODynH9C4juUhwsOpkupWp/MfSuKIJes7ZxOfZz/2/DVP6TV2dZpWR4HFdylFRtEJJDxZHoIhPfz2/kSvqk3RUiJnCNAOyPFSX3/CxJD7Jwfdkz++Vi4ZPyiFxGLLsifXE91/NTeujCYqBTXJYL5N83vPGTAh9+8knZZWWKfCaaktgXF3I0pkCEVp+oa75oFeuGUXOOt5MRx3N/NWvWZvZoLL9v3yDyNcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we/6lexAD8Ir0/s8Oc81tctPQUfktQykOkOUFYsX5UE=;
 b=MZdcxNX0YRf7sCykH3SPAQtKeA7/hL3V9fghRUHxTcAHAVW/URET2yQ+nnY8hRT9DZ14ix0yTjD3p+1j91boqU/grK/QhOhN5z66u35aAk5pMGRCumKTRrCKhVAiGdEoVhHuI3Gt0B/iCF8CLYqBCFNQZlFdc9GCRuvy540GqAxnpnsOFn1qIejlGqt44nBqcEEAg+B58QXMForpvIJ80pnZcmRhoIajo7NIE85ntL4Rgw8SHR6DTn7ljIzLudED3XaB85nHM4Gdy0l9kNCcfoZBwfZPT/Tb7AdP7TBuC5Eu+rTnSL5NtUG4E/M2Y2I8jM6pgbE4CcezxZiDo86JEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSAPR01MB2852.jpnprd01.prod.outlook.com (2603:1096:604:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 05:43:05 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70%7]) with mapi id 15.20.3216.031; Mon, 27 Jul 2020
 05:43:05 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: [cip-dev] FW: Final call to participate in the LTS survey
Thread-Topic: Final call to participate in the LTS survey
Thread-Index: AQHWY0mjKp3pr8XVtE64ghVaGtb2wKkaSkcA
Date: Mon, 27 Jul 2020 05:43:05 +0000
Message-ID: 
 <OSAPR01MB2385AD8CD8F3BED3F66F167EB7720@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: <20200726123720.GB20038@layer-acht.org>
In-Reply-To: <20200726123720.GB20038@layer-acht.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.27.142.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e9e09497-1069-4529-d0e1-08d831efef53
x-ms-traffictypediagnostic: OSAPR01MB2852:
x-microsoft-antispam-prvs: 
 <OSAPR01MB2852EABE842DBA6628B70075B7720@OSAPR01MB2852.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 hp+o7QHYvng2aFu+/iP7qPHXzO1JEdKgJD6CDKfxth25PaK8ZJ03nUAgGAOEElRb2q5S0gAygq2KdwBxzaO8rGMOzvDAxAXPHykbRNva5QVlKQw1rkNBbTYKOpQav59viUZIXmzhZSiUySen/GfXSDAEjF/QjFGZMgwAwe0CWX0Z3gMit2yGnDCRnlB/TahpVMQslftsqepl+25GhxZgpSb8U8+/qg999ZzQQpfqoWCcqpECl6Er1Qw0GGUB87sX42M5jY2aGDCpRoRdfTLcnyNG5ze+LUcd6+IDEpaHrCVyYdIYnluIunBy+gExust9jYv6IXyR7JoLinrBi1g+gGSsDW6wkJ3mM0AgpGs9QWk=
x-ms-exchange-antispam-messagedata: 
 Fs7bxLEwlQliSUoYzHHJ76/2Am+/11elHUYShvVo0I5EACRYwp/lwmSTlEorukl5mzxk+TAqLfbQFXpCjDL0TmbdGHeUJl4NKu9/xX0U7VWPhNPyzy1gVNQ+FKNIuVZT0eUwwAU1MYANfVV6egDQQ7AkLXpS3u+OHBZO6jc5dKNAC1AOK1nFHKTsrNApIQeX8x+MVs56FtcyT6r+jliPWTVswrC69P3IvyuF9hp0zUTIci7ddxcIXXzYMI7uaFCF5mIYTHNJDWUhCOBt/VKjL5lhNSmTwcb9rw+RwYOHdzTNslaaSxXrWRDez591Uqj/VtjeRWLMtHu5YCJJ9NFEpk6FH1X3iYNyTxmLkJZe2ZEXyZvEENJm6OHbNzgHJY8OnQjwLuFU480FbSV0qAq2mvkWu/BjARV0L2Am6RcSmRiOztl95yb2/Uxq5fYDfr3GEnIRCmRMLLX/8j9v9ddtl3pje1Ux6vOX7+N1xaJZH34=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e09497-1069-4529-d0e1-08d831efef53
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 05:43:05.3438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMGiugOxUv871JPTML1oQvKoCzfgD1Nn76bRzGJyrh77BmakxbbbxgFExckRXZTIpiLIq3csMbsYB9Tdvv+COOfXXS08Kfk1KBzj2dBtkBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2852
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UwHGWIaUGXGY8PUmRQayWFVyx4520388AA=
Content-Type: multipart/mixed; boundary="E08eslyjBh5lpM6zyIBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595828589;
 bh=sCtTNf7zjSfgReSXw9czsobl9Hb3lU7tZhk2iN/DffQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hHCJ4m2amSFQT34B++J6jjED9GD+JvkZ3SDw2rUk+ZZC+mVm4wGSYYy9CdbZr/XpK8R
 g045WeRYjZaeBWZJ54vpsYobANMzrcdBKzoX+kA9dkvoVxJEHvFnH2l2cCcZJXcxeNHq0
 lsc8zjdBEvf5uJbFO566EJgjNbXlxJkBFdw=

--E08eslyjBh5lpM6zyIBb
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RllJDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiBGcm9tOiBIb2xnZXIgTGV2c2VuIDxob2xn
ZXJAbGF5ZXItYWNodC5vcmc+DQo+IFNlbnQ6IDI2IEp1bHkgMjAyMCAxMzozNw0KPg0KPiBIaSwN
Cj4NCj4gYWZ0ZXIgNiB5ZWFycyBvZiBleGlzdGVuY2UsIHdlIHdhbnRlZCB0byBydW4gYSBzdXJ2
ZXkgdG8gbGVhcm4gbW9yZSBhYm91dA0KPiBob3cgRGViaWFuIExUUyBpcyB1c2VkIGFuZCBwZXJj
ZWl2ZWQuIFlvdSBhcmUgYW1vbmcgdGhlIG1vc3QgaW1wb3J0YW50cw0KPiBMVFMgdXNlcnMgc2lu
Y2UgeW91IGFyZSB0aG9zZSB0aGF0IGJ1aWxkIERlYmlhbiBpbiB0aGUgZmlyc3QgcGxhY2UgYW5k
IGhlbHANCj4gbWFpbnRhaW5pbmcgb3VyIHN0YWJsZSByZWxlYXNlcyBvbiB3aGljaCBMVFMgaXMg
YnVpbGQuDQo+DQo+IFBsZWFzZSB0YWtlIGEgZmV3IG1pbnV0ZXMgdG8gcGFydGljaXBhdGUgaW4g
dGhlIHN1cnZleToNCj4gaHR0cHM6Ly9zdXJ2ZXlzLmRlYmlhbi5uZXQvaW5kZXgucGhwP3I9c3Vy
dmV5L2luZGV4JnNpZD04NTY3OTQmbGFuZz1lDQo+IG4NCj4NCj4gQWxzbywgcGxlYXNlIGh1cnJ5
IHVwLCB0aGUgc3VydmV5IHdpbGwgY2xvc2UgYXQgdGhlIGVuZCBvZiBKdWx5IDI3dGggb24gU2Ft
b2EsDQo+IHdoaWNoIGlzIGluIHJvdWdobHkgNDhoIGZyb20gbm93Lg0KPg0KPg0KPiAtLQ0KPiBj
aGVlcnMsDQo+IMKgwqDCoMKgwqAgSG9sZ2VyDQo+DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaG9sZ2VyQChkZWJpYW58cmVwcm9kdWNp
YmxlLWJ1aWxkc3xsYXllci1hY2h0KS5vcmcNCj7CoMKgwqDCoMKgwqDCoCBQR1AgZmluZ2VycHJp
bnQ6IEI4QkYgNTQxMyA3QjA5IEQzNUMgRjAyNiBGRTlEIDA5MUEgQjg1NiAwNjlBIEFBMUMNCg==

--E08eslyjBh5lpM6zyIBb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5018): https://lists.cip-project.org/g/cip-dev/message=
/5018
Mute This Topic: https://lists.cip-project.org/mt/75817013/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--E08eslyjBh5lpM6zyIBb--
