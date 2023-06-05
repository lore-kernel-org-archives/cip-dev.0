Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA89DC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:41:22 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.40])
 by mx.groups.io with SMTP id smtpd.web10.1707.1685949251741307707
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 00:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KCyr2+jQ;
 spf=pass (domain: siemens.com, ip: 40.107.6.40, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzB8kCkvQ4elBTt0IG458WHYSd+zHNr88S5pVm6nKnKJ0YPaMUuTTlOWV9o2dqHEf1bWwg9DZX4zmtZ4RhWfpncr7tNRPIfQPuWzNXy1kNqHzKAxTsDssI9wCPel6mrgnuAZv6iaBqpU0rfgZABAEQYU9rfcKtL9Bv+PYeJaMyUiynamiXF+0f54/4/+jlmsH0qGlQYm9dOEsn/XwblaRTzvy7YEXYcViEjI84dNLXWpCTOAAMfxfdJEs2lz6j4Ydb6o0oY/UHjwuvaNaGIaPeu7kTn4Rm1Gs3XaqpYeFobjYYcnyTjKI4S0qoz5UM79ptg+iXkZCLi3ifatR/L+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqERXf1Q1j2kJDNUMH3jkW/3x74Ptb8wh95G8YKmCZg=;
 b=e/hgQfflxgY5njRBXBS5W9VJiDa/zBscW6J6orr6o1lK8SC5dZytaRZLkaFp1bdJdK8ecHW5xhKssZV4bWUGOTt93TSxo7XD3j6d8q66LH0QFI4tT3Rm/e/Co3YK8KLYxO01asW8/rPfQMob+uSvXNw35K3NZM9f9o7P74PWhy1igoIseUnMZN9RiFJze6d6MwaUBW7n6RwBZaQbaIJHPO8WWGVP5x0vqWpTGwz/4y5+qaERZ+w7SaXu7uCbsxNB/elVcvGJUpI9QmG4PW4MeIkNwpXskDs+a3+XIxsklrIel4XnWtmPzieu5/Or/tjHn/FZH8thQ+Z94lZ9ymMHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=ilbers.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqERXf1Q1j2kJDNUMH3jkW/3x74Ptb8wh95G8YKmCZg=;
 b=KCyr2+jQoAJBwyq5b43fCsG7XOGi3PYYsfpyZaa8JH7rw91MKyS/5W65GcgBsx5MqGQirGB6DcSw9GlfWrqKEXCINhQ3Sbe6W/wK1tP4Glwr4DReLGzzRx0ZOdd2txOBK4+lOsm9OpABT81bUXg8fJSpKJPuIsWxuL7zn9PH9R2UQzJWOr50Ub0izmeF2m3qAvUEfFat48Vnmkwl4F9CR3MOOfVU95sK3KOA+OuYjUGrGrwr6DTx4/1kl7ufndrsBJWwUcPIFsH23LCFbd0Mb2vxnjjevAKqt/X/WZj39PkjUl3zqU6P4mdZ6z/A4pxM4LBARpB4DNI23c7JKSn23w==
Received: from DB6PR0601CA0029.eurprd06.prod.outlook.com (2603:10a6:4:17::15)
 by DB5PR10MB7773.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 07:14:08 +0000
Received: from DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:17:cafe::12) by DB6PR0601CA0029.outlook.office365.com
 (2603:10a6:4:17::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32 via Frontend
 Transport; Mon, 5 Jun 2023 07:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT058.mail.protection.outlook.com (10.152.5.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.18 via Frontend Transport; Mon, 5 Jun 2023 07:14:07 +0000
Received: from CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.25; Mon, 5 Jun 2023 09:14:06 +0200
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 15:13:56 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.023; Mon, 5 Jun 2023 15:13:56 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Uladzimir Bely <ubely@ilbers.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Gylstorff,
 Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] IMAGE_TYPEDEP:swu: Don't depend on wic
Thread-Topic: [isar-cip-core][PATCH] IMAGE_TYPEDEP:swu: Don't depend on wic
Thread-Index: AQHZlyRce0bdz8NC+0+MRTURa4lpl697y6ow
Date: Mon, 5 Jun 2023 07:13:56 +0000
Message-ID: <0fc8aa184fe24a549be85f87a69a0edb@siemens.com>
References: <20230516085018.26436-1-ubely@ilbers.de>
 <cb62ac04-f64e-192e-7d00-e411f4422cea@siemens.com>
In-Reply-To: <cb62ac04-f64e-192e-7d00-e411f4422cea@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-06-05T07:13:53Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=49dab7f2-74f4-4e4b-847c-3fc5673b7f4d;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
x-originating-ip: [139.24.237.175]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT058:EE_|DB5PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a24967a-34cb-411f-bd14-08db659473ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h8mUjIH4PnGl6vhVWXBwQ7CLy1vU8cl3P+h7vaVXf5ffm6KL1ufYCrCZfLM/tV5ozsvqNDjpRddYHdEDzcpXTM34ttkDvtxOeuJXC+LDnEOE9KZWuj2FDxvHrxBhyzGtj8owJjD8kdkvGGOP92XE/twmupHQcjj9k3IcAeGRwoeQvxx+eHrvKPEYoYYPnoxkVoZjO+nVSIvXpew15NFb3cbyOzerZg6B2VpSrqav1WDfC+pWR5KaXZUqRdoVt5QGbs1mPaOqvQLK0HoarzerhbPxMEWW/9/ZisFkVGlrhIgB0ho0njBb3NgNGBi1UOPikiTP0wZgSGLFZoG1pEya+0Ux6ue29Y25rEyGO8n0kIofgaeVqWKJkri45Nux+zD9qsichuMVFw4AkAsw0b+I20IJBBO43WLkOYvEqBZ9t9Vwx4C8pYzTFX2yQbZdX8pFdtlHjptceRMVDvHdmorec8GGubsN5XY+pgj27uBC48dH9IXzZrAE3pX0beDaxVby8ggQcGolR6zLeHnu2EsL+0I6JoqhwLmrk+vV3u+9ZBZJ0bgfLXAxgMihMuGixS1Kb8CDZG+4dR2OEVQs9jOarKQvROwpxHF9rzZhk0+xQLCAu5s0vzQf3v+TSoMg+FD/T9uTIvOeL9nqABgk1e6c9JEbTXmdN6/nBewQZA+V9o+di8mSZ1vxp0v/TlTbFXbLEeCekXeSdetQmmWlje0+we/9CqhKKSUY4LMOG1ROMZWCq+G63E5dw/CsHggji7LSVFbOyIpNXyVucoflxbdVSw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(956004)(2616005)(41300700001)(24736004)(108616005)(336012)(47076005)(36860700001)(186003)(26005)(83380400001)(82310400005)(40460700003)(478600001)(40480700001)(110136005)(6636002)(81166007)(82740400003)(82960400001)(356005)(70586007)(70206006)(316002)(8936002)(8676002)(5660300002)(2906002)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 07:14:07.7088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a24967a-34cb-411f-bd14-08db659473ef
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7773
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:41:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11807

Pk9uIDE2LjA1LjIzIDEwOjUwLCBVbGFkemltaXIgQmVseSB3cm90ZToNCj4+IFNldHRpbmdzIElN
QUdFX0ZTVFlQRSB0byBzb21ldGhpbmcgbGlrZSAiZXh0NCBzd3UiIG9yICJ3aWMueHogc3d1Ig0K
Pj4gY2F1c2VzIHVuY29tcHJlc3NlZCAnLndpYycgaW1hZ2UgbGVmdCBub24tcmVtb3ZlZCBhZnRl
ciB0aGUgYnVpbGQgDQo+PiBmaW5pc2hlZC4gVGhpcyBpcyBjYXVzZWQgYnkgaW5kaXJlY3QgZGVw
ZW5kZW5jeSBvbiAid2ljIiBpbiBzd3VwZGF0ZSANCj4+IGJiY2xhc3MgdGhhdCBjYW4ndCBiZSBv
dmVycmlkZW4gYnkgdGhlIHVzZXIgaW4gbG9jYWwuY29uZi4NCj4+IA0KPj4gVGhpcyBwYXRjaCBy
ZW1vdmVzIHRoaXMgZGVwZW5jZW5jeS4gSWYgdGhlIHVzZXIgd2FudCB0byB1c2Ugc29tZSB3aWMg
DQo+PiBwYXJ0aXRpb25zIHRvIGJlIHBhY2tlZCBpbnRvIC5zd3UgYnVuZGxlLCB0aGV5IGNvdWxk
IHNpbXBseSBhZGQgDQo+PiBkaXJlY3RseSBhZGQgIndpYyIgb3IgIndpYy54eiIgdG8gSU1BR0Vf
RlNUWVBFLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBVbGFkemltaXIgQmVseSA8dWJlbHlAaWxi
ZXJzLmRlPg0KPj4gLS0tDQo+PiAgY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzIHwgMiArLQ0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBk
aWZmIC0tZ2l0IGEvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzIGIvY2xhc3Nlcy9zd3VwZGF0ZS5i
YmNsYXNzIGluZGV4IA0KPj4gOWE0ZDUwOS4uNmYwMzRjMSAxMDA2NDQNCj4+IC0tLSBhL2NsYXNz
ZXMvc3d1cGRhdGUuYmJjbGFzcw0KPj4gKysrIGIvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+
PiBAQCAtMzEsNyArMzEsNyBAQCBTV1VfU0lHTkFUVVJFX1RZUEUgPz0gInJzYSINCj4+ICANCj4+
ICBTV1VfQlVJTERDSFJPT1RfSU1BR0VfRklMRSA/PSAiJHtQUF9ERVBMT1l9LyR7QG9zLnBhdGgu
YmFzZW5hbWUoZC5nZXRWYXIoJ1NXVV9JTUFHRV9GSUxFJykpfSINCj4+ICANCj4+IC1JTUFHRV9U
WVBFREVQOnN3dSA9ICJ3aWMgJHtTV1VfUk9PVEZTX1RZUEV9JHtAZ2V0X3N3dV9jb21wcmVzc2lv
bl90eXBlKGQpfSINCj4+ICtJTUFHRV9UWVBFREVQOnN3dSA9ICIke1NXVV9ST09URlNfVFlQRX0k
e0BnZXRfc3d1X2NvbXByZXNzaW9uX3R5cGUoZCl9Ig0KPj4gIElNQUdFUl9JTlNUQUxMOnN3dSAr
PSAiY3BpbyAke0Anb3BlbnNzbCcgaWYgYmIudXRpbHMudG9fYm9vbGVhbihkLmdldFZhcignU1dV
X1NJR05FRCcpKSBlbHNlICcnfSINCj4+ICANCj4+ICBJTUFHRV9TUkNfVVJJOnN3dSA9ICJmaWxl
Oi8vJHtTV1VfREVTQ1JJUFRJT05fRklMRX0udG1wbCINCj4NCj5Pb3BzLCB0aGlzIGFsbW9zdCBm
ZWxsIHRocm91Z2ggdGhlIGNyYWNrcy4NCj4NCj4gSSdtIGluZGVlZCBub3Qgc2VlaW5nIGFueXRo
aW5nIGluIHRoaXMgY2xhc3MgcmVmZXJlbmNpbmcgd2ljLCBzbyB0aGlzIHJlbW92YWwgc2VlbXMg
bG9naWNhbCB0byBtZS4gSSdtIGp1c3QgY29uY2VybmVkIGlmIHdlIGhhdmUgZG93bnN0cmVhbSB1
c2VycyByZWx5aW5nIG9uID5pdCBhbmQgdGhlbiBzZWVpbmcgYSBoYXJkIHRvIHVuZGVyc3RhbmQg
ZXJyb3IuIEFueSB0aG91Z2h0cz8NCg0KRG93bnN0cmVhbSBsYXllcnMgbmVlZCB0byBhZGFwdCB0
byB0aGUgbmV3IGludGVyZmFjZSBhbnl3YXlzIChpZiB0aGV5IGRvbid0IHVzZSB0aGUgcGxhaW4g
dmVyc2lvbiBwcm92aWRlZCBieSBDSVApLg0KVGhlIC53aWMgaXMgbm90IG5lZWRlZCBhbmQgc2hv
dWxkIGJlIHJlbW92ZWQuDQoNCkFja2VkIQ0KDQpGZWxpeA0KDQo+IEphbg0K

