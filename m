Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C913C4332F
	for <webhook@archiver.kernel.org>; Mon,  7 Nov 2022 10:43:51 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.85])
 by mx.groups.io with SMTP id smtpd.web11.1893.1667817820284363545
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Nov 2022 02:43:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KrsVgZLg;
 spf=pass (domain: siemens.com, ip: 40.107.8.85, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtOWtikXSubY7zDjfW8vH/a9fyKDpeQ5dIqDaz5Rh8tIMqDa9oNgmOrLb+Vr2q46F7GHAJHwqyyd+YxDHrKmfsxIczcCFxRVrqp16xMeH+w6oSb4Q959zY0+omBQmwkicn3h9ogMtEGv3erkltCQYWkyyr/wFwQXS8fGwwpwW10Kf2QfKQ2cGpzrPukFegzKOuR622hOiFJ43sdu83aA9lJJZS4cc1j0oqjcf4c+yFh0eDJVjygO9jDKXZDLtEusEB+nHSo0M6WP8r0tOlq3GbrMfi7wNf+HjJJpdMZTmCWhLc4Tsa7XUM0ygxbcqTXr/3Ojv6ECYxo/RVBI4nDEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4ALgWtMGaQHVuulFVSLt/Hy/4BEeMrfXGcDQysVOU8=;
 b=hrgJhAcIuygE8Owl0zQ2snYxuVgHF9cxmegJ5K8plcHnycNla749ryhWpwqBD9bt2qmjJd+jXigyIWhvabnUOoYH1y3k/8kcXcc6JFk9bC0BKccE3MJpvdyFG6unJeVr8CAYY9VX8YvWjEUuPFb37Rbm0joBtmSSwEfKdZdvOoPK1+gKG0sbcO9WMUAhrV0T+j+QN7dhDrUun4JAvbqnR+OjqTPRwpGOMDBYOAPnALwhBiisshpuBh1scXliZrzqxy6ECKvvN2H+jzNYnxUCLbH+6l8SBVmFL9f8u6HqLbVAH+tBWUytL8lHC7XTA5AspuvxGTlZR0Ost0UKJIH5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4ALgWtMGaQHVuulFVSLt/Hy/4BEeMrfXGcDQysVOU8=;
 b=KrsVgZLgfvHAfKOYDCUgeeY9SAUv1D4uniwrAzo5hAlPXX5AnbIENR5lEIqlng7PN5Q8kyReMLcWDRLKBqKMHgZ1kyN71doF86V+ivSjiTDAYW0KIX7k+msb/I34mEYG1s0g5w7Sdu5G2Bkq3uHUw8kbt5EbUJhcdSYIYVDwYcMrje30VXMeZD6vBGikGHJ5ouGqftoHn9h82J4dkqpCziF5JJDLLMxtx8lhWrVLKJycPHarNDDxQSIyfTKBNlkP6IogDKJ8UFiMOqxWQBoFeJ4JFH6i7MouJJXyShwte+rZmTnA379jxjbIW2jmu4nfKinhUh7GyQ9HfUsrK7dU0g==
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by PR3PR10MB4047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 10:43:37 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab71:2e76:51d8:57e3]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab71:2e76:51d8:57e3%8]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 10:43:37 +0000
From: "Schultschik, Sven" <sven.schultschik@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: AW: [isar-cip-core][PATCH 6/8] add kas files for building qemu secure
 boot images
Thread-Topic: [isar-cip-core][PATCH 6/8] add kas files for building qemu
 secure boot images
Thread-Index: AQHY56Qljlkux69gSEucqgZIe14tQa4igMIAgBDWIuA=
Date: Mon, 7 Nov 2022 10:43:37 +0000
Message-ID: 
 <PAXPR10MB50372DB403704E9AA00BFE07903C9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-7-sven.schultschik@siemens.com>
 <1da1e517-4604-3eb9-a43b-01705ca434a0@siemens.com>
