Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3701C87FD2
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:18:56 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.3])
 by mx.groups.io with SMTP id smtpd.web11.48876.1754921934947281385
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Aug 2025 07:18:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GcsnZIPF;
 spf=pass (domain: siemens.com, ip: 52.101.69.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiyDRfHVBKZ4EhRGXKaIXtTXgezSYLeC8lGODXQVDDJI7llbQ/lxcB65FUA4FdT2tOj/zFnzIlqLe+qozIQbif5tBd0pHsbjjOXGrM2h7fz/OYNafM6hWNo12j+yqvN1zT5iarMgrcVMTFiGrj2GYAq4/3M4nj0N1pzLqHqa+BZTRtmQg3UeN4kWcf2hgUsmWFcZCmY+b9lp9TQBH1U/ZqrUWb0RbQBGC2QfXEiwbVd40A/ZXBCrdp7+Hg1FhglG26diLwlcS95Wg2aPzIvDh2q5hQQtldT0X2EVI1OUgRjIk0RsS+t/UrSnoLl/Un/KGP0m0tww2GdDR6vRMyhoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYj9Wy3yPAQbqBIVLD70C7PhsEbTZ7AyoEvrFEvDZcc=;
 b=bsFwJ1KoSkeelFMnro3ymbec7xglH3mxLOphVRWaqxXd5oda69wEfFGgZCtaTBeGVwOW8nZOvuxFjAvQkLrn4d2M9Manu61gjnVa5nfDqU8cl1dKi3a8jf6xUc8ZTcd26pSv6sGT6R0QLkm8iqxL/dafxHvOggNns54Pfy+/ZbfruYJNgvQMrucpuZTUUAXEJL8EHeVyZRrEx8xGNcADnWuBC9+d1zVdFEvTlkO149IQhkFqVOEdizIgIqnp6tdjUPPiXbi0qyINjd2cPTbk42WRrM6WRBZzLjDAGKqkRRfz+/JjMWLsFp9TwDjSyZSUiaSV07/5xYveYzTZwMrL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYj9Wy3yPAQbqBIVLD70C7PhsEbTZ7AyoEvrFEvDZcc=;
 b=GcsnZIPFJVp3pXGMOpSbv8HgvpVqhUcxzMTEaGGWes+IerfWglQhMgzqZk42miYotRBytL0VdX/Z+LQl4Ct5laxsMNHqJ3PKO6XGYmOlLA29R9kuuMNYL68yy6lgq0qsSJbOTiWplNyXCABZrlAfgDzPBjR3OJtli3GCg1T/bMRJ5gRGW3Qv0IjV65ynvco7LaLs4rx66CIVSOCjlwzlrgpxSlzu3WVqjrQaXM4PtKhd7AbBzCnxEezLclhP0GvZOFSoBeWd50ardtT+n9V8YVt2IoOd4t/tcM/nBeh07h004s0FNPGkfVxOftONm/q7T58RXTD30Kc2jBA1y8hurg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:18:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:18:51 +0000
Message-ID: <49adaab5-7e9c-442b-8f29-6fa43a3ff103@siemens.com>
Date: Mon, 11 Aug 2025 16:18:51 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Kconfig: trixie is released
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 280f5675-d17f-442a-c401-08ddd8e1ff38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RjBacDQ4ZDF5R005WG5aUTErbkZGb043cDE3MTlSbE5kVmxsUVVlR3Q4WHRU?=
 =?utf-8?B?SFFTRTIzbG54ZWJ5SmNGdVlUZDM2ZkpMYm14QWVTTUFUR21KeG1XcFdCazRj?=
 =?utf-8?B?L1dkSzBsejVncmt4Q2FDTE5yb2QvSHZ4dnVpS1Bxa01McDhub2xOWHNRTFJk?=
 =?utf-8?B?R3ZIcGJ3aTBvQ2Q0THloTGVZWUpYUnR3MHladjZzK0FnVUJLbm5JeXJjWlJY?=
 =?utf-8?B?VFJBbjYxS0lPUm00TW13OUtkZys3bnFTN3owNW5ublg1U0xvSW53V29qYnAx?=
 =?utf-8?B?a2hLaUF0RUo5QlphVVBIQ0pzVUx3all3Y1NmVkVOVGFYUksvVkRVcUZQenhN?=
 =?utf-8?B?bVN1cmZRemViSExaTkNzTEc1WUgyT0xoV1RXemwwSGcvZ1QyWWxNb3BObERW?=
 =?utf-8?B?dEpBQ3RkaFliZW1VVmFUMHkrdXFaOFVILy9PQWVlS0lrdlQvazZwMDFFTjZw?=
 =?utf-8?B?ME92di9RZjhDWGY5WFN0aFc1cVBaaWJyMGIrSS9xTW9PWmhiQVRWNDlDbmtm?=
 =?utf-8?B?WGR6VXFkR2dhRWVCTlNFZGxWTE1VZzUyTUxBZXNoSjdRamdQT1pHOWcvSGhx?=
 =?utf-8?B?aDR3L2E4NUhmUFo1bU5PRFkwb0ltYVRQV0ZxV0VybE9temZYcXROWEorYWUv?=
 =?utf-8?B?bllGR2pucTUzWkJENWxXQjZzbGhHdzQwZUl1bnZscjF6U1N3REFQKzRBWUpk?=
 =?utf-8?B?YkNMM1dDU3dJNDd2SnNIVHlUWGthWFF6cGw0TDkybGdEMVVuc0ZwY0V6S1Aw?=
 =?utf-8?B?Y0doZ2JDcFM5ZXJURWFFNFp4Vm10TGN4Z3plS2ZnYnhoZmxIRXBtNXZPL0pS?=
 =?utf-8?B?b0NyZGxCRStEa243UlJPZGowbVpBODg1QlRKL1p6RUlhWEpDc1JUT1QzTGRt?=
 =?utf-8?B?Z1RoUHFla0pkWlhWT0RCUTdQcEQzSlRQUi9kdWl2M1d0UjlwaFp4dUVrMFBH?=
 =?utf-8?B?OE1VSVVXd3VnRllVeXlVOGI3MWZZQ2NWQjJUZFlWVktMWnNpaTNKbGZOVGdN?=
 =?utf-8?B?VlhMOGZpNCswMVhwZUoxbGVMVzYvN21kRG9qcmJqVnRRbW5HZ25CZjdzdVRB?=
 =?utf-8?B?anJlY3FmR1U0eGEvb1c4QmhiZVNCL09OS2NwRDhNSm5tSGxFUTdoRGx5Z21C?=
 =?utf-8?B?VGE2SkFhUkh1WW5SN2t5RHBlMmllMjBjUXpja28wV1Zlam1VNmJ5Sm84cVl4?=
 =?utf-8?B?ZllXQlgvY3pWSzcrdSsyZ0xwTVMrRExJakVvTDYvQ3ZZd01jU2tIY1Z5ajZO?=
 =?utf-8?B?RERkTWVzUkYxZ1ozd0RVT1pIZW9KTEFLWWVHdlJTVWNmdTBrUDVhU0JRUSts?=
 =?utf-8?B?NlJsRmFZTUpOak1uV1M1bGJ2WVpQdlkxUFNyMXAyVi8xZThLWkZiN3ptOW5h?=
 =?utf-8?B?N255UTZ1TDd4NHBiZFgxMW52dVVDQStnSUVSTnNzUzA5RlA1VTFmWG1CQW0z?=
 =?utf-8?B?Uk1jTjIvdXRKcGFXNzAybG5MRTljSU1Eak1kMEd2eDhZcFZXYytKZDFVN0hu?=
 =?utf-8?B?bXBOMzk5YnY4V0Yya3I5ckZwSzhBNGhveDF3MmpnY3dVYnNUdmpGMXZrdXpZ?=
 =?utf-8?B?cW5oT1diUmR4alJ3dWUyZzBOZEhDWW02Nm8vNWdTMDFGL3ZGWXBWbzBqeERa?=
 =?utf-8?B?blFqV3NTMmQwbEJLS29pd1MzbWw5QUtiNEdWZFRDTFl2elBtellCWnZJdDhO?=
 =?utf-8?B?c0lxTTJPQ1M2RTg0NnpIMklqQ25UenIxeXRrNUVuZkZlajg2eC84LzBnUTNU?=
 =?utf-8?B?a3RoWGIxT3FTdkJaN3AwZXVkRTJoTmhuVTFyeUI0VXB6RWVzdUlRV1FzT3V4?=
 =?utf-8?B?cFVCVzhRSnRUSlZJMHhOVDM1Q2N1UVdtNDhPUVh6ODJiNnAyNTZKMDVjWGlZ?=
 =?utf-8?B?VGlEeEVERE1oUVdBK1MrWW1JTVhUdWVBK2ZXUHpkbUhld0RDcUgxM3k2RWh2?=
 =?utf-8?Q?efJEZ0QULsc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHEvSytwRSsxU0xycGQ1aFdsVitDaEJDQUF0Q2I0dGFQWFZGMVJsbndlTlNo?=
 =?utf-8?B?VE5BU1ZPbG56V1JpYytJY2N0RG1pbnQxQ05RL2Y0cGJCS1dTWGg2SWRNRCtK?=
 =?utf-8?B?UEpPcTdCMlN4dUUzVHVvSTQwcmRwOHpwd2R6Tys1Y05RTHJ2Ull6eXpabkFj?=
 =?utf-8?B?YzR0SUtqUFpza2p5MmI3SmM2b2lQQkxZNVFqY2lIR1hzQ3U4RWtFTi8rdnkv?=
 =?utf-8?B?V3NuSjJoSnh2RUdwM3JuNzhveUhobHNtSmJ0N25pRkNia2Q4dUs5YVRaNGJv?=
 =?utf-8?B?OXVUWkgxM0xOVWlYVXVIdTVUdU9VNTY5eWpodTJNMUZzMmw4SDZidDVBZmRj?=
 =?utf-8?B?R0tNU290Yk1VdTFxVlhJUjNrVklKTWpqa0Via3AwRnpROVBIR3ovdk02ZWwy?=
 =?utf-8?B?VEZmM1MwalRTeE1zSG5JdWwzTG91RmZNVldkMzBvL0R6WUw5R3doSWtndjVP?=
 =?utf-8?B?MmRZV1JYTnJwaysrNThqNTVhRStvcytlMGN2dlRhTlByc3J6M09Ba0RTQTlv?=
 =?utf-8?B?bDVtNWU4RHIyUll2cFhkWWN4cVpSb2lkWFhwc3VPRlo2SHk3cm9idEhHVUpq?=
 =?utf-8?B?a200UjB5eVE4MmdxZ2k0NDlsRS85RVV0WmRyMjIva2VoN2N0a1Q3NUs5Mnh6?=
 =?utf-8?B?R1lLQXR2V2xKWHlQQkcwWmJVK2JaRnYwcFBXRDBoSW9tSXZCUDBtZm1tRFFN?=
 =?utf-8?B?THVSMTZ6YXhpK1ptc0J3d3VoSncvYlpFODNoMDVVVFlPajVlbHErbG5aalBa?=
 =?utf-8?B?YTZKbnJaN004YUJISzNvSCtUL3FwOGo0V1hhbnV1UGZ3bklwdmxtNHlwOXV4?=
 =?utf-8?B?M09LdnU3SFJrOWtHOHRpNTd4aWxQOWUwUE1nR3NJK3VLZ2pZTlg4Y1RDRHJ2?=
 =?utf-8?B?Qk9yYm5xNW5hc1NwRGpiTFEwUEordlczK2JDTUZHY1BQTmxQeExLdi9VOHJN?=
 =?utf-8?B?N2x1NnQrNmRYRmprMHZmSGFIT1NuSmdXQ2pjTnBHejh4TTRoRW4rMCt4S01M?=
 =?utf-8?B?QlJhWC80NjAvam1ySnJRVDJRQW5ubHFobytyM0tnNW5rN0JsYlR2NHZzT09m?=
 =?utf-8?B?cG5KRDVzZDkwQjdUV1AyV3pvRkZCOWV2c3h1VW1KbkNZUytTQkg0UzQ3Mi9o?=
 =?utf-8?B?blZkT1RoZVBpV1hha3ZvaG9KeGlIbDI2ZCt0SzhVUTVvMWZ2Q3ZENVpLWXBw?=
 =?utf-8?B?akNvU0pNdnRBWWl3UEVPVDJqdU02SXQ4ZVZQcXZhUTRGSDhwUzczSGhmTTk5?=
 =?utf-8?B?M2JFWjFydm5uYnR5cE96cGlZZHlPYmVJZ0QzaTIwZWUya0JheDdkc1JQNHZh?=
 =?utf-8?B?b1Nrb3F1aWVmSklGbGJBMzJEOWNEZDQzeVFEVlUyUzd6Tk9sVStwSzFGTUtn?=
 =?utf-8?B?aWFzUzZZd2JTTW5pWWtVMzhEWGFvSGN1VXdORDNCTWNJTlNnZjdQa1g4ZXRv?=
 =?utf-8?B?aHR3WExIdUlSd0lDOGNnOUVDc0llRGNueFh5MU1CbmIxUEg0ZUFWWmxyNm9l?=
 =?utf-8?B?d3ZNSjZOY0pUb3l0aFNsSVNqSlo2MzJ6MXFwNlY2ZFZJb2JHUlFQMU5sWmIx?=
 =?utf-8?B?Y2lFeXVnWFVqMTJrN1lMczNYdlpycHdtRVNlTkRpNGtvTE1qSlRIQm5NekFQ?=
 =?utf-8?B?SGtoVWJuR2xzNklodnhxREJHQWtuc1hucDYvN0hjZU5aVmEyWjgyei9NYzRY?=
 =?utf-8?B?U1FPUjdyamNQV0tONERTTFVFZmhuajJML3ZlbEs4VXpmamNXQll1R21BcStG?=
 =?utf-8?B?SmJMNHZDbWNmRFhsR1JWblpZM0pmZUxobGVkandzeFJWNEpJNVQzNTVPL2l5?=
 =?utf-8?B?Q0tPb2hpOVBxczAvS1BWMjBtOEpVWWRoZldwY09NUmZ4Tkp6ZElrQnlqRTFD?=
 =?utf-8?B?cmdpSEZFVS9HQ3Z6VGpCaFBpaEt6UUE3blU3YmF1NXMwVmhBMk52UldJa1ZJ?=
 =?utf-8?B?eUxkWkhtanFBUEF6TW5uQ0lja0RZUW1JMW9GaFpYTyt1YTdCbEdMMFVqeGRX?=
 =?utf-8?B?V0VUbVRxbkRLeS9tcHR2VS9LV1E3TG5mN1hxMGRYemlMZnRYMmpOY3ZpOE0r?=
 =?utf-8?B?R2lXSmVoME03WEc0UUpkS1JwQVVTUXdTQVJDVWJMV2l1ZlRFU3hzd3ZtZ0VC?=
 =?utf-8?B?aTJTckt0Wk1pSW1LK01OanJhbnlwV3VSVjNXTTltQ3hqZTY4ZVNVbFRKL2hO?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280f5675-d17f-442a-c401-08ddd8e1ff38
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:18:51.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9OyuNhnivfnUVKMAtmhlTaxHbnATrzGwuLsbKo13NyeGB4jG5Wa7AykTkgaEKWtKVuf8DHINW5YxmkKBid2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Aug 2025 14:18:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19717

From: Jan Kiszka <jan.kiszka@siemens.com>

...thus no longer "testing". Keep defaults until we are confident about
the stability of isar-cip-core for that release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 3196b91a..3ba61319 100644
--- a/Kconfig
+++ b/Kconfig
@@ -171,7 +171,7 @@ config DEBIAN_BOOKWORM
 	depends on !ARCH_RISCV64
 
 config DEBIAN_TRIXIE
-	bool "trixie (testing)"
+	bool "trixie (13)"
 
 endchoice
 
-- 
2.43.0

