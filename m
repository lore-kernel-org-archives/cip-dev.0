Return-Path: <SRS0=6jSD=4I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D303C11D04
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:20:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60429207FD
	for <cip-dev@archiver.kernel.org>; Thu, 20 Feb 2020 11:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="KaiDtoGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60429207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2B6FB20789;
	Thu, 20 Feb 2020 11:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aY3aoeql2ggH; Thu, 20 Feb 2020 11:20:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 54EE120343;
	Thu, 20 Feb 2020 11:20:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DAD6C013E;
	Thu, 20 Feb 2020 11:20:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 884E8C013E
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 774A285F57
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6yzK73FLl4MW for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2020 11:20:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410124.outbound.protection.outlook.com [40.107.141.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2407B85F53
 for <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2020 11:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNd0CmRA63GKLWcswCC3Po/QyQfQRc/rHDyz9XFmDPqoLqFEFSAuL32JXcluSrYdHDhzvdhnUnz0AYgs7wBrDQcrxk4ze5C2YQdov1HGC1CVKxms44Jiw9i28m18v2WtLKForO9gs/fr0zl5e9BZnt08bQRGlXxhqCjhReCDnQ4GdpY3NaDvjdj2IG0UDrtWYmj46ATKFrRDM2g9RvxFgsGvo2VtqFT5xiEAMm+dcHlot7O3Tor1o2XuztwvzXzXHLVdw1TpcsiV5YICxF5WFhKsLeG4e39FTzF+nkS2PEB8b4w09gt+3w6s08+KIrvUxXKlSp1hozj0zL8ZIPBGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4g4pDw1QM9sn/kTUf/41yRCmzVh1KjxZmGprz3Svd8=;
 b=ll2XZ/xuKf2lXpPsH7RIePtddpipLENba+aMLMUMmTWTuOYpqdmkxEkRLI0qiwwkRCNjClzlaiH3/Yth49XxCk/jYbI2KGy+VisDJGPlElg7Ndnl4oG9r7eJ+T550/60i+ZUj/VKt+KzSPzvFOWUWwpNCTmKD9+eloVWOF+LZQkKYHxwKwxZaW/0IklPZA5x4HqLHlsLwROk84eT4Av4Iq3/hFOE2/XUYvR0mJjVtIRrRKjz0sRWwn9iCxcC9wPmuDPfWuu84ZU1cmSVseMrmDZ4IqK+L0AnygmWMsPSm+XnQ9G/eZ1Yr0OuFObo8qUm+4M3xid7kP+EE2KH3WvpmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4g4pDw1QM9sn/kTUf/41yRCmzVh1KjxZmGprz3Svd8=;
 b=KaiDtoGTA6w8iqLQH7gYzfzrz0Q+2FoHhehQ9pGsMk+i20OkXGK+QH9FUPmRiyhAhQd52o0MR7s35rEcoJ8TElCTVhOidAZgb0UYMydKdftFtfVWblRIL2db5svQIiyUXG9/vqoYjq81q06I09scnckPqAfPVVvKpDOXkD8UUPw=
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com (20.179.179.149) by
 OSAPR01MB3826.jpnprd01.prod.outlook.com (20.178.103.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 20 Feb 2020 11:20:30 +0000
Received: from OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092]) by OSAPR01MB5028.jpnprd01.prod.outlook.com
 ([fe80::50c1:d043:233d:2092%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 11:20:30 +0000
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 15/23] usb: typec: driver for TI
 HD3SS3220 USB Type-C DRP port controller
Thread-Index: AQHV5vxbM2cAaZW+M0GaP16aywZW06gj6vow
Date: Thu, 20 Feb 2020 11:20:30 +0000
Message-ID: <OSAPR01MB502894683145EEC15BD1DDD7AE130@OSAPR01MB5028.jpnprd01.prod.outlook.com>
References: <1582034720-5249-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <1582034720-5249-16-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
 <20200219081234.GD31996@amd>
In-Reply-To: <20200219081234.GD31996@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marian-cristian.rotariu.rb@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9224df9a-4b38-4e4b-e3de-08d7b5f6e501
x-ms-traffictypediagnostic: OSAPR01MB3826:
x-microsoft-antispam-prvs: <OSAPR01MB3826E1F5F12C5A6EC67F621DAE130@OSAPR01MB3826.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(199004)(189003)(4326008)(8676002)(71200400001)(8936002)(7696005)(86362001)(55016002)(9686003)(81166006)(498600001)(81156014)(5660300002)(76116006)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(26005)(6506007)(52536014)(186003)(6916009)(53546011)(33656002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSAPR01MB3826;
 H:OSAPR01MB5028.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSg4Bf+2XDn4XreVKAjj7zp9dpA3wTvS61516xgyz5tpZ76qeWCnIXNlli9eZbM8tJKyZoHfkUNkbHYpR315iesvnwDgiAj88EChNOINJ8dBLdxusiAFj3sYaPZml9D6R0p+LUprR2IhKIlmiPHPIkI+bY6yZHI7Plgw071ehhK5XsSgG48cLkNUeDmCWF18aoTWcVYt6GPQ8vpiTGox02uIP/E6TJWZjP516QbIYofQePKU7A6J3LT+jvjeu0Xl3DvPDSJoBu8LaLfoXQNG19OTNRirueS3s8cUC4P0Q9/MBTsHd2m0iTYBi1+IWtSCY61ec4erMsRYJ0ydQ1MriZqVWrw1EiU51VkW6+tmXDSLrgE3QK7R8sOY7GJQgpHP0XRkKCbb+KDiwZRKR7jMt99lKrfFynfDc3aGctAJEsy8ysGZ1ulSjp/kDEFYyH+V
x-ms-exchange-antispam-messagedata: UhVnjmVlLeU9/MZgmRK/21h1dFOFa6fmUekHnl54SEYDo4Jc8kBc9ddxbk86BpyXlHDBDOA+97Zn4iHFj/4QsDUrIaKaOZsFNhH7QJ1VbJWyzozMKwrw3W2VzzJ4r1Pmwc64ynx+9Pg6U0B1XuCIEA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9224df9a-4b38-4e4b-e3de-08d7b5f6e501
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 11:20:30.3973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhbenmw4s1O6LnrmnZJ0j1omWgsheMTaIifxneS+gV0AdfGRxqrS/6542gYe/MXMcPEyO7DjAwB/GsHWFGe68Zdi+trvUEJMr3DHMsyqRVTUeOzGTcvMD7sEMLkNbu8pxs8TSxok+tfqcV11ga0L9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3826
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 15/23] usb: typec: driver for TI
 HD3SS3220 USB Type-C DRP port controller
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

SGkhDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IDxwYXZlbEBkZW54LmRlPg0KPiBTZW50OiAxOSBGZWJydWFyeSAyMDIwIDA4OjEzDQo+IFRvOiBN
YXJpYW4tQ3Jpc3RpYW4gUm90YXJpdSA8bWFyaWFuLWNyaXN0aWFuLnJvdGFyaXUucmJAYnAucmVu
ZXNhcy5jb20+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0
OiBSZTogW2NpcC1kZXZdIFtQQVRDSCA0LjE5LnktY2lwIDE1LzIzXSB1c2I6IHR5cGVjOiBkcml2
ZXIgZm9yIFRJDQo+IEhEM1NTMzIyMCBVU0IgVHlwZS1DIERSUCBwb3J0IGNvbnRyb2xsZXINCj4g
DQo+IEhpIQ0KPiANCj4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXNAYnAucmVuZXNhcy5jb20+
DQo+ID4NCj4gPiBjb21taXQgMWM0OGM3NTllZjRiYjkwMzFiMzM0NzI3N2YwNDQ4NGUwN2UyN2Q5
NyB1cHN0cmVhbS4NCj4gPg0KPiA+IERyaXZlciBmb3IgVEkgSEQzU1MzMjIwIFVTQiBUeXBlLUMg
RFJQIHBvcnQgY29udHJvbGxlci4NCj4gPg0KPiA+IFRoZSBkcml2ZXIgY3VycmVudGx5IHJlZ2lz
dGVycyB0aGUgcG9ydCBhbmQgc3VwcG9ydHMgZGF0YSByb2xlDQo+ID4gc3dhcHBpbmcuDQo+IA0K
PiBPaywgc28gdGhpcyBoYXMgZmV3IHByb2JsZW1zIHRoYXQgYXJlIGZpeGVkIGJ5IHN1YnNlcXVl
bnQgcGF0Y2hlcywgYnV0IEkNCj4gYmVsaWV2ZSBJIHNlZSBzb21lIG1vcmU6DQo+IA0KPiA+ICtz
dGF0aWMgZW51bSB1c2Jfcm9sZSBoZDNzczMyMjBfZ2V0X2F0dGFjaGVkX3N0YXRlKHN0cnVjdCBo
ZDNzczMyMjANCj4gPiArKmhkM3NzMzIyMCkgew0KPiA+ICsJdW5zaWduZWQgaW50IHJlZ192YWw7
DQo+ID4gKwllbnVtIHVzYl9yb2xlIGF0dGFjaGVkX3N0YXRlOw0KPiA+ICsJaW50IHJldDsNCj4g
PiArDQo+ID4gKwlyZXQgPSByZWdtYXBfcmVhZChoZDNzczMyMjAtPnJlZ21hcCwNCj4gSEQzU1Mz
MjIwX1JFR19DTl9TVEFUX0NUUkwsDQo+ID4gKwkJCSAgJnJlZ192YWwpOw0KPiA+ICsJaWYgKHJl
dCA8IDApDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gDQo+IFRoaXMgZnVuY3Rpb24gY2xhaW1zIHRv
IHJldHVybiAiZW51bSB1c2Jfcm9sZSIsIGJ1dCBoZXJlIGl0IHJldHVybnMgZXJybm8NCj4gZnJv
bSByZWdtYXBfcmVhZC4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgaGQzc3MzMjIwX2RyX3NldChjb25z
dCBzdHJ1Y3QgdHlwZWNfY2FwYWJpbGl0eSAqY2FwLA0KPiA+ICsJCQkgICAgZW51bSB0eXBlY19k
YXRhX3JvbGUgcm9sZSkNCj4gPiArew0KPiAuLi4NCj4gPiArCXJldCA9IGhkM3NzMzIyMF9zZXRf
c291cmNlX3ByZWYoaGQzc3MzMjIwLCBwcmVmKTsNCj4gPiArCXVzbGVlcF9yYW5nZSgxMCwgMTAw
KTsNCj4gDQo+IFdvdWxkIHVkZWxheSgpIG1ha2UgbW9yZSBzZW5zZSBoZXJlPyBBcmUgeW91ciBD
UFVzIC8gdGltZXIgc3Vic3lzdGVtIHNvDQo+IGZhc3QgdGhhdCBzbGVlcGluZyBmb3IgMTB1c2Vj
IGlzIHBvc3NpYmxlIGFuZCByZWFzb25hYmxlIHRvIGRvPw0KDQpJIHRoaW5rIEJpanUgZm9sbG93
ZWQgdGhlIG92ZXJhbGwgaW5kaWNhdGlvbnMgZnJvbToNCkRvY3VtZW50YXRpb24vdGltZXJzLWhv
d3RvLnR4dCAoLnJzdCkNCg0KQWNjb3JkaW5nIHRvIHRoZSBkb2N1bWVudGF0aW9uIHRoZSBpbmZs
ZWN0aW9uIHBvaW50IGlzIGF0IDEwdXMsIHNvIHRoaXMgaXMga2luZA0Kb2YgYSBncmV5IGFyZWEu
IEp1c3QgdG8gcHV0IGl0IGluIGNvbnRleHQsIHRoZSBSWi9HMkUgaGFzIDJ4MS4yR2h6IEFSTSBD
b3J0ZXggQTUzLg0KVGhlcmVmb3JlIHRoaXMgaXMga2luZCBvZiBhIGhpZ2gtcGVyZm9ybWFuY2Ug
ZW1iZWRkZWQgcGxhdGZvcm0uIEF0IGxlYXN0LCB3ZQ0KbGlrZSB0byBhZHZlcnRpc2UgaXQgbGlr
ZSB0aGF0IPCfmIoNCg0KU28sIEkgYW0gaW5jbGluZWQgdG8ga2VlcCB0aGlzIGFzIGl0IGlzIGlm
IHlvdSBhZ3JlZS4gDQoNCkNoZWVycywNCk1hcmlhbi4NCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmNpcC1kZXYgbWFpbGluZyBsaXN0CmNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnCmh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vY2lwLWRldgo=
