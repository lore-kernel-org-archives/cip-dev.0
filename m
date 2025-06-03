Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB59DC5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 08:31:36 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.71])
 by mx.groups.io with SMTP id smtpd.web11.6433.1748939487656197076
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 01:31:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=G7vacH4P;
 spf=pass (domain: siemens.com, ip: 52.101.69.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjiFoWQjxHgUbGw3DbN9FDlSSlNH7Gjciqk648UtjWM2qui+/105VGTVwEz8N1Spvbqou4sbxx+XA6lMIOaVEJPYHjkrMkyUI6N9HddZFGjEyiFTzh2VK8FGX0k3jpiEQ78oa16Z5iHk+CvdbIapjbK/O7TwBYJZjd4Zj5rM5Mdw6wnQ9Em0zbUVGJlvIqe710ojJpnwNKWtRntXg3uqJTTGpadVsc8DZjWvM3OAOh4fbGuoddHfwjznpsNCa9JUzyGvdt+4RhG1xyrOnAubPnAxNTjaz9x8l7KJTKpT7HYwNB8ALqlrwa4tJRa0CcqC9OL0hmM42LTOseqoQzD9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1+ql9wAnJtwrfsQpHFHggzVD3tZvayTE2jfx94tH2I=;
 b=sgF06AXC60bxhhM4nKTNuOUxcPnnvQ2rhY/SyT7EDxC5DbNqtSnlXF5dd3Yxwj1Aq/GKXWUGKqKeTFGFZSxMYXbLtUFrVFA3fBO1l6ugJRVOun+5xhCwoZCNAWGuUUwbo3W/ZhAOjidIWLeZpt4EFk117TDnmP5HP2OeBCqkEPoj1InoJVz0eEeV1Fp8K2jKMunsY8bOnWZu6fbe3W9x+um//twXVM/5UMx4rH+O4Crz99ojX10ClNsvkzDeFsgbXshZNlLwPB31t5HfbZ+GjZinrO2LbcqZrrSk7+k5m2z23e8aqUxPcLoFSlCLCQe6yLj3SXel4JPxdII+BWzPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1+ql9wAnJtwrfsQpHFHggzVD3tZvayTE2jfx94tH2I=;
 b=G7vacH4PwaPnCNSkuJVVy9hVJYLkyetV3EGSLbJRlN5or08b5OI5rd/Ni+vZs71cn3lfO0fOhuMQMa1liNlfYcXtCRG2Vs5lvYHVVLLWbpJosSiYS6LljMrdJmbUsQjuMzoof1x26uQNKZAMxdq7Au7BAtW5vL9M3jCw0x0Fsbxpw5Ibs0AXzgRORUSOYRJiqpKww57uM+OjiUe8Ws7FLaFaqmv4JJXcN3Rw7jOUooNZIKyScsm/gP8xU5KLVJEviUGhm7vypT4m2fU5GDGH5fWyrPLxVtIWlpZ/iq6QsHHouNsdvKVlAf2JQ9jUiufbxshxlLdmGYB4cQv2sq6GVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 08:31:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 08:31:22 +0000
Message-ID: <ce5c2a9f-8f9d-4266-8c0d-ceb62dd61405@siemens.com>
Date: Tue, 3 Jun 2025 10:31:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CIP IRC weekly meeting today on libera.chat
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
References: <aDggNAAp1mnSfQja@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aDggNAAp1mnSfQja@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: a5134de5-328e-42c7-d07a-08dda2790565
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dDFteFNsbStES2VxaDh4RXlDNm40bVBBSExkOXZGZytRQkYzVDFUbTJUZCtH?=
 =?utf-8?B?dTAzcDZ1ZVV2SlhvZWZmV0pIREhjVjNCS0l0dU9sWVJQaUhCWnIyUGdCTjNC?=
 =?utf-8?B?aUxaYlpLT2NlenEwMHVVbm9VLzQ3Zy9DRG9Uc1hmRTZKVzZTODhRUCtBcUhW?=
 =?utf-8?B?clZ1cGNoUVR6b1Z2alowdzNCS1FQRE44U2g5UGI5dXg3enZUSkVyYmoyMTRt?=
 =?utf-8?B?ZmVHOGhxdVNjNTRvQkRNK0x1MGZsMXRIRGxuQ1NiRXhpVUhUTzUzLzBxcm5E?=
 =?utf-8?B?ZVZOcWp5KzJwbVg0OU9XNDNWMmhFbmZSNHQ3cTBxRUpwK29xVWxQOFBVK2hx?=
 =?utf-8?B?NFluV05UUU53MmNrZjlabFBLY2dKS0lWQlVmUDQxampQTm5DZzZoSm0rNWVU?=
 =?utf-8?B?TVhHaS9kb1pINFlBU3ZYSXI0V0RXMzVWKzJYQ2RXenBPMjRBMlpFMitybjFD?=
 =?utf-8?B?RzFLL09qZU5sQXAwMHprUjRrMnJMc05WZGRLZW92T2RQSm8zTk0vb2Y1R05t?=
 =?utf-8?B?MlVoM0RkdWNNTEFxZmFrRHMxR0VOVUVmbnBLcyt2T1piQ3pBVm9uV2k5Snov?=
 =?utf-8?B?bUNmTjljcUhkY3llL3ZoN3JGcUhHVXRxSE9qNk15OUNyYnpLZkdWQ1BmUkR5?=
 =?utf-8?B?eThpNG51cm1zc0NBTnNoT3QzMCtzQVUvdXFKY0oxSFlEYWJvVXNNNVN2UUxU?=
 =?utf-8?B?akxxblQweXJkYWQvazdGdVduQUNDdUg0Vm5UWW9Hb1JXWkkrRlFseGpYdEE0?=
 =?utf-8?B?c21adDZ2VGxnQWg3RkhDUDI4QkJzTUJqb1hyL0lnWFJ5TTcvWTlxcXMvMkVn?=
 =?utf-8?B?R2hKUVduSDdGdnNQWmU0N01Ib2hYZVpTckFzZkVNTktuWnpYRjdZbkNhQ1Av?=
 =?utf-8?B?dUhpZklSOW8wUEVMMk1xOHBKS0dMdi94a1lRWHQ5WnRadVRNRW44UmM3S1lJ?=
 =?utf-8?B?L3JjaU16UUJ1eVRCWVRPcE5UMHBCVmpjUy82QU5haHdiTWx5dmZzTE9VZTUz?=
 =?utf-8?B?MlhjbEdDSmo5ei90UnVOR1lUM3ZzQU9BTEN1dytYWE1HTXRjVTZuNUp5ckVx?=
 =?utf-8?B?aDh5bjRDQXFnQnFKMW1OYnhjRkVPTGF5Y1hiOElyRFVUZjBaVUhmVGxUSW15?=
 =?utf-8?B?K3NCOXZ0TmxEWGFGZm5mTUR3Y2hqdjVZYXRnM3dwdWJHTkRrMDYwQWpxNXpX?=
 =?utf-8?B?Zy9SY25wL3gvaDRDbHQvV2E1UnVOQmpGdy9xWFhINTBBbFpEMEIvOUxpWEVB?=
 =?utf-8?B?c2w5Q2hteitldGJtUkhGMHVORVR6RmI4dnMyWnd6N2dwTjNqbzZoRndRMHFM?=
 =?utf-8?B?aVZ5ZWZzTnQ5bklwWjdDblpxeTF3UzN0amFQQUNPSXVkTkZtRXBzcitBdGVo?=
 =?utf-8?B?YzA2RVVmdmlYZy9qU0R2ckxhS0czb0Z4VFBqNS9ZYVc0bDEydEJLdWFUSnJU?=
 =?utf-8?B?TCtUZHhIMExVWU1GU0IzQ2huWC9nSlB5cjVwU09HUmozTVBxMnJVcnhIR0dq?=
 =?utf-8?B?SzhzZmdNZStya0t3b2ZOSm5waVpOS1BtbEpiY05ITWo4alllOWxCQ040MVdX?=
 =?utf-8?B?YkNjYUZNV3RpNUpzLzRtR3ZTaGpCNkNhYVpIZUpVWEJCVGpneGw2R0JDam93?=
 =?utf-8?B?amxqZDNmOVJLZmhYejI1ZG83Z2k4WU5pS0tRWEk3WGJoOUhZSi9Ld0Z6ZVdE?=
 =?utf-8?B?WHZZMGVCRDNua2NIaTVpdXBhVThjd091YjhxVGJxUGUwanQ2bWJ0NDJjUnJs?=
 =?utf-8?B?OGMveGpIemZvV3A5WkVDbGRtYWJQV1oyY1FBc0Z4ZmlQejMzSklRdTJibnJm?=
 =?utf-8?Q?x3M2zCov6BQzCGETl6vrcPWnWi4L/G/CLy4G4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wk9NY01FZ0F1MzUxSVZFNkp5WHZwNEw5VWdBWk9lRHNLZWtFRjZXamozaVZk?=
 =?utf-8?B?ajg3NitZRXVqNU5JL2Rnc1JzcEk4UkhDRVNlaFJxbllPbHBEWWdFcmM3cFly?=
 =?utf-8?B?eUtMcVpkdW14K05HT0ExR3hHY2h0RHpISytqVStZbnpxb0VFbytuNlE4NjNS?=
 =?utf-8?B?aTdaMWxITmdpcDlPcTJhZXM2aHVndC9KZnl6VkMyNVdFUjhlR2lXWVdzVW52?=
 =?utf-8?B?dDdSUnEwdnZ6d0JyZGRTMHp2bTZQbTdiYXZUWjYvV3gwTkwwUFhjNFZZQms5?=
 =?utf-8?B?SFdNSWVDd1hyNkg1dCtEUzhWYlBwTlowenpUL21GMTFMMWllbzFJbWJmWlpI?=
 =?utf-8?B?YkcrRFhnRGNRSENidFRsVTA4ZlNWT3pmamREdDVuWXRqdytWRjdHOUZHM1FM?=
 =?utf-8?B?eUhNa1VvL1JiVFVqR1VjUzQ3Q0xGS0kycjZxNGk0TFFjOXBycXFKdHhmMXZE?=
 =?utf-8?B?TE5WdUpUS3hIakxQc2ZlZ0ZwKytiL3l1WlhLSkV0cnJIRno4NFhhdVNZUmJt?=
 =?utf-8?B?LzRRUk1RQmdwb0kwUWNLajlhNUo5UGVCb0F0Yi9xWkNLd1B3eGdKS012TXF1?=
 =?utf-8?B?NFAvVUN6NzNGNFpRcVkzZHZNOWIyUHJGZW9iOUVVS3ZiQnlwV3pNUmhFUGdO?=
 =?utf-8?B?dEFKTUpGeDUwNG1EK2dxcTlSbUxQUStveXZYdGxRMk1nN3BJTmRTRWtqckds?=
 =?utf-8?B?bEljckxJKyt0ZWVMbFBmZURxQVY0aXdLR0RpNWNXbXlxYjdnd3FUMzM4NEsw?=
 =?utf-8?B?STBwR2lJQ01MR05HZTA4Zm02RlFUZ0R6K2xOUk5sQXZxbkZvNzlpLytaSFdZ?=
 =?utf-8?B?alh3bkk5Rm1YWUVsRjNDaTZvL1VKeUltR0tkeHc0cnVpOGpiT3FkNFlEQmw4?=
 =?utf-8?B?VUtvZERYSkVQS05wSTAycU5UdFZNdXAzNzU1N2EzWDdFcTEyRStpWDJ4Mmcz?=
 =?utf-8?B?b3M2dHBiUFVvSjVOZWM2ZGRabkNNVElUZDhGcitPVUJjWFA4dTRyaW1zZUVT?=
 =?utf-8?B?ODEzZ0h0V2ZvOFg1WjNRK2cvTFlBTVNWY2IzSzdUd3o2UTNEaDdtUXZlVlk3?=
 =?utf-8?B?bXJoTVZGKzRRMUdROUhvSWp4bGRiZ1NSMS9DS1RLbXYrWEZQazVwQ2d2TXcr?=
 =?utf-8?B?anZZSFRxWHo0OG5vRE1IS09Gd2U4cWEwNDlZbExHM1dvNS9IKy9SRC95alpl?=
 =?utf-8?B?U0JZRGtMNDFTQWJjY1BUMkpFNFFJV2x3SDc3c3UzbjBwZ0tReUxwejJmWGRw?=
 =?utf-8?B?TG5LS0VtSmd1NTdKSm1IeFdCWXc0b3JlRis1ZFh1V1NiSXBpM3F3REthNXVr?=
 =?utf-8?B?SStIVzB2UkRXYkZiZExOSzZtZDA1Snc5ZnMwWFNYb1FtRW1SeStrUmc2a21U?=
 =?utf-8?B?L0pFbGd6TUgrb2tsVjEra2Z0UExFYkgyNjZJUnlDNWU4Vk94dFFFUzZzK1o0?=
 =?utf-8?B?Wm95dXJYWjVyd3dRMXhSWnZ0NXlxYjhxTnBsdDUzeHVMcTBsK1l6OVU4elkz?=
 =?utf-8?B?K2RKbzlhRzZQcGZBYzNCSXFkdFllWEtDM213WTAxQ2lidHBOckYxNEFJWW5S?=
 =?utf-8?B?V2xXOW1NS2dtOXVKY3JsamI4cnJsSGk4cWlhakxRMlZTZ0RGVVhxbktDQkxO?=
 =?utf-8?B?Y3BjZTdkZUo3ZTAxL1Y1bW1tNmt3am4rYkFPdllVOGQ3ZDlxK0tkUnZNSDFx?=
 =?utf-8?B?TEpxbHBTeE56dnFFS0VwMjBQNEdkRXc3aHRkcmFJcTZEM1RwQkQzS3hyS3pV?=
 =?utf-8?B?NiszWnovYWM2RW11c0I5SzBQckIzYTI3L0h5YnVjdGFuemQxV0ZFbEY1Z1dU?=
 =?utf-8?B?QjA2TlM1aGpkMHZwNDJTRk9xWEZFaTY0R3JMdEdtYTJ2b3ZJM2lPWTNFZXlh?=
 =?utf-8?B?cTZSdzNXbm9BWGxrenMvbFljZkZsamhJNU1lNkE4UTdmZUY3NG9kejBraHNP?=
 =?utf-8?B?MWxFWEdpZmljYU1TeWVzbkQ4YnV5LzRjYytjb0VSUVhtMzZTUTlCL01wOWly?=
 =?utf-8?B?WStuNUlrOHlRS1ltSmVZRzZ3dUlIRjExUXdia05aVERVNisyczQxZ2RFTEtu?=
 =?utf-8?B?MjY4ODJZbWRVMmtEM0VYNWFENVZQK3p5LzJmN1U0Q3VXdFE0SzYyaWUxUU5O?=
 =?utf-8?Q?aYUfcoKkS9x3zpYmM4Yigz2l4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5134de5-328e-42c7-d07a-08dda2790565
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 08:31:22.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QRV6b1o8DlObiV1N7+6DmFsCxSbrWiOpig2htzRPir2s42WExUSny04owD/w22XozhVvNkLSPIOGbZq7veZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 08:31:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18963

On 29.05.25 10:52, Pavel Machek wrote:
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
> 
>     irc:irc.libera.chat:6667/cip
> 
> The IRC meeting is scheduled to UTC (GMT) 13:00, or in about 4 hours.
> 
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/cip.2025-05-22-13.01.log.html
> 
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
> 

I cannot find the recording at
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/05/ - were there
technical issues with bot, or didn't the meeting took place?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

