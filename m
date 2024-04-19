Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92632C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 16:34:33 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.80])
 by mx.groups.io with SMTP id smtpd.web10.26024.1713544464768851309
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 09:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VQ1oiB7f;
 spf=pass (domain: siemens.com, ip: 40.107.15.80, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gryVW+UaEW1n2s+tgoWClelN0BvdGLntExBA0AGjzoBm+mlHL4N/JiOv9a0EV00umGPzkv5R1rKF1FKEFrR7RBlNXrlT2vgVEe1xP1r2q/z9fMAUpiRfvOKtc+1PrWNjSlr++ut/8SVF5SD+nVUv1erxymk/XOaDg6LXW2MJnj1XG8X8LsqE4kVqj71RDYEMwp0veHydarvXVdXg/nd2DLRwsHmZ0Iw6msbO2xqeNYStDQPoCTiomtg/tkIE5vi6KbW88JWhep3xBci1YhRAPaXHC+hkdk/8Sg77O+cuEamVy4JBNy9Y8Cry91KeGpBmyJIkBh6cROXHSkAoO/xyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIQ3LuqacRjdWilNloUPRkR2K7d5dcNztpT5F2IOZP8=;
 b=NicR18mhGw2WOu76RLbxNUeFaYbtWml05Rj46EaRGoNCbQ7qhTpMMRNV6vKYBXhBapK28SwuHKoOJDk5WVW14L+DlyEsxIh/1Km8dKf+OYuZ09upQ9Ncd6ZCA2BiIf4BW23hs31tkjcrf05racRDfQFQvbTWVEKDx0LmL6PsQrlrodTHy/bczd1GJc96HIeJVp7XuXW7gh3uvD1x2W0rQwksu4cMLVTcokTfRLXJfKUw+eEdmBvEtq0G5LcauykDwXeF54XdagsyGCi3yQoISHK+W34UbyGJzBpgnKJKDYbbVy2sBhkhBFx9IrAiNFL1JOBSJoEp+8NF5vV43p69qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIQ3LuqacRjdWilNloUPRkR2K7d5dcNztpT5F2IOZP8=;
 b=VQ1oiB7fD/j3IhxRfaHnxdaB+hf8oiUOs2J2TcNxpLYvXb5m6o4zmKpHrQUDHuhEsYMZzWqEey48F3Ub/oL04YGeXevWrEranHXLntJ7MGfmWCZMXZJlPRJW2mQZE8AnpnClwKNyAFThg2XcQHbXJ5LRiETV08NyjLUbXdvZwThMeXZ6Kqoy32qgEMQis3uuxptLnGkNV8BymK5TL+wZO4KMMFbxR9keh3Z5CHVSBLr/D0tFJZeUGn8q8Gji7GfJFZGBBrR1Mq1PvQtx+MmA7hltCknLMLSYZE4nehWPtLx5dxRH3eE+wAPuy4oqtFHIY1gwTOz3BTRFRHILVzWBwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8501.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 16:34:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 16:34:22 +0000
Message-ID: <0c9977c6-c7fa-4f82-8e3b-1a0c8dc3576b@siemens.com>
Date: Fri, 19 Apr 2024 09:34:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 6/7] Kconfig: Add option to
 encrypt the rootfs
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, johnxw@amazon.com,
 cip-dev@lists.cip-project.org
