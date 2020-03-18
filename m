Return-Path: <SRS0=NiLz=5D=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B855C4332B
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 20:44:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B152071C
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 20:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="J2voqTiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B152071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 89FEF2352E;
	Wed, 18 Mar 2020 20:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7LIqdWw0P5c; Wed, 18 Mar 2020 20:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 53EC423600;
	Wed, 18 Mar 2020 20:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4915DC013E;
	Wed, 18 Mar 2020 20:44:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62396C013E
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 20:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4A943880D2
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 20:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puQ1PaeKsq8v for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2020 20:44:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400124.outbound.protection.outlook.com [40.107.140.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 000BB880D0
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 20:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m14BuwgFZLPvZ/KJUGUJj5v6SeDaQZ4cnDJCSFwK+4k0girxP4piINikpk9mOcU4K+qEGunF3eBUIJNC/2TLISDpnQt4ktmknZcjaXl/gdeJfhALtlsnE3khGx/5f2DQBWysnFCZKSWvr7k+F2TeW8zZyyorVOHpbfwvSoodp1GwMausa/ac6XfO+XAIt4eptmYTcvC7EbVLBtH4rDbmh0FQxAsfMA9XYDHq04GSN0t6NffD+k8/wFLhmpPl2fur0RydTL3f0U2IcWhtzVXkcEE5pP3DjaTsYX/9JAqTl+9NpO0v61PVq03Su4RfOlDDSe6kOFhzZEYhKVMmKD7EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58AJ2X6f9mN6d7I5XhxAgCUsNL9WnZzEQKIYFROEREo=;
 b=ArYsMDGNCDZ0go382RIkhuAMnh4cNnGzl7LINOpYO6lZYVGHjZKJ7u8wRnS4UbcEF34Bn6mdKRZbcrI7BmjOg5omgRBOLlvaB990gLpkysp2uyxXANJ7gGCMN7f8LnFLy5t3CYAiU9TPBH4FHK/giTF1mWSM1NuqIr331HyAb5OKecXQ5OqZ1AXR65bI62nRTXsm+iNhcK9K9sxAUQWodbdxKfCU+xkT46p77uexUiMeV1kDDsC+5okO08cfl3FXI2gdQA/YRgpw2jkjc3OJBagvENEFtmUvt5wAME4ITXhskerhnpkU72OA6sabA8bAPOeZT4GaT6ZoCvbGCEc88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58AJ2X6f9mN6d7I5XhxAgCUsNL9WnZzEQKIYFROEREo=;
 b=J2voqTiXBvg/rrcaAmRu5KCqi3hpA/ki70VjqmjyucOi7X+ShrqgFxVQNU4mNxFHaL0P76pWqrEjtZDvcsnpoTIgOZg248dCTWHALLxQP9TwlwR90uPdt1zR4q9oDR8uQTYKkBLWzmVCPt8IQ4Y2jO9aY4mdbkpb1H0yDAqyOww=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB3614.jpnprd01.prod.outlook.com (20.178.136.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Wed, 18 Mar 2020 20:44:33 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::a882:860e:5745:25e1]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::a882:860e:5745:25e1%6]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 20:44:33 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, Jan Kiszka <jan.kiszka@siemens.com>
Thread-Topic: [cip-dev] Please check health for renesas board on LAVA
Thread-Index: AdX8pB3xKWT6vpR3T+GXr+q5DF2xkwAYO9fgAA6+gQAACW6WAAAACmTw
Date: Wed, 18 Mar 2020 20:44:33 +0000
Message-ID: <TYAPR01MB2285F2BA27D8D14282F51D3EB7F70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <OSAPR01MB3667C30E9485E66332CE184492F70@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <TYAPR01MB2285C867ACB9D7E7C7173901B7F70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <78ae767e-941f-7015-03d0-1385ce607cb4@siemens.com>
 <20200318204236.GA7162@amd>
