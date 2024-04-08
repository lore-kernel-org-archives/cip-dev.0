Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E8BCD1292
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 17:40:23 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.128])
 by mx.groups.io with SMTP id smtpd.web11.113775.1712598016240571244
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 10:40:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EgBy8Zqx;
 spf=pass (domain: siemens.com, ip: 40.107.105.128, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE1f65vne7sicHMRl4T88QQpiC1F7p/oKFWT1OVbMdaXvm0zlA2si6lPLmOWUK5SLfoG16qKW04Fh1gsf7uGVhIc6pxnSr9IPMiy5neYYt0cL2JdWdVwipEIadiCqB8srzwVNmLyjWhKQkkDgBxHRy3kUKSEkIs7Jr0fCZWSQ0f5+D5UonkZzo9+3yQcccByMNspAmATLyw1TJ7n7kqW3QCpm3bUTNwOkWbbANTBN3nNw6J7ZoUvj2Lz91qtqD81fB9cAClnIHHD3Cl2k0AAGK2WMCDpP8jIYM5etR/hJyuHH7zBuxVC+jMnHwyEOwu/GctOtwICSmcaJApacNULyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3kw6703SPccnzj1El90GyaNJ3RKCcUd4FA1btCxcU8=;
 b=Mk2cYjPjd0VrIfFPqDY5bKoAOVPQWP5xdphPiR/Dobd9e3SQ07HSzLx8XAwvf3SrOz4EXwZuq24DdtTI0ypiSgf9Qkg4uOXym4BNsitCD3UZApGLd6BeePPg13nBXzgXhEdaLg4KpRlvO2azR2B3sJwAhlp5Uygu4faKXw1CqWgRaxo2L3hEHOs9tvow+j1vAiS7h+Je1apy+J9uIGIX7N2Bdjj935RlGdXCIWGFs50wsb9DY/dd/7Zca+mNW9SaSxnzIr4ng+PvV2yECHqzJxqwbBwcYeVuNREMy8WJ/siphMsjYepsVoO8KhbFAmGrHvazqverL+g2dgfeL5/UEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3kw6703SPccnzj1El90GyaNJ3RKCcUd4FA1btCxcU8=;
 b=EgBy8Zqxi+2RtKNk2YBlvGC6j0lv20RDzA3AcLd7OGdgLCSeoR1owujo75QQUjwNPSUBMfW+ax3r6/PgzJJRYnhrDKcPVOTTuYOjAX3LzXoCLjeTk13viuqfq9nKUpHEzbSoszu0gzaIK2RLPNenqaNzWkdv2ySrpZoooDLdk+UXKjxcsqUlMS2kL5XNWd4PcoV+K9pm7/3ltvoRl3oZTWGug+0H84DSvq7MujRE5IBq9hNpmrcP1ythRkMxiD7E84/mjv7yXW/VXL8xwJQeatei3jWO39HWybipcjCPsyjltWORXB1OlINezX7flwV/fRu1CfzHnqb/D9ezhiZGAQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 17:40:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 17:40:12 +0000
Message-ID: <629c8cb7-9992-4b45-9983-44fe9a530be5@siemens.com>
Date: Mon, 8 Apr 2024 19:40:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 00/13] Rework disk encryption
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OSVhQ+3DXzl5NFKSogg0b6R2uAIaeNYuK58y7xLuaNT30Z8zMIvqhrQXwWoXrldYE48EeLxs/5hhBdf4PD8jyW4FyTA8mMs/X0fqJYpRnJZ1HjiUpUm8VnHGahkf/5DeG4ZPVo7RuSYPNpLq7WjhqUgkd4GTBKoXp/KDaHSFE4p/CDY+Pv/Iheh5+uRMQDQet+oHU73HGaouyS+ktetPOzM6XYqOe/ehOlrgIt4WPgeUa7R73VpYu7E8CUCVfvLUWAma4TdR8R7Wgq2asTIPI2CTn/dixiAH0dmprq+DsEyp3A0qe9D1ZQKBCIPvrsULBalxqLB0GHJau8YBfdW5Zd2OkYZaulDr1cCtMCzoDIEYs4+maRoNSN3exwVUjvTK3rZzuCw8CZIqlC92uujwrVuSlSQPn32znzA2lKmL9PbBszmCSG4tbDbDR6PfKHnL2x6I3aJsUlVu1ZLTn8hYIkKYKbkBdUxkbkicK3ICob92OkGctS2NfxYNk78tgHTYFqGkj/DI/fU8zUwOkFh2DozPuptnbyE4PIAW0LoBcm/n704S6yf44qZQZnFZXOgWEyRzOfPPuAdmW5ZO8xLO1Oiqp6z39P5VP1kXoNcfpChPwLOdnZca/9urHP0PgQMyAuHQif+loIBtFeFWzEwxlsAm4WDeRcfmGqNPf1pyBOU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzV2MU5DbGFkR216Q1M1US9zdnFmelVGcTVpNkltTkN3RXhyVlorbUlSU0xU?=
 =?utf-8?B?ci9rMHhLbU9wQWt6aUhQaGdEcDN0K3VIV3FZeCs1R1N6SllpM3lmWDZiYzl1?=
 =?utf-8?B?MGU3Tk1QelBldG52VG40TmRaTFJTVkpCMXpic1JqYUpiMFV1OWJ0dDBuVFRX?=
 =?utf-8?B?Q1hldTNaZ0h0aUk0TVBrZUIrV3dJV3dxTXFSanJxVFd2bXREK25uaDlBUURB?=
 =?utf-8?B?TkpJVjl1dE5icUZZL0VzOThoZnhHbGRZTm01OFNPdGhGUzhPb3Q1WW54TVhS?=
 =?utf-8?B?cnV4SnpHSjY4K3BEeDZGcnZYMDE0U3B3WkVaVldndmRxdnVwOG45WTVHd01M?=
 =?utf-8?B?c1NoQzZrVFVqRi84WHd2YlpxZGxUUW9rSXFXRmgrN0RqUmZoUUxpMCtMOVo1?=
 =?utf-8?B?QW4xM0F3dmI5V1J2NUpkbUtFbGYxZGpuVnVzMHByQ3g0MmVib0x2QUFMS2V4?=
 =?utf-8?B?MmtQYmRQTUVvMExhd2t2V3JOcm14RzJqNlZZMmpDM2psN1VhNTNZZ0xiWWtm?=
 =?utf-8?B?UGVuaDFnZEdPeHBLaCtkZUVnZnRlOUZ1WnVTYjBCVVFoV3pQTzYxcFJ4QkNl?=
 =?utf-8?B?L3hBUW4yVjM1RFZnamIxR2ZveUtzY2Y2NzJBMTJ1RDhxcTBYS2tUck1qNGlQ?=
 =?utf-8?B?a3JHZUV1MWVtYVorWlVTN1RFZEZmbXF1c3VDanVMQkdhNFpodERkS2U2dXBz?=
 =?utf-8?B?QzZZREJCVEttb2xJRFRNOXpUUG9adDhhN2FLenp5MVh4YlhZMVNaWm9LTFAw?=
 =?utf-8?B?Z0NLNEdCYTZPVXBUdXI1L0I3T2pJTUtpRTRhRW9xcFJWTWdFVU1NdHhCbFNk?=
 =?utf-8?B?aHplYnNoaFh5WG5vNEErek84YmJhSmQ2MzhvanlWSytXU1k1WlhxN1ZnZkVQ?=
 =?utf-8?B?RU10Zm9OK1F5eFdFWkcwaWF4Z3RNM29yQnh1WUpCY2RDN1NDbzNrbUZVdnBG?=
 =?utf-8?B?M1pMMDZ5b1FSbEF1RTVwbytadEwyS2hIUWtMc1ZlVzBodDIxeG1IZStCOUdT?=
 =?utf-8?B?N0hWcTMyN1lWTEdkMC94SitwL1I3cTJtV0FBazdFRlN0Y281WUY5dXZiTGR0?=
 =?utf-8?B?ZnBNVHRNR3hFUFhmRGJPNW5sQWlFQWFnRDB6YnVRLysxaXlqNGJSbGFHODN5?=
 =?utf-8?B?Zms0dElERDVoT1NTS1VKeGY4THQ3dkE1QnFRNTh5UkkrT0k1MHhFeWplaWVC?=
 =?utf-8?B?QXdQdFZRQzNwbkR0VVFORHphZ1JoakxQQ0NtOTJVeW5XYm5mSGtrY3lXWnZl?=
 =?utf-8?B?NGlYLzErRlU4eU1vNzBIYkRNYXJGVFJlSHJnelcyWXJhZVl6am1UcTd6SnJz?=
 =?utf-8?B?bE5yeFdkeVcrM3ZrZW5ocGtZemdBby9zaCtFVXMrdjdOeFhHRnJ5YmVWRGla?=
 =?utf-8?B?Y3B0ZjljQVRCMlBvaWZwNjY3YjlXR0pKZS9DRDc3dThJa0xFaFJ5c28rd2lw?=
 =?utf-8?B?b041L1pqZFdzaWh3K1gxREFQV3p5RnVQK2xKaEZoS1NWUUVSaEltMXpUeDBJ?=
 =?utf-8?B?N3hVSkpkbnNYZm5aZVNtSnpYc1lBdE5JeXNwK3NoeGMxbDN2YURiVjVIY3VC?=
 =?utf-8?B?RVFVYzBsT2lEaVJKQkFDMzhVeXNSN0dvNUQwZFBDYXZ2WVlrSkh4MUJTSmox?=
 =?utf-8?B?NjNIaFgrNENRWk1seGNzVWhWMnUycVNROWJWMW43Ri9sblJsM1Vzc1RNM0Q4?=
 =?utf-8?B?L21vSkozWm44WTlqT0lvMysraGxOUmE3SEF6TGVablBDMVNhWXFMZkthN0N4?=
 =?utf-8?B?cUN4cW93Z2NESzVzdEVocmYrRlJOZ2UxRENWbUduS2grbXJXNnNFU0RRd1Jn?=
 =?utf-8?B?czVULzlJa1orOGRaNHJjTTFjNzB1SzF4aWpHeUI5OGorT0NUeDU1bC82emxR?=
 =?utf-8?B?bEdVVUQ1Wm9VQ0FTOStpaDhieWx2bDUwR2FwZzBLaXdtU0hXZ1E3b1Y4aFdI?=
 =?utf-8?B?cVRlSmJvaGpzcjFFRHJaWDZ0L3V2TnhFeEhRdENNWDhxTmdLN1FONHgyb1J0?=
 =?utf-8?B?Q3pYSzBxQzBZcEJmMmZxY1JMTFp6QzZwbjRLTnlNZURWNndpa0d5ckFyNVZE?=
 =?utf-8?B?SlN5cERJK1dNaGVZZ2JLSWxiSkJKY0ZWMmk0Y2pjVG5ZNEJ3aWlCdGtGemd6?=
 =?utf-8?B?Q21ZRGN2RG44dlVHeWZ5QUljK05pOUJtTmhwM0tYRnRZTHhVeVdBY2kxa3FQ?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740ede88-c344-466a-04c3-08dc57f2f13f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:40:12.2177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CBjEfBXZgZa7nN6k23yndifEYhE296d16RUZk02S6EXEyKAjPRnHu2l9xT2wvb5xx7dK0wR0EOk2OzrO3QVDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6943
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 17:40:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15507

