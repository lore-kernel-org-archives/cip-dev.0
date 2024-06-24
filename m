Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E62C2BD05
	for <webhook@archiver.kernel.org>; Mon, 24 Jun 2024 06:13:19 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web10.134303.1719209589466734507
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Jun 2024 23:13:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FhushSIa;
 spf=pass (domain: siemens.com, ip: 40.107.21.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og0dzU5wfVpcQ52amCAFRBGq8x/mk30bLMP9WkLLHBbbPzM06D5YaAOFW1SWrU9Cj9OwRHfYAQ7xMfiis9A72N8UTZhbiy40ktuxipXLjWMJZst6VwG17+pmQSf4OCo7K6qGncPtCnZcVG0176DmIaFJActrB+zKOGtVAA/FrEV3GHR1dQJ2U//8RjZySVQmFXmh/0Gyng9w65mA2AbQDMcOlthL1LFvbSvRHQyCEaThcF4OR+qped9Z3t685e6riIlbazbwtKCDF5d2swFI+gU8KqBADVDXz/nbDTAEFt2P1tKRsBMccxSSkd/Y5bdG8690WglRUUZHC5hR0IKD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3BGHA1tLHM1Id++E0uJg39wnYQsOU/M3WW7i4Mul04=;
 b=lpWq+zG38MXItgF8HoGmOi6kwQX40WxQz6aJma9BZw19T45QrFvWSG/zBKTwFgdGE+DX7Q6N5WU9yXq8GcrBpGOYIetRyJ9MTQQNSm7pOeO5uBQB+4KgwuHNccqC9+XYppnjXX7Ms8qMgY3CkTz6YThxdXhcYLMfruT7y2drTgBqz6+DVinLRVgBO3ObNhBF+Oam2bgFvuWqfT5ctkkIqkLjAo+XtKVNsOIs1WP/neRgF+jdyki18KDZNdkuhMaoPzlKKAOmbZIPmADd53jLLHewTISXq0NXQjMYOLnqZJXaI5m1SMWneTt1t5Gn9X0c8X5i0NOHwKvJ57HdBAelww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3BGHA1tLHM1Id++E0uJg39wnYQsOU/M3WW7i4Mul04=;
 b=FhushSIaIF97aV+sJfpovec/maPTXZT2jjLtqZ0VhMHvCj23cOOqT/jZAXWeXOZmUQ1Xy5kEaY2chmPob+0bSLLY1Ox6u97tyV/eHCnyRbwgeBCf7RC1mdLPRAWIFjm9EWdy3RlaFna0d7YyAZk0BXGgZAEuhV2+kRcc+gL1ME0C7xQNv+xTnRWLsWcdK99WdtHYngSxWcGSoLFImA4CVVRKQhnvyEYV1irZyUvzd35IZ0y0dcn1U5mSwBLonOTbfoRvRZQN+q9A3h1Ds8owXIOGcOPq73hhYr/W0dafYfOuAvRUznf9RY6wwF+XNAYnj+N/QJZh0KME6luBi8BxYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3968.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 06:13:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 06:13:06 +0000
Message-ID: <80e94cb8-e6d5-4dde-822d-227617bf7997@siemens.com>
Date: Mon, 24 Jun 2024 08:12:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernel-config revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3968:EE_
X-MS-Office365-Filtering-Correlation-Id: 27372c78-f498-4ea1-7a60-08dc9414b672
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UUFIMGV2azdMWEFzMFBZOC8rVXZURkxDVnNNWEV2RGgyUkJLUFhUMG12dXlQ?=
 =?utf-8?B?Skw5T3J4VTQzWlEzdDNTWUxqUzJvYnRCN01DQ1lwZEdBOEVKbDJ5TG1JU25j?=
 =?utf-8?B?NFJzdWc0WjNhUmczVDVBK2k0VElsVjZYRXZDZGgwV2MzZWQvd0R5Z2xLbjN5?=
 =?utf-8?B?cS9CME52UU00US9GbTVsc1Q1SHNka1lUZ0dIMEJjRWJrZ2xrVVpzaGM0L0s5?=
 =?utf-8?B?cDFUV3ZlOEcxUFBod1FpY1ZMa3RmTkg1a1JZMTFncXM0Mkc0ZzZiUFRWcWdr?=
 =?utf-8?B?bGxFek9za25zR0duVUs3c1RuRDVsZHJDZ0tIWmRScnFOcWNoMy8xMFVEK3k4?=
 =?utf-8?B?Z2ZXbE9IZ09BNDdlZWpXR2FTdmV4di9ZZlhNSmJwUWpHQ3RuNUVrejVyK21p?=
 =?utf-8?B?SDN6T0xOQ2hsVnMvWlpKS3RtT3NWSVRraVBqZktmUFN4TmxqbTA1OVEzcmVh?=
 =?utf-8?B?MzVidEpKdSsvTGppNU8vcDh5eFNZMTJrbTk2dnV6aVAvd1QvNmRHYlRPTmxw?=
 =?utf-8?B?bzVBWmdvWkIrVkpuL1VJY3drOXRQQWRQOHJOK2lhb1JWdmljL1JBZjlWNHQ2?=
 =?utf-8?B?WVA1OWNHYVlwYTl2K0RDc2E3bU9CR0FDSU91Q1AvVEFYZ2FMM1kvaDBDY01W?=
 =?utf-8?B?WDN3YjZNT0RlNXYyT2hJQkU3Umc5ZHFoRkdxT3NRd0s3Y29wQlhvSTBZRnFt?=
 =?utf-8?B?TkpFbVdEOHc4V1k5anZOYXQ3NU0yYkJlYlREemYvK2hTLzg4YlAvRjhNZVdU?=
 =?utf-8?B?UlFpVDF0OERjNHZsaVh0OUczalhhamVOSmhBdCtsaWtlVjJ1NWdTN3RyVDBq?=
 =?utf-8?B?RVo2TThmNUpWT1RaKzV2U3g4enMzblNwU1pROFBOdnhrTWdSQU0zVWNsUGpv?=
 =?utf-8?B?ZUJHTjNzaFRTV3cwc3NXelZDeWRKdlVTakZOUFgrNzJ5Rnhta3E4c1B6WjIw?=
 =?utf-8?B?T0NhVVZVV2NMK3NTVzNvaFQvaVI5K0dvQmQwMjh2Q2FuVVhnTUpRc1Y4eUYr?=
 =?utf-8?B?Ly9VOW91NitIOEhQWVZ0WnNIcWtxK21vZWcyMGVSNUJjb2lDY2kwMGFIZjRH?=
 =?utf-8?B?NHN3VHZ6VDhqQXpQQys3U0hZVk42T1pYMGhJNzU1cTJJSk85bnNHOXhGZ3pr?=
 =?utf-8?B?Qm93ZllHa0NJUCsweGZaSkNRNHRRUjE0SkpCSHB3Z1dUYTRqVENHTi83alAx?=
 =?utf-8?B?RjdKV3dFb0hkVElJdk9qUlVaK2RmWFJxb2tqYlpDZDFObEo1NmJ6N1hiZ3d5?=
 =?utf-8?B?b2JhMWdmOXBIcHdIbFZTb0RzMTErLzByelA1N3FvbWxQUVVTczZnalQ1RDBt?=
 =?utf-8?B?S3g5NlM2RXNpZ09sbjYvMWFMeG1DU1R6bjByb0U3K04vck4xSDdLbTc4enEz?=
 =?utf-8?B?UWswTER5SmdzNFRZdXhDYnRQMFlDdUg3clZlcU01bjhST2UwdVRtL3JuVzgy?=
 =?utf-8?B?Mi9Dak9xSTllSi94U2lpaEFkOC9TQ2xkUzZadmozWVVNK2tDYTFNZnd0bjN3?=
 =?utf-8?B?c1pxUHpGWHhTcGdoVUxWVG81R0xtRnhtejBjT3NLOThvMnorNDMwaTlacnVK?=
 =?utf-8?B?YlVLdHZaYnBFeExuNVRRSHF5N1NEc3U5WmdneVRxbkV3VmlBZnlCOGlYY01C?=
 =?utf-8?B?VGJsOURkUW5iWkRhTjIzVWNqM05EMEsxLy84ZmVwRFBMbVJBRHAvSVByQ1Vi?=
 =?utf-8?B?TU9TREpEbCsvOHlUMG11bnpYTml4Qis4SlA2bTZteFJMRE1NdmQvb3JWVUxV?=
 =?utf-8?Q?0JQwAqgqIDtB1AzH/aBg2ZEfa07pjcwe1ib9S5S?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckNCY3JXVXltRjN6VkVXMFlqalN2dW1RK3V2RlZhSEMrVWxMQVErZCtlaGZV?=
 =?utf-8?B?WVZTeHBnckhpNDNML1RMQm9yY3dNUUJXZ1ZvQVJ4bVVlZWpaWkY4b05XWW80?=
 =?utf-8?B?R1FpOGxwSmJnZmQzcSt3UTJFV0lUSW1oRThRU3hWVzNRNmt3bXRYR2xCN3Fx?=
 =?utf-8?B?ckhFMlJvc1M0QmYyMStJWXRyZjVPLzBWNU1OZEYrL2JUcnpVdXF2ZG1ma013?=
 =?utf-8?B?VXZRN1NhMmZ2c2wwVEpWcEFSb3VUK1JYcDZaWjJvWWtoL2kreGsxOERGbUlm?=
 =?utf-8?B?dTZLSEhHUS8zUlpSZFFMRnp1bENCL04wVUcveGRld1ZtTFd4ZmlBaFc4dlQ5?=
 =?utf-8?B?eEhtaFF1T3E4UVI3NGRjVk5uT2lOUFZQMlZsOWRqQXoxckZDMmovRElkbHhs?=
 =?utf-8?B?Wk1oRG5LZmJPWXZmb01rUE5PSys5NVpIK3JmeXkwWFh3c2RySGllTlkrcmZ5?=
 =?utf-8?B?ODBQZ2xHYzVROHdnTUErR0g4RExLcmQraXlsMWxYZVA0VjNuc21sbXBYVGUx?=
 =?utf-8?B?OGF0eHR1WmxaVUxkK1doNzlOaUNJYzhXblA2Vk9SM1U3NklCQnB4TXlLb2t0?=
 =?utf-8?B?d3JFeGNJOUxkckxQTHoyZmYxNTVLNjdyaEFYRUZwTUc3TzF1TkVmRVNmaUFK?=
 =?utf-8?B?amt4bXg0NlRSUU5BZENrMGlTTGVwbTg4U2hDbEFyWENCOEdrNEwrVTMrOHZI?=
 =?utf-8?B?L2hNVEo4ejhrczE4RjJadXNNcmxUOW82ekFwa3RGWHlXOE9lYmljTFRhNkEw?=
 =?utf-8?B?U2ZzNVdBeWRJb3A0WnNMYW1rbGl3cnExOWhjY2NmZjAvMTMvWDNjaFREcnQ5?=
 =?utf-8?B?Q1BHWENNZkp4VEd1aWRHbHVmU29aZW9uRlJWR2NLODhJUERvVUNvVzUvdUND?=
 =?utf-8?B?S24wYUZlekZrT2xHVDdyS05idFBCTnZJSm1wNkZiWllDZlNsNllwUC9HbVIr?=
 =?utf-8?B?Z3g0ejNZK3k4V1AzWTlEazRPNlFKOURMVllOZFBpV3hCMVBQZ1JwbGZMV1Ba?=
 =?utf-8?B?dXhDd2R4Q0V6VVJNTUZzYkNRa1lnNGlNUHAvcitXMVVZdE5SeStSMDBXRVJy?=
 =?utf-8?B?YWhTNWYyYnpnQlU0dHFaZ2duMmxtbzJoZlpSR2FqUjg1bC9JSUEvbXNaVXRi?=
 =?utf-8?B?Y1VMelpIbmFkWVBEai9SaVFXMDBkT29CZHVYbUk5bStBMnMvcWVidmp0cTNp?=
 =?utf-8?B?QW4ycTRpZHR6RjQ4M25Cb0d2MnBIcGlUdnh4UU81NU0xR3h5S0VCbFV2M05z?=
 =?utf-8?B?Vy9pRDVGd1hPR04zUDBaWDlkTldUQytYQlhNSDRjdFUyMjFrNWs2RTNTRkhy?=
 =?utf-8?B?OWJVaFR5blQvUHNiT0Y2R3FzV2E3RFg1dWhCbVAwNzc5ekg0MVRCNWU3aFRr?=
 =?utf-8?B?bXQ2TCtNdmV0M041cThSWVJWVWNXRDNldEh1LzlXVWwvL0dQeDJQZlZmcDRq?=
 =?utf-8?B?SGxSQlJucW0zQW9VMTlIU2ZIVUxDdUg0NjZNb003UmZhanE3bjNNMkhWWW1R?=
 =?utf-8?B?MVZtaU0xL3A5dUZXSEVKaFU4aUpDbGdzS1N1UDJNaUJhZGs1L0dwN1lVZFVD?=
 =?utf-8?B?azhvUlAyWFR4cHUrN21SOGdDbU9Ha2VoZ0lJb0dFNFVibGdrajFDV0tnYmRO?=
 =?utf-8?B?ZTRsTFpHck1VV0dpeVoyL1o4YTk4cnk1MjVNQTljZzJXSllzL2R6bVZTY2ha?=
 =?utf-8?B?OFRTNjBHcmFkemNibDJNQVVkOFhxaC9OdUJycWw0ZEhvR2ZqdGcvMkVXK2J4?=
 =?utf-8?B?dEhOUGtuNk0xcDlPU1FueHBjZkh0ZXFMcnZoNHJGMGtSQnRXa1QwdW1UeGs3?=
 =?utf-8?B?VkxVWVQ4dndVYVVUOXR2VVU4K24vUGNUZHNnVU1yczZvbUhIRkordWxVdHJh?=
 =?utf-8?B?eTFla2NjN0hHZ3hHQ0Jvbnl4cG80RjBMUGxsb3QxNnJ3SnlidHc1cTZNNmpn?=
 =?utf-8?B?QURJYnYrOWh5a0NuOE95MnRySVIyWUpmelJ1bk5ESTk4Vmp4S0pGTUtIVTlO?=
 =?utf-8?B?aTRsUmFDRXc1Snp0TzB2bTllRS82Tm5IcXhTdU5JU3NNVDNBTHFRelpCN1p2?=
 =?utf-8?B?cXI5dDVjSDVHNVRwcXM1UGVSTlBIcEZoZzdTOGNscjYyRDQ4alNRQTBFRkR4?=
 =?utf-8?Q?3rEQYppKcvOa8hUw9575B8oxe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27372c78-f498-4ea1-7a60-08dc9414b672
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 06:13:06.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMBqHmMqg60Jp4cuSJMftXdRwZNJvLFfXB88yVWR3MI0mtrD/X/FDqW6+8ieoz1HWt9/zueyDvacEkAF7aHVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3968
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Jun 2024 06:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16319

From: Jan Kiszka <jan.kiszka@siemens.com>

This only makes the WDAT watchdog built-in to support its usage already
during cip-core initramfs execution which does not include watchdog
driver modules.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 1656728a..9c1ab946 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,6 +14,6 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "93b9ba271c14556a24b3f8392d10a8647b496f1f"
+SRCREV_cip-kernel-config ?= "f6b7018cb6845f34f8a03c126bf4f823ce10d637"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
-- 
2.43.0

