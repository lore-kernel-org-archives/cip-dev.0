Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F82C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 13:50:51 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.75])
 by mx.groups.io with SMTP id smtpd.web08.7556.1668088250161870242
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 05:50:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rstnnsKy;
 spf=pass (domain: siemens.com, ip: 40.107.13.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WChzI37oBeXi+Lqb00X+3gVjzoxgX7b3fnvQpLWWcNfHFSJFFgXlcPytqkwFsTOGpd0mFqkOliEZIackqODB5yuQAslPGatHkdE2Qh/l48nQMd/gCT1jdgSaW6Vzp55QLHm/1Bbw+AO1ow50+7Uwy5hmHQaGYRWA8Vj6qB/mh+Z9cyRLNFD56Q8JAVLnO61OTlEPqS2QNRv40tw2GJp3eIPHFysJGAG63dWXJga/KtGsOYuNh5kcz5dgJBcmSbL83OUI+Qh+FLv7l3ByQ75CT1MUI/9ifrGhMBgsW9HZYP/GFb3u0u2qpXNXCgonE3I0kuwfZwv+4rztgiNsgfj6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHb5S4e0bz0N4c42k4cWFWe6pXXGXZR+aWOEvwS+mtQ=;
 b=B7+K5hiSs54NNeeNXPd2Ftrht1xBuBLRmfGWD8wVlFhYqB8s2/80jh8slsLmfDuZ/LBSuLnmGL6S9+UnUif0+Yk0HQyULZXP9YZ5T4B+m5VuR+0bXMSR9V1iUGeR+Dl3ppkOtnIgEFmlpHLv2hXkmQZCViiW1CilCFhlg5VMmRLwn7jI5TD4ZNmteHf91Uhas0aUdudixKjYkqA9KCxXiGbDdxI+dXTNuHl8i+ko3pm4vum5jYJHMeB/kFxT2wrTU5iDS10C1+ajyhu150hYcQv9QQ/1gktLdxiZj//NpqsZPFtGqjBVDiWqsRLGVBrfEBL8rtya1weAUTP/beyO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHb5S4e0bz0N4c42k4cWFWe6pXXGXZR+aWOEvwS+mtQ=;
 b=rstnnsKyoVo1qDpq/AxIBmd8HfSBj7avKn13czm2Rw30JGsvaHeOY/sFWhuVsmPs5xLy7FCy+i/TbpFEpugtNDDUGjcCfOBxSRSjz43o9ze2GwdJakEcdnqHjtRNoFix8Ju7EhIeHMiuyVGDgRoYTk8PKTkiEsTYKIb773GKf6KbhAofyjr03J1uFn0UZwyOtVakjFXeKDSfu4HLb/uxr5M1AmggH8HYwD1n9piDRYOUj1FKAR3fHOpox/GdYXAm51AZ9WIUbnUy3vFvfypRVU06cCfUJmSuj5dHokVi/lrYNmJ57BpDmsPLInECOTN4Fby/WvWmfi3TR5q08rpS5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 13:50:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 13:50:46 +0000
Message-ID: <e9359aee-7d3a-fa8d-2bbb-6f7e239190a4@siemens.com>
Date: Thu, 10 Nov 2022 14:50:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][RFC 2/5] swupdate-handler-roundrobin:
 Increase revision
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christian.storm@siemens.com
References: <20221110124503.274124-1-Quirin.Gylstorff@siemens.com>
 <20221110124503.274124-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221110124503.274124-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c44e373-fdb5-4601-af9b-08dac322918d
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ox4j0aHP+8yZbQ5jV5nhmgEVymeG/MKDmVasogtapZ80XJ/StneaVlxaTTKEjeTLEWe8Cf2TjR44OsvklIwYMoS+8lcQyJkcNP/o3jW8K9N7SiufBIYaQ1XGZUIz3mP9Y+fSatJUVccw1AQpYAejJY52cSnBxBh+UVcMuP34l0uDJ95BdLBjF4IX7JtyguN1vHchsnzCApEgBxYylS286QRJNuQLYL+inrbQ6flZbiKFi1HDGIUhUsrmtITBbxs7mZArx2tTgug2ZQlLraSjMO/0xEGavKsVJN67Dp+z46/4Qv63CrAs7OiWlqkgpU5FFw5fZJxSRxKL7wVtKYnEDgVi/c9lmsS9fC2oaVYWtcRo1feEWeR6skdRQquaNcjRnwXUviOheGbFwuSYzndjx4r4pBqmjchjBkgh6gyzkFdgyzhGr9voqt5yWpfMIvbd4RE48deE5XpYYni+pwFVjmHTMPqys0EZhcIJ0WgJ4mxJMTUy/gQ9ylzAIqQeQDauQJacyu8RHTGIFjiIWjd5rRtslTg2035N6SItWGb5lQGKA1qtEafkAoSA5zpR+arquMGQHZy2tixDQ7zxKEVlDrFTsOdeY2vqRcstnbEPkz13/4bsulmHcVqY8PTVStdqUt1BxNQ0Fc/VOrPLAiI77HhA/I/sKyDBr5AEkwTwFm/MBry8arngl79ILo6IM9OQDwuO6Gv1kxHCm952vOIlmnGGspU8FyCaayplvCdhlguobPZYWBbNzlrsYKpIVJNOSzcGO1VjdFKFpeMgPZkJJlv1QB7cAoZ3tY5R0XeaOOk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199015)(316002)(66556008)(53546011)(44832011)(6636002)(66946007)(2906002)(6506007)(5660300002)(6486002)(8936002)(8676002)(38100700002)(2616005)(83380400001)(26005)(478600001)(41300700001)(186003)(6512007)(31696002)(66476007)(31686004)(86362001)(82960400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2tkTjNsK1NxTC9aZDc3UHk2dDA5cG5rZHFpaHRYVTRtZWdRd3F3aHpuVlEw?=
 =?utf-8?B?bFpFTWxVRUlNM0c4TGZSeE9lcnVWZjdUYkdnVVJwQS9sQTduTUQxNk9zbEVn?=
 =?utf-8?B?U3MrNEF1WXdqM1FvZVBER3huY0d1YzVKWGFnbTJ0S0VGSnBZd1JGMVV6aEd0?=
 =?utf-8?B?SjVtd0JiVk5EbGlUNnBwRjE4M053U2hxc1Z6UGhMNDRzS3RaZ0dkWndFeFVS?=
 =?utf-8?B?QWxORnA5TEpIT3BDN3hHVlBWbjc0TStQNFVVNGFMV0tGbUNHSUQ1dVNLSUFl?=
 =?utf-8?B?UXRsUkg1ZWJmdlM5YU9xeHRMNlVFK2pWNytOSTc0TzNCZ2tnUXRyZk9leTUr?=
 =?utf-8?B?L2kvdGFJeGdLdDBVL2xTaGdKM2VHQlpheFlxa3NMZ2QxN1BZZm5CaERKR0hz?=
 =?utf-8?B?OEZCaUpubWEwaHJOZjFiUGt0b25ZaG9KdW1VVXFJOUpHVERDTnpQSWExZ2pP?=
 =?utf-8?B?aERKbEpTVGdYbnBRTHhYNlpVR0RWZUtTZk1WWDZJak5aY2svWnNhMTl5cStp?=
 =?utf-8?B?eUFFS0JZMkNpVnV4YktnTXVmWnBYZEJFcllybTBuejZkMzQ3aWQwM3V0YXlo?=
 =?utf-8?B?VlRrb3gwN2xrOWRWeVFWT1I2SjZ0TDNLWWI1WmZ5TkxzcFBlUHlxT0k3TU1k?=
 =?utf-8?B?akVuZWhmYmVVd3NUUURqRmY4T1EzS0dHRHQ1VHFvSE11T2FQSFU1VVdXU01o?=
 =?utf-8?B?bnVIWW9OeGxIS1lrbEovSFEyRWk0cFRrU0NXOTBUU3gva3FETDh1MjZPT0RR?=
 =?utf-8?B?ZFI0Zm0xMVE0YmpPYU9lSTU4T1pDeXNyaWFGSnZybVZKUnA4NE5HZzlzSHFQ?=
 =?utf-8?B?MUNvYkltMzMzbzBqRThIMkQza2RBNFIrb3MyME9JR0dpZ3hLbFBjU0FzOTZT?=
 =?utf-8?B?S2NHU0NiYjZpUUROVks4TlpwUkNXK09KeHdMM3plYlIzejJhRWVQV21FOEZs?=
 =?utf-8?B?UDlNTWc0YlM4ZzFNUXF6WlVrOXdGUHZsd2dsQVRRQ0xtY3ZmT1N2SVdXTVQ2?=
 =?utf-8?B?SVZMeU10L1JHaWcwdG9YOGhkQ3RLTVdVaGVVdGRSOUhzTE0wdVN3ZndwYUNO?=
 =?utf-8?B?MThaL1J3TW0yRS95eFZNZ0N3YnZvMlRBSzBJYW02SzlWKzk3cm92MFY2dzhl?=
 =?utf-8?B?anVjM2JXZjQ1Q2cxeHYvMmFmN0VJYTNzODc4b254eDNHNGZLOVY2VldVVE50?=
 =?utf-8?B?ZkIvV0tZV00wNmVaT0EzUVFtVFFZRUVjU25FTWlxaTliTEZ5R01hOUxrbHdr?=
 =?utf-8?B?aDZyYmpiU21QaVZra0pIcENWaEhScURsdHIzR2s5QU5XZkh3NlVVVWFzSEh3?=
 =?utf-8?B?ckVXc2V4bXc2SE5ENS9WSGZkMmV1Zjd1c3A5RkswWXZHSjZRalRJQUZ3LzEy?=
 =?utf-8?B?VlZHVngzTWZPc3BGSzZ6UkRjMTVYOWQ1Z3FrNytTMUJxVTJMdXYzZkEzYXZO?=
 =?utf-8?B?VjlVbDg2em1HWWlsYk5yTGFXU0JWU1g5WXJJMC9WNEJhY0QzcEdXUElwMXNu?=
 =?utf-8?B?U1UvdXZoYjZ5Q2Y0V0xxMXZMS0Y4Y25RTFZOOGRTYmhDQ3Myelp1YjVINHk2?=
 =?utf-8?B?MnNrWTkvZ29MNlJKT25jRDM5SHpjanRZcjZad0NUNTJXaktrQS90ZHIzK0hm?=
 =?utf-8?B?b1lnRkFkMTBheFZSeTZCOFE2cUFDU20rYWNqWjU0dlF0K3Q0Y05DODZaTE1a?=
 =?utf-8?B?ZDZYdlJFMG9hTWdwdE5zUE5COTlKbEZWN1owMjhWQlNBT3Bkd3dRNTBYeVUz?=
 =?utf-8?B?akJQUklpNGxJV3lQYU5QQktSSWFVTHJIaU9ZL3cyT2VwUVU2dFlPTXo3VFhQ?=
 =?utf-8?B?eUIvNHYyL0dvemRiYlFnQnFmTS9OZXVwa2pKK0VZOURmeVluOCtOL2E0RWZl?=
 =?utf-8?B?aXJqdWp0MDhrRGRhQXJoS2dKcHhwYkVIc1pyY2ovdEVISUxQUXNPVHVWMHJO?=
 =?utf-8?B?K2RuZlBxWDR5d3krQVkxZXdrL0NwSStBa0Zyekg3YXFjQThENFU3RTJtR0FP?=
 =?utf-8?B?dmw1RW5zOFRlM3ZnTzEyVS8xVmljNGpnSWJLUWJEMGFqRkhFZzlwS0NqWHZD?=
 =?utf-8?B?NVA1Rld3VlRQR0hia3FJZ3g1am5WazRUUnlWdTJoajNjcURHR3B0eFZNRHZ0?=
 =?utf-8?B?QzRWdlFVcFdWNXQwMmxKOGRkVExJOWE5VjE2Wkw5OHNIZnAyMzZyWEc1aFN4?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c44e373-fdb5-4601-af9b-08dac322918d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:50:46.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx6shpydVtDybzMUQl5zHSzEWg3XbkZmiclU8xcpiXIxod0ukzixMYSCUt5B7GVROqX/GpVj2LoWqPXx2EysyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 13:50:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10005

On 10.11.22 13:45, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 

What does the update mean for us?

Jan

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> index 5801113..65cd652 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
> @@ -13,7 +13,7 @@ inherit dpkg-raw
>  PROVIDES = "swupdate-handlers"
>  
>  SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
> -SRCREV_swupdate-handler-roundrobin ?= "bf73f04b1eec0b8714d3a1b56bfcd1431c58ba10"
> +SRCREV_swupdate-handler-roundrobin ?= "fbc8d8a7e4ae8c381198cab81ae3fb13398a028e"
>  
>  SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
>  

-- 
Siemens AG, Technology
Competence Center Embedded Linux


