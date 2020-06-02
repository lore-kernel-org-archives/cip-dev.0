Return-Path: <SRS0=LeD8=7P=lists.cip-project.org=bounce+64572+4660+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0337C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 08:38:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47976206A2
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 08:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PX9jdZ1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47976206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4660+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id P2NqYY4521723xXhEqJvpkk0; Tue, 02 Jun 2020 01:38:00 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.98])
 by mx.groups.io with SMTP id smtpd.web11.6401.1591087079180906669
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jun 2020 01:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDz4qVIvWStc0MOVIEKRgdZj6d+yaVmqD5Dvt5jhYkMilkK9VRE1lNnjyLdO/MP5EUcJs/5TWNKEIqrBRRoRSHFRmdEtO+GIf/7AnfSlY4Rt5g0qegybp59pT9tDJ3P08J+7LB5KWNqKMhX1BvxWAB2WNdgAPLHqv99TFXfiOnptD/00bZWANdG26+h+ZDxqZoyUG/Acj3yi44YKOXBrsPncp5mb/+dIeJihwphdSDVHgiUyouDAN8YMy/tRm/hZLioHt+PkWCFtZ8XH6Gn4UyYe9MXraRTMeCXi0GzvWUluxAUZcQtN/Z0/62rPlv/vniTPlFrAxIiy3FGkNlEGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJRqDGhth2bfWuOZl7HKhJuHWH4Vnjv4QaHr3DbVDgs=;
 b=W8mJ0YlVeHOjThwWZcDrjU4RSB+rZL8J1OO/yrP3TucQv+/XmAH0c4h27RzaNPkHSH9wsqAQ7og66pR653xieT+f8aK1sXGfAjnlZ8eaw+zan48LN0YJAgviNC0FU+7ITbGHDoKEBRcnYdT+7uztbQUmqmnNIMekZbWwGLK2LqngHr0JlgroVumCxa18KHIyLyc7rTb1ZXt6LxPWs7kEmagVmBTQDbqWJg5hj46iCj/wfu1AaGbZD7/HsJer0fpNpUhhJUTUCktz7sWMHmIMdiBaVykmXkm2ytNTqob6lY/XJtvn5bqbQpjHF0Kk4dRCjp+K3SvW17CTlHd1LWutug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (2603:1096:604:6e::21)
 by OSASPR01MB0009.jpnprd01.prod.outlook.com (2603:1096:603:37::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 08:37:56 +0000
X-Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::95a1:fced:dcb:8ca3]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::95a1:fced:dcb:8ca3%6]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 08:37:56 +0000
From: "Marian-Cristian Rotariu" <marian-cristian.rotariu.rb@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Thread-Topic: [cip-dev] [PATCH v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD
 support
Thread-Index: AQHWM7GDsb80CT+ktkG4UCP9h7+uGai7bxjAgAgzhJCAAR9fQIAASBNw
Date: Tue, 2 Jun 2020 08:37:56 +0000
Message-ID: 
 <OSAPR01MB50285B2DA325948CB05D7231AE8B0@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: 
 <1590534014-2203-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <OSBPR01MB2983BF3C515D310B603EF90192B10@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <OSAPR01MB502894936BCCC76DCBEE8CFFAE8A0@OSAPR01MB5028.jpnprd01.prod.outlook.com>
 <OSBPR01MB2983A075C8031715BBDE37CC928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSBPR01MB2983A075C8031715BBDE37CC928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8eb964d-ed73-405f-5342-08d806d03fcd
x-ms-traffictypediagnostic: OSASPR01MB0009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSASPR01MB000935477F5769C31B5FD6FCAE8B0@OSASPR01MB0009.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 LBpBUXXefRtOFLQ/OI/AlTnUpYr2V3qBTpDEXdtxd341QcZ7WOIV525YLc2gkQ0sh0xbb7CJ2B8gHjl4fEUWm4WbQ9gNBRqPtrEM2dukPL+14LdO6Aco2JWi/EdbbBkJBkxH8ldOm814RG7DQzd3u4EmwC0u0Ori1+6LxRMWDCLSlJ6WFr4cLB0bJ5ktm1jvvCpudmr/z573RPKUrYqrcPSt2zMbIldpJZ4VtrdCREMpe5YeW4++B2IM/v1GHMyAFnOya0aQDjkgSlDZQjfVPEsMySecnblaNaQJvhV3hpGeZ30f+8iibdbySvjfzrtxk7oA5b0BvwzVDPGtoI8UCw==
x-ms-exchange-antispam-messagedata: 
 Tl5g5uWV9qjOUijM6x2KMAK3UFNaS2hzyvaDtRRcA+r6jRPfewcWYJjKv2ZTE9W+F3hBUj7SQ6bxYvxlXzcThO0/c0+lX/YajV9HDnKRSAVw5WvwJG4Xbx4RutkOHlFmbjFGRUY5NrYQwQdPydshAS0tb9vGTA1mAR0nV/cxEhtBy8e1/wk4AuobNI9PdgcT+rR6F1lSzliSfrVorTYV5NZAE/Rgwk3eFVjrz0j+VBeK15/57yPIlQVp7YjyY7q34eM6X3rOm0kmjkrUnhNL9gP9q/Q3YUiuPBH5KYYwr+wiLfxeOZCk/saktZPO3GJttyBIQeMjqjYn0OSZiaOTLXPrk5asRqndppSgfDTMSNFsnnhMfKPi6YJotd2Y88Bh++/SVRA0n/+jHQgFjHntyZPzL3Oemge2uqPAK/Y1Ahft6IUVpC5kBxs/V09fXqRWLFV21ITZeXVprQAeNOzWGu42P3A1D4MBzKpsRfA7Wi6ISxeqjTMS74Wws2CJCfzS
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8eb964d-ed73-405f-5342-08d806d03fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 08:37:56.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9wUUDlWZ3lMtYIZ2PLN/z09Uc7xxrMg9Ow/8NN71HfYyAnwg2z1/Yxb2ONNOH8JjLdtR3G47Hm1OroNkKC3opfnW4GkMkLYP0LZKVPLx7HT3Mld/c5QthDw3S14jvcCGUff2LIQLlSm/63EsIHJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSASPR01MB0009
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1wtXUirTuKMJPNl3OcWjVmQlx4520388AA=
Content-Type: multipart/mixed; boundary="V1BBBAEOREMhqHhkXT16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591087080;
 bh=KbgcPbIvKXhb++SI5PINv0bbqiRTH+cuPAeWbnnjETI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=PX9jdZ1S9bE1Ej4vizZEWLqlZgyJjR0jXkgUWloTDMffgHB8hR/G7y+Skj03NCSOEpW
 daIgFg+aK/haVfhQnj49I3nimelKCgkpXpJI0IlrAxN9gUj2df9MH6wfjm5WzFClBj+iD
 eRYjszCwBWvLX2SW5px9ptH4a3KWxNx38bc=

--V1BBBAEOREMhqHhkXT16
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gPiA+IEkgdGhpbmsgeW91IGZvcmdldCBhZGRpbmcgYSBmaXggdG8gYXJjaC9hcm0v
Ym9vdC9kdHMvaXdnMjBkLXE3LWRiY20tDQo+IGNhLmR0c2kuDQo+ID4NCj4gPiBDYW4geW91IHBs
ZWFzZSBiZSBtb3JlIHNwZWNpZmljPyBUaGVyZSBzaG91bGQgbm90IGJlIGEgY29uZmxpY3QNCj4g
PiBiZXR3ZWVuIHRoZSB0d28gZGV2IGJvYXJkIGNvbmZpZ3VyYXRpb25zLiBJIGRvdWJsZSBjaGVj
a2VkIHRoZSB0d28NCj4gPiBkdHMsIGJ1dCBpdCBzZWVtcyB0byBiZSBubyBpc3N1ZSBhbmQgdGhl
eSByZXNlbWJsZSB3aGF0IGlzIGluIHRoZSB1cHN0cmVhbQ0KPiBrZXJuZWwuDQo+IA0KPiBDb21t
aXQgNmY4OWRkOWU5MzI1ZDA1YjFmNTRkODYwZGJiYzg0YjQyYWE0MDc1OSBwcm92aWRlcyBhIGZp
eCBmb3IgdHdvDQo+IGZpbGVzLg0KPiBUaGUgcGF0Y2ggeW91IHBvc3RlZCBpcyBhcmNoL2FybS9i
b290L2R0cy9pd2cyMGQtcTctY29tbW9uLmR0c2kgb25seSwNCj4gdGhlcmUgaXMgbm8gZml4IGZv
ciBhcmNoL2FybS9ib290L2R0cy9pd2cyMGQtcTctZGJjbS1jYS5kdHNpLg0KPiANCj4gLS0tDQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pd2cyMGQtcTctZGJjbS1jYS5kdHNpDQo+
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaXdnMjBkLXE3LWRiY20tY2EuZHRzaQ0KPiBpbmRleCAwZTk5
ZGYyMTgyNTIuLmVkZTJlMGM5OTliMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
aXdnMjBkLXE3LWRiY20tY2EuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pd2cyMGQt
cTctZGJjbS1jYS5kdHNpDQo+IEBAIC0zOSw3ICszOSw2IEBADQo+ICAmZHUgew0KPiAgCXBpbmN0
cmwtMCA9IDwmZHVfcGlucz47DQo+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gLQlz
dGF0dXMgPSAib2theSI7DQo+IA0KPiAgCXBvcnRzIHsNCj4gIAkJcG9ydEAwIHsNCj4gLS0tDQoN
CkluZGVlZCwgdGhlcmUgaXMgYW4gb3ZlcmxhcHBpbmcgcHJvcGVydHkuIEkgd2lsbCBwb3N0IHYy
Lg0KVGhhbmsgeW91IGZvciBwb2ludGluZyB0aGF0IG91dC4NCg0KTWFyaWFuDQo=

--V1BBBAEOREMhqHhkXT16
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4660): https://lists.cip-project.org/g/cip-dev/message=
/4660
Mute This Topic: https://lists.cip-project.org/mt/74489071/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--V1BBBAEOREMhqHhkXT16--
