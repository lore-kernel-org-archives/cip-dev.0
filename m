Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04B2C48BC3
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 13:00:11 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.75])
 by mx.groups.io with SMTP id smtpd.web10.40458.1708347608141831713
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Feb 2024 05:00:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ybvi7qkl;
 spf=pass (domain: siemens.com, ip: 40.107.6.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA+fqRpVeunkczjonAdjHXbM45SOdf81RmTzUNLbDfoHsjib8HPaGDznWn0JswfW8BdHf5boJYcKiqGaCA8mYSquYg1NOUQFc//vvlTFQREWCrpA0agTnEpKJbGc8hhbbh1mQE6BrdHYfbJMvys2ClOf1CT3OGHdvhRuNVUJ8oa9QTlcYRm/3oEVIqKk5XMkZkmvNc07q1c70dJyyNBfPBpVsU86GJJIHFkyiDwaW8/1hpkCWhul4IClDH9JOiIuVW0Flci6I6yI3oYs9Lm2eE2PCdUIcV/fBHq9kI94rpa58mncfA6e39CKJrFzn/zX7OffdKh92Qp5jzvKoiBVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMghyLIY7u/BTk6dFRVJ5isTn4U+3majqQZIR2YFE0c=;
 b=WcN2IKumoBVax4G69aFR6lnRCtszMdJHksMfZffmdBPIFXH6/kWuKkJTJDnvFKLF3lkKM2xotta5Jgr7HSEzhwVV7OCCVYsHvneCH5w90MuRtV3wXywNxfdvor9W64fQ5PA/uV/PwkGoiBdJAkEAJ0cT5S3fswiRoxbuqjRcxrKapIl+2pzd2+YtPdtHdwxzyyPZK7W/wSroDPy7uMCrouFFmGIOjsR4O9p5LM2GIB4Aj+F7zrES0miGGJLc36UtafYvfET0nipm3QclGfTvDM+90rxgrunHRwwKKpGrB3u2nmGVqCx+/UZerg8P7KCVL66bNlvPxxStXLxEsJtY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMghyLIY7u/BTk6dFRVJ5isTn4U+3majqQZIR2YFE0c=;
 b=Ybvi7qklr8ryH5/2+/P4ckmvzMQC4LbsPASSciiaZWERXw78yBKZW/urG/k91TZEwtfgIbgKypwZyLQjo51r7vTVjafiEhfgWku4NYLwP5w792B/tq/kYvrwb/LmXkyl3yAKB5LCEZEWxzxqvAactQx61IVRX2LtbrCZUWBCEEPXfKpyuKR6hZkoUncpWGk5nRUmjpG2iY5Jy16XwuFnGYyfGUPTVSftdZZ78NhTrTTEy4D88aED9DB4fOfEkQhLwYcL8nLOqL9kxLmSdqvrYNUAnYgLxHmbqKLXG6IAGPKnpue1s/W7/EggAwfcPTsui4ToAUYM9jIN+WCOcGWbxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3599.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 13:00:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 13:00:04 +0000
Message-ID: <06751d93-8bff-45ab-85f1-7252b759bed9@siemens.com>
Date: Mon, 19 Feb 2024 14:00:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v3 0/2] Deploy swupdate images with empty var
 partition
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, shivanand.kunijadar@toshiba-tsip.com
References: <20240219120858.59136-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240219120858.59136-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b03ebe1-7dfd-4c6e-9045-08dc314ab0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AihbbtwyQcME6sey+j2EQHHNPi82zy5rFl3WkjnZES1UaAV3jHTGk35ixGcmbBiEaKZ344saVGbPoynZiFg4I1HD/84zPJ9vQVNyLXr8HJIHsq0V0yimHNINq9qvz8ZAR9HNr+NnVIehODr6UGX7bP8IqbP9LXgN+jnU8F4pdlYNdOT58Gj6yji7PrL96lL9MkF35WTWIB/3Uvpfznl8B9SQgwmUy96JnlVF3Wn7Wwc+iSXRX8EojQTsW99+arWe2nBjMBunweWKIAIjF/g3Zm0y1aBdlM4G5+EFALlE7jB3Um1Zc+q66TUClI6vE/lpqopDyaEZF0VNyz9vC7oPlHdCpQSA/ziOs/UeKCn6SrLUoH+dQiBttl7VMatJP6S1Q+67wd/ouH8/SbCSS0XYcaqPx1cxju3YbRS/qd1VrVrKPuuXmoEu39H+JtwDal9fGuL+C6WctO8jD9H5t0sBsLLQjQlsSFBZgH4qSWLZGSPO+TyJjqTDnJgeIrF7imSSr9fKetnjEfcnWOYTvfzVN1HyHNrm1FnJWb8sezjyhUI4OXQTea21/dTA/JxRtAqO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmM2UGJneTcrMHFCRkRRWHEwSDQrZGwzNm9ielpLRy9UaVR4bk9UbGJWSUln?=
 =?utf-8?B?aDZJL1kvdi9FdE40NHhTSDJ1ODcxd1Fya0crQ3RyczZaUDF5NURJWSs2S3BH?=
 =?utf-8?B?NElrc2JFblZrTkpQTW40bmlCMWJKY3FmNDVzUVYya3FpT3RrMnV6dnZnZkFt?=
 =?utf-8?B?TFQ0YXhlbllQYklWZ3NsQ2E0S3c5ZjVaWkpIRm1INm5Wd01uMTc2ZGlYeWtq?=
 =?utf-8?B?RkJ3VVFIZDQ5WXVHeCs2OVRPWFBZaVJ3VjZiSHJEUTdIWFpmQUV5QytxRjRP?=
 =?utf-8?B?NWJuQ0RQUTJLZ0RkRGpaRUhuVGhUQ2hpVHBuRWV1Nkp1MW1ab3ZvcldycC93?=
 =?utf-8?B?aHJjRGdqdWd3alNsNXRoeFRZT3lMWksxaW54QXpoNURtdGNWdlJINFFWZkVH?=
 =?utf-8?B?K2tKWTB6UUxET2lXdS9FaXhacTV1SWdZanJLNDJ0NkxrZ09OTGJhR1orQzE1?=
 =?utf-8?B?ajFhNSt2MUxRTElvd0FKb1RsNlJWOERsKzNvYkw0Yy9tWmlpSUlYWDVVZ2d0?=
 =?utf-8?B?bWdaSS8wWVM4V3Y1aklXM3NBM2VxdXA0UlNFNU5aUTh3WjFxTUc4cldvWkhq?=
 =?utf-8?B?b05aS1g2dHRvRVUyWG9sUHFOREVwSWVjdGF6eGJaU2J2ZXpkVURGb0hOZ1FI?=
 =?utf-8?B?RHRXMzllbGhvY3VqUkhqYVEvR2NaclNmeUNhL2k5bjFnUFR0VlVGOEM4ejVQ?=
 =?utf-8?B?OHNBUXdkWU9oR2RKa3dtdHg1ZmxUQ2RGakFQSGxkdUprWS9EUXJmMkhxUVVk?=
 =?utf-8?B?d3ZtYmozWDZub0tQUDB6MDJoOFBsV3NmckxqRVhSZW85bFpXUW1jeHpUbEhj?=
 =?utf-8?B?N0tGczhObWJVZDZQTnduRk5kWlRmVGdJL3hGeEVuRkZhaHB6QWQ1WUtqTytY?=
 =?utf-8?B?MTBmODh3N3FNaVpJTjlvQjc4ZnJaczBYSERVRjZwRUpVamJmZEZmR3hJSExt?=
 =?utf-8?B?YmdhaHE2VDVyd3JTcG1QS2xUN1ZmSUUzbWlxT3NqL2l0YlZzRHRlY2YvWlps?=
 =?utf-8?B?Yzd0cWJmd1BZS25uMUFoT2lveXpwMGdCb0NRenZQY0JIbkx4bXJJSklNa2VH?=
 =?utf-8?B?bkt5L1F1ZnVQS1l1VFNLYTRSalQ3Vndkc0pOd1lTQy9KOG93ZUlBN1VyR0lR?=
 =?utf-8?B?Mm4zRjNxc0l6alo2dTBLWHloNXR1VVNBOGlYUVBKUjlOZ0s2L05WbFB3MnpP?=
 =?utf-8?B?MDA3bHA0S2tWTW9LcUVDTlpHWHpFNmVkcStQQVh1SHhTNVROaXQ3M3d0bGMx?=
 =?utf-8?B?WTladVMxQldLQjVldHhhZzR1YklQREdyQXpUWTQ5TVpPb3pmL2Y3S0lBUnV5?=
 =?utf-8?B?djRFRFBqWHRTbGNhUG1RaFVoWW9IY1Q3Sk1OemEyZldUZllYUGZFalRGWDd5?=
 =?utf-8?B?UytweXNSakp5YU85Mko5T1pDMkxVQmRLOEdzdjdyNFJIbmY1bHRRUjMrWFdY?=
 =?utf-8?B?Q2NDSnZHQjl2c09uTHA5bWgyNmc2cXJoWE5vdGVKZnE0WmljWFJUMXNKVEg2?=
 =?utf-8?B?a1JJK1hDRStFMzJUV1hlQlA0SHBzWWxXdU1oRHAzUi9zdG9xWnhDbjByVEMx?=
 =?utf-8?B?VmVnQ1VPVXpWWTVTNnphVWkvcnFYakxrK1dKMmlneDNoNlVFOGFIK1NvWWFF?=
 =?utf-8?B?V1NhNUQ0SkE0N0d0b0FNc1FSWk5VUXBPdVdmbHFpNmxwVHNad3R3VGczd0tX?=
 =?utf-8?B?alhudWNsMjBLcE1wUlNJT1hIdHJ0eXRXSjBwdFNTS3IyZG9ENnFNQ2RxM0lW?=
 =?utf-8?B?ZG4vNVBHOFBnQnRhOVFFcGp4VTVmcC9abEhJUHJ5OXBmR3dvME5lWnJKZzJO?=
 =?utf-8?B?bGhyK292NURnNmY1WE5DTWlNS3hJUk5VUkd5KzU1Z3FvekhEekswNmIyUnEr?=
 =?utf-8?B?WmZsU25LYyt6RXhhWU1xTzhpeTdRK3NUTUNFUmF3a3NwTUM4RjIxWGFJWHRB?=
 =?utf-8?B?dEQ0cXhUcHRqNzJ1cTl0aVBmT2pJV0VjcWloYktQWHdUSkgxRURqcnNhdWw3?=
 =?utf-8?B?Rnczd1pJNFk0cHI3amllWnNUMEhPNzF2THowOGlNZHExRE1NeTljRm1ZR1pk?=
 =?utf-8?B?RzlCcnVyQVRCLzhVMDI5VUhuQkVYUit1aEs4d0V4UVE3YXRhbG96TGs2NFUw?=
 =?utf-8?B?L0Q1SklheWNFM2JnVGJ6cTJ0T0xnUHV0V0VKZzIzTVExakpkeUlYQkwvV2Y0?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b03ebe1-7dfd-4c6e-9045-08dc314ab0ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:00:04.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTX913OER0ghuUdz48IA6kEgFQdaCaBMhlgly+OUtx/ReEgnkwh1+hsrdEYS6qlNUJRtKgiM2+2F0FQrHFOrMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3599
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Feb 2024 13:00:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15033

