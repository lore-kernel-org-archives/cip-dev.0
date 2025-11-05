Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBACECCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 11:50:15 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7769.1762343410176779137
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 03:50:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=onB9DVEY;
 spf=pass (domain: siemens.com, ip: 40.107.130.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6k3RrTmd0qUBtjfdx6DWERwqdahgJP6tDHNDtAzISPY71JHhR0pmDqgf3rzBHOg19mhSJ9l9+8Sd9ojmA+r4NGv6PnMDjqQiwkR32S+g4I4uN02XpYVyeG/oo0FMdt8sOoLnfBapSYRRK1BKCtidfKC1NntTboLv81siCoP/u4cqYIZJHWVGGC9uKP2QOmE6krXwyALCnIolg9+rTvrZJz2jGvdpQVuVHCY4B+CpfeheiJx9iMlY7Hwt8UXdG7vJgvF0OhOTky2yVwDa503mv+u3I8K8d/2A3WySR1eb6k2Y7n7gnU0ddlJJWh6b1BaeRL5ib3E2TisTf08gk4VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An2CnebMZZ6xldtkKItwi8p9FkGa7XKXuZBq46kmGEE=;
 b=uduHUt/ur4nNr2mK4U3wUn7tNpgMTIIKRjhd8WDUIenxVsMu2bixTijBlo9sxD++dg/gt9DXEN0BTwCx7JUBRJXhpt52s9cd6DVhlq4qyDziWBejAKczn3muIK4ikjx//JfpyjeDEpM8/YuQFWmMJnrCSyHVE+9b18eCJ5AjT+QoQWxI0BVxOjaD/4zHbePWWgrmIeCUnqlELo6g+n1BeJ4l+GF3iOoUsgmerWCobah8HE0zfcE8omyzEEcUx+R2arjQHojsCrh7RowOyEBJyh6HfiE1SGBY/H3gbooOkE7nczzxMjjPG1ngRsee+K+og+f/pm0e1bOj4lIOS6G3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An2CnebMZZ6xldtkKItwi8p9FkGa7XKXuZBq46kmGEE=;
 b=onB9DVEYewoDLSuhxVTSSDgfiSExbNnOtEBbdzG4JpkchiEKBnqsjJRhQBTvcdfc9uGTVJtx83IJoL2KB0T2ohTHTPsC77SV4ASrlpkJohTJirkCpN0oGfCb2KXdYe+Mqt8nt05t30yPDe78UqiJi4B8EfdMzn2O+CLLLn+P0HPODBIUYAkPs5Oc+XRkgaBTlEYOEBJlkt4W0OyV3GozFCwAUFkC2OPw+qhKK/ivaXzTg0pyL7wmZEVDQ30OwWnMtBAC0vKrslvfAFGQBU6+JiuKpzlH35Z1tlzaBKy5qjJN9HJyVDVPJxYC22X1wjATEA6n853hGC6oQF/z0qfdkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 11:50:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 11:50:06 +0000
Message-ID: <7ea10ad6-6050-41ac-83b3-63e5c4e82095@siemens.com>
Date: Wed, 5 Nov 2025 12:50:04 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ltp: Unbreak arm64 cross-build on trixie
Content-Language: en-US
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 991adb83-c4b0-4ba7-092b-08de1c61768f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bkRkbkZabUdqL2Vacis1S0JIT09sU01xeDIrZFdMWDh5eGhxS3QyRm9Lc1BY?=
 =?utf-8?B?bC9lc05vSlFzbEk2ZXdHVkRPMjkybmxNQm1IeTUrT2l5bWh0alR3WUl3aGdu?=
 =?utf-8?B?bDlBandDK2VhZ0txbWlxU3hJdjNlbUt1VnJSWlRKR1YzNktLOXFkNElNdmNv?=
 =?utf-8?B?aXA3R0lsZ09yNlJ6RSs4OStGZ20vdnJ3SDBkNDl5NVBkU3RRc0ROTHJIU1RJ?=
 =?utf-8?B?ck9wd243UUNyRkZNNWxyWnhYN2ppdXl3aVdBMTlCcU92Rk5BaFVrcmpvYTl0?=
 =?utf-8?B?ZXRVM1h5bS9sbDBsQS9idU9BUXV0Q2o4dnNSMDJSNGw4ZVZqVXRvOXcydTE5?=
 =?utf-8?B?T0VxSWt3TERkTXoyZCttYVN4N3RRcjVDQXpmRVNXN0VZdDVseWxMRkROYkg0?=
 =?utf-8?B?VTNHeXpVcXVYbVdRcjZqazZ6RnFkQjVabDZJRTVoWk80K3oya0xJSHhHWHhh?=
 =?utf-8?B?cmVOUzkrVTRrTnpDYnNmSzJwRlNqWXljMUJLS1JGZFMrRXAyS0k5K0Y5WkdS?=
 =?utf-8?B?RjIweHcrQ1dHRm1hKzM2cVBKcWdOdm1WYXJObGlmcEV4L205bHgrSTdnczg4?=
 =?utf-8?B?Wi9ESzBlY002ZU5hS3U4NzNIWTNOZU8wQml2REZGZ2RMVnFaSkRQSTRsRHd2?=
 =?utf-8?B?MzcxcUNubVAxd0RrNUk0NktPaFRYTWRSa2k2Wkl1Y083Q0R0Q3BFcnp1blZW?=
 =?utf-8?B?TmpzS3lvVkhLSytPVThDMml5R3JqaVBLWnNvcW9Vckd1NWFFNXc3WGF4cUpF?=
 =?utf-8?B?cENUL1ZnMFRvbEdNaUVVMlREVjZOcVVMbEpMWmUzUWYwUjVyT1RCSnhTNjBD?=
 =?utf-8?B?Q2pObE1KZms3WG1FaDlJaUtmTTJsdEFweDJ0cktNNHg1aC9HL1NDeXBGS0xS?=
 =?utf-8?B?V0RNOXNDMkZURXZlcXBxWTBBRmNGcFBtdEU0aHA4czN0ZDB5OW5EYlRYQitO?=
 =?utf-8?B?VEgzdXVrclE5cTRILzQvRzg2alg1U3R3d3pKTFdvY0VYWVFhbjlCMllDdXds?=
 =?utf-8?B?UkpJR0tKdVhWeWppZnlhbU9vTUVzRTRzeVdYZy9vNitjM2RVaE9KdHgzeUJt?=
 =?utf-8?B?azNINjdIbDZLU2dtaTR5enBCVnJZZzZsdC9PVHB0ZG8zMktYbThkdDhObXll?=
 =?utf-8?B?RHFzRXhxeTJ5a3VCRWV1c1dwOTU5aHdvNFZMbFE3anpqd1cwT040dTVtS29D?=
 =?utf-8?B?OHZRZ0QvU0RsOEZzdmMyTnl6VmhBNXV4T0R6eVJjZ1pMazAydHhYUlFnZnpE?=
 =?utf-8?B?OGxuOHVSc1BvNmNLMkxhUUdob3dsZFJIOFd1Sm5RU3VDMjFaOUVPVHJPbUQr?=
 =?utf-8?B?UzNiV2UrWmRlaFRKN3RUSTZvN2h4TjZoZ0tkVGMxL0N2V2Zlc0c4NDhPdjBn?=
 =?utf-8?B?UENoZWpYZXE5UXBYUm9ycktUR0xiZTNIVkhrZHlmdWZxN05sRmlYQ1NsU3Ji?=
 =?utf-8?B?YmlCckR0NWtva1hVRFVTY21NNFUwWTlzcThYWWdHY09mamh4Wi9LWlc3Ykpn?=
 =?utf-8?B?ZHdZSExQV3VMUGtRUmVGUnZwdFRVSStTYXVOcWl1SDN3Y0xBL3JEZ3BRQ2Z5?=
 =?utf-8?B?RHZKWUgyVS90d2JTVFF6WTNYMUxGTHFaaHRGZ25CcHRySTRKakZMd25kVklj?=
 =?utf-8?B?UDNnZmtSK0FPaVJpakErb2lmQlRDK0MyOGpXWTczT0NRUmFDUC9jc0VEQ0k4?=
 =?utf-8?B?dXRiUzM4YWFGR2l1aVRKYjhkOXlLeWFlcGE5dW1qTCsxdkp4dmtLRzZVM0FI?=
 =?utf-8?B?S3RUczNzY2lTUXZ1SzNGRk1HdnZ3UWVCbFlTU2VMbUtSd2xNWHNvdVh3T2J4?=
 =?utf-8?B?YVkxL0RqR1BLdzFzellnWGV3c3RsYklQbVVpQzFGRDlGWHppY0F6cXdMdytX?=
 =?utf-8?B?STlvUEczYnZGL2RLWkNZcjJadXNVWHRXcHFuUUdzdXVVZ1gyQ1E3aEt3TEdU?=
 =?utf-8?Q?wwJMAfBaWEBi+Ju1gJEgO3S/sA2lUvtM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0dTQ21keTRLTUZuYzMwZ09rNnlheHUyVFZQVU5yMnA3S1l5WisvMWxobEpN?=
 =?utf-8?B?a1pISjgyeUdhNlgrS2JJUVg0eWJST2ErRkhYTWN4cGZSZy82SjM1d1hqTzdq?=
 =?utf-8?B?K2xaNmxGNVFJV3pBelRPZnNCZVd1d21XZ3pSREErbTZNcDl6WFdQT0xoVUJ3?=
 =?utf-8?B?Y0oycW8vTGdqVjZHeEg5UEN5ZTRxV3ZzYUczTE5XakFteXZjcDhnaDJqQW9C?=
 =?utf-8?B?Wkk4SyttZlVXOE9tWDRDSDRzb1JVSzVtZ2ZYOGxuN2QvY2YvS3p6WkJwZjlV?=
 =?utf-8?B?NllPb2lEQ1JYNGhFdDgrRlJPOFpmLzQwRFdiSDUybzZ1SldqREdoaWk5TlRt?=
 =?utf-8?B?RC9xWEdwRFFwdWtWWkkzeTg4VDJWRTFURWxtWUI4ZStVOGRrc1cvMHlpK0hC?=
 =?utf-8?B?L2dwUXBwWEpvUGNKMEJhYmpqMVEvSnE0OUh1YUJFSE11a29vbmxuUVByQ3cz?=
 =?utf-8?B?WDBhRmtPUmlGY1A5OVJ6Q01wUlNSTFk4QmU4eHMwWTA0d0Rybzh3TzVxTjd6?=
 =?utf-8?B?STFXb0RhYjV0SUltOU5pRElrc3BxMWROMksyYU10aWVxKzN0UjV6cFNhbHN2?=
 =?utf-8?B?U0cxTzVsSDkzY3NXVHFEMzFKN0UxR2hJQWc5Qy9Bdi9KdXowMmJXeG5UYnBv?=
 =?utf-8?B?OHBGcG5ZMmNKckJjMWJ4WFk4YjM0VE5oSGIySU5ZUGd5dVI5SCtnVjg5NWpN?=
 =?utf-8?B?TVZzMnFkZFkzeW9hNmgxWHAybU9vWVV0eUQ1MVVpSHY0bVhyMjMrU0d0VFVW?=
 =?utf-8?B?QXF5YlhQTnNaYVJ5Mi9uU3lJVXlIMkRzbEVmQnZWdWpubU1aVXVjMFBkaDBl?=
 =?utf-8?B?U0ROZFlLZVdmOUI1MHFJcHZPUkZxZDhmaHUycWZHNzQ4Y1Z6UkkxOGVBWldZ?=
 =?utf-8?B?OWhhTjYxQThtdlVhTEhhUHQyTmt6cmFmSkgrekN5MktoVThCSFN4b250eTdp?=
 =?utf-8?B?eHZQQnZtUDNmR0VaVzVXbXZBbWZiQjRMTzdjVW9HVG9HVW9Yd3RXNVlxc3VV?=
 =?utf-8?B?K2YrdjZvdUVEVVEwTG5YZ0NnVHFoZWpzdkVLYzVNV1FoRjhkV2dOSUg4ajRP?=
 =?utf-8?B?U0lxem9sQzkzNEVkaXlsV2MzdnM2bStCakgwbytoQU54aGgwdTRxYWFEYXE5?=
 =?utf-8?B?TjdnVXJSR2tkdXE4dmVkeDNtMG5pU0tQOXZTdmgxMU4vZXVjVnpaTThNZmhW?=
 =?utf-8?B?a3dPSUZweEdETzFPWHhtNzZNeEtqd0plQ0liM3o0bTNyV1BoQUdmcGpHcjlG?=
 =?utf-8?B?L3hxSUJERDhPQjRRMHNuczgwMTN1Tm1mbmh6ZSsyU2dsd1BONlFOL20xY2lB?=
 =?utf-8?B?cE03dFBYb2lCK3pTTWcydjZJSG1xUjRXZHVoUWEwZ0JMZkFzc2hyaUFzMFdz?=
 =?utf-8?B?bytKQVZYQVk2MGt6VUtiL2I2VmlzaW9rZVFFSUExdTF3MEtjSkhXL0JyT2Js?=
 =?utf-8?B?eURBT3IzNlJPOEtuVmMrS3JJM250ejVYcms2SDBRSG95bFZidlJPSTVWT09n?=
 =?utf-8?B?UXJpYXpORmF6TDRrQnJ6eXh4MlRnRUZCM20vMUF4TmI3RFZUWG1jL1Zlb2ky?=
 =?utf-8?B?bzk4ZVMxdENiZkhnNk9jd1QxZUtCcThPOC9yWTFSV3l3ZzBINGQ1RTBRL0dU?=
 =?utf-8?B?QkFzd1lHNmpuYXA0TEFaTStsQWlUNmVCSmoyRUJFZVhpVHNaMnZOK2NXNDYx?=
 =?utf-8?B?ZXpYcnFBd1dtekRyMmpsb2lzOTk1ZU5HbkoyMzFDejFkNExwa0phOTdsTE0z?=
 =?utf-8?B?U2JsK25aTU1NbU5HOTl2d0g1T242THhHUDlTY1pJOW80MVFEMkJZMDA0UE1Q?=
 =?utf-8?B?MHkvZ2ZGRFZRLzI0cEFjbENsR01oNXQvV3dzZk1ERTZLdXh2eXhCWWE1MU1Y?=
 =?utf-8?B?ckJpZGZzVldFOUN0cVZJZmpVWk1NMnd1cmdKa3g1R2w0VnRUOU81eDUxNFRG?=
 =?utf-8?B?WHdpUVdKZ2ZKM2VtTFpqd3NjRkk5UXRhNjlRZVBjcmxrMGQza2NCY0NCbWJm?=
 =?utf-8?B?OUh1WmNLYTZFVXJmNmZtNGk4U3pTT2xuQzNPMHE2SWdJK3VxWnlyVGoyVWhl?=
 =?utf-8?B?aEtUdUQrSEM0NFZiUkdDRWM1ekFrRkUrdWNtaEhzNjdRVk1WTjdialBpYklJ?=
 =?utf-8?B?R1REWFhpMWdRc3ozTkVITkpvUjRJOExEZVBaT3l4QWd6Y1haeEhRY2wvTkxr?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991adb83-c4b0-4ba7-092b-08de1c61768f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 11:50:06.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZerBF6MJEEw5YUL3YQmdXyAst60jSpgIbGYkR5Rcb1P/TGSH9LSFX4bYKSdk0mFNzo+wF4nu2fyeH9G1KY6tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5365
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Nov 2025 11:50:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20362

From: Jan Kiszka <jan.kiszka@siemens.com>

With trixie, -mbranch-protection=standard is auto-injected as compiler
flags. This breaks cross-building, though, because a small part of the
ltp code base is compiled natively, and the x86 toolchain does not
understand this arm64-specific switch.

Side-step the issue for now by disabling the branch hardening measure.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/ltp/files/debian/rules | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
index 06b90701..4e1747c8 100755
--- a/recipes-core/ltp/files/debian/rules
+++ b/recipes-core/ltp/files/debian/rules
@@ -1,5 +1,6 @@
 #!/usr/bin/make -f
 export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
+export DEB_BUILD_MAINT_OPTIONS=hardening=-branch
 
 LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
 
-- 
2.51.0

