Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E8C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 19:03:50 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.86])
 by mx.groups.io with SMTP id smtpd.web11.83217.1701954805782141075
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:13:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=htMCwXPv;
 spf=pass (domain: siemens.com, ip: 40.107.105.86, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ene5a9KogumoVBNeOm60gWYEezYq9vG8KgKkRKjU8Z5gtjYX/rQ4JjYcdcX8IsqIA8GMLl4XyhNZNEamNs1NsYEM3ithZJFdKkGxYxLsq/7r0+ZwEfbIfY1BDrtuq59GPX9Nx6nyeZ/vQ7EL/1t4fzaqiZCgTCBxVdSJIJGR2ZSJP09mwqeqSrVXcFyzYdj3nz8DRkwk4rJwHvoqXsA1W01BkZBnD4EGeLMZdg7/PbZULfqdoaESOn9T1kqzxPfv20xKdbMF7GNJ6vpM2OsbJ5EPuPMv4hZqCMVHTWZAnd4ib74b81Ucc7q73WT6SiJzdzKxlw9rZqpIwBdW2Kn9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYmLWO3/ymGsfVnBcOrO3uOT4pSOfXdtYnNCvFiJXwc=;
 b=GVAtlavQPDeZbkloBvPh3HnOKZWL2Yj1njRQuNlGcPeFPe4LNGIQw5xDJhzYvKkla78l5dl/u3SYJGfGOwUUHmdjHhAR+FxnDrZbcnlkTgQCbN5M+hCsmfJI+3SNak8zRZWOY61ezeGgKvnzOpGFHFrggwqrgmja3Yfp35eRGPxdDFwHkw7yYLq/3JLs4DuVKD5sDjQjwwzcP6wI9ME/z8ULcgFigg/EwrOB6gJczu6psm6cUvH+lBVungnG+SsVUnmTxW52rggYt5oW9/v4fkvERXWLk7phlBA0Y2OosUeIdXDgzohXKqmhnxy3+tQ2auBqPMKNjGuxdFsLWoxg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYmLWO3/ymGsfVnBcOrO3uOT4pSOfXdtYnNCvFiJXwc=;
 b=htMCwXPvb3ncCtBVpCuFo8fNCs/ViybrP8S5J+Or5e4hWqKW/5hmZugfWC7Jg97PGmtmF6PcxRhr+2z71ibqvFHxtlsqPXShHlllbygG5cjGLFiadTi7a9vk0BVe2VKhkEP4QuvZz1WOAtGngPWOX1mxXi0Qwc1ihGcs9LA9cREWYnsaK1sx7pWmEV2MhKUsLqSsieKjtCUY8NY4gY/uBeItjOp7JjNv7lE5M0HldNg8apVSd/Htol1QJv07JeTHXdH63AkZuWQM2gxYU3mWaM5cEMDdMZcp6DOCRkSl476LIMrrnvGI3zANNgyZisv5kg+2aGLLUMwO0zLddUKxlA==
Received: from DB8PR06CA0006.eurprd06.prod.outlook.com (2603:10a6:10:100::19)
 by DU0PR10MB6180.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 13:13:22 +0000
Received: from DB5EUR01FT079.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:100:cafe::59) by DB8PR06CA0006.outlook.office365.com
 (2603:10a6:10:100::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 13:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT079.mail.protection.outlook.com (10.152.5.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.24 via Frontend Transport; Thu, 7 Dec 2023 13:13:21 +0000
Received: from CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Dec 2023 14:13:21 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 21:13:18 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.035; Thu, 7 Dec 2023 21:13:18 +0800
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC 2/2] swupdate.bbclass: Add boot<ARCH>.efi to swu
Thread-Topic: [cip-dev][isar-cip-core][RFC 2/2] swupdate.bbclass: Add
 boot<ARCH>.efi to swu
Thread-Index: AQHaKFF31aq2TRIoFUCZTCDg+LwYC7CdR4mA
Date: Thu, 7 Dec 2023 13:13:18 +0000
Message-ID: <d09540837c8c895677ebd6ea9c28211dfb63f91f.camel@siemens.com>
References: <20231206143528.1900797-1-Quirin.Gylstorff@siemens.com>
	 <20231206143528.1900797-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231206143528.1900797-3-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-originating-ip: [139.24.247.30]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT079:EE_|DU0PR10MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 23734a95-d775-4430-80ac-08dbf72649b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZxZYr36VbnPwCF/ZVCiO/E+/X+qavgHY3Z/VXyTsRf9w2HshaZLk2nhikgBHf+IuSM5tk4cTSm4hb7pbqzF69FhAOUlox7kqpwjsRPmOm2oBjQJMdnF6UdJzov31T1qo9fguEJw5uD2OV5AZTIFfSecj6Bz0tAFERKsVGGYqajtygaMOUvEcSS3uVv0NfaLuxRd8Gg9Xo6iadHMET++F1UwVyZdjZrdAekdQzw1d3FM3edW6wLOiVjViRYQqMgVJNXBMf9/2/MYXnNUdM5/mGQ8xA/8PCyYGPGH41i0b/7eAmJKQHi7ixphJLDR7GIFH8M/y6tg4cK6IWN8qUmxOqB1DBAHCtuPxByGwlLTFojBQQdqO7wdBW3Zk8TK3AQsRA6iRBKa1HXgnA2NIUK62h3D1YGZPsiFDTqJc+PA2vjM0MuZu3uZrJ1LRJBZWiRAoKmKYbV7EGKTs0rml7f78dhj7VkjLggtj16pIGrahlgop8A9Rj0xUYh7K/gCa0Xvs4Bo9pCEa7NtJY3g/F4SS8v4l8iG/DDPIYqwqfRVNjnGJFKmMR6dkX8WLcwCBpnuYvjDsgay2jTN1G91SDXjFYTtEGVR+ZSW9/zzn4tzMtx2nmEUhELPwc7Ogsgwid+MxNOCtUvngihByDL/GVmEyOLQB3am+MRI5JBmX+o6FHpKgl2+yuYiFe39AYwxfz9ddwB85G8MsU0N53IlXA1HcjOt6Js4x1ZE5+ZY0bWY5g2FlYv8Fp0/h09z2wasFWfJANlMwBjQmBB/bYUf5TGzKO4ekQ4oeoePdncrTcppGPB/6w3tgljibyUVoHwIySCBPIlj+Y5fejA5Vq2Hh9GcxcKBnfEvYEPKSqZsg5WMn8NQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(6636002)(66899024)(36756003)(41300700001)(40460700003)(5660300002)(2906002)(82740400003)(83380400001)(82960400001)(110136005)(70586007)(47076005)(70206006)(478600001)(2616005)(26005)(40480700001)(956004)(8936002)(8676002)(86362001)(81166007)(316002)(36860700001)(356005)(336012)(403724002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 13:13:21.9528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23734a95-d775-4430-80ac-08dbf72649b2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT079.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6180
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <825898CBC43F8B4982AAF10563871743@siemens.com>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 19:03:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13902

T24gV2VkLCAyMDIzLTEyLTA2IGF0IDE1OjMzICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBhbGxvd3MgdG8gdXBkYXRlIHRoZSBib290bG9hZGVyIHdpdGggc3d1cGRh
dGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3Rv
cmZmQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqBjbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3PCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE4ICsrKysrKysrKysrKysrKy0t
LQ0KPiDCoHJlY2lwZXMtY29yZS9pbWFnZXMvc3d1L3N3LWRlc2NyaXB0aW9uLnRtcGwgfMKgIDcg
KysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9jbGFzc2VzL3N3dXBkYXRlLmJiY2xhc3MgYi9jbGFz
c2VzL3N3dXBkYXRlLmJiY2xhc3MNCj4gaW5kZXggMTE3ZjlmZS4uNGM0OTZjMiAxMDA2NDQNCj4g
LS0tIGEvY2xhc3Nlcy9zd3VwZGF0ZS5iYmNsYXNzDQo+ICsrKyBiL2NsYXNzZXMvc3d1cGRhdGUu
YmJjbGFzcw0KPiBAQCAtMTcsMTQgKzE3LDE1IEBAIFNXVV9ST09URlNfTkFNRSA/PSAiJHtJTUFH
RV9GVUxMTkFNRX0iDQo+IMKgIyBjb21wcmVzc2lvbiB0eXBlIGFzIGRlZmluZWQgYnkgc3d1cGRh
dGUgKHpsaWIgb3IgenN0ZCkuIFNldCB0bw0KPiBlbXB0eSBzdHJpbmcgdG8gZGlzYWJsZSBjb21w
cmVzc2lvbg0KPiDCoFNXVV9DT01QUkVTU0lPTl9UWVBFID89ICJ6bGliIg0KPiDCoFNXVV9ST09U
RlNfUEFSVElUSU9OX05BTUUgPz0NCj4gIiR7U1dVX1JPT1RGU19OQU1FfS4ke1NXVV9ST09URlNf
VFlQRX0ke0BnZXRfc3d1X2NvbXByZXNzaW9uX3R5cGUoZCl9DQo+ICINCj4gLVNXVV9WRVJTSU9O
ID89ICIwLjIiDQo+ICtTV1VfVkVSU0lPTiA/PSAiMC4zIg0KPiDCoFNXVV9OQU1FID89ICJjaXAg
c29mdHdhcmUgdXBkYXRlIg0KPiDCoCMgc3BhY2Ugc2VwYXJhdGVkIGxpc3Qgb2Ygc3VwcG9ydGVk
IGh3LiBMZWF2ZSBlbXB0eSB0byBsZWF2ZSBvdXQNCj4gwqBTV1VfSFdfQ09NUEFUID89ICIiDQo+
IMKgDQo+ICsNCj4gwqBTV1VfSU1BR0VfRklMRSA/PSAiJHtERVBMT1lfRElSX0lNQUdFfS8ke0lN
QUdFX0ZVTExOQU1FfS5zd3UiDQo+IMKgU1dVX0RFU0NSSVBUSU9OX0ZJTEUgPz0gInN3LWRlc2Ny
aXB0aW9uIg0KPiAtU1dVX0FERElUSU9OQUxfRklMRVMgPz0gImxpbnV4LmVmaSAke1NXVV9ST09U
RlNfUEFSVElUSU9OX05BTUV9Ig0KPiArU1dVX0FERElUSU9OQUxfRklMRVMgPz0gImxpbnV4LmVm
aSAke1NXVV9ST09URlNfUEFSVElUSU9OX05BTUV9DQo+IGJvb3Qke1NXVV9FRklfQVJDSH0uZWZp
Ig0KPiDCoFNXVV9TSUdORUQgPz89ICIiDQo+IMKgU1dVX1NJR05BVFVSRV9FWFQgPz0gInNpZyIN
Cj4gwqBTV1VfU0lHTkFUVVJFX1RZUEUgPz0gImNtcyINCj4gQEAgLTQ3LDcgKzQ4LDggQEAgSU1B
R0VfVEVNUExBVEVfVkFSUzpzd3UgPSAiIFwNCj4gwqDCoMKgwqAgU1dVX0hXX0NPTVBBVF9OT0RF
IFwNCj4gwqDCoMKgwqAgU1dVX0NPTVBSRVNTSU9OX05PREUgXA0KPiDCoMKgwqDCoCBTV1VfVkVS
U0lPTiBcDQo+IC3CoMKgwqAgU1dVX05BTUUiDQo+ICvCoMKgwqAgU1dVX05BTUUgXA0KPiArwqDC
oMKgIFNXVV9FRklfQVJDSCINCj4gwqANCj4gwqAjIFRBUkdFVF9JTUFHRV9VVUlEIG5lZWRzIHRv
IGJlIGdlbmVyYXRlZCBiZWZvcmUgY29tcGxldGluZyB0aGUNCj4gdGVtcGxhdGUNCj4gwqBhZGR0
YXNrIGRvX3RyYW5zZm9ybV90ZW1wbGF0ZSBhZnRlciBkb19nZW5lcmF0ZV9pbWFnZV91dWlkDQo+
IEBAIC02OCw2ICs3MCwxNiBAQCBweXRob24oKXsNCj4gwqDCoMKgwqDCoMKgwqDCoCBkLnNldFZh
cignU1dVX0NPTVBSRVNTSU9OX05PREUnLCAnY29tcHJlc3NlZCA9ICInICsgY2FsZ28gKw0KPiAn
IjsnKQ0KPiDCoMKgwqDCoCBlbHNlOg0KPiDCoMKgwqDCoMKgwqDCoMKgIGQuc2V0VmFyKCdTV1Vf
Q09NUFJFU1NJT05fTk9ERScsICcnKQ0KPiArwqDCoMKgICMgY3JlYXRlIFNXVV9FRklfQVJDSCBm
cm9tIERJU1RST19BUkNIDQo+ICvCoMKgwqAgZGlzdHJvX2FyY2ggPSBkLmdldFZhcignRElTVFJP
X0FSQ0gnKQ0KPiArwqDCoMKgIGRpc3Ryb190b19lZmlfYXJjaCA9IHsNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgImFtZDY0IjogIng2NCIsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJh
cm02NCI6ICJhYTY0IiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImFybWhmIjogImFybSIs
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJpMzg2IjogImlhMzIiLA0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAicmlzY3Y2NCI6ICJyaXNjdjY0Ig0KPiArwqDCoMKgIH0NCj4gK8KgwqDC
oCBkLnNldFZhcignU1dVX0VGSV9BUkNIJyxkaXN0cm9fdG9fZWZpX2FyY2hbZGlzdHJvX2FyY2hd
KQ0KPiDCoH0NCj4gwqANCj4gwqANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS9pbWFnZXMv
c3d1L3N3LWRlc2NyaXB0aW9uLnRtcGwgYi9yZWNpcGVzLQ0KPiBjb3JlL2ltYWdlcy9zd3Uvc3ct
ZGVzY3JpcHRpb24udG1wbA0KPiBpbmRleCA2YjUzYTNjLi5lYWYzMGVhIDEwMDY0NA0KPiAtLS0g
YS9yZWNpcGVzLWNvcmUvaW1hZ2VzL3N3dS9zdy1kZXNjcmlwdGlvbi50bXBsDQo+ICsrKyBiL3Jl
Y2lwZXMtY29yZS9pbWFnZXMvc3d1L3N3LWRlc2NyaXB0aW9uLnRtcGwNCj4gQEAgLTM0LDUgKzM0
LDEyIEBAIHNvZnR3YXJlID0NCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN1YnR5cGUgPSAia2VybmVsIjsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH07DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzaGEyNTYgPSAibGludXguZWZpLXNo
YTI1NiI7DQo+ICvCoMKgwqAgfSwNCj4gK8KgwqDCoCB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGZpbGVuYW1lID0gImJvb3Qke1NXVV9FRklfQVJDSH0uZWZpIg0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwYXRoID0gIkVGSS9CT09UL2Jvb3Qke1NXVV9FRklfQVJDSH0uZWZpIjsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlID0gIi9kZXYvZGlzay9ieS11dWlkLzQzMjEt
RENCQSI7DQoNClBsZWFzZSBtYWtlIHRoaXMgY29uZmlndXJhYmxlLCBpZGVhbGx5IHRoZSB3aG9s
ZSBkZXZpY2UgcGFydC4gTm90IGFsbA0KZGVwbG95bWVudHMgdXNlIHRoYXQgZml4ZWQgSUQuDQoN
CkZlbGl4DQoNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmlsZXN5c3RlbSA9ICJ2ZmF0IjsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2hhMjU2ID0gImJvb3Qke1NXVV9FRklfQVJDSH0u
ZWZpLXNoYTI1NiI7DQo+IMKgwqDCoMKgIH0pOw0KPiDCoH0NCg0K