On 19.02.24 13:08, Felix Moessbauer wrote:
> This patch series prepares and switches the rootfs configuration to be
> deployed with an empty /var partition. For now, I send this as an RFC,
> as this needs to be tested by a broader audience.
> 
> A couple notes about the implementation:
> 
> - the /var partition is deployed as empty file system
>   (and not included in the squashfs)
> - no warnings are issued on files / dirs that are pre-populated in /var.
>   It has been tested if this is possible, but unfortunately many packages
>   use both tmpdirs.d as well as postinstall scripts to create the files.
>   This might be the result of a transition phase, but makes it impossible
>   to detect potential issues. Also the tmpdirs.d configuration does not
>   necessarily come from the same package as the dir creation in postinst.
> - The dpkg database is copied to /usr/share/immutable-data/var/lib/dpkg
>   and a symlink is created on /var/lib/dpkg (using tmpdirs.d). By that,
>   dpkg -l can still be used to query the installed packages and their
>   versions. This feature is bookworm only due to the required
>   debhelper-compat 13.
> 
> Note: This series needs to be applied on top of "refactor: use change-dir
> to split rootfs parts"
> 
> Changes since v2:
> 
> - rebased onto next
> - updated ISAR to get better debhelper-compat support

I think we are missing the related patch in this series.

Jan

> - updated immutable-rootfs to use ISAR debhelper-compat infrastructure
> 
> Changes since v1:
> 
> - rebase onto next
> - copy immutable dpkg-db to /usr/share/immutable-data instead of .../cip
> 
> References:
> 
> - https://lists.debian.org/debian-policy/2023/06/msg00016.html
> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1039979
> - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/75
> - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/50
> 
> Best regards,
> Felix
> 
> Felix Moessbauer (2):
>   swupdate images: initially deploy empty var part
>   copy and symlink dpkg db to ro-rootfs
> 
>  classes/read-only-rootfs.bbclass              | 10 ++++++++
>  .../files/immutable-rootfs.tmpfiles           |  1 +
>  .../immutable-rootfs/immutable-rootfs_0.1.bb  | 23 +++++++++++++++++++
>  wic/bbb-efibootguard.wks.in                   |  4 ++--
>  wic/hihope-rzg2m-efibootguard.wks.in          |  4 ++--
>  wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
>  wic/x86-efibootguard.wks.in                   |  4 ++--
>  10 files changed, 48 insertions(+), 14 deletions(-)
>  create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
>  create mode 100644 recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
> 

-- 
Siemens AG, Technology
Linux Expert Center


