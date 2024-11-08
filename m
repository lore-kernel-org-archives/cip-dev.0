Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5019BD64064
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 16:34:06 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web10.16998.1731083645100792776
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 08:34:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EzFJyqgL;
 spf=pass (domain: siemens.com, ip: 40.107.21.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zN5Y3tIOhSLSnxPmXa01acoMF6HBNHsoHwt7a84SUDMVUEz3hwiYqWMG4xppsZQ1OCRZs4MBfSTyMsIV18fl8NFxS8qz+1PPxaJgixBM7dV2IvzAL6ObkY1x/tRAhVADbV0AOS6UIiN36wzzZKANteT7HbzMl1O4y00wvxSzvkUJyQiQ19kGE73yXJAXxteC0RDggd4AV/iC2FTZd9hOJ0pe1tfNhnvtgwo0w3tLZYKoElilE96vqQV3fkuFUdLms4BE649Hkjoq65htGVGnMgh/OlQ/enH35qZKvduuMgsnMxQTlL+8442f3ZhJ1Pt5AOf7nLEtpEk4sQnV7gDtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dV5h7E41QR4rrHn96xmvjCMBpx6r6TxtlVEkv3TEDY=;
 b=F9lUyO9kEu8ZzlGViyyhStwkcdFYb5Yny6gbt4EHyMGng9UKvU3bBgAlom7JdUBNsgXRTfZrL84Qtrmu+BqTq2FYxGB+KTQjoLQqBAldlbkZwQpTSMNMWeozaY0jq/GIIvCqBJ8XH0K8TgVMxFoaiFq9IzK3fdIIOe9dhPOYanqdGVfsjBpUZAypMsRcGECVjQuFFuqbdil9bmBb3Dgdt70G7kdBwgA/j+Rn1sES2OEL2PuB9ZiC9GRrR0yAYDwPqrSa+3cAiZCJPGi6peEiY3Aig/EsnBcroU5vgbRPJuDjGVCsN6Oab8caY1gnAG1Q7gOywhsoegvXe3NdZd00WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dV5h7E41QR4rrHn96xmvjCMBpx6r6TxtlVEkv3TEDY=;
 b=EzFJyqgLpjOA2athC8GH7Rjr4vS0kIb/j+ZUdF9ODxJDSwjy7psaGQ2o1OHBMW0ToeJQyFv8JvF+TyElvq6YhFk8XLuALKIDYRdm533TP452mccU4h2XueC8RP0L6/CkFLN95V5U32FqKaHTtyIIDc0nbSR6hqB6K3e+ioPZFiQ2+wEVWdtrlO51sip8Wh4nvWRbZ7hcsT5uYUUI71y5n8atAn8I00oMD/2RyDuVzYYCS3Cm6hf0ol/kNJYej734Fe/qrNNZJ2Bu1lJeLlk2JO2864nLtYqRXlJXz3vlS5SMidrDH3vvdtVUR3TnS4env7XK0gAXFKpiVRBKy2O1ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10; Fri, 8 Nov
 2024 16:34:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 16:34:01 +0000
Message-ID: <779a1fab-24c4-4962-840b-dd8a73518d64@siemens.com>
Date: Fri, 8 Nov 2024 17:34:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
 <7d506128-22a6-4556-9506-a1394390d0fb@siemens.com>
 <AM7PR10MB3320C33544FDA2A60CC3F2E4865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <0ab55902-7b85-42ac-81c6-1d8214d3436f@siemens.com>
 <AM7PR10MB332073758FFEA64F2CAEB1A8865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <ed6122d2-113c-43d2-a6fe-8bab867ec51d@siemens.com>
 <AM7PR10MB33202DC3FE6C2AFD951A20E7865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB33202DC3FE6C2AFD951A20E7865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 652f3d9e-90ba-4da8-0ebf-08dd001326b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UGVQUmQ2MFloZU5OYmM0VUU5Q1hOQVU5a3dTcm44d1Nsb3EybzBIN2xuL20r?=
 =?utf-8?B?c2F6N2hPMWFMRlZwSHlveVorWmdXUHlVY3h2N1Nmb1JIdXJWWHhYRDFkM01E?=
 =?utf-8?B?LzlrYm1FZ2ZaeG5qTUp1MWV3a0tOc3EwTGpZaTBtOHRaWXpCQzRlb3FuRXJF?=
 =?utf-8?B?d2pmakF1aWp0bURIdFQvN25GNnVNaUF0eEdiZHU3SThKTnJ5aU9iaHh3b2F5?=
 =?utf-8?B?eTJDWHZPcXg0RTllWEdQSUdZSGl2QjU2Rk5OUUVEL0FMSlhpTXEwU1VKZzJG?=
 =?utf-8?B?aVgvQUEwMHIxeUxwUkhBazBGYkViYzhYdVpOT0pTNmpJeE1TNFk4TmlLQk1s?=
 =?utf-8?B?NlFJOUZDODZpR3d1WXUvT3lTY2dlSTNjR0plWVlrWi9XMG9mYlAzM2k1Q1Bx?=
 =?utf-8?B?TFgzZ09aN0xObnNkZkVwY0FieHgxekJ6UHRWNWsreFIrR2VhYkNRVmpLNWty?=
 =?utf-8?B?NzRSUDdJOG83VnZQK3BFb3FaRCtJVkU5TzR4bjRiTWhwNm1UeG1tRkVVNUVR?=
 =?utf-8?B?QnBOWHA1amRFM1A3S1JXTXlQQ1V2YThqam9EeHc2cDJhTVRFQmVMQzIvR1Bk?=
 =?utf-8?B?V08vUXFPN3lrdDROa1VaY25ZR0pwV0xtSHJWWkYwVTlLR21mSHBOemZsNkJU?=
 =?utf-8?B?bnZvWFFBZlIvL2ZmN2FZcHZ2T2Y2N0Mra1FBQ0Z3emkweUpFaDlOQkNhZm1C?=
 =?utf-8?B?WlN5dGRyc24xVGVEaGFiZTNhdjFOb3Z5bHhJdWlJM1Q0WmFpalhGM1dSM1Er?=
 =?utf-8?B?ei9nOTFBKzRiVFZQL1kyMnluQXg3K0JjRWtNa0ZYd1B5VU9VeFJTV3NWZFNI?=
 =?utf-8?B?TE95d3NhbHNvUU9pNFliWEk4S1AzQ1dQSE4veXFXM1paM2VMdW5RS3pNNy9q?=
 =?utf-8?B?eE1rODYzdkx3bEcvb0VjODFnbUNFUFlHSXAwNjJieGdQU3ExZzRBZk81ZTAz?=
 =?utf-8?B?VW1OUlRRL2tzQUFOZGc2YlpUV21WTWIzRFp2UStvT0tlMFgvZzNLVFVVZC84?=
 =?utf-8?B?WFhzTE5INmZZZGdlVEFvZG03WXVlTms1cy9NR0JtN1poSStGUEUvTWdveUpq?=
 =?utf-8?B?LzkvRURIbldhalVTcDl5Ti9NcVZkN0ZxUEZtNXpWOXhGNXFCMWEzc201ZFRr?=
 =?utf-8?B?TDdaNGw0VTZ5cWwyQmN5UHV1Wlp4QTg3MElOZ1l6VUNGcGJVVld1dnVKZytR?=
 =?utf-8?B?cjIwUXhUTStqTDlENTM1REhUVUZ6RCtnaytWdUhwbHlCbXZCUFFkOWMwRDMx?=
 =?utf-8?B?YWRaQ0dPeUNVeEdpQ3RqSzJIRUtiU2N0dTNsNmppSUZUOStUR1AyZHI2NFVI?=
 =?utf-8?B?UmFoemRsYzVSUzFDak5pV0dXV3phY2RXUzh1KzRUZm1BWWg5aG1MYyt4TnFv?=
 =?utf-8?B?eUpxV3BDMnZZM2JxVFB6VEsyOVVGRjYyNDBVN1NUdXB0eXFqNWM0MFFCcVlu?=
 =?utf-8?B?Y1o0a0E2QnNXekFRMk9BTUN4UjRtcElmVURlSEwwOEZDeUNuQTcxeGdjYnVP?=
 =?utf-8?B?SFJKZjcwVXJ0Smh4eGNIVlVBRDFWb0h2VEFXOFovRDVNTFFPZUh2UVZYUW01?=
 =?utf-8?B?QStDVjJCcHNlZ05Oblh6SnNCeGhNRW43ZzRmU2FpR09FQTJiRko0bGFMdTF2?=
 =?utf-8?B?UVFxRk5vQ0tOL1pJZFJMdlpCazlQY2tvQXQxdS85YUtuRWRFMkJWNWNINGow?=
 =?utf-8?Q?S3rWqz2uMToTXzeE0t/u?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2J1U0hTU1JvV1FyWDJ5a2YrVFRZaFhnL3JBZDlHdGRRa1BORGhPYlV1Tm5Z?=
 =?utf-8?B?ODVhd0hnaWZzN203d2NoUXJNRGpFbTZSQ1d2eE1jdzhHakRJVlhpZDFmc0l6?=
 =?utf-8?B?UEQ0WWpEUXNLekhaOEhmQ3BkWENLa2RJZG1aT3VNbWdNSWFNWDQwVDFIZW9l?=
 =?utf-8?B?TE5wQmtTODdHMHlxdHA4UDl1dzlBYm01V0VYRUo0VHlVQm5FckdIbDNUQ0U5?=
 =?utf-8?B?cEZLQnp5b2lJT09nTDZYWGtCOCtLR0d1ZlZaS0F5U0Zvc2J4T250OWJ1aFM1?=
 =?utf-8?B?MnhGZ3VPSkcvSGcyS0pPZ3lJTUIwNmp1OG5OcHVvbkc0dklYUkZBSDZNMk0w?=
 =?utf-8?B?RGs1ellTS3pHUDBZTy8zalYvajMwTkkzSWVod2ZPQkZYckhHMk9QQzVYR1cw?=
 =?utf-8?B?d3NVZzI4MFYvUGJxaUVTQWIvcVZKYXVXTlRxNjhTNEd4djVaTEp0NUZ5dmhU?=
 =?utf-8?B?SFJkL2p5RklQSUttSnRlRzZUaWVLSXl6Y3l0OXNjOERKQmJ2bmJRWUR1cTdJ?=
 =?utf-8?B?VXZTYVJta2l5TW5BRmdwbGF4aWJiK2xsZ3RseTlRTmJUUzB6RE96cE5zdlRN?=
 =?utf-8?B?ZjRsakRzUmp2QlNPK1R0eGtjRVo1WkpJTzU3N0QyQXYvczBlVGxFMUR2SkhQ?=
 =?utf-8?B?QW1iVXovcy9MazYvMVRnNjA4bWc4bmRLVjlMSGlud3lwKzZyQ2g5QzUzMXlG?=
 =?utf-8?B?bGQ2OU1NaDNPREZMU3lieHF6S3kxUVZnWEltbHNVWldQM2VRekg4TXMvcGht?=
 =?utf-8?B?aERPdXFSMUlBcElvT21IMGhSZXZqSmY0UEJJT2R0aVAzM0doempFUHdTc1lI?=
 =?utf-8?B?MWxOM0dQcS9lTS9Ebm50eEtTTGhKM1VqaVd3NVlyQ3l2NGRmbEs3K3ZGRjZC?=
 =?utf-8?B?aVdyclFUdHdQSnJwcW9GMDZQTHlMVlNJVTNYWjBoSU13UGRINDMvODErZjNv?=
 =?utf-8?B?WWdnNU0xVENnWFJ2c24vTzdKd3lCYlo2RjBZMzBoN2swNmdjeG03clh3NWFq?=
 =?utf-8?B?aWZIc0RQMHRjaXpuZzlIeDRyMjZQb3lMWjB4WUZFek5vdHRBcWhUeUhtZUFy?=
 =?utf-8?B?bmRJaURUelE5czBlRU8zcThuYTRUaFgvZ0ZJci9sOE1ZbUxEZkE1amhST3RL?=
 =?utf-8?B?anB1ZXRzNy9qZ0h1b1JpNm9WR3I1ZDkzSjdsTXRKZzJxS1Y5QjVqNlZUdEgy?=
 =?utf-8?B?bW1MU3ZBT2RsV0lNaEZLdEJoSTRzL2JiYmI1aGI0QzAvMUplR1IzRDRhNkx6?=
 =?utf-8?B?Q3N2MkFJTXVBRW80TkdFV3d5cjRiSTcyd2p3VUhQSS9JVEdYclU0QU5rMEo4?=
 =?utf-8?B?KzljaDFSeDdraXpJUzgvZS80ZEFmYUxKZzhvMnluTU9JbmRQR1B0OGxUOTEx?=
 =?utf-8?B?dmVjZFZJd2tVRktFMVZVN1lVRHRyZGxuck9zZzI1bEduZXZEMEtYajNFcEpH?=
 =?utf-8?B?Q3hoZ1FINjI1RlJkeTM4SVpKZ1cvY2ZlMTB4YThyNjd4WkFBalVFV0VUZ3dJ?=
 =?utf-8?B?ZGJKRFQ2RnE2RGQrTFhrczBZMWhkRHZkUXcvZGE3ekdkSnV3YnNoclhxTmpZ?=
 =?utf-8?B?SElidWNPa1hYYjk1dEtCR3lMQ002K3V6dDc4UU9YSnJrRGhad2EzYlZCc2M1?=
 =?utf-8?B?Q204KytEVlR6TWtSUFpDc09iZXVrcGZNbmhqdmlqdUdna0dPNVNLYU9Zby9a?=
 =?utf-8?B?K1oyaDdYWmhiTDRRYkRCQ2wvYWZMRmN6RllIT05KU05PcXdEcFdjWGZGTHFa?=
 =?utf-8?B?L0E2M0N2aDh4b1FZNVZ2NkNBR2pmelNHK1BRNzFaaUQ4d3dyT0hmYzQrTmJ4?=
 =?utf-8?B?OTB2K29VUGFMNTA5VTF6ZG52Y3JlemY1RzNuLy9XdENoUVdkNmd0ZVpuY29I?=
 =?utf-8?B?OVhiQmJHVTFwcDdwQ2szaGZRbDNGSzZ1SFZqTmx5RGxTak0wdGhqUFE1dGRj?=
 =?utf-8?B?ZklSZWh1aVl5ZHc0R1hlVjROczI2dnYvNWZJdnIrOXVackNoeGF2VkRLZ3Rr?=
 =?utf-8?B?S2M0Y3A4RzVUL1haL3JZZUtPVnZEUG1NQkF6T0lFUml4bk43bFUxS3RkbmJp?=
 =?utf-8?B?eTdQR0FRZjJ0U2VHQyt6YmpmcVQ2b2V6T3NnZUozM2lzcTdDUVVpNVpUUzVq?=
 =?utf-8?B?Y2JSUkd5LzQzb2JyN0syN0QyWDVCT3R4YVJDNkV4M3Z4dVRCS3NWeDQ1aytj?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652f3d9e-90ba-4da8-0ebf-08dd001326b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 16:34:01.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hljeDSolxwPa6p9YZ9oTltmo/IZTdEm7to7gl0Om7W/5s5yHmI/VOs2+qBwmqP1vr4y8tYRhCtF0mkuoeBYU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7181
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 16:34:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17234

On 08.11.24 17:28, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> On 08.11.24 16:47, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>> On 08.11.24 16:10, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>> On 08.11.24 16:02, Quirin Gylstorff wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/8/24 15:53, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>>>>>>>>
>>>>>>>>>>> Quirin and I discussed this a bit longer today: We actually
>>>>>>>>>>> should remove the need of expand-on-first-boot to access the key again.
>>>>>>>>>>> And that is also due to an idea I picked up yesterday to lock
>>>>>>>>>>> the tpm secret after initramfs so that we reduce the risk of
>>>>>>>>>>> leaking it via the main OS.
>>>>>>>>>>>
>>>>>>>>>>> Our plan is now to convert expand-on-first-boot into an
>>>>>>>>>>> initramfs hook that would then come before the crypt-hook,
>>>>>>>>>>> thus would only work against the unencrypted blank filesystem
>>>>>>>>>>> - problem solved, just differently.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Actually that's a good idea!
>>>>>>>>>>
>>>>>>>>>>> For now, also for trixie, we will just make the dependencies
>>>>>>>>>>> of initramfs-crypt-hook release-dependent in isar-cip-core.
>>>>>>>>>>
>>>>>>>>>> I guess this is the patch [1] you are referring to?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Correct.
>>>>>>>>>
>>>>>>>>>> Just to be sure, still, the implementation of the initramfs
>>>>>>>>>> hook for expansion will be in isar?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Nope, this ideas fell apart after trying to convert the current
>>>>>>>>> systemd unit into an early initramfs hook. We will need to split things:
>>>>>>>>>
>>>>>>>>>   - expansion for already or to-be encrypted partitions needs to
>>>>>>>>> go into
>>>>>>>>>     the crypt-hook of cip-core
>>>>>>>>
>>>>>>>> ad "expansion for already encrypted": I guess that covers cases
>>>>>>>> like in VM/Cloud infra, where disks can be expanded after
>>>>>>>> first-boot / installation?
>>>>>>>> ---
>>>>>>>>
>>>>>>>> In many use cases resizing the partition should be required
>>>>>>>> during installation / or first boot only.
>>>>>>>> That's why, I'd prefer having those steps separated and opting in
>>>>>>>> for either!
>>>>>>>> Although package dependencies might be tempting to combine those
>>>>>>>> and reduce recipes + initramfs hooks, the use cases and options
>>>>>>>> on combining those justify a split.
>>>>>>>>
>>>>>>>> As an example to point out the combinatorial complexity of just
>>>>>>>> those two recipes and probably there are even more combinations
>>>>>>>> to come when keeping the systemd expand from isar.
>>>>>>>> (which probably also makes sense for non (customized) initramfs
>>>>>>>> use
>>>>>>>> cases):
>>>>>>>> My current approach to streamline that (downstream) is by
>>>>>>>> utilizing a target-bootstrapper (kind of next-gen isar-installer).
>>>>>>>> That means, expansion is not a use case after installation for me
>>>>>>>> when running on target hardware, still, when deploying on vm!
>>>>>>>> Similar combinations apply for encryption, not necessarily
>>>>>>>> mapping the ones for expansion.
>>>>>>>> I am aware of the target-bootstrapping/installer approach is not
>>>>>>>> desired for many other scenarios (e.g. vm, sd-card based
>>>>>>>> installs,
>>>>>>>> ...) but it already shows a good amount of combinations.
>>>>>>>>
>>>>>>>> Apart from that, not related to the initial problem, but maybe
>>>>>>>> something to keep in mind when refactoring/reviewing the existing
>>>>>>>> implementation: The current implementation will potentially break
>>>>>>>> the rollback capability on upgrades from systems without
>>>>>>>> encryption yet in case of full disk encryption.
>>>>>>>> To mitigate such for upgrades of unencrypted systems to use
>>>>>>>> encryption, we must encrypt the partition relating to the current
>>>>>>>> initramfs only!
>>>>>>>
>>>>>>> IHMO Rollback should not be supported - this open opens a can of ... .
>>>>>
>>>>> I see. Fine for me.
>>>>> Then just ignore the part below: "Apart from that, not related to the initial problem,..."
>>>>>
>>>>>>
>>>>>> Right, I don't see that use case either. We are covering the initial provisioning use case here. Wiping everything is a different thing, and I would not address that as "rollback".
>>>>>
>>>>> Rollback in terms of A/B not in terms of wiping out.
>>>>>
>>>>
>>>> Then I do not get what you mean. A/B only comes into play after the first boot, thus after encryption has been established.
>>>
>>> 1. Assume you have a product based on isar-cip-core deployed in the field without
>>>    disk encryption enabled (initramfs was built without `OVERRIDES .=
>>> ":encrypt-partitions"`) 2. After some time the requirement for full disk encryption gets relevant, and the image get's updated
>>>    to support disk encryption (initramfs of update was built
>>> `OVERRIDES .= ":encrypt-partitions"` set)
>>
>> I know these requests but they can't be implemented securely (it's like trying to pull yourself out of a mire by your own hair [1]). Therefore, I don't see them in scope for isar-cip-core upstream.
>>
>> Jan
>>
>> [1]
>> https://en.wikipedia.org/wiki/M%C3%BCnchhausen_trilemma#/media/File:Muenchhausen_Herrfurth_7_500x789.jpg
> 
> Probably not :-)
> 
>>
>>> 3. Update .swu file gets applied with SWUpdate. Thus, passive
>>> partition (lets assume B_rootfs) gets overriden and a reboot happens 4. After the reboot we boot the new initramfs from efibootguard part (B_uki) with the initramfs-crypt-hook active.
>>> 5. A full disk encryption gets applied. This includes enryption of A_rootfs partition as well as B_rootfs partition, and data partitions.
>>> 6. Afterwards while finishing to boot B_uki using the B_rootfs we identify a problem / watchdog triggers / etc.
>>> 7. Reboot
>>> 8. efibootguard setting identifies we did not commit the install and
>>> falls back to boot from A_uki using A_rootfs 9. A_uki does not include utility for disk encryption, thus, cannot setup dm_crypt mapper accordingly, and fails.
>>> 10. Device bricked.
>>>
>>
>> --
>> Siemens AG, Technology
>> Linux Expert Center
>>
> 
> Coming back to the initial discussion (alt: TL;DR)...
> 
> I'd propose to:
> keep the initramfs-crypt-hook (incl. refactorings) in isar-cip-core,
> create an initramfs-expand-hook in isar,
> drop expand-on-first-boot from isar (replacing it with initramfs-expand-hook).

A stand-alone initramfs-based expansion would need extra configuration
at build time because it cannot find the target device without the
rootfs already being identified - which is not the case prio to
encryption. Therefore, it is best to model expansion as an additional
feature of the encrypt-on-first-boot thing. And the common case remains
expand-on-first-boot as systemd service.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