In-Reply-To: <20200318204236.GA7162@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [151.224.220.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f31c9346-9bf1-42f4-b3d7-08d7cb7d2a11
x-ms-traffictypediagnostic: TYAPR01MB3614:
x-microsoft-antispam-prvs: <TYAPR01MB361444F9A3C885A9561DD504B7F70@TYAPR01MB3614.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(4744005)(8676002)(6506007)(81156014)(7696005)(81166006)(86362001)(8936002)(55016002)(9686003)(4326008)(71200400001)(54906003)(186003)(5660300002)(66446008)(52536014)(64756008)(66556008)(66476007)(33656002)(66946007)(76116006)(26005)(110136005)(316002)(2906002)(966005)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB3614;
 H:TYAPR01MB2285.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+shcVFQxcL5befC3YwWYvhJ87tdtJxPzE0fJXVvGf9Gr/NBf66Liwm2vgf412O0h+p2kSZRTzMVttPMb+mltA6DvT/n/dX2PmuruoqfVNaKSZRguGUAOHcvJrVFhJ/EJH66yeGVkvp14HGbpkGSL4p4g8nKM+/g581VHEaRF3Gk1Irl6ZwVH7dD7dRavWDxgjMRn2iZh6Ixs3SgWAH6Xp6zl+9/GqAdcKf/3xv1IkTI9DoI0rtLIPhte7RaQkFeg6yLWHhEqce5GrWM2Og4mB9irubgVrniSKz5XpnSO52q4xwzyqteqpCVrtMOfsASwPQG3POperQ/ktWyxdNKHBrgUuKRk5lXQVceT2ymrxYrQiqUWat1uY+7H9QS2wBD6NIb7bXhS4InGMGYiHTQ8+PjVl3XQ3QASCKEpNh8tQHyMbpt7K17OZsbHLOXgIDANGitkTYJZwrvZyjLM513Uw697BLwaY4Te7rV/Q829CLGoaGY42LwCIA3vznVL5idwLQxBC93/8MI82Vcgf4pIw==
x-ms-exchange-antispam-messagedata: 1knUUvSvfS3wYBaEQLlJT6KDmythVBiyjA4elRZzZHQ5hVoBAUcXvyyg89vWMEcHD9tiTcX7XG7Ljis3TSE7tE73P3GE8TYqGShJfCAugOoWT4NNJAQXrgWnkpmIIeKLe2eX3UspQBfLoEC/xF6QlA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c9346-9bf1-42f4-b3d7-08d7cb7d2a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 20:44:33.1469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73dJqSBoivj1EXrLElIUX0EkPQ6t/ZoiHkKI7quryYcCDMc0isF+qhBFWqbPzRUrzsrglcF1BQ0kqSmoC/nnqulfNQpKHiAhW/UuPIAQLks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3614
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
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

PiBGcm9tOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+IFNlbnQ6IDE4IE1hcmNoIDIw
MjAgMjA6NDMNCj4NCj4gSGkhDQo+DQo+ID4gPlRoaXMgYWRkcyB0byBteSBwb2ludCB0aGF0IHdl
IG5lZWQgdG8gc3ByZWFkIHJlZmVyZW5jZSBwbGF0Zm9ybXMgb3ZlciBtb3JlDQo+IHRoZW4gb25l
IGxvY2F0aW9uIPCfmIoNCj4gPiA+DQo+DQo+ID4gLi4ueWVhaCwgYW5kIGF0IGxlYXN0IG9uZSBz
aXRlIHNob3VsZCBiZSBvbiB0aGUgbW9vbiAtIGluIGNhc2Ugb2YgYW5vdGhlcg0KPiA+IHdpZGUt
c3ByZWFkIGxvY2tkb3duLiA7KQ0KPg0KPiBJJ2Qgc3VnZ2VzdCBhIG1vb24gcmF0aGVyIHRoYW4g
dGhlIG1vb24uIEV1cm9wYSBjb3VsZCB3b3JrLCBqdXN0IHRvIGJlDQo+IHN1cmUgOi0pLg0KDQpJ
J20gbm90IHN1cmUgaWYgd2UnbGwgY29wZSB3aXRoIHRoZSBsYXRlbmN5IHRob3VnaC4uLg0KDQo+
DQo+IMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKg
wqAgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDCoMKgwqAgwqDCoMKgwqDC
oMKgwqAgwqDCoMKgwqDCoMKgwqAgUGF2ZWwNCj4NCj4NCj4gLS0NCj4gKGVuZ2xpc2gpIGh0dHA6
Ly93d3cubGl2ZWpvdXJuYWwuY29tL35wYXZlbG1hY2hlaw0KPiAoY2Vza3ksIHBpY3R1cmVzKSBo
dHRwOi8vYXRyZXkua2FybGluLm1mZi5jdW5pLmN6L35wYXZlbC9waWN0dXJlL2hvcnNlcy9ibG9n
Lmh0bWwNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmNp
cC1kZXYgbWFpbGluZyBsaXN0CmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnCmh0dHBzOi8v
bGlzdHMuY2lwLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vY2lwLWRldgo=
