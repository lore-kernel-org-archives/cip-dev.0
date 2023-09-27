Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CE4E80A9C
	for <webhook@archiver.kernel.org>; Wed, 27 Sep 2023 07:04:37 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.83])
 by mx.groups.io with SMTP id smtpd.web10.12118.1695798267802312542
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 00:04:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ML0dyTLD;
 spf=pass (domain: siemens.com, ip: 40.107.6.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZrCbWdn8T9/72FWjxRzflV4WS14+zzM7QWtvdv6uzo1za8YJICZpLqfr3S8nqmaao/RNnZIOI+waNEtbK3eRw46f1WxVw/iUkyNvHi6uH5O5LWnULrKeaeKXqoGfLD8jGLf2A0ApFF5gv7KpAr7SM2tDKUiXnu7fM7U8qvbEFePC3MjTZcTRolFc9jIcb5p0knBRob00kPY7bppFOBTBT7EMRtoSvXoybLMJdGc7eG/5WAXmd+9L/XC/ryCyooV1KIWj4d/mU+MA15GIfl7K79ejV1FAR0AwdNeSwedzzuMooFiP8feqh4Hwq+m4AuJrubPMc81ix9kGdYyxZWiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVOMi7KNcNsfKymAC6UifQU0AAEQ/1BHFvayRya5pwo=;
 b=aaJ/6VbljB5MfhTl0INT9TKTuneRf3zjeYmi95eXsovKKxfzxRCG5GNH+7Xzd7AFH2WrXQ7TzO8wy0p0mZAZAOG6hZyFY3dVw6HLnlGekkpgd4VQMA8KpHvgX2YNh2RzgJ1JArShMfS/LxmuRAGQVc5p0uZnUn4s2HSKVWc935gMepqZc+1aKlTwDWCscOjcwp8Jh1oColy5ZWNDFd7j5w3gdKXqdz6hkPdDdbaEmVi8ete6As/Ck7vOdrWIBJJSjBTfSjD0dQt0hBFXgxfZenAWzj3KsR+btFGAyyhh1+kxAlZ/86zX7xWNPtvhWCeenQXD8vAlVwcfi5joykAwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVOMi7KNcNsfKymAC6UifQU0AAEQ/1BHFvayRya5pwo=;
 b=ML0dyTLDAHWMHC25oa0pt9snsxOp5TTvnlYcII+BMubKg6gRLBUM0mMsB/cPhkSYXoj4JTHJD3yMNpQ8GLtYOmG69SgfpcdDiRm4nTtaK3YSLOrkN6URUv2UGlh/bAbWGt26FD2P+468ql4d0KnjpNO5n9MtjtqVASavMK7Zq8mkh5UMsCni7tDfe19yqLPawvFdxJljpK3qWoWzzhduaRMBEIAY5krV/ELtbycKNMt5JceWGEhTeVsbSLgC5LWjL5FtZH/KTku4sYxWgfW307KMT5PHLMhz21OejhuM6qD4m9Yur0N5rjHCiZMuxryYNGwzejMFw28ZPLOpTz2tQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 07:04:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 07:04:24 +0000
Message-ID: <6a6e4add-e51f-46d8-ab52-f0793c569281@siemens.com>
Date: Wed, 27 Sep 2023 09:04:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v3 2/2] conf/distro/cip-core-common.inc: Set
 dosfstools as build dependency
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <e9aeb66d-91f3-40a3-8b5c-44b75bec3544@siemens.com>
 <20230926164021.30185-3-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230926164021.30185-3-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3627:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ea88ce-2e2e-4e56-2a66-08dbbf27fb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h112Z4KQwIHGFqry+2xVmWavm8mrIzoGnxJZbR59J7M7iWN/9g9ZjpiKLjnpk1JLyVDAGhC2ElSuO/9RQTSCfUPsD40INU/WlqARMmpqXj39IZqTr6CbzGFXSm/QuwwPdMUh1GKsyrG2qQOQls30C4Z21XP7pkCorxm5tFx9qjTQGySE43P3kivX6H9vg7USkhpHSAu1PHlvWIpiyDG9TnrBRrlLG5oFq/6+f3eloRd2b7u8Q7iMhxhpxatMRIWt5QKh7OqDp8+eBCjCTs+9QqAbpVBiiHrgbOdAKeds3olxnPHjXZNgTYtk85H3Ti8BhRJ+RIi8R+fixUCXngwFD+G6tSB87Oc2FjFGaUivOF4JBZD9oH/XiP8KCIpU3jaVnLakYY+KKyQ2QoqekExYL5WIul637ThWr5UtRvtnPkGINnGDKbFTZWo2c5PuPjWsGqAhNSUwsKpCVHqZ1mTNNy1eyqUng0Gpwya/y1w9Wwm6+qSX12ACjAbPP1eiJIcR2ZKT4GruDBI5mFBF3WkMG4eeVK5zWMR15JI5cRSp6rKoWvUydgAF6GZLVHmWuWWLVOOo0mJGS80g+l7C3+fxvSjw7PaePskvjHv885yXpk1GadYHlBWapVvRFU6XqR6pE2oh8Tbf9x5c2fQMZOKN7g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(44832011)(5660300002)(8676002)(66556008)(966005)(478600001)(66476007)(4744005)(66946007)(8936002)(4326008)(31686004)(6486002)(6666004)(6506007)(53546011)(6512007)(36756003)(2616005)(38100700002)(31696002)(86362001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHJyL2FFVHJ6NitOV1hNNi9Rd2pielBXMmh5UmVTWnluK20rZlBpb3F2NkF2?=
 =?utf-8?B?SjlGK3BPZDlLUHVWekp0azExbWF3UkNpOWpDbWg2UTBqcjhqTklRNGVOaS8z?=
 =?utf-8?B?YWFXb01hTDBIekdwWmtVNzhpWGJZZy95YXNwZGVyaUI1UlV2czhoYno1T3dR?=
 =?utf-8?B?cG1zQ0owRDFvcHB5U2dtSjRlMU9NeDBYMURnM0dndVRQeFNWb255c2NTb0xJ?=
 =?utf-8?B?aHo4N29hS0xoR3JYUlZsRU5ZaW1SRVpUUFYvUk1SWFBwY0pFSlY1eE44WG5S?=
 =?utf-8?B?OU1zcW5aUjBFenVrbUFJSGJ2RWl4L0g1ZVRySkFZZWhTVkRFeEU3RStVNExE?=
 =?utf-8?B?djhlTUVVaDBvcHYzUFhjVTVMNG1yVmZENkRzcFI3bjhGR1BNM2Zkd1B0d25P?=
 =?utf-8?B?RjlsWEdleHcvZndvSlFPSVJPVDV6RjNFSzBYY3FVYTRjTnVVNVc4ZDNIT2xT?=
 =?utf-8?B?YzU1eGU2NExkNU9xUVdPT0JVSGhvbDF4VWdIYk9oVFY2c25qZGpaU210VWlt?=
 =?utf-8?B?NDJJdVllbmJhdjZoQkd0ZFpBVlFxcWtrQXBLbXlSbGpDMC90c1VVbmtBWS9G?=
 =?utf-8?B?ZUFJTlpqUUdHQk92QzM0dENJbkhIcStUSHl5cm5YcGgyK2lqT3BxSjhNMnV3?=
 =?utf-8?B?SVVqTlM4bVphN3pmVWxPR21helVDUVd4TFpmR3ZXdDNaYUV2RjZIdDlydHNP?=
 =?utf-8?B?S0ozbDYyY3pYTERkYUpzTzNaS1hsTlpodGgveGYvZFdITHJ5RnR2YjluOUg4?=
 =?utf-8?B?bEttWmJZMkptVDZ0K0lRbWhyQmpqVWR6WFh2Nk9GQ0hKdjc1MVQ1bXhnTXo5?=
 =?utf-8?B?WW01elVEV3YvcFovNmhOMzUzWngzK01xbWx4cHNTNkRZWHFVZDR6SnlnUm55?=
 =?utf-8?B?WW5HQjlNVWpHQWRBc2dFN3NoTFFVbkpFMmxYK3VKVmtUUzFsSXpJSlpyOEdX?=
 =?utf-8?B?SjlNZDJMYmwrdXdRZU91ZmF2VXBNd2dBU3h6ZVd4OGI1cWVTcVhzTzdabUlC?=
 =?utf-8?B?R1hNN2ZkOU5pT3VJRGFYTGt6NHE0b2svL3duZkdhaW1JVlhwQmdkYWRpaGVn?=
 =?utf-8?B?Um5ZYzZ3L3dES3R4T3U1c1BSWDFUYU9TcEVKYUdoYm9nZXBwM0hRTFg5YmRM?=
 =?utf-8?B?RW9MdllrUC9hQVFPcmFsb2hUa0QrVzJ1ek1yYWxtNDNCS1FFZ1RwNDgyUDVp?=
 =?utf-8?B?RWNXM04xT2pFQWwzRktKdFVReW9YUUk2cDN1NC9xT09ZQ3FlWURkVXdBK0VF?=
 =?utf-8?B?YmNFaWs3Q01vZXdyeDBnWEorM3oxTVNaZW52bTBGWDAzVE84SVdoazlqa2xy?=
 =?utf-8?B?TGxiMVVhbkNaUVlRbzBwN09vZ2RJS1hqaWx4MGoxNkRXSHRxdzB5cXZhWVBD?=
 =?utf-8?B?dlJkUy9KUVk4a2dCR1M1SXhWOGhmL0daSGVEdEhSUUpVTkhXc1dHa3VjRUpV?=
 =?utf-8?B?d3JjNWZ1bzl5bVk2d2paQW51OG9zOVZzKzZWT3pNTHV3NnZ0K0pQTHl4WEtF?=
 =?utf-8?B?NTZhWWdsRHlzL2wycUZEamJTZ25XdGlDc3JIc2VsVjJScmtVUWlLT3g3TTBh?=
 =?utf-8?B?TE9qbkxXdG93WGNiMU1GVU5nT0dnN0ZJRzJQbHl5ZnZzeEhOYTFOd3pzUHR3?=
 =?utf-8?B?N0RDOG5EbDJVZFFqL25LQ2k1KzFudGZFYlY0NmhWQm1DcHFLL3g2ejZsYnlu?=
 =?utf-8?B?UnlzMDd5SEN6bzQvYW5CNHQyM0NTNldLRXlPbFZ6VDJBYkdXZkNUc0lxQ0p1?=
 =?utf-8?B?ZkI4YVd5MUo3YUZUeUM0ZW9JcDlKWG1oamxPOEpKclF6ODhXYmgwQ2lkWG9k?=
 =?utf-8?B?TS96WmpxbDRkRlZNd3EyQThvUmlSMVpiQklLdWQ4THE0dXJuUTlSMnBkcHo2?=
 =?utf-8?B?cndvM1FjSi9halQySllZaTUxU3RFc1pZaXZBdmh3RXZMMG5YaVhXVk52c1hw?=
 =?utf-8?B?MUd0U3hUNUJaYXJHRXNaSEpBdWNrdVBHaStZSjREcWtDWE9ueXo2ZzRPSzZB?=
 =?utf-8?B?YWQvSG44SXJMaVgrUGJDc1E0UHJOVitUbnpicWdIOGQ3cDFZNE03WkVBRmNm?=
 =?utf-8?B?YkhKZHVxaCs4cXR5UFF2cjhKbWZycndPVEozS1g0a1U1MUJwbHhTdnRkUTFZ?=
 =?utf-8?B?U2ovTjZickd4UUpBR1d2SzA5RGY0VkVtL0NzTU9uZllxaDNYQmxJdGxSeW5t?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ea88ce-2e2e-4e56-2a66-08dbbf27fb8d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 07:04:24.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIj00UD2SG6XWgOknhEXmb0/Oybit9dcNA4lBqW2G+KjTT1Q9g6/5wC2Cz6J4DngjuTT94yOrD1I0oiITScMag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3627
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Sep 2023 07:04:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13235

On 26.09.23 18:40, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> custom dosfstools is included with fix that will help create DOS images
> reproducibly.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  conf/distro/cip-core-common.inc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index 5d3ce10..5a158f2 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -14,3 +14,4 @@ KERNEL_NAME ?= "cip"
>  WKS_FILE ?= "${MACHINE}.wks"
>  
>  CIP_IMAGE_OPTIONS ?= ""
> +IMAGER_BUILD_DEPS ?= "dosfstools"

Unfortunately, the patch does not apply to the buster version of
dosfstools, see e.g.
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/5172706817.
We either need an adjusted patch for that release or need to skip buster.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