In-Reply-To: <1da1e517-4604-3eb9-a43b-01705ca434a0@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-11-07T10:43:35Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=7957b5e1-dff8-4ece-b545-a2dc265b4040;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5037:EE_|PR3PR10MB4047:EE_
x-ms-office365-filtering-correlation-id: afab95ee-ae1b-4022-c1d6-08dac0aced22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Yqlja/TsEKdglvubhPUAAgggvT+UVda7GzvY8gkoTNaPcOkjdNbNh6x3BQo5j5Px29vHzT/vh+pavFIGh32ZQ3CmhM/Qm3BZKYKHUE3AO3+lZtrsj8n7lGnByak6Q5QTNit/zT2DCn4+kVLtpzh39/OCHfNRTeg+OgrcbPKKv96C3uWYraqc1Na/cA2EGiMVhvN9llzgiZj+BylRHxKWEuvhHaea/+VgMhxZXk3vupFNYkfY1v/xmhd3+h3p9Zfpt/lnQM/oW3OIqN34exSsq10Nk5pBrammdZjA4RqRNzkt8UF0suCBwlBXcAlIdfiLQDX7N6tbZdONYikV0HBdeVvqPPx7buWWdIkZNRCjvNOJXB4LXPXbFPN0Fwii1tSHtzNh/0v5fZs8ZPj3MxlZkiY606fsgPEycHRiBDccvSjUsbK6vQRuzlR3dZoP1wNgTvCYvSZzrLJOxcra1wymxPVNAom30b7Cvx1fA5PT7xhV2uwwbFTLOI7+tpcIifoj44fakxcbbBJOywdorK3nDEWxeCiO3ho+BLeJmMAJ9xCfrBIkOA+PsbSfMdPRWChrW9zVB8l0B1WFs4hFapEcDNM2+ST0oERaBmcOmWEdM2ie5zgb2hcsO6fc0Z4MC9bW/i2GxFmDtHk91Pr9aY5PjJ/9Rg/uSikQGavOLU8JvfHnd5aChOK8tnFqvSqpS0ARQRCPFNuJdRC0ZootYTxwlCY8ov5OZftn+jz+S/+Jp0/TKV2t4x9ucjiTDEhITi4XtwTh+D4zC9Ig81VBcdfGqg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(2906002)(478600001)(52536014)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(8936002)(4744005)(71200400001)(110136005)(55016003)(316002)(33656002)(41300700001)(38070700005)(5660300002)(122000001)(186003)(82960400001)(7696005)(38100700002)(6506007)(86362001)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YXhYa2VRdG91WFJwUTlKRmdxM295RXM2dmV6RjJNNHhocXJBaTZsay9PMGN6?=
 =?utf-8?B?VXZmQWRFNDlhcURKckVOemFqclJHaWJ0bXBZbGFaMHg1ek1SNGx1Y3IzbHBo?=
 =?utf-8?B?Qys3U3Y4RXFLWHBqR3ZSWklXQmcveW5aTm1mUGh5dVdYU0RtYUFUcGFjUTJr?=
 =?utf-8?B?RFk1cTZrR0J2MVM0THY5L3BKZUVldnluMWhLZU5tdnhtV3lBMFRCbHBOZWF0?=
 =?utf-8?B?VUtpaHgvckwzU0hHZFZNUmIwTnlTbW5TQlhsMDByQTkwZGkydk5KZ3hNQVBE?=
 =?utf-8?B?N3BmYmlUSUprdC9SU3AwU1d4NnVaL1VDbkJKU2RHd1Y5cE5SeFloSG1MZitK?=
 =?utf-8?B?cDFYTkF1TDdQa2JXTmFtUk5YOGh4Z3E1MGJadTFpOTFwcmZFNndZRFhCUGEw?=
 =?utf-8?B?RFJwMWtJVHdGeGhCaFR0NW5pK3FnbHZUdFBhQ1ZTenJaM3hvdzlOamVNd1pi?=
 =?utf-8?B?dHhxazVGbGVDbEFESFlvY2d3TjAxWHcrQTBtbmo2NmdsRXFWdWxCMU9Ld29n?=
 =?utf-8?B?aGQyVUNhRURyYlQ3ODlIenlVZmpVT3ZTdjFCMzlVUC9mc1JTVElUNlBNNEdj?=
 =?utf-8?B?a0I4WEFwMDRPeWNzVkVTQU1FOGxud1l0bkZMRWt6eXIyYk1UMTRvVW0yVUV4?=
 =?utf-8?B?Ujl5YkdVWUx4cFlzQUEvSGlKYkxMWGQ1cnFnOWgwc1dySWVsYm9nRHh4ZlNI?=
 =?utf-8?B?M1p3Q0FXQnc4cURLTklUV3EycWRrQjBCMFhJYnJXQ2RBcWNOSGRFY3dwZlVl?=
 =?utf-8?B?RTRmc1ZtRzEyZFBDZ2V6d3paQjFMRk5EQXFSZlFROWRSV2JIZXQrL2QyZHBr?=
 =?utf-8?B?ZHIyNDB3TXQzcXVCbHJwK2hqRTExNHN5N3pPTENrV0xyZkFBYkkxOEFudHpI?=
 =?utf-8?B?bSs1cHptWlBoWTcxekZTWXVhb0I2NEJGb0N5REhJZXhzZTZsM21TU0dqcE12?=
 =?utf-8?B?WUNpNkJsSDFUa3pvaFArWm1qaTVZMmcwd1luaEluSFVaQ2MyZ1FHVCtrMUpL?=
 =?utf-8?B?dStvSWVIenZtSk9JSnpudkk5OGtyanhwdDNlYWF0TGdXd09IYVU2Zk5HamtP?=
 =?utf-8?B?OEIzZVZEK3UyRnRueUs5TVdrcnZ0VXZaVmYwVHVIK3FJTVVvTXI3SlhyUUZU?=
 =?utf-8?B?ZFMwdkd4c1dBNWVEQmtwaTV2WmsyMjZBaWx4eHhMTnZsUWhDcGFld0Jhbndt?=
 =?utf-8?B?V2VrYThoWjliOCt3c0ZNSVhHS2MyM0JWUlJ1UEp2Q3hsTHNyT29IK25uUWE0?=
 =?utf-8?B?Ly81Snl0SFVuNUlTeUlqZVhzZXNVd093TlE1U3UvUGNhV2d4NHhpcXdUcjNM?=
 =?utf-8?B?VytnMEdCeWZkNXZUQjhteTFBbVg3eGxuRzNxamxsTUhwdENxc2hXWVI1emJO?=
 =?utf-8?B?OWc1NVlldU9RdnhCdkpRaEhNeUtuY2drSXVMbGZ6K0xrWTVzUm8wVVF2REM3?=
 =?utf-8?B?cVVOVWxqU3htZktIODZ3Q3pOcjBjS1YvZWpwL1V2NlE0TTBwdlNGZi9UZ3dq?=
 =?utf-8?B?VkdmNjlmdmR6dWRKSDdOTjl0V3p4Yzk3WGNabzBJWXoxMlA5RDMvL0k3UkNk?=
 =?utf-8?B?bG14QmFzQWlwYWw4SE5ZaSs1VDBpN1JlQzFLN0ZOT2YwejdDVmlFTUFQVkFB?=
 =?utf-8?B?bW5jWnJwNXdHSU5rdmkyR0QvdEVmenZBRTExM2J0UGdOZVFXdmVuZkdLOWc4?=
 =?utf-8?B?T09jWmtjTVJFbjR2ZjB6dnI1M1JSRC9GZk1SejcySzVtL2x6bWlNOGpUS0xW?=
 =?utf-8?B?UFVROGhFVkpxRm1NNCs3aURQNnM4QlRmVERlOEtHZzFQNzBZOURLemQ2SHha?=
 =?utf-8?B?TndzM3lUUmVsWk1OcmJ3eS9FMkxqQk1kUEg5SHQ2eWY0NG9wdHJrd0l6L2R0?=
 =?utf-8?B?K252OUVNdlBuZ0xDamtncjVHNlJaUXZoL0wyN2w2TlVpV3RzRXp6Z2ozN0Ny?=
 =?utf-8?B?ZHZlVVhhWFFhdlBEeFFXTXpEMTBkaWFEVFB4OGdWUXp1V1pVRzRvc1dWNHhy?=
 =?utf-8?B?Z3hyeGZVMnI2bE1aZ3ltQ0Q3UWozSU9QY0ZSYmRBcXdjUSsyZE56WktTRjhY?=
 =?utf-8?B?MEt0Q2NNZm5GcDJMK0w4UGRLc0ErWWE3RWUzd05uT3g3ZnRHSmJ2M1M2RTYw?=
 =?utf-8?B?d3dGczlWK3BPSkFEaU9PamRscmRDbm9rNU5IUHg2OUlERXpBbkFRdHdtcEVJ?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: afab95ee-ae1b-4022-c1d6-08dac0aced22
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 10:43:37.1576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBuY9po1uOCCV/1REel4O18pJdY7Rf1cCB9+Z/GIT/jpoY9oCdUgUcgKAtlfNVaUjWG9oVonRjhd4E+ICS37hna3BHbk+qBKs2SDGLNahM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4047
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Nov 2022 10:43:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9939

