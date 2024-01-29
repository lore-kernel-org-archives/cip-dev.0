Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61242C47422
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 12:22:26 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web10.13455.1706530940790108711
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 04:22:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ixLPKtKk;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeUx7mX6EFUwzidYgwcMr+jkyCT/j6Wc10qhwQYmLMw8KYy0nRrmcn1qAWt119gHm/xP89eY6zvvizyGFE1XLafSFJewa0Us6lbOV49G5n61khA5D601Ju2DSYcHFPqsVZsbhYfMJ1xremMAeNWhrNeCRldE8Y311cRdX7+nZKEmtk5n9WLSD+cBo82h9pPh1aaCUcTLHPwtUXECwo4mn9Zumw2ARnTbFhgfIHq4axX7+odqLRDmry/jwjgBwXLfE+eULRLKOLV1kgdNKoDGpvK13ip5qyZWjOMkuGegSbylXSeCMs4CACEK4T8dTMz75iR6LkxAub9xETfuwucv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3MjmuiECz3Ae6tqMI2IX78fdk55LBm3iepsvPULTLM=;
 b=oE3QAqkpMiYgd+k/Fi1ZNAQWdhCH+Og1XGc7KlE91gN+ahex5KtzxS67Xlji9x2xof46JthsR2KtBwofBLs9C7ydwL1/S0Y+w9KYafo6ZZyhV3wNEiRggFFU+89MGidYl8+/57FvvIj2Yj7HSbFWFsF3mWVlpTZY1zfhrSPQ9nD3/PZlvyVE4UVaRT3V/3KpQKA1BNWjUUZm2FiI7AYe30fNPBEduQRiaLhwH/XaTMLRKszgmyUZPIurj7We1SePbG9wGa4/jeruz+tTOznSIqD/SflZYVo53K9JSI0JJRUxdvpggzscttS/vVBncmUhDIQRtddS9YYfIq0TZOjC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3MjmuiECz3Ae6tqMI2IX78fdk55LBm3iepsvPULTLM=;
 b=ixLPKtKkfQ5+o5cFcDgko/xRT8GzFt5sLQAzNx6i3779MRdnO+o0F2FpkIe5EhMsdcni7ufZ+x2B9YYys80ZjJAbCETzkqILBrhO9ZFrk1oOoRK0bTmHh+UghlEDm5ghjVFgH2eYtTkF5+OrzFBgbW4WTCqUy3Go7L0w36l9KXWT3zLLERkD/E7xRwLswotUrrI6+VJiefbsOdYHX9YxyZzU8SRuSmalzYTkZsCf253SekCkeKRIutSOIw8F7ydxzoH785/FhCRM6/8MiXzGQsO1I7vt3kgmxoFwc28cANcIAI7OMaqSOVD4KCkQ9lNzbk8jHJKR6E4cF8JI2SpMHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:22:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:22:17 +0000
