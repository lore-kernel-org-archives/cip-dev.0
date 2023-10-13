Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47FCCDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 04:36:37 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.76])
 by mx.groups.io with SMTP id smtpd.web11.30961.1697166623358103109
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Oct 2023 20:10:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=g/qiCMa5;
 spf=pass (domain: siemens.com, ip: 40.107.20.76, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWc6ySzP+4nbJF2pVC6gX5BTv7QfCCrRiBdqasUHgH3B582s1S/ZYW1avMjwBoU7qOTOswrpB+rgqi7LJ3+mNY4tg28qeqwepQ39v8Ot0JOsaAz/wiUIH/OLllvsfVRGHs35NGIW7kuBD7oCeS+ghn5c0rM9Z3cCpQIOR83jKe+VDU3vr8X7V3rXbUp38mRrOyH6eIcM9rnkqlWjo4ixsSWzHve6/6ubn27aKeX8lz13yx1UB4R4E4YK/VLgPST6plfmYnKHg0p8Q08cyXK+9DzzGlmA+pMKAdpUzfE7xOBYjHTOS45BcPc0qWMh3lp7+mn08P8au0S7Ufl9BA4G1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXt8vRdn+F7w51YwO0B/E6SwCZ5WUUIPicwAe3uZVME=;
 b=iTjvO+QA2PgMXHgoRI8FQb3VzuaiR2uAjG6XOG2edHi7r5yNmtwRJPBhYYeYwmiuk7iVIdHP0fpaI+0h6r0auuVSWu67iQxVbkElXc9w/Tf7Z/F/+Morvn67UNa+mn2/Ghs4XRPh2UXtePIseoI0TG2vwvccxucKRNh36eRHPJ7/IjZdkbIAqZiSikzL28CswaCfkAqGjH1SlL5ghS06YkFwtqJ86VPX+8KRhOG5diCVKgGVl3N+0G/SqbeUDrQFM5QX9A8/8lb490nLfQtKMGwkxPwl7CrEgBHxu0HYPmdSC+UZpFkVgMKN/wRXqYlAuGAyqiPiy46sr1C2ew+ZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXt8vRdn+F7w51YwO0B/E6SwCZ5WUUIPicwAe3uZVME=;
 b=g/qiCMa57ns92tjJBLGcD25IcePfOSpjawDqF4L7Zm0HXMvDk638+9C5aVo0Zdyxsd5F/gwqlitCNLwszHMqVa3QKOgymhJqjY8SAuvqJQCckHsKOkIbtukW/0OhMkMSSNiZscP5buEWslErTSo5imyyTGKTy4J5M6/xg5v8SQGwggUPAE6C3Ek2vb65tDKrYsmGvIg8HGSD0CodvwugD6glNMEwvWcngm8Aqq0nbeNQQ9tBPe9Ql7L35+JMsy6D5REhxN5apUvs7cV5e2wsC5k3K3wuc0SAM1OAQtQU01aALjv7NH2h3neaFNtjsrzsFJsONFN/IKcTbHwCUJZ8Wg==
Received: from AS4P192CA0034.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::13)
 by DB5PR10MB7917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 03:10:20 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::10) by AS4P192CA0034.outlook.office365.com
 (2603:10a6:20b:658::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.31 via Frontend
 Transport; Fri, 13 Oct 2023 03:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 03:10:19 +0000
Received: from CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.23; Fri, 13 Oct 2023 05:10:18 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M06MSX.ad011.siemens.net (139.24.237.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 11:10:16 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.032; Fri, 13 Oct 2023 11:10:16 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH] verity: Prepare generation of metadata file for Isar update
Thread-Topic: [isar-cip-core][PATCH] verity: Prepare generation of metadata
 file for Isar update
Thread-Index: AQHZ/T2B5OS2+V5px0GNPwpJa+nYK7BGhPoA
Date: Fri, 13 Oct 2023 03:10:15 +0000
Message-ID: <a3227a8c5bb18ca4478b5eccdbcfa9c94c8c445c.camel@siemens.com>
References: <4747221e-c969-463e-bee0-6a3304e7a144@siemens.com>
In-Reply-To: <4747221e-c969-463e-bee0-6a3304e7a144@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.51]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DB5PR10MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceeade4-0c3c-4320-1a01-08dbcb99ee77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZHmqMlbwbSIzCIgRaLf5Qx9kQCv81mCCQZAyHqd/oVd4NKzFBLxPL5pUNr9XhtCLeU7VfOpsPIwxQmni0x24XF7LXnYeNDYCa0MkNxq4x4nXRAluh/CMA4epmIORwg5bDPN7sFerDrxS/7WGxIuFfzs31u1I62pAWl1P/piwxmzs5re1n69SNW8Qe3aQWoyW45IFH6yxbX+TyT6/LA6mg8T41XY0ow5qvGylxxdmqbaOIvSQf5OKdtOde0Ct92+Z4V7yZ38JkcQqaNPRzBV0Bi1ZsJB7PIt9jqQAyc/o5fMahg0r73Ns03tjKHKID1koL190Ua1yyqnE+sR2J09ivFdwO7U0pFVXpXnYfwPhJqU6bks67wmWtD5m0DOekIOBmkGCx/jZe/8uu7GG5IZMQL5JgQ8GQy3ccoMFIbJnc0i72ViG6uL/LQEvw81Vy4IsFW8VCq4nznW1dOaxh9zIVeBAWGRULwKgj1KtICmJdrFWu+Nz2BYPMM5hggHesncpzT5poYAssQk/FUIb4BM1KDRDYWTLZ2a+lB3X2sN9Fc6IE4UazuTlCLdeUxTITYOQiUBioM9wung6IpkzZjB/8CpOBairfqZ8MjTeV3XTdJgicztH1eL0gEA93jzzPd0Bv49FLGji4AnbzL4DNT9kE0eGx8LXBblzdXnbSFnmnPjj6xD7pxVxBBZoKKj10ENsKOqEvbZiJGf8QuUG9Xc6KPZopbq+u3+zoALV2E1sd/kF2bwlJy/pvm9Kh/1+gVmIZWPJh51kUHjNYaaENvRlvw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(26005)(956004)(6636002)(316002)(2616005)(110136005)(70586007)(41300700001)(70206006)(83380400001)(8676002)(8936002)(336012)(478600001)(40460700003)(47076005)(15650500001)(2906002)(36860700001)(4001150100001)(5660300002)(82740400003)(40480700001)(356005)(81166007)(82960400001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 03:10:19.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceeade4-0c3c-4320-1a01-08dbcb99ee77
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7917
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <60BF2F0E4EEE1741A6EDDC53361333CC@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Oct 2023 04:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13394

T24gVGh1LCAyMDIzLTEwLTEyIGF0IDIwOjU0ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gVGhpcyB3aWxs
IGJlIGNvcnJ1cHRlZCBvbmNlIFNVRE9fQ0hST09UIGlzIHN3aXRjaGVkIGJ5IGlzYXIgdG8gdXNl
DQo+IGltYWdlX3J1biB3aGljaCB3aWxsIGFsc28gb3V0IHNvbWUgc2Nocm9vdCBib290LXVwIG1l
c3NhZ2VzLg0KPiANCj4gUmF0aGVyIHRoYW4gZGVsZXRpbmcgdGhlIG1ldGFkYXRhIGluaXRpYWxs
eSwgd2UgdHJ1bmNhdGUgYW55IGV4aXN0aW5nDQo+IGZpbGUgdG8gMCBzbyB0aGF0IGZpbGUgcGVy
bWlzc2lvbnMgYXJlIHNldCBvdXRzaWRlIG9mIHRoZSBzY2hyb290DQo+IGFscmVhZHkuIFRoYXQg
aXMgbmVlZGVkIHRvIG1vZGlmeSB0aGUgZmlsZSBhZnRlciB0aGUgc2Nocm9vdCBhcyB3ZWxsLg0K
DQpJJ20gbm90IHN1cmUgaWYgdGhlIHNjaHJvb3Qgc2V0dXAgbWVzc2FnZXMgY2FuIGJlIGRpc2Fi
bGVkLCBidXQgaXQgaXMNCnByb2JhYmx5IGFueXdheXMgYmV0dGVyIHRvIG5vdCBoYXZlIGFueSB3
cmFwcGVycyBpbiBiZXR3ZWVuIHRoZQ0KZ2VuZXJhdG9yIGFuZCB0aGUgb3V0cHV0IGZpbGUuDQoN
CkFja2VkLWJ5OiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29t
Pg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMu
Y29tPg0KPiAtLS0NCj4gDQo+IEkndmUgc3F1ZWV6ZWQgdGhhdCBiZWZvcmUgInVwZGF0ZSBJU0FS
IHRvIGxhdGVzdCB2ZXJzaW9uIG9uIG1hc3RlciANCj4gYnJhbmNoIiB0byBhdm9pZCB0aGUgcmVn
cmVzc2lvbiB0aGUgbGF0dGVyIHBhdGNoIHdvdWxkIGhhdmUgY2F1c2VkDQo+IChvciANCj4gY2F1
c2VkIHNvIGZhciBpbiBuZXh0KSBvdGhlcndpc2UuDQo+IA0KPiDCoGNsYXNzZXMvdmVyaXR5LmJi
Y2xhc3MgfCA2ICsrKy0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy92ZXJpdHkuYmJjbGFzcyBi
L2NsYXNzZXMvdmVyaXR5LmJiY2xhc3MNCj4gaW5kZXggYmFjZjU5MjYuLjkwMzBjODQ0IDEwMDY0
NA0KPiAtLS0gYS9jbGFzc2VzL3Zlcml0eS5iYmNsYXNzDQo+ICsrKyBiL2NsYXNzZXMvdmVyaXR5
LmJiY2xhc3MNCj4gQEAgLTg1LDExICs4NSwxMSBAQCBkb19pbWFnZV92ZXJpdHlbY2xlYW5kaXJz
XSA9ICIke1dPUktESVJ9L3Zlcml0eSINCj4gwqBkb19pbWFnZV92ZXJpdHlbcHJlZnVuY3NdID0g
ImNhbGN1bGF0ZV92ZXJpdHlfZGF0YV9ibG9ja3MNCj4gZGVyaXZlX3Zlcml0eV9zYWx0X2FuZF91
dWlkIg0KPiDCoElNQUdFX0NNRDp2ZXJpdHkoKSB7DQo+IMKgwqDCoMKgIHJtIC1mICR7REVQTE9Z
X0RJUl9JTUFHRX0vJHtWRVJJVFlfT1VUUFVUX0lNQUdFfQ0KPiAtwqDCoMKgIHJtIC1mICR7V09S
S0RJUn0vJHtWRVJJVFlfSU1BR0VfTUVUQURBVEF9DQo+ICvCoMKgwqAgZWNobyAtbiA+JHtXT1JL
RElSfS8ke1ZFUklUWV9JTUFHRV9NRVRBREFUQX0NCj4gwqANCj4gwqDCoMKgwqAgY3AgLWEgJHtE
RVBMT1lfRElSX0lNQUdFfS8ke1ZFUklUWV9JTlBVVF9JTUFHRX0NCj4gJHtERVBMT1lfRElSX0lN
QUdFfS8ke1ZFUklUWV9PVVRQVVRfSU1BR0V9DQo+IMKgDQo+IC3CoMKgwqAgJHtTVURPX0NIUk9P
VH0gL3NiaW4vdmVyaXR5c2V0dXAgZm9ybWF0IFwNCj4gK8KgwqDCoCAke1NVRE9fQ0hST09UfSBz
aCAtYyAnL3NiaW4vdmVyaXR5c2V0dXAgZm9ybWF0IFwNCj4gwqDCoMKgwqDCoMKgwqDCoCAtLWhh
c2gtYmxvY2stc2l6ZSAiJHtWRVJJVFlfSEFTSF9CTE9DS19TSVpFfSLCoCBcDQo+IMKgwqDCoMKg
wqDCoMKgwqAgLS1kYXRhLWJsb2NrLXNpemUgIiR7VkVSSVRZX0RBVEFfQkxPQ0tfU0laRX0iwqAg
XA0KPiDCoMKgwqDCoMKgwqDCoMKgIC0tZGF0YS1ibG9ja3MgIiR7VkVSSVRZX0RBVEFfQkxPQ0tT
fSIgXA0KPiBAQCAtOTgsNyArOTgsNyBAQCBJTUFHRV9DTUQ6dmVyaXR5KCkgew0KPiDCoMKgwqDC
oMKgwqDCoMKgICIke1ZFUklUWV9JTUFHRV9VVUlEX09QVElPTn0iIFwNCj4gwqDCoMKgwqDCoMKg
wqDCoCAiJHtQUF9ERVBMT1l9LyR7VkVSSVRZX09VVFBVVF9JTUFHRX0iIFwNCj4gwqDCoMKgwqDC
oMKgwqDCoCAiJHtQUF9ERVBMT1l9LyR7VkVSSVRZX09VVFBVVF9JTUFHRX0iIFwNCj4gLcKgwqDC
oMKgwqDCoMKgID4iJHtXT1JLRElSfS8ke1ZFUklUWV9JTUFHRV9NRVRBREFUQX0iDQo+ICvCoMKg
wqDCoMKgwqDCoCA+PiIke1BQX1dPUkt9LyR7VkVSSVRZX0lNQUdFX01FVEFEQVRBfSInDQo+IMKg
DQo+IMKgwqDCoMKgIGVjaG8gIkhhc2ggb2Zmc2V0OsKgwqDCoMKgwqDCoMKgwqDCoCR7VkVSSVRZ
X0lOUFVUX0lNQUdFX1NJWkV9IiBcDQo+IMKgwqDCoMKgwqDCoMKgwqAgPj4iJHtXT1JLRElSfS8k
e1ZFUklUWV9JTUFHRV9NRVRBREFUQX0iDQoNCg==

