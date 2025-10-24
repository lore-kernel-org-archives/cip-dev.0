Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DFBCCD1A5
	for <webhook@archiver.kernel.org>; Fri, 24 Oct 2025 11:13:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.web10.7558.1761304423930025928
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Oct 2025 04:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VCWTLM1f;
 spf=pass (domain: siemens.com, ip: 52.101.84.38, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wILgEooBUTzMv5Hlq/TivFfHfGe2K06TQ2e/zfMydbaJfzsK1F9BZQDzFBnmXpo2F9r8XuDTqZHCsaXdth+SeE+ISXwVaarmV28bBjCkRs0Zur0igLwGEsBFpQE/SuQRJhx8p8wqrDed09Ni19ncvZPeto1EODaiGZ6/l0WOkLSkWQR9hz7NqJlSB4f5/nYhSzazaGQMTMRPukPviW6owfIF5zUJGOhn5GSNKpJnQ1A2SOk/UFjzDlfIS2oRrsClH7pmMOwqfiItyJ4vDGfpBIiBS+SsOYfERP0TIJcS3S8XJh80VvKfHAU0m58UXNfnhmj2pqu5Dq6BiDf6UKEUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNAZF8Qg6hc/3PDlcYIc7nndyF8EVsZ2Cv/ZR1AyUrE=;
 b=uwOapNAAtmJm8g1MzFMrn0Us3YbnJ3ogn6uugKzo2lvwOCTfgSOb6hzzJzMb4KqjYBwTI/WeVHIkAYg3HQKFGnDtPYvF+HPbc8KkrrgXocqSADi+21YbxY/nzvcecEUr1sGhmw2FsjAJeCYy8bt9iDDlw818pdADg1liqQu7UrRD96uTeEYvUFNU1ZnicOo8Te9eh5c+tTktlLI/APpnL3duhlWnhiSH3qSJdPjRYpQvtwdzJkGmZNFd2fhDxaHlmAqoytCG3ZJKWEzOxhD9gm+t0Xgw93K0DINmxXkxbXTY6RKJrxk7l/ebsifWWCHz3qQlNtv9rnJU3mFe8olwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNAZF8Qg6hc/3PDlcYIc7nndyF8EVsZ2Cv/ZR1AyUrE=;
 b=VCWTLM1fUMv0/uYGIQj2ZrSvadYg9j2JqtHu22SE5/KI/ydb4rMX9hDIrSL3Lh1fuiM+Lro7Qt1JS9zwtiGTBW2e6Yyuz8B3ASoLKhIT1xZHOUgQeUmxVj4N25tnjST+fH5k4sgd/OSv4oMPSKcRnV+KtTXI1P2y0WweY11ju/6/ZfoygslZXG7lohJepjpqn7uuL2/IUopq8Hc31Qt6gQzpC/YLy02PRShLEGux0Qio1SIp1G89FPx7M+HNMqof6XWSRb6/AkeWVyUjSWJBTqwxmoKlqhCqNdIqsaQzqZRzfQCsjc+Hj9dVs08MrvnI6lCP1sVcB4ofKbKqL2RGbw==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB8PR10MB3798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Fri, 24 Oct
 2025 11:13:40 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:13:40 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 1/2] read-only-rootfs: Fix rebuild from
 sstate cache
Thread-Topic: [isar-cip-core][PATCH 1/2] read-only-rootfs: Fix rebuild from
 sstate cache