Message-ID: <5866a5a9-c2a3-4930-9362-a3893ad309bb@siemens.com>
Date: Mon, 29 Jan 2024 13:22:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] efibootguard: Update to 0.16-2
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240123211406.2154661-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240123211406.2154661-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: e63d5f3e-eea8-4f48-38a4-08dc20c4eecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7fqziidpluBIUwb1EyEbKxbehNZR0vNep+AozfBL/tfj89mtKDBOP8rv1OpVzcytzhSR+mdlSpVS126DVqftIdmjdrXuHjJnG0Q4F+QdTZpSMwGYtesLFa1Rci+HjrFa404ZM68xQTUkvV726QBdh22YizumFcldJ54lozaaUFCIErYpBhdI+CfWvgkEHnRuAZywd7RFtaht6YT9yxKeXlBoq2+2xx+ABUh2+CkkyrqiA8Im1e5jmSiH6FdYQ4bwGIvFTp3bBYodaCKV3PQnKuSyi1Wazd7/+Of0z3oSKtXmuRMqSVzm9JgEEJLa9f9ne7Q9filxoK92iz4oojk1p0oy4Zz+KvrU7Ykt8F7j+jeF4uzqIB8DrUDyOmyVmvRSEHIEPdTi1C8dRilQfD3Sqi6CI0hTOBRjyjhP5dhjNakJyEwJn/nNXEgK7yal9p5uqatdZnRS8PHhWbXdGjwBoai2j6p1eLdQPfclhmLqxEqN+ao8WkmAmc0t5camuOA1E1wBC1/x+G1Us1i1YdBq8X/WPUk3MAfe+vxX36tLnZxt424yDbt1L7YagTFiO7B6xe6kwAt4b+q4nfTVoJN9Zdh+k9PdAFW17SSxLWdAt54+g9VChnPRo1BuxyT4WJKUumTSTU88ZJB+HbXJAyg6Xg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(2616005)(26005)(31686004)(66476007)(316002)(36756003)(6512007)(478600001)(966005)(53546011)(6506007)(83380400001)(6486002)(38100700002)(66556008)(82960400001)(66946007)(2906002)(31696002)(86362001)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WFNoRDBvY2NxNXl4L3M0d3RiSFFxWVpVWjc1QW5lQ0FGU3ZPWTZZdUpvem9D?=
 =?utf-8?B?NTljZjBIYlkwVllMdksvOUNqVXYxRDlFVTVPLzRKUFhMRkVOQVdGL2FGSS8y?=
 =?utf-8?B?dENWdU5FajhFWWw2UGg1LzcwdkpkZjhlRFhxQTNZRUFOYnFya2dndEl1SW5D?=
 =?utf-8?B?NHRCWHVkWnY2ZXZBbXoxVlpZYkhjY1NPYWlsaWF0S2ZnVXMwR1ltWHc1azAr?=
 =?utf-8?B?STVnQVNXb3Ntc3p3cjVDbEQyaktRL0lwYnNyT3VSR2JwMVpGU1hwS1R6RDNM?=
 =?utf-8?B?eTcwdkxCcldYamxSTDJxU0sxclFiVHZncEhPRk9QSXMrSmsrS3Z0MW9Gd0FF?=
 =?utf-8?B?cklraG5RbTVLUHZ2cnd0R002OS91djNHRUNjZGhxTzY0Y1dZb3JQcTB2SUtD?=
 =?utf-8?B?dlNZQjNtZjA5NEU5TGlIcmNvaEpxQVg0czVlR3ZuYmZsYzBmeXpFZTc4MmJI?=
 =?utf-8?B?V0RlZFdGb0dmZWRzblBuL01HYWIzZkFUSjFUbTRHRmp5UlloWDBmL1QvV3Jq?=
 =?utf-8?B?U3BNVU9wYnpaUUIzbHVPWnFOWlI3TWR1Y2hBMnI3UEljOExNT0xDRjFRU2tG?=
 =?utf-8?B?RStHSm9FV2d2SFBEMFdka1gyVStGL3Yzc3M5YTV4UmdBcmw5MjJjaUlQZGp6?=
 =?utf-8?B?eENTb0xJd1RqN2ZGaCtrQUk2dldKOERnVDJxOGZxYlRORXNmbE55RHVtb3Nj?=
 =?utf-8?B?ZEJwSENiWTRRT1NwaW92M0MxVjZERk9rZDIzRlRadWlQekgzTWRVSngzQ0ZB?=
 =?utf-8?B?Vk1XaElsQXlQblA1REZITjQvbWtmQnJiK3c3TGUxaHFtYW1FSVFkMk1KZ1Jx?=
 =?utf-8?B?WWZoUlIzU3lSWTA0d091d0tCOTdRMDRpQlVVNzlNWWI1WC9FOW5kZVp3YnJH?=
 =?utf-8?B?UzlSR1NoTlJpaHVUYTY3UEdUa3RRS3dvYzRBUjIvOTZDOVNmaXNMQVdSMWU1?=
 =?utf-8?B?L1pvT0hCSzR3NVNDK3d2RmFGMHRrQS9xYWV6d3VINnJTeHhISDUwTlhhSzJo?=
 =?utf-8?B?U1J3WWg5NXZyNHhsblVCdFpHVzRlbFprd1NCeWF1WkN5enRPc05Sd25mbnpG?=
 =?utf-8?B?MFVYUllxQmFFRmphNEF3VVBydUZzaHNOayt0MVNpZ2JMOVRpTjJlTk5LM3pQ?=
 =?utf-8?B?Vy9lOE1EVkZtUFdzaGpHa2JsTnRrT0FNU1BLK2loYWlENU9pOE80Ly9xYVNx?=
 =?utf-8?B?dG4xQXUwMTlUWDZjTWh0TDhrZWpmbXpMVHdmdFhvcTRzQmdvZGtPSXl5Nzgy?=
 =?utf-8?B?UEpYT2dRa01Id1d5dUZZdlB2b2hTa2hCckxSVjBvejU3RCtHM0ZvTGxNZzN6?=
 =?utf-8?B?SlV2c1IzV2l1VERGcVJmWTU3VXVOd1FLUG9OWlJFZ3FRRTAvRzFEeDMzOUU0?=
 =?utf-8?B?ZmtmK2EvSTEybzVhM2FJL1hvdVVTY3lxMERqNmYydlVxcmRZRlZyNFcxQXdk?=
 =?utf-8?B?bXJhaER3cWxReDV2WTFYQ1pXNjFCRUtsNWhzN3FabTFJOGZpK0FYSms0czk2?=
 =?utf-8?B?TlpWUDdQUkEwZTNzMHg2djlpbU9Ec0k3NDhkaE9vY1hqRk9VVnUvVDZGenNF?=
 =?utf-8?B?SHM5MDFmd2ViTi9nVGlCTEJXams3b2F0Yjd6cEdJTWJDT1FHb2N2VXJqc1dz?=
 =?utf-8?B?d1g2cE9PZENYbXQyZy9JdFFYVitsNXpEN01BT2JhSTY1VC9WRndoUEsveDhV?=
 =?utf-8?B?VUpzN0IvaW10THhzdGgreW9iUytESGdDdXVvaklTc2IxK1p4ZUNZWGJ4dFRv?=
 =?utf-8?B?cnZGaVJaSUx3N2FMUWdQY1pEM3k5NW9FTHBsRFA2MXBlSklUbGN3ZnBXb3Jq?=
 =?utf-8?B?S0lOWkdTK2VmMi83WUJ4R3ZDQmJKd29UZVptT00xa2t5ditKbERseTlzdXZu?=
 =?utf-8?B?YjJqZUhiNjc4Tm54b2lrS3lFajgrd29qOTNXMUU1YTlKUW9NSGdJc2F3NnpH?=
 =?utf-8?B?VjQrZlBiTE1hS0tzM1NSUGFNemd2WTFaaU4raTdHeitmUjRtb0NQT2ZhVDVh?=
 =?utf-8?B?L1Fabmp6dXF0YVIyUm1FRWNzQnZXeHVUbzZoYXZtdzBadU1oNEdWb09kSE5J?=
 =?utf-8?B?RGVKYzZuYjliZEFNdjdZUFRHczNxc2JkRUF6V0RhS09KK1dBelduaXU4U0lF?=
 =?utf-8?B?MWRCZ1NyNE1ZUTN3U2FDUmkvMEZsR2FHU0lTakNtRWpEL3JYd21URy9yUERa?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63d5f3e-eea8-4f48-38a4-08dc20c4eecf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:22:17.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFV66N4OQTi2YLJptfmGd2qrpC9V3JCze1ZWFB0Ma68dWxwzirBar7OrRzWkanm2DC9/g4JiPvz6iamoPxFmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 12:22:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14477

