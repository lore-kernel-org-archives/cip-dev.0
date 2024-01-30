Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE19C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 11:37:26 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.48])
 by mx.groups.io with SMTP id smtpd.web11.16084.1706614640545550875
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 03:37:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sqYiOFKs;
 spf=pass (domain: siemens.com, ip: 40.107.7.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bclg3GkonMwBRmcr86l7pooSj0AjZYyXhMcc3XwTJGPVIsUGGfJov2t8r6srMrXRmjGXDuoC4Ss83U9tVKIzUw8KYXBCNaUFeF3bdbT+689WO5HuKimHqfbRPMH59E+CaNnR3eSJfjUsP/p9iEReKdXRNQsq7zmqFMmAyoUSKrL8Y5VA3qcmkylM/bTWK0oHij3fy2CqwtqIZUK7esVJejqtCMNY+nphw1auk2gWXFa51Yk3YV/4oRbnygjIewpAkwqDqcUOW0Tq1M8IK2QZ4PZSV+++iqQ9UVTyO4qQ0F8dK26QbJkgDrXD2tJeGCTqaoRHz0qdG74FKPxyUG+kPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsKXqDont9qFKyWfufG4/v2cDMm6Mi9f5KpGSPtoV8Q=;
 b=Wi+BDe3FsX+P79VEssRmY64DAciq6aEEkyp4/TPl4ocLAiFEEe3XkGGzT0px8e6mZj7CD8076TS7kkK9goESFjODiIbBkuxhPy8jAgV6mCmBDanZLP0E9Wu49oXV4nmTot8BUc1bY4ynG8W4sdCYxHQ5cxGmNHw5NwfObbSc4cDW+TcWHm6uUlLnPUBuZjjdJk/5jUC1NzSP4pQr0y4ecZmyWVlG2zjV4KF0k63EnDQaTc035z0OTCOjFN79tcJiyLXtucYz4bUsFilh/QdbfLNBKEF2iehEthzswEMYRrs0nFedjFpgFMl5Dw1XbRkvP+ckg7ncWZVjIa72dpsHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsKXqDont9qFKyWfufG4/v2cDMm6Mi9f5KpGSPtoV8Q=;
 b=sqYiOFKsHjw3iDZDokgLyv7AIFQwTLgzX0A38/LhUWhEkTnsX/e2aYXw3V6i1Qpd6mw5fq394sTNz/TbOgUtoonAY/6a8kAS3v6AttFl52Dw2j+cPD4yjCCsv8iyhvBVwaPkyObsl4ItYXbf5cTKrLjtUfYz6/zEQejUd29erap7VEjqfJ8Kt1alAOchFTRcVJJQdp3Ouz8edHwb7Xty2VhaHSa+KjsmSi4izmClXBv7udxrU95xvTGGUkEomM7xtjIij8fTNB2G9yM15uJZexG2vJCwy2mcoujTDokAVhHxR+zu1AqjNif4suihc/HIj52OVdj+3rQa8v+yu3yBtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:427::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 11:37:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:37:15 +0000
Message-ID: <5dcad42f-4759-4a46-8120-b87f862407f4@siemens.com>
Date: Tue, 30 Jan 2024 12:37:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] wic: Set fixed partition UUID values
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <8ee6a477e885307b180d216fd83ec4475247ac0a.camel@siemens.com>
 <20240130111722.1463101-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240130111722.1463101-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: add0e4c4-f115-4847-c7d9-08dc2187cf10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D12ZEOrBfilu+RIC5BDCwx3Ad4FCd4TSZ/uWTxOumubnvGQu0op16nnMTLvY4pyz0jN8nsY4FpvIaDCkdWewm0UM79ODtXLW32s/DiQQ6f7RePrpx5EXL/rwcEktaACVwq0sryY1LST4jGdkmjFIqWYVfryfl0lXLRZTlPYxc9DAf8LqzeTEzRhrHAlrieVpeL4V81DQM6oImlJW9yHSfOKRXfMEA2/wNZtn27XWajJN6YJ5DrNYdGtUEkwlHgcEY7mEadV8tvBYDw5Odqmw8RqXUelDTVsc/J5EvFTdus+4cHvQhSI+O1hto8Pojs2LwRu5EdVCgxAjVCEbPKaRaBy1HO/wn9+QpvDOoDcMi6AMe4aWdGaf7jn0ra1JwSvppV8NVPilYyZaQLuYKj+KkvVG2Yr45scqd5ASr+RbdLDbgcaQ9K4JqM8Ku+Vd2bCFqxZRKaIOvk5P2DHg6JEpGH/mgjjCKA3Ac4n865WCJ65RNdq8h6rV7C7NfIrkphaDCa0z2sSOn4VijxOBMSFVQiKt8O8rsU1ZOcKtheK4ezOnkmqP29UnjiMzFBZqv3DAF2DHKvR4oIpljUlM84eYi/AOjEJCR8HL4FHJvSclnuzE/2/h5Dx1KneIkurZeyI0dtN5JZkzTEEFEO/JVedrvvYpcCSg3h/9ydMPy7B/94nG2BtbkgReJuTfgBVpYrsz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6512007)(53546011)(6506007)(38100700002)(66946007)(478600001)(316002)(2616005)(8936002)(44832011)(41300700001)(30864003)(5660300002)(4326008)(2906002)(8676002)(6636002)(66476007)(6486002)(110136005)(66556008)(36756003)(86362001)(31696002)(82960400001)(26005)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0w4T3RpaWFtYWxLSTA5ZndST0pWNTA3YlZVWDNXRHhWSGpLdFkyT1J5bDND?=
 =?utf-8?B?VWRJbDhLdTc1bXNLS0tkMnZ5aEtMbWcvODhPUFVyZXVVK0Z1czN1YlRURHFn?=
 =?utf-8?B?WHRWQWU4UUY1ZXpwbWF6cEdnbVVCNVRSdmo5RVVTMm00U3VNQTBFZVpiMzQv?=
 =?utf-8?B?NmxDUERybFZCOTNuQlRTRTlpN2xqQlRSM1dRMjcrS3VOTkhQRjRrNXBua3hZ?=
 =?utf-8?B?U2dYenhXRzdaMVp5WHBmNVJvVWdQamRVa21iQXhBL25iSGNPOURTNFVlbGxs?=
 =?utf-8?B?dTZqVTJoRlNjMWw3THNEQ0MzVG1rL1c2d3hZMjduVWpXcGFRZ1h6QnFrMDZE?=
 =?utf-8?B?S2pkV1BEditNckUxNVkvTE1FaGxJVFFHKytBd0IyZzI4RnRSZDNVdVVBUFJ1?=
 =?utf-8?B?aFNkeEZqRFJ4YWRQUEYrSDYyLzNHL09nQ0lGVXRIQURndlEydkFIdktZdTZR?=
 =?utf-8?B?cElWM3BNL2FLYnRrdkgrYm9JNnBXT2FrMVp0SjJQRG0wK3U5U2Nwa1lqSSt0?=
 =?utf-8?B?SXd4STRyb1htaS9BOHdYMENzSGZRQkpsSUFsYUlsR0NPbkxaOGFGZk9sUFdi?=
 =?utf-8?B?L1ZES3hzN0V0aGpldktRTXN5Tlh2eXl1d0Z6MHVlUkIrQUoyeFN5cU1RVWtl?=
 =?utf-8?B?UGtWNmJIY0R4bGk4blF1VGQ4Tkh6MzNOemRUVk83cFU4WDJFNWRPb056bG9p?=
 =?utf-8?B?VEtjaEtIdEV3c2E0UGlWbXNzc3Z5ZzhiZjdWbXh1Y0JrQmxBeHVXM2dyU2xq?=
 =?utf-8?B?ZWFnUUdGRVR2dmFpUWF2U0dVaW9oMEJXMjN1KzBaYitQdXlIVTVhaEo4WktX?=
 =?utf-8?B?ajJzMXNDUGtsb0lkVi9oSEJYbndnbDI3NXRVc3lwamRxTVIzaDNCNzcvUjhI?=
 =?utf-8?B?cyt0M3BHRVA3clFsWWw5cnJJVTdDeDFuc3laekpZM3N1QWhBL25GbW9teHdn?=
 =?utf-8?B?UitkbHI4aWh3a0hPYW81b29Bc0lzd2M0cmJFZnZZcml4TE1lcVdrVytYblFh?=
 =?utf-8?B?d0NGSGl2OVIyby9ZbmIrY2hydCtlUXRpcWNNeGRwSjF3ZndTU3MwNHdKaWhh?=
 =?utf-8?B?Yy96MG5WQjNGVU1hMmR2Q1hObGVsQVozODlvZGdmSFpxOENGekVYdGhrS25Z?=
 =?utf-8?B?cnBscndoL1RadjBhNU8vSlNpdUVRYU1KK0xjRG5XTlJPSUdvdjRvZWVOeXFo?=
 =?utf-8?B?SjlFYXRvWmUvZmYwVFpwTFZMdXZkSnQzN0V6aUtZdTlTdm90TkNUNmFPUnBI?=
 =?utf-8?B?c09GMjNBc21VdzJzRWdRVUJpOFRqTkszQzFqNCsyWnN0UWRic3M0WWFEZDFB?=
 =?utf-8?B?NmxkNHpKSEZEbEdOYUdobGI0bHRvQzErTEkxUEZMcmZvVkxES2U0K2RpU3hM?=
 =?utf-8?B?b3dTd05veWExVkN6S2dqUzBWUTc3OC9qNjl2UnhrbVVCT3FCUzNsTklyVDhN?=
 =?utf-8?B?V1pJSWV5aG5VZnA0eFY4WWIvTnlOdlkxbU5vUk5FMW5kdU9PeXBWbFVrbzdx?=
 =?utf-8?B?SC9CY2RCTHBGYTVsOGxhNG02bFlzeVZXUU9QMkdxd1ppRmpUd1diMWtFWSti?=
 =?utf-8?B?anM5UkdnV0VZaTdUZ2h6eTJDK0k5U2IxcVJ5TzAyN0tuYWdaYjUweHBDZ3lJ?=
 =?utf-8?B?L0h5U1hTTVpYV0dyemdXZHdNaUNSQ0tObGxaUXhBT0pRUjVSTTlRVC9LZXQ4?=
 =?utf-8?B?TUMwSHlFZENacG5wRmJ5OUUwbGlRNlZqRTMwVklONXhoRWVjbFA3aEF5WlFu?=
 =?utf-8?B?ajkvc1hCSW13aUtYNmN0Z3FRR0lhcVNUV1dkWVhBWjI2b1dMaDh3eFBKZndN?=
 =?utf-8?B?WkZyQmVYWklCamQ5V2dPS1o1ekZWMHB4TVlkSkFERE5aOE05Q1Q2WkpqMURm?=
 =?utf-8?B?dXZiUHZraVJOS3JuTXVhT0s1bTBmb045Slg5N2ZIcDJkRytSUkhZNmJLNTRE?=
 =?utf-8?B?VUUvNThkQmJkZFRZL0tJa3B6YnZYNmdrZE9ZbTdPWm14dDVwU29JVXp3b1B0?=
 =?utf-8?B?ajlISmpBbCsva0l0K2Nlb2JYdTM2U0RDYUVYUVVkd3pDTkZteFc2VkRKNVdN?=
 =?utf-8?B?UEJUai9YK3p6MmlPcFI3NXJiZzU5QjNTYXdhckdsUEdndUZSYmEya0xSNFRp?=
 =?utf-8?B?QU4wTE5SUkpuSm43aFdWamtZWkx1a2JaUHlQNEVQdHpKRk43QndLbkJkK1V5?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add0e4c4-f115-4847-c7d9-08dc2187cf10
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:37:15.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEzQhVnek+oGc2g/9oskpIIuW8ivhmVfd58yU89Be5vK6Qga79xeURjH6vSCxVUW2873Q1njbPwOsMZQsnFejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7484
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 11:37:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14492

