Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F222BC636CC
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 13:06:43 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.67])
 by mx.groups.io with SMTP id smtpd.web11.11392.1675170397585563384
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 05:06:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OCNrZfNt;
 spf=pass (domain: siemens.com, ip: 40.107.105.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I01FLVM/eHwA5RrfSigYnBVdBeo3njNjQ1bvv/1AxPOuwKNAuqQz7f8i9lrqKswHUsI5V2jx9BvUkKA7/VUykFG2No19InJUy/h9jC4dkVhT9ZIDTY2CE82CphCas7TLSX+sGNZZwhYk+xMVsCiGW2lyFHuBJtNQ0iIyws7NoToOfI6i0dzo3TMnU2PVs4/cvD1VHrb4y6FCorZSorb0Eu9bEvSM+g0V64X1sA2T4PHln+9X/BSpNCs4EHMH4f/MDQsexQDdWeDIDv/Q78YCiy7m0xW9l9s4DxUP+MqigEuQJdZ4FVmngwPyRPWoGcr2dyAp3F/TRInVcI/SUf5Dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JviQDv3hAwegoI2MAk9BLL3Oi+qihZI8Qpchhk/rvsM=;
 b=JaNQvR+/uyITRo9hjQkWgsHgmSRRWhfjSizFMzuVKXfyGj+8R5PKT8l2160WdShSuv6W9uzcgNwGerwI1BTnP0ORwJaAPb5hKNQDZdlt4xUxV4bVDJA8mDOEKToXhIXwLQO0i6q+ihVAS+/u0/Z8O4FopMoDFqBrGyQeTxYVbCdkQ2wWYcDKBdfbY0A5Ctyior4/iMvy2gK3Pa5bZhzlJRUPa2R2K4qxl4QmVvNvth9WrDpHDMFwKVw/eenZoLruBJqpdqB+fW7tLhHzdmKdA1N2evvcHdp1Pbf3v3mD7NSk5Ol4CByaHysH1LnsAu8BoiF+sBek9lYXt4aUBO1DWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JviQDv3hAwegoI2MAk9BLL3Oi+qihZI8Qpchhk/rvsM=;
 b=OCNrZfNtEOuK68FpDabIt5MUCezO77PzD4ZfqkVkHN7vslgiuElOz8tLVXggy5UfLsEmHDEcotAcvLeb5T8LRkARP55KVhbJSMlf+4EbJY4cJnQcKP0ZP+VYLbVzdJkfmYDq7tscZIoF7AJVV6EouUFbTmtGhdrtKCtz5TYLJs5IQgXEW9VdDOThq9oG996d0kH3UFbrsaz/QWJSs27Cdp6mD+LoK4k9SQWQOJQYYu8i50hWpRD30q4p79eul3oNhxZoI2U1Sky+JHGxenxedYczqe7q/FVNE7qphxpISDRkwYrTaL+WpAY3GKQv4KmmtbVsQtjHLlpOyTVyVwp3cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 13:06:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 13:06:34 +0000
Message-ID: <32f270be-5b19-65f0-4f24-4fdd95d4d459@siemens.com>
Date: Tue, 31 Jan 2023 14:06:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][RFC 3/5] wic/x86-efibootguard: add
 partition to encrypted
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
 <20230130150204.697758-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230130150204.697758-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:610:74::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a5835d-5126-4893-aebc-08db038bfa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o/I+qTOqNIcXu2bdE7lh7qLNTZBNPbF8DOIsu6shz+2Tw4j3JHVAWM38tbf+y1M+e6hWNcRnMJVGol6zodrEvb/vfA3Y6BJgA6qfiVbHXDRi/8I8xkh8liSszfz4zjXNFiczufug3U3H/dM0aFysii9THvCfZYnrn9+T6253dG3sEHtje8oy46uka3Ll9ENkAS8CJm+AYq6jKfQhBQezTcow1iOmJDDsHgs+Z5lNz3Dtsx7oik2Yqr54xOeg/B1OT4B/MvJOCVFv9JgXQNHyGTotffEZhCLtTrpxyiEzh5NZwEkUC3z5fY7VRCwIlSp9bdb5PdTStvx/vCePxC6mT7HZGk/vQkYNTo+OZ5w5UIn/iyhjAv+S2XyxQi42XgIMm01WaFnYActfJoWgH1u/ahsQL/x0kedkbrRVN4nBq1ByJ9+WQHYz6A4r3tw8kmMWeU9Po2tFCQnnt/YUhpD/EIeNJ5wEb10PWpUI53Hl1s6bHk/v3AAWSOU3Td+qGXnmhFLpAe/T35AU1jU9WjLbrI6nnnCZRNHKF/7kaDKt9QNQyDNbEvfxpq2nULbV0qAv1Dla4t0H2UMlr5iaxitiaL70LPlm8nkq/D95+LKg2BsEnWDkS4pNZnwmQnwZfcMylg20qreRn68B7Qoo46H3gmaBkd+9tap4Jl1tCFV0uY1x6Xem1VefISe2Cy8nr4hnrLEOqFW4cJY0hoq63FVMOqMIMS88TRnAJCXHNAwSuUM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199018)(86362001)(31696002)(36756003)(38100700002)(82960400001)(31686004)(44832011)(6636002)(5660300002)(2906002)(41300700001)(8676002)(66946007)(66556008)(316002)(66476007)(8936002)(2616005)(6512007)(6486002)(478600001)(6666004)(186003)(26005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUhWSUZ3SGJ3d1JlVDltQUJTT00xdWJJU3dMYWpYdms3NTFrOThKaGtHdUdl?=
 =?utf-8?B?ZGd2K1YrNWN2elFUNC9aQTl2c0RFRGdpc3lBN1NQNmF0eFFNOWgzREQwRElS?=
 =?utf-8?B?MXRWQ3VoNXJLbUhkLzBDWU5Xb2k0ZWhXaDdqdmZxSFBiNWNONXhYR2ljTWc5?=
 =?utf-8?B?UzIwZWRmMEpURkgwTGpMWkIycFdLdEJVWHovSmw5SGNwY2lEVFB2Tk52eTlh?=
 =?utf-8?B?MG1INVhGVHpEdG9qVzZlM1NSYXRibVdJM1hXSE1LQnNHVUFhZWJCUVk0TFdj?=
 =?utf-8?B?SU5rbG9UbmcreG9yTkd2bStzSVpUQXNacTZPamRzczlpdXlHdjczcmFNcmtK?=
 =?utf-8?B?d0lSRm01OVZaRlZPQTgrQjVNcmNGcGtQWFNkMnlnbFFQREZ6Q0FOQmRGQ1Ew?=
 =?utf-8?B?V0hQb3YveEVYcUZuRVBDZms4a1JWRUJTWUsyWmt4ZWhNNC9SREZXanlWZi9O?=
 =?utf-8?B?ME9xcW9hUjNlOVM5cTB2L0IxNFNuZWdQWVJBanFVblRrbncreXRXZ2sxTlVG?=
 =?utf-8?B?UDZ5VGVKaDhHYmRPYzNPemlOUUZJMGRmYWpZTGhXVkNncC9oaGk2Qkd3ZjFz?=
 =?utf-8?B?M1lMdUNVYTkwaU1hZTZaN0l5YkNRbjljWUpudTVkUGdQdWpqMWVCYThJdDNB?=
 =?utf-8?B?WVgyL09ZcDhEZlpBaTFvQ1Z6TmE3VytyK25vU2p3YXlBL1ZvdUlNYkpwVDhm?=
 =?utf-8?B?K0VLUFJnRmZyaWh2RkR4NndONnZTWXhIcGdaV1VyM2pvOTFtTVFSSUZtUm5C?=
 =?utf-8?B?Y01MbGkzWkgyQmt3ZEVqcDFSTmVNMVQ1M2Jib1oxYUZWekpTVC81R3Vyd2N2?=
 =?utf-8?B?eHFUd3JvelV6KzNtd01mYmt0Y3ZsMlIvWHBwTmtzSVNtckRXRDltcE9jNThJ?=
 =?utf-8?B?RWJ4cDM4Tnh6enRaNmNxb1M5cVZRZzkxL0t0N2J6dFJHYmx2NVZHRytLdVdT?=
 =?utf-8?B?M20zR1Q1b1QxK0RzbUpueWNwcHhwYTdiQUFFbXZ1aTdZcXJJTk10WnA4UnVT?=
 =?utf-8?B?T0Ewa0tOVTFSaXhBNUJrZm1CalBhZzNXUWx1dWNodXdTVmNPTUFRRWJ1Q0d2?=
 =?utf-8?B?N0VORzZFaTZ3OEh0RTNuQk4zRGFnQ3J5NXVXNjZUaHErZ1FHWDBmM3JnN1Ni?=
 =?utf-8?B?RWpodEhpS0VpQ0pHdlhnc2JwdXM1YS9lZ1BOSW9vYjdHRlVnaXp5WEU1N3Iy?=
 =?utf-8?B?THdFL1JLNEJRV2M3Ymd4OXNPdWFtZlkyR3NJOHp4Y0UrQk9oeWpOdGFYeDd3?=
 =?utf-8?B?djBqK2R2eFNWMU5YMHV2QUl2NmM2WXEyTlNpNHJyclc3Yk9WYmNnbzhVRCtu?=
 =?utf-8?B?REVxWjYwWmdpbjdBbXdZZVptM09JSU1QWElWNVVNdDI0RUJ0dVlvV2liamg1?=
 =?utf-8?B?MS80MmxtZEc0ekdBYW04VW5hUTltb3k5TGh0bzl5UG1BZU9LVGFJNW1VeVJq?=
 =?utf-8?B?N1plM3JUbnkxSitGQ1BVbVJSMXlNb2QrKzYyZm1WVWZsM1p0Ni85SmtWVzFm?=
 =?utf-8?B?ZmRvdFA3ZmMrZ0k3YnRDMGRiSzRrQ3BJVkM4cEtJSHFtd25zZ0lYaGVGc0dz?=
 =?utf-8?B?cm9OU0lObTMzZjFicjFLZ1BJbnY3NkhCMGZ1UEhWSWNGQ1kwOEJ4ZWVZZjZI?=
 =?utf-8?B?Z2JOUWROYWJhemFHcStnUGc0ZHJMNXJBVzlUNWlHVmFrS2RYdW83dUVJSlUy?=
 =?utf-8?B?UUhUMWpSVjd5V3pCOVkyWjFKb3Q1MVBXU2RhbUI0blduTmlKeFVuUWhjMkw2?=
 =?utf-8?B?SzNSamd0VjV3SDVRWWJHanJITkdOKzlqRTJ1MHkvSWdYYXBIQ2cyWEVEYkU4?=
 =?utf-8?B?c3VYQlZqbXgwMVVvME10T0c1ZHV4eVJVODdTT2hSWE4rY2ttcTlCVTAyTkVZ?=
 =?utf-8?B?cHRSMk1LMys4NlJKcjc3dHRnYm9UdjdCaThCT0k3enNHRmprRTNKenM0MCt0?=
 =?utf-8?B?RmsxaWVIbUNvaTNVQktSbHA5WFFYc0JuaC8xRlJNdmplTVVlRGxJMkgveHRU?=
 =?utf-8?B?SWVMK0hzTUk5SG5hdkd1SHVJT1RsL2FQNkJjQk4zbkQ2YWg5UHNnWlg1NmFa?=
 =?utf-8?B?eFcweUVGWmhERXFZVHdFdTl2azg4UW9iWGt3aEJiemtLdlJWQ2RrYThaNXEy?=
 =?utf-8?B?VjgvL21MSHJwUEtrMFcyWWhCd0VPdytBRmJwUnUwTUl6cEIwaS8ySVdtTVB4?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a5835d-5126-4893-aebc-08db038bfa67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:06:34.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cjsn+nRE9hP/Srzv2EKczwuJWUgdVK1L/C9PKjchHdmeWIALHDB0rA5Wti5q5QtbQ5OY4TtyHswFuSFMjXcPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 13:06:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10528

On 30.01.23 16:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This extra partition will store the encrypted file system

I thought we would encrypt all our persistent partitions? Why now just
an extra one?

Jan

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  wic/qemu-amd64-efibootguard-secureboot.wks.in | 1 +
>  wic/x86-efibootguard.wks.in                   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> index 5c41116..44f9c77 100644
> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
> @@ -6,5 +6,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
>  part /var  --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var  --fstype=ext4 --label var  --align 1024 --size 2G
> +part /crypt --label crypt-data --align 1024 --fstype=ext4 --size 2G
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk panic=5"
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index b635a8b..bad6ff5 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -9,5 +9,6 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  # home and var are extra partitions
>  part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
>  part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
> +part /crypt --label crypt-data --align 1024 --fstype=ext4 --size 2G
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


