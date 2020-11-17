Return-Path: <SRS0=o7Yi=EX=lists.cip-project.org=bounce+64572+5803+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75930C5519F
	for <cip-dev@archiver.kernel.org>; Tue, 17 Nov 2020 08:57:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BDE238E6
	for <cip-dev@archiver.kernel.org>; Tue, 17 Nov 2020 08:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Pj4lXU2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BDE238E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5803+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TZFIYY4521723xsY9ANtkVAw; Tue, 17 Nov 2020 00:57:15 -0800
X-Received: from APC01-HK2-obe.outbound.protection.outlook.com (APC01-HK2-obe.outbound.protection.outlook.com [40.107.130.121])
 by mx.groups.io with SMTP id smtpd.web12.5394.1605603433465909588
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2020 00:57:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEwj3kxWpQccQ19rpLRJ5J7Qku6SoAf9Wbn2L9v/IP6YkocKQjuG2aUBzUXYnXJ2pFaIbmHmmb+nkw9QANeznHiLDKomTO6dPSVYdgSMUITj5ATyx3c7J5Z/Np1lAXyaOSFtClxTue9t0dXvbSNq3KLYB6Ks4JF6LcrVLK7iz81B0FIHrhjABBAr3TuXT33zibTKp6LQBHlaqce1XtI0DyTvKKVbsKh6CPbaJ2TCwfuBwpsgCyyguEr0GHNTUg5B3iuZ4c+Yu8URypPcF7hHBuhNZspGZLu50m1f3XDWXxvxOIIx1wugKxOI4xKulMv1YZQDai1wnBglMMm0tNN37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pjavg4S5/PkTKe8pwN8L1Rf1CKuCPIA2eugyj9L1iQ=;
 b=Voe54lidNDLRnXCD9i0ISO2g8FCQ2BUhTVbCjZvfJR9dPt5N5P8K3WHWddDy5NV/LxVWnXbU4nxWIR7Bf3KuJBtL2/3+jkO0nFglJoKrnzhKXhhIUOEy/upO8WhopLxt1R95io+EI7OSE21aQeXMMgjflxzPfiSPYsofqZFEHQkx7SkwJ+5tyAGxIU6lYPy8KzVf7Qpr+zHpgfGYGlIUB7MqiVChHxjFyuD8LrcL2eNk6W19pePg4NPk5g/raA2UiDkDezOuGigQkBBi7G/XBnWuMt28GkfgTOX94aFyeDBA27s+N/u+OnVj4m0TVqCvtrdLSaeRNepMbNUtPG0V1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TY2PR01MB2700.jpnprd01.prod.outlook.com (2603:1096:404:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 08:57:09 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::bc60:b903:db5a:4abe%2]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 08:57:09 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Joining CIP from Codethink
Thread-Topic: [cip-dev] Joining CIP from Codethink
Thread-Index: AQHWvCBwyQVAWKz2gEO7dPFsR7xZCanMBqDQ
Date: Tue, 17 Nov 2020 08:57:09 +0000
Message-ID: 
 <TY2PR01MB4972E0E72776C8C5E4223DE8A0E20@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
In-Reply-To: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d13e46a5-5641-4da2-3533-08d88ad6c445
x-ms-traffictypediagnostic: TY2PR01MB2700:
x-microsoft-antispam-prvs: 
 <TY2PR01MB2700854DADAF553E6B78DA19A0E20@TY2PR01MB2700.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 YcFExZGtqjtqHBym71vjRvgoyO61RbUCZb3YiL/xZVKN5j3zu1FDAexhPGub+F1aTsjhVaf15haoB1DhRS1wWKEfXRP2Mcc4DSigH6rWNDwcC4p20WGoy4uPfSwKlaby0c9NAn+5oK5p4svpdu0MjDyIWWInUsFDqO4NqYPMltQYU0YeEeV8qS8yEhK2rYdQlHkSNK6jsoJ6tzZNiL9ERF/Oduo3rkTn26oAh0WpBhBABjEdiHOSj9RJsgLFQmAfqYSFbZVWUwbV/EpsvSO11ZILD5/Efu2T1iKBQ+MuwBVR0vNd/idIdDzXOcfz21kZoHH4Y/7RHg5WwFx5k4RlGQ==
