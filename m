Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A8C4332D
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 08:20:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AA820724
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 08:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="pARJ3XJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AA820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BC47686A72;
	Thu, 19 Mar 2020 08:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZUwOr43e07-s; Thu, 19 Mar 2020 08:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A363186A47;
	Thu, 19 Mar 2020 08:20:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8856CC07FF;
	Thu, 19 Mar 2020 08:20:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5A37C07FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 08:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C295087FF7
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 08:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MLghMn5jm46p for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 08:20:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410133.outbound.protection.outlook.com [40.107.141.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4861F88271
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 08:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAypmleY6fH3qoyRl+D5l7By+g/JMKGc9EAzebtvXZGtULlZxSMmm08Hctxxel/yBP1155lhXCBLqgyqPcOKfRtu/ct8Yn25TS2N+47/XDg2GCYlSItOY4MVI+6vaCeQqZg9Fr6C7U82Q9LvYSncKQzkm2toAKhig33u+a1U8Qr0UYy5YzIRQaTFbHSgtsfbP4kWaTVB+t8bk+uPHJXR9OZJrzRIpiiJ0Ark3QjyFx/HcRPs29nDbvno8Ct1sRyigPmw+tAeYpwR//M/cDTW8mMaEjfjJj5D3KLcoZabzTOsGMw4ALH2ugtavH5Ddh3JLSE+AcYUlN/auKItC+WXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EemU3Kug4gWnTdVaCWOtpySUJnAY5X7uJPS8jdD41QA=;
 b=Hx0gTCZP9/I1uU6lEnKpWrEwR9OJHcDoBjCqyX6EG943i/NKVDueCteG1fq+G8hrEyg7qJokRCVExBOcRmJkF1gCE7+UuhzWHdZridQiFCir2Mzp+rc5cFYsXhQRlN5IlKOTWKO6/AzXa1Jk9dMGXN36OF11z9YaFK5bunT/4wFLCS+2/+jVAFnvq7uexKQjpaEAUfxFQDqFx39ksNIYmos0Vvxm7nGsWhZInTr0kfKPpGL3pz7SNfvrvmtC6RmsWTMfbxAXAGNlyvAN5zovjUCDek4ZI38SDUsbKOnHnpTRta1h1UkUlutgIyCon22eU7Au0ASttYj/ZoSL5Gm6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EemU3Kug4gWnTdVaCWOtpySUJnAY5X7uJPS8jdD41QA=;
 b=pARJ3XJbGnMI/TW2rl9zG/IRYV+KhY9jcsb4x1INJLwR28CsUbQnlSVlqM+04v16wtgrqiUhOoj98HQ+dYeWFCVppBhizW/vCJQeHtwDFdd6RJJm/EfMgt12/DnhHnUISFt2hlxfi57PFNDD6bhmx7PFaGcf9FeeYcBJveze5Jc=
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com (52.133.160.148) by
 TY1PR01MB1673.jpnprd01.prod.outlook.com (52.133.162.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Thu, 19 Mar 2020 08:20:17 +0000
Received: from TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62]) by TY1PR01MB1481.jpnprd01.prod.outlook.com
 ([fe80::9956:7b5b:8a8e:df62%5]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 08:20:17 +0000
From: <masashi.kudo@cybertrust.co.jp>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdX9dX2slHPoB7r7Sb+Plxao3vu0vgATX9EAAAD/wdA=
Date: Thu, 19 Mar 2020 08:20:17 +0000
Message-ID: <TY1PR01MB1481E7D2085CD00C2BA4EDF2A0F40@TY1PR01MB1481.jpnprd01.prod.outlook.com>
References: <TY1PR01MB1481511E8091785C5D10BAADA0F70@TY1PR01MB1481.jpnprd01.prod.outlook.com>
 <OSAPR01MB3667CF267705F5E8A88BA0FC92F40@OSAPR01MB3667.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB3667CF267705F5E8A88BA0FC92F40@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=masashi.kudo@cybertrust.co.jp; 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9c16815-6229-4b44-da94-08d7cbde5b70
x-ms-traffictypediagnostic: TY1PR01MB1673:
x-microsoft-antispam-prvs: <TY1PR01MB1673288CF67AEB4E9D791D75A0F40@TY1PR01MB1673.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(81156014)(7696005)(316002)(8676002)(52536014)(66476007)(66946007)(86362001)(6506007)(53546011)(8936002)(5660300002)(85182001)(66446008)(76116006)(64756008)(66556008)(55016002)(186003)(33656002)(9686003)(2906002)(110136005)(81166006)(478600001)(966005)(26005)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TY1PR01MB1673;
 H:TY1PR01MB1481.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PnuQtAbDFXjKQMjRDqPNuyf6mx1RpRwmMYTVnbbCU8haI2/laLTHpBCNWOltWblPC2YjlWsjQqX0vIeeh1tlFRQkVc1xB/NmztF0FAe+xF2toeqIyq1XDczZjo/MQVKd5z/ywLQttBXMqNsQHSxIA3z5XYRZv7hcDMOTIEO3HM+N5vseCp4sxi0xsHtr2GiQGiMoRmEEsfUA/pSwczqIN2APHiI4fw/oqcDhvKsxdKk+FyITTJcEoRxVclS7dzyAnk9ZDqM8JBccSWKCTV+4hsOppHNlc0bIhv0nJRpOAKtTi6TsIFtxLlaK6vZlDv61bmgxWR+5Z2oFPKVXq3mkWWa0SaBkvligITqGyNrObksVn+84TBh6gSNNzdgtTflDL8RO6RdEkYM4qncqoxKaLHMzPT7glB571ZvYeH4SDDtGKWeocp+vnYc/qRtEwr9Wamt5xE0Bdnjliz6fbmu24WgGgCJsSZXbFqvGQl1l3DXBx2Rv8+qK1M8RCzo5ePeeAfLfaz2Z074ChL9ZNGN5lQ==
x-ms-exchange-antispam-messagedata: LPA/qDtNYAJRA2YLFFoL0ex6eUcg416XbFGpYRfF0muKGkEc00hh4SWEcpIGKr722acZ7l1lYYMzugwdh+fInfjUiz4UGehlS9MQP7tpyxaKNgik6I7uL/RKRjdS4CQk+SzPd3dhfBzYLmdNKxBXxA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c16815-6229-4b44-da94-08d7cbde5b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 08:20:17.2545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu+CWrIm5hbpEE2A14L5C8zbZIua8NEYL3h4+YbAs91cw5tU3TNPYSXZHl71GMvOpftbtPkXuK1skQgVdaCb+uDwKXPmZHjPqca6j+v+qH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1673
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

SGksIEl3YW1hdHN1LXNhbiwNCg0KVGhhbmtzIGZvciB5b3VyIHVwZGF0ZXMhIEFsc28gdGhhbmtz
IGZvciB5b3VyIG9mZmVyIGFib3V0ICNBSS0yIQ0KV2Ugd2lsbCBkaXNjdXNzIHRoaXMgaW4gdGhl
IElSQy4NCg0KQmVzdCByZWdhcmRzLA0KLS0NCk0uIEt1ZG8NCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4gDQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMTksIDIw
MjAgNToxNyBQTQ0KVG86IOW3peiXpOOAgOmbheWPuO+8iENUSu+8iSA8bWFzYXNoaS5rdWRvQGN5
YmVydHJ1c3QuY28uanA+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU3ViamVjdDog
UkU6IENJUCBJUkMgd2Vla2x5IG1lZXRpbmcgdG9kYXkNCg0KSGkgS3Vkby1zYW4sDQoNCkkgY2Fu
J3QgYXR0ZW5kIElSQyBtZWV0aW5ncyB0b2RheS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBjaXAtZGV2IFttYWlsdG86Y2lwLWRldi1ib3VuY2VzQGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZ10gT24gQmVoYWxmIA0KPiBPZiBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5q
cA0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTksIDIwMjAgNzozNiBBTQ0KPiBUbzogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vl
a2x5IG1lZXRpbmcgdG9kYXkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRl
ZCB0byBhdHRlbmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MgDQo+
IHRlY2huaWNhbCB0b3BpY3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5Lg0KPiANCj4gKlBsZWFzZSBu
b3RlIHRoYXQgdGhlIElSQyBtZWV0aW5nIHdhcyByZXNjaGVkdWxlZCB0byBVVEMgKEdNVCkgMDk6
MDAgDQo+IHN0YXJ0aW5nIGZyb20gdGhlIGZpcnN0IHdlZWsgb2YgQXByLiBhY2NvcmRpbmcgdG8g
VFNDIG1lZXRpbmcqDQo+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21l
ZXRpbmdkZXRhaWxzLmh0bWw/eWVhcj0yMDIwDQo+ICZtb250aD0zJmRheT0xOSZob3VyPTkmbWlu
PTAmc2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQ9MzcmcDU9MjQxDQo+ICZwNj0yNDgNCj4g
DQo+IFVTLVdlc3QgVVMtRWFzdCAgIFVLICAgICBERSAgICAgVFcgICAgIEpQDQo+IDAyOjAwICAg
IDA1OjAwICAgMDk6MDAgICAxMDowMCAgIDE3OjAwICAgMTg6MDANCj4gDQo+IENoYW5uZWw6DQo+
ICogaXJjOmNoYXQuZnJlZW5vZGUubmV0OjY2NjcvY2lwDQo+IA0KPiBMYXN0IG1lZXRpbmcgbWlu
dXRlczoNCj4gaHR0cHM6Ly9pcmNsb2dzLmJhc2Vyb2NrLm9yZy9tZWV0aW5ncy9jaXAvMjAyMC8w
My9jaXAuMjAyMC0wMy0xMi0wOS4NCj4gMDAubG9nLmh0bWwNCj4gDQo+IEFnZW5kYToNCj4gDQo+
ICogQWN0aW9uIGl0ZW0NCj4gMS4gQ29tYmluZSByb290IGZpbGVzeXN0ZW0gd2l0aCBrc2VsZnRl
c3QgYmluYXJ5IC0gSXdhbWF0c3Utc2FuDQoNCk5vIHVwZGF0ZS4NCg0KPiAyLiBBc3NpZ24gdGhl
IG93bmVyIG9mICJDSVAga2VybmVsIGNvbmZpZyIgLSBtYXNhc2hpOTEwDQoNCk5vdGU7IElmIG5v
IG9uZSBpcyBvd25lciwgSSBjYW4gZG8gaXQuDQoNCjMuIFN0cmVuZ3RoZW4gc3VzdGFpbmFibGUN
Cj4gcHJvY2VzcyB0byBiYWNrcG9ydCBwYXRjaGVzIGZyb20gTWFpbmxpbmUvTFRTIC0gS2VybmVs
IFRlYW0gIDMtMS4NCj4gV29ya2Zsb3cgZm9yIGlkZW50aWZ5aW5nIGltcG9ydGFudCBmaXhlcywg
YmFja3BvcnRpbmcsIGFuZCByZXZpZXdpbmcgDQo+IHRoZW0gMy0yLiBQcmVwYXJlIHRoZSB0b29s
cyB0byBiZSB1c2VkIGZvciB0aGlzIHdvcmtmbG93ICAzLTMuIEdldCANCj4gcHJhY3RpY2UgaW4g
YmFja3BvcnRpbmcgcGF0Y2hlcyA0LiBVcGxvYWQgYSBndWlkZWxpbmUgZm9yIHJlZmVyZW5jZSAN
Cj4gaGFyZHdhcmUgcGxhdGZvcm0gYWRkaXRpb24gLSBtYXNhc2hpOTEwDQo+IA0KPiAqIEtlcm5l
bCBtYWludGVuYW5jZSB1cGRhdGVzDQoNCkkgd2FzIGxhdGUsIEkgcmVsZWFzZWQgbmV3IENJUCBr
ZXJuZWxzLg0KICBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9waXBlcm1haWwvY2lwLWRl
di8yMDIwLU1hcmNoLzAwNDUxNi5odG1sDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIENJUCBD
b3JlDQo+ICogU29mdHdhcmUgdXBkYXRlDQo+ICogQU9CDQo+IDEuIFN1bW1lciBUaW1lDQo+IFVT
IHN1bW1lciB0aW1lIHN0YXJ0ZWQgb24gTWFyY2ggOC4gQ0VTVCBzdGFydHMgb24gTWFyY2ggMjku
DQo+IFRoaXMgSVJDIG1lZXRpbmcgc3RhcnRzIGF0IFVUQyAoR01UKSAwOTowMC4NCj4gDQo+IFRo
ZSBtZWV0aW5nIHdpbGwgdGFrZSAzMCBtaW4sIGFsdGhvdWdoIGl0IGNhbiBiZSBleHRlbmRlZCB0
byBhbiBob3VyIA0KPiBpZiBpdCBtYWtlcyBzZW5zZSBhbmQgdGhvc2UgaW52b2x2ZWQgaW4gdGhl
IHRvcGljcyBjYW4gc3RheS4gDQo+IE90aGVyd2lzZSwgdGhlIHRvcGljIHdpbGwgYmUgdGFrZW4g
b2ZmbGluZSBvciBpbiB0aGUgbmV4dCBtZWV0aW5nLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQpC
ZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmNpcC1kZXYgbWFpbGluZyBsaXN0CmNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vY2lwLWRldgo=
