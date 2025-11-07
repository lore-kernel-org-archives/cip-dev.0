Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E733CCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 17:27:54 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4754.1762536464331551529
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 09:27:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WaiMVHNR;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMwKsOtKMCC066uyWQQ1hRyd0ZR0GVFA3xh4LTjwKadZ4f/YGhVN8fUhzWr5UGuvCCO2Dkjl13jVHj25Yan14xEx5Xhq27NTNbQeOxqxnljhh2Rur0SDWe3UK6hOQl2LXLu5DVGXKiMuyZVvvl0JvgUUhRHsh33tLxDMqWEogKdL/SN1g1xe9Ow84FVPr/Sp0jYUaz6YpLMR6n/2CNzVeiQ/Gvxjq+92L6Q1N5Y9V4sdTlm8p5AocImi9tyWz1LTbTMbOAGkT4g3iRv0cx2Vl7ZcuCdujWcd9Qia4uxer+CvHffTU28dEs+ur4aU0rqDtCGGWkzVL7AUwgPRYnbSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDrBTqhQ9+nij6MgZ6lmPN6CZCM4lwbROG9X4oHjoSA=;
 b=U9T6EL19dhwXCcSd9Q5xta7byVFrTIW+TgZZFT6SmAg1WVJ4ohe6SRUBpCX9sHGBCNOSVxNUV/GxH5y+/On+r88f2a9YR0xSTqVpDfBwH2j6A2ZXIULOKavz+L9WZF8pXSrfv33LtsD/KLAcX9Zslge1hmLQRksfUy291l6jYD8xwWbpTXRllCqytrZILcL6P+Vw73sdHmObOjT6KpKYXfXGgwF9ngSoP2HF1sreWD5iu/DThfupMeziheOuDQ/OrP17wawc2MfuN8pkzBHCCut+s50FCVJoQGnWHdnhRR0USRmXghbdZgCda4ZRxPtRW5QHNEsiw8B7IjLSG6o75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDrBTqhQ9+nij6MgZ6lmPN6CZCM4lwbROG9X4oHjoSA=;
 b=WaiMVHNRIpCuYGGVsqd4kqGKF3EAN3dpnpyuKTHEYCE4BUF0xYNLBu/+8/0z65OGEb+8bEfY8pTbO+vYDd0GVPvdSN/gat77RqbN1jovv2BRKYgeKcWpNvpL/C+NCorRjONyqmrHY7eXAaAAumdnS5X2C/KXHYMBaHXrPnNnALU51JmiIqNrCD7iivVzVYUt9UtKuwQtVeNqLHwpIu/2rmD9oR06eKGawW3NXRtaILTLMHI82w5pR83JL0+L79x3e4B0HEoCRpAFaZFDwu0hi0evt58ZzLR4tcrzqsm1q68XN/b5xmJU+HIjIZdkmcFMe3CEQuZBiROEG+gkt2HoAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB3993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 17:27:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Fri, 7 Nov 2025
 17:27:41 +0000
