Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A6C636D7
	for <webhook@archiver.kernel.org>; Sat, 18 Feb 2023 08:05:20 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.73])
 by mx.groups.io with SMTP id smtpd.web11.8328.1676707513092860551
 for <cip-dev@lists.cip-project.org>;
 Sat, 18 Feb 2023 00:05:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=j/6c3sD+;
 spf=pass (domain: siemens.com, ip: 40.107.8.73, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSOLaDXZF0Mvae2p1/zpcFahEyE2Q6PYmO6XENTvBxmLzw2XXTdUTrAxftGq4Bucl2CHlsdaHp5cYxi8ZYHUPnuJOnZMOcGAvZ+AoM/ZsyJ8owKmgrqxDH7h6HR3Xr9AFKvBEs27BSfAhyxHcoU2qbj5Wo5VwaXTeMoGwk+ljw0UTNoIC6mZ6qTwOXd3I8vEijmgC8UxWFobCGJf2qtC2bRc+tbFuiUoYKBJ8pyUz5pl6i1Cz1a5EvU9pkIhbn6Ho2xHQPx+DOZQRQzjC9UgY9uP/CdeZe7fYw1w8C3z+V1r5r3je7Jfp9/RzDoIVLdpu8FbFHpE9tuynLJALm1vSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDQu/0luId8qlX6gqFEwSLRRoFITh8FpfK0KLFKqOY0=;
 b=YdDKgmrZLLHCa16vs/cxTXiAHS0SAHVTs3PqqnwSkCqFTjxcvA4INF8kZS4+4oMLBmwmZ9UE436BmMIc+FQ7emjwmXDOW5MoXaM9VlT+YsE0jJZdvWvEEq4g+P+I08w1QbnTE6YgioVNHK0PEs6VaaRMmr0PMgI4Apm7VIc+XCc10/EpyXm8me4MLaDavDEKKdSRkBLrtgiZqzcsuCAMWYIN5qpkDva8Yr3Pfu9ZAn2wd7fPYVRDcXS2PWZnrGflHH7NyYU7j2sfZKmy7QeXn1R3lyiiiRy6zNUr1w6nZyN+SSt9KZTK9uhlxzcZassJH/8QUvGc1oW73xJPKG7lJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDQu/0luId8qlX6gqFEwSLRRoFITh8FpfK0KLFKqOY0=;
 b=j/6c3sD+SiEGHzZCQX/qKHzeZo7Si+3D4Q+GjSkF1gpOsuGyFTLF0vmNyFgHbu2uepWDBaRZIDJajXRH1F/O86q78mKwUOHggqvkOIHWFdyQgZJEsFMblxulGdpXupN8y7ZV7Jfok/D0Eygp9CzRNOzt7djB3c3vHv63fVEZz3WQlCfHPsqfVZ4MI5Y9L6g4FZZBEgByhTOfdonlZuJz89tKxS1jpCYyAUhKcTmdJgXkybJVixC4w390QuitMQYzGftKmW6E5duc7sxWAGiI8+4ZaJdAo5lC9G2PAHxMWfEx4Abq4Nzcav9FM5uVUhJNloVPXxfZlt5AZpebGqNu4g==
Received: from DU2PR04CA0075.eurprd04.prod.outlook.com (2603:10a6:10:232::20)
 by AS8PR10MB7523.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.14; Sat, 18 Feb
 2023 08:05:09 +0000
Received: from DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::e4) by DU2PR04CA0075.outlook.office365.com
 (2603:10a6:10:232::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Sat, 18 Feb 2023 08:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT052.mail.protection.outlook.com (10.152.5.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.18 via Frontend Transport; Sat, 18 Feb 2023 08:05:09 +0000
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.21; Sat, 18 Feb 2023 09:05:07 +0100
Received: from CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) by
 CNPEK01M01MSX.ad011.siemens.net (139.24.237.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 18 Feb 2023 16:04:58 +0800
Received: from CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) by
 CNPEK01M01MSX.ad011.siemens.net ([139.24.237.214]) with mapi id
 15.01.2507.017; Sat, 18 Feb 2023 16:04:58 +0800
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Storm,
 Christian" <christian.storm@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][RFC v2 2/7] use bullseye backports for
 systemd-cryptenroll
Thread-Topic: [cip-dev][isar-cip-core][RFC v2 2/7] use bullseye backports for
 systemd-cryptenroll
Thread-Index: AQHZQtCp79rHWUA1eES99XMpw/jgQ67T06AA
Date: Sat, 18 Feb 2023 08:04:58 +0000
Message-ID: <1e1407ceed36b937bfe2749647443b1c0642a844.camel@siemens.com>
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
	 <20230217130540.509910-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230217130540.509910-3-Quirin.Gylstorff@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
x-originating-ip: [139.24.236.126]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-as-result: No-10--18.315800-8.000000
x-tmase-matchedrid: ObgwaKFsELBwWrhivu9rXtplUyIIewbxuV9eQHCYbHq2DJSILb1B3ltX
	gpRlmDco5NZMkA6RI/BNTSdjDfpz5Hsqldy8Qo/8EnBx19Ky1wStK/5xK9tOnq0gCFoXW3rvP6T
	ki+9nU39XiLrvhpKLfPjte/rXsdtHzuwxCLJTs5ClugrXm5IKcEsuK6d1t+nS+ACG5oWJ7tK6hg
	VvSdGKoxJsfwlIUVdBZLYsv2vt/uIxfmc+cH1ukGfZVLHC85THeJcau6RQVFFO8qlnOXFSzzB4t
	WHctlhIPFkUXf114YfxKgjDZODy6uqWNmgKqoG7c9WRurKP6CyQChJgCUVPz+eHqsHi1mi++Kgi
	yLtJrSA1Y73PdzvXZHh6u6bomTIV7q10LC+cTaU/pdBnuqFPc+VHGbcDbAq6gxsfzkNRlfJoFT3
	KzpHqE6HkM5YY92pZjaPj0W1qn0Q7AFczfjr/7L+fffwOmCE+d66l2D4rQT9x5H/yvP0oUA1wTv
	X+zMCK/YId6k4T5I0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--18.315800-8.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1018-26498.001
x-tm-snts-smtp: 13D83E18CFDE16986B9E4740693E5EA401BF0FA37AFCAD00795909CCA48B4C4A2000:8
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D57B6F21AF672438887E9F0E0A6DE0F@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT052:EE_|AS8PR10MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c592876-c21b-4506-aa7f-08db1186da88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/nsx01xuQuzA7/2Rd/zTa3VeKxN6lg3yCeeidbvaRp1IWusezXQ5Hn7zq54vhBATwMOgheSEbjSLPtxf8NeqSeP0Co2qvwWo44L6oY6/Mrv9JvvIizneQ7nMH2KdQPmqV8WA2syseLW/QYR6RGNA7sjJMq3Y/F1lRwGPgmjXTjgOBPesxykncYrQaqI9ufKOCqV9wbNXcUvomnoNdxD1F/6q6tUq+yddv1jBFT5PEV//uBtJpOW30pJOvsuyeag0oFYgqq21KPgKM5hTm+xW1Wo2Mi68YOpULNhJdhKHTCOBtA1bkOkRgxQLZ8r/aNPo+hDitrnZRMHibCby8J9dcZEAcvCTa4TJ8zYGOfn/753657MCwnFmBFBB2kFodLr6fqu16gBgD82fPZezuGFSjFJOVWmZZUH14TafuE3mIxSNtIizWflumMvlqVOp9JF8NYXJPV2vO24gCo8DgX0qCsp7eBrbvtfFZ2b5/hvqMZBJ2bdXsM7SKavEUtS3EUQDYu9duIgCfud/TpuQHipucTMcpKZt2v6UTvQEdUzlK+XxR7MCpCNwFrxoKe9KALRpfBE+OdzVXXXhpqhQKxmk5O5AZKx1JPy2uRBB+/Ii2Hu4E7VhU1NiBnRH+c3ohwC7gMl1nhAJpxQzqnqJ0kAcu5c+tP0VWBI7SfhHw1t3bSfJstgtssNlnmuZPAWPqTsHZts7IaJ652qilpFz2WyVA+MhGPBDlXZT5jEJ929CI04=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(966005)(82310400005)(40480700001)(36860700001)(82960400001)(86362001)(82740400003)(47076005)(7596003)(356005)(2616005)(7636003)(40460700003)(336012)(83380400001)(186003)(26005)(36756003)(956004)(110136005)(6636002)(5660300002)(41300700001)(478600001)(66899018)(8936002)(316002)(2906002)(70206006)(70586007)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 08:05:09.1955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c592876-c21b-4506-aa7f-08db1186da88
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7523
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 18 Feb 2023 08:05:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10739

T24gRnJpLCAyMDIzLTAyLTE3IGF0IDE0OjA1ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHZpYSBs
aXN0cy5jaXAtDQpwcm9qZWN0Lm9yZyB3cm90ZToNCj4gRnJvbTogUXVpcmluIEd5bHN0b3JmZiA8
cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gDQo+IFN5c3RlbWQgPj0gMjUxIGlzIHJl
cXVpcmVkIGZvciBzeXN0ZW1kLWNyeXB0ZW5yb2xsLiBUaGlzIHZlcnNpb24NCj4gaXMgcGFydCBv
ZiBiYWNrcG9ydHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBRdWlyaW4gR3lsc3RvcmZmIDxxdWly
aW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqBjb25mL2Rpc3Ryby9kZWJpYW4t
YnVsbHNleWUtYmFja3BvcnRzLmxpc3TCoMKgwqAgfMKgIDEgKw0KPiDCoC4uLi9wcmVmZXJlbmNl
cy5idWxsc2V5ZS1iYWNrcG9ydHMudHBtLmNvbmbCoMKgIHzCoCAzICsrKw0KPiDCoGthcy9vcHQv
dHBtLnltbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDIwDQo+ICsrKysrKysrKysrKysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZi9kaXN0cm8v
ZGViaWFuLWJ1bGxzZXllLWJhY2twb3J0cy5saXN0DQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGNv
bmYvZGlzdHJvL3ByZWZlcmVuY2VzLmJ1bGxzZXllLQ0KPiBiYWNrcG9ydHMudHBtLmNvbmYNCj4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQga2FzL29wdC90cG0ueW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
Y29uZi9kaXN0cm8vZGViaWFuLWJ1bGxzZXllLWJhY2twb3J0cy5saXN0DQo+IGIvY29uZi9kaXN0
cm8vZGViaWFuLWJ1bGxzZXllLWJhY2twb3J0cy5saXN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAuLjNhNTVlNGMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9jb25m
L2Rpc3Ryby9kZWJpYW4tYnVsbHNleWUtYmFja3BvcnRzLmxpc3QNCj4gQEAgLTAsMCArMSBAQA0K
PiArZGViIGh0dHA6Ly9mdHAudXMuZGViaWFuLm9yZy9kZWJpYW7CoGJ1bGxzZXllLWJhY2twb3J0
cyBtYWluIGNvbnRyaWINCj4gbm9uLWZyZWUNCj4gZGlmZiAtLWdpdCBhL2NvbmYvZGlzdHJvL3By
ZWZlcmVuY2VzLmJ1bGxzZXllLWJhY2twb3J0cy50cG0uY29uZg0KPiBiL2NvbmYvZGlzdHJvL3By
ZWZlcmVuY2VzLmJ1bGxzZXllLWJhY2twb3J0cy50cG0uY29uZg0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwLi4wOTA1ZmJmDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
Y29uZi9kaXN0cm8vcHJlZmVyZW5jZXMuYnVsbHNleWUtYmFja3BvcnRzLnRwbS5jb25mDQo+IEBA
IC0wLDAgKzEsMyBAQA0KPiArUGFja2FnZTogKg0KPiArUGluOiByZWxlYXNlIG49YnVsbHNleWUt
YmFja3BvcnRzDQo+ICtQaW4tUHJpb3JpdHk6IDgwMQ0KDQpUaGlzIGRvZXMgbm90IGxvb2sgcmln
aHQuIEJ5IHRoYXQsIHdlIHRha2UgQU5ZIGF2YWlsYWJsZSBwYWNrYWdlIGZyb20NCmJwby4gRm9y
IHN5c3RlbWQgYmFja3BvcnRzLCB3ZSB1c3VhbGx5IHVzZToNCg0KUGFja2FnZTogbGlibnNzLW15
aG9zdG5hbWUgbGlibnNzLW15bWFjaGluZXMgbGlibnNzLXJlc29sdmUgbGlibnNzLQ0Kc3lzdGVt
ZCBsaWJwYW0tc3lzdGVtZCBsaWJ1ZGV2MSBsaWJzeXN0ZW1kMCBzeXN0ZW1kIHN5c3RlbWQtKiB1
ZGV2DQoNCkZlbGl4DQoNCj4gZGlmZiAtLWdpdCBhL2thcy9vcHQvdHBtLnltbCBiL2thcy9vcHQv
dHBtLnltbA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi4wZTRkYzk1
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIva2FzL29wdC90cG0ueW1sDQo+IEBAIC0wLDAgKzEs
MjAgQEANCj4gKyMNCj4gKyMgQ0lQIENvcmUsIGdlbmVyaWMgcHJvZmlsZQ0KPiArIw0KPiArIyBD
b3B5cmlnaHQgKGMpIFNpZW1lbnMgQUcsIDIwMjINCj4gKyMNCj4gKyMgQXV0aG9yczoNCj4gKyPC
oCBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0KPiArIw0K
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ICsjDQo+ICsNCj4gK2hlYWRlcjoN
Cj4gK8KgIHZlcnNpb246IDEyDQo+ICsNCj4gK2xvY2FsX2NvbmZfaGVhZGVyOg0KPiArwqAgc3lz
dGVtZC1jcnlwdGVucm9sbDogfA0KPiArwqDCoMKgIERJU1RST19BUFRfU09VUkNFUzphcHBlbmQ6
YnVsbHNleWUgPSAiIGNvbmYvZGlzdHJvL2RlYmlhbi0NCj4gYnVsbHNleWUtYmFja3BvcnRzLmxp
c3QiDQo+ICvCoMKgwqAgRElTVFJPX0FQVF9QUkVGRVJFTkNFUzphcHBlbmQ6YnVsbHNleWUgPSAi
DQo+IGNvbmYvZGlzdHJvL3ByZWZlcmVuY2VzLmJ1bGxzZXllLWJhY2twb3J0cy50cG0uY29uZiIN
Cj4gK8KgIGltYWdlLW9wdGlvbi10cG06IHwNCj4gK8KgwqDCoCBJTklUUkFNRlNfSU5TVEFMTCAr
PSAiIGluaXRyYW1mcy1jcnlwdC1ob29rIg0KPiANCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0N
Cj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+
IFZpZXcvUmVwbHkgT25saW5lICgjMTA3MTUpOiANCj4gaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVj
dC5vcmcvZy9jaXAtZGV2L21lc3NhZ2UvMTA3MTUNCj4gTXV0ZSBUaGlzIFRvcGljOiBodHRwczov
L2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9tdC85NzAyNzMxMC82ODc5Njk2DQo+IEdyb3VwIE93bmVy
OiBjaXAtZGV2K293bmVyQGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBVbnN1YnNjcmliZTogDQo+
IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL2cvY2lwLWRldi9sZWF2ZS8xMjA1NDIyNS82
ODc5Njk2LzYzMjM1MDQ3OS94eXp6eQ0KPiDCoFtmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29t
XQ0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiANCg0K

