Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425CD609A5
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 06:51:18 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.72])
 by mx.groups.io with SMTP id smtpd.web10.66357.1732690271881532065
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Nov 2024 22:51:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bPTf2Rvk;
 spf=pass (domain: siemens.com, ip: 40.107.241.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+g7h4IsyJxFzSzNWjIOS/VkRsLTXVMMmPhkADaZkBWKOEFZJiUuHho8wJFMuMC7pU8RfK2KF+KKOyN3IUjhfoLLR/z3YNYrl3XiS/yaKe5w4Q0428cHsTKfOdfzqoyL2dNKM8h7J2eK9eYVAB3w5XMMYXlElQboX/VUznDYJhiIh2I2iMILdCyq4v/bpj7ucLzsRllnm5RgsMHZ0wpjR0l09s0T6PeX33LqUrxj4ZuOTrW4YPsU+WHD1BTp39Iz9qJvyaE8kS8GH1ikRBRXNXBpLQqVJw98bNRzAKfoi6uJVHmjXIV1q8qajlXh25Ai7HhmueLEuOv2cmq3E924Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DqmOewMEtN8dJzcH9oM+wURLv03XZNjKbhtaC3BGVo=;
 b=oOpIPE7qGF+GbT+OuadSqekTv0cBIUxOClHDBPPBYVcWxSxz9mlH70FllenDir6OzFSslqZ77Rbm9uZasC1MyWDqafPT+vlRJ3HT2epbiRMid3Zww8yxDlUMCTKHLV8EYdnj5zLfNgyW7fqYsTGdYek+FobQXaJ5Bswqtn7RvoR8kmlv91DLB9QjyjR04yFh6rmmFw5DI4CcBapeFeh2w1U8jV+UDB4b9YxQKPcAv+7wLzFHg5WK5A2GyZSDv/ki7Uwmj3qGvCWC3qW9Msmj/BFL49/2p00HANsCDGZDMsScJCHkufYRs4AZHwmzo9LMkJ0ZgzQIrVbiPaoGcoe2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DqmOewMEtN8dJzcH9oM+wURLv03XZNjKbhtaC3BGVo=;
 b=bPTf2RvkwT5zQOK4MgkIQm+YgGyysQHfqb/2AOO2g4gIqSgUODuu7nQlHpMb7NSpS6pWMdUZ+T803CLmURtnFi9NFFn1gw1fHc+JGZGtHdbEvkeJPlVhmXunhgP3fAr4Uq2nUdq6bdrmXngA6HxSGM5ymuvlcvMjBTuJQUst3EquRFsDWr3X1qb5/XLKsoh9NzLGPvvn+4lxGeD/8Oz7SReE4qtIamVr9yEKZAE0qx/b8+M9M7zuHQD7GlKmUwcoVxPBiQ3A+zr/RC/OvZpsN5LXpztw35lp/bv/FAMk3y8H7edPImyZ+TZENncLQhz27724Xq1kjTrSvcykq5g5+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 06:51:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Wed, 27 Nov 2024
 06:51:08 +0000
Message-ID: <0622c0b8-223b-45bf-afbd-06d59c8ced6c@siemens.com>
Date: Wed, 27 Nov 2024 14:51:03 +0800
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip93,
 5.10.229-cip54-rt23
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 0314f7f1-d95b-48e9-36d8-08dd0eafdf01
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YnpzVGhwaXJYdDlZdkhScDF3b2dkMnArVGorNFNDR0d2dW9qUzZrQXpuWVJN?=
 =?utf-8?B?cGQxc2pGSXB6WkFQR29pVkpIKy9VTG9FVXRxQTRtTFVnWEdJVlRmcW1sVDNP?=
 =?utf-8?B?YzRydDh1bkJLdUF2Um5XWHVxSlhtbW0zRU1rVlhuMDYwTnRCSVJSbVhUWWJv?=
 =?utf-8?B?STBVNFlyaS92YllKWkZ5aDZab1RxWHl6SEZOeHdVWnc0bUJmMzZTUFI3dWVi?=
 =?utf-8?B?QnQybk5ENEZMa0VuN3RCWkNaQ1h0VnJ1VlNxakhFdnBHRGxQMnZFNGNNRHlz?=
 =?utf-8?B?cDhmeGJlbXZSTGNTNWMwTkVJTExuVXYvSldDbkZZKzF0MGRBUXpYTWZOQUtm?=
 =?utf-8?B?NDBhdGk2YmRmSUJwS3lsOGtSSkpOYVgrYUZySjlzc25uSk9XVlYyaTl0TDFp?=
 =?utf-8?B?Wi9INEw3MTVTNGJtMWtxeml6Nm5OZitES2JmUy9qZk5pY0NlMHdZc08xS3lI?=
 =?utf-8?B?MnY5Z3dWTzdLY3NZOWhuaXQzZXZBM2g2Q2c2b1VycVB4S0piaVNjaC9HUXJj?=
 =?utf-8?B?YzQ0T2JaOVZqZEZtVDNtemRMdmlXMjQ1UC9rZUVsVWxHc0o4dU1qSEM4aUk1?=
 =?utf-8?B?WGVLQ1MrUFZ6SERkeFZpT0kxaXRtK3p3aTJmOVFTTHNub3hxanVjVXlqY013?=
 =?utf-8?B?c2kwSnc5Y1BqT0I2L1pJcnEycVFCTS9BczJiMVZjSGpKSmFkdXhSd3RkVWp4?=
 =?utf-8?B?eVcyMGZSVWpyOU9UZnJtZkRSNVBsWVVDRmFIVGU0aFIvaVVYUlhKWXEvWmJu?=
 =?utf-8?B?ZVpnTnczU09FT0JsbjZLSEgvRFZ1eXV4bWR6WDlxS1o0R1ZYRUFSQlFFQjFT?=
 =?utf-8?B?MVI0Zzk5MEdVYUR2WTNSMWhFaHhOUkprTEhZOU5qTEl1SVM5R1ZFUGZ6UVUv?=
 =?utf-8?B?SHM4eGY5TlVTeVM4SGp1a1dnMk41TlNlMXVJaXNkVHphS1EzaFJmYmlrdFdN?=
 =?utf-8?B?N2hOc1VPVVBBRExQaEppNnVHREYvMmt1cHM1TS90OHBNOXAvYUpPbk9hT2tF?=
 =?utf-8?B?WmNLRjVmV2JCalhhOU1aU2taOFZ5UFdZTGhYMEM2NkY2SDFSTDY0dlJnU2F6?=
 =?utf-8?B?SnlBRkhPRG5MMGNKUHJTZE5qNHJDaHBMVTdRbG0yOWlzZnNrcUlXWENWUHVx?=
 =?utf-8?B?NUdzVzJWcU1idmRUMlpKaW81anJDSDlLb3pHUWJVdFJlRVVFSjlOdjJKN1dn?=
 =?utf-8?B?bmlJZWpXcERnWDhKL2M4Z25WTFhpRExObGJJSkxIZCtIbG1QRTdKS0JWakRr?=
 =?utf-8?B?b0ZqVTZJVE1haDBuNUdkVFZpeGdhR2pZWk9UUkg2eDZMTysyWmxOdFpGYjBL?=
 =?utf-8?B?WDNRUCtmbDFzVUdhSG0yTEY2a1RvR1AxL1BxZ0Q3aktkaVBaZGlyYTV2a2RO?=
 =?utf-8?B?T2tSd0c1emp6aGcxU3NpVzdKMkFlMkJqUHZPcGRiY042YXdvM1ROSkNwMGpY?=
 =?utf-8?B?emVPbld1WXZSSmNmTUd4ZmsyV1o2a1JHTEE4WGNuUlE3QTlUQXJFcW1ibytp?=
 =?utf-8?B?WW1XaFg5SUpNVzVjaVdycytVeWNIZVJsRjRlWkk2ODRCVEhNVTBHaGF4Kzh0?=
 =?utf-8?B?TXYxdGtXL0VheW9UeWREbXI4MzRtMStmL21PU0dXQU93VWlqSDZwRFJpOTlh?=
 =?utf-8?B?cUZnL3VudGUzdndDYlNDWGJIb1k5NzM1eWsvb2FWNnd6Qnc0WTJzem5hUHAx?=
 =?utf-8?B?WXZPVTVZZWhNM09RZW82ekc0dGZuNkdPZDlpTXN2R0lZeWlQV3hNVStmM0xI?=
 =?utf-8?B?YVhYdkNxNnprR1VGaUpyS29WS21RM0Zsb0ZWb0RDcDBzYk9mekNod0dSaDgv?=
 =?utf-8?B?cFowdkQxU3VqS3lzdHR6QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDRDOFRzcDNSa0RiSURKMENQeHluRGt2WEpzUEFFYkZRZzhhRVhTY1FvWXVx?=
 =?utf-8?B?TXlSWnptdHA3Z2VyU01paXA4NkcrTit4TXhLL1ZLU1BjWlp1RnptNGNsT2ZD?=
 =?utf-8?B?azF6UEZKSzdlR2dnUzJjZUhWcWdwYVpGKzlqY0xBbHFTYm5FZlllRjhmdE1T?=
 =?utf-8?B?V1NWdCt2OExDR2FtcXJpR0g2a2t5VnIzN3ExR2JmOXkvSVNUVm1IaFdFdjhU?=
 =?utf-8?B?dWtQOGVvdWJuZXlZOXpoN2RiTVJBZGFPRHhVYnB3QWpMaFlKcUtXL216SHlC?=
 =?utf-8?B?bTF5UFdEVXhlWjhvVWRIQURMbWg0VnZwbis5a2FHOXVOR04wVkt4VGk4eWo2?=
 =?utf-8?B?a2pxUVF3SnR1NTdQSEo4ZGF5c3VwUENZbzNJN21NVmJKRkl0aHZ3aE5ZSjZv?=
 =?utf-8?B?bDg0cjBkUStwQzVvWHBIbmgvZVc1bzdNeEcxQ2RJbCtYR3BrSDlBcVlTOE9p?=
 =?utf-8?B?eHJkakxwK0ZkMWRhN3VPeUpHWFJwckRBcGxGY2trTVhKME9ndW5pWFc5ZVRB?=
 =?utf-8?B?cGpwWUY2TU9yQlZkRktqRnJISUVaWWR3T0lFVWRsZFZSYThUYWEvYnBIRUJH?=
 =?utf-8?B?R0ZpdTUrNFpoYTdhUzlKemxmTFNGVm5TMGlMdmVDQVorMmZJL0lsc2dCOUxp?=
 =?utf-8?B?RVpMMWlJUi8vT0FySGsxL2RVWWNxMFJjR3Y5NGVzNU53TnF5d1ZmZHczN2Rz?=
 =?utf-8?B?N3lrTlVsQ0IzUE9XK21aRHlscHVtaG5QR3N3NTJFcTdQeDJML2dkSGJiRkc5?=
 =?utf-8?B?RE1qSEpyYVJvRmlYakxoMlY5cXpjVXRMd0hOQXRxb2ZJVGs5QnJBTmN0T29r?=
 =?utf-8?B?UXJ4aHM3cnpTVjdkcmsxK28zaUdFRThrUmhyeDMxYWlRaldzSldBWWxRdXdG?=
 =?utf-8?B?bk95Qm4weGdwS05pNG1jbGJOVzVIMnBUUXRkN1RxZlFjMmxFcDhHM3RaeXRW?=
 =?utf-8?B?b3E5a2JUbzVBQW5pZ0VyQlZlM2lMVzVhWXpXZS9xN25OSzY1TmNXQXRQK1FX?=
 =?utf-8?B?NVhEQ2ZjSDcrSm9OU2hITExmOXBkYkdQNEIyQUg2ZFRCa0tWMWtjZ041OEMw?=
 =?utf-8?B?YWhMbHptRUJ4NmppekxFMFgzVFFsVVExRlIwNytZYm9ibFVzNHdCRjRKQjY5?=
 =?utf-8?B?WkUrQUxDMk9MeEg2UTQzQTFjamdhSTl0Zk9iV0FrcTFOVERyYjFBUWZVdEZZ?=
 =?utf-8?B?VzBld0RPU3lTeFJMT0dvb2RzQ0pEcFB0VGJmQ1kxS0xiaW5QcnVQck5CT2NN?=
 =?utf-8?B?R3lLUTdBTU5EOTNVTklhNXlWSldHSlNJUmw0YkJCSEtWUm9KVzhBV3hVakNo?=
 =?utf-8?B?c2ZOMy9DN2lVZkxEM2VQbHNEcXZ4aURXWDNnbFdUNnhYWWQ4TzZJQjNEUXpG?=
 =?utf-8?B?ZHRuZ2RDOXdCNGN4dHduMVI2QXNGUE9YbStsK0ZOUzZ6YmNNSGt5SEY4RzVZ?=
 =?utf-8?B?SFdKNS9lNVUycWxlaTdQNTliN0dLbmZUSjd4QzYweGZEaFpVL1RqYjN2TjBk?=
 =?utf-8?B?Rm5DNEh2ZUd4TVhiQkxkSzFrK1RMZWRXNk1IWnkrU0lTSDRFeHAvSFo3S3Jh?=
 =?utf-8?B?RklVS0F6L1RXaU15azJlNEpTWkp6alZ1d3MyLy9DMGs2K1YzMzdJa1hNeVdW?=
 =?utf-8?B?dFF3OE5SYVRvSXNVcnFBUmcwVWkrSWhGL29VTnZ1RU96MGh1NHRHbUEyMklO?=
 =?utf-8?B?SElnWVVRd3N2Umd4aUdMU3RJREdiK3dwR20zdUJkU28wekxSZnl5K2xNSk15?=
 =?utf-8?B?T01wUTNrOGlwaFVONTdGbElGNzVyS0doZHlnY0VIN3N6VUh0U1F6ai9zb3VC?=
 =?utf-8?B?anlXalNtb0ZDbUo0a0ZLcW94TFhyTS9FM1F6aTlUdHcvNnRqWGJvNUNHTk5E?=
 =?utf-8?B?T0JucGdUckdxK2NmcUl6cmNxZzVZaDIwZXROazNvRXltTjVyZDNlTm1nUlpy?=
 =?utf-8?B?TTQ3MVVPUFVtRjZidWgrUVNmeUJJYk4rNHI4Y2Z1U1pJYlZQcC9oZUJQdEk0?=
 =?utf-8?B?V0hMQVU5cHdMTXpxay93UEtVSml1RVdpdTUvWWFtdHlVOUxQaGQwN25QdXBD?=
 =?utf-8?B?NG0rSWRtQzRONVkwN0dFc2RobnRrVEJ2QXQ4WE9WT3RTMzJ5QW9MT1VKTHRq?=
 =?utf-8?Q?ZU3xcbIzhcrQUHWJMut5paHbv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0314f7f1-d95b-48e9-36d8-08dd0eafdf01
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 06:51:08.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQz5Mj6W+9udAKDb/JbjjEvupClDBJV1HySXDSfmgE3U4vtI/UtkxaH8lE5lk2W+SkM0r829/jduyfpqY6HLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7051
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Nov 2024 06:51:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17285

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...10.224-cip52-rt22.bb => linux-cip-rt_5.10.229-cip54-rt23.bb} | 2 +-
 .../{linux-cip_4.4.302-cip92.bb => linux-cip_4.4.302-cip93.bb}  | 2 +-
 .../{linux-cip_6.1.115-cip31.bb => linux-cip_6.1.118-cip32.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.224-cip52-rt22.bb => linux-cip-rt_5.10.229-cip54-rt23.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip92.bb => linux-cip_4.4.302-cip93.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.115-cip31.bb => linux-cip_6.1.118-cip32.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.224-cip52-rt22.bb b/recipes-kernel/linux/linux-cip-rt_5.10.229-cip54-rt23.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.224-cip52-rt22.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.229-cip54-rt23.bb
index c8f6ce84..b4ed09f6 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.224-cip52-rt22.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.229-cip54-rt23.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "eaf443d103c2e5c28206f3141e643b86c5e5482e56b33acb7434d43224bb2891"
+SRC_URI[sha256sum] = "b2b1767a7c8fe41391bcdf508349c45bbb3b8fbdd4add031b0767d583d5c8738"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip92.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip93.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip93.bb
index 223dcbeb..7c080ae3 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip92.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip93.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5eae4b20ea63eeaacdeb11fa8ba17a7beb965711ded3e8bc316ca8250b807cb4"
+SRC_URI[sha256sum] = "4fc7c7364c410ed5dac752d2accba0f78b09c01322f321ec97b7a2880c5a40e4"
diff --git a/recipes-kernel/linux/linux-cip_6.1.115-cip31.bb b/recipes-kernel/linux/linux-cip_6.1.118-cip32.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.115-cip31.bb
rename to recipes-kernel/linux/linux-cip_6.1.118-cip32.bb
index 46944a8c..c6af0e65 100644
--- a/recipes-kernel/linux/linux-cip_6.1.115-cip31.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.118-cip32.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "a6661d623c565feacadd3702f5bc6b34d76db0cb47122a7d7e336af46ca262a7"
+SRC_URI[sha256sum] = "2823163be5f468631fe9ba0f889e2dd69fe27408cf9b39d19a6ed951a8508a84"
-- 
2.43.0

