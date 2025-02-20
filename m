Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F545C021AD
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 06:11:00 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.63])
 by mx.groups.io with SMTP id smtpd.web10.43618.1740031856562251502
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2025 22:10:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dih+4veq;
 spf=pass (domain: siemens.com, ip: 40.107.105.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO/vGuDsXM1FHUXHiIxXEoLMHYH/8b6/r1R1s+Z5GAyxNQKOJZFQvn/Ia/iMow0XxO82dJuW1rpcsOnvqU8bSxLws94BKyc0aWGvnYIlta1Z8cm/4LaSo9KFkWJeMRL7nCbKzzfjTcYg7afkWBRs0ltmyb+jPf61P5ZhAnEQhFJm8VE5dTxJlYgvpRwza/rwgXeflTF3AlAplaBxb7eflL5MsoTpKGh/pXoXm1wQrcMYGyRdYOkQfAaKPmyKia/OJXpzEYqePiWfsvMdSUKep/UAOfHfLBRhVB814ujKmIyxlKN3aYnH3nKo4UwO/uUHKIRWKXd+nrbfqQSno3P/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5U/756U0bZIvkrGrLKkV6nmqygvJHQnTPQQZxmlsO4=;
 b=uN51NtTR3E0LihvVJqIJi/R/Vbc5l+/m+RVX03oOcYt9KXn2e012f3uJ1z/41D91uEB9VqeGOgVx3F+XXTo/c2DmsRAREio9lmBL8gECyapNJO2A+OkHYrekJkwDwFI9KJKDpzUxz7VomC4oieviq5xu2VUd1SeD31ANoq0pAHoNkApmeCE+OsjUUpgWiL6xMcxon8OvrOHjbPmTYnJMSkbo5Zv6PNzPPRPB9Q+YzWef9ZQPwrizsflPOai7cIzjy83ffzfux7aOSHqjQwofigEV2yyA4iinG6h7t1y3dJHJ4r0Ot3sT6q0yxHz66uN6jEfAPgVdHMoAC01C5tDKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5U/756U0bZIvkrGrLKkV6nmqygvJHQnTPQQZxmlsO4=;
 b=dih+4veqEvpHHpZgLWIMPXfhBVYXP3ovrKQKRb+xMBm9da0u3bEdOTVqfrQtnjv0cg3H3oWWVQysacV4mjYaPw2nyWlwKroVU3+txBGiL00K4aHx2gCWqFO4ls/C5J7hxnsabo9h7nh0NzPvasIQmSJUqp3N7IxC0AC02YLiD60/M2eQGrAyUFPjXGgMp1fguLZXJCqfmCTnt/U2UGrm6tLSWOrZy1n1wf+eExeAOSKI9EaWUFOJKcEGZXYm77EvQDuKB+YnDqb4zFSSSdtjLlFFDMEpLNJ4U7htBvsj0Lqaw05UPR97ondzvRrhi5uXUW/cbq+p3ew5lbsRuLORAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3798.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 06:10:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 06:10:53 +0000
Message-ID: <9ec45249-ea8b-487c-a1c2-e7bf4ef6113f@siemens.com>
Date: Thu, 20 Feb 2025 07:10:48 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip96-rt53 and
 6.1.128-cip37-rt20
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3798:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0152c7-1d22-4435-63d2-08dd5175549a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VkRoNzNWclFyK1AzSFAzMHBBc2hyWjVmMnE1Rnl0eHNBTXVUcStub0QxSFdk?=
 =?utf-8?B?ZXB5bEUwSHVvK1RVKzJHRDVwb3JMTFE0c3lzRnJ2N2hCQTlUaU4zNDR1czZJ?=
 =?utf-8?B?anRLZCs1WFFDT3dzTDR5bjVuWXZncDRDVGkrYkE4NzZqdkhqSy8xU2U5bTFm?=
 =?utf-8?B?YUJnZlh5clpSelgvQ1E4VElMRWQ1L2hkeDE0VTNIc1d5UWVMa29qc1ZXdXRQ?=
 =?utf-8?B?Mk0ySkNZQ2NkRjhKUnlHNjFBZ2xuRWFhWVVTazRxZkoxTjV3bG8xN2YxWmsw?=
 =?utf-8?B?ajNieWRWZVI2RU9uRnh0RTR5ZitqbmlWbmlTSUo4Vkp1YzFUck51ZkIvenRL?=
 =?utf-8?B?MlRpVms1VndHUFVJNW4zVEZpWEFObk1QOGtzUTIvRjBWQzdmYytlazViU3My?=
 =?utf-8?B?QkNGeWtWQnVDRnVXSXdibllDUnVFcVlaSkxkMDVnSWh1RVN3VlZucm8yZm9Z?=
 =?utf-8?B?NllSdWZVbDhWRGcrOGtrUFpLUlUvR0h6UlY3dW12MmVDbG95NzBTRkh0OE5C?=
 =?utf-8?B?QnlncHdweE9xeHlHTm1DQW45RlNuYlNoYWh1MDR0bVE0UDd2bFlRMDNQZmZG?=
 =?utf-8?B?cmc1WWQweGZpck5YS2I1Uy83ZDVyMjRsZHJkRmRPVHliNlVqazNkUzgwYndx?=
 =?utf-8?B?YkhKelA2ZzUxdUN0SXBmNVlDMVBjNjYzTHlrQjNwOVh3T3FZOHRnYmJQY1hj?=
 =?utf-8?B?akpjWDJDNFNyV1BnaG9IZHp6cnVwaVVBeXV0UVBMUzZxM21NNzg1ZGxqajlp?=
 =?utf-8?B?T3pkYnpqZDhCdENUN0c5d3lmdU0xMnBKekl4Y1BoZDhlWG8xU2VGb1FrUmJx?=
 =?utf-8?B?ZU9XZC9zb3EvVU5EK2VqMWZCajhhRHJUazB3dnhLSlZPL3lTQ21NR3I2SHFt?=
 =?utf-8?B?d3pDL2R3UXBpVnM3cTZNeHY2TzVwK2xXb2NBVlFsMnFmNEJQV1VKclF0NXIv?=
 =?utf-8?B?aGFPdTBMQkV1V3VBTUgzZG9lK1VSRXJQUWhtMGVuRGdyZHBJb2czVFBJS1BK?=
 =?utf-8?B?T3FwcmNPdFBKTkRQeWpJdlJJRHRyVEhZMTNhWlpZYk1RK2p4RmprTmdBb2JC?=
 =?utf-8?B?aWhtUEkvUEJ4ZkN4aUcwK0hzZ2szcXhFUWs4R3oyek5VeTNkb25pd3haNmRJ?=
 =?utf-8?B?RjdIRElUM2VnNmcvY2x5eWlFSld4NEsyNXdLZFhwN1pHcDh4NFVXT0d2S2N1?=
 =?utf-8?B?SGZBSEgyOURUeXJ0dVRXS0ErSG1ibmZoSjk5SmUxTFgrVW5xRVFtN3BPdjZm?=
 =?utf-8?B?ZjJkL3dkSW1sOHFWdFp2QnR6R0pTcEt1bGhoT3ZWREMyV2IwdFowbCt3MlUy?=
 =?utf-8?B?UUNLVVdqZTNsdkcvWE5GNFM1RHFKWGdpSDFQL3lFc3JiY2ZUOXEwaEdoMm1E?=
 =?utf-8?B?bVNPQUhoOW4wMUJtc1BhdHpSTGgyMnVVb0t0WUhGTWZ5T3YxSjA2QXlQcVFx?=
 =?utf-8?B?dzF4OThVU0Rrb3V0Mk9NQUs3L2I1enZIRmJlMHhnZjlHYW9FQUJVMEQwYTVL?=
 =?utf-8?B?VmVNNFZZRENIRFoyQkw1dldpSEFvVUF2d21iaDBVTitzRHVQeEo0V0RKbnNV?=
 =?utf-8?B?M1IyVXlQbFEwYlZFdjB4MjdWcjJCVHpZR3piMzdCQnVkdVB1VERkcmdkdUtS?=
 =?utf-8?B?MHozZkpoS2JrSWpyeGpKVTYwQktCZE9yMW50ZENuaVFKc2N3UjBpTFA0TndS?=
 =?utf-8?B?cm56dzA5MHVweDJNMVRGaW42cXZMbmo4NEZKUjhMeHNIMHNabXlDclF3ZC9v?=
 =?utf-8?B?b2VjV3lXS3BhQ2N4d0hBMEQ5WGV4R2VDRnY1cEpPMWtzcU9nUldnd0dRMmNR?=
 =?utf-8?B?aDRFQzhsNVRDSzd3c3dBakl1RXRBTnJoUURveXIxRytwaWV2ZjVJelkzSVdF?=
 =?utf-8?Q?mMemOQUGrm3sn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTRjMmM0R2N3SFhkdERTTFVZZnJuWWp2SVY4cXBocXVEM2U5VE4rcjN5N0xZ?=
 =?utf-8?B?b29IVFdrWVFDeGZ2TUtwWEhjT3hFUThCM1hLbXI2bFFScEkrbUlkVmMrMThH?=
 =?utf-8?B?OCs2M1drZXZ0dXdMMVFOVGFyUXh2RHZnZm5UaGlWNUxPMXk0ZzVYaGp4SjAx?=
 =?utf-8?B?Rkh0VEIrdHlyaTg3RnpxSFZsZWduMTVWdzBmNjlMb21MTlpVaTBvWlRJWlRR?=
 =?utf-8?B?VHhvZkE0M3hpaERFSElyZUl1dWRzSWc0NDgvdmdyR0ZRQnhrZGZIa3Jnd3kv?=
 =?utf-8?B?SmZnZHdqVi9QbktjWnVsdnpEVDRTWFF3UEpiTnVWK0FtUFlCRTgrdHBEV0Vj?=
 =?utf-8?B?WC9oYnJUSW5ZZXJlNFoxcFpFQXFVTnB2cVZndmtKYm1yRTJXbjg0NXdwSnIy?=
 =?utf-8?B?RkFEWllpU3Zick0yY2tsT0lGbU1CdFZOTEdHaHRJOUgzRkRtYnpUQitqMEQz?=
 =?utf-8?B?RnFUdVFTWlBqZE5tMUMyZ0tPQTRySG9aQlNmdHJZQ085aUlvSytVRm9TOUl2?=
 =?utf-8?B?bmZla1BVMHJHTHVMZ3U3QTBlbnZKNUl3ZUxLeXNyWFVNc0pMa2E2SU1SYmNQ?=
 =?utf-8?B?SXYxSk0wN3N4WjkxSy9kWUZTKzB2Qk9uSElvbzNWZzFjUHIyd1NxWCtuVUQx?=
 =?utf-8?B?ZWdTZ3NQcEJ3VmcxaG9TVkh6MjFkcFN2TWx3bkIvS1RaUk1ZKzA5RzdKN3RL?=
 =?utf-8?B?SmpuMUo4cmhYenpIMG5zdGhHUm84LzF1WDVDSm83M2JVWDlIa1ArZHI4Nmgz?=
 =?utf-8?B?bnBJUlN2UjBkcm5nNUN2SllwZzJFUkZEOU14dFllanphbkluQUV5QnVIeVc3?=
 =?utf-8?B?VEJlZnl6S2d1SkpkZUw0WlBxai9HcjVveVExZjMrbWVjeEJaWS9nL2lWZXdo?=
 =?utf-8?B?eFZxOE01bkpXcnRsMTRhdEIzeE92cHBvQi9jTk5PSTZEMTZBZ2ZRdWZpZHJq?=
 =?utf-8?B?ZGVSZ3BobWJtWVROMVdZdzUzcnQ1Yll6VVZmWEdGME1YOFVMakk4ZzBabGkz?=
 =?utf-8?B?bzh2YmJQdW9HRmZMWjd0MENmUU9NUElUTEFCLytWL2ZrOFFUV25DbW9ndzBn?=
 =?utf-8?B?NFZmMVVyUTFkVTJPb1Z6WDRPMG9HK3kzb1E4bTdJdU1OV3ZGaGptbXM4Qllw?=
 =?utf-8?B?U2hIZkFvM1BiYU1Naks4RFVrQXJEczVJMlVmY3RJTkVFQnhnNlRDdFFHdk5G?=
 =?utf-8?B?M1NjRG9wWThLRVdoZDJ0TDRrL25EVDFDeG5WRGczazdndjY5c21rd2VZYk1a?=
 =?utf-8?B?d1o5WUt5L1diTEZEYmdLWUJBZ1YrbCs4eHFMbWwvNHVLVEZTSjc1cVVmZ2tK?=
 =?utf-8?B?MU5RbllscVFNQS9uVmpBdEd0dnV3NlRzdjI5akZENjhYcHo1SlRFUDhOTGVn?=
 =?utf-8?B?b3VERUFBVFNZMitjVURxQVBjNy9tcjBwZ082ZTc2U3ZZVFZnVXFpS2NuNkYr?=
 =?utf-8?B?NmJaSXo2eEVCTVpzdFl6S3ltMmdZbnVldkVXejZsMnFTRHNhV0lYcnhmNzEz?=
 =?utf-8?B?K0xaVkpPOXY1ejZmNXdqZTI5MXVxQTR5U1FjV09EYUR0bU81Lzhqa09XSlIw?=
 =?utf-8?B?OWw3THpGdWhHM3Z1MXk4clJYSWZWZE43c29waG8zSjM5SEtwQVlUcCs4YlpU?=
 =?utf-8?B?QjVEeldmRjNKL2dIZWE2NzM0cFRWektveFpBTWhYTWhCb2FKTGdTQUFNUVNZ?=
 =?utf-8?B?djhHaFhhbUd5SnpTL2dDS0dYdGNjeCsxVFp3SkpiYUY4bUJ6cERrcTh2enND?=
 =?utf-8?B?L2VJcUdnOW1USkt3UlhieldBVFlXUmNkamhZcW9sd0hzSnZ1Z25Gb1krbUd2?=
 =?utf-8?B?VFBBeHROTXdCMWdBVU1jcjZDcEtPYjFqZ05nV2lvdG1JWWo0MmlVSWhDcWhU?=
 =?utf-8?B?cHRESWVId3hnNDc2a2tpZmdDUUkyenhPMVM4MEp6eVBobmhMTjlkbWlCN2dh?=
 =?utf-8?B?OXd6RDBZaEkyYUdTYy9FNngxdkRjMW1xdFk0UUI3bDdyWDdnSlV2ZmJsUHNR?=
 =?utf-8?B?TU16MnRDNFh2NFFYdERnSFJpZk1ZWTRZclBkV3V4TGptNFVmaE5jYmdzZjhG?=
 =?utf-8?B?azBaNFdDRVRXWEd5M3lWbEZnQ1hWd1QxQXFBYVJaNVUzK1JaN1A3cGlRbzZ2?=
 =?utf-8?Q?kXfevisbVY2nvjYHx+UBEa5qJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0152c7-1d22-4435-63d2-08dd5175549a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:10:52.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5VdNm2K2aExCUG8C8+Ga5GvA6Ftn0fhaSxrUUDuBeVO/RuC2q43m6sgE0VxcIL2xh4fiS5HulZVm0i98UtW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3798
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2025 06:11:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17871

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.4.302-cip94-rt52.bb => linux-cip-rt_4.4.302-cip96-rt53.bb} | 2 +-
 ...6.1.127-cip36-rt19.bb => linux-cip-rt_6.1.128-cip37-rt20.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip94-rt52.bb => linux-cip-rt_4.4.302-cip96-rt53.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.127-cip36-rt19.bb => linux-cip-rt_6.1.128-cip37-rt20.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip94-rt52.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip96-rt53.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip94-rt52.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip96-rt53.bb
index c9acba69..95ba0661 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip94-rt52.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip96-rt53.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "f197cb9f47625e46c2cf50d3624c096a9de18f1507b462ce76501f7a872f3e8a"
+SRC_URI[sha256sum] = "591f3fb22080d25c3e41228b8da30ecb95cd4cedbccabb186df895e11a0debbb"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.127-cip36-rt19.bb b/recipes-kernel/linux/linux-cip-rt_6.1.128-cip37-rt20.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.127-cip36-rt19.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.128-cip37-rt20.bb
index fbb7d409..6c780826 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.127-cip36-rt19.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.128-cip37-rt20.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "93525a9cb4e9074e0b7d63cdd12acc4758b0bfeca994b5a6ca8ac3e283e1dd85"
+SRC_URI[sha256sum] = "45a2eb7cf72faf1ac8ea4a6dfa8891671c74f89e0265cba2737f116fbe7c22a5"
-- 
2.43.0

