Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F87C61DC2
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:21 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27266.1787677218365246868
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 10:00:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=klPvDm9e;
 spf=pass (domain: siemens.com, ip: 52.101.72.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI8ULPDgZLEEpJ6ov9QCsgrL9uHSxSGZqpfXNXKL+X0C2dWUvGAUIIFJzfyeXBBHyJXhoY5NDhTuM4Hppj1FOxbrBi/Fm2TNZ9rScuUXstKHNhw6t7q0nzHN6kEafdFWqoFdEs6vOmfpqGdnZXHQBGk1lqT77ONM63ZSOKM2AkxhxNUmfu1x9S7M8Q+iaKo80SFzyZDfjWejBSgTTChisVW6EnlYrwlnEfDuElQuWxCvQpDX7lKgX8C0wBVHd+w2q2qW0EiEeoUCp9gORFbYDxGtJDOZcg3OlyPGN2Z5XU+83155XI5bB64X3dqWypsa4X6+CLhWd3NIE0eAa4DUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/lV8NNz36U2FnOQtFPnDAJ+LVuxq4zr8TPdkPDlg64=;
 b=WeE4BWRxfcfFxPgb1nd/VYaumCbca92fVjbLnLmYBFStNSkNoSKvkwy8GJdtaEEFROJAmLC+SKT7ODCbL/mSuP6GOVvklgVcdS1hmrEdJmCSTqZ8APt4dQ1vL0vkMaMjEMOF4ET9SQtdbRLrbvbIxPLRl62opHZsv80cHAnjyCEekTN+W4zuVHH2tk06kw9M/Pdh0NOzA6njUkUzvoki4BxnCZ+t0R157f1EFBDD/oKV/sJF7BMwW1tL4BYNJpcAAxTJ8KrCp9LhsT2TDqQQwZLJ+h3kgPrchh8ZygigAe+Vl7Y+VjNU627dTc1wCUONIAu806cKdZVBKJAfLyjMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/lV8NNz36U2FnOQtFPnDAJ+LVuxq4zr8TPdkPDlg64=;
 b=klPvDm9eXao3FrXTjZiGSNz2tzJuo0HqFyQd8sYxXij1jixBEkXf5lyVRhkncjrL+HYPy2yN0SNlPAsoByU0IpSjwzjW+EDpp4kdd3K3bvKhAq+Molz/dn1lFw+0hlgBtGThOlMLPfognmtqLnBdAnwCzlgZFulJvIoG2Zo/WgmeFf74pqGSSKh+IoPv4SJghppTeiCVhCuM+2124wofZkakmIMpFxuYD6l5x4KmDhECZEszPOXIV/AtvWkXQXwQ8dlDAayszqtYFpSPbG6pCxrsPnBgmOVFRDNHdx5p5vsg9aV4julSPTUa7RmKEDyH08/vUO2fK27R2DmjnIPKMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7896.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:369::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:00:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:00:14 +0000
Message-ID: <5cbd3567-d84b-4a87-a029-b6bfc0ac2b43@siemens.com>
Date: Tue, 25 Aug 2026 19:00:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 07/12] Add class for validating
 the CIS options in the kernel config
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 clara.kowalsky@siemens.com, christoph.steiger@siemens.com,
 dinesh.kumar@toshiba-tsip.com
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
 <20260824094721.2636375-8-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260824094721.2636375-8-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: d2efa749-0edd-4203-ef44-08df02ca5514
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|4143699003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	YduYs7UVdRri2RKQYxGE8hb4PgKR81oltPqUbkKg+QW8Ur7vG8qHavC6ZQ9+vHxM0m8FrZNx5vcpN9+nbHOoW8sGmSZyrAvhFBO0qs9jV+S7MCtKGmtLWP1oeF4+QLRo+AGW54m9mPOnYmNMde672spvbfQ6P5boFnFDlEoBTlR7bS6OtagzzFxE3xmB/SnjIYNGt+uo4gqjk9ADx30Tet48e/d9v5wtpwj23qWQQAEpvubScXq8Ks1Quct4t0lj56VBEnIr9nlbUmZirVBYTtb0MUB6w3vlsgGWMWBRRGS5sva5JIRjtZb6ILDKLnDvd2xdAP+tc00aBMCmHpaUEZi575V+mTkvPRwGRTV4wVDC+AKxgPAGYmnjG6f4jRp2NUfvjUSgkcLNelWws9NXHnNyp+xlgeL+AMkris3qWYltbcwFhfA4rEqp+Icy3i0IsvRAYQI7uBd40Pi9zAQOgl8WKdJe6r5Vsjo1hOyRRfypXUggv+6RfZEMeeMhK25XIyF/zLwqGU0d37LPFjqeWyNeTrBZHFYWy8J6bejvFdLmolncEtme7+uZKZcH56PJ1uLWCKajNdcs4xKXOuvOat7EZmoKxMBw2lHUdnwYsyElO0V72KSayrrOqEazsxxywj8rNqh90TUWg/VNDadAJdfI147/QZFJa+4ZVSZvipc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SXQxb09qVHdwS2lpTkZ5a1JwQlBiWGpsWlNieVBTZDRTMDdHTkZNa0ZqWlJn?=
 =?utf-8?B?UkhXQVJtenJwRkZyTCszUFhlMGRwdXd4OE4rYUhYMGZqWCtCSVJydzVsUjVF?=
 =?utf-8?B?eHljM2dwUGFYd0Zla201bGFsaU9TVkQvZ1p5MXVKQXp6RlQxL0ZYNUVmaEZi?=
 =?utf-8?B?OEJZUWtaT2VuUmE4TXRVeVZSaXY0U0V5eGZGdWF1YzhxMmd2WjNmRWZhWnhI?=
 =?utf-8?B?S2VzYXlkajFQZ2gzNW5wUkVzTnZQam9NT2FkbnJCOXZxZFdwVUFJaGV2eit1?=
 =?utf-8?B?VVNzcWxtWnladWVreUp6RHVBZjVnQjZjUGtITTF3dHA2eEFQVDlIVHMwT2Mv?=
 =?utf-8?B?d05BRDU5WmdJWVU4SlFwUGNpVGtESnVIbFFzL3EwWEYrKzljVkZDc3lCYlor?=
 =?utf-8?B?amkzY05TSXd2amhBMnBqZ0hLSzk3SnUzNndFZmQxTmMwUEVTMDJpQWxuV1Bw?=
 =?utf-8?B?ZDJrWWNkcDQ5bG9zQUc5c2tYY2VuSkJyUXBTbjZTaktlNDZzcXAzRFpGbUdK?=
 =?utf-8?B?czRyeXp3cncrS2lacmNJbmFCdEJWZUZEQ1psTmJYMzZLYUhmRlBqVjA4MXY4?=
 =?utf-8?B?QTc0RkdMNVJhL0lCdnlXZitoK3g3SFgyWXk0YzBpNEZqVjJGSW1uWGpqazlI?=
 =?utf-8?B?U05zbzJXdW9PTllKb3lMV0JHTlRreWtYUzhZb3JKc1FxTmJRUDNIWHpsSk1I?=
 =?utf-8?B?TGlvMnlycTZFMzJYaUxtYllvV0hIa2h2ZnBvaGJST3RxWUpqYzhZWno4U1g3?=
 =?utf-8?B?dDQ5N3NmV0RvUmx1SytrSnFuOG1RckUvM0p3T0ZOcUh3ZXdoMVVVNk84Tjln?=
 =?utf-8?B?ZWwvdE9GNnFwcVppUzNYdUplM2l6VXlHKzI2L0UvWFcyM2M1aHdMSFRNQUZO?=
 =?utf-8?B?WjJvbGtNdHlieEEvcXBkMkh2YnFkRjhvWXdZZDE1TzlqRG9hSU5aL0RLRm5S?=
 =?utf-8?B?SVFwY3ZDM0hmV2pISU1SNml1YUVybHZUNGp2UlF0c044Wlhaako2ZXpDUS9K?=
 =?utf-8?B?TnFmdlpWTDVsY0N1VTA0b0NGSDNnN1BNY05EOXp3czBuNkM1bGpWMFI2RzhC?=
 =?utf-8?B?UjhDNHV0TlUvczVpaVdMMkp2TVhSUUM0QTN5ellRNnNYNlpYMUpwNlNSY053?=
 =?utf-8?B?SXlGRHNKQWQ2SGQzWWh2bmU4YzY2V0EyOGRxSDdtREpjM3NOSXFMVEFPNVBw?=
 =?utf-8?B?a2dkNFJnaTlUSTBzREdnMDF6QWVyZVVNcTNZOTFhR1l1K05QNjlncHg4eUhp?=
 =?utf-8?B?dDdDVEJOaElqRkdtblRzQU1yclZQVGdaS3J1dVd6V2JzZzE1eWpaM3ppcnVK?=
 =?utf-8?B?R0lVRm1jSUk5cUVVbndOZytXdlFKcXY0UDArRkY1YTBUb2wvc0FDK0Z6UHpN?=
 =?utf-8?B?S2JOSHZLNFdZUWFzNUxvWG1sc0xzTE9YOThxMHZvL2VVc2VSRUpuTjJIeUNn?=
 =?utf-8?B?aXorN24zZnM5OXBnQjNsNHJxWVkzZ05yemx2Wk0zMnF1Zk5wbllsSnRwNVN6?=
 =?utf-8?B?dGc4MmI5Q3RuY21uV3NUcHpGQ0dnRm1UWXRTMVlkb0ZtMUZSZkxUL0k0UEFi?=
 =?utf-8?B?aDFxQXJHWWI2T0NYQ2VuYkY5Z21Cc0paM2NmdHNZSTRBUlo0dUdYY3BRS1Fy?=
 =?utf-8?B?R1Q1WlUrQlVEL0xieGhrcHdsMkxnWE8xK0tET05FUzZ5RTBSSE5POUlXMnRW?=
 =?utf-8?B?RStVMUZPK2FZalF5YTBRRW9iUVVZeUVEcndvR2U2WGNIY1J6ZmZOTGUxUzk5?=
 =?utf-8?B?cEJHQXBkQy9yU3N6T3hYdXdLMkp4OXRYc2FzWEt1ejNDRm1PNVJrcTg0S0tr?=
 =?utf-8?B?eWVMMkxyaUV5Y1VlUlRGMGFwQzkwWUhWZVo0OTFGTDJwTk1hbmltMFFhTFN1?=
 =?utf-8?B?a1BnblM5d1QwKzlPRU55VkFyaUh2YVRwSkZKSTA2b2tVZ2ZGWUpWYm9HY3dm?=
 =?utf-8?B?WGRLYWRCZDZlOWVhTCtnbXJ1Zzl2VVRVSUJJRjRHQ3dvWEhONExEc0dveFVL?=
 =?utf-8?B?cVd0WVhLa2dNNk1LcXlFK0RjUlVlZXJnZGpCQUVoeWhlTUZLTGo2QmhSekFR?=
 =?utf-8?B?TDAvWit2WnZvNmdlcmxUUEZvUnIveDZicmlkYytUZTE3enBNeHhDWW5XQ2lZ?=
 =?utf-8?B?YVhhMHBqVWRIYXMyVllURDFIZW56ZWVLYVJhR0JrYzNsMnk3eWFXWjFDdmJP?=
 =?utf-8?B?RlVTMXpHTlc1b01YZlA5a1RKYTVkS1dnY1BaeWNzSGorWFRldGZKZHlpdC9W?=
 =?utf-8?B?a24wVUNSbzU4M3NROUQ5YTlwUm1tcmV4b3dOZTNzTUdHamhIeWI4QkdHMWRU?=
 =?utf-8?B?YWQrNVd4VW01ZTh3Q0lQc1FpOUtQVUtOU2d6L1NHd2JIa2N2Rzg3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2efa749-0edd-4203-ef44-08df02ca5514
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:00:14.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgPVg9AufXfLygysr0qvMO/JRahYKqiwSoNSymcI54+/kVZ5aLCTLRLR2+7JSYLHFonpeGNo2jQXQzfAfjK2Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7896
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 17:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24004

On 24.08.26 11:46, Quirin Gylstorff wrote:
> If CIS hardening options have been configured that change the
> kernel configuration, this class checks whether the correct options
> are selected in the resulting kernel configuration in ROOTFSDIR.

I think I already pointed out that checking for some random file in the
rootfs is NOT reliable, specifically when there is no config deployed.
Please check the config that was used to build the kernel, possibly
leaving "signature" if the check passed which can then also be
runtime-validated (if that is really needed).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

