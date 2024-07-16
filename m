Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896EFC3DA59
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:51:37 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.49])
 by mx.groups.io with SMTP id smtpd.web10.5550.1721116288940239677
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:51:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gyKQEqDW;
 spf=pass (domain: siemens.com, ip: 40.107.241.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rf6UlnsiJ4LVHybSpT/ah/m/fQgq9PwBwoC928/KID+mWZKsvA6xhygqWXcJW/GJMMfSpBcIoUM0DnIm0qClyUQ1Vy4GtMTNbyubyCLg1evPgEwvjtgQ0fHD7iyj5YrsOiUd7wFgLCVG3ntHbBUSUhA/Tigecv23YKUjspH4nXD9YfK594SVXoSdsMOxIZSACAC9KqhTnq1WnMNxDndph0T0rd4N/ZF9AtEVDAa/WK4UtSwxPhrDnG6EXulldJXCZo+NppGG9xiAD0PuLjTgcGoE9K+44PWFccboS+9DoVLyrzX7PPhvMhRadTCLJ2Ue39qZwS92L+RcGKu/4MPoHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5290GloC46nWE/yT5O55JQKnIfdkuewcPs7ldyUQfiQ=;
 b=VayxuGva3IVJVJrCyRF7+16lnbO43lLzLTqtRR2dxAcL6sarHGfzbxW9uzwzUt/VrVEhuzl6SydQxpFjSkqAU1bQ4N0OcrY0tliLSBol6zvmwPSYeXGFQshQ9X/B9UMKFpbTEmx2S2NOx6yf/mNeO0sKvpESR7gJAFfQ+nUzM3LQjEfqln1k0/D1nYaIK11HLBEIm+owh7GgbZ5ZBVNtg0qnvLDssiiZFcaY2mSxOK6aZOi0kANnLVOeOB3eX7b6wKUbxJ3V67WWw70xgcaseabmx0rpew2tGoWYWWHyaFAqUrP/Re+Iqeot3tD2ZA6N+5RvzukkZbDsnlB+n/ziPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5290GloC46nWE/yT5O55JQKnIfdkuewcPs7ldyUQfiQ=;
 b=gyKQEqDWtVNneWW2GnNdYKzZd1JrCqq2KNOCft/qwIxVQYxHJUPxZpSvASu7/J1UA+AZp12iv7/GVdj/gTePNOJuIay72Ldsy/79F0PYqdwumbwlUU5Bj4Z1CWE32r3d5ZBgJ1QkaPeQ1ZfGTdyOyswfEuFsIc2BI79atik10M2w9V7A7rGm2OzcPFxnjw5kIgyXr03dL5mIsOsvlXi2Uk4c5j8GW9sTN446fbyU1acmovHn8+BHAcrjHr4nxi0oIF1i76L9zv5z78USbLJm96Dw4bQVBHQ98bvMduKBTF2MZBfDW/kgVLZpo9NN0w69o2XNVIk8wC0AEHyw8A0edg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS8PR10MB6818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 07:51:25 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 07:51:25 +0000
Message-ID: <627e973e-d402-484d-ab9c-101d79a85696@siemens.com>
Date: Tue, 16 Jul 2024 09:51:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] initramfs-crypt-hook: Provide full losetup
 executable
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
 <20240715134630.1640160-2-stefan-koch@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240715134630.1640160-2-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS8PR10MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cfe3c0-e8bd-4ab9-013c-08dca56c17ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MlhaZTFxZGhIWTlaeEkvM1VQaXE5Q1ZDRWdlYXBPUUVpQVF1REtKQmNUSmpn?=
 =?utf-8?B?Ykl1VkhVNmtMZEY4aVpTOUN3bzViclpqUGEySzVSWm51TDQzQVZFOFpXdUMx?=
 =?utf-8?B?Q3VNcjVEd1Zzbno1TVQrNzZxaDdHeHdGVXR2Zk1ubTdmVzJQdnlkWEJFd0Uw?=
 =?utf-8?B?OUxZQWFBM3BDYUtrVVdQNFFtSUFDb2NiR0MxN2UzY05WQXp1Q2tnR1k1aEgz?=
 =?utf-8?B?ZjhXb0JQdzdZK3FJdDRwTTJtS2lpa1JzUTlHTmliRCtQWmdCdFMzWDRESXBR?=
 =?utf-8?B?ZUN5MWJrV0E4OWh6VjR6dDk4RDZmMzVqMHphcXRaSDF5aHpBSkVQb2o1NXpw?=
 =?utf-8?B?MDc0c0VqWS96TnhCeldhVS9XQW5TVlpRcGVhTlU0bG5LL0VGcFF5dUFzVU9v?=
 =?utf-8?B?T0daaHU5bUkyL01PR3FlZ0sxRFU0cVZ6RHhzYVlPTWJJdGozQ1Znb3VBZnZW?=
 =?utf-8?B?M3JnbnFGbVBlSTN4UzhYMm9pczFnWmtpckR6bVRpQVJaREJQMXIyZmpzdVNv?=
 =?utf-8?B?cEUzamRNQm1ZeFI1Wm1IV0FoU0trVGh3NGxtZVZ0Z2xkQ1BtdEdhMHV3TDlt?=
 =?utf-8?B?SFdrSk5sQWNqa1BpODdwQ2Urd0JCTFNtVlRyR1BxRnVyV3hLdDUyR2tGSkJY?=
 =?utf-8?B?enYzQlM1cUhwZXZBckxRTlhpSm9EZ212d2VvVmdtV0xwbHd3blQzeXlUbHNj?=
 =?utf-8?B?dGoxVHJuTnMyVW5UWFBPR1JiaytzMDduVkcxTmpZeSswaVloSGsvL2xWNDJC?=
 =?utf-8?B?MHo5YjRmUldEM0JmZzBWbFJjMXh4T3NiQ2kwT1p4RnpKemNVY0Q1T1lJZEdV?=
 =?utf-8?B?WmZld1dRbUtWZ2dqa1BpUERYM0dqUGh6elo5c0MrQ3NGZ0FyQ01BMkJKNjRG?=
 =?utf-8?B?bFo1NjRhN1lnZTV3SllrajFIUU9Ya1dvUFJicVdsTk90a1NRMi8venRFeElq?=
 =?utf-8?B?MW9VMmxRQlU2L3VuVTlOUk5GcEF6bm9MVG14YjhZQzZkTERJV3phbzc4R3VF?=
 =?utf-8?B?QjlISkRpangzMmFTSDZxRlZrV3hmUDFnTlUzMndHZ3Q5WlMwQ000NFRwVGkx?=
 =?utf-8?B?RTR5d2VyRFFEK2VCWHM1WWpWR3ByN0lDUmptUE5TcTVQQWJaU0NWVjgzNmwr?=
 =?utf-8?B?R280QWFOK25nK3FFYVl4eGNKZ0pEdms3a0JXVDVwSXZUV3pOekNad1l3SU14?=
 =?utf-8?B?ZDV5YlM1eWVxdG5MN2ZHdUFyaXQ1WjVOeXB3M3lVY3dqV29OL2lXeXlUd0Mr?=
 =?utf-8?B?WVZrQ3cyY1VEN1ZDZHlDYUxkLzV6RkpZTGdtQ01ReEpmeW5vZlh1NHpnS0pP?=
 =?utf-8?B?Z1pUNHRoRmdJZjdKVzhIMWxzNmcxZlY5YnhsQ2tFNlFYYVFRZjZvV2xuTjU4?=
 =?utf-8?B?cDZtM3VsOW40NGlibkRZNnNQSWlUMkdxd29qeGhHTCtqYmdPVkFsQ3VtSThl?=
 =?utf-8?B?TFBMYWlweXFpSCtYdTcyUG4xWTQ4ZVRNRE1ycTV1Y3dHZjZvRW5yRnZCUWlj?=
 =?utf-8?B?TVFHUFR3dndWWWNrQ3BnN2xkaEt1cVNWeDR6bjNlcllnN2RuaWRuNDhEeEpw?=
 =?utf-8?B?TzFoaHdRSDlnSEM1ZWJ0TUcvZE1Jc0piYnByRFFRaXlFL3JRQ3hZZDVMR0Zt?=
 =?utf-8?B?VjBJcFBhTkxKMkFUbUdlbzcvZUl6SWlwYW5vVEhIOFN6dmRuWTZGQUZQOGoz?=
 =?utf-8?B?N3VTV0xhakFFMm85cmZFZHFQZ05HMmxwRytFVHNObENjVWVtNVMrWk9vU1l2?=
 =?utf-8?B?eGRTc1J6Rm9kdzVHVzdtYmkxRWxSSk1oZ0hjanhxZVIvc3NHdnVIWXpYYWpk?=
 =?utf-8?B?V3JtTzhMTGhaSTUra0pzZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1FXeE5vSlViWkJORGhnWXFpVkJPSEZUaG9MU2kxTVRxaXp5TlhnUDJvY3Bx?=
 =?utf-8?B?a1RJdDVBYnN0VEIwT1F5aUpiTDVGNmVMUnQxckN0S09jY28rUDlDcjQxUjNz?=
 =?utf-8?B?UktNMHRneXRmWDM5RExHNFllT3kwSitPclZRb2Uwc0FhdE5WSXZkUmtiK24z?=
 =?utf-8?B?UWQwaFFXeEc5SloxWFNuOXJ5eVExMGQ0V2J0dEVPWXhrbS9rZm1rSi8vU0E1?=
 =?utf-8?B?b1FYRFQvdFdIUG5YeGZuZ3llSjdqaENadzhyQXZGVHl2QldMRHF3T2R0ZDRZ?=
 =?utf-8?B?ZmZTc0d4RFN0d01iVUh6bFZLQ2hZTVdRYkpKMXFSdktNSzlsamgrbVV1dGVD?=
 =?utf-8?B?a1djSGdCNDZJQllWbHV3WFlmdEhncVVCbDJoNjdkRmlVWThpa2NlbUdNVGt0?=
 =?utf-8?B?b09CTXVBTVNMVEUwS1ZpZ3I0SUM2bjJHdEMxcFEwbndMZGNDNURURlB5MURY?=
 =?utf-8?B?VGMrdVhoam0zaS9CbEpLajIrcDdYL1Z2MyttMTF5K0dHbDFkWTdUOTJhYzJB?=
 =?utf-8?B?anQ3OE1kdUs3SzFlSVBZaUJja1phTFBOY2tJSHdHYjdUdkJCT1ZxSG5Ka0Vn?=
 =?utf-8?B?RGFGa0VqQ0c2OTVFNmJBQ3JQQzk4R2s0UFRVVXZBbjNwRmVFNnpCdENDRFE2?=
 =?utf-8?B?L3pSYWU4QUlSWVJpTlRJQVJyTDluNFZ3LzhCd3lGMzhGKzNIUnR5NmJMdENY?=
 =?utf-8?B?d041c2szUCtEV1p5ZmNaNE1YTVpUYkVSem5rWkxhdExQM0dxb3BIY2RjVzk3?=
 =?utf-8?B?dUhtNFVoeTZwTDZZeDNySkJ2UU9ETmE4ZVR4RjFUQWxMU0pUS1FsdEtHeHpK?=
 =?utf-8?B?d0hycDFuL21IcnpWb3czNzdlTEdVeUk3eTVXWGNuanVVTjlCT0tKcnRLL3k5?=
 =?utf-8?B?dk00M1I0WVc1NDNMQUd6TTZWN2g1cjJ5YzV1dEdlOUZlWTNhNk9GektzdUJ4?=
 =?utf-8?B?bFZ6WTgxMi9GT083bXBZVGp4OVFEQzh3TENxYjZhTTl1S0lYVXFTQktBa2xj?=
 =?utf-8?B?TTBBamJDMTdzRk03RVJWdU5xKzl5YmhWUC83ZUp6dWpQVVBWbm9ZdVFYV2Ju?=
 =?utf-8?B?MHdaZWg0RFRSeENEWUhEWGFNSnVQRjJNMnBPMTJrU28zdHg3UkU0dlRHV25v?=
 =?utf-8?B?RnYyOEdJU0IvK0I1dEJvbzFzUjBIOVFuUFpKUkFmN2Vqam9sR05RK3Y4ay9i?=
 =?utf-8?B?TnMzSkw2L3JiMkYrcUNqdXJzOGlPc08wWk1pbm93czA5RmtrTFRJaHpQNW5Q?=
 =?utf-8?B?OUdqRTIwZTJsQXltM05CQ1RQQjBDZ1pXQzJzWlErMExoaFBPVGFhRkNGd0lJ?=
 =?utf-8?B?VndXQ3RoaVBzYzB1R0IybTRHT2VJK2JLL0tsZ2xYek9sVC9yckpaSVI1L2ZR?=
 =?utf-8?B?dmx2d3lxV1E5aVRpQnE1Z1U2TlovSTAwWjN3WHJFZ0cwcmJhRHAyQi9SSWlR?=
 =?utf-8?B?b2QyTEx6UWNoWkNleU92N2I1MkZxcStMdDhvUm1VVTBuR0EySVRZTlRJay9Q?=
 =?utf-8?B?SHlLR1BFNWhacXZxTit5NnNXbDMvT3B6WGVuWkVLeG5mYTJoMmVmQUxLbnNh?=
 =?utf-8?B?czJZYnQvSGdjVW5LWlZGcnZodG5nNS9YUmlZOGgzajhIbDI3TWdHbEh6RlR1?=
 =?utf-8?B?Z0I5cWUyUndYVlJVT2NWZUFnc0VERU9OVDFkMG1seGVSSTVXMUpHeXVUV2dh?=
 =?utf-8?B?aFhqRjhFUytJVXRUcHoyYncyUzQ3cG10NmxEejY1bDUvNlBVN2dQdFVKQ0J4?=
 =?utf-8?B?RlhvU0VxL1M4QU9hQmlTVGdmcTA5UEpFNXZINER2UnRDMS9FVmtMTG5odVZa?=
 =?utf-8?B?VFVXU1VHNmRXeWx4L1NsVW1PMHBZWUNyczFTZWZkZmRuSlBnV1RaZVBiUHhw?=
 =?utf-8?B?SXJ2Sk40WVFQOUJWMllyTlZBUDkrdTZhV2FWZTB1anNhejExZnhrRE5yK3hC?=
 =?utf-8?B?MlFybEVXUUFtdy8vZnNCU09MTVJOM2tBL2VYNVp6anFqTzZzWGZiejFkRjYv?=
 =?utf-8?B?eGZQdU80ZTVzc1VMSE5VQ0x4Mm9VVGN1NkxldlluK0J0aEdhb2QvSnlmZis2?=
 =?utf-8?B?bjJxT1pvb0JNMWhzczk3Tk95NC9mN2VWcTNSbHh3U0hnTVJLTERmYW93UUNw?=
 =?utf-8?B?TjVNRFVOLzRKTXdpMm9Qd2RCWHNMY1VGZDQvK0orRjZHZ2NhcEZGMEU0UVAr?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cfe3c0-e8bd-4ab9-013c-08dca56c17ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 07:51:25.5663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REWj7TcWHRgpxW0lTnkbkItstmwwDXVcT/DcCZfmCU6Ijy5KxIxnHsAywzLNSeSnI0N2RX1pFwM+K6wGA8QUGEGd5CtWAeS3tQ/07NmqK2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6818
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:51:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16499



On 7/15/24 3:46 PM, Stefan Koch wrote:
> - Avoids using a busybox losetup executable that
>    doesn't support the "--sizelimit" parameter
> - The "--sizelimit" parameter is needed for introducing
>    speed-up of disk reencryption with the following commit
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>   .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 1 +
>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb            | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index be8c117..1e8c74c 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -47,6 +47,7 @@ copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>   copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>   copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>   copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found" > +copy_exec /usr/sbin/losetup /usr/local/sbin/losetup || hook_error 
"/usr/sbin/losetup not found"
why copy to /usr/local/sbin/losetup? please don't add additional paths.

Quirin
>   copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
>   copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
>   copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 72de5b6..3497d95 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -9,7 +9,7 @@
>   # SPDX-License-Identifier: MIT
>   
>   inherit dpkg-raw
> -DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
> +DEBIAN_DEPENDS = "initramfs-tools, mount, cryptsetup, \
>       awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
>       libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, \
>       e2fsprogs, tpm2-tools, coreutils, uuid-runtime"

