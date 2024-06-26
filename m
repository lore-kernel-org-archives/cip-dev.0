Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DE4C3064D
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:56:41 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.71])
 by mx.groups.io with SMTP id smtpd.web10.27260.1719410200066413470
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 06:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OLuupmYA;
 spf=pass (domain: siemens.com, ip: 40.107.21.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbqPjbzsPZ1ZN81Sb0c720XpHhIVXDgnRx+8JdB4zpZvGSmQ9hpNHU8dw2qraBo41fOIqpE84/bMR2x6Z9d8GJ69kOvx1YdE/+i7wXmCP6V678+yCnONRlb2mXfVD8qjAk0n7lvogZ1oHSj9zx+HfjNBR7f6W+DOaNgWnHGaG5LyBMGv3nWXPqd6DVDushrvRY1CtboDsFtlx51k5CHrOU6DGH8iwFizNsrcsrlE8c8cjvH0SIhH1NeEFs1ehpAffICkE0JzRIwyZM9mi4tW4I+fZ3qGlJchxe5yn3iBPEcDxtK/ngpridcRKfEev05GgIox2uyna3KioOjt2erJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfVCduh3SsfvkBJ0249zy/rjgtaHAyovTR4vOvp5kus=;
 b=JNaT+ZCcMQzDED05s6VjRwohWqQRpbslko1VPwnxK/Lw8RrgDraFp5s2LggLE6ISHwRZtejnMffdJ5YB5D5iXa6tuoWnJtM309A6wU5x99KhijbaPKcU5b2mhtoCjMunD+ziMUxQ7aZ81CIB9S10ft1VU/URbuIUlQ8118d6AGZgxtnY2Up6esfwLlnoeBZ1lTx2Bn3tmZAgL/NAdrsR/pRDMyTlDqazGchUOL3+iYHgITDP6bFJFV9zNW1dep41uBQkvGrhbH9/txkYGtPInDzEbyNMa8o9/64Rd/x7Gb8QCGaeNBJ6nuoXDUXE14bbqaUNeVRnbyFbwk0504GA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfVCduh3SsfvkBJ0249zy/rjgtaHAyovTR4vOvp5kus=;
 b=OLuupmYAfxgktx6CMWiDRheaVbcffdFLU3ZrjgHr9TeoTO988Hx/nYf1SEtnJ9TCCrKhtQZGukDrhXwSexaIE+gjAIqoQq7E5P97mUjQHseabBpcU4CPU8X/Yuh7j7G3EtDIEn5wDXs+dWOf6sjp/KnQjjEj9uaaPxVd1cCzYt3+cthNJlCulsscVU8tf0jObHKjl99aX0I7pl3axxEqM5tB9QDt2dfqwdeeaB+CHUWHU8cdnpxxbR/ReTACpFqFU8ikO5ZJbsEfz6bxqi1f+tpCLPTQ7LtgHPKhKB0LkDrTZ6gK2oLMkr/6pp/rE/EojcPrumtIK8sSCN+4yIg9WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:56:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:56:36 +0000
Message-ID: <0fc2eb61-c41e-4704-a329-a14b0529a1fd@siemens.com>
Date: Wed, 26 Jun 2024 15:56:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/2] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240626134141.74487-1-clara.kowalsky@siemens.com>
 <20240626134141.74487-2-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240626134141.74487-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6a6871-4aa3-4e12-7a93-08dc95e7cbae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2NTQWFaTUc4KzI2am5IMVZJeEJ4R1VBd3ZscXI1aUhsWVh4Q04zSnJKTGdX?=
 =?utf-8?B?eVhEcjRnK3dNWGo2V1BVQ0V0SmZGdFdGVU0xcW43N0NOSDNBcXlLbnVWc1gx?=
 =?utf-8?B?TVloUDR2SzRWeHdxMlVDVnlDTGNST3Vhck5pNE5mbXNPQjRUemp0bk1oOXJR?=
 =?utf-8?B?UHF0RHRRaDRNMWZZNkNud0dKcFl0MDVrTXUrZHdvbE56TGdYSnJoK3BqMHJW?=
 =?utf-8?B?QmxKQXdIejdkTnZ2UThkSVB1K1lVZmlHMzJveUd3N3JaOEdxdVlTcVpiSUJ3?=
 =?utf-8?B?SnVRZTFYWHFDK09zelk5b1h0bDFUTHRpVGJnNHJoTGJsTzJqZ1V4Z2RQV1Fj?=
 =?utf-8?B?d1BLaWxvZC9ZR0xFSGw5czdjMUtRVlF3ZDVQa0ovdXRDRXI4VkFRS1A5cUxV?=
 =?utf-8?B?bFQxMXluaW9hU1JidTdnSUNzeWlOWk5kUTlJMjdTazIxZUxxcVRwaTJHR3pp?=
 =?utf-8?B?UmRtZFNQQkUzd094UjI0aG42aGhRdXZnbEdiVTZ3TGd2VmhGdHV6Ymd2V0pS?=
 =?utf-8?B?RHM5NDlhV2lkb3g3bThzSmpxVVhSNDZxYTU3czhLeFozK3Y3N24yUjFoT0pC?=
 =?utf-8?B?ZTcwK2d5L0xCd1Y2RzJHUHBLdFJMZ0lQbjJJN3dXQVhDTGQ0TzFaSWxIdlVk?=
 =?utf-8?B?SHRLeHhqOENHY05TMmh5dlFaUWpSRzZMQ3NXcVFuM3FWRmVaWTIxRTRsZldP?=
 =?utf-8?B?T2RVV3J0V1pzZS9uRlJMK1EzUG1SaFNLbkFqMTljSUZZZ1c5YXpzUklnK1lv?=
 =?utf-8?B?RnpGRytwVjlTWE5sNFczQm1wdWF5YjgrSytXUXNFNGE1Y3pqMmNqV1I2OGdt?=
 =?utf-8?B?dG85R1FpOXdNUU9MWGkzVmgxcjVMVnl4TUlxNDNNM051TisrQ2t6WitVSWho?=
 =?utf-8?B?a3dpWU0zaHVuYmZXdmNCUHRvazAwczYvZnlCR1RnZEp3blBwdUY1eEpsa1NO?=
 =?utf-8?B?N0tUVExXa2p5YzdpQ0tJTmtGRE5rQU5IWmtudWVwUGJsZmN6OEdrTWdzQWV4?=
 =?utf-8?B?QVNqdTMxYlFMOFgyT21Ka05pK3J6bTBkbEQzMlRVWWl3WWNKNktzZnFaZ3Zk?=
 =?utf-8?B?cldRVnZtUUdNbVBydnNxb0dIb3dhWnExcS9IRnlpWS9hY1Z5VHV6M05wcDFu?=
 =?utf-8?B?SGVYakpXSEtwUVg2UWYxWjJqWDJVOVltSWRxd1VqQWFWYkoyNFJDK1JFRlBN?=
 =?utf-8?B?NlJrcjQ5WWxtZEVzK2psVFNyTzJ2Q2I5MG5scmg2QXpRa3cxam1LbGRUYkgw?=
 =?utf-8?B?UEczQjlHWVhzdEhyUUF3azhhdWtzMnlSQkNacnVrOTNVbFVSTXVBTUVuOVpK?=
 =?utf-8?B?K3Qzb2JJSWwwYm5JZXlDcGlkbVYwSmdHVWlQcDVERWdxamVTeHJjZy8zSUtr?=
 =?utf-8?B?bnNrZTRHKzNrU2dHaDVtb2tVZzE2dEVOWHh3RGhaTkNtazdkYytIRkdvRnZC?=
 =?utf-8?B?M3Nwb1NjYUx6NUd6UjJaa1pTODZlYnhjNjAvU1h5QW43Qk9QODlOOEpoc25J?=
 =?utf-8?B?Ukk3TUdpblhlK05wRlU1d2RLWlNsQS9sc0MvK3c2c29zemdGdFBVUklzZHJ6?=
 =?utf-8?B?Q0xPTk1abWdvWDhSSWpTL3BTaUQ0T3B6TDFEaG5pR1hIN1NzMDRZcEFRQlZT?=
 =?utf-8?B?c1Q1aExkZWpIUFM1M3BqL01ORFFnK2RPeXZDYmdJSXh5bDdXUXUxSzduRFY3?=
 =?utf-8?B?ek1lMFVOKzl0Ymp2d05CZnZ4UFZKVmlTOU56QnFUdGNmN3NtbVZOWlRuQXk1?=
 =?utf-8?B?NlVTd3NMb0FSS1BPVjc0OWhCT2xONktudC81cDZ5dDJzLzQyMm5oUS9FQmhv?=
 =?utf-8?B?Nk5FaEFFc2lQUy90MTQ0Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTY3VVNkOHhWcURrQXpIcEZLTTVSTU11ZUlXSExJTDZEeDBNWXRIdkppRXBt?=
 =?utf-8?B?RmZqNjJBQW5LYTNSSDQzNzVnZEVaZ0l1ZVdpVTZTT0VWZXFXQWEyUGppL1VL?=
 =?utf-8?B?STZra3p4UXhsWHlYVksvSDZYUjVHVWJoRGxaZWxzeG1QTVh1Yzh1NzlHdGVq?=
 =?utf-8?B?TFc1dnI1U2lSM0pEQ2hTZTBUNzlKR0hVR2JuNHV6bWMwRTJDaDlid1R5aXBR?=
 =?utf-8?B?YlRZTmUwL0dQTi8vd3ozR1l0M0pwQnZKNTZPSmpqWDd6UkJuWXQ0ODlGV2k0?=
 =?utf-8?B?NFNZV05iSUx4VldaTnV1cjNmV2VHWXA5WmlXRjlJS2dvSXgvbUJtTGJoUE4y?=
 =?utf-8?B?YW9iQlpEaW1JTjkybitVTE1pbUlBNDl1UHJhMS96OWdubDhubzdZR3RKOGJK?=
 =?utf-8?B?NzVSdzYzUmFIMWcxVHhoS3JrM3kySmExWGNVc3FlRmo0aU5yallHUEVyNUFK?=
 =?utf-8?B?YW12aEVHN3IyQTFEWXhoaUovTi9YTjhaVVFya2ZDRFZDTmxENzMxWWRWbTBV?=
 =?utf-8?B?T2RiUG5zK2xNcllWVXJ3NzZIYlNsem5WK2Q2Q2kvajRBVnJjZUZueWYvUVBy?=
 =?utf-8?B?RUo0NnBXSVNjRjlKZ20xUDRNRHpJekl0bzJGaXlLb0c2OGtIK1F3WCt2a21u?=
 =?utf-8?B?NG9QM3V1QVExYjZmR2lndGRHVU1lbWJLL0pPOVpTbFdsNnBVMElUTnNaWUNB?=
 =?utf-8?B?dlg3QW5UTkdxcGM3b1ZkMCsrMjRRYkpuU1BRTTBUZm1HWFN6RGExYVV1ODdm?=
 =?utf-8?B?eWtuWUtFbmljWUMrVUxicG9HN2Q2a1lUMTExVy83OTRmVkIxN1BaMnBUZEtZ?=
 =?utf-8?B?Mk1aM0JBdmtTSWVZcENpTU9Ba2tZYUlCWVVnUXZSdmhOUU9nRUp1SGhUNTNJ?=
 =?utf-8?B?VXc2WmwxczVnVXZic1ozVnhXTmUrRDlGVEhrU0VTNHJ6NktUSVZtL28wbXE2?=
 =?utf-8?B?NjF5dloxZ0dpcnVBKzloYXplWDhBODVGTGdocS83MU9WM1YrL0IzL3RnSWtj?=
 =?utf-8?B?bGRPTDY3eFptRzdvSG5XK1ZJUU92QmxMSEFWSkNwZFlDSDYrcVpSbzV5SUtO?=
 =?utf-8?B?cytybnNFKzVnQVE1VzNzYzY5alNUbjA0UVk1UXZ2eW1rd0pHaUdRVFhZcTRT?=
 =?utf-8?B?djRUckVUZ0plNTJmaHdYRFdoN1BRWWJYOWhOTjhVcG5aWVVXb0pTWEhVL2Er?=
 =?utf-8?B?VW1NM1NMZDJlc0dHUjVra0lRQmd3S1VvcTRmaGJ6N0R1a3RlZDRWdUZMbWNL?=
 =?utf-8?B?c09vSzdVZmE2ckxJZ3VaY1NPb2ZWeEZXRHpjZHRaa29CbDdyTXJVR3lYamQ4?=
 =?utf-8?B?aXRvdDA5dXJ5aUt3ejlnVGdtTFZ1eERDNnQ2UE9laGthdmFDK1NvWjU3cFEx?=
 =?utf-8?B?OXdVWmN4UGVGNUFGR1gvVUsyTEc4MjdxZWJKMko4cWlpYmJTVkNzbkhlR2tR?=
 =?utf-8?B?dklJV1FISm5TajRHS2V4WjdJQUtYSFdQUzBlT2h6RllyRlgvR3lWeFdMY2ZF?=
 =?utf-8?B?d0dwRmJneUhadXIvdWVRcEQxV0ZrOEVBV05hRWo3NTVRQVRyY1VrQ2FVMVBT?=
 =?utf-8?B?RzVZM3JqTGVrYzgyNTg1UEJXbWZPQXlMc2lyWmRBcG16Z0RvMU1Pdlo4N3FI?=
 =?utf-8?B?M3BQUXlNbG9WTmZVdjQ2YW11OWdkZVl5aFdkb2VMdHlRdkRrai9NUGRmY3o5?=
 =?utf-8?B?dUtVSzFFZ09XOWwrcC9lVW9VS0hCMHJzOXVxYitsd25DcEJPTE5hMlhYTHgy?=
 =?utf-8?B?VExZMDk1RTY5Wm5pQ2NxWktXV1M1YlAvRkZqRTJKVnJlTVJTSmtHSWJhamhN?=
 =?utf-8?B?djY1VkdlbGFKQjJmMlZtMGRPa29DcDl5QzJ5WkllRjhqUHdoeVliMjdpdjhS?=
 =?utf-8?B?ZnVWa0d1TmNiOC9hTVJwWml3cWVncTFZK0xvTUhMYkRtMWRQMWJ2ODg4bm1P?=
 =?utf-8?B?UEFpVWpDRExzaDVqSHRobG9wN3prOW45WFV2RlRnSW52WFBQU24wYWlaL3l1?=
 =?utf-8?B?V1hKZTlBQmxNc0hra1VqRHo3Mit6akhwbkNDbUdPMytPbXVhRHArUjYrZ0tr?=
 =?utf-8?B?SU04NkNiWTNrU055UWs4MWg4T0JMbVZmVjRVcitzWFQ2cjAwai9reVRFMzRM?=
 =?utf-8?B?MUt5UmtuVE9BeFFuY1pSVFc3MFl5ZFRmS3dsNWFadnFVRzcrN2pjOERRT0x1?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6a6871-4aa3-4e12-7a93-08dc95e7cbae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:56:36.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+IKaOZpi5R+2DJnPVknaw5Id1hEkBR7rpk0EhvzSK2sPuWBgr46vsAKnuFw+Fj7Kt9SX5ifrSAJTVc0GKsjUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9156
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 13:56:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16332

On 26.06.24 15:41, Clara Kowalsky wrote:
> In case of ext*, this detects and fixes file system errors in the
> partition device before doing the partition mount.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.hook          | 10 ++++++++--
>  .../initramfs-overlay-hook/files/overlay.script.tmpl   |  8 +++++++-
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> index 8b00ecf..1a54853 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
> @@ -22,6 +22,12 @@ esac
>  
>  . /usr/share/initramfs-tools/hook-functions
>  
> +hook_error() {
> +    echo "(ERROR): $1" >&2
> +    exit 1
> +}
> +
>  manual_add_modules overlay
> -copy_exec /usr/bin/mountpoint
> -copy_exec /usr/bin/awk
> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 42eb59c..6b404c6 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -34,9 +34,15 @@ ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>  
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +	if [ $partition_fstype = "ext*" ]; then
> +		if ! e2fsck -p -f "$partition_fstype"; then
> +			panic "E2fsck on ${ovl_partition_device} not successful!"

Err, this will break the boot without even a chance to go back to
factory state, no?

Jan

> +		fi
> +	fi
> +	if ! mount -t ${partition_fstype} \
>  		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then

-- 
Siemens AG, Technology
Linux Expert Center


