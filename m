Return-Path: <SRS0=DIdx=45=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6228DC1975A
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 03:50:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AB1206E2
	for <cip-dev@archiver.kernel.org>; Thu, 12 Mar 2020 03:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AB1206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AE2B62612E;
	Thu, 12 Mar 2020 03:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KPFSG6iCai2n; Thu, 12 Mar 2020 03:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 77954265BB;
	Thu, 12 Mar 2020 03:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D33EC0177;
	Thu, 12 Mar 2020 03:49:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF54CC0177
 for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2020 03:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A88C38929E
 for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2020 03:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5xiIDr2kOp8T for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2020 03:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DB62E89299
 for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2020 03:49:55 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 02C3nltb029099;
 Thu, 12 Mar 2020 12:49:47 +0900
X-Iguazu-Qid: 34trcFcTQxXjkOSiyf
X-Iguazu-QSIG: v=2; s=0; t=1583984987; q=34trcFcTQxXjkOSiyf;
 m=UvztHTVvyWOWnhVPforOC6rYSOdsqDhE5o/Y0W20k/I=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1512) id 02C3nkAb034714;
 Thu, 12 Mar 2020 12:49:47 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 02C3nkmb002583;
 Thu, 12 Mar 2020 12:49:46 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 02C3nkNn018069;
 Thu, 12 Mar 2020 12:49:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+wYlJ59WWm7gQtjecSdVb6/9dxyspEsnrFhgTAPrEz1G1TCeDMzsg09In8cS/8Z9ph5oYbHH1OZ05FuQilODHL6GW0IRMozQLZADHbyJRcWOU/kx1Vx07dpmvHYML2pVDgbpTGW2XrTihieyE4oMFyDb9sykV16C/WXSDiqSCEk2GFj4ORyuMqdZrhqPXzTEBENuB2F0YTT0+/mDxBDGS4dIUyAfrGvvSmmRJNcOZpCHkb9ZRF8VGqyLe9ivXY8Eoc0JGnqP6tB8YXU+aeQsy0uyhrL4ZsFRjgrJQJDvF3udq0HaIWepcmjBAtMuHQja+8EB+/bQgCq2cyAmnuJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVA5vav3fyepkncAK+8W04P1ZQm8ZM7xPn2gxXgfBg4=;
 b=eVQpH5vApQnrBD2JTiWe+yCJZlgf2n6o7P+MoowbFxcMyy7jlfGD1vxnsft5FRinEM8+fWOauAQTc1vHURWXXkZ8F7RbV6nT+nPXzj76in5/Jc2yxWG+ngCo82ysCOZc9c5NmFWCGe/Zc6pKyu2vcAkwzxU1e3SHeh9qPp2asjWtikdELAUvM8RfRIXAz47y14K3P1ITsUe6UvZzvIZxE3QPnwoP555lK864h8pd1mqKRpPTGIZ1fNxNMDQ74M+KX1yPh+d0AW90uw718MNshE5hXH33u8VIRoxmo8exdW2EaAqCfPCWGp7zTV2cNPD6nEgmLoxGVN1tcVTa6mtNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
Thread-Topic: How to handle diffs created in -rebase branch
Thread-Index: AdXjKlkyLRv0rzztQySPKpryzgkrqgDGNnKAAE+cnsACdGeZAAGxaRFw
Date: Thu, 12 Mar 2020 03:49:44 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB36678CD3167D6F6F5427BCF092FD0@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <OSAPR01MB366723B45768B553CBAE532392150@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <20200218100717.GB20615@duo.ucw.cz>
 <OSAPR01MB36676CE7E99B28155861453192130@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <20200303120000.GA26229@duo.ucw.cz>
