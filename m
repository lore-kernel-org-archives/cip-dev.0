Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E6C4332D
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 00:20:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0426120752
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 00:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0426120752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B5E74204AB;
	Thu, 19 Mar 2020 00:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EvzebIv6-8Zn; Thu, 19 Mar 2020 00:20:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DA928203FB;
	Thu, 19 Mar 2020 00:20:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C70CFC087F;
	Thu, 19 Mar 2020 00:20:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE7FBC087F
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 00:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CC4DA20449
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 00:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rly-r2Q59GL7 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 00:20:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
 by silver.osuosl.org (Postfix) with ESMTPS id 64653203FB
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 00:20:15 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 02J0KCQi016724;
 Thu, 19 Mar 2020 09:20:13 +0900
X-Iguazu-Qid: 2wHHsainOjA8LGvIXb
X-Iguazu-QSIG: v=2; s=0; t=1584577212; q=2wHHsainOjA8LGvIXb;
 m=febBi7JXSnkq0hEhvHYhfi9RH4v2TM38wqX5+oU7Bww=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1110) id 02J0KCZn006662;
 Thu, 19 Mar 2020 09:20:12 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 02J0KBdn022802;
 Thu, 19 Mar 2020 09:20:12 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 02J0KBsS008359;
 Thu, 19 Mar 2020 09:20:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyei2J7x8kB1negtOwyeFGMI0at3mnbAJMjujK6sn0Fg3qHO/H2svIbrndjzFEVtv9O7/L3lP7YW8xJfLpEYXY7xjqCNegt07ym/jCHE3s2bZfdOgAhVYKxGjQlQ0vmRyhU4wHm8vnwUdkAxbpXI9uTZMPKmyYI13kKICxWorxBIfmzikQtNvXvB4LV2dH5qNfhAB4bEx0RJoCGpJzfRfJtPu0+ViHKquyb0n9oMnAbatEwOo+cXAwVuOFKdEnw7DEKvdL1B7eb0W+lh7yWJ/TWmeScT81k9mmUyCjOjWTi8Mjk1i6n571CN0WCOmPF6FDELJKq8n9gd+ZLGEUNqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW/Q2YwlDGZQNB4DoafBZqARFZLnazSgqstqpO3/uvE=;
 b=R4XRm3zHccbvAg689DJhCJ2LxDaeL//teWO94rbBAheKWut3T+LllhzXUEBuOfrOps45ydpF4V60LNIyK/TrbjfD3qcaTsqwbmB2+C9/EH8EonHk9Ie+mkTqmZc4XI08B42UIjDYZsypGmBtSUXdDssAGQlxemRJXJQ/8f1p9GHnTggbbMmvnIAhYrCaHvJW4vaK4STYR6d1mvxLJJv46ED5KjTEwqDzL2EXm8/rnkrDzofLfoBcCihUvUOD0mRUWkoHMspPhTragL7y/Eu/Pqvm/WhDnX/my0x3U0Htun2WgrGkdD6pAO1QzdCodE7o4QUEIC9jB4OaV+hphHvPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>
Thread-Topic: Please check health for renesas board on LAVA
Thread-Index: AdX8pB3xKWT6vpR3T+GXr+q5DF2xkwAYO9fgAB+QbqA=
Date: Thu, 19 Mar 2020 00:20:07 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB3667D61A40C620118BFA14A792F40@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <OSAPR01MB3667C30E9485E66332CE184492F70@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <TYAPR01MB2285C867ACB9D7E7C7173901B7F70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB2285C867ACB9D7E7C7173901B7F70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5e735b4-d7a9-435c-bec3-08d7cb9b47bd
x-ms-traffictypediagnostic: OSAPR01MB4803:
x-microsoft-antispam-prvs: <OSAPR01MB480313E0F71C87D400E925D792F40@OSAPR01MB4803.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(7696005)(6916009)(6506007)(33656002)(71200400001)(53546011)(52536014)(66476007)(66446008)(66556008)(76116006)(66946007)(64756008)(5660300002)(316002)(26005)(4326008)(2906002)(81166006)(186003)(81156014)(8936002)(86362001)(8676002)(478600001)(9686003)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB4803;
 H:OSAPR01MB3667.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXHrNbclv0lSVres8CUYGY092cM94f3FTtMVtBqwX+6V9csjkwSgIOTI7/+NICRGjemtAiJ0gNN1WIUMD5Zh5esK7ZBFT2oEFA1XXG+67bwBYGWPJWLJ62kypavTHt5qUZTibB+8XiqpI3J9/JvPKAKF93ewGN/zfdXELmfjQo0fVPihNQieKJvTwR50yhYN4w2budTjTj/769WvoO20dSARA9JGDiQEuw9GdqKQpZXqn7zvoG4vdNUNvziDK1wV0b1hTzd6tnfmRIkqw3lsY0HNqEqRFlta5cv2TtwGJ40uQ2CEZNnSbE/qu9GW7ntaz51feMkyrdUzByVxbawqukqi3DuO8yBmjzctfw9ddPoCl70q9NeoM59EvDdGCt0HXzvScJQ2J1yyPvAMh/VAI2JQ2leSlyLYDpYKY9juCgCOMJI80EnFLWO0HtTA2cgK