On 23.01.24 22:12, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This is the official tag version from debian which removes the
> native flag from the python3-shtab dependency.
> 
> Also remove the patch debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...16-1+cip.bb => efibootguard_0.16-2+cip.bb} |  2 +-
>  ...rol-remove-native-from-python3-shtab.patch | 28 -------------------
>  2 files changed, 1 insertion(+), 29 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb => efibootguard_0.16-2+cip.bb} (96%)
>  delete mode 100644 recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
> similarity index 96%
> rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
> index 93114c3..b6bb2bd 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-2+cip.bb
> @@ -24,7 +24,7 @@ SRC_URI = " \
>      file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>      "
>  SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
> -SRCREV_debian = "eacf94e767136a0257850ea0c888d234cb8cace4"
> +SRCREV_debian = "74b34b5a3bbdedb628bd75422d6a8bfef70ab58a"
>  
>  PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>  
> diff --git a/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch b/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> deleted file mode 100644
> index 42204a5..0000000
> --- a/recipes-bsp/efibootguard/files/debian-patches/0002-d-control-remove-native-from-python3-shtab.patch
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -From c599480bdec0ed57922d100dceb5c94d04755694 Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Wed, 15 Feb 2023 10:47:38 +0100
> -Subject: [PATCH 2/2] d/control: remove :native from python3-shtab
> -
> -This fixes the cross build for qemu-arm and qemu-arm64.
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - debian/control | 2 +-
> - 1 file changed, 1 insertion(+), 1 deletion(-)
> -
> -diff --git a/debian/control b/debian/control
> -index 8b92019..53e2b66 100644
> ---- a/debian/control
> -+++ b/debian/control
> -@@ -9,7 +9,7 @@ Build-Depends: debhelper,
> -  help2man,
> -  libpci-dev,
> -  pkg-config,
> -- python3-shtab:native,
> -+ python3-shtab,
> -  zlib1g-dev
> - Standards-Version: 4.6.1
> - Homepage: https://github.com/siemens/efibootguard
> --- 
> -2.39.2
> -

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


