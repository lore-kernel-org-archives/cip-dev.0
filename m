Return-Path: <SRS0=EZCl=5S=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B19C43331
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 08:23:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C4B2080C
	for <cip-dev@archiver.kernel.org>; Thu,  2 Apr 2020 08:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="QWe7HDX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C4B2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C657488046;
	Thu,  2 Apr 2020 08:23:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 487NEU9w5SIb; Thu,  2 Apr 2020 08:23:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9CC6388031;
	Thu,  2 Apr 2020 08:23:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81E7AC07FF;
	Thu,  2 Apr 2020 08:23:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00A77C07FF
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 08:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DDEC686FCD
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 08:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P9miiDX81A8r for <cip-dev@lists.cip-project.org>;
 Thu,  2 Apr 2020 08:23:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320098.outbound.protection.outlook.com [40.107.132.98])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 44EDE86F6A
 for <cip-dev@lists.cip-project.org>; Thu,  2 Apr 2020 08:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOWMi96u6fadUNo+s+PNVixNBp1sVSwGnvw8XAw5tFECFdPPFXhHYd6OzAdn2xKFQZrdAfXCHtwdX8I9UcsTd1q7tcIMwz3CUTpBDnPU0IHnaLrLV/76lmeYWup1wLoKW1E7f6jWU0LSbjaDDeqQafEXJi7L8B09pOsgwuYDJ2iyWh0ZN4VLsYKT6tAlmhu5FN2meWD6jF5MCO6e8Jxfhl6g0r7IsgesWJ/jPzpzzwbhYguagBLaR92JFwb/I+1HRIar7rLqlxkEjhDRfR0FBrjOLj06to/yRqpyBqElzR+ESvcP/9kI/9lG75v3UAY/0xt3nBqjsD18f5tfdELDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ5NPKlWvQsRYEIYMc3oIloKVhg+e8wzeJEKXCZYv8I=;
 b=cz/+WHnOQ4CY6SL9mR2b339UYHvYqNjxSP20HPyLVw40B/7VNEUDTKvah6IlOppORl0zEmdvgeUpLX+diQb54KYhqAKxfuv64OCd9ptfSoHjjGTbLa/D9/Qd+DIQHUF/Bxm6AjXiuO7Z60sMe94FdmyZ1Q7oO8kdFl1RkMjmmLfLQS8TOFUDwvYtEFOOVDVUIJoRZHfkzjElaOcD5wgcF/xYO1OClT1Qa/znVkeJgELzGmfOTsutse7XeQWJI/WtOWUojRXjCmyK2pQShW46u7yMNewGZ0XqwQdGWBAkABiG4YfYG5X59jMeywlvN26tBsR4YyV0gJkGT+zegw2xbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ5NPKlWvQsRYEIYMc3oIloKVhg+e8wzeJEKXCZYv8I=;
 b=QWe7HDX9Drbx3G+Ld/nJvy1/5gZ6dWhyPIeY2v9X8EHz/ZX8/aO3SlxU0zMjyU7H/hVdxk8m/Cr8Zs2oldYWwaNhQJgsrW/vi44QBdLFniaesgcekgHN/qY32Nbo/U0wspu3KIUBB5kMsQuxdg5+TplHMCjR8WdZTndwylwJjdY=
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (20.179.172.148) by
 TY2PR01MB3004.jpnprd01.prod.outlook.com (20.177.98.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 08:22:59 +0000
Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::e845:c7d4:4f:c3cc%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 08:22:59 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdYIhZVqicFEP+tqR9SIqW8yobQpWwAQWk8gAAA0whA=
Date: Thu, 2 Apr 2020 08:22:59 +0000
Message-ID: <TY2PR01MB49724A19CF5B5D2EEC096143A0C60@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: <TY2PR01MB49720341AA7BCA1D28EF8480A0C60@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <OSAPR01MB36671AB755C81D301FF1773092C60@OSAPR01MB3667.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB36671AB755C81D301FF1773092C60@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [219.123.27.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13656891-4605-48c6-f545-08d7d6df0dbe
x-ms-traffictypediagnostic: TY2PR01MB3004:
x-microsoft-antispam-prvs: <TY2PR01MB300457A13D35113D26C59CD5A0C60@TY2PR01MB3004.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4972.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(478600001)(2906002)(6506007)(76116006)(9686003)(7696005)(33656002)(110136005)(5660300002)(66946007)(66446008)(66556008)(64756008)(53546011)(55016002)(66476007)(316002)(966005)(52536014)(85182001)(71200400001)(186003)(81166006)(86362001)(26005)(81156014)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bjR1aRVBwo9YVAmSRSRSkzOWkq8FbsFUcOfToPinDGQ3B42pQRoVYHBfwaoCX9/8sfI23DFA80Ju7qSUp11ozC58ziw5pzLM904UHbuGB2mrKZAoEsJv0666jmBcBMK0B0OJlhFZzSqVYI520eTl7XFx1IVWbI3P7q3E8CrHz4wwGUY4Pyp7Oi1nKoI5nlZwqFl/rz+Ro+k6cT2V3HunXpHk5Ubl1iO0EaOQoWf2ROFYYkektjjGWgjiQ5d0yujFU6QLg/x+PG8ZA/ctzgQTp9U5F7cyoPGJHVumRMET56iqoHsDIWKamR4F0s+roCQ3d/X9JD6xaYTV8VipNgD7FRJlbxLg5/j9zi6r4fBoVyc2H0ZpvJTwfg+RaQ8OyDW6Gwvw7ZMyL26P2S/4p3KRYD0AvyWRitI5FVZCkgU3p4m9mUOxIYW+Gl9J3/BCw55KXx//WgW4hp+Ypn57ff9oSySCPdTlQLEerNt0G4cQnJlnWFeKeRya0QuoKoheA1ESePeSKReGZbsC6qA5rHhTXg==
x-ms-exchange-antispam-messagedata: LSafpAA2fyERrVEXETWsvqHoLhaAlxIuiCY+t2DSSjDGpgEDdtpjL4qwBXZvj68gV4y5QBTlohKiujpJfrbcmBWeYZqdmbmoySKobXgkBvZge82VTpU9ZrBk7Rct1iMyg23XX+b8zs5u2yGyovzFNA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 13656891-4605-48c6-f545-08d7d6df0dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 08:22:59.2464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6Pq281VCO0StcYQWdi/WpelV+FdOsLb8OiJuDs4j1tlFJZUH82UFIITXmysic2pxfwVQXnYZjcvGmo1LK0hyype2RpJTkHMlnm2oJV6zfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3004
Subject: Re: [cip-dev] CIP IRC weekly meeting today
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

SGksIEl3YW1hdHN1LXNhbiwNCg0KTm90ZWQuIFRoZW4sIHNlZSB5b3UgbmV4dCB3ZWVrIQ0KDQpC
ZXN0IHJlZ2FyZHMsDQotLQ0KTS4gS3Vkbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogbm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanAgPG5vYnVoaXJvMS5pd2FtYXRz
dUB0b3NoaWJhLmNvLmpwPiANClNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyLCAyMDIwIDU6MTkgUE0N
ClRvOiDlt6Xol6TjgIDpm4Xlj7jvvIhDVErjgIBPU1Pkuovmpa3mjqjpgLLlrqTvvIkgPG1hc2Fz
aGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
ClN1YmplY3Q6IFJFOiBDSVAgSVJDIHdlZWtseSBtZWV0aW5nIHRvZGF5DQoNCkhpLA0KDQpTb3Jy
eSwgSSBjYW4gbm90IGpvaW4gSVJDIG1lZXRpbmcgdG9kYXkuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldiBbbWFpbHRvOmNpcC1kZXYtYm91bmNlc0BsaXN0
cy5jaXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiANCj4gT2YgbWFzYXNoaS5rdWRvQGN5YmVydHJ1
c3QuY28uanANCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIsIDIwMjAgOTozMCBBTQ0KPiBUbzog
Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJ
UkMgd2Vla2x5IG1lZXRpbmcgdG9kYXkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSBy
ZW1pbmRlZCB0byBhdHRlbmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1
c3MgDQo+IHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5Lg0KPiANCj4gKlBs
ZWFzZSBub3RlIHRoYXQgdGhlIElSQyBtZWV0aW5nIHdhcyByZXNjaGVkdWxlZCB0byBVVEMgKEdN
VCkgMDk6MDAgDQo+IHN0YXJ0aW5nIGZyb20gdGhlIGZpcnN0IHdlZWsgb2YgQXByLiBhY2NvcmRp
bmcgdG8gVFNDIG1lZXRpbmcqDQo+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNs
b2NrL21lZXRpbmdkZXRhaWxzLmh0bWw/eWVhcj0yMDIwDQo+ICZtb250aD00JmRheT0yJmhvdXI9
OSZtaW49MCZzZWM9MCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZwND0zNyZwNT0yNDEmDQo+IHA2PTI0
OA0KPiANCj4gVVNXZXN0CVVTRWFzdAlVSwlERQlUVwlKUA0KPiAwMjowMAkwNTowMAkxMDowMAkx
MTowMAkxNzowMAkxODowMA0KPiANCj4gQ2hhbm5lbDoNCj4gKiBpcmM6Y2hhdC5mcmVlbm9kZS5u
ZXQ6NjY2Ny9jaXANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2lyY2xv
Z3MuYmFzZXJvY2sub3JnL21lZXRpbmdzL2NpcC8yMDIwLzAzL2NpcC4yMDIwLTAzLTI2LTA5Lg0K
PiAwMC5sb2cuaHRtbA0KPiANCj4gQWdlbmRhOg0KPiANCj4gKiBBY3Rpb24gaXRlbQ0KPiAxLiBD
b21iaW5lIHJvb3QgZmlsZXN5c3RlbSB3aXRoIGtzZWxmdGVzdCBiaW5hcnkgLSBJd2FtYXRzdS1z
YW4NCg0KTm8gdXBkYXRlLg0KDQoyLg0KPiBTdHJlbmd0aGVuIHN1c3RhaW5hYmxlIHByb2Nlc3Mg
dG8gYmFja3BvcnQgcGF0Y2hlcyBmcm9tIE1haW5saW5lL0xUUyAtIA0KPiBLZXJuZWwgVGVhbSAg
Mi0xLiBXb3JrZmxvdyBmb3IgaWRlbnRpZnlpbmcgaW1wb3J0YW50IGZpeGVzLCANCj4gYmFja3Bv
cnRpbmcsIGFuZCByZXZpZXdpbmcgdGhlbSAgMi0yLiBQcmVwYXJlIHRoZSB0b29scyB0byBiZSB1
c2VkIGZvciANCj4gdGhpcyB3b3JrZmxvdyAyLTMuIEdldCBwcmFjdGljZSBpbiBiYWNrcG9ydGlu
ZyBwYXRjaGVzIDMuIFVwbG9hZCBhIA0KPiBndWlkZWxpbmUgZm9yIHJlZmVyZW5jZSBoYXJkd2Fy
ZSBwbGF0Zm9ybSBhZGRpdGlvbiAtIG1hc2FzaGk5MTANCj4gDQo+ICogS2VybmVsIG1haW50ZW5h
bmNlIHVwZGF0ZXMNCg0KTm8gdXBkYXRlLiBCdXQgSSByZXZpZXdlZCBhbmQgY2hlY2tlZCBvdGhl
ciBMVFMga2VybmVsLg0KDQo+ICogS2VybmVsIHRlc3RpbmcNCj4gKiBDSVAgQ29yZQ0KPiAqIFNv
ZnR3YXJlIHVwZGF0ZQ0KPiAqIENJUCBTZWN1cml0eQ0KPiAqIEFPQg0KPiANCj4gVGhlIG1lZXRp
bmcgd2lsbCB0YWtlIDMwIG1pbiwgYWx0aG91Z2ggaXQgY2FuIGJlIGV4dGVuZGVkIHRvIGFuIGhv
dXIgDQo+IGlmIGl0IG1ha2VzIHNlbnNlIGFuZCB0aG9zZSBpbnZvbHZlZCBpbiB0aGUgdG9waWNz
IGNhbiBzdGF5LiANCj4gT3RoZXJ3aXNlLCB0aGUgdG9waWMgd2lsbCBiZSB0YWtlbiBvZmZsaW5l
IG9yIGluIHRoZSBuZXh0IG1lZXRpbmcuDQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJv
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpjaXAtZGV2
IG1haWxpbmcgbGlzdApjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZwpodHRwczovL2xpc3Rz
LmNpcC1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2NpcC1kZXYK
