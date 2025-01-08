Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF893E77188
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 01:58:05 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.2])
 by mx.groups.io with SMTP id smtpd.web10.15599.1736331450259221018
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jan 2025 02:17:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uKuDmzu2;
 spf=pass (domain: siemens.com, ip: 52.101.69.2, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSJf1/iiRnwevrOO1x563o8rr03IeEBqLRbMfnedbOY2NmNn8xK/lzw+S/Qn/RFiJczgXLK0unFubQhbknmrIqOWPrjOfgFXMW0Q79gTEjcsZ1b5ewI8GVgtxAo41vieoQBYD6cGn7PgMRIshJrZflqUhvd9nFgN39blxxN/YN1wNfxbrDQP4pdWf8kgc9fIzdk7Q4UENlcBwhIOT+UpUwKKDtp2oBCSXO/xBXAGX7PwVMeBbrBKIn5GWNcY+7KtNx9n0eDWL3yXpvkEyUJucdJbM2wQqVmk7D+K9drr0trSDVxfF5ikOvmadEVLY40uU6p7hkv6FMOJcNRBh0kv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LAQcUrqSEJbMAx0A1bYi1PuZBea3U0A/vAuTWuRRw0=;
 b=xiZo5W6Inz35Ay5dgwjsjSsMVTMvmxQLOnVKOrkVJbdnuKOwk2W+l2sXTbSHXxD7xJJKbm6JeIh113piRRWe4wIAWNQBZioY2D/N0cFpDwJ4SIWY9N9quoszPjvyFv8mdeGu0twKMIdhQR+ejTLtAGji1mkExF9vMercgTm0GprcQ08TTfY2LcxURzc5YlxCq0RlmkHJS533oNnmvENAdxSYUX+Gzt1l60i721waPOrUURN7Y6JQe0dcyyhlBs+JyR5hyDCTXISGE1RCI2ZSfMgXP73KRZxpela1ToILHe/lcGid9PfZaOL7MoFHLcb6dxCzRMHV3UgWK3U1CoOpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LAQcUrqSEJbMAx0A1bYi1PuZBea3U0A/vAuTWuRRw0=;
 b=uKuDmzu2KtHsVAvUIV3PgpZY0yQtw/THNDVft8wsyq9Ad3VyRBb3xk36gNpg84mByy2JsDv6ppRKTrgBkJJ8+VMtEs8FzkmXLofRRdVzqoe8jFDKLSy3sJh/+0bfvJOzpND40kB13qHyrx5HgU9sahZinMCBK5aqqzYDSxcA8la/VRKzPXSC2VVGOn8KfV8L/NHkuQCWWA3c37lXMb0jKFRaYh9rIq4Hf9tXn6EYPRXRYmhwphBS50g9A12dZjtdNTsfxW0TXNyZ8/RPlqCkd2ohS8OV8hy4NL1osC1pXEm/EiR1YodCilGzj7ZnPIodKOJzc2De8F6ADxAM3+dHUw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GV1PR10MB8860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 10:17:26 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.8335.007; Wed, 8 Jan 2025
 10:17:26 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Adler,
 Michael" <michael.adler@siemens.com>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 0/1] linux-cip: add kernel config snippet for container compatibility
Thread-Topic: [PATCH 0/1] linux-cip: add kernel config snippet for container
 compatibility
Thread-Index: AQHbYbaEPMcaX3PKSU2ke18iTAksPQ==
Date: Wed, 8 Jan 2025 10:17:26 +0000
Message-ID: <27230c907a5b0c43baada41fe3b49528b0d81eb3.camel@siemens.com>
References: <20250108100755.55673-1-michael.adler@siemens.com>
In-Reply-To: <20250108100755.55673-1-michael.adler@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|GV1PR10MB8860:EE_
x-ms-office365-filtering-correlation-id: 82f85fa2-2cdf-4c5e-3c15-08dd2fcda6be
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WjZSSXRGZ25aUDVTVGpDbGFXVTVNcE9hclp4WUtCWDBtak9HcnRTSndFWmdh?=
 =?utf-8?B?aHVKcGZFS1hGVW8vd2Y4Sy9hUWVUbjU1aFl0bXNtdEIyQnpxKzhQZG5UUm42?=
 =?utf-8?B?MnlXVk8wSURROEo4Y3ZQbGRoMkdRdTgzcERKODJBOUJadWt2c0d5M3I3WFdT?=
 =?utf-8?B?dFJ5Y21wZExwK050N0pRQ3Z1TjZ2ZjQ2YzFna3ZHeVFmSTZoNGNuNjl5N0VO?=
 =?utf-8?B?UXd0cmhPNzY5Mkc2eU0ydTlYS0Q0RnhWZDVGbjh2TFZzbW5DTy9HN1d6OGFV?=
 =?utf-8?B?RGt3MmlwQkxTT2lGQnIvTkg2dXhUd3MyQ2VjaHl0aFh6VzlhZXdSN2MwUnd1?=
 =?utf-8?B?M3gzVEREbGdaRC9td0xDMU9iQ2xwaGo5bkNpKzJqTnZPQWJhTWlmaTdNN0o0?=
 =?utf-8?B?bTNGc1A4YWNsaUdzdHE0cmpkaEtqRkN6cy9aT2RnNWZsQnRHL2RRb3NkbHUr?=
 =?utf-8?B?cVhCUitZUEJsRzcxZnJKL2l1ZThYU09yME9jMGVZUVZhMXZSd2Y5TDhURTgv?=
 =?utf-8?B?ZW83OFlHZE5uMDBFR053ZHNieUJzcUZ1UnFKcTE2aTc5dGRSWEpQMmVPcW45?=
 =?utf-8?B?UFNPU0dhbWpSK0poL0UrMVpNQUg1bkUwS2E4T2xPbTh4MFlJbC8yeXUvM2pX?=
 =?utf-8?B?K0ZES3R6Vk5MRTJ2b3RqQUQvWkJzcmRUUFVrZWd6eTNIQ1o2YndLMCs0THVE?=
 =?utf-8?B?TldUc1lkSzVtQWdGWnh3cmtxbEVySWVFOW95TGNwaFRsYi9laHUvcDlJM1lR?=
 =?utf-8?B?akRTcHNYUCtacWs2MDhicVV1OCtiazlHc0xaYzlRVk9Wd3F3TTlVV0V3Nlo4?=
 =?utf-8?B?eHlTaW5PM3RJQXZvZ1hnL0ZiNHhsMjMrYzE5R0pidE9TaVIxQnJHeGNvSjF0?=
 =?utf-8?B?SXhyWVR3MG40N1ovMzFDaGdxdUxsdzJQMVpmakZIOWMxMUVKanZ5cm9tazgv?=
 =?utf-8?B?bjd1eG1rN09jYzNxenRHckJRemxucjJMSzh5RDhhOTUrRjJFNWFWNG1VOUlj?=
 =?utf-8?B?SjBtc0N1ZWJYNXZUaXlCZjdzNmNxUWcrbUxSUHJsWFg1a3pRMXZtYmNWaDhI?=
 =?utf-8?B?ZG1DTWNLb0NWejJ4dGJNYkJLU2NEaGlXNm5ycEhsZmFEekhoeE5PZm1yZDIz?=
 =?utf-8?B?eXdqR3YvSjVYVTYrZ0xkdXBCV3d2MnNrZUtsMk5rQ1JiRlJCZy80dHBFWlVZ?=
 =?utf-8?B?QnJlYkpsSjFqUitjYzNqbnZEQytUdTRFcU1FbU80SGFlRlRjQXUzU1dKTkd0?=
 =?utf-8?B?Sys1cWp6a0VGQ3diYzFxOC9wbjdueGFWUFVPT3R5T2RjVTdUZWttSjhPOEM1?=
 =?utf-8?B?S0NodDFoSldZV1ZXM08vNVRDMFhQUWI4VDA0VGR1RFl1NHZXNWw0Wk1pSGNi?=
 =?utf-8?B?NE5CMUQrMjRzMk1TSFNQbDlLdXo5ZVJiL1pFMVpnOXZvUmpiZEdCeFVVRDZH?=
 =?utf-8?B?TC9JNnF2c29KODFESG1sMTRtY3E4alZxMW9OUzl4akdQelJqOVJyRmpGU3pn?=
 =?utf-8?B?V1F0RjUwU3pHR3VrcmtvbUxySlRkclllakZnamxHcDc1MWhWYVRwSDVwZDlU?=
 =?utf-8?B?Z0k5YWl3YXF1ajJlcS85MWlBSmtxNU12cFl3ZEhNYTRHM21xQWlBbUFPSEFP?=
 =?utf-8?B?cFdmbjdITFRDR1pQOUpRdGJyZ1BzRUdFd0pyejdCZ2l2eS9vTlU1N1o4UHFH?=
 =?utf-8?B?bS9TWGppY2gwbDNQbjFmeHh1V21DQVViRkRDb1Frb0FFNEVYbHRKWXVEL2o2?=
 =?utf-8?B?RStiVWlKTytxV0hsY0dUUW9UUGdrN2VtYi8xWWtTbUIydVl4RGpQaFgyLzdX?=
 =?utf-8?B?aS9XRkNXSHBGTFltdUJobzkyWURDOXd4ZnNRdmlhcUZTWkVreGFhN3dWTGFD?=
 =?utf-8?B?TVZJRlB1Q2Z4cGFkRTcwZlpxRXJScEJ1Qkc1REdQVllTQi9zeHRQTzhrUHpH?=
 =?utf-8?Q?ZqWF8NDxg0Gin+8DVU1x2djUsWJj7K6v?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YUNKYjVMeFNVNzVvQVF0Qk9ObmV3bkpsekpJbjJwMWVhdUJZRzBXMGJDbHZZ?=
 =?utf-8?B?Z0FLZ1dYdXd4SWRwM0xoNWR6TkN0ZlZjbW43RDc4T3JCaklxMGxyUUNPYVpx?=
 =?utf-8?B?RWhzTlFlc0p0SjZ1WmFna2I5LzFaZmc1WTQwdGFyL3ZZcFFmV2ZOa3dKNWZY?=
 =?utf-8?B?K2lscU5NQTA4TUE4QWxrSnVTb09NYVZjUkhReGdhRjlWN2dxRzZvVi9ZbXN2?=
 =?utf-8?B?MmpsUFlFNlJ5cHVZQUJPSFBzTktBZ2RRMlNUL3BXL3lOaDhXMXkwcllSaEs1?=
 =?utf-8?B?QUVaMXFSdGNxL3FmUXNOTFBOYStMSU9XdnMxVmFNNS9LS2NGTDVMRE9WNU5P?=
 =?utf-8?B?Ny92c0tFMFczcWUxblF0c2FzL3UyL2ZhU2lqVENaZ09VNW54RFV2WlZmMytM?=
 =?utf-8?B?MTBTNVB3RUUrWU5nNnYzYkkwZ0hrWC9XNlpXL1QvOCs1N283c3QvWXEwTU4z?=
 =?utf-8?B?eG1XdlNVWU9jY2VWRDFYZmJuSzhaNncwN1B4dGR3dC9aR09OTy8yY2JkR0g5?=
 =?utf-8?B?L1hvcWh1ZTRvQ05oS3lqdjAxcVlleEw1ZTBvODYzc0l3aHNxMnJ1N0Y4K0Fj?=
 =?utf-8?B?NXVNSVJCWmwzaGxMYktlc1h6R1hFZ0I4SmlsWXBTOTJUaytMQTJmdTFkTkdH?=
 =?utf-8?B?VThNODFlRmF6UjZWS29hWjQrMXNuQ21EeHRTYVM3anRVYjJLS09vaU5Oblla?=
 =?utf-8?B?TUhxcXVyQWRINmp2SDVxa2xMcktXSFA1WWtHYWdTNTlCdlJSend2cjJncXpV?=
 =?utf-8?B?RzJQSWNBeVNodTNoakorQUk1by9oVGViSzBNUGJtRDIyRU9Dako1Zis3M2lF?=
 =?utf-8?B?VklEVUorZnFNbEdWVHVBbzh6ekdHMkRvYmovQkR3dERXa2tKeHFCRTh2emoy?=
 =?utf-8?B?UXYvVHNNTlNBd3lIdkkrRDN6bTNKd3BRR0YxV2VuVitpVFI3RHh5bVNPc2N5?=
 =?utf-8?B?bFQyeWZxVHR6dHFybnVYSzJxVmRXRkYwK1VFOTliSnVVMFpSWGluRVIrNnE1?=
 =?utf-8?B?V1B1eVgzRlJ4cXhRaGF0UXZGdWV1citOOVlTQ0wyZjVJbmgwQXdhSkVUT3JP?=
 =?utf-8?B?enNyNmVMQ2VpaDFWdzJ6NEljS2VXKzhNdFh3MjR3dlhtTjZIZndMK1NjVlow?=
 =?utf-8?B?ejlIMU5BVTNjYThLYkxMR0VpSmJ2Q0prNEVmcXNQcG9Wb2hBbU9VdjhJREc4?=
 =?utf-8?B?UEhieHlRZjlKUS8wQWQ0Nnh2SHNMNU41eDdvL0hzUVRYQTVsM1gvNDZ6L0dr?=
 =?utf-8?B?VWZVWHJBcVVEbEYvcjVvdlNwNEJMZFA2d0d1V2RNOWN1MDBVVDNxSzlUWkpQ?=
 =?utf-8?B?VHZBMXBuaXVRQmVSdytvL2h3U0lQYWZJSUZXQ2tOeDhlWGdXdHlPdGM1NWpM?=
 =?utf-8?B?VW8yVklhb3RFR211T1YrYWVqMDc1ZFlJeU5Nc0tTUHlJRStUcHNBV3JwZ1lY?=
 =?utf-8?B?Z1J5cHQ3cndnWDk2YktxaXVKWW5xRjRWYW4wOWFwdzlnVzdtcUZMblhuZWJr?=
 =?utf-8?B?MjJtQW0zaVZFeWd2K2V6cnFsam5uUWR0T0Z1NDJlM1p3dTlKVTRmZ3M4ZjI3?=
 =?utf-8?B?WmhkUldST09kRy9GZStMd0UyYzJwNFRmNisxUEorOU5QL1hRTmRtUXFpdWNH?=
 =?utf-8?B?WEYrM0dKdEI2Nm5LYzRmRUpCTC9mV2FuNllxQ0wzcTcxV1NZOGMxOGlJbDY5?=
 =?utf-8?B?ZTBMdVZJM0VjWDFxZmxqVHJaNjhlKzd1bmZEUzdJQ0pVSmdtck5GekQ1U1hX?=
 =?utf-8?B?Z0gwajkreFh3UEdpMmljRTluNTRsZ1VKd2JEVk14WG9vbTdDWGc0ZUpQV1Z5?=
 =?utf-8?B?TjcxRUxUNmZWVVlhYlVXeXRjWW5YNUc1M1RrdC9rek1IWGNmaStqU2hsZ21h?=
 =?utf-8?B?dTQzZDZPcTNldXVsSk82ZFplb01FMVBzTEpBSnlFbjJ6V0hrWE1TWjhDRURn?=
 =?utf-8?B?UVlPZUZPYmRzNlVLTkZ5SXpycXdWQWpjNHJIbVc5VmdlaUo4YmVHNVdpbEVi?=
 =?utf-8?B?Y0xrcXd5NUd3L2pTdkZVS1YxNjl1eHVZRHFyL2xTSEc1UjZkSlpxS0JjdU5X?=
 =?utf-8?B?RXZIY2J1QjR6RUNZb09vSHlTMzU4S0lPenhTdjFIVXVHQ3g4d3RCRTVMS3ZF?=
 =?utf-8?B?QlhjVEd4Qm5ZV1pqQ0hSbG1jci9hbDZOTlQxeUxhd3NVRmZBMXR1M0NIM1JK?=
 =?utf-8?B?UmhOa25Bd2FGSzkzdFNSeXhuUlVsWkZpUkhsWitVU2ZUbXI1S2ZzY0dRdmFj?=
 =?utf-8?Q?adb6M5AZp8A9FFKeNOKhL0I86YsoyncpxASR6h7G+8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f85fa2-2cdf-4c5e-3c15-08dd2fcda6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 10:17:26.8196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pB2EY2/K3ewttIhgAUf7PaPeUAt3ojgs4iyrdSDahi0hgcdqLDRDn/rZLkDI9w8sI6Je2E/hIVtWcSC0AmCAPVkdHA7DwYkxloZH2jjxJas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8860
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1E24B8B5B1D24FB5173A021D9793EF@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jan 2025 01:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17508

T24gV2VkLCAyMDI1LTAxLTA4IGF0IDExOjA3ICswMTAwLCBNaWNoYWVsIEFkbGVyIHdyb3RlOg0K
PiBXaGlsZSB0aGUgY2lwLWNvcmUgeDg2LTY0IGtlcm5lbCBjb25maWd1cmF0aW9uIGluY2x1ZGVz
IHRoZSBuZWNlc3NhcnkNCj4gb3B0aW9ucw0KPiBmb3IgY29udGFpbmVyIGVuZ2luZXMgbGlrZSBE
b2NrZXIsIHRoZSBhcm02NCBjb25maWd1cmF0aW9uIGRvZXMgbm90Lg0KPiBJIGhhdmUgaWRlbnRp
ZmllZCB0aGUgcmVxdWlyZWQga2VybmVsIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyB0byBlbnN1cmUN
Cj4gY29tcGF0aWJpbGl0eSB3aXRoIERvY2tlciBhbmQgUG9kbWFuLg0KPiBJbnN0ZWFkIG9mIGlu
dGVncmF0aW5nIHRoZXNlIG9wdGlvbnMgZGlyZWN0bHkgaW50byB0aGUgYXJtNjQNCj4gY29uZmln
dXJhdGlvbiwgSQ0KPiBhbSBwcm92aWRpbmcgdGhlbSBhcyBhIGRyb3AtaW4gc25pcHBldCB0byBz
dXBwb3J0IGN1c3RvbSBrZXJuZWwNCj4gY29uZmlndXJhdGlvbnMuDQo+IA0KPiBOb3RlOiBJIGFt
IG9wZW4gdG8gZmVlZGJhY2sgb24gd2hldGhlciB0aGlzIHNob3VsZCByZW1haW4gYSBkcm9wLWlu
DQo+IHNuaXBwZXQgb3INCj4gYmUgbWVyZ2VkIGludG8gdGhlIGRlZmF1bHQgY29uZmlndXJhdGlv
bi4NCg0KSGksIElNSE8gdGhpcyBzaG91bGQgYmUgbWVyZ2VkIGludG8gdGhlIGNpcCBkZWZjb25m
LiBBdCBsZWFzdCB0aGUgbm9uLQ0KYXJjaCBzcGVjaWZpYyBmZWF0dXJlcyBzaG91bGQgYmUgY29u
c2lzdGVudCBhY3Jvc3MgYXJjaGl0ZWN0dXJlcy4NCg0KUHV0dGluZyBOb2J1aGlybyBpbiBDQywg
YXMgaGUgbWFpbnRhaW5zIHRoZSBjaXAga2VybmVsIGNvbmZpZy4NCg0KV2UgZnVydGhlciBzaG91
bGQgdmFsaWRhdGUgdGhlIGJvdGggcGxhdGZvcm1zIHdpdGggdGhlIHJ1bmMgY2hlY2tlcg0Kc2Ny
aXB0Og0KaHR0cHM6Ly9naXRodWIuY29tL29wZW5jb250YWluZXJzL3J1bmMvYmxvYi9tYWluL3Nj
cmlwdC9jaGVjay1jb25maWcuc2gNCg0KQmVzdCByZWdhcmRzLA0KRmVsaXgNCg0KPiANCj4gDQo+
IE1pY2hhZWwgQWRsZXIgKDEpOg0KPiDCoCBsaW51eC1jaXA6IGFkZCBrZXJuZWwgY29uZmlnIHNu
aXBwZXQgZm9yIGNvbnRhaW5lciBjb21wYXRpYmlsaXR5DQo+IA0KPiDCoGNvbmYvbWFjaGluZS9x
ZW11LWFtZDY0LmNvbmbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gwqBj
b25mL21hY2hpbmUvcWVtdS1hcm02NC5jb25mwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqAgMSArDQo+IMKgcmVjaXBlcy1rZXJuZWwvbGludXgvZmlsZXMvY29udGFpbmVyLmNmZ8KgIHwg
MTE0DQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gwqByZWNpcGVzLWtlcm5lbC9saW51eC9s
aW51eC1jaXAtY29tbW9uLmluYyB8wqDCoCA1ICsNCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDEyMSBp
bnNlcnRpb25zKCspDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMta2VybmVsL2xpbnV4
L2ZpbGVzL2NvbnRhaW5lci5jZmcNCj4gDQoNCg==

