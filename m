Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5388C4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 09:28:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web10.1108.1714642104159055116
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 02:28:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tL8BOKoe;
 spf=pass (domain: siemens.com, ip: 40.107.22.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG9PswKvIlK0v9qe9kdnePb6i4hXmQ2BCB8+/GNwP9/PpzC0OMVFBp93ctP+bdfvn9b70fXRmDw5g6cGpK3gWaUVqucKLQ7BytlHjNc8lXeq31IIEJikWwEaJU/VN02sQmzQcalJFqf2O/SPDZPs5eR7/ybyfA1QhnibHtzcICSQ2ml6SfSJhxClGOn5pkgZfres2ebUTtDUpmu5M0wgY2wS1cY1ThH8N0/UIr7PtmUjmGo9yOEXN3+Y27LTGB8f9s4/h6N3EAhrEtrlz/6htQEygiWGCnl9JjCatKUss+qYcS4lXJFd8b4rr/emH6/OHhqXhkiEUfP0hfYlnyMpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYZS7NEFry+sFRk4puLPTdLNLOzuazGPYbIeetNPLWM=;
 b=ChXq/5DY756d0NWlSohz6Hmzc2wnCHvRRSQjJUEFmUAxYXqIGRXjHqPyRGwPZL+gHdYerSW45AqkjjTXuPTGuhE+lWAFYVCx+WFNrCBJlWmIWJugPxJmolup3PkOMcuGEviSUbP+rGic85QOvVoMBWmO6OK6yxKT7gBkO49lALTdwK4qjIsTU+BeHP/K1VCuZ6jjX0EKBs47egFvftOdFEpB7MHuKAGwzpWLHOeqVNA7Ujmha2k89Pd9K6ElH6d3uFYKG1Jt1e8Nv9xRow+JtFujjwUndWbEF1hu544d92hN0pPidS+pmRduD4x36YGFR/rY23tS4sbJFofw49ykLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYZS7NEFry+sFRk4puLPTdLNLOzuazGPYbIeetNPLWM=;
 b=tL8BOKoeEOgeT40O6Z3UXnpELEDIHLsJPWRHzKnYyOvHsrtyfgnuy4O3tE0XnuQCTW2rvi5SwaXq3tl2pE1L/B9icz5KcH4wUasCiqFVp8pxpyLzqU6Ruldosz/GiiUCUlJtdLGZGlTMyWC6Ye+MEcq15YZxx3oY8olZNE6YhFte0mjkjq6i5xDuSK/ShdddSQ4VB9wrCiCgUmyNyVj+VJ7fa17qR5e+Uc0xdv5Jenh19DR08unaag9GQhRaxibG3sQQDEoDBjx43rdg8H2hzHJ9p/He8qcDGxImFoy0GPziJvzM88lA8z+njnWZ3eU7vlDNhTjheBRuvM/EQ4bx+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8188.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:385::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 09:28:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 09:28:21 +0000
Message-ID: <321d6c65-fe1a-4714-98dc-5e496cf6d22a@siemens.com>
Date: Thu, 2 May 2024 11:28:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] [PATCH v3] update ISAR to latest version
To: Rakesh Kumar <kumar.rakesh@siemens.com>, cip-dev@lists.cip-project.org
References: <238f7a31-1684-4503-a835-e0162e9b33a1@siemens.com>
 <20240501120001.855311-1-kumar.rakesh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240501120001.855311-1-kumar.rakesh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: b404fc45-1cf8-48b7-476c-08dc6a8a350a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M21zWUhkdEpRSVU5bVBzeW4xa3NFMThTTVUrcUNVTlJ3OVZ5VlZoNjBtdnI4?=
 =?utf-8?B?U2MvQ3QwQmNOWEtWcjF0TFlrNndIMEpOSkNWYWhYTVlaakM5dldTMHZ1N2JF?=
 =?utf-8?B?bDNzcm1GeW1vcEF3TG4zV1JONlFzd2s5ODRqWG5WK2pSWkFkV2kvUzlyZjlt?=
 =?utf-8?B?aGVXemZVbXhZaEVDM2NxODM1VDhTelloc09CS2JtdXp1WlhKeTRPWTcreWdz?=
 =?utf-8?B?cHIvd0V5VVpQSGFDZENlNkVkVTc1Uzd4bjUyd0F6OVhXeCtGeldPWHpudW1I?=
 =?utf-8?B?TFlFZ0ltZXdJTnNRUEZKMldTUVpLd3FGTjN5ZGhRdHhGd1h1MGo1S2NueUxz?=
 =?utf-8?B?TUtWTWl1ekRCWG5YRjdZbE5VSGZkSi9wK0ZrbUl3TFlSd1BPa25CQVZsNkRX?=
 =?utf-8?B?VGwxc201VStlTVZ2dUZ3VzMxay9jMy9KR3NQRnI2Q1RLS3RWeG92YU9LUkF2?=
 =?utf-8?B?Mk1CZnErWk5nSWVwcXExUmVFUU5kYlVsNWE4S2taaERxVTNyMUhkSnpna3Rw?=
 =?utf-8?B?aEVZenJSdG9SOStPcVNDdUtEckltcmRUb3VweElBQlBMN1N0S2NkY2luZkta?=
 =?utf-8?B?ZXAycitCRlNyamFZSkd1bkxEaEJobzF5dElmemg3dXQyY3lDQ2U3RmRtQWMx?=
 =?utf-8?B?a1VnU3l4aE82aU05alkyS0FXYm0xZCtNeCtScG1TcUVBWGY1amV1OEtyc1Ns?=
 =?utf-8?B?ZkRwdDFRd2RneVdPcGZWZlQ1WFltcFFyN05qVi8rTmdBd3kwT1pBTXVCY2ZX?=
 =?utf-8?B?aGxLbjdycy85RFZBVnNDV3F3UTJuaERNa1hCeDRRMC9yWkxrRkVxSE8xajZo?=
 =?utf-8?B?UEMwVkhXMXkrT2gvQ3VaRmdzdzNUL0M0cEk0NHZpbHZEV0MvR0FPaHU5ZXlo?=
 =?utf-8?B?N0hvUWpTZmhlQzI5WEZyMFNBSWJtMjAwK0JqRjZEcWs2WjU1VVpWMkpJdHJH?=
 =?utf-8?B?YS9YMUFWbFZra0RFdGtJNHl2UHJIeFdBajBlV1FyM3RTVzJEUjFValRoMksv?=
 =?utf-8?B?VG5RQnhFZjdkWkpHeVlyc3hWSVlTNm0vaTJlSTNBMnZsQTdkKzljZmdPVXRZ?=
 =?utf-8?B?Y1lnYmZteGpvejJRMnVwVnJrZTdicCtTcGhyRkVwWkdtTmwxOU9LNU9aZ3NO?=
 =?utf-8?B?bHd6NVE4angwWUR2V0RlaFd4cjJPRkJRb3Bmc1huZWpnQmhLYTZDMklVTVlU?=
 =?utf-8?B?R1NRaFU2bFVzOXdxM09zTVhFV1luR3NHZDE1MWdHV2graUkzWWN5SmcwYVBo?=
 =?utf-8?B?ZGNObFdvNjUzYXpUZldpQkpSdGVtRnpoaURzRzBmSm9JM0JaQ0t4MndPZHV0?=
 =?utf-8?B?UW5jbHJJcWNEcXRpL0QreUlQMVhxUUpjNXdRd0dxc0tGWUYrR292bURPY2Y3?=
 =?utf-8?B?TWFEVXZBM01MVWs3U0tFMXdRWmJXU2lML1kzVHJPTUt2dXovQ0sxdVZLTUhq?=
 =?utf-8?B?dDF1bWM2SCtKeFl5L0ZSdUt2RlJPZVV6dWlXVzU5NmF4VkxBQUtmenlqUDRL?=
 =?utf-8?B?Yng4RkRacXZ3cWhsbEJRbWZ5M05kMVpoanFWM3N1RzN3TnhvQ3UzdXFiV0Jt?=
 =?utf-8?B?RmNOUkpEd2xCdFRCWXlsS3V5Ty9vbzBIZWhJYW5pSmRBTWFqTFhuWVp4Zmpx?=
 =?utf-8?B?aHlkdFJDSEhrb3RmYm5ZSnd4MW5rTXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHlyUXJ0TGY3bU5UeXlTZXRvUWpIQkNpRTNCQ2tlaW14by9aMHNJbG1MR2Fv?=
 =?utf-8?B?aVVqZ0gwQWk1Nm5RSU1nUXlVV3B2Y3JlZkZIWndNb2FhSEtFNlRZWWpSVWRF?=
 =?utf-8?B?Z0Z5UU5jMkorUWx3emZwR1hVWUdVTVVsZDVFVndiK1V3Mm1sZ1FTbzh1Ky80?=
 =?utf-8?B?OVEwR1VmbVpCeEFUM3hrTE50MG9EYzI5RDVTN0laWlFVQmVWdGNENmI2ZWgr?=
 =?utf-8?B?VmpPZFFHaVc0dWltbkFjaTNLTUNaVmtEcGJMVlZyVkhTQ2tRWjFUL3FzeE1p?=
 =?utf-8?B?N2RBUWhLWWF1ZURQUlRzT05LSERiK2JtcFRwVlRzbitQTjBKQUcxTmhKUFVH?=
 =?utf-8?B?a3p5Mm0zTUVtU0lldWpQbDFDeW9ZQVJHYmNkekZHbGRWYUpnTFk2dWJtMnMx?=
 =?utf-8?B?RU95M2VJSGFiQVlPRVdyN0ljTFBwemNhOVNSb3p6cHV5SVdwUko3RHBTVEJL?=
 =?utf-8?B?QVNFOTRza0owTHVvTUpwaWxITVJWcm15OXB3dGhZMWJydE1RK0pRa0drOGZy?=
 =?utf-8?B?T3d4QU9rZHMyczdIbkg3RlVUK1k2MXRrWWoraWVpS3RsdWc2RDFDWkRQMzRX?=
 =?utf-8?B?cmJyZzhaeFNBajVLL05KSHhvZ0U0bGRHaEJaQ0ttbjhIL2Nmalg3UHFkTTJI?=
 =?utf-8?B?SWpPVHVxUWlzQUJCcjZaaGtvZ1BsS2FUZXJLQXNwbzllc0RKVFgzTm1IQkhG?=
 =?utf-8?B?UzlXRkhlZmFodFN2clozRXBTbGl0WnYvZTlRT25UWW1sWmhoL2pyT2Q5QWpN?=
 =?utf-8?B?TVpkSW1UKzRlbnpOZDZiaUt6bjFJeFF2bDl3clVUZGY1QjJMYm55ZkxOaUM2?=
 =?utf-8?B?Z2w0VVlWZkFMZjFGYnZZWUgrMnp1a3JZd3NMZk5xUDZyeWlXMDFMdzZMSktu?=
 =?utf-8?B?UDM0UktSVVJGdTZsejQvYjZkNHNNNW15eW4rUEVWVTB6KzViUU4rVzZoZ2l5?=
 =?utf-8?B?MGtUcDM0NXZvdTVIbHBFOXYxa09jTmJuMXdHMElPOTFRN1V5U2EyYUtKQnBR?=
 =?utf-8?B?SjJHb0kzTmR2azM5c2xuOUNwcnNVN1V3TGdIM1RiZTF6NkZNRmh3bS9KOFg4?=
 =?utf-8?B?KzhCa09HMzVrY0pEMnluQkUvM1ZPcGR3M24wUERjTUt3QnArMlpMbWZsRGl2?=
 =?utf-8?B?LzhSaHduSGpaUlN1NmFjd2M3OGU2aUNrbDd1cTAxMFRWMFZaaHowT1RSM25V?=
 =?utf-8?B?QnVWQk5iZHF3WGt2NWZ6TVRocFI5ODFmeVBkRzB1SnVMQnVndVhyMFNSalR4?=
 =?utf-8?B?eC85ODRzc212LzduTUk2WW9RclVoa1RhZlZqM2ZZMDJnTHN3Um1QNEdOVnY2?=
 =?utf-8?B?T20wWjVBL1dabVVlY3VxQkdHenhiNW0rRS9McmpSN3dSRzlYNVd4UllndlN2?=
 =?utf-8?B?WFlHSHU4OUJwb25Qc0FQN0p1L3RFUlNXUnBiNDFyR3daTmZ0ZE1iUGV0cjV1?=
 =?utf-8?B?aXo3RXQ2M0laaGp3a3pMZjR0UmhEczJPNWF0a08vYklMTDFiVVpoOXh3elZx?=
 =?utf-8?B?YXcrZWloRjlRWTkxNEl4WURvSlJnMndJVndMWS9mSGY1QzlmM0xObDF6L3VB?=
 =?utf-8?B?S2VUOFlHeEYyM3pRcU5nMGthMERhNnhMcll1WkppcXo2ZFFRSVN0OXJiaW02?=
 =?utf-8?B?UTd4K0ladndYT0kyYThMalpvaVZuK1RlcHVVYUZXNkwzS1FDN2tjTHRBVXB6?=
 =?utf-8?B?Zyt4MXdDWjFxR1hLN3NlcitrUDFMNFRJWUxmVFRWU3Vuc0dwbGxMazBKRlVV?=
 =?utf-8?B?SDRlSnkxbFR6OVhQRG8zS0o0V3Z6NDNDaldhWnZZT0QzYi9RY0FSR0VEblM0?=
 =?utf-8?B?RUFpL0VKRGhGRVlSWnh4VTdEaURCdFJKUzhsSkVOQ09PaTg1UVp4aVIxdzNP?=
 =?utf-8?B?T0ZTZ1MweWpDdHBIRmpmaHloaXdJUmxnMkY1dVhLajZWYnRHbElGN3pxemhT?=
 =?utf-8?B?c1dhMHI1VTNiaTFJYnVQNHlubDJ0ODlWZWd4ZmNnL2wvNkhvRzF3VmtqUHFp?=
 =?utf-8?B?aUpXc0pEQ20vS0c5Nnl1enIvVjFtRTB4cGtCRG45dFpoRmt0ZTNvbjJSQ0Zy?=
 =?utf-8?B?MUkxR0FnU2pnRTJaSUh0cGsxYkRuanhwWno0ODFnZFFZam14UjFsZDQzVUp1?=
 =?utf-8?Q?an3yRZ5rHgN0FvNXtZglPh/QD?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b404fc45-1cf8-48b7-476c-08dc6a8a350a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:28:20.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfRHZ2AGQs/aBJub4ISiXQdWlrMdc/fU8lpSQOX5jd8JqKA1Q6K56BiXX7ALTSslLepPkE+yo9/rFCgfz6eb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8188
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 09:28:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15793

On 01.05.24 14:00, Rakesh Kumar wrote:
> One of the changes is DEBIAN_PROVIDES, which is required to
> resolve the duplicate Provides problem in secure-boot-secrets
> to ensure that the build process completes successfully.
> 

We will also have to wait for

https://patchwork.isar-build.org/project/isar/patch/aa9baf96-98d8-41fb-9297-9d9b20d1520e@siemens.com/

or carry this as isar patch.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


