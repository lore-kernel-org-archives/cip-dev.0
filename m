Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61483C28B2E
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 05:57:47 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.32])
 by mx.groups.io with SMTP id smtpd.web11.2340.1741672665823646030
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 22:57:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i8oYdZlX;
 spf=pass (domain: siemens.com, ip: 40.107.162.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHFxnlcZ0519JR9X7wx83mpXfItkml3mwHC6oRub3YeK8iu84l92FqNqQInCe9Hnn/9kP3dibCQaMRT/X6F8KqlU28AdnxyeyAKFjn6TdLQF3PxJbmW4ZKUylP5V0fcSgmJbTHdflKkC1NqBKivqyOYTg98jNU+frKKHKRw1CO7fw1Q1vETuk2z4W5N4Owc3baK7zud+5bHYmN4tkWYNC/gTWFWzjPeUNzqQWXzz+ml++hgCASHw7HPXODuW1IfWvZazWV+SMi7yPMLnD6y5FmlueGbFTT9hmZt5QH6uNp5nS9CETd4k+rV+FGR9Pxf9lXxYLBo5fEECG5bCaSrJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wtX6pt5/vWOkooF/3aIJkaFS1JvI+ojfOlP7Z+TALM=;
 b=e/CMebqsnhB43RvOsXhQwDhzTJnpuJzn/P5UeC0OtDBqS0HeCk0qGDyceXGUiGfJFrvmEDvOMDcUGysZY3LL3GAe0nTM9IHLjXGa/MJEbKQ17HReTnwUXNOb44l3eyHJ6DF/2CTSMsk2SD8gWgpck1ssiyrSpbL9LJiJyl2jgGijCf1mI0eopLYWzwMy1hgXXggYzUnBoEDhi4kS3Zn33x5CnwLN0eiCbinnLZfVpyWQc/5/rlpJXjCzX+kSJSyze1pojFFxDdmIIMZ3UdFSe8og5KE4Ncr4BLUqNrimLawQ+4FaRFK0XcK6lmWFCPRK1Zw7tgh5iCwVSaAuCXfDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wtX6pt5/vWOkooF/3aIJkaFS1JvI+ojfOlP7Z+TALM=;
 b=i8oYdZlX8ZYBcOeA6UJCcGhpSktGzoPjPCvhgM4znCPSIJFVqh0vFnHjtl5mcVtrrJCqcVDePjeFAIoPeFtiSWg74aE3oiytqPvlgLWf3S9zARaXWPiZS46HASQBlPJZtFykrWUb3QrOn8NBxLtYdbWrqA9qcJDnMuXn8YM4HdC4H9RVxdIIzp9Bq0wURbAGcjEGqqMXzotZbi1ufBnjxQt8AEAFNzU9oiqlw3+4kXq9Kp8P6MDhGEFz2fYgzrpNUqZ7RZEeAUePqg2V24zgyAAwB1HBu+wGrErvUktNAucYMknUwr5gybP6OccwMnaZ/1yd+Z96rkzlcHkOfRL5ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9153.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 05:57:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 05:57:39 +0000
Message-ID: <6cc51480-03b6-4d42-b9c4-191b6bc17e0a@siemens.com>
Date: Tue, 11 Mar 2025 06:57:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.7-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
X-Mozilla-News-Host: news://news://nntp.lore.kernel.org:119
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5b75ee-13a4-4488-6e57-08dd6061a1a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aFZRMEZ3Yk9sOU5Yd28zVWZHckQ4a2tKQTZIWjVHU2RLK3FGY3pMYW1RRWpW?=
 =?utf-8?B?NHBTZnJUNWFBdGlXTkx0L0VDUEN1MUYwK1dqV0d5SklFSzdmMWRpaVY0Qkgv?=
 =?utf-8?B?L0NqWUV1K1BDYVpiQ3NzallkWmJkTENxbTN6SUZFYWo3ZmRjMzBsdkZlRjNJ?=
 =?utf-8?B?TnBIM213OXd5SnRRSzF4ZUdNK2JIdmdxcDh0akpvRWVLbTZUVmFleHZEeWFa?=
 =?utf-8?B?OWEvSStLbTdNSlJ1dzRjcFZKUUxxaktjdjVGZEJKVjBsWkxlMDJkUHNNaVhm?=
 =?utf-8?B?YWJZVWpielVONFR1Tm95WUpkNDFqM0xubDg3UFBwNDVFTnZha1ZsZjh5MjZ4?=
 =?utf-8?B?Wmt6OXBrR05aMHk3dTcyRitOMThDVkhlMzZZTFNXYVgzQTl2ZS9WVkJsTzIw?=
 =?utf-8?B?alJ5T0NOZnA2NjNBeVd6bDljVnBYNGNOZXBMSXg4dldFZ3VPdHBhS2RsYnp1?=
 =?utf-8?B?Q25taFg5NEJqdStUR2g3cFMrZ3NXelBRVnIxUUZZMnE2dDk2RmR6QUVPd1p1?=
 =?utf-8?B?SlhZRy9TRHk0ZnY2WVliN3k2dUkzaVh2WnUzWWRjVWFMdzRESWFVWnJQelds?=
 =?utf-8?B?bVZRNkNGT3N0NkRYc2lhd2ozM0FQZmhQcE1oUWVGWGZKTG1LVklPcXhTcEZI?=
 =?utf-8?B?alIxa09tNEdIZUg5MkZtUnpHeFZEQTQrMy9YTGJBeUU3RnFoU0c2WVpSS2pH?=
 =?utf-8?B?UktaTkY2VmtPSkRNRk1Jd0NKM0tzNk5UMWdwcXd5ay9sSVRISUVRcmNUSHJO?=
 =?utf-8?B?QjVUNUVtcTN0dUlqVi9jZ0pvMVdvT3poVFU2Wm1oNW5SWTI1U01qalYveFFN?=
 =?utf-8?B?QkNNR3U1bWhOaWdNdEh0MythR3FNVDdYRmlFek11ZmdJd0Y3WlcvSkg0MGdG?=
 =?utf-8?B?S29Lck1sdnE0TjRjc2NKcVYxcFExSXk5R2pxQWE1VktyU0UzbjNlSTNGUXhI?=
 =?utf-8?B?Ykg3N3I3MEtQRFhRcUxoaCs0SzJHU1U0UG9RTi9vVXFoVmgyc3JDemc5cWRq?=
 =?utf-8?B?bC9PVEMwSmYxZTNRQzcxbW9WSy9UbFVqUzBwVXJFN0RSck9nRy9lb0h4aS9W?=
 =?utf-8?B?K0YyTnBPVFAzZURJNmJySFNTTDFDd3pvbWFSckl3U3JhNENxWGc0N1VpYmdV?=
 =?utf-8?B?U2UrMHhBMW42aDVQUWVHbFV3dDhjWGRCT0djYlNHdWY1YlVadUNtaE9wUnR2?=
 =?utf-8?B?Znk1d0x1dW9oMytnOENBZ3g4cG9SMjQzeEN4NDBnQk9LTWU1b3RpcEpiOC9w?=
 =?utf-8?B?d3oxSjRHckdCUnFjaU5LR3NBRFRoUEV4YTlxM3RoYnZlT2NQR2VJZWRGUThx?=
 =?utf-8?B?dzdTL09nZUZRZ1U5R2hydDV4OTF0ZWNLRXVkVytXL1VLelFLL1MrNTllZVhz?=
 =?utf-8?B?TmhIVGV5RVd4OWZPdzNlY0t4cjBxYms1SGg4bjQ5Mm10WDFvbkNUbmxqeUs3?=
 =?utf-8?B?emxTY1BQajJwSjJoVlJ2RC9iWnVmck1ZYk94WEFoNTIvNGZ6OGJ2TnlrUkt2?=
 =?utf-8?B?RUY5T29EZFFMNFErbVVxRFpYSWJsU2duTGFUaXZQSE4xN0V1NjB2dmtoNXl5?=
 =?utf-8?B?ayt2Rm1WQUR2LzRQK2ZxdFdSMjU4MzRmTzV0L1RlSk4vMVRYMmJVNExwNDBR?=
 =?utf-8?B?bTErU1V2c0VlbENEUGJVZ2QrS1JoeS9vOXp0aEEzanBTbC8xcXI3NU12RFFo?=
 =?utf-8?B?QTRlbHhtd1lsZkd0SDNiTmxMb3piRWtDczdPYnRSTGNXUGQwK2YzY2xyYWJY?=
 =?utf-8?Q?E9kqBMnDVhDkGwWeCT2cvliTT0jPj+MDfFY7jPA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c29XVngyM3BrakZITUdUWEQwdmpXZjJxSWE0RnpZbHdZemlRWGJCNXIzdkFL?=
 =?utf-8?B?WFgzYzVNVjNob20zMUlvZkZSQm9mZ1ExejgwSnB4U1FkOC9VREMrS0ZlZThX?=
 =?utf-8?B?Tk9ncDVhVk5CTW4yU0tLeTVGdkxJNDRGNjlzYUtOQjYvdHVDdi8yNjJLaStm?=
 =?utf-8?B?NFl5NUUrc09BcHFWZG13VUIxT1lkVEYyR2ROS1dmN1RkRWZWaHZzbVhoeEJG?=
 =?utf-8?B?a2FpRWtlUWtvcER2QU5ReHRRUUtQR1ArWkZicmVrekhWMTVLS1hCM3c2MzZB?=
 =?utf-8?B?QzQwd1hzY1pRb3lhWWZtZG1XeTNlVTlxaHQ4bFNWT3lkd1pOYWl6TnRUSlR6?=
 =?utf-8?B?ME83MDcyaWJCODcwZVUvaFcxcTVZMWo4UHNZaVAyemhPQTBYVExpMnZCa3hZ?=
 =?utf-8?B?c2pnN3lkNGhXaDNibFhDWjJzZ21qQ3JpMVBZWm9RWFRNeE5iOXBzbmljSEsr?=
 =?utf-8?B?Q3VyeVRVbkMrVFhab2VFZGQySXJtdWhTL0xGQTg1VlBBVlY1WHE0NlQwbXNa?=
 =?utf-8?B?bU1iMjFaclRmTWg2d3ZCN01UOTJ3YVNxM0ExRGRjd2FkSUNPTUMzZnBkNVE2?=
 =?utf-8?B?eW8yTVl6SmJRZ21FMVE1TkhHTUJZMW5aeXJNUmhHSGQ5Uk9KakVkN205QlhX?=
 =?utf-8?B?UFBSUm1KL3RIYmF3Y3B2RmhmdmwwQnkxKy9ERWtha0xsOFF2cEl4bWxybmM2?=
 =?utf-8?B?US95a0g0WEQvQzFnemdtVGwxN3UzRGFNbTNpMW1rL1BPd1Q2bkF1TW5QZ20x?=
 =?utf-8?B?T01vMnMyMDEwZUxRajZRSzk0VDkvKzRuUlhTeWREUXJxMGpQK2ZFYS80cnhE?=
 =?utf-8?B?ZzIxVFlRZnlMU2g2SlowbkZkRVNlVzZFTjM5c3hGczlPOWZiVFgxdUYzdll3?=
 =?utf-8?B?elIzdGZrNitHelFlL3RoRWFVL05DQUFPSkNxajNQK1ZwQ0NPS01GeHU0cEFL?=
 =?utf-8?B?VFY3NitFaExYanNtUEtpV3ZNV0N3bTFPZlozMjduZ0t3VkJmYTcvOWtmczFs?=
 =?utf-8?B?MStua3NzUC94L0FPd0J5TjQ2OGQzMmpOdEt2eFBuZllqQTY0aFppM1hlVHRq?=
 =?utf-8?B?QjhJVWZSQlRuWnFhaldhM05hWGlRUnA1eDJUSDFzcWQ0VEhPNzA1OWJMQWx3?=
 =?utf-8?B?VG9OMTk4ZG5XUkNKNWZydHpnNkxNRldoZ1RSRElzN1djVFdhUFIzM2pwc2ta?=
 =?utf-8?B?NmJmTWpRNm5kWUZWejQyR0hvS1hOV1Ryd3hDaEhabmVvYStoQXhCMmFoVm92?=
 =?utf-8?B?L09xRWgvd3U0UEZtK2FpWjBCYjRnblhjVVIzY0JTVWlvalR6QS9ML3ZCdklK?=
 =?utf-8?B?aHozNXRqeDJWajBJYWJ1RndsV0JWQWdneWZVV010Z3RBMHFBQ213LzhHeFBZ?=
 =?utf-8?B?U0ZNMXlMdzhUZ043R29FdHFFcFQ4WGtFODQ1aExrdkg1NlkzbjhuYllkZGdS?=
 =?utf-8?B?bUxRRUdUd2tUamtUTmZ0YlY0aER5aFNkclJqUThXbGNNU1U5VHYvTGE5NGND?=
 =?utf-8?B?dVBIZ29yS0NOU1oyMDUzWktHV0h4RzJsSXArdExac2ZmajArQzE1ZGgvOGIz?=
 =?utf-8?B?NUEzN2RmcTBPaUdnZkhWbHNaSVJLaldwbGJkYVl5ckVTOC9ZZVpOOGtIZXhj?=
 =?utf-8?B?ZDZ3ZTJ6KzRhdVFKdS9sSEl4VSs3dlFVRmFNRFl3WkhKMVQ4NjE4L0tBeFdo?=
 =?utf-8?B?Y1h6UmZLU2Q2aDVjaTk2VGl3K01xeGVjSHFaNEpCMXlGenEzdTlFQzJpT0dM?=
 =?utf-8?B?RHBQbjFvTi9vMDF3a1NTZlRjNFN0ekt0d09iaE5mc20zdVNUZ05qNGp4RzhG?=
 =?utf-8?B?ZzNKUzdyM1lKRDYveENid2VpdmpxUGJGb2RkYnErWmw2REJSTVh6QVl5dlQ2?=
 =?utf-8?B?YldibG1rTGpJYkhtcXBNYUZ3c3l4NFVKMmpZaCtieTBmRk9GSWY1ZFUvS1RZ?=
 =?utf-8?B?aWQwVDE5K2NKOHJ3V1N5REV2S3QrTkJVSHFrNjUwcTVjbkxmSnY0SmN3ZXRI?=
 =?utf-8?B?R291bkhQMkh6SWFoWW1QZE1rZFBQeEpOaTdBeDhIK1JCdXovUDdLTE5JSWxt?=
 =?utf-8?B?N3BhVGZRNGpHbTVNa01HQWpKMmxZQnBLSzNCOXhaaTRjNXNIZlZqTmZLMEVr?=
 =?utf-8?B?U3lQdHM0QTRycjJqMlQ2RG1pYTJjcGU2QVFVYXBhRVBvS1BtajBhN2dhRUFt?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5b75ee-13a4-4488-6e57-08dd6061a1a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 05:57:39.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+x7oXSboqfLjZ0mrkw/6wwuwedDs25doU6KCMXNRGfdwVM7Xldma0DYIEuZgl7rUsurzCfzn+AsQcFgcKAlrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9153
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Mar 2025 05:57:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18083

Hi all,

here comes rc1 for the next isar-cip-core release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.7-rc1/isar-cip-core-v1.7-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.7-rc1?ref_type=tags

Please test carefully! If nothing goes wrong, the final version should 
be ready by next week.

Jan

-- 
Siemens AG, Technology
Linux Expert Center



