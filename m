Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B6C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 09:37:53 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.58])
 by mx.groups.io with SMTP id smtpd.web11.15853.1678700267855719930
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 02:37:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ALIc5OYv;
 spf=pass (domain: siemens.com, ip: 40.107.7.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOI31+yGVeOu1+YHzyQ+2AObVj2+eU44LMcH443l+aBX5pohp3uknFV4mpo7+STiNjUl8nQbYJVFZBhWk+4ut5a+U6zGvdCDJa+ofZgZFXFSgB3eTBDTiYqMcUm6X4RvxqXw9M3D+H78LJlqv2XIDBU4gBVpGNp+c8Hk+ic7/BqUtz8aZznZsh298Pq55z9DdVf9y7SG6bFNT7UcqmsdJ3OvBskf3+h6rbYLm7u4nhK1SlkLbYDERQQB1SfgJ9Y1WOmLja6m/Qq2/eLRUhEPLW/25EMknyUD138ikStI9lZgPf6R2nmrkehv5A6hKiJasY8B2fh0MB/SfQGtlWnZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp/tmI7lPLZq6uc8a803gCluw7ZgBp9gjblh6Usrd+E=;
 b=NQfyQqfGpkMSnBEY9OFPr0XvcDZjSp3L6bsJ16WUkujrAVNlEx85ZdP1H8FlCJMJ771K5UZ2vsgnK2m8lLyjPlOvZl8ADQ0qrpzr1QqXo3S7byQko9EpMGbCYbW45M81B3VpikJRZIotrUa7bLQjLIvXvEen+r/hIufYIvk8Vr6pzm3qIb8B6NwkaOMsM9SdCHG/1orT584b1ndpR0q3u+68skEHeWo5YaAQ7BbhDpRHSH1f0IebJZtQ1QcuaMsqDdjHXwbQAqI5qbtlUAStMsiQrW1rRqowMKsN5EdCGWzekET5UUx4N08dQHSAGbRlMQvi9pvf15QuL/RdheU3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp/tmI7lPLZq6uc8a803gCluw7ZgBp9gjblh6Usrd+E=;
 b=ALIc5OYv9A27aNCuLAoz1E/fvSvLxbZaEGqtpJ6wCl4CuutFrBnZFiQIDdb3InkrJdP2MBOY/2HludelpUsS942GTcShf0lE1NAunw+L+t+BSMlUJj5RntfGxvn0FqeduWxAVrwMWR9YzcysnG5GmK0VGdKSiO8NP1jHIfy53+o7rIb5z09foQsXQVWgUbnnP79upA9f0cTRz+DtMTHSJtHesfrPdP8cenqIhkoquK0jD3TTNTOklppg26S8bUjBC8b/YIhiOPC+8R6UEcUkhSHRzjbM3syjxDTqugKC6PsuurVk6mW5KxonZOHkzYkPhmrr9wNlm8eNgVXAFMat7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:37:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:37:44 +0000
Message-ID: <53cf12a2-1211-ae03-5ddb-d54f0d19e972@siemens.com>
Date: Mon, 13 Mar 2023 10:37:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 0/6] Encrypt Partition in
 initramfs
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230309085321.17167-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b1c7cb-50b9-46dc-c290-08db23a698f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lgbSJpOW6QTdVo+a88aECnZP5QsdiqT1vH7NaSv0aKImW6Lj8Pmg1BTvzudOVsoSCzsztwK6Ysv8n6BAKolbexNiTfNi4EofN0amVgwb3FeissC4+DJZUEp4sOkFpkwfx/xoyAq4fN62Qzdwh0sS3FhPEU11shvktE7+LcjIAjVjN/c28bvlWQ5kUUPHLxNdB8jrDvYhs9fu36Vcx4xYAIUtN68OfHCQgTJgTxl3K5GNsVE/varVExa06v79FwFko86G26pycHGA+LuPVpSjQg0v5W9tUxvEpQh67FBzwy44+eW9l2CMYyA5c5N5fvOBpgmurWmB/mgPapCdS8j6TxoO624hTejf/R8v+xsGrFBwT1W8h8ZubMdUh5MSjLmDyE3B+TtTxcUTvBd9QVRvHKbzow4l1d3YdW6WSuhg3ljEEmiL1iVQ1ehD94veq2Re+kycrIK4YAxbJNlcs6E2swfJK/TeF+tgCCG85/NP3maOlZc6ORN9MT6KKN6X3NkstmYtVt5XVRzghQU5VMvbJSyWdNtT0tmY/U50IM5jPaeNogDELPoVeirxGxD0i40n9GTn+oqRoInQv17JcTggK+gsmBtnGy+hEo/5w0tKenn3zb3cT2MB4O59rHHGZk2gL6vRHzpHcmUD55hCgAyXJIGA9kMQrsA0IdAB/5mLhI4wQgPk+KqRA7AkmJ2y1eV8UsE+Cfix3YaHLGcpfP8ovnNRYQu7pIX4kixMGn9AMW4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(31696002)(86362001)(36756003)(82960400001)(38100700002)(8676002)(66946007)(66556008)(66476007)(8936002)(6636002)(478600001)(41300700001)(316002)(6512007)(44832011)(5660300002)(2906002)(2616005)(83380400001)(6486002)(186003)(6666004)(53546011)(6506007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGtnM01PeG9Nc1E0YlpBend2THpsVTVoVy9FRlA0dVB4am9nMFFRSnJtZ3g4?=
 =?utf-8?B?OTBScTFvZkZYK20xalhnV2cyZVJ4OHlZdDlPK2owaitRbVZseXAxakcvUmVH?=
 =?utf-8?B?RGpkOWRSZHNLdTNaSlM2VURnMDAwVk5QMUlxYVhRRnhsUytoU0M4bGxIdG5K?=
 =?utf-8?B?VFc0MGpieVMrd25hVE5VVjhWSHB1RzF5ZklJRmRMRTREVlhibWNXNmVaMWxY?=
 =?utf-8?B?MVNzR3BaeTVCeS9hTnVhT3I1dW8vQnFFa01YSzRVUG1hUUFvSU11NUNHL1hS?=
 =?utf-8?B?UFJOMWVWZ1Y0T0VEMjBxS1dpYmVtNStXc1QyV0luNEhpS2ducG9yeFJwc1I5?=
 =?utf-8?B?MXc2ek9tNXh0RlJWWlltTWpRZ0xSOEVOaCtSeW5LOEpqWHRScHh1V0dlajRj?=
 =?utf-8?B?KzB3N1J3bHVBVjJBdmh2MXAxOEtNN01XNnNXcUNPcmR6ZlAyR2JaMTIxcUN4?=
 =?utf-8?B?SzhVczdJLzViTFJDajZJeWJhYW1Vc0w1di9mZjFzajlYbkZCUXFzQWQ1K1FI?=
 =?utf-8?B?Qklwb2dBTkVSOHFuNS9yeW9iMy9jblRwNEhOUTlyd3pjNldPTzJNMCtod0NH?=
 =?utf-8?B?Qlp2VzlqaHBvVVN1NU11bWM2T0txRDNzdXQ2VS94Ti9xVHRaeGJJbzFKdmgy?=
 =?utf-8?B?Q0FtSXNaUzVodVVEU1NneUxIbnBxVVltdFVvYjJuRzR3U045SnY4SU1rZ1dH?=
 =?utf-8?B?eGpIUXhJN1FWUXpKRjE3eG9ZU0h5UGZHYW56TTNKSE93d21xcURLQmJ5cGRS?=
 =?utf-8?B?T3hLNnphclZzTFlvWmpqWmlBdVFBVGtNZ1FXakdHdFNlbHVod1lZZjBYdXNh?=
 =?utf-8?B?bmdjRUU4YnI3enBrRk1OVFlaTnU0ZC95ZHUxZ1g5bkZZVEJXd25QNHJkTEMv?=
 =?utf-8?B?cHI2cmNCZW1hNXI4ajRXeWVOSDF6UWJpc0Y1UEptY29aZ1NNUDJ3V0d5ak8x?=
 =?utf-8?B?TEZxNkF4N2N4S2hRYm5ZdDVFVy9JZDZDWVQxUkVtYlNwMEZ2SmNZengxMDMx?=
 =?utf-8?B?ZDBYaUk1cXpHNFlzZHNvaHRQWGRxNFoweElVNGx0b0JYbGFHUVlZQzNHM2dS?=
 =?utf-8?B?eTdXRnQvQzJsRFlTN3dxbVFYa2ZnbXNYd2srbWMwbitvYVlZb3RrUzJPN2xm?=
 =?utf-8?B?UldFZFZPRWhjRE1OOHMvRWZwakFtaTVPQ2Z2K0ozL1VsdEZINGd6WUZpOUhV?=
 =?utf-8?B?RDBJNWwvQ1Faa1paZU9McDJLbEU1ZnMvdlk0cWFjZzFodGJtMHhFQ25DVE9m?=
 =?utf-8?B?QnY1enB6TWlRTnBHeHNMUHlqY3EyRXJtUDVOSTltVW83SnNqSVp6aXZyUnpT?=
 =?utf-8?B?VisybGN2cFp1eXVPRDMvN1FTcjZvcnZqV0NLSm1qaVJ2WURCaVI3VitBaGNq?=
 =?utf-8?B?Q3E1Z0Jtb2RiTEhsbHIxUnB5L1ZMMGJ2dGZ2YUNROUowTk11RTZRelFTK0FO?=
 =?utf-8?B?TzVvV2Vwc29GYzdUQnNvSFpBcEVNbnpiY3dqdlYyc0ZxdTZWZlF4OWZNODho?=
 =?utf-8?B?KzY4RGc5WVhOaWp1eURyQ3JnTEtucFFSbE1kNkV5ZGVNd0NmQmY4S05EVVUr?=
 =?utf-8?B?cjR0Q0NmenNkNG02UGx3a3I5VVFaelhaNWY4SUY1S0pVS2I1UEUrVytmYzJE?=
 =?utf-8?B?Tk4yeUpVTTBnNVpnWjk2T1Q2VlZLdWd2Yy9KUjdQN2VBSGJ6SmxKSmZmSjAr?=
 =?utf-8?B?NnBMbUx5V2RFQklua29iUmJyWm5ycGdQWHdZcHFOWkJBM05WTzF5R1ltZW9y?=
 =?utf-8?B?a0lMYmdlVXYrRFpOV3N5MWsreGpMK0RBcy9yOTUxUUFxUHZ5ayt2MExDUkN1?=
 =?utf-8?B?MFhFNlE3Z25tRisrKzl6d1dhYk5wY0V4a0VLQnZDOXZjK2R3NmZWR3dweXEr?=
 =?utf-8?B?dmlFT3VwT3Q3MFROQ0pGMGs2OFE4R3ZOelNuVnRGbEZSZXdaeXd0cXFxdGpz?=
 =?utf-8?B?NTFyNlc0cUhLVDdLdm92VWFRRjRkQTNUWTUwYWZnNGdQNjI4ZnZpdlhvdkNW?=
 =?utf-8?B?VjIvQkpTRlFQdkNlMmV2c0FCSTVZMElkMkhGRFN1TXM4Q0RVMC95ZS91Y3dx?=
 =?utf-8?B?QlN6cEcvcXJDd3dWSUg3S09nVlhYb2ZJZWRrSGRidjlrbG9qOEticEJjemhp?=
 =?utf-8?B?Tm8vdW1OWDJsbU55MUZCZ0xIUHphOGI4WlpMY2pqRTB2dllUQ25OY1M1cXJx?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b1c7cb-50b9-46dc-c290-08db23a698f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:37:44.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/T4bz/ou8R1kj+Bh+icRgG6uOeucyyQklSKfbsrevycMVxMnAMDrLncnUyrPe/ApE+e2lVSM+WayRd0QPWQqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5682
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 09:37:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10999

On 09.03.23 09:53, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This encrypts a partition with LUKS and uses the TPM2 to unlock the partition during
> boot. 
> 
> Adapt start-qemu to support tpm2.
> 
> The implementation uses systemd-cryptenroll to add the TPM protected
> passphrase to the LUKS header. systemd-cryptenroll was added with systemd version > 248.
> 
> The following table shows the support of systemd-cryptenroll in Debian
> release.
> 
> | Debian version | systemd-cryptenroll suppported |
> | Buster(10)     | No                             |
> | Bullseye(11)   | with backports                 |
> | Bookworm(12)   | yes                            |
> 
> I am currently testing a adaptation for Debian 11 (Bullseye) with 
> clevis instead of systemd-cryptenroll. If clevis works I will sent a
> additional patch.
> 
> Changes v2:
>  - rewrite for multiple partition
>  - add rencrypt for populated partitions
>  - encrypt /var and /home
> 
> Changes v3:
>  - remove additional partition crypt_data
>  - add Readme
>  - fix KConfig
>  - only systemd is from backports
>  - start-qemu now checks .config.yaml for TPM2 support
>  - correct whitespaces
> 
> Changes v4:
>  - whitespaces
>  - README add requirements for systemd 248
>  - Kconfig add help information
>  - adapt commit message of patch 4 (add information about extra-space)
> 
> Changes v5:
>  - rebase on origin/next
>  - rename kas/opt/tpm.yml to kas/opt/encrypt-partitions.yml
>  - Kconfig change help text and option name from IMAGE_TPM_ENCRYPTION
> to IMAGE_DATA_ENCRYPTION
>  
> 
> Quirin Gylstorff (6):
>   KConfig: add option to encrypt data partitions
>   start-qemu.sh: Create a tpm2 device
>   Add initramfs hook to encrypt a partition
>   overlay: add prerequisite 'encrypt_partition'
>   .gitlabci: Add ci build
>   Add README for encrypted partitions
> 
>  .gitlab-ci.yml                                |  13 ++
>  Kconfig                                       |  10 ++
>  doc/README.tpm2.encryption.md                 |  55 +++++++
>  kas/opt/encrypt-partitions.yml                |   3 +-
>  .../cip-core-initramfs/cip-core-initramfs.bb  |   2 +
>  .../files/encrypt_partition.env.tmpl          |   2 +
>  .../files/encrypt_partition.hook              |  53 +++++++
>  .../files/encrypt_partition.script            | 145 ++++++++++++++++++
>  .../initramfs-crypt-hook_0.1.bb               |  40 +++++
>  .../initramfs-overlay-hook/files/overlay.hook |   1 +
>  .../files/overlay.script.tmpl                 |  12 +-
>  .../initramfs-overlay-hook_0.1.bb             |   2 +-
>  start-qemu.sh                                 |  27 +++-
>  wic/x86-efibootguard.wks.in                   |   5 +-
>  14 files changed, 356 insertions(+), 14 deletions(-)
>  create mode 100644 doc/README.tpm2.encryption.md
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> 

Thanks, merged to next with some massaging.

I'm still open to resolve the backports issue with an alternative before
the release if there is a working solution.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


