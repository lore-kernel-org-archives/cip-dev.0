Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7934FC46CCA
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 20:28:04 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.49])
 by mx.groups.io with SMTP id smtpd.web11.2434.1699990863646924628
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Nov 2023 11:41:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hLpPuGTn;
 spf=pass (domain: siemens.com, ip: 40.107.104.49, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4+VssX9opQ0wpfdJ3Mjci5gkHhqEUjJs1xdFa9a9tPMjTUUM6Bh9SHJzjhRyiOCehXHSoAUe5T8ONMbEzSdPR7Dg5D9yE4iHd6/fGiuwHOcv8L66gmQE4hW74DqxpxcXikifYSUrc+tTruc4QdFhwTjoGNAZ+nZxaMEZq+EzDGCihjXwHmGQ9IZGJSbxGlEKs/ud/En0rfCc2jnI78V7LTgFP7clYIbNsjRXTqWe1Lmmvy9dIEyXb0+PAoVIqYwFitfzjqVNMNtY0hwSGlIWxKtZoDiOUkMokLhng72SSqvU6cVPItVAT33pnjftKVjweQZ4bk5AisA2iuoHrjw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK9TJH3fJ4m5HkML3yScFAZVUszE/07qlF1D4IbRVAQ=;
 b=SwsHLP0v3yFPAosHHx5EGI7cKRzfVmJLimBAi2qSLya36pqtljVQvZp1AI4tJOOYdm47RBjNwcbpDwzuywzji3wh+db17U6cu2Flf/ENtm4oe70Z8f5lrohySFXmACuh/N/fk1FB41tXB08+TrWXrjVSRUfnYegdG+I72TRFdKdldyJ9bPrNogT2o484WhdU7qxr1H9USL+8QFsRAbMHNnDewTN3znqN7Jikiayyonr+VyNE3k5tPEgb3af5F4ExuOQQcYeBk/X44m0l2hiZAax4Pp1rTMTKJX9OudEf5uh3d+B1FGLt013Bih3IrC+jH31Y10nhsw9DpBMTkQV+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK9TJH3fJ4m5HkML3yScFAZVUszE/07qlF1D4IbRVAQ=;
 b=hLpPuGTnO5THQMWtaEX9I6kWc6slyt87FCPC6w9HPBWkXENPTz6heUIfLnDr4hnFkXzTOPjAeltYhtDVn67RSoUj+iFbLtJM2EyV901pJJ64aH1Ojn/HghurYgcKgGmymmKnLMIaygMjKk47JkBDu9s/EuoVxf12/8Lf2IBGS09u0tnNHwZPPrRXXPQxQHcIpEC0wUoeT8qeYFDd7h5Jf7DRzQPu89uYSV49y47Vot+1riwPAapwLseCdHaYmMaegGVTGq3txOEgb/AVVOJIb6LO0H75ySPfpwbhn0ItomqRgDF2jtGqAhw9nHs49njrcAGVkEby7LXWAQDvOg2/9g==
Received: from AM0PR06CA0130.eurprd06.prod.outlook.com (2603:10a6:208:ab::35)
 by DB8PR10MB3739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Tue, 14 Nov
 2023 19:41:00 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::81) by AM0PR06CA0130.outlook.office365.com
 (2603:10a6:208:ab::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 19:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.74) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 19:40:58 +0000
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 14 Nov 2023 20:40:57 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 03:40:52 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.034; Wed, 15 Nov 2023 03:40:52 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Update to efibootguard 0.16
Thread-Topic: [cip-dev][isar-cip-core][PATCH] efibootguard: Update to
 efibootguard 0.16
Thread-Index: AQHaFzJ5OiYi+sGbLECxrX9iNXZMIA==
Date: Tue, 14 Nov 2023 19:40:52 +0000
Message-ID: <d4330c0838bccab3a7a231caab5753f6b8aba2f4.camel@siemens.com>
References: <20231113100528.127244-1-Quirin.Gylstorff@siemens.com>
	 <bf97043c-4e70-41b6-98bd-15b42ef66ee0@siemens.com>
