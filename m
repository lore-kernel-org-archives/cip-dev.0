Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC430C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 06:28:32 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.75])
 by mx.groups.io with SMTP id smtpd.web11.16073.1709620110471256654
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 22:28:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wWw99MIN;
 spf=pass (domain: siemens.com, ip: 40.107.21.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErJG4w3K2bwEwGXI82eghxHY8MQWZzBVuc9cIQVsWwRf0603YGV0UhZPCHe32IpxP1fiY1vtaGdM4yYnQ1ESdq29p7vE3No7/gK5+DtawIuoPX3pCnI7kf97GG0m9q9IQXMLehVD9pzfoJ0fsMJH48bTBFPaHcRozGVGLMHExkD/USqNqDlbLFFln247d9zffRNdmhRAZL6u4P7UYmum5SEgtC1uHwsEpEAYgPwsKmwtmeuD0VEx6HO3R77OS1BTB4KxcVdhMTd6A7BHMtQGAIBQnjC46MKxPBhiEBgc12deh/xjWWnepg57GVJ3ta5pS8S8/X9KP5MGr0kmieqxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsyDGety/YAS8WuYQDIXgWaNAJJ9bGY55CPVnfZQ/xE=;
 b=NBZokxIDEY7vxAm3OP8YZUiZYrTZTbffuGY/rWkuyiAmEbrT9bfwymSTuMEta1M/Hzj7IVsGLHXTrmU/ql5Zt0SIIVy2+fPxsRtk6bopiTtwkhTTyo6yZFI+RdZsAlbFgZqw+rUr7dlqcWGI1vF5XmsO3GgnyTl0mEISSfLpsBioDtcVMqj89Sb6nTrW6g7kNOnhB4Nf959NFzb7oze0B7RMe9sRUwzrGeIdaoUCPJj41xS38VWd4Cw8ARHDVMT/diHodUtHi8c0arayubVitEjXtd8TME8rY8un4V7+j12JMmvPeESwlACf3J3NrYu20Sm4lohaHdp3t2I1GUmHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsyDGety/YAS8WuYQDIXgWaNAJJ9bGY55CPVnfZQ/xE=;
 b=wWw99MINJNSfjBDeXT0C4cI8kuE9uU1/0K3nM0X1QXueIA0Bs2cJANsqANkrLQSk+gKujjknHRSTtwovEuWzSggHW/oJlbSJgN/VPXuFKufppg4fNamKukRws6c6bu3mRU3c2PP7MU2+5OgYEb8fJIp4PHZ9yHEX7BYPSZ24MUQtr2up/nKUnFm2Ck4MEtthvi2Uc+X+GTeq+snFC/qoKZhQCMKE0m4IQ+1m1fgW696XSujr/C7/lYq3aFP7wSuW1+tN6MUtxXpJVUUp1cDuoLyzs5ZqMO96u1hvifmBc3lEklxGVro+ZM5Nlxp2BGnh0l5DqLkG1ENvrHNoPYdFWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 06:28:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:28:25 +0000
Message-ID: <fe9b2bc3-2444-453b-b2fb-62248d0e7f49@siemens.com>
Date: Tue, 5 Mar 2024 07:28:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] create audit log folder with
 tmpfiles.d
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
References: <20240301093422.572373-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240301093422.572373-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 5833aec4-5010-48a9-974a-08dc3cdd769a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xK6X6IpCGoI+jvJrjaEh+UEV82YKeZdzVy8JWA+bcF7Mg591aV8vwsnp4+IFff0Gk16g+gUMmRkQtZGTVPKj5riADA4GkBV7wMHxWf1+S6TezPnl0hglOn1N3QphgKYZ7qXG/eg5FfEthhdpNaDY19FUi7AOobXKEpJp/xmNEHsi2G3ht+ZdEwk+nk21xHN7I4uSnjbjY4ZoHBz+29UWrVJRkjUwt8ig91dzFVf/FXOSMOQYVZVn8MbaIY3a//MUVJMLI4KHxvg1Hjr3gVPAOFgk73ASCa1wHddx5z8cQjMnH0pH4iY8TVZlHkN68NgL3fOvfBHPN9m4yxtMbePKk6IHCJbrUeNOW6Z5GM/wWMwK0mx1aojcTd663uekXkPxT/OCDzzx2JSYu0DJp8KjrBHdJ1Cb0s0Kd5c/oJCVzy0WoxyJT+jMQK7Av288kitT5ceCGbLEFWZoHt4Grzt/rGRhZZGut8qpZymXdLZ2rRhXL6NbUbzqCN+9o1Z1Z+3FrdgUm4iCitBU0vYtjL0X0ayoHMCd0V28G1NQ5oo/GCYArv+jkAoyrQt3qOqcmD4xLx2U1bsiRFh/LZR13Ftrlfp8tYX4sTYE4WIE5N3ec4+BWs8Rse5SqrXsMKemYimfUdDWikNxqJhHsBfyR6UNjcL00il0HOFphDOBtHuk9cE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djM1b2tSeWF6SFRBVEljbHZDQlcraTFyNmQ5cUttWnhlS3FwcGg0MUtDWW01?=
 =?utf-8?B?UGE3REMwNkJGWDM3aEpLRlBlU2U1T1dNdUFSbk5JeFRBUDU1OHFKZGFIUG9M?=
 =?utf-8?B?V21GU2Fjbkl5MjZ1NjZCUWdLeUNlOXc0ODMvMDBiMFN0R21ocjY5NnBiUTdS?=
 =?utf-8?B?VjVMMmlCMnRPOGNSQmhPQzFWRUcxM1drYSswS3Vrbk51KzJOc3pvRDhSWmRy?=
 =?utf-8?B?NzVCenJVNXZZbFZWY2JLYklRTjd3T3RhNVF5cytGdjVjektJbzZrVUIvZUZj?=
 =?utf-8?B?U2xXY0EwZmlTcUVGNHBkakk0NkdhaGIxUXlYWmxjM042YWxjSjhmMWlpdmlu?=
 =?utf-8?B?MWRqQ3RsdTN2N3p1eitDK1VPdnBIeVVHa0ZrQ2g2QlFBK29IOFRnNktCeXAy?=
 =?utf-8?B?cVV1MDhJaVpLNnhmZGFRa1JqOHhaVE41NVJ3NkJkSDFZNVVZVDJSQUk1b3A4?=
 =?utf-8?B?bjJnZFQ2aU1uUi82OXI2WjJGME5xNm10aGtBQ1Y3bHY1aVNwNDgvVkhNd1pT?=
 =?utf-8?B?dUkxeFNPQncyL0VNOFJXT3lZdlVQOGZudWhPVytrN0d1Wk5nTUVXZ2VkVStT?=
 =?utf-8?B?YXJxNHVURHpIeVFXbWN0MTltWmtMai9pV2txTEtiTEQ0YVNCMWw0dXk0S3Y3?=
 =?utf-8?B?VkN2eGRKZmc3OFh6aHlYWHdOZXJPdEorcUE5R3ZVRkU3K1hpSnFpU1RSNWFU?=
 =?utf-8?B?VEdzci83dlFsRW1qdlJOR25lMkJGRTdvK0JDUGpHU0ZsaDV0anZJd3dGWFox?=
 =?utf-8?B?d3l0WFdubkNMdEM4VVpvV2dhYk1xa0xCREFtWUtLYjlMYWJrNU9vOTBFd3RB?=
 =?utf-8?B?eHhodGF4TVVwOTdjdk53UDFRVVdSQ3Evcm5rYUlKV3huZ1dDcmNtV0JEUU55?=
 =?utf-8?B?d3g2dHNxck9aUFQ0N3NBWk14bUplU2hCSjlGZTEvVkRrakFaOW1ERFhPRjhC?=
 =?utf-8?B?alFVL1ArY01NT0xUSExvbDVqMXgydWxYRndSKythSzBjU1VlS1F4OUUzbjhP?=
 =?utf-8?B?aTVnd3lScDJsZitSMFJ1ekRMenpTcmlVNFhqMGxXV3paUWVaZHlNaXNVWnU3?=
 =?utf-8?B?TlcxcFZmMWhDUkRINHU4ZzZobnhFTXN4QVZZbXZ2UXk0N3EyMWlMRW9FWU52?=
 =?utf-8?B?M2lVSG8zakMrVkpqWTRHQkwxNisvN2NobzU0T0dSSU1EM1kxZ0lYUGY0Q3FO?=
 =?utf-8?B?b2N6TkNYQWlrc0ZnR21XMTBQU0t5d2RCTVcwQTk5YWRLd05YdWpEenZ2RWQ0?=
 =?utf-8?B?OEtVQmJmOWtTRVNXczFpM2dRKzhXOTRTejZkRTNJcEZySEZZUmFvTEJJU3ha?=
 =?utf-8?B?b20yVjlKcURhYkp6Tk40bFJtQTVhWW1Yc0lienU5ZlJrYWo3QmJDSXcwZVMy?=
 =?utf-8?B?ZXpSTTJrN3BGMy9ZWElGRUQvUkNxMDVXR2U0cTZzNnBvZTJ5OWVEaU1GQ2xm?=
 =?utf-8?B?RUxldFcxLzIybHUvZmZKcGV4MnN6d2s5ZTRkMW91UnZzQ3ZUL1lnMmQ2dFJW?=
 =?utf-8?B?MWhhOVErekx3V3Y3TXVnVFloT01hSjlxbjNJVzNKalBkQVd2WGNMTFh5bEFG?=
 =?utf-8?B?eXo4VjBmdUtNcFdSUXVXOVk4UmI2QW5EUUg3RjhaczU0cUdlQ3ZuL1BsMDFD?=
 =?utf-8?B?YXE1c3NqMzRQdC9CV0YrWUhQRHd6VUhZazJOaEV4YVFlVnBCK1kwa3k5Rno5?=
 =?utf-8?B?ZUd5djQ5TWQvalV5TWJWaCtqbE5aSm5jdUJacXA1VUdRWThCV0JLNkhnSW12?=
 =?utf-8?B?K2IwQklIeUs2ZHZHd2ZvR3ZZTVhEOWZxTkptTkM2V3dJSWJBWU1jZ1JET2Zi?=
 =?utf-8?B?Y1Q4Wm1vSEl2YnlvNkhIbndzRDErY3U4U2ZrR0hjUmtWTUdJVnBtYVNnZHpP?=
 =?utf-8?B?NW9wdm1iL3dENWJXTHYrUGl5TU9TODU2MFNldFp6cDRreE45VW4yK1QrSWdJ?=
 =?utf-8?B?WWNNTUpzWXJYdzJmdGVncVdVR0JJdG9jL3o2eDBMc2VGaXJrYmIxNXVtamdU?=
 =?utf-8?B?UDdjUjZmb2tIMWFzYUc5MXA2RDRqbXNIV29ybzhJSmowTzkvTERHdUlzZTMv?=
 =?utf-8?B?WnR4RkJKQW1qVWFvd1FsaDFxWmRhOVBrYXJ4MXRKcWROQldsK0ZqRkp3UUls?=
 =?utf-8?B?RXBOOG5BYk8zaGhxS1V3OUNlRS9vMEQ2L0xEa1ljUS8vNnFLQmdWbE9DZDZE?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5833aec4-5010-48a9-974a-08dc3cdd769a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:28:25.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUKBFWjqP3h1aqBHedo+6ChItQPbv6/gDQPPpa3Fy33DbbUCAODfMYt8pZJDWncqdsSkbcapc5LRmCcjHTHCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5514
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 06:28:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15206

On 01.03.24 10:34, Felix Moessbauer wrote:
> The current packaging of auditd is incompatible with an empty /var, as
> the directory is created at install time. Until this is fixed upstream,
> we add a tmpfiles.d entry to create the directory if it does not exist.
> 
> Fixes: #101
> Reported-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
> index d180bc5..2f7c338 100644
> --- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
> +++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
> @@ -1 +1,2 @@
>  L /var/lib/dpkg - - - - /usr/share/immutable-data/var/lib/dpkg
> +d /var/log/audit 0700 root adm -

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


