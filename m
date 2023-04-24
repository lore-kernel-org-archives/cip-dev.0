Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D85FC7618E
	for <webhook@archiver.kernel.org>; Mon, 24 Apr 2023 12:03:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.59])
 by mx.groups.io with SMTP id smtpd.web10.46529.1682326282597569072
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Apr 2023 01:51:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AIcO2E4t;
 spf=pass (domain: siemens.com, ip: 40.107.20.59, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGGJHV6AG1hNNpzf3I8g+D/LIaQf+tdYlLyOvHv/r1sg904Y1HBd8RzLME26GK4DmNj2BEH4avRY3aAs0TxLdjM2biGPpII12jIbZl/EBCQJfqy1kCeYKSYvZ0YdQ18bsyVQvhw1bmPKdrNppDo3ZlbMC7K82p/0hK0KcMdBah6N5C3qBMooHQcFvxE/PkVBN5oU5EgGgART48+ArYvE+VSXIJTH/+dqKol/e6yw0juoTcvAtetrpHtTuiA+1k4QXK4sBJu2WYZLZC9xgrT9vAT7IIa5m3VKRM1fgaEo6qM8X//hrJ10sxSELvXxp7HJ7pWtNxuSvM8WObYnUdzyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0LGT9bIU2z7hT+7HpZaUIHmZNrJODKtNy0d1MJ4pXU=;
 b=Q4ELaA9nBf5AC5fYunMnXi1kmm5G4OUa5jWanza8fLQoDWLFmJyL1MBekCk0DQdnqsrs8gD9HLjfQtW9lSrE0uQd0cqqAOjPTyS8qtOn22yv1680DeywkECZH8bUtikKGmq2HY4w+Sm3ogTRXQuIHZTuGNg5tEEpnG95d1DNHTTqx4/TYVWrRHCjv9Wfge8faJFYrdm5OYW47Bkt39b1iDvGn28WZjF0AqP1yufgU3etZYumrrAZ45ZVyYvAnlLQVZrl/PFaFFqh0zXhQ1tUup6pd9xLXQnaxyy/dvJ2RtRa87Fw2PSFgmMKYDeyeidp3UbSVP+WA7g3RW76z0l5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0LGT9bIU2z7hT+7HpZaUIHmZNrJODKtNy0d1MJ4pXU=;
 b=AIcO2E4t+lCysuovMM44Gb8KQxEVl5KRu4gJc8GGPGJcty9hcsncWpFW0jrDz536bQjfs983ZfxR78kQ9ljV39iZCMFpzpN7IkDDM7xCpfzfs9IfpbV/nLqVab892e/s/W2IQnSXJckrP68/IxvBWrlJnywsixD3e5GKO93JP2ML4HRtPn1x0hwl6sYvPXMi+2DE7F5WRBPN6Txxb6o3cuAhgPkIspeXQ9YRqcnCKhZKeq4TPQTQ3ADtRA+6Z/NFG4b80tX7DgrkMwkgMXWzXFbLmeDVlay8nNUU0bA3egIXrOa54se45f2ja53f4jbg5Ffglsg6+HOUNPLOo/9ItQ==
Received: from ZRAP278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::18)
 by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Mon, 24 Apr
 2023 08:51:18 +0000
