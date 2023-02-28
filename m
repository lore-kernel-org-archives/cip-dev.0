Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C710C64ED6
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 12:22:58 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.70])
 by mx.groups.io with SMTP id smtpd.web11.21870.1677586969602789900
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Feb 2023 04:22:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ia1s1M1J;
 spf=pass (domain: siemens.com, ip: 40.107.20.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCjGEVgPqP76na4nk9q8CkE173b5tGzvhi60MJuRKZ+AhiHaDFwGiHmeXBNwUbfLEAJ+ZUCdy5DTQrG5X6Urra2x+XB/0BPDTSrwLLqa3NAaB0Hcuz2cTeQA7hac4zUr42ajz4pcwvfu+L6FnLJ51uCvOMSgdlQj/mE6BYDx+ZzAd/CaQH/06ldIeDr++MGWVFu5imp8n85v11t4dtaYuzaqWcISAMDfRW07e7qOUq6mYa/VQjiOtDXa/98Z/Fl7nm2uZGzwXvhBDzExsq9vCXslWWMRtS2sgCiiwUvNH+CnLfjXUxXx+/mp8BE7rONE/kQerVxixXZgogFE297lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWehP0UP6v5BVZLDWdpu7MoPTPKdHN7Jvb22oG0ZFkc=;
 b=Ot0OyMJZ+gi/y98l/XYZgUUEn/LmRn41j+UoqPQ6MEFI/zpmyDW6Wx2uSMxrtdlzUayfE6eDWo10YU+8OmuHIW1+Eqd5Bu5IaDVj21a6Fl7RnsWxnNwHPdencLj0RC8AM8GJYZEkOaQ+teRds7+F+LWlnHAVmkvd1QmfWbDJue8ypp6HOp4tJ4qAAmhlRKGVDb4mKj37xbbnb5aN9SaGTCEaS+AN8ikgaN9HFvIDNPaJabvP08DWYHgOl8iA66XFyowLMEMiJTzeB8aVBn6Bh834odrReNyfUS4DxuoNboGfBgqrWDfOWNSaPBfI10663RgSXWqvmUzNFEf9rekmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWehP0UP6v5BVZLDWdpu7MoPTPKdHN7Jvb22oG0ZFkc=;
 b=ia1s1M1Jufn71aQ5Rbw48aOfLJvIYxUmyzfwg6BsY86xhs1vnBZ6XIP+2cQBwwevNmlgRkQpiHqWskzUlNg+itWIYQabZu5JNY/XvDGRD8pTvqS496laWsVvaXSFSoJ4Yt8fHfuzziKJtg2GcbpltnmE6czFZAYGAz9EzhbzZ5+jE5DxeDSlHkvAu4E1YZFMJEG32OlR+2yJ8g+P8m2XGrkoHALsHfIrGzAOqJNAefUbmEGCQL2v8gd3RRF0guWSjzqkl+Rk3R9EtLyEI7Dy5BDE5zpClxexz1IZs1EiEsUAHHtzZ7mrj2NOqkiri+O/ya0d7Dat8oi9CJC0ETwF4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 12:22:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 12:22:46 +0000
Message-ID: <4d25f4fd-8be7-6c5f-1e53-a85f21781076@siemens.com>
Date: Tue, 28 Feb 2023 13:22:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH] README.secureboot.md: update the document
Content-Language: en-US
To: Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
CC: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230228120825.2522604-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230228120825.2522604-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:610:5b::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f6c66f-526f-496f-edfe-08db19867f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0clbx5xLG00o/F8c85BALt7++j61IFe232fmh6Z2zSm8LQe6QUb3oP7lMxScaGzCjQjyz417MvXvSrdM9PbE2LT6QovUk/qet5ACstbveV0DpcRstlTLMx0k35HEJnowBRY4RLuZyQpDmdYTME1swiz1ykk+saujQCTG0bMT53QNVRfFm8KsUkG8eK9s+92du7JdGxVa0dWMN1GaiwzdC4ZmjM0tsA+37+Ku8f3HJKor3AZnoMRbEyzNnnAfYh4GcQZfclN+HWGPimF/c6DUmpeANgJg3wPugpu/jgp9diws0Ppk0m5Aq0rcc2fpQoCA1NAVvFNK+jncnwza/yvwEGGNTd1kqb6cL6gzWbtQxidtV0nSwiM86JAnIHJC9hgb3iivZiUrnn65a3zPxeKzc8gqWfVXCFhuvt8PeU/g/kds40/P4no3SN0fRnlNl7r5Md6+iOiZY0GM3JWSAs8g1jBUp3U2+m/E5ql18UvK5hQ02ueaujCdwQoKPu1xE75En1d7QOCEY1soR6JR2wDH4Icdz2T+qNT7/lLgpjZ9v3t3dky7aihxUrQz88IaxBUeQKC/rxY7mYXI9wwA23WrujYWwifS8ldv8Lm0OxmqFFH6Hxvtdt46kwmiofl8brFzGVcieP/zwWdeBd3wXvbZHS9ODT1s6cwr/Cio+7DN069dBkJjgoicopzIS76c9sXnqD3xf8KPg4flks/tbYhCcV1HsGTePva7iEqzdDOKHLPm87vt9j6NprXS35kou27P
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(38100700002)(82960400001)(31696002)(86362001)(36756003)(44832011)(15650500001)(2906002)(8676002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(8936002)(2616005)(6506007)(53546011)(6512007)(26005)(186003)(83380400001)(110136005)(478600001)(6636002)(316002)(107886003)(6666004)(6486002)(31686004)(43740500002)(45980500001)(47845001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B6TTaCDYywAahnD5s5xHwDCfmnuks0Be2NQVF75eRgZkKthnMFsR/CJxLEVp?=
 =?us-ascii?Q?jtu9PIlbu10nXPzxtCn6Txj5chmFL8nv6V42OY6znWXCGdnEo15CfjdExg4a?=
 =?us-ascii?Q?Xf6KosVT2brTRnVaDQoP3K7jI+mIGERbWHIO/RP+IpMav7YQjr748ZuWES05?=
 =?us-ascii?Q?sR+6y/MzI62ittjdFtmPsKAYo75C6R5GBGH4fVuWAu7KGBUdzeadCge94uQc?=
 =?us-ascii?Q?qDvQkPNSQHXKbUY+9QC/mRTyKEUDv0e8YgT2nd+cjsmafIMAx3MDVghjHrCW?=
 =?us-ascii?Q?9AStV6YwvD8iEZfulPR/pkymt7hoZ9ix/et4CVi+Nr3dDpuDwLfFkghaBUY/?=
 =?us-ascii?Q?KgJOTvbckgeeuv6LLISVM9AsBVyqip6awfl9nnN2F33RVGy4oXRWM13iObt5?=
 =?us-ascii?Q?ayG0ofSH0h0R3+pSS+fQkHJOp1IrVrAvBrGZZV98jRC6m5VxglTDfsNa6xx4?=
 =?us-ascii?Q?tFE/d44MpXF6eRNIyNNYWh2k8CXk9QwLx9kZVF6gJrflJIcoGIhJj6nCaifp?=
 =?us-ascii?Q?FnlDOYEMyQje4jFmU/BBk3t13Bu/7wGYNfyHSlp51QYv1WAYooaMh+ROVo0H?=
 =?us-ascii?Q?fkZK2fm2/RKdjqchx2YpEojBJoT1d0+2XXzRoX1+1Wfgptffrsm+HbYFMcQk?=
 =?us-ascii?Q?JM0ZQxlEu8iJUsrX1rmKUMlKIXtLOKWc+vwiUVJUKrD+TO7kMc/Ygq/t88GX?=
 =?us-ascii?Q?RdSFbdFxIn2ZFbGMcJuSL2kDebNRceHwY194ti/ROGoMblYu8nRrxwTcSd0x?=
 =?us-ascii?Q?36QG/ipliZS8kHbi10zFNBijfUcncQeDBlaO/hNihMesgII1gFtnkYGO38st?=
 =?us-ascii?Q?oOGsCT2K3M3ju0YtB+4/no7UEWm7KMiQyClPM7vqwInOqDPB9TKuLCcvf4Un?=
 =?us-ascii?Q?e7fSKr/dorBI0yffBuQ9AWawrc0ljT8IrzJttJL5gkIbMwZ/GDKvrjYy1a/w?=
 =?us-ascii?Q?CiFCdUvnf/DYQeifT4Tr5arJig4D6Ii87AbAPBUIWz+5gu8bqwVuEsHrfOA2?=
 =?us-ascii?Q?D0+2agyd3oysEx+zzFb2gUnngkLKbjZWB7JYIrP/Je3fs/XIto9gWhEK+idD?=
 =?us-ascii?Q?ddixXgj55XcWuc1b3tvp1LJBo89QfHWrue/vuhxFqXAhMLyn+DHfDpTsBj2d?=
 =?us-ascii?Q?zFWGrYSaSXJX9pvriXzFgYZuyKSxbfxg4kjtoU+VxxBFsJSNlkuwkMjMnXC/?=
 =?us-ascii?Q?Cg++H8Z9rKXuYkuFA4M9RKvJ5/fJLWTQwtI5bex/J+GDHlmO4PrN4OPDuSZ+?=
 =?us-ascii?Q?QEKcKTi8oK0fpeMb5g7Q6w3MpwZLJB0XUD1a6Xk/sn57cUFJB2w3sPQhK1PT?=
 =?us-ascii?Q?cpAR2OSki1PnMJOsHYx4K+LIRYuybMnqUyktXG+AXeEtEJZGra9pkZuqFWKf?=
 =?us-ascii?Q?Zz1wILAEzAiau5+KEtysb5Po+uKaumJOVABNiqTpL4nA7yAwuOeFPEnA4cwn?=
 =?us-ascii?Q?87KuSRP5Geh5jOdZsx2babE1gU6H6G2okeIizvgT+Ep+LJdX7zXMcsABvk7y?=
 =?us-ascii?Q?myXSgw00Dcd/79hAL5jjTUHGK8axBRFUmlKzG/s0rp4VViO9vEjCwIyMo/d+?=
 =?us-ascii?Q?RS1rOPrH66kIKAEE+qZTnxwMFSeM3SDU/NNz1J1giDYvnIDEjDoh2bVwC50O?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f6c66f-526f-496f-edfe-08db19867f8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 12:22:46.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1yU/UHCdxOgd3HK3HfY6hqBPrKCeUs/EKWWQJKvwbRT4a78mLS5Lrki2hbPWtEzA7JqctoGUN0XS3C54IPjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6322
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Feb 2023 12:22:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10866

On 28.02.23 13:08, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
>=20
> Update the secureboot document based on the current implementation.
>=20
> Note: Now secureboot directly boot the linux hence no need to provide the=
 efi
> file path in efi shell.
>=20
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  doc/README.secureboot.md | 49 ++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index b15ea93..54d67c7 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -67,10 +67,9 @@ Set up a secure boot test environment with [QEMU](http=
s://www.qemu.org/)
>  ### Prerequisites
> =20
>  - OVMF from edk2 release edk2-stable201911 or newer
> -  - This documentation was tested under Debian 10 with OVMF (0.0~2020022=
9-2) backported from Debian
> -  bullseye
> +  - This documentation was tested under Debian 11 with OVMF (2020.11-2+d=
eb11u1) from Debian bullseye
>  - efitools for KeyTool.efi
> -  - This documentation was tested under Debian 10 with efitools (1.9.2-1=
) backported from Debian bullseye
> +  - This documentation was tested under Debian 11 with efitools (1.9.2-2=
~deb11u1) from Debian bullseye
>  - libnss3-tools
> =20
>  ### Debian Snakeoil keys
> @@ -80,7 +79,7 @@ You can use them as described in section [Start Image](=
#start-the-image).
> =20
>  ### Generate Keys
> =20
> -#### Reuse exiting keys
> +#### Reuse existing keys
> =20
>  It is possible to use exiting keys like /usr/share/ovmf/PkKek-1-snakeoil=
.pem' from Debian
>  by executing the script  `scripts/generate-sb-db-from-existing-certifica=
te.sh`, e.g.:
> @@ -196,12 +195,6 @@ and the following command is sufficient:
>  ./start-qemu.sh amd64
>  ```
> =20
> -The default `OVMF_VARS.snakeoil_4M.fd` boot to the EFI shell. To boot Li=
nux enter the following command:
> -```
> -FS0:\EFI\BOOT\bootx64.efi
> -```
> -To change the boot behavior, enter `exit` in the shell to enter the bios=
 and change the boot order.
> -
>  #### User-generated keys
>  Start the image with the following command:
>  ```
> @@ -239,14 +232,17 @@ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-=
qemu-amd64.swu root@127.0.0.1
>  ```
>  - check which partition is booted, e.g. with `lsblk`:
>  ```
> -root@demo:/mnt# lsblk
> -NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> -sda      8:0    0    2G  0 disk
> -=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
> -=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
> -=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> -=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part /
> -=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
> +root@demo:~# lsblk
> +NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
> +sda              8:0    0     6G  0 disk
> +=E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
> +=E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
> +=E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
> +=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
> +=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
> +=E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
> +=E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
> +=E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
>  ```
> =20
>  - install the swupdate and reboot the image
> @@ -257,11 +253,14 @@ root@demo:~# reboot
>  - check which partition is booted, e.g. with `lsblk`. The rootfs should =
have changed:
>  ```
>  root@demo:~# lsblk
> -NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> -sda      8:0    0    2G  0 disk
> -=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
> -=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
> -=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> -=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part
> -=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part /
> +NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
> +sda              8:0    0     6G  0 disk
> +=E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
> +=E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
> +=E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
> +=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
> +=E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
> +=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
> +=E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
> +=E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
>  ```

Adding Quirin for a cross-check as well, but it looks good to me.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