Thread-Index: AQHcRM6tUA1RNqvWfUOz40ynIEALKLTRJOGA
Date: Fri, 24 Oct 2025 11:13:39 +0000
Message-ID: <07658546a6b733b67d9e617a060d850d589d2575.camel@siemens.com>
References: <70896e59-d6ca-41b7-b06d-bac4238d95f5@siemens.com>
In-Reply-To: <70896e59-d6ca-41b7-b06d-bac4238d95f5@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-5 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB8PR10MB3798:EE_
x-ms-office365-filtering-correlation-id: 7b9de2fd-6fc0-4f6d-7d7f-08de12ee62b4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WHV0N0NnNFNKTFZWb2c4WnE1RVZIM05hbGdqbE01NzRKZVJQQ3oxWFU2RWo0?=
 =?utf-8?B?VWJZUGR1TE0wem4vUDN6aDFIK3JLSmlpdnVwckxGT0dNd1pxNG5YWVRLV1lm?=
 =?utf-8?B?dkpIU2w4c0xmV1p6amY3d3h6YnJvRmZVaXFEUEtaTGhuRGVUR1lzS2lXQ2xT?=
 =?utf-8?B?L0kzNmluQnRJeG5yYTQvZDIvd1lyUmRyU2MvVjAwNTNnMzh6aGIvUFhQWHdF?=
 =?utf-8?B?ZndmODkxSHRmZk1xQkZXUUhaK1NDLytmdllZNW9hbnR2U2pvajE1cCtuUlQ4?=
 =?utf-8?B?UkRrR1cxbjN6VHVSSkdXYVVlOUtFditDSEpKT29Fay9rYXRKQk1QZXpMdlpE?=
 =?utf-8?B?aklRN0l3Mkg3OWZZblF3K05NSFh0UWdZdysxLzFXTXJ6czFUSTNHK3g2YVlZ?=
 =?utf-8?B?TWwvVTZHZW5uZXp4NVl2WFltbnhXUnpYVWRTTUwybDN2UXV1R0NFQllKdmxL?=
 =?utf-8?B?M2NoR29Pd0hEa0RXOWd0NzRaTUhHYnB1Wm1qU25XL3hhM3dpem4zL2VTUEtv?=
 =?utf-8?B?M0gvUThPbktERFpBUmxQNWRYVzFHS3BieFdyZUpYUGw5VEhNYTRWNnBpZk5X?=
 =?utf-8?B?eVZYREs5QXpBZzI3d2NPaFl4b0xPZ2ROM0pCcHFWUzdmd3J3L1dDemNiemkr?=
 =?utf-8?B?SWUxQkFZN2ZpVDBTbW04NmFFWGRYeXFGM2ZjeDM2YWYxVDdaMFdsUEtDdHVk?=
 =?utf-8?B?TmlYaWtBUDllYnJZVTY0d2JNMWdHdkhWZTZLMk93QlJvbGxDY25vKytEeG9C?=
 =?utf-8?B?RW5CVzFvVjl0VklaM3NKNVk2cUxiZURzUjBPMXhEaEFVY3dOeVY5OGs5TWlO?=
 =?utf-8?B?ajU1R0ZpL1E3L3U5YkhDUU5ZOGh4bHBMMlFCRE1iSmd4RkcxdXBCa1VkY05H?=
 =?utf-8?B?RzVhVHZKTlBJZmNER3llY2FTT3ZmVGk2VjNHTWFDczc5cWpWb2k3TTlHbFZZ?=
 =?utf-8?B?SExidStqUEZRUjBPU3pIeDI0amREL1ZHYVJPcGMrRElBSFM2WXNZQk9YV1Zq?=
 =?utf-8?B?K3RDeStqcEVZbThHUlpMbkVqWWZiSi9wYVBIMXFhKzRsM3M3YTBmby9ESGRS?=
 =?utf-8?B?aGt0QjVmRmYranhvZk4yd1E4K1k4OTJiOU5XYkdIeStjVW1lOWc3Q25xN2xY?=
 =?utf-8?B?ekU2YktmeGxML1NBZWZmMzc4L3R4RENuZzJ1enJiWHNVYWVyMDd1eUloMElx?=
 =?utf-8?B?UExkTi9laUJkNy9hRkJtTlAycUYzZlI4ejcza3FDalFoZlUrTU5GdVBzMTU4?=
 =?utf-8?B?SVNjUzVnYzVCdXFvR0hPRnFKcERqUHJhNUdGaUVtV2x5YU5td0J3endpSDV1?=
 =?utf-8?B?dFZRQ1NyaE1VbVZ4L2NKeUJ4MUJucHhDZzBUcGVNK1Y2ZEw1cVg0d1MzNEg0?=
 =?utf-8?B?dVFaNk1iK0YrMEFpcGIveVpBRTdNRXBWa1ZGTlRXRGF4eWt1RVRWQWtoak5j?=
 =?utf-8?B?bTc4RmltRkNPVmtYZm9XcFFqdGxDbmpoOG56T2tSejlHd3BKSm56NGhOUEg2?=
 =?utf-8?B?L05DWlRnRXVVV3Z6RTZxZXFHa0poRjU0U2l6amY4czUzQ29xakVkeVhKaXZo?=
 =?utf-8?B?K2JHN1ArZFZGbG4vRXM3ZWdsMHJqcVdyUkhjWVVQVTBmUXo0TFFOSHlGQjBs?=
 =?utf-8?B?dkNVUXZhV0psSkdCYVVBK2NFNWRLSlRydVF4VnJzUG9pMFg2Y0ZvYzNKVlAx?=
 =?utf-8?B?WlNnUnhyVCtVTXc3TEVPdzFobmxpejRnTWJXc0RDZEcrU3ZkbEZuUEpXU0xm?=
 =?utf-8?B?c0JnQWVBN2hzVkVxUm40RWVxRFp3YVB0ZGlESnhCWlhJdGdUeUVIMS9qM1A0?=
 =?utf-8?B?elAvSDlGYkpGQ2l6cWhIMEV3Nmt4clREaVFCTmNNNjlycVJpekFQaHdTSDlF?=
 =?utf-8?B?VWtheElJbEdpMnZnV2U1RDZjWGhyM0pmcVR6Q2doNWIvTU9PQlBqRmxHcXEw?=
 =?utf-8?B?bXNrNWZMZVZlclhObThtRXpmZTloYXhmS2lnVXJLZjlXWUFsMXpHcGlqcmR5?=
 =?utf-8?B?VjdIZ0VDZ1d5OVgwMXc2ckY0UGhyWlRyNkNPQWlLQWxlVy85cVdpS2VGNUI0?=
 =?utf-8?Q?440GVN?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dFpTVTB0RW9yRkEzN2VlTGY2WWVQL3IvS1hTSnhkVkdTdkROaXNhVCt0Q1dT?=
 =?utf-8?B?eU5JeHVGelNaUEJ0ZzZ3NzQrL1RKYTRtcm5JY2tsMVZuRHpEbjhqUXpPZXp0?=
 =?utf-8?B?WlpPZzYra0lIamU1ZDhMWTViSjBQdDdxaEtZYTlFVG5SWXc2ZEJBcnIrcU9z?=
 =?utf-8?B?Wm5Dam5lSnpYclNwZFR4dFJvMTZmUlN3c1BzdEVyVEJXTUl3SEpZT0VoTjZw?=
 =?utf-8?B?aDBvNFBNU2tpOTNFcWN5b01ta2NkWlRldnhDaEE5eVVPMXJ5WDl2dldLRjJx?=
 =?utf-8?B?UHIvTDV1Q0R1UEE2SFNCRnEyN0tiRHcveWcxS2twUFFyRUpNellqem5RNS9W?=
 =?utf-8?B?Z21HM0ZyV1l3ckFHZmNqQWFpN3lOZmN4Szh4MWUzVi9oNDJpeDVuaFNiUUhN?=
 =?utf-8?B?Y1pnWUVBUDlxbnM2MEkrdXNYRVFPakZLRE1uNnRsSzYwZ2d5THVMQXlTRCtz?=
 =?utf-8?B?dzJEVmtvT2l2d21EVE03NFZpRnNpM2laRExReC8zblRrNFNYMkpTbHp4QWZk?=
 =?utf-8?B?dmJZd3ZuWmx3QnBhS3UvaGcxTGVIVFlFWnZnei8yZW1pRW0wUUdEOTBkakdl?=
 =?utf-8?B?dzRDbEdiWkVKTGNVUzNEUGpnZFhLNjhseTl2eHZqWmdjTUpwb0lrSjJ2UkRB?=
 =?utf-8?B?R3F1WUYwU3JyRmZqcnZiNkJXTHhjMW93M25zcXptNlRDaWNKd0xrdnlKYXB6?=
 =?utf-8?B?dWdqcFNnTC9vMW12OGY3azluS0h1Mzk5TzFhZmFjOXRkN0Q3MThFbEg1MnY2?=
 =?utf-8?B?SExlR3FIS0ZTNXNHdEdnVjk4ZEZ6UEcwMk1DMHU1OTlremxodktWL0xtYUZF?=
 =?utf-8?B?TjN0a3RKWUJiMzRSa055K0JQdkF5OGM4SDlXZjc4Tm1TbmlCNmhha1lxZTgv?=
 =?utf-8?B?ZTRuRmE5QXhZenlzRG5aRjRQWmhNT1dYRExNSU1VK0dROEU2eG9PemNXdW5o?=
 =?utf-8?B?dE5oemd6d0Jvc2JOdy9ZampnZkx4azJwcDJsSTUxS24yb0t5bURBZEtpMGVQ?=
 =?utf-8?B?LzJITzBLK1gxU3RyTjYrWlpnKzJBZm5MZHFZOERKTFB4VTR1Zi96K0RXWXZq?=
 =?utf-8?B?U0xTbEcra1pHSU9TZ3JYMFNzKy90eHp5U1dicmJEWVJvaUg3RkpDS2F2K3dh?=
 =?utf-8?B?YndpOW92cmpDY2VRS3Jva0d5REZXWUluMGVSWGk4SHVERGZwWENnTFdsNmRT?=
 =?utf-8?B?L0NjWTZteS9nR2tReW1WSG9kRWZodDYwQmd3TWlFbGdaWk0zbG9kbDhpTTBs?=
 =?utf-8?B?ZUw0di8vTGw0VzAyYXRzU3V2QmhrMUV1K2d5bnFHdXlYWXNiZlU2eDZaNDlH?=
 =?utf-8?B?TU5Ib0swdHlrRCsyUHVremsxS0ViZE5tTVpjOTJWcVBhVGlWTVZwVFdMUUxB?=
 =?utf-8?B?elByLzNvdmZ3OFpYS0hLZjZxL1owbUxJUGhZRWlkNWpNK25YRUFlYVJWMzFB?=
 =?utf-8?B?TFBMODdVTmpiMHh3dHFNVEQrRld3bi8rY1cwR3laZks5OEdJb051ZkpMMmtL?=
 =?utf-8?B?MmMwWFNRZW5aUnc2YTZ1WVpyRDlrNllYRlZXNmp0TmU3YWJ5OFg1SXl1aUtY?=
 =?utf-8?B?bWVmckpsdVVTdHlwTUVrVnkzQ0JJUEVqN0wrN2FydlNDaWV2L2lucWJES3Bl?=
 =?utf-8?B?d29hcW9ta0RvN01UN2owbUpOcEV3K3FJNTNPalRGM2t2ZjBISlhNY1J4QUE1?=
 =?utf-8?B?eFU2ai9lV1VBUmJmRUpHWkFHTkZhSCtLSmlLaFJUREU3RFIyb3llVVdsRy9y?=
 =?utf-8?B?Q3NyOUF6ZTFXejA4TjJiQzYzbS9wMFp1bUdMSVBSNkJkcDZMbExHWS9xZVBP?=
 =?utf-8?B?bTUva2JFODhpS0RuNHZJTDZJVVFZQkxSR2JIaG1hNHJnLzZzbkhtMndXeUtS?=
 =?utf-8?B?Y214NFVMQWI1ZXBKSDVrZm1tcUNvcnluTzA3dUxMTlUwaUFWUDZpVWd6b2pw?=
 =?utf-8?B?NVdpcytBVnJncStkamx3QlVwc1pJRGZKeVcwQjcwOUxDUHh0TFEwcm55aTdO?=
 =?utf-8?B?bkxtcGFyUmJmTTJRc3dxakpOK3BzT0ZHVnhhNVdqbjFhSVlPZGpWdVBvOUZj?=
 =?utf-8?B?VkRpVWtjWTczNjRVa25MVUlsZHFyMk8wTmU0Z1k0NEJUU0F1Zm04Vmo4eFZq?=
 =?utf-8?B?OGxwYTZGQ3BHUlRid0tUZ1ZaNFZrQmc3YS9rWkU3bkp5VWh5U09LVUgzUHRT?=
 =?utf-8?B?OEVxYlVQOGhsN2Uwdm5BL2V3WHM0d3FsOVlqem40c1BvYk9wVG9LejdvY29j?=
 =?utf-8?B?aktEMW5qSXhvaU55MlorS0thV0N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F55DF1F29ADF2409BFEE307E3ACF26C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9de2fd-6fc0-4f6d-7d7f-08de12ee62b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 11:13:40.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yD3iGAOI67pvtGdB+ZkbcQ6cb7l/jEQUPe0Frkl0JXxYAXond6YpvPIdDs84YHsMapZtGjsTADTSJwQaggEtssGlDyVRGgN9iw/cMRt+2CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3798
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Oct 2025 11:13:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20219