References: <20240419082036.2389583-1-Quirin.Gylstorff@siemens.com>
 <20240419082036.2389583-7-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240419082036.2389583-7-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: bda69fa5-adc0-4809-f47d-08dc608e9153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AqCwVsNpB48rcBi4p/lGg1Op0QH/FClAuK3iOJGoUUqouLxSm3VNC2oxws+DHx7s1nVPKDKFlBVImUCcN//AoUA7OItas1j93hKLOhGooFv0vqZXWUimw6aOZL3HpTF/+HjIo14ZiglmbbPZNWqGJ8iZFXOaOWheCuVWGhwVJmwJ7xemxmcZGmC2mP/xtkWOv4tHWYsPc0nH5MOeHIuw/up7euVN67wy1PDHYJaoy+pkeDDS7lEcVSZZlu7MsK/nn6OINiSBxhlCdI9UwTmd/fHTE8x6qVTkP8uWRqx1PDub9rWU/XwMoPXrRvyp2XDzIpmrKDVSn8dHimhni55A1CZ6hq5MWZ+Nn6werKF7WVAxU64PYWnSvt45cPfRDziEaS8VZCkUVUJsMIV+yCs/KpaLXPbU0lcbfKX2iOTrXkDWbF+y18zw7hSfdmnLJvcL/+i3/N5AWa7rIC7mPhFZeYjSb4l7suOJQ4xUdXD2M3AdmER8PREJS/8fgknBFKCGwKbTJpz/WQTQOcb+H8wATf7+6SZziH81EMztjP5tubdWjEzQgGdjkdd7st797EdTUgTWSlj7609TGd7bBcDyU7+4uYsRR57WB8rjhxvi7GlXLtbyVoTbtMJoP9B+1O/8ofQYKuh5lGs+Xm73Za0xrB/sIZNFxRZQCRqBYXCkEx0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlBHMWhkQTUxdE5MS1loN3hpb3loWDJIYUtOWXVhK0kxODJsMUNmbUtIYzMy?=
 =?utf-8?B?eGt4NStLL3ZudktnSEJJYjE2d0JqblVtcXd5NmVVRGZtcjY0WHlOTTVWTW1m?=
 =?utf-8?B?MVhZMXZITlpnZXlOWkRaMExkaGw0dGd6c0NEQUFZRXFxYSswS2lKeXI1ZVlX?=
 =?utf-8?B?WHJycm5ya25CUlgyV1lBa0pTeGJPZXhtOTZIcmtRNnZuU2g4Q0pYd2FhVlcv?=
 =?utf-8?B?endPTGd4YmlYNVBEeHpwQngvQVQzYVJmQUlJTUhyQXRzYkNRdEM0ZnloZXRP?=
 =?utf-8?B?Wm1BSFBQb08wWEozR1c4M0tYc3RaaWMwZlM2cDduNndYcCtnTm1DUEpkQ0lo?=
 =?utf-8?B?M0VLQkE5TDVJeG9pQW9QR3ZNZ0UrWFdMeTFDWTJ1QUcxckF0OHdKM3VlUzBZ?=
 =?utf-8?B?cDQvNm04aWlwSDR0UzcwV1BwNEYxN0V5RGdLbVhuM3FWZVBRL2RhM3d0VUlN?=
 =?utf-8?B?TTlFOEdZR0N5clhyY09Uenp0cnhpWTZjRml1YmM2YVdZTHFrM29nbllWeGo4?=
 =?utf-8?B?TnRRNHkyc3hCalpIdmZQUGhlVmZHNXA1blBGR1Fza1E4c1l0MENZY3E3eWg5?=
 =?utf-8?B?YmQ0a2xmNFc0YU1SMHhMZGR6a0hBamR3ZVVIWjc5WlhzdDZGREswQ3VHekt3?=
 =?utf-8?B?NXFjbWJCNVRsRllhQ25rWWFyTUJ0NGF6U29xbU5oUEJxcmR2Z21GU0dFSFlm?=
 =?utf-8?B?d1YxS28yUEp0Qk1LdTBMQnlMa0hTZDB4a05tZEFMN3Z3a3ZGYnNyWXgwQWh5?=
 =?utf-8?B?R1Zpd29LbGJieVl1aDR4OVQxeFdkell2ZXkvbUErMjRRUjZqdGRwekJNcXF2?=
 =?utf-8?B?V3g5eGt0WlBEYVg3OWlCTXlhQlV2ZEw5c3Q3SVlzL1NPL2dkcCtBcGdIQTJW?=
 =?utf-8?B?bFFvQmJEenc2V04zWThIYlV0aWQwZjhweklpZUQxTFNzQ1Z4bE5adkRRUkts?=
 =?utf-8?B?UER4b1FCbm9CTVJmOU05SVhKaHJCWmloZU4xUVhMT3dLZHRONzByZ2RvM1dH?=
 =?utf-8?B?Q2o5aHV3QWFZZXQ2SDE1SkkwbFNsRGdvNzk2blhURERhemRXdGlJNW4yYURW?=
 =?utf-8?B?bm1tanZnSGFZM0lSMDgvY0w2M2kvMFJ6M1Q3L0hMelY4ektEaUlZQjdCZlUr?=
 =?utf-8?B?cjR4Q1ZWMmVqSlhPV1RIZGVTd1hoUzlxV2VNWFVsYUVpbTdRTlNydk4rRWFM?=
 =?utf-8?B?TnR1cVZBakE1Y0Y0RW9tcEFYVTBVa2pFL1N5QXdEaEJ3QUVuZnVYdmc2OFIz?=
 =?utf-8?B?bUQ2R1dabU1mSHNDVVRYa3YvTzg5cDRxcU50Q3p3NWxnM1pXOFJpdlNmcHln?=
 =?utf-8?B?OE1MOWpjcWhDY1ZzOHRrWkl3RUFFeG9KYmh6UmdRUnlMdDhaa1hPcE5Td0kx?=
 =?utf-8?B?ellaYXc0YmM2R3djNG5kVWhCSWZVLzFKeENYdURZYW9tRXpjdXJwcUR0dDYr?=
 =?utf-8?B?MGIzcXNnWGJQSkNxMXdzNGZQQlk1dGFXc0crVnBIcjBkOWI1S25vdHBxb0ds?=
 =?utf-8?B?WU9oZmM5WHlqRGRMakNmM0xJYU92Nm82MVBhemtZSnVpWlliYUtsTWtISWR0?=
 =?utf-8?B?R1RGcXdMNmg2ZFF3N0dtMkZRUGhhZDNUOEJ0REljYkc0emhCTFp1djJJdWpM?=
 =?utf-8?B?WFlzZ3hXcjd4YmdmY1c1emg4WUtyZDRvM2Z1UDMybmVBcityZHRJd3ZOTzJy?=
 =?utf-8?B?T2RUeU95amZGZTdtTU5yeFJXd1h3Qy90TlhKdW5IbGNRUzYvMEQ2WmRyZWRG?=
 =?utf-8?B?WkR5d0tJOUhIWGVobDlJVmN5ak5JOW9wTjVleUFIZW1BQS94dzdjMjA3cFRN?=
 =?utf-8?B?V0NNcTJnbS9UMGExQ0FRaG1sMHNBMXd4RlM0VUtEVUdZN2RJdmpxb25yejhQ?=
 =?utf-8?B?TjZMM1dBZTA5ZmQrNUlHeG0zaHNLZFpPMWVHa0pEYjJNRVBwR1JycVhmbUJu?=
 =?utf-8?B?OTIwWXF4RkkrT1AvMkQ2cVZUYW93VHJCME40dlhXTnBEVVR6WHN2YUJJM1JD?=
 =?utf-8?B?UVcxSGltdWl2UVZVc1dwa0tDd1VxZER4OFRNVklCaUhxZlloV2JBNEVwUFFn?=
 =?utf-8?B?Ym9iQytCZVNRN0czL3lqWisrUzU2Z3ZUM1pQcENEN0NBZm8vNTdRZVUwKzNx?=
 =?utf-8?B?eTIrTmgwVzJiWVJxTkxHRld5N0t3aWFqd3B6RVhQOHRKRk52YU5zNjN0Nkdz?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda69fa5-adc0-4809-f47d-08dc608e9153
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:34:22.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFbA/8qUR2va7vd4NgOtv0hMKV+nLLmdWkT9EoJFhuRJTZ/Px/0W+RpgzbBdCRTk+StzArjeOcP9F0nrMdH9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8501
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 16:34:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15705