Received: from VE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:10:cafe::fe) by ZRAP278CA0008.outlook.office365.com
 (2603:10a6:910:10::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 08:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT012.mail.protection.outlook.com (10.152.2.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 08:51:17 +0000
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 24 Apr 2023 10:51:16 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 24 Apr 2023 16:50:45 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Mon, 24 Apr 2023 16:50:45 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v4] efibootguard: use debian folder from salsa
Thread-Topic: [cip-dev][isar-cip-core][PATCH v4] efibootguard: use debian
 folder from salsa
Thread-Index: AQHZdFt3wFjGI+/ooUeCAxAOsD5CXq81hn8AgAQZIwCAAAUyAA==
Date: Mon, 24 Apr 2023 08:50:45 +0000
Message-ID: <f1175c11ad2e550f839ff60b955940be4b3fd369.camel@siemens.com>
References: <20230421141330.3905234-1-Quirin.Gylstorff@siemens.com>
	 <f4ec927f-5d19-48e3-84ec-b8dea9b5c13e@siemens.com>
	 <cb6b51f2-be45-d758-e718-c18fdd37c4de@siemens.com>
In-Reply-To: <cb6b51f2-be45-d758-e718-c18fdd37c4de@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.25]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT012:EE_|GV2PR10MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 60eb874b-06a7-4ea9-6881-08db44a1119b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lcD5BtiiMRaFR0KG5tVhyLQcIy32r4y55mImL+HDojBf1dZ47TjvShB6DflTt6f/cDrsxMnubXdKOchC9aZsjmHJ6y1DWuY3RFN9m6PlaKmOlkVYJ3oA6Kw12IOM+znK22ovSQPH2YEXi/wNOyUuX5E6BkOHvk8iJyH2/ukQMj0GMRA4YFBGtcYGMPyxExPHX0usHk9GQGlHrRUx9kqXcbaxN2NmNcvMfL04TlDJt56/vEJgKQGOL1ycldq0qSEPt28nGkmM84rylzchFBaSI/Vj6FtkqFCnUkNl0Jdayoi3q7V9mnpDJAs4AAYrTKq4eb/yvVOV/lr7+yg5ZPLM03VnQCYQ5WDCZC042p65prPArKbAmkLKW6QYngAzNePZf7NhHts+aJ33U8lPZI5NxSf92AWvKhrQDgPcSaslNSCINqFySJvIY1AyynKnU1IVSYnf6R/sT19plDaTiELQia2c+DSZsdwj32J02LMnMY9sfUvwDHprj+Up3toPE/1+VZ/Bo3lzEMHv/VZMJ2NZZko8REoTiaEIStRVCfVXZd2Qdi9xXG0GiJ/1UbSsyfSuVTt7Gd4/PC1u2Fk5inGwbD/Lrd1qX3SMXaY9UatcgFaolm6w7ZSIbjwXi77X/h02Jk8YDNOdSTZ98ljEwPX1I6I+Bfb7YEaJjunSAZNMevusuQQktkcBc3wkOqonRmdHq/3tXUQte0YXoELqAwaJmpfAFO4cwm7WAyzY+DWFejM=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(41300700001)(5660300002)(8936002)(8676002)(47076005)(36860700001)(53546011)(186003)(26005)(2616005)(336012)(956004)(40460700003)(82740400003)(82960400001)(356005)(81166007)(86362001)(40480700001)(316002)(36756003)(966005)(478600001)(70206006)(70586007)(110136005)(6636002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 08:51:17.8253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eb874b-06a7-4ea9-6881-08db44a1119b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT012.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6186
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <048B518656AF0F498581AE91635F328F@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Apr 2023 12:03:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11334

T24gTW9uLCAyMDIzLTA0LTI0IGF0IDEwOjMxICswMjAwLCBHeWxzdG9yZmYgUXVpcmluIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDQvMjEvMjMgMTk6NTYsIEphbiBLaXN6a2Egd3JvdGU6DQo+ID4gT24g
MjEuMDQuMjMgMTY6MTMsIFF1aXJpbiBHeWxzdG9yZmYgd3JvdGU6DQo+ID4gPiBGcm9tOiBRdWly
aW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+ID4gDQo+ID4g
PiBUbyBhdm9pZCBwYWNrYWdlIG5hbWUgY29uZmxpY3RzIGJldHdlZW4gY2lwLWNvcmUgYW5kIERl
Ymlhbg0KPiA+ID4gdXBzdHJlYW0NCj4gPiA+IHVzZSB0aGUgZGViaWFuIGZvbGRlciBmcm9tIHVw
c3RyZWFtIHRvIGJ1aWxkIGVmaWJvb3RndWFyZC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gQ2hhbmdlcyB2NDoNCj4gPiA+IMKgIC0gcmVhZGQgcGF0Y2ggMDAwMi1kLWNv
bnRyb2wtcmVtb3ZlLW5hdGl2ZS1mcm9tLXB5dGhvbjMtDQo+ID4gPiBzaHRhYi5wYXRjaCB0bw0K
PiA+ID4gwqDCoMKgIGFsbG93IGJ1aWxkIGZvciBxZW11LWFybTY0IGFuZCBxZW11LWFybS4gc2Vl
DQo+ID4gPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAt
Y29yZS8tL3BpcGVsaW5lcy84NDQ1ODAyNDcNCj4gPiANCj4gPiBJcyB0aGF0IHBhdGNoIGFsc28g
dXBzdHJlYW0gcmVsZXZhbnQ/IE9yIGlzIHRoYXQgb25seSBuZWVkZWQgZm9yDQo+ID4gb2xkZXIN
Cj4gDQo+IFRoaXMgbG9va3MgbGlrZSBhIGNvbmZsaWN0IHdpdGggY3Jvc3NidWlsZGluZyB0aGUg
cGFja2FnZSBpbiBJU0FSLg0KPiBUaGUgDQo+IGVycm9yIGRvZXMgbm90IG9jY3VyIG9uIHVwc3Ry
ZWFtIGFzIHVwc3RyZWFtIGJ1aWxkcyB0aGUgcGFja2FnZQ0KPiBuYXRpdmUuIA0KPiBJIG5lZWQg
dG8gdGVzdCBpZiB0aGUgcGF0Y2ggaXMgbmVjZXNzYXJ5IGZvciBib29rd29ybS4NCg0KVGhhdCBt
YWtlcyBzZW5zZS4gSSBhbHNvIG9ic2VydmVkIHRoaXMgaXNzdWUgaW4gYSBjcm9zcyBidWlsZA0K
ZW52aXJvbm1lbnQgKGJ1dCBkaWQgbm90IHJlbGF0ZSBpdCB0byB0aGlzIHNjZW5hcmlvKS4gV2l0
aCB0aGUgcGF0Y2gNCmFwcGxpZWQsIHRoZSBidWlsZCB3b3JrcyBhZ2Fpbi4NCg0KRmVsaXgNCg0K
PiANCj4gUXVpcmluDQo+IA0KPiA+IGJ1bGxzZXllL2J1c3Rlcj8NCj4gPiANCj4gPiBKYW4NCj4g
PiANCg0K

