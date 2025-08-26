Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D04CA0EE4
	for <webhook@archiver.kernel.org>; Tue, 26 Aug 2025 07:13:04 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.48])
 by mx.groups.io with SMTP id smtpd.web10.58745.1756192380568662821
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Aug 2025 00:13:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XhHd0ksN;
 spf=pass (domain: siemens.com, ip: 52.101.70.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iplkutliO3SdzvK4D411lsOKAYwkMoXgV8awf0s3z0yRG//MirMkWQ3T4mml7lZ/bg4nAIR2pxFcBvw9UxxoLFL7hucLw8FO08fQpGoeAFuF32AYcCAKf/f/0jy7bxPP0mXUWwhqSNNy+3L1yzt0ULKyHZAxsgjTZSVuiBb9XJoWZ6KAlelnTgergqnD5hcSEvpF76ImBn0VwexMncofhtWv0OeNW6QDmK83tqac765GHbVjQUhr6INg5QgTrnabEkC5stxXsUoZ8Gs12G63Jc3uA5ZMERdrdlX/yFx+OECIJdoWf6ZzdImFEoiUaxo/sdv4hXe6K+hWF2A13GzqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD6a9fZ+hF9B4v/CDfVAJLNVCWGW00/CG7c9TGwMgR8=;
 b=pnuzu2i+J7vecgwv2uSVK16mmRLowtX17ddzoBr3Hyyk/9XxiXs3UdBIjdP7rQa+dJM4jtJ38IIPvW7yHN/c1PKJ6HHXQsYOaBh2hkKa53yTruw8Jso5Y29KZ+u0Ms3GwqR5cxtLkRvVERYzkNMmiwwxobKNmJcIWFfV2UCu3RIvyilir0sTs0U5+wkafCzfHuqi+NisZYDx8KBnXaBLtMkbYQSpRGydSQBhSm9kq/WEtIFNUHdjC4cK8ONHzEkoji8CMxVtUF3A3z7zx6FqlNVLp96me1nsItoAFWy9YuLfBN8g7nZSEsR4GHIHRq+4jXL0rZF7oEbmtsbs3zbbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD6a9fZ+hF9B4v/CDfVAJLNVCWGW00/CG7c9TGwMgR8=;
 b=XhHd0ksNQ9ouKaYAuRDOXI/+vyfY1/+oQErYYb20K1pG4d4STttKrx6mTDD04RcfrPNBm42WQMtI7dQLK3CdTtHQVjHdC9Ra/p8sT8Ych/GNlTMjKLcCKGxNhSxjJ4ThPCRV/0os8dD2Fq59pTNF0iAhVQ8eUySXe7mM6bscnE/zAUf+GKOEDI19Y7M9GciBpmANgqFLPm2kEhlwJxl+jWRglic5L//nL9tjdy/gHMfvXTHPufYV/jC42uD4u9pl8B3oZelhSIvkV4VsEANpbRxTHXqrpltopogXIBYEH0AU1ov3eaggJwbg+MRdlVKgfx698y44mNrxso3v7+PnSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8707.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 07:12:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:12:56 +0000
Message-ID: <4cfe95b3-becb-499c-b426-10825467f3fe@siemens.com>
Date: Tue, 26 Aug 2025 09:12:56 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.240-cip63 and
 6.12.43-cip7
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e2c144-19cd-463f-9941-08dde46ffb5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y3VZR1ZVUTNWbGxZbTlDc01HRTlJaCt6YnlnV04vWW95bVBtODc5N3lxOWN2?=
 =?utf-8?B?NExYYUpGbEpzREpBTUlzTkFzQk96MnA3UU9ZbEcrOUZOK2t4dHoyOTFqNDhE?=
 =?utf-8?B?dUxNeXNRZTFodktjT1N0bTA2QWhTL3VwQVh0OVdyQ2cvSFd2Q3NMZjZDdTRD?=
 =?utf-8?B?Y3VkckFEN3FsUlkvcUJldkFLWGIxMDVmTlljb0lieXN4TmNVaXJpN3JyTEJ2?=
 =?utf-8?B?MjJFR1Q1VXlpTGJQcFRCbW9PV2JJL1NHOGJKcDd3QkNiMXBRVEF5QzNwelQ4?=
 =?utf-8?B?dUhFcHlBSmljMm5TYUFpWm41bDllazVLVEdIZDZXR296NCtTOVhtSW4wR0FM?=
 =?utf-8?B?V1plTkJOS2I1UVA3aGVhSGwwSkxMTHhWMVBJbHQ2aFZ5N3RRQVR4azJnaG0y?=
 =?utf-8?B?NzdZMjFReXJrYW9adzMyRnljRWJLdXNQcHRJc2s5WitSQnEyd1daM3N4TG9o?=
 =?utf-8?B?cDZzUnVRcnUvZXpocEdNM0paeWVRVVBXVDdSSlBxSHdYUEZNS0dVaW5nYW9T?=
 =?utf-8?B?OUFGK09QSzFWNm5iMC80UGd0VHF2bEtzdlJBNHI4RDYxZTdWNnZqL3lwTytR?=
 =?utf-8?B?TXQxVTVSZXpnbnd1VEs2MUxsQUs5MldNMWVKZENkMnJBVDhxaXBxQVlONGc5?=
 =?utf-8?B?VGlzbld5QWI3TnFESG5EMElqekxKZkdZWHJ3bkJDVTJEend6dHVmcmRiaEhD?=
 =?utf-8?B?ejhIam1sUUZoZDdoTzJjM1ZNZXprRzhBSkxBNG91azd4bCt4NFprTldLSDhu?=
 =?utf-8?B?d3ZXZzFmOWU1V1llRkxGRjRGU3BSWk5FNHJGVU9BNm13NDNKT3RQbFhKN05a?=
 =?utf-8?B?czZ1YTVleUkvWlZ5UlcrWjRob3QrOG9OaTlINFk1UENQZkdPQTUrU2pkRVRW?=
 =?utf-8?B?L0xsVGl1SkIxYWdONmhaSUNhbjNHc2pGbTdUZ3JKYmV4ZmtPQTNoc3R2Wk53?=
 =?utf-8?B?UmtELzBOQ3lseHVoWkU2Nm5iTUxueXZDK3pyZm0rVTNBOGZUL1pjZ3l2V3dX?=
 =?utf-8?B?TFEwOTl1TXNLQ0s2WnFjUGp6MEZPc0lxdENzeTFnSHlhRndMWG9sWU5od0tt?=
 =?utf-8?B?aXQ0cUkxYVBhdGFwRlA5amxRNmNUREN4NGttY0NDR3RLRS9PZFBTSU1EcHRj?=
 =?utf-8?B?bWpjam9DaHNHQi9OWTYvV0FMY3dGd0VhUFFGR2FlRzU3VlNRT1VHM1BoQ0Fk?=
 =?utf-8?B?aFE1K1R2eVBGS00xaFZZc29qUzRHc28yZGFoOVhiRXBrbmVRQnlVYk45SXFv?=
 =?utf-8?B?QTYwcmpSUTlrWjNXdEh3am5xcWpLL3pEZWhXMXF6TzUraUkxVnNPWTdpeVYy?=
 =?utf-8?B?M3pFR2p1R1VhcTNMcFRJYitXNEcvK3FSNFpEUW1wZHlFdGplUzZmVlNFMDhw?=
 =?utf-8?B?WTBjT0ViMVdDQ0dJbmJGSFdCSVdQaEsxdFI5Y0xHRkVudlllRmxoU0tJbEZ2?=
 =?utf-8?B?aFpqbisweHRrTmtEOHlEYS9oZjBKb25wc2ZXUjN4LzhpREsxalA2VWJCWjRp?=
 =?utf-8?B?SW8rMngxYkNvUDZGMW45dm00VzVMa3FOcEJGZ0g3V2FWakpzSG1tUmpmai9j?=
 =?utf-8?B?KzM1cWZiVk41T0tXdG9uOW1wV3Uvd25LWmFtMXhyVEp1NHpyRGFUMVFIS1VN?=
 =?utf-8?B?UEhiNjdKMjB4TmtjcnRYRVZTRFBmem1pbTNPVWxnMjZYb0E2WnpuRlA4U29Y?=
 =?utf-8?B?QlJpVFN6cWRmaERlQkg2c1AzWGhWNnRqOExOaHgvVE03T1FjcUx3TitUSkNm?=
 =?utf-8?B?U2wrYi9JeC9YekhHaWMyVUZvQ1MwWkNPYVdPOUJGaGN1Q2tuTElsUm5qRW1I?=
 =?utf-8?B?ZUZKeENvY2Ria0h0K2pzUmxHanVLZTNMVFd3Y1pDck5JWFZBZy8vWCtjdXBv?=
 =?utf-8?B?dlAzdUNFR3lOb2t1UytqaDBQMFdsb2d3Z29LMEwyMDRFY0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGJyZVhBWnVyaE9HMlpmQ3FyaERhZGN5Ymt4eXVtZXlRVm1LUjl2ZElKdEVP?=
 =?utf-8?B?bzFmYmVvaXlSbFp2N1AwU0RHdkVDM09LT0l2YmNkZ3YxNm1QYVh6NVRKRHhV?=
 =?utf-8?B?d1lhOEViUzhDZERmZUlkZFM4VmJiaG1vallvM2kyeDVYVUhrcnlBendBS0lL?=
 =?utf-8?B?U0JGTjdKYmZuOWpsNExGZjRWMnBiYldYR3Q3RVBMRGxtN1JycHFwazdwRUpp?=
 =?utf-8?B?K3hpMks0NnFiYklCenVzRDFLR3hGNVF6VDhXSVM0UjB3eHlxWWpnZGZOSUJ1?=
 =?utf-8?B?UDRCbWhYeit3VHYwZllZT2FXSitmSzhWVmJET2llTlZTOS83cnZMRzcwYk90?=
 =?utf-8?B?cjZjTWd2cDd6SlMxVy90b0prLzJKZkpLYWF6VXlPdEI0dGpoK1ZtakNCMFBK?=
 =?utf-8?B?MVRGZFpnaW8vdHNWWmNiR0RVS3Eyb21OSCtlaGVYdnh6MHRjejQ5UWE5VXlo?=
 =?utf-8?B?RVR4aUdYVWh1eXdQeHRKOGg4WlY3NzJ3M0paNGpKcFJtWlA5SzF4R1RmNnlk?=
 =?utf-8?B?cFQ1LzFneTRxOEFkNUY3YXY5R0draFJraEdlcjNDKzNhUG9pZ1pJa0UzWmYv?=
 =?utf-8?B?d09Nc0JSVmV6SjhUaVNrSG9ZNWFpNWp4N0NLSU5nb2xrS3J6UzlVUjVmYlVW?=
 =?utf-8?B?ZUJxYW8ybUM3V2hCZExzNUFlOGJXeTV4ek1KZTJNUnBWMmZlQWRibXlsamJO?=
 =?utf-8?B?ZVh4YlVWT3lRc0c1aEt4THBiOUNDZytHVVRyM3poODNWRGJhNWxjbkVPRTUr?=
 =?utf-8?B?Y09kakxDY2pPcVl6UnJPYlZHUEhqbW1GdTV1Y0M0RisvYmkrVXZ0STJJYWlI?=
 =?utf-8?B?K3JGK2Yyd2FuT2ZjKzVSK1plVEFKY3RzOXdUYWVWNGFUTnRaV1Fkck1lWDFm?=
 =?utf-8?B?dTFPdXB5R0pENmhBeVlPbkRma0VzOExSTmhZbUNtM1Jlc2trQkxuM05TMmRi?=
 =?utf-8?B?UGFMZ05FVUV1RFNTc2xrbGhneGxtTE10cFdjNHo4VS80Vnc2ejF1WFcva1NS?=
 =?utf-8?B?VDVaOHM0REtTaVc3OHZtMGwwMDFIZ2lCQ2hBaXNZS2xGM0MzVldjSWlqY2VP?=
 =?utf-8?B?UXpnekJKYWRzcmhncXI2VnI1VURxcTJqcmNzS3ppZml6aDhadllRM08yblUy?=
 =?utf-8?B?WDY3S0RSOEp3NGwvRmNKT1I2cGlUdFhIdm5rSFZFMkc0aXBrT2JxUlF2bTRX?=
 =?utf-8?B?M0VqdVViZ1Z6ZWx2N0JuQWpDMjFGR0NwWFdKTnFIdi9qdGhnWFhvQkEzSmRK?=
 =?utf-8?B?QUxiVkNTRFZDWEJIaDRXWVNnVVoxUjVSME5KNWRrb0NiTDYxdmdrMUY3dmk0?=
 =?utf-8?B?TVRnTzJzUTZpdDZmdkNZUDVFeHNIMUhEd0xSTWdkNmIwTEhBNVhRc01qVUZr?=
 =?utf-8?B?blBOdGVhOW5GeFZ3SXpYbGYvT2dmc1NRZDVyRE5Ud0pqajBpcEs3T0NXVXRw?=
 =?utf-8?B?TEFHY3hNTzJLZk1pNHBzajhvNDFXbGtLRitiN0N1dTAydll6NkFWRElBdUxB?=
 =?utf-8?B?MjNJaUNQS3MzMk5UbmVIZ011ZzZZelFSN2dGeVhsSFRVTnlNbjhlQ2FwMU00?=
 =?utf-8?B?SXNpOGNsVHJ1SWhkbHFIWWgxTEdEYXNXQWJHdFFBNjkyRWNCOUtWTGNZNWFY?=
 =?utf-8?B?NWY4Vkh6OWVId0NOVW5JTWpxTTVMU2tvNThVUXA5R0VYNUNDZENDRWpJZklt?=
 =?utf-8?B?SkhVS1djZGtQcXRZY3A5ck9HSXRJdWF2S1RSSTVqTlhlY0lwdzUyUzNkSTRm?=
 =?utf-8?B?OXRtVS9XbHEzdkM1SDJQRFFjZGEzYk0raUNzbHZkd2JVbmJRRk05NzJFeGds?=
 =?utf-8?B?ZUdva1kxdTdJQUt6TTJVZm1xUzdYV0RwWUV0TGl6WGtrUDdWcWdPQmRBck1N?=
 =?utf-8?B?bGR2NU1JNFY5bHVkMlIrR0p5WDVrcTN6WUpKQ21hOEl6WEpGc2ZDUjZLb3FK?=
 =?utf-8?B?dGdiZjlWQVAxZXgwZkNEYXBXbThoQm1mZXBzTzk0NHdvVDRYOW1WVmV5MHE5?=
 =?utf-8?B?K0dFYkJGNTdFSmJLdnBIWHFKRHpFWmpJUEN2UG5hNFlqTXRnWE1tTDdpelRn?=
 =?utf-8?B?clhYVUZVWnRxSlQ1M2wzK28wYmxVWGVmYVQ4UlZJOVdSdGZLMGo4bXFScXJm?=
 =?utf-8?B?YUVVZlBJWkhydkZ0eTY3Qk9zLy8xMVNjbVZVRmdHTmpPb25qVnRGNlg5elov?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e2c144-19cd-463f-9941-08dde46ffb5c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:12:56.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO1/uA67k/0RR2JPQ7jwfuhw5weg1lm29USBz0VNBuOpuPX6/xY/dffDJsm4nsB/2MQLm0CLzytjxE4XhTevhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8707
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Aug 2025 07:13:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19962

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb               | 1 +
 ...{linux-cip_5.10.239-cip62.bb => linux-cip_5.10.240-cip63.bb} | 2 +-
 .../{linux-cip_6.12.41-cip6.bb => linux-cip_6.12.43-cip7.bb}    | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb
 rename recipes-kernel/linux/{linux-cip_5.10.239-cip62.bb => linux-cip_5.10.240-cip63.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.41-cip6.bb => linux-cip_6.12.43-cip7.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb b/recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb
deleted file mode 120000
index f68d2686..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.41-cip6.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.41-cip6.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb b/recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb
new file mode 120000
index 00000000..091db61d
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.43-cip7.bb
@@ -0,0 +1 @@
+linux-cip_6.12.43-cip7.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_5.10.239-cip62.bb b/recipes-kernel/linux/linux-cip_5.10.240-cip63.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.239-cip62.bb
rename to recipes-kernel/linux/linux-cip_5.10.240-cip63.bb
index b2dfb4da..40841607 100644
--- a/recipes-kernel/linux/linux-cip_5.10.239-cip62.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.240-cip63.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "13925dd65f12b38832340a654226becade5c2118f94d86a022b386231ca57998"
+SRC_URI[sha256sum] = "6a84a1f1395b99040b06fcea02f8884ecee6da85b345edd2b160e47838a374ce"
diff --git a/recipes-kernel/linux/linux-cip_6.12.41-cip6.bb b/recipes-kernel/linux/linux-cip_6.12.43-cip7.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.41-cip6.bb
rename to recipes-kernel/linux/linux-cip_6.12.43-cip7.bb
index c4f24657..4a23b9fc 100644
--- a/recipes-kernel/linux/linux-cip_6.12.41-cip6.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.43-cip7.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "c69287b8d28e0b740ea46441584cca19896fe887befc296743b4cc0a426508ba"
+SRC_URI[sha256sum] = "d85bb43cc091d7cd1b860dceeefad4345d5a9bd39d81c1abb24fd962e21d537f"
-- 
2.43.0