T24gRnJpLCAyMDI1LTEwLTI0IGF0IDEyOjEyICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBG
cm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gV2hlbiBidWls
ZGluZyB0aGUgcm9vdGZzIHVzaW5nIHRoZSBzc3RhdGUgY2FjaGUsIGhvbWUgaXMgYWxyZWFkeSB0
aGVyZS4NCj4gUHVyZ2UgaXQgYmVmb3JlIHJ1bm5pbmcgdGhlIG12IGNvbW1hbmQgdG8gYXZvaWQN
Cj4gDQo+IHwgREVCVUc6IEV4ZWN1dGluZyBzaGVsbCBmdW5jdGlvbiBjb3B5X2hvbWVfdG9faW1t
dXRhYmxlX2RhdGENCj4gfCBtdjogY2Fubm90IG1vdmUgJy93b3JrL2J1aWxkL3RtcC93b3JrL2Np
cC1jb3JlLXRyaXhpZS1hcm1oZi9jaXAtY29yZS1pbWFnZS1xZW11LWFybS8xLjAtcjAvcm9vdGZz
L2hvbWUnIHRvICcvd29yay9idWlsZC90bXAvd29yay9jaXAtY29yZS10cml4aWUtYXJtaGYvY2lw
LWNvcmUtaW1hZ2UtcWVtdS1hcm0vMS4wLXIwL3Jvb3Rmcy91c3Ivc2hhcmUvaW1tdXRhYmxlLWRh
dGEvaG9tZSc6IERpcmVjdG9yeSBub3QgZW1wdHkNCj4gDQoNClRoYW5rcyENCg0KTm9uZXRoZWxl
c3Mgd2UgbmVlZCB0byBmaXggdGhlIG1pc3NpbmcgaWRlbXBvdGVuY2Ugb2YgdGhlIHJvb3Rmcw0K
cG9zdHByb2Nlc3MgdGFza3MgaW4gaXNhciBpdHNlbGYuDQoNCkkgcmVjZW50bHkgZ2F2ZSBpdCBh
IHRyeSBidXQgdGhlbiBnYXZlIHVwIGFzIGl0IGlzIHJlYWxseSBoYXJkIHRvIHRhcg0KdGhlIHJv
b3RmcyBkdWUgdG8gdGhlIGRldmljZSBub2RlcyBhbmQgbW91bnRzLiBPbmNlIHdlIGhhdmUgdGhh
dCBwb3J0ZWQNCnRvIGJ3cmFwLCBob3BlZnVsbHkgdGhpcyBiZWNvbWVzIGVhc2lseSBwb3NzaWJs
ZS4NCg0KRmVsaXgNCg0KPiBGaXhlczogNzg2ZGRhYWIwN2Q3ICgiTW92ZSBjb250ZW50IG9mIGhv
bWUgdG8gSU1NVVRBQkxFX0RBVEFfRElSIikNCj4gU2lnbmVkLW9mZi1ieTogSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+ICBjbGFzc2VzL3JlYWQtb25seS1yb290
ZnMuYmJjbGFzcyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy9yZWFkLW9ubHktcm9vdGZzLmJiY2xhc3MgYi9jbGFzc2Vz
L3JlYWQtb25seS1yb290ZnMuYmJjbGFzcw0KPiBpbmRleCA5OTgyNjlhNi4uNmEyMWU5ZTMgMTAw
NjQ0DQo+IC0tLSBhL2NsYXNzZXMvcmVhZC1vbmx5LXJvb3Rmcy5iYmNsYXNzDQo+ICsrKyBiL2Ns
YXNzZXMvcmVhZC1vbmx5LXJvb3Rmcy5iYmNsYXNzDQo+IEBAIC01MCw2ICs1MCw3IEBAIFJPT1RG
U19QT1NUUFJPQ0VTU19DT01NQU5EOnJlbW92ZTpzZXBhcmF0ZS1ob21lLXBhcnQgPSAiIGNvcHlf
aG9tZV90b19pbW11dGFibGVfDQo+ICBjb3B5X2hvbWVfdG9faW1tdXRhYmxlX2RhdGEoKSB7DQo+
ICAgICAgSU1NVVRBQkxFX0hPTUVfRElSPSIke1JPT1RGU0RJUn0ke0lNTVVUQUJMRV9EQVRBX0RJ
Un0iDQo+ICAgICAgc3VkbyBta2RpciAtcCAiJElNTVVUQUJMRV9IT01FX0RJUiINCj4gKyAgICBz
dWRvIHJtIC1yZiAiJElNTVVUQUJMRV9IT01FX0RJUi9ob21lIg0KPiAgICAgIHN1ZG8gbXYgJHtS
T09URlNESVJ9L2hvbWUgIiRJTU1VVEFCTEVfSE9NRV9ESVIvIg0KPiAgICAgICMgYXMgdGhlIHJv
b3RmcyBpcyByZWFkLW9ubHkgd2UgbmVlZCB0byBjcmVhdGUgdGhlIGxpbmsNCj4gICAgICAjIGJl
dHdlZW4gL3Zhci9ob21lIGFuZCAvaG9tZSBkdXJpbmcgY3JlYXRpb24uDQo+IC0tIA0KPiAyLjUx
LjANCg0KLS0gDQpTaWVtZW5zIEFHDQpMaW51eCBFeHBlcnQgQ2VudGVyDQpGcmllZHJpY2gtTHVk
d2lnLUJhdWVyLVN0ci4gMw0KODU3NDggR2FyY2hpbmcsIEdlcm1hbnkNCg0K