On 30.01.24 12:17, Adithya Balakumar wrote:
> This commit sets fixed partition uuid for partitions. The --uuid
> option in wic allows to set fixed uuid for a partition. This is
> required for generating reproducible images
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  README.md                                     | 1 +
>  wic/bbb-efibootguard.wks.in                   | 4 ++--
>  wic/bbb.wks                                   | 2 +-
>  wic/ebg-signed-sysparts.inc                   | 6 +++---
>  wic/ebg-sysparts.inc                          | 6 +++---
>  wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
>  wic/hihope-rzg2m.wks                          | 4 ++--
>  wic/iwg20m.wks                                | 4 ++--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
>  wic/x86-efibootguard.wks.in                   | 4 ++--
>  wic/x86_64-generic.wks                        | 4 ++--
>  14 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/README.md b/README.md
> index 4ded924..62f72e5 100644
> --- a/README.md
> +++ b/README.md
> @@ -27,6 +27,7 @@ the BeagleBone Black target image with real-time kernel, e.g.:
>  
>      ./kas-container build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml
>  
> +**NOTE**: For Production images, it is recommended to use fresh UUID's (Partition UUID) and not default ones.
>  

Looking at this from a different angle, this recommendation basically
ruins reuse of ebg-*.inc files in own images because wic does not
support variables in include files IIRC - while we should better make
those UUIDs variables, rather than hardcode them.