In-Reply-To: <bf97043c-4e70-41b6-98bd-15b42ef66ee0@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [140.231.111.226]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-as-result: No-10--21.301700-8.000000
x-tmase-matchedrid: kxpaLTp5p67dDS6etHbe2xUPMjLtuSnBDDw2a573DPfAsQvj68mG04HZ
	B8pBnDKZP4XE9vEibPIhlG9iTcYtaqNIXC+Evb2D+tClQO7LquTtWteqKqfAdT8Ckw9b/GFeP6T
	ki+9nU3/pNRJxzW1obtKfQ2mUc6Ddzq3+U82RYvEQwEMBBc8ejBA28Q5ejUOd5QEeLkPp6LLJ5S
	XtoJPLyDxzAG47ocHfT+pHS7C+dZHo6dWzkF+OLk58Fhz8Vuqn7BM/cnFsGwp+J3gtIe0gA9jhk
	7FwD7j2U72YOAMDJjieAiCmPx4NwHJnzNw42kCxxEHRux+uk8gVQUmbYHof0Q==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--21.301700-8.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-snts-smtp: 657CC48C49781EDD314F181DEBC10D8C75B990BF97DC9D10F2E3F093FCB992A52000:8
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|DB8PR10MB3739:EE_
X-MS-Office365-Filtering-Correlation-Id: c670003f-7a2d-4f8b-ddfc-08dbe549a048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N6M0jPWMYhpKoQ5Ac8EmoEy9i1zQEJEc/wMSwyjpRCGBVOM53OsrT6LJstXVRmgrxq5aLmfoll8styOab+qiqoq3K+iXK2V9VxvWkHgZ8qaX6RYgM184UyX6Yn3YhowFiGrDcxNgbXIBpPPrsijKbtgWFpxjLzkvn+3FSqBcIF0gapcmY9aQUuheRu3eT21Vx8xRajLzTJ/OfnEmKBUjyuKl+EW7XDlzjn5m58pHCG652EzAXZ+OeJBiNS72jhZzVXHeoGPzTF5wpnlzqPLmPQUxa0szNF0//0tNJGxvRsnViDkNOg1LdW3F+aumIl3qtFgEfcRFAAUzcMVoeJeATRK5j60QefMpIz2QuZCxR7cPOX4tXazM80xfZ15vnB3iBXcu1zY82dw0oRXzgb9emKKCe9zXpGyWYi5Gr/XOUSn3NQPzeBHQ00tf/zAaHkOi1+revxJRRvJ4bucBEjtwqCcKg9GC9HdKUwBF/b3BiI06BLNFDiJLTwk8G6axioS3JLcxjbAiSst+VubWQJmWNxEe8zDFXfzkfw2WmbH4qsBHFat4BpRqbjBp/eUbFVJk5+Cg3KgJ1FtYFJe1me7QLz0EhZrW9RjfOInJbmHvDH2GRSzlZ5SxrMVGax9PgAooBGirBLEo2EG4yue+RbQkQ3nIfFgFIqNK88HYdgKm+x9CO2LSW5EkkQSdee3CriPIkBu7UKL++yIshrPDl9D3uHQWXvevBViXL2yEn4f7vIGtr2WUpyH/rl+6HtPEDfzCDDNRH8Toi6HvY1CVGP4PVw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(2616005)(956004)(26005)(40460700003)(336012)(82960400001)(82740400003)(53546011)(478600001)(83380400001)(86362001)(966005)(36860700001)(5660300002)(47076005)(36756003)(110136005)(4001150100001)(41300700001)(2906002)(70586007)(70206006)(7596003)(7636003)(356005)(316002)(6636002)(8936002)(40480700001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 19:40:58.7091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c670003f-7a2d-4f8b-ddfc-08dbe549a048
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3739
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DEC50C3417EDE4CB382C66423424E63@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Nov 2023 20:28:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13581