x-ms-exchange-antispam-messagedata: 
 rjuGMB/p5uwsTp9gsnM4zZM8b0z1yruLiXJVO9GmzKSlHxBH9UndikkQhKXr6/0Gof2CNSvMD/pTHYtPOuBWveJthzxlme9LbdgDSCIDIqsXmwpOdRB1nsr2nV/n+w8oUIcKEcFrjlYi0UjrRKe9kMnzB3EEJnFEP1DURszVi7viBuEuYRhzX7gDlsGKDmSvkev9VQrD2dwBDAh/wS9zegu3s7Z0Thd/3+6UK85qJ6Ux4RzwT1JBiKSBQ+p2Irsv6YlFue/VKWO3tKGruPWhpMlW9bL7KgDaD1z7jjO0eT3Zb4r8PpZU0tRW2hM3VcxgjUX0rwCl+zH/7yNUkGBwjmH6FPYDbB23W2i6zyjY0OQUtWdYyJxw9af75YmYJjw8XM1at0H2GFoybsAlan0sdO/a0oY+Puf153qWuCflw/yG+iaZlfBiGeF7x6183k/sfiVkGeUDEYnbs9Oyhdcqfa4j9wpF8SaDI0Bt8BMAqP1DAwsMb1VL8GUGKU+IsiNzkFJsA64XiCPODgAUfeDEv1I5Ghd1NAmjIskx3ZG7Ub4Y8a7PiLoPnZ6DV9bNTgKsXCuxrc/jw9+5r/+vK6M2ii2DrD95HeAyvpexvVx+MstvlmjaQyfGYfr1eH4wcMG/IuiTkUInGCA3cU83CdnV8g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13e46a5-5641-4da2-3533-08d88ad6c445
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 08:57:09.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJurQZ6RMIHbBF5WMXPK08m2vORuy3J+yPhSh88SNpIn8u8Rarnf50nd3wKz4t1+ldAjTn3kdy7usZ6rFhibeOCQhsJUr9jrHOlBtjn4avc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2700
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gUOpWSypUzekphlzA0iGBFYmx4520388AA=
Content-Type: multipart/mixed; boundary="WUCYaPtDtWOsBxMFDeZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605603435;
 bh=7IvWvIEkLdNoOSaHNIvP6HOWhlHsnK9phjbe+C1Zmcg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Pj4lXU2uBrmg7SquiyrPMTXl4le0XCr4Tottu9l4/shjWC2jFf7n8rJGOo011Xzb/BG
 UFJB09UEDDThsugFWxtYlp/S4YU6JyQRbonX7Gda3hIEnaHO0MNnrrWc8mUIFsTrU86Ly
 TIARHiCH/n6R4A0a3juf6SLRFaGxIjsLMlk=

--WUCYaPtDtWOsBxMFDeZq
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksIFN1ZGlwLXNhbiwNCg0KV2VsY29tZSB0byBDSVAhIEkgYW0gaG9waW5nIHRvIHdvcmsgd2l0
aCB5b3UgY2xvc2VseSENCg0KQmVzdCByZWdhcmRzLA0KLS0NCk0uIEt1ZG8NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
ZyA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBTdWRpcCBN
dWtoZXJqZWUNCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxNiwgMjAyMCAxMDo1NyBQTQ0KPiBU
bzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIEpv
aW5pbmcgQ0lQIGZyb20gQ29kZXRoaW5rDQo+IA0KPiBIaSBBbGwsDQo+IA0KPiBJIGFtIHN0YXJ0
aW5nIHdpdGggQ0lQIGFuZCB3aWxsIGJlIHRyeWluZyB0byBkbyB3aGF0IEJlbiB1c2VkIHRvIGRv
Lg0KPiBUaG91Z2ggbWFueSBvZiBteSBjb2xsZWFndWVzIGFuZCBleC1jb2xsZWFndWVzIGhhdmUg
d29ya2VkIHdpdGggQ0lQLCB0aGlzIHdpbGwNCj4gYmUgbXkgZmlyc3QgdGltZSBkaXJlY3RseSB3
b3JraW5nIHdpdGggQ0lQIGFuZCBleGNpdGVkIHdpdGggdGhlIGNoYW5jZSB0bw0KPiBjb250cmli
dXRlIHRvIHRoZSBzdXBlci1sb25nLXRlcm0gTGludXggS2VybmVsLg0KPiANCj4gDQo+IA0KPiAt
LQ0KPiBSZWdhcmRzDQo+IFN1ZGlwDQo=

--WUCYaPtDtWOsBxMFDeZq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5803): https://lists.cip-project.org/g/cip-dev/message=
/5803
Mute This Topic: https://lists.cip-project.org/mt/78291887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WUCYaPtDtWOsBxMFDeZq--
