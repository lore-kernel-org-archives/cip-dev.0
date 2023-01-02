Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B2C46467
	for <webhook@archiver.kernel.org>; Mon,  2 Jan 2023 10:37:43 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.45])
 by mx.groups.io with SMTP id smtpd.web11.32656.1672655859060728601
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jan 2023 02:37:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=au5qYsUV;
 spf=pass (domain: siemens.com, ip: 40.107.22.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dApZY1b5Wmp8+vnuSygaPTduJqBM2YYh7rw4SWgssiVmGmRhZd0avY8mfix+J0n322d3kyWyXFl3DHyI5tU6OkhOjZSpmOBxOa/vplG9X3Rmv8b9+p4DERiXBK4wjPRlD/rnLAVY3b2y0hmacwmCuEAb7amvga3llO1hootfinrGyUKR+9m47eVn0+bUV2SLoLhMVMMtT837PHLiu1zX4anrBP0M43RlRb9+qPTGeZsPnrsl2d7ehRa49eX3UorPlF8J1TmKGa0ip2T7rPf9lvhhzy0tq+QSk2irUzQJyWKHq3Jb4/lEEL/kr3mjxowtUS0mCieznbLsXEsUsUmBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oFgncp5BAN7B69bbNSU8JW0mt6Bu9vyVdJClIBma1I=;
 b=PO2txwphCqv3vXBBaXOXRVzvzSGQ9ofkSYvaHwoz7n9jQQyxFUOsqQSPhbqNgJY9ZgOp3XL1O0AKSXZfjw/iLR9k8YbfVKCiPQ5IPliPjbhPjIojmrGNb0pT1BiaupQAeliXr/0CcNTE2Z9Uqq+9r+0uhXjuETjAzOiTGGFRX5Fx8elPnPSMocpmNvAKnIx3+O29EHgjYJcEwfRDv4iHVd+UqBEGtcZdFlfYQdqwF6rYYFhxEZQwL9hheDADtEkasu6L25lpS46Ug1H3qYMQ/8mS7y7ZYcycoCq5Mauru8j77b6y4FA++ibSGPa2uMTkPq3fdM9gud7vdmiKMAEF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oFgncp5BAN7B69bbNSU8JW0mt6Bu9vyVdJClIBma1I=;
 b=au5qYsUVAWDNFtqk3kmSIJojQBsQymVLW4AKUoJAMZPb4iZa7lOuz+Nvf++N6a7JOOKuLr1NSHyn7f2cpXYUcoWlAZ4YUwv42bugt6kbiSUtfg1l6vQID67FvPB1N40aLo6S6EuM2/uTUoTC7wjEyvc0AmFHsWPWeVX3KwtUafCDawSY/FbLRPlSfdy9inT3lysfkI3pw1h39GXneREqcQqDsWMAqoMNRLDZvGg8LHBUwaBYORuckN9wa3XTFlWL3YNi9lx3O50j8DzcWoPzcL+vCa0X4QmfTDCEi8wvq8haNzltuvkfVPG7kNk+SdS+muxfg1fYzUICRDD8HJsDbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 10:37:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 10:37:35 +0000
Message-ID: <d45bf33e-044a-b948-3438-efc5f9ef80b6@siemens.com>
Date: Mon, 2 Jan 2023 11:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] kernel/rt-common: Remove
 prepare_build_prepend
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20221219132910.326418-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221219132910.326418-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: d6078e40-b80b-4b4d-8eff-08daecad5cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DSgyFcvSTskYfhasVXs+McYHcLuJi6Rt1z6OWHZpCVUOAcylZXJEWrIpFaZd+bGEGG0PuRaiNeFGzIwVu5S+5b1JusFs4IvEo/DOhpHboVyeOFcSj48hexiJi9pz5W3YU1FoW3nXmNIQ6a+EweAD4+8j9UxclyIoNCV120oT2oiyRjsz7cziZU5if4GdFYN5b4kxlrKqXCJQjIvNuWCRG88RL0JoV80vb759W1nTco6kqPhzWJPOcKaTrbcyJA1EbTT9oGfSpl8ZAtRXTi3kwjPlc9zKWu1NUyymz9u08DhcM5hKiWNsgcad0XqZa3iks4zQ11Hd7A6p2PTi9P6HjCOHTAeRyg/76O3zOjlNlzbanyX1GwLUIauCzkShmwltNP9yPy7+cvsslT30Spk5z1EPJJrmkc/AAWiynfvE8fRCnOEKOmh/xxQmOWM/7XPM5gW7aNsozAF4UK64T7rNGjtESQbuex36SDUXPJzE8k83jLyYsMMefuGx25sYj80FWq0hXj8tvXx52pmHQsQecw4/CmUksHgMlOAgKlUKTn7NrUS7SmvNCdBa9UDLZefzJHLhNU4XSChWeJZs+xLKHD3AYEHjJNgxvfcWPUKyry2DlyQmEIpSiq/d+SZbVLMod1RB0Ud2JMr9BrfgUeO0gBusOLCm3zrm8oATZwek+b/IzqyuwCndss+2Y1zJQ+PBOhEmBd4Y/prpD2rW3oGinZZiyP3Jb0REJjfwYuy2GNsZZf5nQ7NVA8Nxdt7+/ZjmMkmPmiov4jazQ2FUw+dYRtIFuN1ZXWzZv2NDGypPRDI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(31696002)(8676002)(86362001)(44832011)(41300700001)(66556008)(31686004)(66476007)(66946007)(5660300002)(4744005)(8936002)(316002)(82960400001)(2906002)(83380400001)(38100700002)(966005)(478600001)(6486002)(26005)(53546011)(6666004)(6512007)(36756003)(6506007)(186003)(2616005)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDlGR0FrT0FsQWZpMFBlNTJ2bkZXOW5rdmdka1RjeWgrNmxHR2lWR0ZJN1FF?=
 =?utf-8?B?SDYyelp2YUM3MEtpTFl6U0JrbXBBMEpxUitoWVVrU0xoaUFWcGZmbk9MeEFn?=
 =?utf-8?B?YWxmMWNUMWNzbkJLTUtWSE11Z25KbTgrOUMwaVZLN25pTkZyRmtwZGIyMStI?=
 =?utf-8?B?WTdPcVNwZFlwOFJoVFRPWkl2U2svb2YwYTBhUDEyR2IzUXg3NkdJdmhmVldz?=
 =?utf-8?B?eFp5bEdPNFFPMUpxT0JVbSt1OUVkWFFzUHpGMkRMMlAwQmhuVHBoR21QRnBZ?=
 =?utf-8?B?QURQVnJNdjBSTG5KT2pXcVQvOXUrbGRhaUNRTk1xOEQ3YXdVK2UyVWdVdHI2?=
 =?utf-8?B?b2JTLzhhWVpvSXF5WllucTE3RDErR25nUmxlQm95Mi82bDlLWm9RdDVEclZH?=
 =?utf-8?B?aTVDNlljTmtubGVoOEpkT3pSc2dLVWF2aUgySlVkUkVkaHh0ZVoxam9kdGxH?=
 =?utf-8?B?UE4wR2M3Z0RVWnVjL2x1ZjF0RzNZK3lweFRNMjdocktDaFRHbFJYUW1odkNI?=
 =?utf-8?B?Vm9xOWJBdmxsbDRsd3RlZ1dvNlZrUnV3MEFJVUdBR0EzWmduVG9LQWRlOFBD?=
 =?utf-8?B?R1pwM0V1UjIxOFE3OHVZaEprelptK3huYXdyandxaGRjVHRkZDhQNDQxY3BB?=
 =?utf-8?B?dURLUmhVSW5TS3B4N2ZUS0FpTWpIYXhsZDFIK0VwUmpvUDBuTTRVSFBtRUhQ?=
 =?utf-8?B?VFhKU0tyUm5MdjhmSHhxT1cvQUNubGtHZW5acmx1VWxQd0tIZDQ1MUIvZHpQ?=
 =?utf-8?B?MVI4RUZtT0xDTVhtMWRMYU9USWtjZXRDSFdFVjVMNVlDMlZmK2pZcUFOWUZ5?=
 =?utf-8?B?VWQwM2xERlJldWdiaEY5eEZpdnpqbE1WUlhvalNrQ1ZWRCtzd1hMRVYwL0tB?=
 =?utf-8?B?enQ1NUhFanpYQWZ3YnQwVWZrOE5JNm5Ta3ZrTXhKckR1KzZVMjN1aTI3YVdP?=
 =?utf-8?B?eHdodER0WVBjdTUxSncwT1JSR1VXT084YmtBcjJ2YTQwaW9hRlFYTnQ3Ui9F?=
 =?utf-8?B?dW15NWVNWHlKbndjcUZaMFdXTVZMbTlMSnBYMCtDcG1ZaHRWNGtEVURsbjVM?=
 =?utf-8?B?aHJiVzJ1a1RLYnR5eDJTNXloblVFRjFWQmtOenRJR2tzTEtzWVk2bW9nZ0xx?=
 =?utf-8?B?MEEvUFVVMlU2K09RME54S2RBTlpQaFRSdER5NWVKSi9IWmsyV09GeTNLRURH?=
 =?utf-8?B?U2lONEIrUGtIRHVBWVhhSDFpcE4vSWVXemFuSmZ2MWlBK3BLSlE4ck5zMitH?=
 =?utf-8?B?d0Y1L25JTFpTOUtEa3h2Zm9uSUVCeW9oNkVZbzBoeEVFT2NLSjFnVHQxWm5u?=
 =?utf-8?B?aE1VR0srYm9EZzFsUkRweEdQUTZPTllGSVQzVjA3dVYvcHIwSWMvZkRCdk96?=
 =?utf-8?B?aXJSNXNiYmJ2U3J5c3c5WTV4TDdHMEZGcXNsZEQxdUZZYUJkVERqTXlwKzNX?=
 =?utf-8?B?eGZoVUFHbXFaeW9PNkZiTkZMREFOUEJsMkc5Z0tnMnp5L2gzV1RYSGtORnRC?=
 =?utf-8?B?cis5V2hkc1dBb0orOGhnclBVVkx5cTNxOTJGY2Z5cW4yUGtxbGZJcytYaVkv?=
 =?utf-8?B?ejkybHE0VzIxRVo0c0Nqb2NQeFZVSUtYT09zWUlMeThWbmxhVGtuSFFMaEVv?=
 =?utf-8?B?VE5uZVl0K0gzMnRLM0ptNS9KVWh3cTNVc0x0bnJaY1d1TjRSMXFueFc1T3dT?=
 =?utf-8?B?SFpnTTlKNFQzTFN6THpNTFVCOTdtQkp3SHFGT0FUWEZJbUdJV3lodkJhOUZM?=
 =?utf-8?B?MHUwd3FsNkZpODJRZGtJMzIvVE5kaTc0ZTVnN1JFeVA4WXVKZEJVNTBIanRM?=
 =?utf-8?B?NDJGa2NFS2NvVmFwTWlaVFFaWHMzTEtpOEhsSDUwV0hsMmdldWpleWtrVlp6?=
 =?utf-8?B?OEh6NjgyREpQL1V6Rk9vdFhCdEZXUDZBRXRSaEJHSnB0T1lWY0w2TWhzOUJp?=
 =?utf-8?B?UVFwdVRGaGVZRzRRWUlnbjJLWUxISkdRZlNGSklUaUFUOTdwRFdObzlpRTJC?=
 =?utf-8?B?SFlUMHI3dFk0NXMrcXZFUWtFOUZMMVhDb3ptazVvVWtZMkRsN3A3MWRXN01p?=
 =?utf-8?B?dU5YVTc3WDlaQngxdk9LTTFCMzZQQmZhdFVodG5lRFREUUtQbnRFem43TzY5?=
 =?utf-8?B?MGx4bnJOZ1c3ZDVqYjlhMW44dFEwTUlxd0R0cm1zVFJHVmQwcys4M0RMSmNj?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6078e40-b80b-4b4d-8eff-08daecad5cab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 10:37:35.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gtAubPHnPnC3oAtjF7LpX0xxI1239BuAPppvohFNPUnGUzStAxn7TuJ1ofaM62rQ0xBNj7BFNz2jGy/GBLxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7814
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jan 2023 10:37:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10272

On 19.12.22 14:29, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> *.cfg files are automatically added to the kernel config.
> 
> https://github.com/ilbers/isar/blob/d26660b724b034b602f3889f55a23cd9be2e87bd/meta/recipes-kernel/linux/linux-custom.inc#L119
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt-common.inc | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt-common.inc b/recipes-kernel/linux/linux-cip-rt-common.inc
> index dffb77b..8e2c293 100644
> --- a/recipes-kernel/linux/linux-cip-rt-common.inc
> +++ b/recipes-kernel/linux/linux-cip-rt-common.inc
> @@ -13,6 +13,3 @@ require linux-cip-common.inc
>  
>  SRC_URI += "file://preempt-rt.cfg"
>  
> -do_prepare_build_prepend() {
> -    cat ${WORKDIR}/preempt-rt.cfg >> ${WORKDIR}/${KERNEL_DEFCONFIG}
> -}

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