On 19.04.24 10:20, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig                    | 20 ++++++++++++++++++--
>  kas/opt/encrypt-rootfs.yml | 22 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>  create mode 100644 kas/opt/encrypt-rootfs.yml
> 
> diff --git a/Kconfig b/Kconfig
> index 7c19640..e657a22 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -202,15 +202,31 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
>  	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
>  	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
>  
> +
> +menuconfig DISK_ENCRYPTION
> +	bool
> +	prompt "disk encryption"
> +	select IMAGE_SECURE_BOOT
> +
>  config IMAGE_DATA_ENCRYPTION
>  	bool "Encrypt data partitions on first boot"
> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM
> -	select IMAGE_SECURE_BOOT
> +	depends on DISK_ENCRYPTION && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
>  	help
>  	  This enables LUKS encryption for the partitions /var and /home.
>  
> +config IMAGE_FULL_ENCRYPTION
> +	bool "Encrypt rootfs and data partitions"
> +	depends on DISK_ENCRYPTION && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
> +	select IMAGE_DATA_ENCRYPTION
> +	help
> +	  This enables LUKS encryption for all partitions.
> +
>  config KAS_INCLUDE_DATA_ENCRYPTION
>  	string
>  	default "kas/opt/encrypt-partitions.yml" if IMAGE_DATA_ENCRYPTION
>  
> +config KAS_INCLUDE_ROOTFS_ENCRYPTION
> +	string
> +	default "kas/opt/encrypt-rootfs.yml" if IMAGE_FULL_ENCRYPTION

We still have a logic flip in the name of the kas option files:
"encrypt-partitions" suggest "all partitions" while "encrypt-rootfs"
does not suggest that it actually means "(almost) all".

I would suggest:

encrypt-partitions.yml -> encrypt-data.yml
encrypt-rootfs.yml -> encrypt-all.yml

Jan

> +
>  endif
> diff --git a/kas/opt/encrypt-rootfs.yml b/kas/opt/encrypt-rootfs.yml
> new file mode 100644
> index 0000000..f273b65
> --- /dev/null
> +++ b/kas/opt/encrypt-rootfs.yml
> @@ -0,0 +1,22 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +  includes:
> +    - kas/opt/encrypt-partitions.yml
> +local_conf_header:
> +  encrypted_root: |
> +    # Do not set mount points for systema and systemb as they are mounted by the
> +    # abrootfs/verity initramfs
> +    # As we use a weak default assignment in the intramfs-crypt-hook recipe we need
> +    # to set all partitions
> +    CRYPT_PARTITIONS:append = "systema::reencrypt systemb::reencrypt home:/home:reencrypt var:/var:rueencrypt"

-- 
Siemens AG, Technology
Linux Expert Center