On 22.03.24 11:05, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patchset is a cleanup of the initramfs-crypt-hook:
>  - Aligns the systemd and clevis implementation
>  - consolidate script in a main, clevis and systemd part
>  - split clevis hook for readability
>  - Adds some checks for TPM parameter
>  - Remove the dependency in the overlay
>  - Adds an example to encrypt the rootfs
>  - Add readme to switch from clevis based encryption to systemd
> 
> 
> Changes v2:
>  - fix typos in commit messages
>  - some fixes for Debian buster
>  - split clevis hook for readability
>  - consolidate script in a main, clevis and systemd part
>  - Add readme to switch from clevis based encryption to systemd
>  - Increase version of the hook
>  - The disk encryption now sets the root mount if necessary
> 
> 
> Quirin Gylstorff (13):
>   initramfs-crypt-hook: Allow switching between clevis and systemd
>   initramfs-crypt-hook: Align systemd encryption and clevis encryption
>   initramfs-crypt-hook: move the mounting of encrypted disks in a
>     seperate function
>   initramfs-crypt-hook: Check if the TPM device fulfills the given
>     requirements
>   initramfs-crypt-hook: add flag to make encryption optional
>   initramfs-crypt-hook: add e2fsck to avoid resize error
>   initramfs-crypt-hook: split encryption and mounting
>   initramfs-crypt-hook: Add check if root is part of the mountpoints
>   initramfs-crypt-hook: split hook in multiple files
>   initramfs-crypt-hook: Consolidate clevis and systemd scripts
>   initramfs-crypt-hook: Increase version
>   README.tpm2.encryption: Add section to switch from clevis to systemd
>   Add example to encrypt the rootfs
> 
>  doc/README.tpm2.encryption.md                 |  20 +++
>  kas/opt/encrypt_rootfs.yml                    |  24 +++
>  ...pt_partition.clevis.bullseye_or_later.hook |  34 ++++
>  .../encrypt_partition.clevis.buster.hook      |  30 ++++
>  .../files/encrypt_partition.clevis.hook       |  20 +--
>  .../files/encrypt_partition.clevis.script     | 157 +++--------------
>  .../files/encrypt_partition.env.tmpl          |   4 +-
>  .../files/encrypt_partition.script            | 164 ++++++++++++++++++
>  .../files/encrypt_partition.systemd.hook      |   5 +-
>  .../files/encrypt_partition.systemd.script    | 152 +++-------------
>  .../files/mount_crypt_partitions.script       |  61 +++++++
>  ...ook_0.1.bb => initramfs-crypt-hook_0.2.bb} |  49 +++++-
>  .../files/overlay.script.tmpl                 |   2 +-
>  wic/x86_64-encryption.wks.in                  |  16 ++
>  14 files changed, 442 insertions(+), 296 deletions(-)
>  create mode 100644 kas/opt/encrypt_rootfs.yml
>  create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
>  create mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/mount_crypt_partitions.script
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.1.bb => initramfs-crypt-hook_0.2.bb} (54%)
>  create mode 100644 wic/x86_64-encryption.wks.in
> 

I heard no further comments (but also no "works for me"), so I applied
this now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


