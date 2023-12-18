Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D444EC35274
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 17:17:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web10.49034.1702919860009553039
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Dec 2023 09:17:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AGGrAXiF;
 spf=pass (domain: siemens.com, ip: 40.107.22.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnpQLyitzlGp1qF9gYfQcLAWNq5CXP2KsKPvDqoiHrWAKckIhyt83/u0i+r5pwzPaPkRP7OHpac9m5zQQv59ZWtt95ruk72sydC3p+DuDslejDVxPwMNSR+YtY4O1JOmhuJoKinRjHpOg5nwQjGX9ccrgBHWCO+ZdJdjBebZ4ZUx8LlQ5KpEf0BzamYKUDLPFkeyZaqohWVu+v1cK1fcxnAeQRR1CwublUKLdCkehyS1WFFCs4ZYeo6+u1MiHOf1FUwiYxUkjsIGasST3JUfrtO4kM8wbrXOL1MFgIe8fQcQPM+6ysWpT45qpY7R/l0Bz5Vn0fgKXCZJRYtwksOh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcJad1xwdvqdaihUSICMrKANGWaOsyUhLaz5iZ8+eDw=;
 b=fjh7y8N+0xA/J50r08URWgQ7ut3L218sPkQfhXDjXmdlbk1vMGLuPDNYjkjESOEM0Hl4tginJpwv89WXKs1EI7NbIgQ+nuvJ8uiikInb8J8G3jDrMGcifcawBkWmNbmiVw2sMJUVD9wqXD/npWDaMEvDS12B/agVaxsuYnuLPvvJ755+zbV8rJuwjjVedS177+kqM7eItGC27R9XiGh2oCJ0EhqnENw8JUnA6+1gB6swYJZdMigzckWYs2W/VWqYJF+un6ustfzzRKsYPzTtmSMiHDNH5rWgckTeDFg8FH9KV7xALb5Se5hiozg6dbSdBKW7tiB9gbuidzcwE5FRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcJad1xwdvqdaihUSICMrKANGWaOsyUhLaz5iZ8+eDw=;
 b=AGGrAXiFYUw+jpXdQF7FgyXrllKHD6IsH/ACg/xE9MT1XOhdOHxB9TDXjMIKbpAqvfoQ3W9Opf2eX7YH8oI/vZwYqM9SaTeltoLS9h8eCyFyW4Vo1Wgysj2bfIdOmXS6ra4fHREfyGh0YTNkxSit5nZmOiwE/CjJ6n1EL7Vz0/MeTGJZ7ihHcxH5ZlNCTRCl9zeiqmXQjaBGYNIQ0qrEubcCHsgG2vmzqeHcksRVYDK3SW0ditb8dHkFrGyJzSWu1E2Eji3aJlT83ABG/Sg0MkkKZ6HqCVxPh1uM0YhExFS30rZvqGuuyKONNPJezV5Cl2gi0VU6dr63z7bVNtIGqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:454::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 17:17:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:17:36 +0000
Message-ID: <731738f1-b1dd-4ecf-b030-91c8b25a4153@siemens.com>
Date: Mon, 18 Dec 2023 18:17:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] initramfs-overlay-hook: Get
 Storage mount point from INITRAMFS_OVERLAY_STORAGE_PATH
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231218142906.1507050-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231218142906.1507050-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5ad561-15b8-402b-75c4-08dbffed3a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2YLw3rexEZjHzGyfmEbTH4blDJXFHOQQr0H9r9QRI2vBKSqFGacieX92pIh/vMb4svy8l39C0r4E02nFvjSs4wNcSfO5pP/124bpR2obah2B6vMX7+R0Wb8fXghxFjyQRgN45K+Skto0U4O5fOdoDzUS3bnfhsYldSoTjpO4zzxv5oXQkWFitBNukdO8c7/QGvwqcuz8b5aFYOtp3fr4t2ibIYSYhafcOu2nPdp1IgNYJBHImT6HUjFgsuAe/QtLf8wlxEwZWxNw92KQrDb/ahVSuJ8Ywb9V8GptJ+Kb1PgqKLMvnXfi5Eun/b92odcWs54XXHX778nh4y7C4BQ0DmNHs6NB0aRMFQSyZaM2A7AuKTBOSDj2k1s4TMTGjRupJbyf2xyOVgGDHBhts4JIHPY+gv8WKmfcf1jcthuPnnakZAGxSOM259Md329hTIGdJMNmH7tvtRCN5g5p2TvBhjESfXCSPINsmsx4jCCLHuODz63KD6G59vuCwkibd1UUtz77HjTORZabnSTd0q0yQC5KVyDATwuv4iW/XhMlI+j+94a/Z2VE7LGI/U/eKW36I7Zw4hpoJxzYB7q7KPkS//NGXauj4weommp1DE+ec7Yx52uiNg0tHD5TUWhsJdrG9ZcNEvrdxjSbGeH9w7DxLQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(2616005)(83380400001)(6486002)(6666004)(478600001)(6512007)(6506007)(53546011)(44832011)(5660300002)(41300700001)(82960400001)(8936002)(8676002)(31696002)(86362001)(36756003)(2906002)(38100700002)(31686004)(66556008)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZHJNTksxK3plaGZBeFh2ajFDd3FzY3pWNkRDRDVpRi9zKzh3RVJmNXRmakRZ?=
 =?utf-8?B?UzMyaVZFY0hOaTQwNzJPTDVURTVsNXRWNmJtT1A5Uk54VXhhdExjSFJlS3Rn?=
 =?utf-8?B?bE5FZ2tzNUdsV0U5ajMyZWJVUG1TOSs2cFc5N0xRVDIvTmRTQVZOWm5xWUZl?=
 =?utf-8?B?V09UK2Q1elFpeDBCaVEzN244R3N5YTFlRDdVVjlkWTdBUWxlM0RZUmVtYkhh?=
 =?utf-8?B?aU9lUVQwTkJhZWlaa0JSRjQwbDhOSU12cUwrbGw2M1lMNy82Y25sdFFXSE40?=
 =?utf-8?B?MTdiTmc5cVJVL0JzZkJUNnYvREJpUXR5YUVQUlY1ZkdWVGR4a2kvSkVDdmJG?=
 =?utf-8?B?eWZsRmZXRnBLeVpWMzA5UHpaWWx1ZVo2a0ZXUEVWOWh4K0dmeHlZZno5UHVj?=
 =?utf-8?B?dVBIT2FYbi9iajVnbkR6TEhVaUsxT05Nam45Tm5iUXo4ZG8vK05Jc0VBSVJE?=
 =?utf-8?B?cTdQeGJJa2ZDK1dQR0tsSm0rZXFxOEpuYWNoK3pEdEVzR1A2N0RaMUFsVERj?=
 =?utf-8?B?VkJkL1RvN2IvYUo1Zkt3eGJPNjZ5UzdrdWxBMmo4QmxHWVByL2thK1lyVTNz?=
 =?utf-8?B?bDU3d2Nzb3dSSDh3SGdvS05lamVlKytIWVNVZlJXSWxETUg3Z0paOGx6L2tW?=
 =?utf-8?B?aTNnZEZLVXRKUDBpRytrZG9aRHQrNy9uR1dtMmc0d2t0QmREWmdkL2xnMVNY?=
 =?utf-8?B?UlVtVExhbjVjY09KTDUwOUJEeko4MlpEUWdRdFZiV25xWkZkN0x5RXhlUlA3?=
 =?utf-8?B?NHI2NHN0U1VveFFqa0hMamgyeDNOYlYzcXY5a20wWWtJMGdIRXU2bDczV1Jm?=
 =?utf-8?B?RGY3cWJrbThSSEZQNDgzay9kK2JoazFQU0gxVVNuWHlJa2VqdDBLTHJNYklB?=
 =?utf-8?B?UStyUzN1cjBLKzhQK3Zwam9iNHhxV1RaQm4ycUhYRWFoL2VKeE0weGg1SkpM?=
 =?utf-8?B?ZnMyTVdSSkxFZkFWRmZiNS8wbk1zaDUzSkZuejA2dCt3cG50YndUa1BPWk5Y?=
 =?utf-8?B?amY3UnFWL0x1bWdZQWxObWxDQnRPOWxCcU8rVHlFYVFBZDl1Sm1ETEZnOS95?=
 =?utf-8?B?Yms3enpoU2FMZksrVnNENWxVeVNjOEEzSWJOenF5cXRyK2NZTHphaDFPS2JO?=
 =?utf-8?B?d0FzUWxOQ1RNbzBYdmdXVWJTSnBZTGlEODJVS2cwZlRQMGVrcjV3eUxNWURP?=
 =?utf-8?B?NEwxekcxNzY1aE9MamxOTm1WODVWblBrS3llN3lvSkx6amJGa0t1SFBVMnhu?=
 =?utf-8?B?M05RaVRpdTBIOVpTdU1BSTYxK25wZUt3K1ZiWm5ZN3RIbGwvZU1lN1Vpbm12?=
 =?utf-8?B?VVd4UUZGc3YvcUNqS3RMb01TT3VyODhJQ1ZJUFRENWRTblV5N05JeEwyVHh4?=
 =?utf-8?B?MncrU3RwM0NHMGtnUXQ3THZoVWRpRldWYkNVeUl4Y1BlWHJUNzZ5NndLSjZG?=
 =?utf-8?B?cUZwVmZaVVc0NVBWYk9kckdBOG80dTd2THFWNEIwUFVzQ1FNQnlscno2cDB0?=
 =?utf-8?B?NWd5WWZ2NUs4aVYrZDJ2am81elg3UVF4LzQxRWFMQVBhY1RkVXBUWGF5OUJ0?=
 =?utf-8?B?V3Vzem1SdXRpQjR2aTZ5dWxjZWE5VGd5TkU5Z2tuNmFYcjh1YWhJbDJOMUhS?=
 =?utf-8?B?NXJFcDJYM0piUFFBclU0RjhSWnljUUp1SUpKbGk0bGpPWTRyRFFEOTk5Zmw3?=
 =?utf-8?B?T1RhVHBxRUhoS0RvN1FBYUNkNDByVXhqVXF3Y0FrTVlVbHZ0TldpTjNuZ1lu?=
 =?utf-8?B?dms5eTZpMkZ0YTNTeGZya0UzUk95aVRuYWorb2NuYXFNQ1JlWG9QSUlxbFJX?=
 =?utf-8?B?RzFHckRWTDRrTUpzMXpnbDJVRFpsS2czeXJ3Z3hjNGtNN0phbVZNdklmNThw?=
 =?utf-8?B?ODIyOTBWZEMyWVZvLzJZSm5KVzlQdjY2WWFVdnpwL041V3hCRmV0VEprVEZ0?=
 =?utf-8?B?cDZtbGNXbVVzNjVWU3pjRG9reVNvcUtBaDRIZjNWd1dzbUV3RlRlSzBLemFs?=
 =?utf-8?B?TitocWV1Q3ZsaVNlQUFSNk5HRzZLNitlL1NtTm9teVpLRFR0dUlJdGJRZ1ZW?=
 =?utf-8?B?eHJSZkxCSDZEZHhHTmpvZk4wQXo1VEdKTnVKTnV3WXJEVVhPY01IMTFsaDJt?=
 =?utf-8?B?REl4UmZ6STBaSUsvNnRzRUYwdGNPMnVsSlNmMVhUZFdDZWFFd0NCdkNiQmlo?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5ad561-15b8-402b-75c4-08dbffed3a98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:17:36.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DADutMEuEFMEwx6sAfo1thlj+jf5XtijOlE5ttzUVDq5ukmLN+EkGIfaW4RLNJlH56htnKni4i9lYm8af8Bc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7242
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Dec 2023 17:17:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14133