PiA+ICtsb2NhbF9jb25mX2hlYWRlcjoNCj4gPiArICB0cnVzdGVkLWZpcm13YXJlLWEtcWVtdS1h
cm02NDogfA0KPiA+ICsgICAgSU1BR0VfSU5TVEFMTF9hcHBlbmQgPSAiIHRydXN0ZWQtZmlybXdh
cmUtYS1xZW11LWFybTY0Ig0KPiA+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPg0KPiBX
aHkgaXMgdGhpcyBzdGlsbCBuZWVkZWQ/IEFzIGRpc2N1c3NlZCwgd2Ugd2FudCB0byBoYXZlIChR
RU1VKSB1LWJvb3Qgd2l0aCBURkENCj4gYW5kIE9QVEVFIHdoZW4gc2VjdXJlIGJvb3QgaXMgc2Vs
ZWN0ZWQuDQo+DQpMb29raW5nIGZvciB0aGUgcmlnaHQgc3BvdCB0byBwbGFjZSB0aGUgZGVwZW5k
ZW5jaWUgb24gVEZBLg0KS2FzL2JvYXJkIHNob3VsZCBiZSBrZXB0IGNsZWFuIHdpdGggb25seSBt
YWNoaW5lIG9wdGlvbiBzZXQNCkthcy9vcHQvZWJkLXNlY3VyZS1ib290LXNuYWtlb2lsLnltbCBz
aG91bGQgd29yayBmb3IgeDg2IGFzIHdlbGwgZm9yIGFybQ0KDQpTbyBjcmVhdGluZyBhIGViZC1z
ZWN1cmUtYm9vdC1zbmFrZW9pbC1hcm02NC55bWwgPw0KT3IgaXMgdGhlcmUgYSBwc3NvaWJpbGl0
eSB0byBhZGQgYSAiaWYgbWFjaGluZSBxZW11LWFybTY0IiB0byB0aGUgZWJkLXNlY3VyZS1ib290
LXNuYWtlb2lsLnltbD8NCkFkZGluZyBpdCB0byB0aGUgc2VjdXJlLWJvb3Qtc2VjcmV0cy5pbmMg
aXMgbm90IGEgZ29vZCBzcG90IGFzIHdlbGwuDQoNCk5vIGlkZWEgd2hlcmUgdG8gcHV0IGl0IGN1
cnJlbnRseSAuLi4NCg==

