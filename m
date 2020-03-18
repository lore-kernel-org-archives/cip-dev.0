Return-Path: <SRS0=NiLz=5D=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CAAC10DCE
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 09:14:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0B32076E
	for <cip-dev@archiver.kernel.org>; Wed, 18 Mar 2020 09:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="oRcid0pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0B32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8179E885DE;
	Wed, 18 Mar 2020 09:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BOBq9RaGVMBF; Wed, 18 Mar 2020 09:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E5786885C7;
	Wed, 18 Mar 2020 09:14:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA1FC013E;
	Wed, 18 Mar 2020 09:14:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59C42C013E
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 09:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B4C9185FB9
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 09:13:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g-5R-kSwrqZC for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2020 09:13:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400112.outbound.protection.outlook.com [40.107.140.112])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A148585FB2
 for <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2020 09:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofGb8J/Ihp6H/3wI5ggWyYvYiw/BbtFEK8rGzeGMHb4832PDQEIwET66nxmjPJ/l7a6EYziFi4uZqYJAYFMCKI5dyykFtuR+C8SKFkczlVV5T2kZ+guJObfT+R71wj4mL254tVMLNpoeoQymoIalhFea5tXafV8tb9DBghmxmT10shw1QDm5Tf3GMhbBm2V8H//fsITfOvTLWDmquebwLPNbXJU9sAmOYkWrRCw9stIMqIlVQ7pGFurh0uInHZu4nMJsbW1dY/vMyQPjCEltGz2cSvTylKveg0I8In5anb0MWld+KfISBqdvQGk6JPcz3kmZoyk5sb3ymzMC86szcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oswSMGUt7NgDjuAm+bRkZqocwVsThB1IucHQHRYMt00=;
 b=PBx0JoOVVI+9CMIA7dDk75d0U/kVLCpCD8pgBzUBGdAenJpklIU9l6bhwElUjMde0iN/87uGs1/6p9YNjJ5CyBHXdJ/ZErqPxS2KoYd4FgECGA02YSQCb8vSTmP22FYnPeltxo1HP2VlfmcUCD+EwuqyVxAbSu6tgHlCKe5fjc5PMz/B9ZTCn4kkJ8aTA8oq6TNTi76cK7beSMHXPy/StYkrahmEDattNNpj7GayNX32NgOaka/tJu3eHNE41z2qU/Q5AQtlJS53gqyjZjpvJvA5gdgpSJc1Ph/6gxQWaR2FNRajAho/IlLWbMca13oprEeQYkZEYpDQdBf+0Wr5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oswSMGUt7NgDjuAm+bRkZqocwVsThB1IucHQHRYMt00=;
 b=oRcid0pIPa0MzALq44HInxwYz+7JbdZ1nrMRXADam02o8Xg1d/ti9fHZhqk8DJ5kWI5wrbJ3KnvlwstJ2Pp23ZTTfQfjJw7Mku9R1DgoG6ofX6V90667JKO3fifM/W6Ggdc0Vzx0zbW1fQiIPLqlG8tYTDqgi96qf3ZVY4+ZEZk=
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com (52.133.177.145) by
 TYAPR01MB2766.jpnprd01.prod.outlook.com (20.177.102.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Wed, 18 Mar 2020 09:13:50 +0000
Received: from TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::a882:860e:5745:25e1]) by TYAPR01MB2285.jpnprd01.prod.outlook.com
 ([fe80::a882:860e:5745:25e1%6]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 09:13:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Thread-Topic: Please check health for renesas board on LAVA
Thread-Index: AdX8pB3xKWT6vpR3T+GXr+q5DF2xkwAYO9fg
Date: Wed, 18 Mar 2020 09:13:49 +0000
Message-ID: <TYAPR01MB2285C867ACB9D7E7C7173901B7F70@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <OSAPR01MB3667C30E9485E66332CE184492F70@OSAPR01MB3667.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB3667C30E9485E66332CE184492F70@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Paterson2@renesas.com; 
x-originating-ip: [151.224.220.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad16a225-fc4c-4c8c-f15f-08d7cb1cac07
x-ms-traffictypediagnostic: TYAPR01MB2766:
x-microsoft-antispam-prvs: <TYAPR01MB27663DC1D91A7D70A3DE2EBCB7F70@TYAPR01MB2766.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(9686003)(55016002)(4744005)(478600001)(5660300002)(81156014)(81166006)(8936002)(966005)(316002)(71200400001)(7696005)(26005)(2906002)(186003)(86362001)(52536014)(4326008)(6506007)(33656002)(6916009)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB2766;
 H:TYAPR01MB2285.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GU2bLzV2KpNVG2O5TQ6baftb+iT3qiQl49RuZ5QYAAa4GFeFl1nwfOq8R9Q2Lu8pAwvxYqX7HB+v+ye1zokcvFrUfImfR7FMfULSF4avWK/+Ren9AddpqHAfv1BgbIgNVSS61SzP181dIlbz7u05girmsdDpVZ/c6o1fF8HFTX+2OpmYfdx4HWM5eh0t88l7APSqtfhCxbw6esJmgk8DNsEGDMnqEY052+WbpB5FsWRV7FpgzlAZ9mG3Q+2z+ToHSs2SPx+oOYJJ4zNjRQborkCnEKDp17pO5mCZqjtwT8HDYYCaHc+kI15LwuMO0iHzBgn+9LnPdwC9Z7Unp/fahuLKvnPXbytckeqHVRiAcQyANe0MJ2wV8NkvoX9N3Kdt9xCkWCmbM87kgNEfoF+cI4lneKmA4h0XToJRBw3GzuOMMEVPvZYlfjUz0BJZnijjtzwPcgy1+Cj0pjw9sWvaf/QaWfkrRX27cku3DH3JpryKt7TZbDfIO1OQhKnkf2hp+bZ7j+drOQh+Pau9nwOVHw==
x-ms-exchange-antispam-messagedata: /6Nd1guUiTjs9s5U57Pk2V40yWg6pAh2LCr20mjAjl18RbSaKeym1msASe/XiCbjO6WRg0FbnIeMDoYYaRjtRFPiMLZ1vdmqx8D7MTw3Wwulx+Ful/eZX+Rt+Dn3i0UAcz8wy+1hhtwT/kNm1LAlBw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad16a225-fc4c-4c8c-f15f-08d7cb1cac07
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 09:13:50.0449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVCCYX7P2VZucsSrbwmYENsAScxwZg6plC25TpwVLXHnO7dWcdikRBvYYTi06+jZPbbpqLiiJ4m9b5ED2NFib1QOlFrUg85/Dq+uxeRuRY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2766
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

SGVsbG8gSXdhbWF0c3Utc2FuLA0KDQo+IEZyb206IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJh
LmNvLmpwDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gU2VudDogMTgg
TWFyY2ggMjAyMCAwNTo0Mg0KPiANCj4gSGkgQ2hyaXMsDQo+IA0KPiBTb21lIFJlbmVzYXMgYm9h
cmRzIGxvb2sgbGlrZSBkb3duWzBdLg0KPiBUaGVyZWZvcmUsIHRlc3Rpbmcgd2l0aCBnaXRsYWIg
aGFzIG5vdCBiZWVuIGNvbXBsZXRlZC4NCg0KWWVzLCBzb3JyeS4gVGhlcmUgaXMgYW4gaXNzdWUg
d2l0aCBvbmUgb2YgdGhlIFVTQiBodWJzLg0KSG93ZXZlciB3ZSdyZSBhbGwgd29ya2luZyBmcm9t
IGhvbWUgYXQgdGhlIG1vbWVudCBzbyBpdCdzIG5vdCBlYXN5IGZvciBtZSB0byBnZXQgcGh5c2lj
YWwgYWNjZXNzLg0KDQpBcyBhIHRlbXBvcmFyeSBtZWFzdXJlIHllc3RlcmRheSBJIHJlbW92ZWQg
dGhlIHByb2JsZW1hdGljIGJvYXJkcyBmcm9tIG91ciBDSSBwaXBlbGluZXMsIHNvIGhvcGVmdWxs
eSBnb2luZyBmb3J3YXJkIHdlIHNob3VsZCBiZSBva2F5Lg0KVGhlIG9mZmxpbmUgYm9hcmRzIHdl
cmUgYWRkaXRpb25hbCBub24gQ0lQIHJlZmVyZW5jZSBwbGF0Zm9ybXMsIHNvIG91ciBDSSB3aWxs
IHN0aWxsIGJlIHRlc3Rpbmcgd2hhdCBuZWVkcyB0byBiZSB0ZXN0ZWQuDQoNClRoaXMgYWRkcyB0
byBteSBwb2ludCB0aGF0IHdlIG5lZWQgdG8gc3ByZWFkIHJlZmVyZW5jZSBwbGF0Zm9ybXMgb3Zl
ciBtb3JlIHRoZW4gb25lIGxvY2F0aW9uIPCfmIoNCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQo+
IA0KPiBDb3VsZCB5b3UgY2hlY2sgaXQ/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgTm9idWhp
cm8NCj4gDQo+IFswXTogaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9hbGxk
ZXZpY2VzDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmNpcC1kZXYgbWFpbGluZyBsaXN0CmNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnCmh0dHBz
Oi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vY2lwLWRldgo=
