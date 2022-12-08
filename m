Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE33C3A5A7
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 09:30:24 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.50])
 by mx.groups.io with SMTP id smtpd.web11.9404.1670491822241632265
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Dec 2022 01:30:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VIh90FTl;
 spf=pass (domain: siemens.com, ip: 40.107.104.50, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvRAKA/bAv9X67mfeapE0kR+RX+MaUHb4/CDIwbmLvOHTjd6ahx3jzMeD+w+YLe8iY9NAjKUUVap/YDnNcfa8FDl+xGOhrEsVKONZFPNPsEjHLbAEDA8K6emM1GD5bTVjv0nDXbNPGywfljzKlbDB3SconybnOA6fKQmFwqXWguGsCjM63k8fhMuVtS+oJ1DN9V9KWVODmW/3l4d4xIClx02LhHHw8TYIkByc5pMkdbtzZHCsg+9mm/cMAqXmcqpYme3tiNKqT1wWAucEXnxi7hPDergzw3v8zPqNpNXiKyCtf4qFGphBIDOjVYG6C2KgvK4lGYdtHND/p32R2iwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISyVbriiOOfhrqphmIvmGrTRfsjIrKvfRLs6lkQsziY=;
 b=l9oyHoZI5y27gZ5rF7CGwBwr4mepwmTDTjRcGB916ey6mzgfwbGnOYBfI6vV+PMGsU8CneyZCY2nL3sd13VayBvQ3zIGNB9W809HJ5LNgeMUC3EcAfLzAE+kNSEIOvK7kGQrPYeS2lPmUQQ6kdv8g1fj+vjLayg3uZDGEUFEwVAqX2ztCksXvyADxKeE7slZTslJ6yJwCM8oEikoNb1VMoWwOW80jjCgFqnDnN2iUl9FhUVg1QklbXi/X6zoOPi5jJC1tCLY0I8vXAOF+sYT0jPHnFDaQoVr1UB+jWf6CrDmGr7EKSOIoC8Rl6gZF9jNLAR5GSz+XnPV1tROUdH9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISyVbriiOOfhrqphmIvmGrTRfsjIrKvfRLs6lkQsziY=;
 b=VIh90FTlfbvjITQNwJXVhvpwIMcDi2mQoGtp04M3mWCXHEpM25SbMZ1jEDwDbvHP8m+Gqw/XNPGkz75QQUQgYJ9LfleGfI9ta0jBdMTqYRLUm/MwYNw/yay5yuplMVODIsNrMKqOVS71fZKpvXIluYhf5SQYPphI96dScwcKwvc/wiUYw2WL4VTtwfMA/qUyozm5mKnR8k8ur3GORN9uMnJYnD0EI5At9whS5EBvqqIIqWgghcPYXrvwNHgcB+fvvZoSukNBmVt+23ECljjFRqP8Bn+EHzFn0Znx38UJWP3Z3cQYGHFpCMU/UORaz4xV+f9hAsCKQTlTvFBWZlfykg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7739.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:647::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 09:30:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 09:30:19 +0000
Message-ID: <cfc8b418-0f95-a21a-0aaa-8c7d2a9da37a@siemens.com>
Date: Thu, 8 Dec 2022 10:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-abrootfs: check if
 /etc/os-release exists
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20221130111827.43184-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221130111827.43184-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: a99f0eb0-e0b6-4274-f79b-08dad8fed290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BYSkcd7PEpYpX8BnIpf2hirbreoKUORwepsTG5TJhdCxDa48AGhdkKWMSxPz5DZAUs8fYWk8O5ZrK68ecl+QC4fZT9NeMml8Oid+zrR/pYmGH6B0JvFr4WlQguxTWJUq4BVGgac70kiLgXyva8vbMxSoNEtYKSrMy3I0+n3aJwOUs7gpDJ8eEk+qcdTnDDAqR9LgbkSo7KzqsyupVr7cSCSv4YKnqcteLirJNvNzP70PtWYpTVvicjuuwoUVyttsiieW5bguQ1f0EPJIiltXsJMUkno48JLPpXSw5wr1XYeMUTHJGsrVcXkBkGZNGWbEHJEGUXWfV+pt4Mz/Wb17DAHjVwUUdo5EednMnYo8yTPc7OmK2USm6KSykCxfd5rez3nCfH5/SqPCsh6ekvJ1So90xf9hEPlojKErNU97iMFz4KUNTW2dAJsj4dmQ+qg73fi07CiIh6mslzMa6unZHrgFdT7BuYvEL+o/oCaZ46HCa2P+O+w2s+fXOXk/pP/5MbQN83AqCkJrFcUQMq4wkygF4wha+2UgDkGXL8aZUyCPFrQQri6hy4ns4qKCsTNnGVGQrE9NQb5AHxxoidDHjeRScuu08FWolnGl9Rg/q/5jqOXkaQ2fRsmCv/ExUl2x2GCsw11fDuVkFCBvV03pT3GwVJci6keRo9Zurg21qd31RLEJSeMQucz6DRSufTOBWX19IyQd5OuPtRQmvmPDN4am7CtmUWrirYlG+izoufA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(83380400001)(31696002)(8676002)(5660300002)(41300700001)(82960400001)(2906002)(86362001)(8936002)(44832011)(6506007)(53546011)(26005)(6512007)(6486002)(6666004)(186003)(2616005)(66556008)(316002)(66946007)(31686004)(66476007)(478600001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODlWRWx2b0lBT0ZQQmlSWUt1OENya1hoaW10U05XVGxzQlM5N21Kdk1VOXlY?=
 =?utf-8?B?OFhKRy92OFRpR01IaFI2YWZLL3FkL2NCaHcyWElraHhUN1hneU5DTFY1aGly?=
 =?utf-8?B?ZVkxY2pJRzltMDBEQjdwK0NjbDl3enlmRFdibVgxT1NuSit5M0Q2V0RLTTN1?=
 =?utf-8?B?amU2a0J1KzdieGNnWlN6MC9CRlQrNjFwVWo2d2diWk91R3hURzAzQkYySGZR?=
 =?utf-8?B?M0QxV3gwM2NCUElKN1NidjlyeWl1dXFpZ1lPL290VlJjdUJyTDZnOE03L2ls?=
 =?utf-8?B?c1JneUNHd1JJaTRxOGNkbFZhcDJ3ZGphUTZQZUxRK0dpV0c4SyttdUNzMlMv?=
 =?utf-8?B?THFJUkNpSm9VT0JJbXNNeFRadFhwZkFkSXRURkhUaEgxVlRhTXVqRGJYcjNX?=
 =?utf-8?B?Yk5UdFdod1owWnpwUVNuRHRZN2FLUlRMenE4TlA2Vngya0lIaTl5K1libjR3?=
 =?utf-8?B?MC96SCsrUmdHdGd0K3ZKQURzZlk0SXRxVktNUU8rL1RzaFJpUERDVWVTOFF1?=
 =?utf-8?B?ZjBZcmdrQ3NxekJDWWplSENubmxPNHZZWnU4WUxLaGk2VXo3VjZDUWF1L2U4?=
 =?utf-8?B?SnJaTHM4N0RiWk94MXZLdzNFQlEvdDRKMDNWZ3FZTnZrREkvQlpMbkxjNjV6?=
 =?utf-8?B?RFFveW1NZjh5MHJ2VklvSFpOYlRLSHVsMWgrT1VLdHFZSFF2NWpiUEplVlZL?=
 =?utf-8?B?aXEyU3lNT2V4U0x1cUtlT3gxbmJtWFF4dnFmeDdMV2dIc29ObUc0cEpLVzA4?=
 =?utf-8?B?R3pMVFdydWdiNUpvcTM1bm5sZW9XbFppcndLN0JndGVDTkxMd1JCMkNuSFZ3?=
 =?utf-8?B?dXk3WUc4UlBBVkZsY2ZBZjk5SGdwNmtjaFVRZ1JWRDZuMUxyc1NxVUR4OUtP?=
 =?utf-8?B?cTd0bzJGeUQ5QjgzSnZkVU4weEpON0t3R1JIWHRqU01rWWxjbUNhZzZFQWEw?=
 =?utf-8?B?TXFjR0hHUWdrVWlGZ2ljSk16WGZodWhHMXNYUmFabE04ZlRwNDZYMXlHMmNT?=
 =?utf-8?B?M1Y4Mnl2bFhRMXlQRWtUandyK1VST003SjRyOG1GL0RwUDZDcm1DV0Q0Q0Nv?=
 =?utf-8?B?ajlpVVVrV29uWUZnTG93N2ducHhwK25ZVndsVFgvbFlRT0tMdGpTZEduVTBl?=
 =?utf-8?B?QituL09IeDh2dmlVWkY2cnREaHdsdHJIRllVYnc1MUZDMG83aUU4cUxsd3NQ?=
 =?utf-8?B?K3ZjTVB0Nk91MHFMM2FQSi9ybG55QzZZa1Nlem93eEZMMjFCS1pFaEpSRjNv?=
 =?utf-8?B?bVFYaGlyN3RsZG9UVkE3NE44RlRaMytSVExTMUthVVFXWVdmTm5GTVpxTUlO?=
 =?utf-8?B?RURGMXg4elFpZXZZeG93UGhEVE5xbGZYcDUzNXBSZE8rL09sSkJBVlYwSDVm?=
 =?utf-8?B?YlZpS0s4S0NvZ2ZZdzlUV1pqQS8xVFBDTkpWMThRcFltS0JsUFU1ZUs1WGxF?=
 =?utf-8?B?QUxvRVVIT0phdTd2WG05ZUMvdTBMamdzWklwRXQyRzBFbUJPOVRqR0ttY0V6?=
 =?utf-8?B?RTR3aEljR0cvQVc2RDVzc3Z6SURsMFN1L2JBYUxyWGlZdVhwWXlVdVZLNkIx?=
 =?utf-8?B?SVEvNk9jRWNXVFp6SUxNYk16WHRHQkQzL2Z6MDZqOHdNUjVQLzJKam5yL0w0?=
 =?utf-8?B?bU1EQldqTnVkZmY1UGNzZjB0ZHNHQ20xTU1ieUJpOFRzTEJLd1h6TGc1VXBU?=
 =?utf-8?B?M1A3VVlyV2JRZlgvOXVqS1VwV0hJMW05b3E1cHN2cHEraWFQSC9vVEdVV2E1?=
 =?utf-8?B?SDRSc1FzSmduS0x0OXNZa3ZnaEcyaHp4VitTSkhGSXRrd1MyOEFIbkFXNnNR?=
 =?utf-8?B?bXdVNDFTUWFQRUdsYnRZWXdNeEZHamlqWWhjYmxmL0dIVTBPY0lHbTRkZ3h4?=
 =?utf-8?B?SnhoTWh5S2dkSUNpbXB5aEFiNFQ2ZWtOdDQ4c3J1N3VSVWErUzlxeUxodDBy?=
 =?utf-8?B?MHk0RTFCRndRZW16Nm1Pa205RGt4UHVjV1ViZWlDcG0wWGdiNEYxT3Rmd01K?=
 =?utf-8?B?V0xLZWNLVnF4L0YvZ3A1V1Zyb3pGYjJVSzdRdXk5SmtlVjdGRGZSZ1ptV1Bk?=
 =?utf-8?B?SU14aFhVbVREREhrR0doaGtwcWhnV2NiTXIxVW1HODZrQ0VNM1JYSWd1SmJs?=
 =?utf-8?B?WFAxcStJT1RTNnVYaXkzZDBhZXYrcXNqYzJlb1lMVkIrbFM0Y3dJV1hCMysv?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99f0eb0-e0b6-4274-f79b-08dad8fed290
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 09:30:19.3761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4YQ+wLsoQpk2tf6p7AsRRiIbSJE7o0oy6KyrjYqs7ZTHF1naBA/AhGllyTf90pkm8hJJhaXQtk5pIerMMyhxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7739
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Dec 2022 09:30:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10164

On 30.11.22 12:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If a valid root file system does not contain /etc/os-release the
> script aborts before checking other root file systems. This occurs
> for example if the boot occurs from a USB stick and a ext4 root
> file system exists on internal memory.
> 
> Also ensure that IMAGE_UUID and TARGET_IMAGE_UUID are not empty
> before comparing to each other.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-abrootfs-hook/files/abrootfs.script          | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
> index 23bbfe7..848e829 100644
> --- a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
> +++ b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
> @@ -35,9 +35,12 @@ find_root_via_image_uuid()
>      for part in $partitions; do
>          if [ "$(blkid -p "${part}" --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
>              mount -o ro -t "$(get_fstype "${part}")" "${part}" "${rootmnt}"
> -            . "${rootmnt}/etc/os-release"
> +            if [ -e "${rootmnt}/etc/os-release" ]; then
> +                . "${rootmnt}/etc/os-release"
> +            fi
>              umount "${rootmnt}"
> -            if [ "${IMAGE_UUID}" = "${TARGET_IMAGE_UUID}" ]; then
> +            if [ -n "${IMAGE_UUID}" ] && [ -n "${TARGET_IMAGE_UUID}" ] &&
> +                   [ "${IMAGE_UUID}" = "${TARGET_IMAGE_UUID}" ]; then
>                  found_root="${part}"
>                  break
>              fi

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


