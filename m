Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA4AC4828F
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 20:23:20 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.50])
 by mx.groups.io with SMTP id smtpd.web11.46914.1707078192746837164
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Feb 2024 12:23:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QI6OSsTu;
 spf=pass (domain: siemens.com, ip: 40.107.15.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9o2x/GMtlC8Peg/OPDj6cPbD5h2WqEvoJEBWWgl6lbtQlBHLXWZ628XXRdiPOY+L4jveNiErp+TaEXjZmdCGi2AkblCyLkpEG+Yhx3m/WwB2B0Z1GCpDGKxOjmXcFaEm1+JcsX0A7DYjF+a1gJsW0TkI09WVudDikp2N8w6t0oMawVK/wUyfvnXQGJlDcG4omwO+2k19v/dyeau8WMFPENcJVwyLJ2kY5VSAPQd2fw55XIBxH3yuCTzhPuZdkRKsnu/CGkSDtINvIoW5qyNRvkrRq2wypz3kS/Qf9iTMlZMvQyW5fmFawBcdyIqMDayOVyrzzRLBpmLF31iqnsaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFQAoj4ua3TTJ/g2zmqKPJHG4HgZGHEZBDCg9h/QQ7I=;
 b=R+2L2wrFgQS37Pg+4qOH+sj3X5RKfMBL814uqMaMExWF9aeyjx7EEkTkNHTEP6O6tBSHheejUDJ9eOs1PXUFn5Sf4i/oA1XSTC1uC4KVNLNgq90cQ4Uewk8GNn3uScixoxol01ePwKQ9cCHfo2UBGeCT8cz9OwVn2vg1Ck+HuTjlRFun5sKLkNvmRB4r/6coveh3ueqVgq7XYQSXZBM2TWkC/2yOIrB3kGHCeBUrYyhiDQbuT+ogTCYUWtcgOp4ijcQ8ZWa/hChAG8Oh9nXN0ebrtQhbHs8D+DAeBt2VK+fbf3ttR/26PY9L8gp1t1896Hizlhfb3yfGNn8uFMjaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFQAoj4ua3TTJ/g2zmqKPJHG4HgZGHEZBDCg9h/QQ7I=;
 b=QI6OSsTu+7pRPsRnJkvf3B679CHHbZ2JtI4G9lcBSsgpVrjLIxRam35/oEYDWxlVjyBWregsKRWiTQNakCDwqqZRj+6rZzFPtEtSFApB5sQARYXP7e1FKGNrRDW6Hy2AYGaa75dfYlDuuMLncZ9ml2F1xuNFw5JGI2O6DljFzh1PNhD9wsjLNWvZQI2dhULdi77W5vEPj8DE33I4AJxdeGJ/yx5AK2zZ1YythACrw1x/4UOIhRsx85LBzQK5o1jhQhM/q7RibaG6QARrrZydi/ELNLql1qjtdUBG6w1qb0ZYSH9fpu4/yj627K7vFqKFomUGDlvNEQ4R0q0o994OcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3649.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Sun, 4 Feb
 2024 20:23:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.027; Sun, 4 Feb 2024
 20:23:09 +0000
Message-ID: <88372d09-b38f-45a6-8b54-bffdbacac2a3@siemens.com>
Date: Sun, 4 Feb 2024 21:23:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 6.1.75-cip14[-rt8]
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <a5d2083f-b9ba-4b52-af23-51eafa8fbe89@siemens.com>
In-Reply-To: <a5d2083f-b9ba-4b52-af23-51eafa8fbe89@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3649:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f65b689-bb84-4dba-fbe2-08dc25bf1ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jr+cl5NPmHz/u/vvH7G3gaHFRarPHH4iTqGi9zHRLl4KJaKzigLhXQBDkMWDj00l9QtWYsSV2VEd4c6so9J8fcwKr0yY9WsIYpoOUMWm2RpFvZAA+SdC3kz+YA9FUhlxKTRe7Fr8BEfFsolBsnLBvtY6HFABA5J+swkuDUC6cEClA53k4UciDQPlAqyh896yYxgAPZGLF58q1AAvvQWM1qrD+2wDdk1VOGxH0m4LzCrpX61/HphiuvTqVGtmajBfmSzqvccO6pbKPQELbl6nynbKZd97M33NSJnQfmM4OT/ZMEfxEYDXVuq6oHTED0hcYU/Qv/SWs6xrXYH7+36mH/FPUaQsMkM6XqeVDvvWsYkRouG1bSHKZLhZSR0ap6zmhIgat/IoWCL5tbK6aFCwGxfwy94Ro9RPFjQ/XW4HYXT+7Q2srTQ6Qw2YTpVrD9CkLuJSTf1BK8kP2c6FF/e1o2y1j+M2RJs7hKZndinB6I1Jr5iVCKvsD6S3SVRmjNiINBrJbv0bUagL65EHUAjfjFTPP0irNo3T11v0SxbiIqHNFGK9vbWQpylAuNGqdGUVzqcJzrJG3HDufNlk/aJ5lw1dNfPYEDiU8wSXQQdWCUdv5EZqVa8QuiCc3WKTvo9dd8UE1rLkFM2XA7VdOhTV5A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(83380400001)(26005)(31696002)(41300700001)(82960400001)(38100700002)(316002)(8936002)(8676002)(6506007)(6916009)(66946007)(66556008)(5660300002)(2906002)(66476007)(44832011)(53546011)(6512007)(478600001)(6486002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUlvVmlOa1FEQko2Y200RkFMMVQ1aTZCU1JoRzlkNWx6U245Nnp4L2t4Tjk4?=
 =?utf-8?B?SmkzMTR3OHhQNnUxU2tsTnhLUXZONmd2WFVtV05VeWFDL3YyK2NpSHZvakw4?=
 =?utf-8?B?VlZVZFFOdmNPRW1ESU5mSTdYTWRLdTczWm5UL2pJbnFvZ1YvK2hsY2F6Yncz?=
 =?utf-8?B?cUtMREJvRm1DODFqWlV4NjV0Zi9FbTd1YXRuVHg1ajltQTNjaEtUZjBVdUM0?=
 =?utf-8?B?eVVvTVJ4MXE3RGcyUm5DN04wOTMvRXNXWlBXV3FFbm4rTy9KaVIxMUdpL0JQ?=
 =?utf-8?B?eERVYUY2dFh4RkFCTm5Wc25xamFtSXhWWEMrRWVjV0FFUm9tSEQ5cXI0QXdt?=
 =?utf-8?B?WG5KUnJnK0w0OFNxS2c4cmxzcC9zU2xlTVhLYURTVlJ5RDBkRjkrckFMQ3pE?=
 =?utf-8?B?enV0ZGRUZHRsK2IyZE5sL0FlN2h1NkZYRVNhWTlaNisxVkREKyttazBnUkJB?=
 =?utf-8?B?NkZPSE54S2x5clZvV3ZVY2RoVHRMdGFYMXp0d2RWZlBXSFI2UEVnRldmMXFW?=
 =?utf-8?B?U1RsNWRrY0wzUWpxQ2dRSUhsVXZ5bFpXdkF0b29ZYXBBTFRGK29CN1ZtemhK?=
 =?utf-8?B?amg5QVQxQ2NUa1kwK1BDSGhxTGdNTlJYWkJNRStHdlJvRGNtc2hjR05mZllE?=
 =?utf-8?B?MHZHUWZpVlR5dWlUVkVuVy9NRENiSytraUkzQVcvWXdrZU9pVDRNbzZvWDJv?=
 =?utf-8?B?Yk81a1JIS096V2R2Vmg2VitCWWRkcE1RZUh4dE1paVFpdFNTUTMxeTR4VWFU?=
 =?utf-8?B?am1LeW92MEcwS011ZGxNWTZHOTFmQ2Ftekw4ZkVZaGJMRTJteGdwd0pkVHEr?=
 =?utf-8?B?clJVdDl6cmN4Q2J4bTIvRGswY1padEhhYldxSG4rcVl1VlR5QTAwcnFtcENC?=
 =?utf-8?B?L1pIbXR4c284c3c5akg0NmVXMDNCSjAyOE1IY2JBZFNNdGI2bW11a3AzcDhI?=
 =?utf-8?B?S0ZYWDJ5YVc1ZmZPVE1Ua2Q4eDZ0ZmQvc2xGQ2FTK0VoVzlsZ0p4bHBzM0ti?=
 =?utf-8?B?c3V4WTVFM0MyRmNQQmtQeEN3NU9POFplYjNQOS83VXRFdkVjY0kzQjRuVzRS?=
 =?utf-8?B?MzBja0JHUXZ6OElFMCtSL2dERTg2Y3NnaDI4YVI2cE1QV2tRWUZsRE5iT1FU?=
 =?utf-8?B?a05PVE5jSWVjYVp6bTNUQWVkenA4UW9hQXh6aVhhM1MrZlJUb0c0ekI5anNT?=
 =?utf-8?B?QlRxTXRLbWs5a0lJdkJhaUY4QUhIZG0rbVkxaGFzYnd3Sm81K3JsbHJ2N3h5?=
 =?utf-8?B?RzF4TmpybUVObGQ2MUx4N0djU1k5WWZRdU5CNnBpaWFwODFITnpDMmFBRHhq?=
 =?utf-8?B?NFJsUUhJSFpmaFBDM2o1QjR4TGtxMDM1eitsMzdLY3pzMmlMWVN5VmtXOXYv?=
 =?utf-8?B?c09ZRUFzWkh5ZDc5Vkw4SGhoYStNbHRiOU1JRlBXanhlK0xPK1krTU4vYmpW?=
 =?utf-8?B?TEpORzNuMHVnbzdyMWFMUytLemt4QkRRWkZLTWhnSW4weHh2VzB2dTRSVkRr?=
 =?utf-8?B?V3FFL3lmMUtlMVJ0U1A5cmk0eEIzUmlmaFZvODR6OWxHWThYcUdzNE5uVm45?=
 =?utf-8?B?aHBncUxROHJwb09CVnZBTmppWmVGVXcrcEg5MElCSzhtS0FqMFlxUlNXckdP?=
 =?utf-8?B?cmNPRzd6UnNaZ2c3b0NLck50anN6eDZLRytPL3FJMm51bUMzUFIwN1N2K25I?=
 =?utf-8?B?RUk1b1dMM0xEL1hQeitkNE0wdksrc0JXVWY2UVNLWG5GWU1RT3RtZnc3RGl6?=
 =?utf-8?B?WTF1Wkx6bVlVeFFUUmxzOElnM1o1cXprSnliVnNXMHY4Lzd6SmFJTVB6M0FM?=
 =?utf-8?B?WFhxYmExalFYWWxNUUo4UlhNVWNmWi9Mci93NXJzaEpINno1dEExOEgzZUJL?=
 =?utf-8?B?UGZaaldGakVBeEk3d3JBd0dsellXcUxFYnVNR2U2WlpzWFVpdE1LdnBiZnQy?=
 =?utf-8?B?amlvRkRmQnVaMC9ucVZldW84T3MrVzI5K24vbWFrZlZhT1UxNnZhMnY5YU1k?=
 =?utf-8?B?c3poQi9BaVRTMHlFV1A1ZzhPeDdHb015V2g5SnJpc3UwZXRkZWp3TVdPYzgx?=
 =?utf-8?B?eWdPamlMNzZUL2ZPMnZmVUJ6NFJRSDBvQ2hkZ29WSXRhMjhxb3R6Y2hzQXdY?=
 =?utf-8?B?cWUyWTJwczRaamdQdE5ScFVOSktBOFBvTFVkOUM5T09IWm9ock8vZk93RmZW?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f65b689-bb84-4dba-fbe2-08dc25bf1ac7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 20:23:09.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LDkQsnGkCtdy3cFtO6F6lMWw0OHKtmojyBFBwIFYWEsqYI86W3GaouyEDGPRGPvvmrOjzdCfTkPhUD4mpygnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3649
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 20:23:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14657

On 04.02.24 21:10, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  ...-rt_6.1.67-cip12-rt7.bb => linux-cip-rt_6.1.75-cip14-rt8.bb} | 2 +-
>  .../{linux-cip_6.1.72-cip13.bb => linux-cip_6.1.75-cip14.bb}    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_6.1.67-cip12-rt7.bb => linux-cip-rt_6.1.75-cip14-rt8.bb} (59%)
>  rename recipes-kernel/linux/{linux-cip_6.1.72-cip13.bb => linux-cip_6.1.75-cip14.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb b/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
> rename to recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
> index 2e54a3d2..f37645a2 100644
> --- a/recipes-kernel/linux/linux-cip-rt_6.1.67-cip12-rt7.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_6.1.75-cip14-rt8.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "5b2affdeca3822cdad6fb8a236cdad07ca14f15d6e3e9b263dc1916667586751"
> +SRC_URI[sha256sum] = "79f42787e34aa9159f253849dcfbb4665048690105499b1dd77c4f66e65685c2"

On hold, this source looks bad.

Jan

> diff --git a/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb b/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
> rename to recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
> index 55e55786..4fdc6069 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.72-cip13.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.75-cip14.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "31baac22fe43d65797704c70b9bf91554f098f93b7731dd5ccbfe0ca7f0005c0"
> +SRC_URI[sha256sum] = "a820699d7342d8ad8a8f580da90e03ee4db37e9d5dac4cf8d14015ab3bae5f62"

-- 
Siemens AG, Technology
Linux Expert Center