Message-ID: <520a2818-a027-4f9e-94ba-cf263e29065b@siemens.com>
Date: Fri, 7 Nov 2025 18:27:40 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] start-qemu: Detect unknown Debian releases or
 architectures
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB3993:EE_
X-MS-Office365-Filtering-Correlation-Id: a9205833-f1a2-4a34-60f5-08de1e22f42d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K0IvRUFhcUdHeFFrdVAvMi81VWhXWEdMaHpqQUIyVVBVT3ZMR2lURmdwMzRW?=
 =?utf-8?B?RFE1VTBWdDJxSTZNTVlNRVBqRG1lUkM4cXNaQVhCaUs4YVZSb0tLNzBxVUtX?=
 =?utf-8?B?U3phWmx4UWYyS2pMV0FzQ2NYeHppYkJKZTFqcEZTSVBFaysvUVBqcytpd1JQ?=
 =?utf-8?B?NDRJaW1DcnZQdk9ia3pOSzROTFZSQmVmYlp2THF3M3pBRThremZ3Zld3VDhU?=
 =?utf-8?B?TFo1YWNmbituL1JNZ2VVL0I0M3VWSHA1UmtQSXdyK3RSWlhWYkdOZjFRdlo1?=
 =?utf-8?B?cHgrZTJmRVlMbldjbzhZRjNySWZ1d1RHTjhaN1pJZFJRVnVZTmtaSENscnJm?=
 =?utf-8?B?TTE2Q0dqRTUvUW8rRWRmTFRnM21iWVh5L3kydlVoeWNPRSsvR3JNWm1scDAx?=
 =?utf-8?B?aUpMczNPMjBmbEJrTG0yUDZqbWFtUFFRaWRYNmVhNjBTTlF4MnhFblZiNUlk?=
 =?utf-8?B?MnlTS0hBaEZmcTIwaTU0dE5ST1JRV3BPWjhzUXpXcUxtK1VlSUVhY1A5U0Vu?=
 =?utf-8?B?eWZweXZDbGMxZ0Z1WGl4ZGppWjRPNzZCUHFDSjM1ZnMrdWY3WUxHZEd3RGZq?=
 =?utf-8?B?QlVxZTQyV284bjhJdW1YQjhlTzFFZnFlUWdsc3BKeXpiQXlqT1RTZnEzZWxM?=
 =?utf-8?B?anlFbHVUOGxvNlZGWjBORHYwcFR2djBxNVhvdyt1UlJPWDJvQndJN1BVQTVo?=
 =?utf-8?B?c2FZbDFhOVNpeVVpaVpXOWIrOG1uS0lGSzVnUDNnN2Z0SlR5RTBuT0hDNmUz?=
 =?utf-8?B?MklWT21CWEdsanZFYUJoZjR6ZVhzMHNCb25MRlBvT0pOQnNBRXdtaHdMZDZx?=
 =?utf-8?B?OGU5S1h4dzVETjhkTFlSNUZxdkdQdS93TWk3WUNrZStPRHVYV0pNZlBOU3Rt?=
 =?utf-8?B?THNpek5xb0FBcjMzZVM1ZThaT0VpN3BJcWRlRk1Kbit3bGoxcTQvSXU3dVc5?=
 =?utf-8?B?Z3A5TlFFWS9vOWNTdzhqTnJXR2doc0p4YVJKS2hoSk4xYnF0UXlKQnl6SFRF?=
 =?utf-8?B?NGFzVFlCdjVlZERnbjZGUVo3SGo4Kzg1MnV5WG9NTVJNWDhodmdCRUtpelEr?=
 =?utf-8?B?VEpBRWZieEFNakV5aFQxcFE5cXRMc2pzMzMzbW5aZGdYU3JldGRrUVdueWhh?=
 =?utf-8?B?SDFvK292Tm8vRnFLSWplSWtXTjFzT1krTFZQM1luWTVqYm9MVjlBUlFuZU9T?=
 =?utf-8?B?TkF6UGd6UGlaU25wK09pVDNPRUVHNldnM0REaWRXREk5WUhvUzZBVTEvUFMv?=
 =?utf-8?B?ektqOFZQaHAzMEtmRnpHL1VQNlhtMWtldmJGaDRpaFF5ekwwVUhvZllWWTRH?=
 =?utf-8?B?SUJEVmtmOXdHYjdISEIxRkIrSUZmYmhTRnNQRHF3ZHY5bVBqMHNodmFDR290?=
 =?utf-8?B?OVUrcnhVcno2eFp4L2xOMENBL2g4NWZ3bmpETWFPWEZITFZYRDdEUU5SQUsx?=
 =?utf-8?B?dUJmcU1oTUlRZkxYMDdVNFEzNWE5Yjcxam55MHVFL2I3YzFxL0Z6d3ZwWG56?=
 =?utf-8?B?dmJLb0IzZDNJaktKcHJldnhEWUJpV0RsWjhtQ1ZkYnV1eW4zckJGalA1THoy?=
 =?utf-8?B?L1BaRFM0cFJhd1I1Tm9NQnhCT2Q4WTErUDNmdzRTMTd4blErT1dxSlRYblBu?=
 =?utf-8?B?MXRDUkhFWDBzM1lTVWJPdXFrWXRCaDVCRThKN1A5R0hrQkVsVC9MUDduemxl?=
 =?utf-8?B?b0UzeDFYZVhHZmFjdTFKdmw4K2RCdGhTZk5OQUJFaWozNFZRR0FQZkRZTkdO?=
 =?utf-8?B?bi9sMXU2eVh4NlJBSWQxVUwvalVvSGRRTHpnbVhIWlljRW9WSEEyQnN6VVYx?=
 =?utf-8?B?OTVvS1FOQjlVYmZnemY0VzZTU1JuVmNCWXJZaFNoOXNDSk1lQjQ2THBUUjVH?=
 =?utf-8?B?aWxuRWVIbTUxUWFzUThjVWhWRXNHZVJaa25lOHFEbmF6UUMzcmNZRDNuOEY0?=
 =?utf-8?Q?rx+vXyf0ff8rZXSEA20/Dem9lz4eIT1y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWxXcTFuUzc5bHBDT1E0dGdZRmwrZkg2Yk5UNkVMSzA0WXp0OFBMOWUxTVI5?=
 =?utf-8?B?eFJOWTlyRUdXZWUrWFloTU9yZzkwVlVSTEdnZGhhd2FibGk4ekVsWnVEMHVt?=
 =?utf-8?B?WTkwOE1XV3g5bkJrSDczbnVjUFFHYVN5SjBuWEtXbnlubkRWTGlPUTlKT2U3?=
 =?utf-8?B?QmRSTm5sWjJGVG9mb2pJdndwa0l4aWJESVhZb0dtdGpNTmV1OStIWkx4WTR3?=
 =?utf-8?B?aFNOYXFzV0UrbDFmc2dQRmpPOWE4VVd3YWFMMEw3ZmE1VlRXY242d2NWczBi?=
 =?utf-8?B?NVQwMmREVUN2WmRYODRJQ0UrbHJYRXljRVRQZHZSSjdXTFZBeFFIa1QyOGMy?=
 =?utf-8?B?Q1JWOWNmKzhXN1VxOTd3SkNHbjdBL1VrNlVjeVp2by9xQ3hDd0hreU5HSXlj?=
 =?utf-8?B?QnJ3VThQT1RuRzlPbTNIQkJoZjlpajdsTG5yNnltWmhkVzUwRGt1YTZoa0kw?=
 =?utf-8?B?YnZMVWtMWXBReFZhL1gycEZsNm5BVHJEQzZTODdqdDd1N2RjclFFbEczTWdi?=
 =?utf-8?B?WWFVZ2VSdlFyNEc5a1JZWXk5YWNldnBneStLWDFWNTI1cGVuZEs3dmlTTzQ0?=
 =?utf-8?B?UnRLOFdQR2JkR3B5VFF5ZFZpazRVcXJpcTNPdUtiWjZ5ckdNdWpGTEpMRFIw?=
 =?utf-8?B?Sk1uYThqUCtUZzQ1N3M2RWtCU2NBQnh2L3I2bHdkNFJwL0NzaUQ2OHRNTkdB?=
 =?utf-8?B?OGN6SmR0b0ZxS1k4ZGVTb2NzR3dxZE1zTHhDVFdnVk50Nlc2cWF4Qmc1bmk5?=
 =?utf-8?B?OG93cjljZ0JDbzdVbFpJcFNoRVFmdE5SMmcrbXM0TlpIZlg2N2thMmNMQlBO?=
 =?utf-8?B?WlZVdTkrelQ5dldZMWZJQ09yRis1L0I3N2xwNzQ4YStSdHlhV3BhcmlsRncy?=
 =?utf-8?B?d20ramxvbWkzcVVUTDJrY0ZweVNqZ2Q3ZXYwRW11S1FZckhRaS9hS1VhZ0l2?=
 =?utf-8?B?TFRQZytsTmxHNUIwTUhHUG5haTNrazh4WGMvbVNXKzZwS004N0JHZGlhZzdr?=
 =?utf-8?B?QnN2OGdTWVptbUdsU1hvUFZlL055Y0ZkcmtxdTViWjE3ejl2ZkU2azlHNXM0?=
 =?utf-8?B?WGQ4SUhaSjh4Mm9KNnlkZm5rWXlqTVBOU2EzSlJyYWVkdjNkeGhTc3NSaldW?=
 =?utf-8?B?d0w4UVlvS1M0amkreTJmOWJMQXIxQ01jWHRvYXdYWURaQkNlVmI4NWNsV2VL?=
 =?utf-8?B?UzdsOTFHUjUxSDY1V3A1bENINEdlODJEcEd5YzBGNG9IUVViTkIzYW9kdENK?=
 =?utf-8?B?L2MzOWRNZ3o4RUMzajQyVlVBVWRtUzArSkZSS1Q5OURkR0wxU1lmSi92Zlg5?=
 =?utf-8?B?TUN0Sk8zcFhrd2lzcmtaYmkrQXY1VjJaN1NEeDlJSlhyTmRUc2xQMkxyeHFw?=
 =?utf-8?B?MnAvN29WM3lTL3N5QjFIZktpc3RieXZyNmsrVFYyS3k2RGlZbzNSMXNGT3cw?=
 =?utf-8?B?MjZrTVNZZXdNUE5NVlY2VnJScVFGNm12Tit3WXVKRWtxdk5Za01mcTY4cFlo?=
 =?utf-8?B?LzZFcXJUamRsajZvVUwvTE5tZmN5NXF5dUJBc2hUMVA4cGZBc2QrcVJSZFNi?=
 =?utf-8?B?YU04OWhVNTBiVEY4OUdwTDdsMWVkdW5GTkFYR25Ld3p1eUJjZlllajNpYVRG?=
 =?utf-8?B?RW1DQTdSZlE1cy9VRGlTbkgra2cwK2VhbGdPRkVRSHVRQ1J0THZDV2ZFMVIz?=
 =?utf-8?B?QjZqMURzSk83Qk9BdUdrQndvaUFCRG4yWHRuN2pnOFNjZGdrdTh6Y1FVUkNX?=
 =?utf-8?B?YkYveUVJTzRKQkl6WUVrc2I3aWZMQlZBeXd4ZkVsMWNwWGVEbWcxbzlEbmNJ?=
 =?utf-8?B?d2toZEhKUmtJbnIvMFkrL2RsQld6blR0RG1HY29WWWxoRFRGTjZCaHcveXdK?=
 =?utf-8?B?WDFkODZyUXpHamh2L0lFbUs1NmdHOFdJdUdRUHR1MlIycmEyT3ZMVFlsQ01C?=
 =?utf-8?B?YVhjeGxIREFGTGxaL0NFbmcrR3hOSGIvRHZQeVFMejQ3ekc1bmxTSWNZc1dq?=
 =?utf-8?B?UE9wTVZvWlY4WHB3RUlJN29Ldm9qYXNoVHltaTZzNXVlTXpxZThVeG1yOFBy?=
 =?utf-8?B?RlVUSDJCd3JHNUNvYnYzODlubFpudzlEejlMVk5rZWlmMk1RUTVkU1NEQzdW?=
 =?utf-8?Q?0SWXXVEfnLbRTdRWbzpr76qHk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9205833-f1a2-4a34-60f5-08de1e22f42d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 17:27:41.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UH9B4j72hSC3rtSGs2SxB1vd5p9c6Ds7Q8GlFTrW26tgSBqDamZpOHguWgTbH5pYVWywrAANz2Y34Hny8OWhvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3993
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 17:27:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20474

From: Jan Kiszka <jan.kiszka@siemens.com>

Just to make the script more robust against configuration issues.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 2426c986..0eb306ac 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -39,12 +39,15 @@ fi
 if [ -z "${DISTRO_RELEASE}" ]; then
 	if grep -s -q "DEBIAN_BUSTER: true" .config.yaml; then
 		DISTRO_RELEASE="buster"
+	elif grep -s -q "DEBIAN_BULLSEYE: true" .config.yaml; then
+		DISTRO_RELEASE="bullseye"
 	elif grep -s -q "DEBIAN_BOOKWORM: true" .config.yaml; then
 		DISTRO_RELEASE="bookworm"
 	elif grep -s -q "DEBIAN_TRIXIE: true" .config.yaml; then
 		DISTRO_RELEASE="trixie"
 	else
-		DISTRO_RELEASE="bullseye"
+		echo "No supported Debian release configured"
+		exit 1
 	fi
 fi
 
@@ -71,6 +74,9 @@ else
 		arch=arm
 	elif grep -s -q "TARGET_QEMU_RISCV64: true" .config.yaml; then
 		arch=riscv64
+	else
+		echo "No supported architecture configured"
+		exit 1
 	fi
 fi
 
-- 
2.51.0

