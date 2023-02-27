Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3797BC64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 07:25:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.43])
 by mx.groups.io with SMTP id smtpd.web10.85060.1677482702023130180
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Feb 2023 23:25:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Hycp7e3J;
 spf=pass (domain: siemens.com, ip: 40.107.22.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhKl7zU2frF5ZQonKDvkG1wC+t70ewV4vMFkXktUOYsHoC+6yQj4ZIbgJaMmPKZv9OeRXIhxISfi90lOu7SGRj1VehDFcr4bMEm1OZQ70dOZh+msxBCz3iDB4v4SA6YRE+BDCcyeNExW5Xf5mAnX7fi3eNg7VPN7hV+Lid3eRaM5BKK8iSQ7Ic3McG52TJ9WyImh+m1Dc6ILY76WATXoGX596y0EqciGaRMoppFEq5ON1jehUKiYZyU/RXaOGua3mvD3wUNZ38AMHwXnIddcoMAoxsebF6NJcaZIubsvA5ul1r8zwndm4db19DZIrITKkH8o/aB/ExAGA5GQJ2bkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50qig7NontMJFSRk6mv4I6f9013T8uUDRctwa6tPG5k=;
 b=KjUbu8YLFr6fVRsN+hEWPqAQU+Cq0y4ZOpULa4Xb2A5hQtWZPUYwXtEk8lDorgRBDQIwUl3249RVliLmYwqlikMnfqs1i6kYCp27s8/kRmu+M8TVAPKDbB+GLSrCv4DyE2sfO5pEwemj8iaJrt43pD6Oup4DQJvO4gE5PD6ShjEEygQb5IGsdMi3Vqs3TT/k97a3U6tjat1WEINJEzoopAMrlJIILi5IMkBd+haS685iNQFMEjhYAJ+jpm+G297cR8ekiUQT5PWrdpalGCCThlTaXKdIGBHIBx/68hqbnOG8yEImHvrRCiMoPxfZt+BhNJ3MxzlmihnPhqvxnYzoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50qig7NontMJFSRk6mv4I6f9013T8uUDRctwa6tPG5k=;
 b=Hycp7e3JaJOrXmZldn3GmbtCGXwdH0KbF1rGI7ycjszSjsI3UhCVt9n3FJjlrZ1mYXwhx7k/Mz+KYyXRjophLwEiFNj0gjPRSNKVO69gmZAIJfJ5BLrAT9YHJ+9ZTE+IcosI1tFLlhYhgfKhwL61Z6wLDQI0f5NjmtxluGxRC7UUCYpL5XtnnEWZ3bf/mo1ycIRdbPvgBZWbRRURMVAhfqb/bzemhIiRXrJ8P7dV4ayIhK0SyQykRNO3O/KxLrOn0d5poLxFF9JE1ovaa1J5QKvhqq32o3kGNm12/H4WElWT44ju4dPcMp7ieFRBm6MysqYOMoaHeq9/Grv5IjW0TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB7964.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:272::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 07:24:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:24:58 +0000
Message-ID: <9b718775-9909-4adf-cfc4-cc3acc63b427@siemens.com>
Date: Mon, 27 Feb 2023 08:24:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 6/8] overlay: add prerequisite
 'encrypt_partition'
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
 <20230224162832.327030-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230224162832.327030-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a98aaec-fc78-4ede-8d1e-08db1893bb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	And57QeiQrpWMbc9guxpcb5I5XAo4Gvp9B7jbahmkH3i5GHZ/3fWSQry5DLoshDvtIEJNS6b+1ax1oZYRJq70ZpdrfL+fe/rToGRoiS7dCPMlQOknletgmm3jxukXt02kHzNHa3s3BsshxVda3MM2r3GdhIbbjGdTv1kTLe17PhlT6WCDK2zhNNlI8fqrErB2SLZgnCYTiBKJw96xc6J4dB2hh0O0zG4ZkqqeujQScyoMdaGlVXHfVA5YBcMYvT4byV5G8rjfi4cvFhsPHKd74kEvql/f+sZ4V6C+eyLn5cnb2L9KCehYcNrWV2hAYo3uatJaY1eLk5aEyqIVZEX3Qr4Tlj+NK5kW0jOG5D32xpQCn2H4wnP3Adfs4OaSHt6BVX1KkEemROo2WDtei/JsiZfdE0CNAwJt3yDhiGpimfa3b7spMezb8qnZ5UtN6fHySF/BJUmHSInTA71aL7rBaQ47Mvy3utj9HEH2Wqf5ni7Tuc/Jyl1lEcnUhF7EOav+YBNV0ScCTLbP3HfFFSPPBhG+c/X0lMPmpGBHN26mDz42eMQ6qXZ8sFAYjOgqoxVTBuXf9lvrLtWoED7ebI82yxsSsYq6ZmKXE2CRn9xMWNOMNns01fvanX15+tFf9v7OxKDDl0qM3Q07vPKl6hgPqPAmaO3/CzH+8X9bBqSIGkC0RQPeKz/+eshRa/HlJU+9MeE40kFcYWr/e7KOLrESB4Wf6uWJYeVS1eRC9YNkB8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199018)(316002)(82960400001)(2906002)(31686004)(31696002)(36756003)(44832011)(5660300002)(8936002)(86362001)(53546011)(6512007)(6506007)(66946007)(186003)(26005)(66476007)(6636002)(66556008)(38100700002)(8676002)(41300700001)(2616005)(83380400001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDZzZ01RZzVTdlJDcU5KQWZBdUdQUi9GUERSVldGd3NpOVpHeFFjQnZFNldF?=
 =?utf-8?B?ZnhqN08zNlI0ZUpRQVRTMExXa0N3dERydGxKMjR4dDJ2MjNqZVBuNElGZk1P?=
 =?utf-8?B?Z3hWenN2RmVPTjZtbjhRS3JmVUwxWXViNFQ4ZjUrNG1neFFCYmZxVlJsbk1L?=
 =?utf-8?B?UjRZaUJEL2lLSEdCVXFoanVHM3BFNFZ4QTZyU0E4ZUY2QVNWMG40SWdTbkJ2?=
 =?utf-8?B?bXBEc3R1anoxaXd0UithRXdZYjE0d2MzaytDVnFvZnA1WTQ5TVVjRzNCUVFq?=
 =?utf-8?B?MWJ3NG1vY2ROUG45a29aWURlcDUvWS81ZVhOZjRpZ0lDWDNycFIxQ25aRENG?=
 =?utf-8?B?V3pEek8reVZiRXlUMld2bk84Q3NzVytqdkxzYStIWExJcVNFQzBLeWRIWWZ3?=
 =?utf-8?B?Y1NQaVRPT095dDM2QUowaEo4bGlTTGdYb1IwZXhoVmRnbm41V291cHQ5Y3JL?=
 =?utf-8?B?L1JMc2QzYjRNOFZ3Nnk3Uzlpc0pSWjJ1MnBWVnl4SzFrb3BqNFJtNnpORm5G?=
 =?utf-8?B?NlVUV1YvWFlxWnVYUjNNYnA4d2tYSXI4dXUvOEhaRUtjdCtVZ09WRUxRcGtW?=
 =?utf-8?B?eXY2eWVUTjQzV0pUYnVwb2RVU2RQaU1MNDlSbUxNMU5VN1U3MjgyY3ZrVVFK?=
 =?utf-8?B?Mi9SK1VBL0thdHhNLys2TnB0ajFZa1ZaMG1YK0o5a1NzRGZja0tRNTF2eDcx?=
 =?utf-8?B?UXVOQXJVRDViRE50WUpmaVNjTzlkZy9paFJIa1pLVjVtVWNHSktzQTJLRU1h?=
 =?utf-8?B?Y0xSOThtUU5ESHBKdUhTWk5UcHQzZWZZbi9nUk03eW81bnRydUpDUmVvRVBr?=
 =?utf-8?B?Ylo2N1V1YUVKbkY5Y1QrR0RlN3JpZkFOSkY0ZjNJeXNSOW5lcTB6Tk12N2NJ?=
 =?utf-8?B?YlZ1cHBCTFEyaWFnamJMdTJPbjA5MVpqbnR0ME9QNzRvei9LUUFoSnJrYXVZ?=
 =?utf-8?B?TUFMMU5KTlJyMlJ4bVJobDBBUk1LL242L1hoaTFXREhlODBUZFdZb2ZEWi95?=
 =?utf-8?B?aHp2dkVySVQ3MlpUV1V4OTlKT0hMMDBKakxtVVgyR29mc3JwV3NrYjhPdkY0?=
 =?utf-8?B?WWRQcVA4UDEranR0K0Y0aWFSNXRPTTBQcHN5dWM1ZUxuVkNxQXdkRm5JcS8x?=
 =?utf-8?B?TkFFMzhCVkhHRFFyZmh3NWxqSk9GMHBiNDJIYkJMTnFobmhEaW5LejFKUG56?=
 =?utf-8?B?M3hGUkRrWmdNUVpQWUs4VkdYRU5UVm0xc0RiT0Z1Vk91ajBnRmVQWFN0OHBN?=
 =?utf-8?B?QU9Hcmh2ektSaWQ1TVVITlU3cVVGMWJkTTFBZGFhbmJ4Q0g0bmF5NGJQVDg3?=
 =?utf-8?B?RDFMcTBaenJIeXhNalNEemNxaFVjL1FKeEtHVDc4T0JycGVKMlBoRWpCM00w?=
 =?utf-8?B?YW9hZjN0Wms2cTlybFlHMkFWckpwWVl5VTRrZHp4d2NzcnZLaUtEK2Fla21k?=
 =?utf-8?B?K3NhWDFiK1VCaE9xVVMrLytxbmhOcEYvNHNPR1dwQWYvQ3g3SkRndVdRRTFV?=
 =?utf-8?B?QUp2SllEQ1p6Q1F1ckxhWFFsMENDZ0pCVHBYVkxtaW9uK3VWTzRlcU41d0p6?=
 =?utf-8?B?aElFVEZKL1RMOXhIbjRSUFZRVW5mMm1SWkQxNFFXZXp3elRmTVhEVXJMUUxt?=
 =?utf-8?B?UjJZVWFyT0VFSm9yN0VOSnNiQ28ycGpMaWRCanl5VXJJcVlnajhYQUZEWUpl?=
 =?utf-8?B?bXlQaTJrajMvZ2ZhVzJPeHpJU2tIRHVhOTFtZzVRNXVvV1IwWDF4MGdlc2FM?=
 =?utf-8?B?N1pqb1dwYW82NHpxRXAzd2hGRkZWSXJnZXB2YTJ0eFdWdjMvR3NyR3d5cXU2?=
 =?utf-8?B?TU1VWmZMQXhuUkY2bk9Xa3JuQWhqK3YxUDZjSFhuTjE5bXdTcjhiTGx0ams5?=
 =?utf-8?B?VTY1N09CWllKTGIvWVhtQWd0Zy9EdUxsaDVqY2R0cXJFWEwvSFVTeWVPUHNL?=
 =?utf-8?B?K0I0RUJML0p2NElRd3VpaUhrTW5zV044aXBWRnpGYzNFekNhWGIwV21UeEJi?=
 =?utf-8?B?M2FtelJUR3I3S3NxclhqUk1aUStyVVpMblRtb3VIVWFGSCtHQkVEaFVhMDBi?=
 =?utf-8?B?WnZaVTBOYmlRRXEzVzdVL3NDWmFtaUJQZFk3c2gxeWlWNGU0bW40VjVTTUJw?=
 =?utf-8?B?c2tFcjQ3MDE5VVNoVFA5UFQ1emc4RXo3TklwWVRNcFpqWWYwVEdoN1JBODRK?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a98aaec-fc78-4ede-8d1e-08db1893bb75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 07:24:58.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ba7kF2a8CQiHMqrlLnNUlTc/c/f4ob3tD4oXX4FmZSc16vYOaXsdfCa8hnxUxmvHrHw9IclgQOCRi19m84WbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7964
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Feb 2023 07:25:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10861

On 24.02.23 17:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If /var shall be encrypted encrypt_partition needs to be executed
> before the overlay script.
> 
> If the prerequisite is not available the overlay script will be executed.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.hook        |  1 +
>  .../initramfs-overlay-hook/files/overlay.script.tmpl | 12 +++++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 5bec258..bc6a682 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -23,4 +23,5 @@ esac
>  . /usr/share/initramfs-tools/hook-functions
>  
>  manual_add_modules overlay
> +copy_exec /usr/bin/grep
>  copy_exec /usr/bin/awk
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 87ec72f..9739197 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -9,7 +9,7 @@
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>  #
>  
> -PREREQ=""
> +PREREQ="encrypt_partition"
>  
>  prereqs()
>  {
> @@ -33,10 +33,12 @@ ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  
> -if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
> -	   /dev/disk/by-label/${ovl_partition_label} \
> -	   ${rootmnt}/${ovl_partition_label}; then
> -	panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
> +if ! grep -q "${rootmnt}/${ovl_partition_label}" /proc/mounts ; then

Maybe use mountpoint instead? More lightweight than grep.

> +	if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
> +		 /dev/disk/by-label/${ovl_partition_label} \
> +		 ${rootmnt}/${ovl_partition_label}; then
> +		panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
> +	fi
>  fi
>  
>  for ovl_lower_dir in ${ovl_lower_dirs}; do

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