On 18.12.23 15:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows to set the overlay storage  to another root directory. For example
> to `/overlays` instead of `/var`.
> 
> This restores a similar behaviour as from before:
> 725dbc99cf9c4956fe7eb04d3932423782b7ce57.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - Change wording in commit message
>  - Add comments to the recipe variables
> 
>  .../initramfs-overlay-hook/files/overlay.script.tmpl      | 7 ++++---
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb  | 8 ++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index d7da6fb..a321490 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -32,12 +32,13 @@ ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
> +storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>  
> -if ! mountpoint -q "${rootmnt}/var"; then
> +if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>  	if ! mount -t $(get_fstype ${ovl_partition_device}) \
>  		 ${ovl_partition_device} \
> -		 ${rootmnt}/var; then
> -		panic "Can't mount /var partition - overlay will not work!"
> +		 ${rootmnt}${storage_mount_point}; then
> +		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
>  	fi
>  fi
>  
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 9e78dc8..e8651af 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -17,8 +17,16 @@ SRC_URI += " \
>      file://overlay.script.tmpl \
>      "
>  
> +# The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
> +# overlayed(lower dir).
>  INITRAMFS_OVERLAY_PATHS ??= "/etc"
> +
> +# The variable INITRAMFS_OVERLAY_STORAGE_PATH designates the path were the
> +# changes to the overlayed directory are stored(upper dir).  The initramfs
> +# also mounts the first directory after root to the
> +# INITRAMFS_OVERLAY_STORAGE_DEVICE.
>  INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
> +
>  # override this to switch to UUID or PARTUUID based mounts
>  INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


