Return-Path: <SRS0=DIdx=45=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AB1C10DCE
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 04:14:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EC2206F2
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 04:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="lIHBxlDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EC2206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 40C9E869EC;
	Thu, 12 Mar 2020 04:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urKrfc7WpIoi; Thu, 12 Mar 2020 04:13:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3B9D6869BF;
	Thu, 12 Mar 2020 04:13:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA58C0177;
	Thu, 12 Mar 2020 04:13:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0847C0177;
 Thu, 12 Mar 2020 04:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CC268869EC;
 Thu, 12 Mar 2020 04:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0HQiljlZoQ6; Thu, 12 Mar 2020 04:13:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410135.outbound.protection.outlook.com [40.107.141.135])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1FF76869BF;
 Thu, 12 Mar 2020 04:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtkLgwlRbD2ch5aa0YS5pl0xHTrN6IuXtK/Ol2/jeK8lb9ZRPliUzZmkKYEa/OrooQfYeespI8KHAFV/mTqJhyV6D4djSs3IkexKbvD7lPhAhkihNhMj7nl7Iwct4SKHeTIG3e2jaW9S8jiGxSG39ZwZxiwNx+vQirf7+HRp85TsCko4OeGCCYtQuMhFOUSYUzidQUscxZUDF2hOD0BZ+4tFxorkvXrRR/2YYFObEsAA8IJCMm+K/nF6njQMaOXLRJSMX36/Fyof75yHxquBGGcQU1c2rgu/PdJwq4UgHLNoLFN6VzCtyDvWQQ6jXaaJLRtfOHNUZscTTvaZV0NPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK2jKRBx21QN2uOkIr6zFV4k0Z0s0jnU+Z7I8Zwq+/8=;
 b=DGAaALCBiwkOtFHNqUWTkfp6/kB9NL4pgc1tAyB3vLpRKOb48BUZ1L7iBAYHEPjIL/Vt4hWzjGTKqg4gRBoccblTGETXbiW142QjAQsvXtpswhkyZ+K/wnjrtntUGHUBTCl90MUFJsJSAACYa+aJOlN/4VCdPt2YviZ9rII3HBV/1q3ikrzBiUlTb5+FR1ZDiqjTvcJXMvYFgf+ZFnxvvcjDsuK52EpRaVKplbGFahnNIvkKL349k6S6c/mKnVeLkPQwrIk0F+x5X6tHbxCP+7QWyE/lZOD1qLhZ4b0G3Amv6ZvVK74HjMMbsm5sNmLrJMN3opupOQz5lYAB6onypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK2jKRBx21QN2uOkIr6zFV4k0Z0s0jnU+Z7I8Zwq+/8=;
 b=lIHBxlDaSjluN22CYd3kB/imSgoHmRLUDsTN9hyyWx5yhRAy+pyMH7ISCZgglS5hczmtMCdJrV4RgW4OqvRL7IM0x8wrd5ddUeIl/6jpFsKk5vX72Lvze1FrVVGKv3Jejekdi+rlEJ4AbSIQzWJX7hFSqwSBEjQz2VHqBk1Hd5U=
Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com (20.177.101.84) by
 TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 04:13:51 +0000
Received: from TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::5c55:e319:e25a:563b]) by TYAPR01MB2399.jpnprd01.prod.outlook.com
 ([fe80::5c55:e319:e25a:563b%5]) with mapi id 15.20.2793.013; Thu, 12 Mar 2020
 04:13:51 +0000
From: Kento Yoshida <kento.yoshida.wz@renesas.com>
To: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Thread-Topic: [cip-dev] Package Proposal #1 (Security packages), rev03
Thread-Index: AdXhPVMXFwdvSCDCQN63lDtGohpPbgUwIdJiAITnlUA=
Date: Thu, 12 Mar 2020 04:13:51 +0000
Message-ID: <TYAPR01MB23997E05968D679F418D3649DFFD0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
References: <TYAPR01MB23996D34ED0281C405A6C34CDF1B0@TYAPR01MB2399.jpnprd01.prod.outlook.com>
 <87zhcphlav.fsf@kokedama.swc.toshiba.co.jp>
