Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C21C5ACB3
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 07:40:38 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.73])
 by mx.groups.io with SMTP id smtpd.web11.30795.1700552431880961304
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Nov 2023 23:40:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DiLGjJ9y;
 spf=pass (domain: siemens.com, ip: 40.107.7.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHIllfF73itFeBkVgDvay3Y2jj7CQU8EGzl+/Vd/7kV440/6nVff9j9YAIfm5ubbmSVMe+IlRBQRVh4+8EJOqoMIUNeT7qab/25SS/Ml69hzesJUEYkWK//5BGDDmtCjKTSv5i5wVIU9mDJVfCarZhxVg6vTkEDjR1cFYhgDs2F2r+E4Z/NHIH+iVtM7MeYX2xxVQg+4UwPu0Ib47LvYWzxEqqp8wiDuFO84aoMFwr14maNpsvnUO0J7GN+wKoBTdg46VJ17z6vwDFrfbhFUtEobLpTQuUqjfZk8xwr2ocKvMTabFrjMqVQqCFDSmVjffd6IqNjAe/zSWvZ5ualuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwJ4EeOE5mtvakGRNdKwlSL7DovoEIL+xtdMGFT/uY0=;
 b=U6tUoFLb1yjyX3s8nvyoFyx4DveuAWvkHXXGAtqn5cThDsnBzwfV2YJRC9+xF5isuZa9RyUdFViE7dh2/HjJDM5f5pK2V6nla1R/aoKoY6Lvwji8VAKL+99emDMHgKtZyEolcz7/CSHFXnYO4z61fdQ74Fcyf+RP6rvlKt9MjDo0bOUAIfYFv9NYuhadVyQt5DyfooN4DeeYPkshSidsuhPMrLWL/gSdJsf10XUwLIEuQrdhselQP4uT0B37chlQLA/p8ovZ2VT1YkwLgoTnxe7J7EmhAS6tPVI5ewfDWNNOdAbdKLBcMoOGelrkIvInjpQbhDTACHKGn6YMsUKByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwJ4EeOE5mtvakGRNdKwlSL7DovoEIL+xtdMGFT/uY0=;
 b=DiLGjJ9yPMxrVRRHBgh9mI+5WS9jHDkmQVvoCnuFd/nNDy6NpOK0+XvbjAByA5OtorfqpkGdNStLA7miyWtL4nFmFb/kfnPVVJ2uVMRu5i2f3hw7JcBkpsngrUOa2vSfv9du7HCv+6cFCpPL6p0qTGqiS9Bx60yrMCjrti2QJTzq196XgRrnYbTBqCPvrmx+WVQo4el3ozRsioBliJ2+BYh0bPIoUxlCAI40ZNd9sFxjngRtAgnNAtScINGW4rm9hMquV2UpgBSv6kxKTMQ8kmz8SaTIEjTWM0nuOKHrr2FW4n1fdsGD1JOHeZ8y8WJ3uh9dXFwiLW0yzTQXZdUBuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6870.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:40:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 07:40:28 +0000
Message-ID: <df0317e0-b9df-436e-b922-5ea5e9e9680c@siemens.com>
Date: Tue, 21 Nov 2023 15:40:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: 5.10.200-cip40-rt17 (rt97) update -- not easy
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
References: <ZVsslmgICGwnNkdT@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZVsslmgICGwnNkdT@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 5568dad8-ec9c-4b4d-7e60-08dbea6521b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ejY+VJ00rXHQeGOXyOWJXy07tqFnyrIy3XRKRUQYVmF+LxSXhANnZozhfYDLR9hlxko8EsuelxXMuFxMcinbYtwmoUs0gAiUlrlcfNdoX/ae+9JV0wG+M56PSdBxhScG6GlF5mcPi+GzDEfnPZFItm1HcD28gpfYGEAn9K1oJvHPPxERTwUajMsKB8/UYtTfGNBbAYnE+wT+g8h7V5UxiCCXEg5b4sPtfe6R7GU8JOZiQXXyPk0E83Nkn7JcOM3pSRjxbvOKE5I92N1ARBplYZya0rtM2cTMDTu9SoIQdZYRlPEWnNtHzLt4bM05uiWBZL3QgHepkGwdbDYEgZ7q2VQYab1EQKRDbO0gNWTap/IMgHntpn+MuOEUFh79O3DmOsq8kIVnPsN/6bnScKJ1tMPz9TvsRWzQevgJuPwHB9MnWWe4colqrCcSqF0ERj1FrZjRtmP89HCSi03oie4q8FfKyOcanSbIq06kOkzTwMTSMAsbS3Y4clCZdkaxSNwXxlNUvxmD0Gr/0WDDHNTlAgwQX4Tih1d/DIFGRW/z5T+L79dSS0Fxc6AqwVB29FxWWnaR61abRRJkbh9qi8eElLD0Y/M8bIg1CYZfnGCqtNdGVay1zbNhEVfSDGoPtQPII61rfBM0BZ729VNoniBniw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(83380400001)(82960400001)(31696002)(86362001)(36756003)(41300700001)(66946007)(66556008)(66476007)(316002)(8676002)(8936002)(5660300002)(15650500001)(4744005)(2906002)(44832011)(31686004)(53546011)(6512007)(26005)(2616005)(6486002)(6666004)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmVqUm5ad1hDQTN0SUNBVGUweXlFM1pBc1dqTitSSDBZN2U2RXRCa3hReUF3?=
 =?utf-8?B?cUJFWWxnbXExT2FSR20wcXNGVVl2V0dteFYzall5c2U2SlpPSDdrWGdDTWFV?=
 =?utf-8?B?dzVHREFlbHFjMjVHMW5oV2hoak9EQlZwQ3NlK0hoOE11RnY5MmlzSmRYMnVG?=
 =?utf-8?B?cnA1UkVOTzdRVEkyNkw2MG96cFNUL1NQbDlXU01PdjJBOE0rVXgvZnBNbUdY?=
 =?utf-8?B?QW1wL0V2VjdPNy9hdEQxS1VxdVEwVmk5RlQzYkgwK0pDZUs5OEpMaEhuQk1J?=
 =?utf-8?B?YmprdzBjZnJZS2Q3V2FtSWxBazdSbDBhS2FSN3pPNCswZTVwelBhWDFJbnQ1?=
 =?utf-8?B?cERNamNITXhKNWgwOGJ6UW1HNDBPNkh2Tms2Q3B5d0VRNGlHdWdtVEd0b0l6?=
 =?utf-8?B?UzZUUEVMdmxiN3NuWE5RSjh2QjR3bzF3M3VxWCtuTmh1eTZNU2FQbEFqbEhD?=
 =?utf-8?B?STVaczBuVmV1ZU0zRlVsZ0hzVFl6M0VtcllaV3kxMmJQeHZoMWcvTlJqb20w?=
 =?utf-8?B?OHJyTHBPUVJaNmtkdUs2QUI5a0hxaTRweTQ0ODBMbE1oSm9RWFpvMExIRk1y?=
 =?utf-8?B?c1d3RndjbWxxbjFKRFZLaElLWEg4bGgzb2lyNkgweFV3WmZzb2RyMmp1ek1k?=
 =?utf-8?B?aTdnVHNvbUZhQk4xcWtYdDFMZ1ZwREMvU3czMUJLRGgyUmFKcjBiRkwrb1ZT?=
 =?utf-8?B?bElmcEd0Qlg0aUlrYVNRbC90dy9Da1JqakhTaWlrQXhGOHlZS1FFVmJqSFVx?=
 =?utf-8?B?U2ZvRVNEK2ZkUHZhMzk0Z2dFdUZhNE16NUIwdWpzM2UzRzQrc2R0Z0tIL1pP?=
 =?utf-8?B?NnR4L2hYWlVzd1crazFYb3U5b2VLb010NkdNL1BWVnNwSWlhbFlDUXdKUXZV?=
 =?utf-8?B?N2JHaFBuYTVHUFErT05SeDAvaTNIc0NYVHNCTHZKblNON1ovUGRzNE96WEVn?=
 =?utf-8?B?NU4vQTlNdE4vU1l6ZmR6V3BjVkNMbEtSdzV2R0ZkbHF3RXhBSjdaakxaekVa?=
 =?utf-8?B?UTBybEVobjVFeFBSOG9rYUNOTk9RQ2lCblMwcTFweWQ5TnhLamJEbHFxMW01?=
 =?utf-8?B?YkpmbHFiOGFGajY3amRCQUNTOTA3dTNSZHFOeUFTVjJ4cEQ1SDUvdnBJUUVO?=
 =?utf-8?B?b0c0RE5nS2doOEdFSlNwME5FUllxSDc4SHJzZjF6SXdJQWk3cGppRmlGRzhG?=
 =?utf-8?B?VFhWaGVJN2ZYNUpKZzRZb3pwVjQ4eXpyNHJLYVNXd2NvUjVUTFdvdE94a3o1?=
 =?utf-8?B?ZTgzTHl6K2xlUFpFQkUraGo4S3B6RXhUbnVadjdGWnhiU2VuTGpKbzE4bnVF?=
 =?utf-8?B?RlNFUFp2WUpENzgra2psc0laakFjbml6VlU5aGJtYnZ1UCtUU2NjeHlNOERs?=
 =?utf-8?B?SS9ERkJFZ1NuUVVGYVRQdXk2dEFDcVBSaVpLNHpPUk9ZYms2SW1DcTNxL3NJ?=
 =?utf-8?B?bmRaOHQvc0VBYmcvS09vaEJRUk5vek1BK2pPSklFb2E4WjZPU0RxdnQxQzVG?=
 =?utf-8?B?cmNUa3FabUlQT1FJNkc5TkNMYTN5d3lLVWVkTHU4R05CU0w2YWMzMWV2YXhz?=
 =?utf-8?B?VVBNcStTTkY5bm9XSjBhTm1sZHVuSEJDY0dIL1owNHFESDdsNkZTYnFBWDB2?=
 =?utf-8?B?Zy83cHJITzdzajRlM1lVbW1GUmR2Qmx3STZUMFREUmpNMS8xRkwwRzc0TnlF?=
 =?utf-8?B?SE5Sbm1wZU5oaUN4UnA2blBiNEhOZkVmVlhBakhWOXpkQ3dXZmptYlYvWU1r?=
 =?utf-8?B?SzF2WWJ0cDNuZk1mM1gvaGNDdmk5QUdnTkJBSWZQV1VYM0dFUFVURTF5YnFp?=
 =?utf-8?B?b0FweHkzTTRLK3NSOVM1UjUxUDR2SnZieFhwWG45ZG81VDNiSHZlczJtOGc2?=
 =?utf-8?B?SkRaamordmVxempyUHdvbEJ3Tm83dHRxQmNaRXcwcy9xck5TVzNNelNoclhK?=
 =?utf-8?B?QmhqbmVBR3NIRy8wSVE0MmdMVnFWT1lDRzZWTng0VUpsODZxUE9UVHMwVHJW?=
 =?utf-8?B?U1JqNlJTTW5POGpzUldWNkp2Mnl1bUI3d2sxbjR3NXZZZmNKSHRFTXRzVEJB?=
 =?utf-8?B?bWpJejJvUmpRRzM2Y1BUdVhZemgyQURVZGk2TVhEM09XalJsVkg4a3dhQTlt?=
 =?utf-8?B?ZEYrSDI1V2sveFZ0YlRudUpmU1lGdVZuVmt4azdpaG4zS1FIZm1TRjlzc3Ft?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5568dad8-ec9c-4b4d-7e60-08dbea6521b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:40:28.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPbeS+41/hSFiib8/cXHGY+WMLlIT5l+p+SxLyUNlYsrLvLRH+M3hwDW4ghWbwNXNvVLTyQ0237Vsp93zSEwCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6870
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Nov 2023 07:40:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13607

On 20.11.23 10:53, Pavel Machek wrote:
> Hi!
> 
> I tried to prepare 5.10.200-cip40-rt17 (rt97) update, but I don't know
> how to verify it. Problem is that regular release and rt releases are
> based on different -stable release, thus can't be compared easily.

Are you normally merging in the -rt tree?

> 
> I have 5.10.200-cip40 and v5.10.199-rt97. In -cip branch, I have to
> combine them, and result will be 5.10.200-cip40 (rt97). But we have
> -cip-rebase which is "on top" of rt. And rt is on 5.10.199, so I get
> 5.10.199-cip40 (rt97), which is obviously different trees.
> 

How about creating a temporary tree that merges 5.10.200-cip40 into
v5.10.199-rt97? That should give no major conflicts (knock-on-wood), and
you could compare the desired update route against that.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


