Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78767EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 20:34:12 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.57])
 by mx.groups.io with SMTP id smtpd.web11.35448.1688675647870118342
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 13:34:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=A4jt+fvd;
 spf=pass (domain: siemens.com, ip: 40.107.22.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKaDzGxhtbyWlFzpd2vg4vZHA6uu8O+plJ47PiDF4Rzv3Uclesqx1zZgw+3n9Xtww/d5uMbvYC2LCHQs8x3/e6rMheBYMyP1nKYJUpfUSzdNm5nz4rpJcK29SeE39qYEJW1aM9Q2xuAW18j3bs8uChrUcQRjn874IX+SlnZJPfV8I3PawMlX4toIhjuXCOkPM0m4Y1g7Og2qLX0QScNrgp2vmC3AAoY49gI5w482I45sjhNM0GEhcVhpe+xVzm6bvAN2pP3IeAGBWDd0fsYAYJWen5KFcZSnkYGiCBfzwWJkOI93njkGJevWONWOeYBgUzAoeh6ZcLNp/PDT4cZNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZnNWi1PHj4DdI9MUnrlyqX0YeTv2fZuomFIUmo9fBc=;
 b=k3iDqcM1A7a2M/ocJbNWVHz3pk6x4xjvk9ECYglldYMcnLTLmrM9r/PDSA/AnASRpip0B5voGbIgfcPNfZOEHFNMYmEhQWXyabO7UmhXr4Iq8eFN/lzdQmrULLytsrgpaMzivGtRdiW90P22v317nrCbaEgFrUgb9acvdGMwPcSx0/jnMsjyOekl9AUZkLTBwfH78rI0vGKkmhUSZXrfzNwqi89xceUdupcYw7HiMOsxzMLsYCFU3t0flxHiV30XMEXyptsMvnAeX50w7jxOVS/FqLhgdi7NmAixFjvQRiN/6mqif+Yv7qZ49EDhj3IDmlYXHihx6A64cO3k6/mQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZnNWi1PHj4DdI9MUnrlyqX0YeTv2fZuomFIUmo9fBc=;
 b=A4jt+fvdRZen95jXGXBtlmDfGcEspp4ZA30R0gthgGfBJlJ9Jj8nndKWYFNOOUmVV4G/sq5zaCX8vIuIl+Le+bliDrY9g7KGF2kl2OhnHuINj5/Xc9Oa8KC6NTACaUtJHUx2pDiiPyqGCFDMTh+gfaxx+rtwX6LB9hrKSiS+iPRDoYcCOQivbrN50qrwbFjRy2N/dQBYBhlZBT5sFMDGVV8DGcQo1dmP0btwY2aSQHLzIDVcZ0iap6cNwN9pJnne8lUc563x0wyheGKyZMfBlSB8BuSwvNpT5OEP8Xr6f8kApX59S2mfHUGQFZsEbaFQU5LHmiTLW1n70xG78vFTbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB7631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 20:34:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 20:34:05 +0000
Message-ID: <f0665f2e-7500-7f40-afa0-9a701645b9c8@siemens.com>
Date: Thu, 6 Jul 2023 22:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: isar-cip-core: heading for 1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: adfe9427-6900-4235-ea57-08db7e60570c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RAVUqmDUAX3Oa0cnpzxchdUE1tD05nt2PS1LiMfBa6s3t/xiGwsqsYYLI7o9J/Qn8+KhKZuhXK+F+qrZx5OJsX2AiRCwx+7NVqR2WXcMpn7KIs0/Lfg6jDoEEpcfTvzjKf1ie4omnugEx5il58Dn9SblB7Zu4OjSn10ZZzJb8FFSqxfLQmRPU7uyff+ro7g/j/NEwex9N6muSRc+sdzL/2AOCyahVcrpnKZLj11WcfSA6P2gRPbgCYFnAhEyAY0O39dmVAe/SDLfthiAGjX5OIS85CRF+s2Aqr1etzN+aXCXnOFjEb+KhbLrhW8abYKkAmCvfAI2LX0NDR9v2H/pryGZEOVTMQP6P1lXzN5ZkIx6F584Ak4QTBocSfwMyrm9itcst0mksnS5SVf15qyjuAtxf+aHTqV4s+YGC/EYrHNdDKcKpKft3JzIb9tVa/k6hU6k7uG3I1n/y93PS/TrEPNuVXizM2Oi6gsKPF+lZ4RLPexqrWXIRrwPOBe85sBlT3vgW2FL1dPQ9HTpsot64Q+J+JmwZkXhJX3iOfQ3QOXsmVTotb/oMT0bjiCCtBzoisrs1DvkP//JNx0wPT0nHw+pgkVqHJeKR0vopy/U+uxPl54qr6pZOozW0VBFHEqNToq0YWDGC4vVFlSjJOd0SQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199021)(8936002)(558084003)(83380400001)(2906002)(478600001)(36756003)(6506007)(186003)(26005)(6512007)(5660300002)(6916009)(6666004)(6486002)(2616005)(66476007)(66946007)(44832011)(66556008)(41300700001)(8676002)(316002)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmIwMTExMHg1OTlVNnBoLy9FdXU0MFRocVpWYW5FMFd3YkNuRWZaYVlRVVJl?=
 =?utf-8?B?WWsyd1RyQkRhNTNhbUpIMCtYR3lwdmV4cEJqMktXU3VLN2t0YmhudEpsM0gy?=
 =?utf-8?B?THVreno2MUtwdlJTSGl1cHJDOHhpVjZra09rajBJR2ZUbGp3WFlXc1JqejM1?=
 =?utf-8?B?SGdNSFM0a2V6K25CSE9WRTZ4NFpUNzJ3VUZhMW9VdmtGbHg5RlFLVzlQRjdi?=
 =?utf-8?B?c29HM0J6eGJadGlGa1J6ZzE3cDZuRE8vc0Y1VE14VmdKVzl4b3p0aFBhOTdJ?=
 =?utf-8?B?ampleDgwVEhMM2ZoUmR2SnlQcWY0YWd6bjRoQnFTc1E1ZzBoME5LbTY1eDdu?=
 =?utf-8?B?bVRkaUV3ZVFaQ1d6Qkd5aXpzVit0WlJqT1FHQUhwcHdLMk83cGpMd3loQ01Y?=
 =?utf-8?B?Q2wrRlh5UzR4MUVTZlI3cUdaTHU4SnlwMENzK3owdnlXN2hpK0t4TzdYWmlz?=
 =?utf-8?B?ODc1OGZseERiSVZjQ0RRRHhhSCtZcWhoaThnRW83WTZJbU1ZS2VPVktkWnVa?=
 =?utf-8?B?bHVhOWV4OVRSaHlmN0xwVGsvZGRXMXZhODJMdVJnMjFjWjFjV2lablA0ZW41?=
 =?utf-8?B?OTNDY3NabkFGYmhOM1Y3Y2F4RGxlQmIyOGhVeHlkdDlJQXYwemZuckE1OGdl?=
 =?utf-8?B?QTZTRUU3YlYvb040MHVCSUl6dzJIa0xnMDBnaERXaTNGMU5JR3c4N3hJeTFi?=
 =?utf-8?B?cVVvay9vRUhpWDNWbGdManU2Wldqb0dYY2JKR29KQ1ZkZ0FsYnhVL1pnSm4z?=
 =?utf-8?B?M1RLb2RQZWVCejRQUjhERFIzUCsrWHg2SUhiNWl4SVpQSTVvbVB4TzgwSU1H?=
 =?utf-8?B?eWN0V3dFWjliQzlnL1grcUE1TDJrcjdLUnBjeEYwUHl6dXNFYkVrUlFYUTA0?=
 =?utf-8?B?SjJZaHlLVmR4RnlhZG1qZmRMWlJHUHozb0hlNFlGaVVNa0hrdEliNllVSTJY?=
 =?utf-8?B?VTVsbnJMME1LOVhCTU5SWkdENVNSVExtWjlZdUlDSElLYkdCbURGVjlUcW9T?=
 =?utf-8?B?SkxvaVU0cy9jTXFWRDh4NEFWc0lXMjFwbXBaVFlNRS9Eb1hPWFZ3K3BWSlM0?=
 =?utf-8?B?THYxWUZYblczaDZKeTFXVHZ4Vm13dUYvTlBBY0V4OG14cnpHc1g3bVE1ZGlJ?=
 =?utf-8?B?Yjd0eU5kNytmRkxnTzVKTW9ic1dYZFE3RGlFVUNIQkFGeUZwbU1jSlB5UnNn?=
 =?utf-8?B?VEFSTG1ER3U0Rkc2bHltQ2ttQ0QxT2YzQ1NzT0R2VUpQaDNJNm8weFJCNGNO?=
 =?utf-8?B?ZDBkQ0tUU3VDVWhoZ0tSODZULzVySnhPTFl3dVQ4SkhzZUpVNndtNytSSmF5?=
 =?utf-8?B?S3NNVFpTdXk1NDNhdWZpUDY4aXJlcm94TlZodjBadDk1V1hVV3l3VTA2byt2?=
 =?utf-8?B?dEFPbGhneXkvL2FxR1c0M2ludFA2QjhnVU5ISEdHMUdUT3IrWVBIOUx2cjVW?=
 =?utf-8?B?REFONjJKN1NPNTMyWGxEc3p3N3BLZTVyMnZ0T3oraWgyYnJGR3doUDh2RmlM?=
 =?utf-8?B?SHJ2SFlxdnpCSlBveUdRU0c4RDlFK1RWRzNRb2FrWHdUWERBZHd1bGsxbktm?=
 =?utf-8?B?RGgrTEVsODJsbFNoQ0V4cEh5WVVlSjMwaG9YRzYxMkpYaHJERHhzb3R1SzlI?=
 =?utf-8?B?bU1ob2VGZ0cvTXNCS1NjeU5QTHNWQkYzMW1neFhBZVFrMWZWUFM2YlF5cDlZ?=
 =?utf-8?B?dkdqVzN2QTl3Z0ZFVzVmTnk5dll6c0w4eXRHbGxGeGVKdmNUZVQxWlEyVVdS?=
 =?utf-8?B?OFU3eFIxRitmQmRFNW12MlluWldxNVMyQW5GMXU2QjV3YmRYMEpyU21ZanRS?=
 =?utf-8?B?cEpOclE5dnN0UU5tVS9lOWtPY0QxV2ZHWEltSlN4TjVhWGgxSEZlYXV4T2xr?=
 =?utf-8?B?TEo4Y28zeUpEalF0T3pCY0N5TUFPL1ZYU1RQN3BBUi9xeFlmRE1EREMxc0FF?=
 =?utf-8?B?ZkxiYzhFTGZEODNxQjduNFhIbXhpVm1YazJZMlRRU0lScUpWd051MzJJODZP?=
 =?utf-8?B?V0EzcmV6RjFLZjdHYnNaUkZKN0Z1UnVoaHFIMk9yVCtvMkk0SzVoblBJT0tM?=
 =?utf-8?B?V2Nkek9VY0lnZ2NpbUhhcXkxdG5ZMjdGYmRtQUk5enFzVEk2bkg4dXJLS3M5?=
 =?utf-8?B?L01OSGxweS9PRnZ1bW9oRTY2SHkyR2xGcDU5QTdSQTNSMEFPTkhwbi9PWlVJ?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfe9427-6900-4235-ea57-08db7e60570c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 20:34:04.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1a07MnM83DskgJU2mXRKiQL8mSjcWOjJ3ZPfi0Y0CB9rL1kwivjfje373L9OOagw4yKdVwZoVts0Ygq2NzvlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7631
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 20:34:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12263

Hi all,

I'm about to close the merge window for features into isar-cip-core
before its next release. If you have anything pending, please make sure
to submit until beginning of next week.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

