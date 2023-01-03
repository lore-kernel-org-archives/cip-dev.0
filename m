Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE3C46467
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 15:06:32 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.43])
 by mx.groups.io with SMTP id smtpd.web11.65479.1672758384173634295
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 07:06:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zVUBoKBN;
 spf=pass (domain: siemens.com, ip: 40.107.20.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pct3q/of/f21morBiH3l9r7JyD6GvSEi/7S9CiA4kKP3IjbQ/BuW+p0fD6g3YspWmGVpluIvjmEWlscv2rEvv/VVCri3qvUi5TgmAZ40DfZtdeorzjwWnk+3iOgIAgZ1nY/qTRv/ZSbxSawk6Zzb96aBxfk8rYiAZ4CIiS0YtpMnR1qNNhfGRsZCaDOtRem21fJ7IOLwj+vNy3RJJ6b6zWIucOWvR0oRpW3bpTirfogl/U0RpknwP3w2etohibgkCG+EbuzOf5tJer3LJLNQIB4nvtiASkOLln1S+dchHz8Qr4KtmGw+zlPTrLABfLTzIbEpSbiXvTVERaSILa7f0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBlMvcCfS2B38DjHMfDOsV2VRYpQkjgwhD7hGQgR2rM=;
 b=lxjW0fxQTNmXvokFYal0BfBo95kX4QdtNeFiYLbi48eYy8MSMjPDf3z0Gq7odDIa6lzgcrkA7mW5sleLLJFPbABjUNYP6OCuzdJ260784Fk6NKRDKDlpD40CNAOinhKB8soH+FLQLBw+NNy7KQ+IdKkQA7ipMlLskKQBTIQ+1l0dyOchxibyaJGSvbZkq43cm0JPZQ9yN4NQ9ZABO6ddqQs/wt08sEFPVyRD0Qi0N5TsrmUJTSt5Ahivv8kWcUFag9LE1gwFN8gU4uMH5eoxQqKOBe/NiHxNVdXXcInV2hsaoOvhLP9vDO2D3x8O9aPfFgP7NkDdhXN3z+Dpw3RWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBlMvcCfS2B38DjHMfDOsV2VRYpQkjgwhD7hGQgR2rM=;
 b=zVUBoKBN1hua22iMRvSwhEFwUUymbJyriO3UHZGyy/eZ3KTTnXCXbiNMtjOIJNghpvRhZI7ncnFVPpNxbrYce7Sr/aX+4ZuOBKDNLA96P2LYkRlxZz1FincxuMiIblhpMM5OsW86vGkr2HydIt2PQStaRpnRgDtnUUHYkaBflGlDrDHGBAx/QdpDS4FUr66TMQSAq0uZpTNdaainHKRccAJ1RPqL/xA6L+j26SUVYi/FLOGj7zzE6j65/6van9qcIISx5AB56b6w4kmL/8SNfcLoAhXbTCIrzmDIMH/D+JhITCLhtmzKIiZ+c2UveT0g0KFEFfejpI0bDgYkyYYEfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 15:06:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 15:06:21 +0000
Message-ID: <7e0aef08-10ba-4ff2-5b44-4245d9c3a51f@siemens.com>
Date: Tue, 3 Jan 2023 16:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH 1/1] only copy "A" version of rootfs part
 for ab-rootfs
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Christian Storm <christian.storm@siemens.com>
References: <20230103123110.358166-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230103123110.358166-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:610:74::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3235:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a7ba0e-a1f8-4967-4edc-08daed9c12b5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ss56+D/P591Rws/+wJvEwTcIkYq9E/C9pdi998MpSe/I46N2yZu5aT3fP7AlK0MXDEc4EoxkHQ8gLOQy5VJXVMrhxARwc2fhHHHABxaXOCEKt4q65MgtSMIbmoec+b48SgwI53Gasw59zvNwr1fBeXgZamsXw9OZbKKFpdmX5Ot8XataRnjVWKbOi1jehC4Foi9JMIl+2vTVR8XBNzVegKHk808Etxx2C6WzYvvnObWhMxd58GN+v5P8emT2vTeJ2xgu+dvmItfJLphUiQjayzkofzpLyqSDxu58Ik5v+J0QPF5EEPOpzn7UxI7Nln5evG9MYpIBUgQrthiKGqhGdJgH6dekX/R9nLVJ/27MKNTROx3jhpSIL6HyGNFCWedq2H+7bISJjeAJoWhBSreTYuKElgM3SByVAtSLeXLZR7QbdotfUL3cpbM/qwXhZQVfSzOiMaRB9fGKCnIlR57KjUWOwUkdV+L6NA5+jDt2c4KwdUiccm+bVkXVcVvMDXj9os6wZ01c3Udpduoh6SOLILiGMrtQLLb77kHTSZgzG7/APvTIOt0q2M4Nq8TO+QefRH4U+LnyObyuUdlz+pc2iayTA74FBRN5X0etFQ6SqB/FIq0hmE1itk2eJXB05evt8vdmH9TYLtZufZUXm47NSd7RDDikddnP7qUctwf5VfplenU1uEA6yuo69HGj42V9HtAKq1gjHN2rbRCXT0clrrFRc23pFMf2V3JyOiYz/w45i19qTKfxysnhN8Y5fFM6B0GPjV+1843qGzsQ1GQKy4ZYYU9o6mJDq/Wgx/Mgigk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(5660300002)(41300700001)(316002)(8936002)(66476007)(66946007)(8676002)(66556008)(6636002)(110136005)(2906002)(44832011)(6506007)(478600001)(6512007)(6486002)(53546011)(26005)(186003)(31686004)(6666004)(31696002)(86362001)(2616005)(83380400001)(82960400001)(38100700002)(36756003)(22166006)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2JBSitRMG5SN29VQmJmR2tHaDc2NktHYTRWNyt1VUlTeXJVc1luajMvTGRr?=
 =?utf-8?B?NTB6dElyalY5eThVUG9uNWsxc1Vxd0g4ZVRoUnVISk1sTVB3ZmFTRGF6d09T?=
 =?utf-8?B?OHRKZDhUL2MwZzFySFdPWnI2R3VmQ1RnSjZNMHVXeE8rOW9VQ0ZPVUttTXBW?=
 =?utf-8?B?b0tzWUtFcVZ6N0xnYnhmMzBXcE9iZnRydTFKNitVMWlQUS8zUHBhbGtRSmhw?=
 =?utf-8?B?UlpTNlhJRWlpVmpnRHNIeHFaNVZNUEVKalhiN0cwS1FZeS9xMDNvcnRUSVBE?=
 =?utf-8?B?L2hhdjB2UUtNNVVnMjdpRkJQcS9MK2VkdmhwbnRONXdpcFhpUHc3NTZyTis0?=
 =?utf-8?B?SkxOYUVrM3hpNzFSRHBiVDd6N2tpaFlSU1daZkptZDd2SU9rMjBPbVZzRnRu?=
 =?utf-8?B?aTJaWkZDeXJZdGd2SkNpRy9ZZDlQVzlMUk5GUnY1RENlNGZoWG56bmtaSkpD?=
 =?utf-8?B?cWFxYmZ2eE02UnptOFdVK1JRd2tIRG9sc3RoZjVudmFrM2ZXcEoreWVSUG9M?=
 =?utf-8?B?b0hrUFJ3dXlmcytKOXAxSnM1ZUx2aDJlNWVuQWh5NmFsTEtSMnlWMFAxdW0v?=
 =?utf-8?B?Yk1oa0xjdFg4ZWRQczJJRkFJbnB5LzZ3ckZBaWtDSjZVMnpIRDBaVHo3N0tj?=
 =?utf-8?B?RnJ1U0F4aXBWWHBUa0JIWHVkSG43d1dPakRUVFR6ZkxGUFphQ0lhRlU5NXlK?=
 =?utf-8?B?Z0V1RWt1Q0xPb1pKV1h5dzdWZ09qM3hYbEJYT0lZZS9JaWlwTDArYmt1ekpF?=
 =?utf-8?B?dFE1MkMzSjhlYmRDSjFrcEVmSUNFbUhrcHUvb2NlQVRML0ZRMzlXMlg3dEhv?=
 =?utf-8?B?V2dDUGlyM0Z1Ri9DdWRuQ0hoeStYN1kwTHMxOExFSHd1R3NYeDFQQVpjUlBt?=
 =?utf-8?B?MWVkVDN5dzluR3V4bFhadGQwdDBFTmU0dGtiUC9oN1NOSkthRXRjMnJoRU5r?=
 =?utf-8?B?UUJuVHJhTmFNWnA1c0ZuOU5pWHU5TEh2SDYvNjJjMEE5QnZzN1FsUlN2VitZ?=
 =?utf-8?B?YVRYZXhoWFhjZmRlRjcrTnBybXZOLzlmUWR4aVBaN3hVcXE3SmJxQXNRVWtZ?=
 =?utf-8?B?M1pZcjdUMitaYTBYZEN1TmtxVHM2VFZXb09kSE9ZMjhVanFyNGdLTVQrbGpO?=
 =?utf-8?B?MzJiSlJHeDRJR2Z0V01yWk5GS1JqcXIzdnJ1QVp4NUR3bHVOZjJzN3FRb25a?=
 =?utf-8?B?emVETnhUWkJKbm9sYjhTdHRMZEN2MUxHUnZoN1RGcFlHcVpKZE4yYlU0NlNE?=
 =?utf-8?B?RWZCRG43ZVBQc3p5TVJScys5djFkNzkySHozVWhYN25IY2paa2Rvays4TG5R?=
 =?utf-8?B?VVQxeVllcElZUCtadzJFeVgzazZmN1o4V1RCWTREbjh0RnZmY29MaGZtckdv?=
 =?utf-8?B?MXE2dFZlckVON2Q2NGdPZzU4Z0xyYWtIa3FMaHNDV1dnUHZzMGo1UzFYUUJa?=
 =?utf-8?B?dnBQVk9NOThvZjlNaXlmMnF3ZU1aM3d2K1NpL0tBMnMxYi9WOVRxbW03allW?=
 =?utf-8?B?Zzc0R2cveWpFYUgyOVNuZEs5UGNOcXV4MGZFc092MXcxaVJ0RkE4ZW4xUlFU?=
 =?utf-8?B?Z2NxVDhqMGV0Tm4wRnVSMXE3WElrVjBJeXhibWNHSkdtd3BVeWhRenhzQ1h1?=
 =?utf-8?B?K29zWFpGREtGL3E5clhlUlc1VXl1NGxWalhYUm1mcTEzM1BWMGpFRVpVUmFD?=
 =?utf-8?B?TjJMQWJySjR5NGJWeDkwa1N4OU90WVhvek8xY3kydzI5c2kzTHlNN2dyeVBw?=
 =?utf-8?B?aVVyUlBpaDliQ21VdHphdkJRRzVMMC9Va3lvSFY3dklyc0t2d3FCVW5GWDRT?=
 =?utf-8?B?MjNoaHk3bGFVeHFrNEJaZmd6NmRwN2s5c3dXNzBqTHdNbGViMXZDT25VRi9p?=
 =?utf-8?B?MFpCSVhUMENXa0Z6L3BTNTlJNythQjhEaGtoMXUzajM5QkdkdWdrRWM4TDZl?=
 =?utf-8?B?V1c1L21sbzlFYUJJKy9IeVpuSm5Kc2NvejFIcjFZbWxRRXRMMmg2OGFOaG90?=
 =?utf-8?B?LzhYakJXRkl3dXJ3bDZQeUlrZ1ZYeXJja1dTckduUlBVSFJRT2pvWUhkZ2po?=
 =?utf-8?B?OW5ScWh2aGgrOENaQUhuaGV3eiszOHYrWkoxMnFOVG04OG1hOWhZRnJBMEJo?=
 =?utf-8?B?NldBRVF6Y1RXR3ZiZ3pnNGFZeGhqZk1WblRuTzlncDlOemQ1U05BczEzWmtM?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a7ba0e-a1f8-4967-4edc-08daed9c12b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 15:06:21.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOQAYDO7SJq6X832rZorMF9iptTKve19TmjUKbCWhTgzxdhpcU57g9qRpti9IEx4m0JaLUCSSF9Bet3yu+UBJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3235
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jan 2023 15:06:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10287

On 03.01.23 13:31, Felix Moessbauer wrote:
> For swupdate images, we currently copy the rootfs to both the A and the
> B partition. However, the content of the B rootfs will never be used, as
> the first boot always chooses the A partition. And after an swupdate
> image update is performed, the content of the B version will be
> overwritten.
> 
> By not copying the squashfs into the B partition, we can shrink the size
> of the initial image by half and also cut the flashing time in half.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  wic/bbb-efibootguard.wks.in                   | 2 +-
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 2 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 2 +-
>  wic/qemu-arm64-efibootguard.wks.in            | 2 +-
>  wic/x86-efibootguard.wks.in                   | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index e48cc7f..8a8de50 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -12,7 +12,7 @@ part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-
>  include ebg-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index 0e298bc..ba7846c 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 3b8dadd..80a7803 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -1,7 +1,7 @@
>  include ebg-signed-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 9ff03e1..53ab568 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -4,7 +4,7 @@
>  include ebg-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index c71253d..ed01e28 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -4,7 +4,7 @@
>  include ebg-sysparts.inc
>  
>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
> +part --source empty --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>  
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G

Seems reasonable, but I might also forget right now the original idea
behind filling both - adding more folks to this discussion.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