Looks like this needs a second thought. I'm dropping this note for now
while merging, specifically as the need to customize variables only
comes with combined with having multiple images visible to a device
which is not totally unlikely but also not really commodity.

Jan

>  ## Running Target Images
>  
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index 48789c7..b9c8f3f 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
>  
>  bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> diff --git a/wic/bbb.wks b/wic/bbb.wks
> index a797e95..b46282d 100644
> --- a/wic/bbb.wks
> +++ b/wic/bbb.wks
> @@ -9,6 +9,6 @@
>  part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
>  part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
>  
> -part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 25d57b24-f34d-412e-8c88-28629f23aa0d
>  
>  bootloader --append "rootwait console=ttyO0,115200"
> diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
> index b2340e2..be63cd7 100644
> --- a/wic/ebg-signed-sysparts.inc
> +++ b/wic/ebg-signed-sysparts.inc
> @@ -1,8 +1,8 @@
>  # default partition layout EFI Boot Guard usage, signed version
>  
>  # EFI partition containing efibootguard bootloader binary
> -part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba
> +part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
> -part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb
> -part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc
> +part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
> +part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
> diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
> index 300c36f..121dc73 100644
> --- a/wic/ebg-sysparts.inc
> +++ b/wic/ebg-sysparts.inc
> @@ -1,8 +1,8 @@
>  # default partition layout EFI Boot Guard usage
>  
>  # EFI partition containing efibootguard bootloader binary
> -part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba
> +part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
>  
>  # EFI Boot Guard environment/config partitions plus Kernel files
> -part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb
> -part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc
> +part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
> +part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index 2ac8850..aa704f5 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
> diff --git a/wic/hihope-rzg2m.wks b/wic/hihope-rzg2m.wks
> index fd3a338..f5b850d 100644
> --- a/wic/hihope-rzg2m.wks
> +++ b/wic/hihope-rzg2m.wks
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --uuid d122d639-1d92-4b41-bf7b-4b2bdf8dd899
>  
>  # Rootfs partition
> -part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid b8bbba3f-3ba6-4b2b-8d69-4a95fd4f34ed
> diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks
> index 85765f0..21fc419 100644
> --- a/wic/iwg20m.wks
> +++ b/wic/iwg20m.wks
> @@ -12,7 +12,7 @@
>  # [Note] u-boot runs from an SPI memory device
>  
>  # SDCard Boot partition (copies files in IMAGE_BOOT_FILES: zImage and device tree)
> -part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --uuid 28a58348-5270-44d3-bea4-b1c492a81b7f
>  
>  # Rootfs partition
> -part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid d0fa8361-7deb-43df-acee-1725d40d403e
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index 2e5cb39..b16da0b 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
> +part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 2fc389c..22e23b4 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
> +part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
>  
>  bootloader --ptable gpt --append="panic=5"
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 1f50ba3..7fe68d9 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
>  
>  bootloader --ptable gpt
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 9158aa4..19ca1e0 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
>  
>  bootloader --ptable gpt
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index 98e8da5..43bb782 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "
> diff --git a/wic/x86_64-generic.wks b/wic/x86_64-generic.wks
> index 1a44e26..a2b9c21 100644
> --- a/wic/x86_64-generic.wks
> +++ b/wic/x86_64-generic.wks
> @@ -6,8 +6,8 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba
> +part /boot --source bootimg-efi-isar --sourceparams "loader=grub-efi" --label efi --part-type EF00 --align 1024 --fsuuid 0x4321dcba --uuid cf142945-6fa1-4945-b0f2-b8d6226298c0
>  
> -part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f225331b-2d9c-45a2-bcfe-4a6e86287dfb
>  
>  bootloader --ptable gpt --timeout 2 --append "console=ttyS0,115200"

-- 
Siemens AG, Technology
Linux Expert Center