T24gTW9uLCAyMDIzLTExLTEzIGF0IDE2OjQ2ICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMy4xMS4yMyAxMTowNCwgUXVpcmluIEd5bHN0b3JmZiB3cm90ZToNCj4gPiBGcm9tOiBRdWly
aW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20+DQo+ID4gLS0tDQo+ID4gwqAuLi5maWJvb3RndWFyZF8wLjE1LTErY2lwLmJiID0+IGVmaWJv
b3RndWFyZF8wLjE2LTErY2lwLmJifSB8IDYNCj4gPiArKystLS0NCj4gPiDCoDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gwqByZW5hbWUgcmVjaXBl
cy1ic3AvZWZpYm9vdGd1YXJkL3tlZmlib290Z3VhcmRfMC4xNS0xK2NpcC5iYiA9Pg0KPiA+IGVm
aWJvb3RndWFyZF8wLjE2LTErY2lwLmJifSAoODQlKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9y
ZWNpcGVzLWJzcC9lZmlib290Z3VhcmQvZWZpYm9vdGd1YXJkXzAuMTUtMStjaXAuYmINCj4gPiBi
L3JlY2lwZXMtYnNwL2VmaWJvb3RndWFyZC9lZmlib290Z3VhcmRfMC4xNi0xK2NpcC5iYg0KPiA+
IHNpbWlsYXJpdHkgaW5kZXggODQlDQo+ID4gcmVuYW1lIGZyb20gcmVjaXBlcy1ic3AvZWZpYm9v
dGd1YXJkL2VmaWJvb3RndWFyZF8wLjE1LTErY2lwLmJiDQo+ID4gcmVuYW1lIHRvIHJlY2lwZXMt
YnNwL2VmaWJvb3RndWFyZC9lZmlib290Z3VhcmRfMC4xNi0xK2NpcC5iYg0KPiA+IGluZGV4IDBj
ZmI2ZGEuLmFkYTA1OTIgMTAwNjQ0DQo+ID4gLS0tIGEvcmVjaXBlcy1ic3AvZWZpYm9vdGd1YXJk
L2VmaWJvb3RndWFyZF8wLjE1LTErY2lwLmJiDQo+ID4gKysrIGIvcmVjaXBlcy1ic3AvZWZpYm9v
dGd1YXJkL2VmaWJvb3RndWFyZF8wLjE2LTErY2lwLmJiDQo+ID4gQEAgLTE3LDEyICsxNywxMiBA
QCBMSUNfRklMRVNfQ0hLU1VNID0NCj4gPiAiZmlsZTovLyR7TEFZRVJESVJfaXNhcn0vbGljZW5z
ZXMvQ09QWUlORy5HUEx2MjttZDU9NzUxNDE5MjYwDQo+ID4gwqBNQUlOVEFJTkVSID0gIkphbiBL
aXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+Ig0KPiA+IMKgDQo+ID4gwqBTUkNfVVJJID0g
IiBcDQo+ID4gLcKgwqDCoA0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9zaWVtZW5zL2VmaWJvb3Rn
dWFyZC9hcmNoaXZlL3JlZnMvdGFncy92MC4xNS50YXIuZ3o7ZG93bmxvYWRmaWxlbmFtZT1lZmli
b290Z3VhcmRfMC4xNS5vcmlnLnRhci5nejt1bnBhY2s9MDtuYW1lPXRhcmJhbGwNCj4gPiDCoFwN
Cj4gPiArwqDCoMKgDQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3NpZW1lbnMvZWZpYm9vdGd1YXJk
L2FyY2hpdmUvcmVmcy90YWdzL3YwLjE2LnRhci5nejtkb3dubG9hZGZpbGVuYW1lPWVmaWJvb3Rn
dWFyZF8wLjE2Lm9yaWcudGFyLmd6O3VucGFjaz0wO25hbWU9dGFyYmFsbA0KPiA+IMKgXA0KPiAN
Cj4gTWF5YmUgYSBnb29kIGNoYW5jZSB0byB1c2UgJHtAZC5nZXRWYXIoJ1BWJykuc3BsaXQoJy0n
KVswXX0gaGVyZT8NCg0KR2l2ZW4gdGhlIG51bWJlciBvZiB0aW1lcyB3ZSBub3cgaGF2ZSB0aGlz
IHBhdHRlcm4gKGFuZCB0aGF0IHdlIG5vdw0KYnVpbGQgc291cmNlIHBhY2thZ2VzIGFzIHdlbGwp
LCBpdCBwcm9iYWJseSB3b3VsZCBtYWtlIHNlbnNlIHRvIGFkZCBhDQp2YXJpYWJsZSBpbiBJU0FS
IGZvciB0aGlzLCBsaWtlIFNQVi4NCg0KRmVsaXgNCg0KPiANCj4gPiDCoMKgwqDCoA0KPiA+IGdp
dDovL3NhbHNhLmRlYmlhbi5vcmcvZGViaWFuL2VmaWJvb3RndWFyZC5naXQ7cHJvdG9jb2w9aHR0
cHM7YnJhbmMNCj4gPiBoPW1hc3RlcjtuYW1lPWRlYmlhbiBcDQo+ID4gwqDCoMKgwqANCj4gPiBm
aWxlOi8vZGViaWFuLXBhdGNoZXMvMDAwMS1kLWNvbnRyb2wtTWFrZS1jb21wYXRpYmxlLXdpdGgt
ZGViaWFuLWJ1c3Rlci5wYXRjaA0KPiA+IMKgXA0KPiA+IMKgwqDCoMKgICINCj4gPiAtU1JDX1VS
SVt0YXJiYWxsLnNoYTI1NnN1bV0gPQ0KPiA+ICI5ZDJkNDY5MTNlZDgwMTMwNTZhM2MyYjA4MGE5
OTdlNjhkNzhkOTJhMTA1MWNlZDA2ZmJmZWZhOTMzNTNiYjdmIg0KPiA+IC1TUkNSRVZfZGViaWFu
ID0gImUzOTcyOGY2Mzk0NmQxYWYyZDVlZGJlY2Q4OWEzMDcwNmRjMzFhOWEiDQo+ID4gK1NSQ19V
UklbdGFyYmFsbC5zaGEyNTZzdW1dID0NCj4gPiAiZDZkMzdjNTlhZWQxNzQ4OWQwMmI0ZjBiNjNk
YjE2OTk0ZGZiOGY5ZjcwZjU0YmU0ZDY1YzM2NmY1OGM2YmU5ZCINCj4gPiArU1JDUkVWX2RlYmlh
biA9ICIyZTgwZmFmYTg3ZjhmNmZkMDkzZjQ5ZmYzM2FkN2NhYzYxNTkyODcxIg0KPiA+IMKgDQo+
ID4gwqBQUk9WSURFUyA9ICJsaWJlYmdlbnYtZGV2IGxpYmViZ2VudjAgZWZpYm9vdGd1YXJkIg0K
PiA+IMKgDQo+IA0KPiBKYW4NCj4gDQoNCg==