x-ms-exchange-antispam-messagedata: +MaZmka9bhqKvakRhiuvqHgHy9Ivr9kqcYVFwV5e0jCtyZKprG5G8kQ3TfQ4uDP6+mjW2GJfvfYNMwtep4OwyqY2F1o3V6DJsjVg9Sqhx8C37AFqqlNQty4mgpeqWZ/VkIKl6EdE1FqcNCkq69Mwkw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e735b4-d7a9-435c-bec3-08d7cb9b47bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 00:20:07.8652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QAP+bUF6uHooB4mTiZtWWfU+0wmzGoBiVUmzyqgGLhMg1q+20b3l2nV1XQwdmcHSJpoby+ILhsejc/TQgEZ+9Tc9pa6TrsRBypJrK0xPd/H5jcN7ROQ/6SyfrwvLKO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4803
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Please check health for renesas board on LAVA
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXMgUGF0ZXJz
b24gW21haWx0bzpDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb21dDQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgTWFyY2ggMTgsIDIwMjAgNjoxNCBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+
IOS/oea0iyDil4vvvLPvvLfvvKPilqHvvK/vvLPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VA
dG9zaGliYS5jby5qcD4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFN1
YmplY3Q6IFJFOiBQbGVhc2UgY2hlY2sgaGVhbHRoIGZvciByZW5lc2FzIGJvYXJkIG9uIExBVkEN
Cj4gDQo+IEhlbGxvIEl3YW1hdHN1LXNhbiwNCj4gDQo+ID4gRnJvbTogbm9idWhpcm8xLml3YW1h
dHN1QHRvc2hpYmEuY28uanANCj4gPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+
DQo+ID4gU2VudDogMTggTWFyY2ggMjAyMCAwNTo0Mg0KPiA+DQo+ID4gSGkgQ2hyaXMsDQo+ID4N
Cj4gPiBTb21lIFJlbmVzYXMgYm9hcmRzIGxvb2sgbGlrZSBkb3duWzBdLg0KPiA+IFRoZXJlZm9y
ZSwgdGVzdGluZyB3aXRoIGdpdGxhYiBoYXMgbm90IGJlZW4gY29tcGxldGVkLg0KPiANCj4gWWVz
LCBzb3JyeS4gVGhlcmUgaXMgYW4gaXNzdWUgd2l0aCBvbmUgb2YgdGhlIFVTQiBodWJzLg0KPiBI
b3dldmVyIHdlJ3JlIGFsbCB3b3JraW5nIGZyb20gaG9tZSBhdCB0aGUgbW9tZW50IHNvIGl0J3Mg
bm90IGVhc3kgZm9yDQo+IG1lIHRvIGdldCBwaHlzaWNhbCBhY2Nlc3MuDQoNCkkgc2VlLg0KDQo+
IA0KPiBBcyBhIHRlbXBvcmFyeSBtZWFzdXJlIHllc3RlcmRheSBJIHJlbW92ZWQgdGhlIHByb2Js
ZW1hdGljIGJvYXJkcyBmcm9tDQo+IG91ciBDSSBwaXBlbGluZXMsIHNvIGhvcGVmdWxseSBnb2lu
ZyBmb3J3YXJkIHdlIHNob3VsZCBiZSBva2F5Lg0KPiBUaGUgb2ZmbGluZSBib2FyZHMgd2VyZSBh
ZGRpdGlvbmFsIG5vbiBDSVAgcmVmZXJlbmNlIHBsYXRmb3Jtcywgc28gb3VyDQo+IENJIHdpbGwg
c3RpbGwgYmUgdGVzdGluZyB3aGF0IG5lZWRzIHRvIGJlIHRlc3RlZC4NCj4gDQoNCk9rYXksIHRo
YW5rcyBmb3IgeW91ciB3b3JrIQ0KDQo+IFRoaXMgYWRkcyB0byBteSBwb2ludCB0aGF0IHdlIG5l
ZWQgdG8gc3ByZWFkIHJlZmVyZW5jZSBwbGF0Zm9ybXMgb3Zlcg0KPiBtb3JlIHRoZW4gb25lIGxv
Y2F0aW9uIPCfmIoNCg0KWWVzLCBXZSAoVG9zaGliYSkgd2lsbCB3b3JrIG9uIGpvaW5pbmcgdGhp
cyBzdXBwb3J0IGFzIHdlbGwuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmNpcC1kZXYgbWFpbGluZyBs
aXN0CmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMuY2lwLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vY2lwLWRldgo=