In-Reply-To: <20200303120000.GA26229@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93ca3408-8100-464e-559a-08d7c6386723
x-ms-traffictypediagnostic: OSAPR01MB2052:
x-microsoft-antispam-prvs: <OSAPR01MB2052D2E5A2C7E9D11D3CF88A92FD0@OSAPR01MB2052.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(55016002)(71200400001)(316002)(9686003)(7696005)(26005)(33656002)(86362001)(81156014)(2906002)(52536014)(8936002)(478600001)(966005)(8676002)(6916009)(81166006)(4326008)(76116006)(186003)(66446008)(66476007)(66556008)(6506007)(66946007)(64756008)(5660300002)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB2052;
 H:OSAPR01MB3667.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C11EbuKoCBtjwoio+BDrLuvQ3PIP0Hn3/++wQNNCvb+grAai0dNWEhfU+dYSbS3xZFwFsfl0+Z/AWA/GNq4uLMz4b7zE8XRGAu4QgBysiYQOkuw2t4O1ZsV+/F5p5f5VEnh7y05UtIoR0wtDDuRQP2w5tp4/SwCn8WeKMlQmNbzxGkHY0Xcf7IcHjtshkT7WSlqWR41Rl6QDjEq9GVh/93iSj1ARxC/VUIL1zvVu5yTbAj01llvxqubKgySbOkL1/7wOswwa43cWlcn3oIDPbwpLSbXSvdP1akOHmrBxmvDLiA8QmxiiA6GuXbEmo37Qj2Wl6rupLZTnJURVsJ8WwhybFYQF1+dyWhwtYIIJ3COYUqabI01vDgrEEUgIiMO+cI7pdV+5wOzZ75FCWEQA1mScliWQO8boDEAWV33tdhTVlOa+OzB9vrdblzL74k/njeeRmJIQIN4zUkilnkJc0PFDucGGowUCf5XmQz/eOhF4S8RMzz6gzJrSbqQLvWuud3/2iZqnQOAgeJ6GgI46BA==
x-ms-exchange-antispam-messagedata: cqDZvQqeXc1PWghEohmTrKQw0juIiMWxm5fN07Sky7rE1x8CXCWtYtVBa2th5jxk8FmXZ7AvM3M81AhK/IEjoj9/yNxzMkirDZHx/XZqp/EMoAeNgglQ5ggjCbtNk47a69WDsCEXA6He6sk2D9FL4g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ca3408-8100-464e-559a-08d7c6386723
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 03:49:44.5462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1dj0UvjtrIQ1LUm6fZsyUWmhV/EgxpUCic6MlN8s1OU3ttL8AV8gefCWpSXb4r21tpD9FBv6mkf1mO39WsXj/xLwC3RDo9daY5unc8cWjXAYVXWNHIDL0w4HBRmP299
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2052
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] How to handle diffs created in -rebase branch
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

IyBBZGQgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgdG8gQ0MNCkhpIFBhdmVsLA0KDQpU
aGFua3MgZm9yIHlvdXIgY29tbWVudC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBQYXZlbCBNYWNoZWsgW21haWx0bzpwYXZlbEBkZW54LmRlXQ0KPiBTZW50OiBUdWVz
ZGF5LCBNYXJjaCAzLCAyMDIwIDk6MDAgUE0NCj4gVG86IGl3YW1hdHN1IG5vYnVoaXJvKOWyqead
viDkv6HmtIsg4peL77yz77y377yj4pah77yv77yz77y0KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1
QHRvc2hpYmEuY28uanA+DQo+IFN1YmplY3Q6IFJlOiBIb3cgdG8gaGFuZGxlIGRpZmZzIGNyZWF0
ZWQgaW4gLXJlYmFzZSBicmFuY2gNCj4gDQo+IEhpIQ0KPiANCj4gKEkgYmVsaWV2ZSB3ZSBzaG91
bGQgY2MgY2lwLWRldiBmb3IgdGhpcyBkaXNjdXNzaW9uKS4NCg0KWWVzLCBJIGFkZGVkIGNpcC1k
ZXYgdG8gQ0MuDQoNCj4gDQo+ID4gPiA+IENvbW1pdCA5YzA3NWQzMjVlYzIzYTliZDk5YjcwOTdm
MGI4MmVjMDRiMDA3MDkzIFsxXSBoYXMgdGhpcyBmaXgNCj4gPiA+ID4gaW4NCj4gPiA+IHY0LjQu
MjExLCBidXQgY29tbWl0IGVkZWVkNWY5MTBkYjU5NjJmNGVjYzA5N2FkNmQ5MzVhMzMwNDFlZTAg
WzJdDQo+ID4gPiBkZWxldGVzIHRoZSBmaWxlIG9uY2UgYW5kIGNvbW1pdA0KPiA+ID4gNWEwZDE1
N2I2MTUzYjQ2MmVhYmQ4YWZjZjgyNzg3N2U4ODUzMzZiOSBbM10gcmVjcmVhdGVkIHRoZSBmaWxl
Lg0KPiA+ID4gPiBJZiB3ZSByZWJhc2UgdGhpcywgc2luY2UgdGhlIG9yZGVyIG9mIGNvbW1pdHMg
aXMgMiwgMywgIDEgdG8gMSwNCj4gMiwNCj4gPiA+ID4gMywgdGhlIGFib3ZlIGRpZmZzIHdhcyBj
cmVhdGVkLg0KPiA+ID4NCj4gPiA+IEkgYmVsaWV2ZSBjb21taXQgWzFdIGlzIGdvb2QsIGFuZCB3
ZSBzaG91bGQgbm90IHVuZG8gaXRzIGVmZmVjdHMNCj4gPiA+IHdpdGggb3RoZXIgY29tbWl0cy4g
VGh1cyBsaW51eC00LjQueS1jaXAgaXMgb2theSwgYW5kDQo+ID4gPiBsaW51eC00LjQueS1jaXAt
cmViYXNlIHNob3VsZCBiZSBmaXhlZC4gT25lIHdheSB3b3VsZCBiZSB0bw0KPiA+ID4gY2hlcnJ5
LXBpY2sgMSBpbnRvIGxpbnV4LTQuNC55LWNpcC1yZWJhc2UuDQo+ID4NCj4gPiBJIHNlZSwgYnV0
IGNvbW1pdCBbMV0gd2FzIGFscmVhZHkgYXBwbGllZCB0byB2NC40LjIxMSBieSB1cHN0cmVhbS4g
U28NCj4gPiB0aGUgc2FtZSBjb21taXQgaXMgYXBwbHkgdHdpY2UuIElzIHRoaXMgdW5kZXJzdGFu
ZGluZyBzYW1lIHlvdXIgc3VnZ2VzdD8NCj4gPg0KPiA+ICAgMS4gY29tbWl0IFsxXSAvIGluIHY0
LjQuMjExDQo+ID4gICAuLi4uLg0KPiA+ICAgeC4gY29tbWl0IC8gcmVsZWFzZSB2NC40LjIxMw0K
PiA+ICAgLi4uLi4NCj4gPiAgIHggKyAxLiBjb21taXQgWzJdIC8gRGVsZXRlIGZpeCBieSBjb21t
aXQgWzFdIC8gQ0lQJ3MgY29tbWl0DQo+ID4gICB4ICsgMi4gY29tbWl0IFszXSAvIENJUCdzIGNv
bW1pdA0KPiA+ICAgeCArIDMuIGNoZXJyeS1waWNrIGNvbW1pdCBbMV0gPC0tLSB5b3VyIHN1Z2dl
c3QNCj4gPg0KPiA+IC1yZWJhc2UgYnJhbmNoIGlzIGEgYnJhbmNoIHRoYXQgbWFuYWdlcyBjb21t
aXRzIGluIHRoZSBMVFMgdHJlZSBhbmQNCj4gQ0lQIHRyZWUuDQo+ID4gU28gYSBmaXggbGlrZSB0
aGlzIG9uZSBhbHdheXMgbWFrZXMgYSBkaWZmZXJlbmNlLg0KPiA+IEkgdGhpbmsgdGhlcmUgYXJl
IHR3byBtZWFzdXJlcy4NCj4gPg0KPiA+ICAxLiBJZ25vcmUgZGlmZmVyZW5jZXMgYmVjYXVzZSBp
dCBpcyBhIGJyYW5jaCB0aGF0IG1hbmFnZXMgY29tbWl0cy4NCj4gPiAgMi4gSWYgYSBkaWZmZXJl
bmNlIG9jY3VycywgY29tbWl0IHRvIGZpeCBpdC4gKFlvdXIgc3VnZ2VzdGlvbikNCj4gPg0KPiA+
IEkgdGhpbmsgdGhhdCBib3RoIGFyZSB1c2VmdWwsIGJ1dCBJIHdhbnQgdG8gZ2V0IGNvbnNlbnN1
cyB3aXRoIHlvdSBhcw0KPiA+IGtlcm5lbCBtYWludGFpbmVycyBvZiBDSVAuDQo+IA0KPiBJdCBp
cyBpbXBvcnRhbnQgZm9yIG1lIGZvciBib3RoIGJyYW5jaGVzIHRvIGVuZCB1cCB3aXRoIHNhbWUg
cmVzdWx0Lg0KDQpPSy4NCg0KPiANCj4gIklmIGEgZGlmZmVyZW5jZSBvY2N1cnMsIGNvbW1pdCB0
byBmaXggaXQiIGlzIGFuIGFjY2VwdGFibGUgc29sdXRpb24gdG8NCj4gaXQuIEJ1dCB0aGlua2lu
ZyBhYm91dCBpdCBzb21lIG1vcmUsIHRoZXJlIG1heSBiZSBldmVuIGJldHRlciBvbmUuDQo+IA0K
PiBDZW50cmFsIHByb2JsZW0gaXMgdGhhdCB3ZSBkZWxldGUgZml4ZWQgdmVyc2lvbiBvZiBmaWxl
LCB0aGVuIHJlLWNyZWF0ZQ0KPiB0aGUgZmlsZSB3aXRob3V0IHRoZSBmaXguIFdlIHNob3VsZCBz
aW1wbHkgbW9kaWZ5IHRoZSByZS1jcmVhdGluZyBwYXRjaA0KPiB0byBjcmVhdGUgdGhlIGZpeGVk
IHZlcnNpb24uDQoNCkkgdW5kZXJzdG9vZC4NCg0KPiANCj4gSWYgeW91IHdhbnQsIEkgY2FuIHRy
eSB0byBkbyBqdXN0IHRoYXQ7IGJ1dCBhdCB0aGUgbW9tZW50LCBjdXJyZW50IHZlcnNpb25zDQo+
IGRvIG5vdCBzZWVtIHRvIGJlIG9uIGtlcm5lbC5vcmc6DQo+IA0KPiA0LjQuMjEzLWJhc2VkOg0K
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGlu
dXgtY2lwLmdpdC9sbw0KPiBnLz9oPWxpbnV4LTQuNC55LWNpcA0KPiA0LjQuMjA4LWJhc2VkOg0K
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGlu
dXgtY2lwLmdpdC9sbw0KPiBnLz9oPWxpbnV4LTQuNC55LWNpcC1yZWJhc2UNCg0KWWVzLCB3ZSBo
YXZlbid0IHJlc29sdmVkIHRoaXMgaXNzdWUsIHNvIEkgaGF2ZW4ndCBjb21taXR0ZWQgdG8gdGhl
IHJlYmFzZSBicmFuY2ggeWV0Lg0KQW5kLCBJIGZpeGVzIHN1Z2dlc3RlZCBhYm92ZS4NCg0KQ3Vy
cmVudCB0cmVlOg0KICAgaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2xpbnV4LWNpcC8tL3Ry
ZWUvcmViYXNlLWNoZWNrL2xpbnV4LTQuNC55LWNpcC1yZWJhc2UtYmFzZQ0KQ2F1c2UgY29tbWl0
Og0KICAgaHR0cHM6Ly9naXRsYWIuY29tL2l3YW1hdHN1L2xpbnV4LWNpcC8tL2NvbW1pdC81YjQ1
MTk1NmMyYzY3NjU2ZjFjNmRjYjVjYWE5ZmQ3YjlhYjc1NjEzDQogICAtIDViNDUxOTU2YzJjNiBm
aXJtd2FyZTogUmVzdG9yZSBzdXBwb3J0IGZvciBidWlsdC1pbiBmaXJtd2FyZQ0KDQpGaXhlZCB0
cmVlOiANCiAgIGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRzdS9saW51eC1jaXAvLS90cmVlL3Jl
YmFzZS1jaGVjay9saW51eC00LjQueS1jaXAtcmViYXNlLWZpeDANCkZpeGVkIGNvbW1pdDoNCiAg
IGh0dHBzOi8vZ2l0bGFiLmNvbS9pd2FtYXRzdS9saW51eC1jaXAvLS9jb21taXQvZDg0MWZlYzcx
YjliZjQxMTdiOTg1OWQ3ZmZiYTY4MjEwMTYwYzQ4NA0KICAgLSBkODQxZmVjNzFiOWIgZmlybXdh
cmU6IFJlc3RvcmUgc3VwcG9ydCBmb3IgYnVpbHQtaW4gZmlybXdhcmUNCg0KLS0tDQokIGdpdCBk
aWZmIHJlYmFzZS1jaGVjay9saW51eC00LjQueS1jaXAtcmViYXNlLWJhc2UgcmViYXNlLWNoZWNr
L2xpbnV4LTQuNC55LWNpcC1yZWJhc2UtZml4MA0KZGlmZiAtLWdpdCBhL2Zpcm13YXJlL01ha2Vm
aWxlIGIvZmlybXdhcmUvTWFrZWZpbGUNCmluZGV4IGZhMDgwODg1Mzg4My4uYzk0NGNmMDkyOTI2
IDEwMDY0NA0KLS0tIGEvZmlybXdhcmUvTWFrZWZpbGUNCisrKyBiL2Zpcm13YXJlL01ha2VmaWxl
DQpAQCAtMTgsNyArMTgsNyBAQCBxdWlldF9jbWRfZndiaW4gPSBNS19GVyAgICRADQogCQkgIFBS
T0dCSVRTPSQoaWYgJChDT05GSUdfQVJNKSwlLEApcHJvZ2JpdHM7CQkgICAgIFwNCiAJCSAgZWNo
byAiLyogR2VuZXJhdGVkIGJ5IGZpcm13YXJlL01ha2VmaWxlICovIgkJPiAkQDtcDQogCQkgIGVj
aG8gIiAgICAuc2VjdGlvbiAucm9kYXRhIgkJCQk+PiRAO1wNCi0JCSAgZWNobyAiICAgIC5wMmFs
aWduICQke0FTTV9BTElHTn0iCQkJPj4kQDtcDQorCQkgIGVjaG8gIiAgICAucDJhbGlnbiA0IgkJ
CQkJPj4kQDtcDQogCQkgIGVjaG8gIl9md18kJHtGV1NUUn1fYmluOiIJCQkJPj4kQDtcDQogCQkg
IGVjaG8gIiAgICAuaW5jYmluIFwiJCgyKVwiIgkJCQk+PiRAO1wNCiAJCSAgZWNobyAiX2Z3X2Vu
ZDoiCQkJCQk+PiRAO1wNCi0tLQ0KDQpDb3VsZCB5b3UgcGxlYXNlIGNoZWNrIGFuZCBjb21tZW50
IG9uIGZpeGVkIGNvbW1pdD8NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KY2lwLWRldiBtYWlsaW5nIGxp
c3QKY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcKaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9jaXAtZGV2Cg==