In-Reply-To: <87zhcphlav.fsf@kokedama.swc.toshiba.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kento.yoshida.wz@renesas.com; 
x-originating-ip: [2001:268:c05e:f9e:1de8:b5f9:4956:942c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92460dc0-4dcf-4d1e-bde1-08d7c63bc582
x-ms-traffictypediagnostic: TYAPR01MB4544:
x-microsoft-antispam-prvs: <TYAPR01MB4544263C45DC181A5AEBA693DFFD0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(186003)(76116006)(6916009)(316002)(6506007)(86362001)(4326008)(54906003)(33656002)(5660300002)(52536014)(15650500001)(66556008)(66946007)(64756008)(66476007)(7696005)(55016002)(478600001)(9686003)(81166006)(66446008)(71200400001)(8676002)(2906002)(81156014)(8936002)(17413003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB4544;
 H:TYAPR01MB2399.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Z3MCwF2MOFt1XsOGmkhh5OJdqJI55yvPSEPOb+DUiN5v85Mk3NHZvlja7OBQQjIqTqqcBAXE45eB61hZ1W1X6zF7pTex03iFnUzXcgT60HqP02JD+4/Hiqx1yXkQiAh4GCJCKpoMq21gW3gCdfwQlYz7Nxe6SbGs+Mr/Pvo6axV/bGrlYdloLXZSJDXID69dPGvlmJflajQdKRJ36LUfyWAHD8ecJrlscHAV/9UtH5rnJG9GAUWAx5c1exX7dskpNk91M6NYGJ8SWTAzHE0qsMZBroiqMrmaFI8xKKZZTrALWkidYu9e6gQlly65Xke3uCyCfpr2qc93e4x1X8XCHeaC6vW4Gzme4LqJ9UlpxTFo4pcmKciowLsc0X0gzMUB6g1TS59P+KBwjy16YoZFhuxSjr6DjMCqnG/aX6+Yy9o1Mgo8M9mRa1hMO91+rIW2yfyunvycyLxQrhLOjkg53RC7XYzo+sy3W8AkKAuHpMzhG8Di+59+HINO3OWKJ7G
x-ms-exchange-antispam-messagedata: DaG0YGi8w62lkIfkuJGFr77KEAqkEHQKYX8ejhuUjkHSV109kkXTPa4Fm59fy3At+cIxfIpoAeaHxrIKeLuYQ3FlbK5OKu+TA+XYJaFu0fY0MmDZtpWo3eLa3wv25CpZpXhJQJz+W5IEPgpyIOkix5o8buEN7Uwbsbjf7qD2lQ7Ezb6jJPN3k9xImBiS8lvP7SUKgfk0hvH/1asd9AoPdA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92460dc0-4dcf-4d1e-bde1-08d7c63bc582
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 04:13:51.4394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiMf0ngaOiaf24Iz2H5Cad3btGcFC/ldDiay43Urm54jfLjF8iuGwADGux7clMeG+oOVTMdSqiZ6/JZWHEWhS0Lo8A7224LeTfdQlO408QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4544
Cc: "cip-security@lists.cip-project.org" <cip-security@lists.cip-project.org>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Package Proposal #1 (Security packages), rev03
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

VGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLCBQdW5pdC4NCg0KSSdsbCByZXBseSB0byB5b3Vy
IHF1ZXJpZXMsIHNlZSB0aGUgZm9sbG93aW5ncy4NCg0KPiogc3Vkby1sZGFwDQo+DQo+SXMgdGhl
cmUgYSBzcGVjaWZpYyByZXF1aXJlbWVudCB0byBpbmNsdWRlIHN1ZG8tbGRhcCBpbiBmYXZvdXIg
b2YgcGxhaW4gc3Vkbz8gSUlVQywNCj5zdWRvIGlzIGEgbWluaW1hbCBkZXBlbmRlbmN5IHZlcnNp
b24gd2hpbGUgbGRhcCByZXF1aXJlcyBhZGRpdGlvbmFsIHBhY2thZ2VzIHRvDQo+YmUgYXZhaWxh
YmxlLg0KPg0KV2UgY29uc2lkZXJlZCBhbmQgZGVjaWRlZCB0byBhZG9wdCBvbmx5IHN1ZG8gYmlu
YXJ5LiBBcyB0aGUgcmVzdWx0LCBzdWRvIHNvdXJjZSBjb2RlIGluY2x1ZGVzIGJvdGggc3VkbyBh
bmQgc3Vkby1sZGFwIGJpbmFyaWVzLCBidXQgd2Ugb25seSBuZWVkIHN1ZG8uDQpMREFQIGlzIGp1
c3QgZXhhbXBsZSBpbiB0aGUgcmVxdWlyZW1lbnQgYW5kIHdpbGwgYmUgbmVlZGVkIG9ubHkgc3Bl
Y2lmaWMgY2FzZS4gQXQgbGVhc3QsIG5vYm9keSBpbiBzZWN1cml0eSB3b3JraW5nIGdyb3VwIG1l
bWJlcnMgd2FudCB0aGF0Lg0KDQo+KiBvcGVuc3NoDQo+DQo+QmFzZWQgb24gdGhlIGxpc3RlZCBy
ZXF1aWVybWVudHMsIGl0IGlzIG5vdCBjbGVhciB3aHkgZnRwIGFuZCBzc2ggY2xpZW50cyBhcmUg
bmVlZGVkLg0KPkNhbiB5b3UgcGxlYXNlIGNsYXJpZnkgdGhlIHJlcXVpcmVtZW50cycgdGV4dCB0
byBtb3RpdmF0ZSBpbmNsdXNpb24gb2YgdGhlIGNsaWVudA0KPmJpbmFyaWVzIGFzIHdlbGwuDQo+
DQpTU0ggY2xpZW50IGlzIG5lZWRlZCBhcyBqdXN0IGEgcnVuLXRpbWUgZGVwZW5kZW5jeSBmb3Ig
U1NIIHNlcnZlci4NCg0KPiogcGFtLXBrY3MxMQ0KPg0KPkZyb20gbXkgdW5kZXJzdGFuZGluZywg
dGhlIHBhY2thZ2UgZW5hYmxlcyBsb2dpbiAgdXNpbmcgcHVibGljIC8gcHJpdmF0ZSBrZXlzLg0K
PkJ1dCB0aGUgcmVxdWlyZW1lbnRzIHRhbGsgYWJvdXQgZW5mb3JjaW5nIHRoZSBzdHJlbmd0aCBv
ZiBwYXNzd29yZHMgLQ0KPg0KPiAgICAiQSBtaW5pbXVtIHN0cmVuZ3RoIG9mIHVzZWQgcGFzc3dv
cmRzIG5lZWRzIHRvIGJlIGVuZm9yY2VkLiINCj4NCj5Qb3NzaWJseSBhIG1peHVwIG9mIHBhY2th
Z2UgYW5kIHJlcXVpcmVtZW50cz8NCj4NCkluZGVlZCwgdGhlIHBhY2thZ2UgZnVuY3Rpb25hbGl0
eSBhbmQgdGhlIHJlcXVpcmVtZW50IGRvIG5vdCBtYXRjaC4NCkluIGFkZGl0aW9uLCBwYW0tcGtj
czExIGlzIG9ubHkgcmVxdWlyZWQgZm9yIENSIDEuNywgaXQncyBtZWFuICJBIG1pbmltdW0gc3Ry
ZW5ndGggb2YgdXNlZCBwYXNzd29yZHMgbmVlZHMgdG8gYmUgZW5mb3JjZWQuIiwgc28gd2Ugc2hv
dWxkIGNvbnNpZGVyIGFnYWluIHdoZXRoZXIgd2UgbmVlZCBwYW0tcGtjczExIG9yIG5vdC4NClRo
YW5rIHlvdSBmb3IgcG9pbnRpbmcgb3V0IHRoaXMuDQoNCj4qIHRwbTIqDQo+DQo+SSB0aGluayBs
aWJ0c3MyLWVzeXMwIGlzIG1pc3Rha2VubHkgaW5jbHVkZWQgYXMgZXhwbGljaXQgcmVxdWlyZW1l
bnQuIEl0IHNlZW1zIHRvIGJlIGENCj5kZXBlbmRlbmN5IG9mIHRwbTItYWJybWQgYW5kIHdpbGwg
Z2V0IHB1bGxlZCBpbiBhdXRvbWF0aWNhbGx5IGFzIHBlciBteQ0KPnVuZGVyc3RhbmRpbmcuDQo+
DQpZZXMuIGxpYnRzczItZXN5czAgaXMgYSBkZXBlbmRlbmN5IHRwbTItYWJybWQgYW5kIHRwbTIt
dG9vbHMuDQpCdXQsIGl0IGlzIG5vdCBqdXN0IGEgbWlzdGFrZS4gVGhlIFRTUyBhbmQgVENUSSBs
aWJyYXJpZXMgbG9jYXRlZCBpbiBsaWJ0c3MyLWVzeXMwIGlzIGltcG9ydGFudCB0byBtZWV0IHRo
ZSByZXF1aXJlbWVudCBzaG93biBpbiB0aGUgZGVzY3JpcHRpb24gZm9yIHRwbTIqLg0KU28sIEkg
ZXhwcmVzc2x5IGluY2x1ZGUgbGlidHNzMi1lc3lzMCBhcyBhIHJlcXVpcmVkIGJpbmFyeSBub3Qg
anVzdCBhIGRlcGVuZGVuY3kuDQoNCj4qIHV1aWQtcnVudGltZQ0KPg0KPkl04oCZcyBub3QgY2xl
YXIgaG93IHRoZSBwYWNrYWdlIGlzIHJlbGF0ZWQgdG8gdGhlIHJlcXVpcmVtZW50IC0NCj4NCj4g
ICAgIkFjY291bnQgSWRlbnRpZmllciBzaGFsbCBiZSB1bmlxdWUgb24gYSBjb21wb25lbnQgb3Ig
c3lzdGVtIHdpZGUNCj4gICAgbGV2ZWwuIFByb3RlY3Rpb24gb2YgcmVsZXZhbnQgaW5mb3JtYXRp
b24gaW4gcmVzdCBhbmQgdHJhbnNpdCBzaGFsbA0KPiAgICBiZSBzdXBwb3J0ZWQuIg0KPg0KPkNh
biB5b3UgYWRkIG1vcmUgZGV0YWlscyB0byB0aGUgcmVxdWlyZW1lbnQgdG8gY2xhcmlmeSB0aGlz
Pw0KPg0KQXMgaXMsIGlkZW50aWZpZXIgc2hhbGwgYmUgdW5pcXVlLCBzbyB3ZSBuZWVkIHVuaXZl
cnNhbGx5IHVuaXF1ZSBpZGVudGlmaWVyIGdlbmVyYXRvci4NClNvcnJ5IGJ1dCBJIGRvbid0IGtu
b3cgd2hhdCB5b3UgZG9uJ3Qga25vdy4gVGhpcyBpcyB2ZXJ5IHNpbXBsZSByZXF1aXJlbWVudC4N
Cg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUHVuaXQgQWdyYXdhbCA8cHVu
aXQxLmFncmF3YWxAdG9zaGliYS5jby5qcD4NCj5TZW50OiBNb25kYXksIE1hcmNoIDksIDIwMjAg
NzozMSBQTQ0KPlRvOiBLZW50byBZb3NoaWRhIDxrZW50by55b3NoaWRhLnd6QHJlbmVzYXMuY29t
Pg0KPkNjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgY2lwLXNlY3VyaXR5QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZw0KPlN1YmplY3Q6IFJlOiBbY2lwLWRldl0gUGFja2FnZSBQcm9wb3Nh
bCAjMSAoU2VjdXJpdHkgcGFja2FnZXMpLCByZXYwMw0KPg0KPkhpLA0KPg0KPkFzIG1lbnRpb25l
ZCBlYXJsaWVyLCBJIGhhZCBzb21lIHF1ZXN0aW9ucyAvIHF1ZXJpZXMgcmVnYXJkaW5nIHRoZSBy
ZXF1aXJlbWVudHMNCj5mb3IgdGhlIHByb3Bvc2VkIHBhY2thZ2VzLiBTZW5kaW5nIHRoZW0gaGVy
ZSBmb3IgZGlzY3Vzc2lvbi4NCj4NCj5LZW50byBZb3NoaWRhIDxrZW50by55b3NoaWRhLnd6QHJl
bmVzYXMuY29tPiB3cml0ZXM6DQo+DQo+PiAgUmVxdWlyZW1lbnRzX2Zvcl9wcm9wb3NhbF9TZWN1
cml0eVdHX3JldjAzLnhsc3g6IHRoZSBzYW1lIGZpbGUgd2hpY2gNCj4+IEkndmUgYWxyZWFkeSBz
ZW50IGJlZm9yZSB0byBleHBsYWluIHRoZSByZXF1aXJlbWVudCBpbiB0aGUgc3RhbmRhcmQNCj4N
Cj4qIHN1ZG8tbGRhcA0KPg0KPklzIHRoZXJlIGEgc3BlY2lmaWMgcmVxdWlyZW1lbnQgdG8gaW5j
bHVkZSBzdWRvLWxkYXAgaW4gZmF2b3VyIG9mIHBsYWluIHN1ZG8/IElJVUMsDQo+c3VkbyBpcyBh
IG1pbmltYWwgZGVwZW5kZW5jeSB2ZXJzaW9uIHdoaWxlIGxkYXAgcmVxdWlyZXMgYWRkaXRpb25h
bCBwYWNrYWdlcyB0bw0KPmJlIGF2YWlsYWJsZS4NCj4NCj4NCj4qIG9wZW5zc2gNCj4NCj5CYXNl
ZCBvbiB0aGUgbGlzdGVkIHJlcXVpZXJtZW50cywgaXQgaXMgbm90IGNsZWFyIHdoeSBmdHAgYW5k
IHNzaCBjbGllbnRzIGFyZSBuZWVkZWQuDQo+Q2FuIHlvdSBwbGVhc2UgY2xhcmlmeSB0aGUgcmVx
dWlyZW1lbnRzJyB0ZXh0IHRvIG1vdGl2YXRlIGluY2x1c2lvbiBvZiB0aGUgY2xpZW50DQo+Ymlu
YXJpZXMgYXMgd2VsbC4NCj4NCj4NCj4qIHBhbS1wa2NzMTENCj4NCj5Gcm9tIG15IHVuZGVyc3Rh
bmRpbmcsIHRoZSBwYWNrYWdlIGVuYWJsZXMgbG9naW4gIHVzaW5nIHB1YmxpYyAvIHByaXZhdGUg
a2V5cy4NCj5CdXQgdGhlIHJlcXVpcmVtZW50cyB0YWxrIGFib3V0IGVuZm9yY2luZyB0aGUgc3Ry
ZW5ndGggb2YgcGFzc3dvcmRzIC0NCj4NCj4gICAgIkEgbWluaW11bSBzdHJlbmd0aCBvZiB1c2Vk
IHBhc3N3b3JkcyBuZWVkcyB0byBiZSBlbmZvcmNlZC4iDQo+DQo+UG9zc2libHkgYSBtaXh1cCBv
ZiBwYWNrYWdlIGFuZCByZXF1aXJlbWVudHM/DQo+DQo+DQo+KiB0cG0yKg0KPg0KPkkgdGhpbmsg
bGlidHNzMi1lc3lzMCBpcyBtaXN0YWtlbmx5IGluY2x1ZGVkIGFzIGV4cGxpY2l0IHJlcXVpcmVt
ZW50LiBJdCBzZWVtcyB0byBiZSBhDQo+ZGVwZW5kZW5jeSBvZiB0cG0yLWFicm1kIGFuZCB3aWxs
IGdldCBwdWxsZWQgaW4gYXV0b21hdGljYWxseSBhcyBwZXIgbXkNCj51bmRlcnN0YW5kaW5nLg0K
Pg0KPg0KPiogdXVpZC1ydW50aW1lDQo+DQo+SXTigJlzIG5vdCBjbGVhciBob3cgdGhlIHBhY2th
Z2UgaXMgcmVsYXRlZCB0byB0aGUgcmVxdWlyZW1lbnQgLQ0KPg0KPiAgICAiQWNjb3VudCBJZGVu
dGlmaWVyIHNoYWxsIGJlIHVuaXF1ZSBvbiBhIGNvbXBvbmVudCBvciBzeXN0ZW0gd2lkZQ0KPiAg
ICBsZXZlbC4gUHJvdGVjdGlvbiBvZiByZWxldmFudCBpbmZvcm1hdGlvbiBpbiByZXN0IGFuZCB0
cmFuc2l0IHNoYWxsDQo+ICAgIGJlIHN1cHBvcnRlZC4iDQo+DQo+Q2FuIHlvdSBhZGQgbW9yZSBk
ZXRhaWxzIHRvIHRoZSByZXF1aXJlbWVudCB0byBjbGFyaWZ5IHRoaXM/DQo+LS0tDQo+DQo+DQo+
VGhhbmtzLA0KPlB1bml0DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpjaXAtZGV2IG1haWxpbmcgbGlzdApjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
ZwpodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2NpcC1kZXYK
