Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF7C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:11:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.55])
 by mx.groups.io with SMTP id smtpd.web10.8664.1676646664923128899
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:11:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=k46HivQc;
 spf=pass (domain: siemens.com, ip: 40.107.20.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXQNCSyBxnxsdVvbmPugq1EnBHU00f/Kixqbg90Kxi1XFnkETKXozu+TtBnbgQjz9U0HVlHICP+FxjPCKZ2XGICDMnqaHKlLIT0iylga63pUW25BajOZm8rieF6fo7kN5L6HFpE9/1Zcbo4w9r5aH7F7AGOnneMv7/y1wXTrdmrOGxeBjLSwcZdqB0FKQQnUFUV5EuzABxbMAXDaYTa9VqmE5CDT2HfvWmkKaeXf4sFMdvF8RC6MGRk0HaqiT5704NSNK2OaLnx9E1GOfNXyVU2/kLiYyK3ygk07uxpWBYh1hZPWnH4cLu1YCgY8KsnNKsj+tOghspaYp9kery/F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abTKjuiw6ix5BJXy9uTRtGQ5ipFhGaHUzI8Jr1uHbwI=;
 b=Min1WNSRX4balTBUJHgm2ISvD7I3Ir588FuU0wva/Gj1f7T3IQq6sOcVnPZqXrVRsamxT2WSJDGtdoPGvEGEby8Jz2pZ4+7JzCkdyWuwljUc81d3LeYz1K0JCwKuBQxZ8NPi5o+WHlC336eQeaw2RlsIgZjjGtSh2/3bI96xLMeYFjRYNaBGl+SUP177mjnEgAiZPG0Ih6Jdt1V4ZkfSEbUZiDuXLMtS7YgDH+EwoUbYX09oTKeZb1F/t2Ya7758ZeZtFMA+fyNi+i/tTrkqGFjemXquUeGCNSKzltGQbtFQxPy/pPTeYGbLvVAmyNeKZ+UhTm32wvqz5Wk0LLenIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abTKjuiw6ix5BJXy9uTRtGQ5ipFhGaHUzI8Jr1uHbwI=;
 b=k46HivQcFdcsusTILCtCCun/8h/zax2HyPCN/HwBI22TiQqw0DePviqetDXMk1wqZUXmPY6CFejPSITMg0498tQTy7LFENXuz0pL1IKmqWLHeaKeF9h3bB12d8L4jEsnf1CAlmlc34+f+UgX/dzne+Q3qKVH2MzteZIcrJz6IVqOS/em1seWCGQ65hbeg8+fYjmRW2QpXNBJmDmvUGiiw0cun69Af8Nf0xDQBV+ynAuVLPKAzHAypeiCTGpkkVzOfsB38W2huJhVuvHGvYhloJ+AqZ4qXbJ1P8Mc+Py52jOCYILvJf0iamehg1Ez2gAce6A8wwTr6f/demyZ6eFkjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 15:11:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 15:11:01 +0000
Message-ID: <eed2cb77-0980-58e2-5dcd-7a3414a0531c@siemens.com>
Date: Fri, 17 Feb 2023 16:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 4/7] Add initramfs hook to
 encrypt a partition
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-5-Quirin.Gylstorff@siemens.com>
 <2012e77d-1892-1797-3161-b834ccebda86@siemens.com>
 <00766d63-d1cc-c792-c5bd-8c7d4a3778d4@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <00766d63-d1cc-c792-c5bd-8c7d4a3778d4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO6P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: d89794a6-5230-4ce9-e5cc-08db10f92e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hF4q+9vVVAC6SC86vFTCZX0TAHftjlBAUi4RxBd6fxJ5VSXW35ov2CJpCPwEqOQMyqqqyIVGj/VeFTDjBmdd8ZNQPMhelHtWjhUhzZHFMbAarLVqDkxJzTsYmtFhLB87emHtF4+x37YDQwlKmULjnUEqIyDRy4Q1zOPlEccahG+l8bcqjvCjk3mtM2l1MCeeNT4+C9jafABs/xHHV0wJ6yF8fxswmp/AZmvt1s7NnMKpPQlrUCe244GJ1W7yGhG3W4dKyfhqeVhg4+tCCfUH5bYBdKRUZzT1Z4ZnQrgQPfEIJ/JleCUKUXTpMm+vdpdpNSLxbtBchrCt/t4rWBU64sT04um9Q/AOoeVM8vp4EuZg/x7wclmiG2u1Pe4+ypuqKehSx9Cdb5hdt38AKdU33m/MmygXBFAULf+xW3jWtdqhkciojs6lIqmCoBfwtt5/jYURN0oy+aAA6yEHJ6cFfBPOYJRjNUESZYmdpBWFN+pMT0j6hEbrbo9a6MYFIYFD7kVc7VBIbgL7hOsb/5wuVmxdnkdZeUdDP25vYfJ+oMpSkUPtbwPbFZKnjEqpYRY1J1X98tAvbfrZXGkdzXZTwsM9U/qSMND5UhfCaBlj3ajIxUkgY6trbd2M6/vZttDxuVWmryKYhIsiqmc3J2m6+44TgKxe4mq+yuQyjjGVSZ9k4MQ3wzergy4FVa5BIanuoR6Dj482WrbVJz2tV66NDKnOyuTBL4JdpEiYkaFPk8ztY9/7pYI1EQdUXOvAM+hz5F/5VNtZkp1LBJDp6Fti1g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199018)(31696002)(86362001)(82960400001)(38100700002)(36756003)(44832011)(5660300002)(30864003)(2906002)(8676002)(66476007)(8936002)(66556008)(66946007)(186003)(26005)(2616005)(53546011)(6512007)(83380400001)(41300700001)(316002)(6636002)(6666004)(6506007)(478600001)(6486002)(31686004)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B30HcqXcrxNXEchbmNlSjwgiYt/uNEe6j5RnUZLPqWwV6JOBUep/uBTz9FgY?=
 =?us-ascii?Q?/z6HSGycBuDao+sZKDjY6LdMAZu5PpaeW5dz+vPQCfmr9AeKO4n6tkZOj4SB?=
 =?us-ascii?Q?4rQ9PXEA5WvrMweeuTVqcn/3o92yI1RqpDaEQs0B0KjljLJjLqOTEdRTYbt4?=
 =?us-ascii?Q?2jyWmzKu0ZK4GUsLc1aZ/dETH3zAaISMefY6ntKB/b4spItFstudGzD9Rxd6?=
 =?us-ascii?Q?H6AhqZr2hCsNqWwBhqIGmxvqrmtQzOGzEOevfoA0igLryxSptCWd1PTtc0Ca?=
 =?us-ascii?Q?qBvSSTbLEUo+QXIDehselJDz4nl/SBXkCQBkxcThalKqacRAStglNWXPlpVm?=
 =?us-ascii?Q?5qz3hNfcdew+Qf2McRlZzNpYipvxP9MtRSggAXQP7acj8vesu+T9IKWKusQS?=
 =?us-ascii?Q?W2sN8xvw289qwaHN6VJLGBgObX4+Xz7mP7kMxkVlOgLGl1kD7r206KgyOmld?=
 =?us-ascii?Q?iQhugwcLXEJ+iqOFrhTsSjwJ6tOqYBO2o17KdIIaLz1QIV9NRGaxZA/hmLk2?=
 =?us-ascii?Q?WHWdLkl2D1/s4XexYznOvOsbmuqBOguOqxps4961CD/pvcNUThOEVlt0LFqz?=
 =?us-ascii?Q?c6s6Voi9vojiEFu1as1k2VvgGJ4ckpEW/SWNw5LpKrXi0yDTUIamcQzxGtfe?=
 =?us-ascii?Q?LCheEt3e77YPaqt6ZK+o6sW61mcZrh5gSvl0RlA4FyrG+6DS4GGOH1cwbM+b?=
 =?us-ascii?Q?ogtwOcYGi9M7UKmxQiP+UKaAuBkB71p1GcMP+GJCS38hqRHGcv5YXpmSNVsc?=
 =?us-ascii?Q?foHeqta7amjVPU74jkpzVYp6MR33NRIsaoyI9X+Vm95CZhD6iEfBG0H1ROos?=
 =?us-ascii?Q?wTO4fg3rdkADddk1kxUpVYI4kBtZh5s+6ajLRYuoPShwh1j7W6fsyi0ywyEr?=
 =?us-ascii?Q?FFxgvvePHk768rRNvlQ3bcNNGN1SOEeMllfICBfQIR5dhsulyOzaFDHVgOAx?=
 =?us-ascii?Q?IeF3LA7TEYM/mQ1ESAmFxHMNiyUDtlVZCWMErsi+10siaqLlhb4dGROMTQ3A?=
 =?us-ascii?Q?4VRNfyItCsUUDpM6B/UizLubbPUUOiOjVUqkgNANiHXPKB45un9yhxWzKapZ?=
 =?us-ascii?Q?/qLuxHEJA/bjB6dL9zq3FWoKsVvqa5HlZD/oo6GDv8hilQY/vZeitPMeBb2X?=
 =?us-ascii?Q?CVaXBizQIhhdPsoGxdAolkbcScH0T3J8QBTxj5fxvoPqIcgkqYCLd/eQJbHS?=
 =?us-ascii?Q?sWhBF27V2zIxnMaLmnitY1DSy/ctZfnX3OY36kQGkiP5y8DhS6XIpImJLFWz?=
 =?us-ascii?Q?y25u3D+OD/yMvzDjBhZ+LvNz3KFxfIvvFH3xWyEPOppEJ1y8t0GpUpFheNVp?=
 =?us-ascii?Q?5MjDShdsZbvQfyojxgZVbGK9Zk9LBRrTmhLXpyCwKkz4dEd7gXntE1Lj8eZK?=
 =?us-ascii?Q?1POAkYIBeLEpiGLEiSuPiKAWpTZYenp8rX4MuUHlX77iDsuWKjPf0wMUGAkg?=
 =?us-ascii?Q?xvaXIdrSwtD5HUwOMALCCWJZKaoEfTgYpSEMBt3neN+xfKqGUcgw74+WUgqP?=
 =?us-ascii?Q?RE3bxwJZP5GwxVU1VjZJw2r6V8fyq7mvAcCvvRzRPRGOWsW4TRLHUW8f7BB+?=
 =?us-ascii?Q?pAls7sjPqdFKwD/Yh7zAMxCMUbQk20fWf/6DoG/gtDMSwdGcDPPDL68p5O0/?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89794a6-5230-4ce9-e5cc-08db10f92e7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:11:01.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjQdpaA+YOsP19FG5Niy13uekeHchCrE6yCdv4Z/zs9hdD+5cnnj9gksk7qcr/frZfTXKNq1Ltk30gfCYirX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10727

On 17.02.23 16:06, Gylstorff Quirin wrote:
>=20
>=20
> On 2/17/23 15:53, Jan Kiszka wrote:
>> On 17.02.23 14:05, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This creates a new luks encrypted ext4 partition with a the
>>> key stored in the tpm2.
>>>
>>> The initial key is randomly generated and removed from the
>>> LUKS partition. Therefore a new key cannot be added by the user
>>> and if the LUKS header is corrupted the data is no longer readable.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../files/encrypt_partition.env.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>> =C2=A0 .../files/encrypt_partition.hook=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 49 +++++++
>>> =C2=A0 .../files/encrypt_partition.script=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 135 ++++++++++++++++++
>>> =C2=A0 .../initramfs-crypt-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 37 +++++
>>> =C2=A0 wic/x86-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
>>> =C2=A0 5 files changed, 225 insertions(+), 2 deletions(-)
>>> =C2=A0 create mode 100644
>>> recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>> =C2=A0 create mode 100644
>>> recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>> =C2=A0 create mode 100644
>>> recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>>> =C2=A0 create mode 100644
>>> recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmp=
l
>>> new file mode 100644
>>> index 0000000..943fe4b
>>> --- /dev/null
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
>>> @@ -0,0 +1,2 @@
>>> +PARTITIONS=3D"${CRYPT_PARTITIONS}"
>>> +REDUDUCE_DEVICE_SIZE=3D"${CRYPT_REDUDUCE_DEVICE_SIZE}"
>>
>> Did you mean "REDUCE"?
> That was my intenion will fix it in v3.
>>
>> And what is this variable for?
>=20
> If you use online reencryption on a populated partition you need to
> create the space for the LUKS header. The necessary minimum size is 32MB.
> As an alternative you can detach the LUKS header.
>=20

And what does this variable contribute to that?

>=20
>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>> new file mode 100644
>>> index 0000000..96e084a
>>> --- /dev/null
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>> @@ -0,0 +1,49 @@
>>> +#!/bin/sh
>>> +# Copyright (C) Siemens AG, 2020-2022
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +PREREQ=3D""
>>> +
>>> +prereqs()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo "$PREREQ"
>>> +}
>>> +
>>> +case $1 in
>>> +prereqs)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 prereqs
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 exit 0
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> +esac
>>> +
>>> +. /usr/share/initramfs-tools/scripts/functions
>>> +. /usr/share/initramfs-tools/hook-functions
>>> +
>>> +manual_add_modules tpm
>>> +manual_add_modules tpm_tis_core
>>> +manual_add_modules tpm_tis
>>> +manual_add_modules tpm_crb
>>> +manual_add_modules dm_mod
>>> +manual_add_modules dm_crypt
>>> +
>>> +copy_exec /usr/bin/openssl
>>> +copy_exec /usr/sbin/mke2fs
>>> +copy_exec /usr/bin/grep
>>> +copy_exec /usr/bin/awk
>>> +copy_exec /usr/bin/expr
>>> +copy_exec /usr/sbin/e2fsck
>>> +copy_exec /usr/sbin/resize2fs
>>> +copy_exec /usr/sbin/cryptsetup
>>> +copy_exec /usr/bin/systemd-cryptenroll
>>> +copy_exec /usr/lib/systemd/systemd-cryptsetup
>>> +
>>> +if [ -x cryptsetup-reencrypt ]; then
>>> +=C2=A0=C2=A0=C2=A0 copy_exec /usr/sbin/cryptsetup-reencrypt
>>> +fi
>>> +
>>> +for _LIBRARY in /usr/lib/*/libtss2*; do
>>> +=C2=A0=C2=A0=C2=A0 copy_exec "$_LIBRARY"
>>> +done
>>> +
>>> +copy_file library /usr/share/encrypt_partition/encrypt_partition.env
>>> /usr/share/encrypt_partition/encrypt_partition.env
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script=
 b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>>> new file mode 100644
>>> index 0000000..e58794e
>>> --- /dev/null
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>>> @@ -0,0 +1,135 @@
>>> +#!/bin/sh
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2023
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +prereqs()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 # Make sure that this script is run last in local-t=
op
>>> +=C2=A0=C2=A0=C2=A0 local req
>>> +=C2=A0=C2=A0=C2=A0 for req in "${0%/*}"/*; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 script=3D"${req##*/}"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$script" !=3D "${0##*=
/}" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pri=
ntf '%s\n' "$script"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 done
>>> +}
>>> +case $1 in
>>> +prereqs)
>>> +=C2=A0=C2=A0=C2=A0 prereqs
>>> +=C2=A0=C2=A0=C2=A0 exit 0
>>> +=C2=A0=C2=A0=C2=A0 ;;
>>> +esac
>>> +
>>> +. /scripts/functions
>>> +
>>> +# get configuration variables
>>> +. /usr/share/encrypt_partition/encrypt_partition.env
>>> +
>>> +# load necessary kernel modules:
>>> +modprobe tpm_tis
>>> +modprobe tpm_crb
>>> +
>>> +# fixed tpm device or do we need to find it
>>> +tpm_device=3D/dev/tpmrm0
>>> +partition_sets=3D"$PARTITIONS"
>>> +
>>> +open_tpm2_partition() {
>>> +=C2=A0=C2=A0=C2=A0 if ! /usr/lib/systemd/systemd-cryptsetup attach
>>> "$crypt_mount_name" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$1" - tpm2-device=3D=
"$tpm_device"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Can't decrypt '$1' !=
"
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +}
>>> +
>>> +enroll_tpm2_token() {
>>> +=C2=A0=C2=A0=C2=A0 #check systemd version and export password if neces=
sary
>>> +=C2=A0=C2=A0=C2=A0 if [ -x /usr/bin/systemd-cryptenroll ]; then
>>
>> And if that file does not exist? No error? No bail-out?
>>
>=20
> I will remove that check and move it to the hook and fail during build
> time. Is that better?

I just want to avoid that a realistic error leads to improper error
handling. Even worse if that could lead to a usable but unencrypted
partition.

>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 systemd_version=3D$(systemd=
-cryptenroll --version | \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 awk -F " " 'NR=3D=3D1{print $2 }')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #check systemd version and =
export password if necessary
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$systemd_version" -ge=
 "251" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAS=
SWORD=3D$(cat "$2" )
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp=
ort PASSWORD
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /us=
r/bin/systemd-cryptenroll --tpm2-device=3D"$tpm_device" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 --tpm2-pcrs=3D7 "$1"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAS=
SWORD=3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pan=
ic "Unknown systemd version: '$systemd_version'!"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +}
>>> +
>>> +reencrypt_existing_partition() {
>>> +=C2=A0=C2=A0=C2=A0 part_device=3D$(readlink -f "$partition")
>>> +=C2=A0=C2=A0=C2=A0 part_size_blocks=3D$(cat /sys/class/block/"$(awk -v
>>> dev=3D$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
>>> +=C2=A0=C2=A0=C2=A0 reduced_size=3D$(expr $part_size_blocks - 65536 )
>>> +=C2=A0=C2=A0=C2=A0 reduced_size_in_byte=3D$(expr $reduced_size \* 512)
>>> +=C2=A0=C2=A0=C2=A0 reduced_size_in_kb=3D$(expr $reduced_size_in_byte /=
 1024)K
>>> +=C2=A0=C2=A0=C2=A0 resize2fs "$1" "$reduced_size_in_kb"
>>> +=C2=A0=C2=A0=C2=A0 if [ -x cryptsetup-reencrypt ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-reencr=
ypt --new --reduce-device-size
>>> "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup reencr=
ypt --encrypt
>>> --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +}
>>> +
>>> +
>>
>> One newline should be enough here.
> Will fix in v3.
>=20
>>
>>> +if [ ! -e "$tpm_device" ]; then
>>> +=C2=A0=C2=A0=C2=A0 panic "tpm device '$tpm_device' does not exists - c=
annot create
>>> a encrypted device!"
>>> +fi
>>> +
>>> +for partition_set in $partition_sets; do
>>> +=C2=A0=C2=A0=C2=A0 partition_label=3D$(awk -v var=3D$partition_set
>>> 'BEGIN{split(var,a,":"); print a[1]}')
>>> +=C2=A0=C2=A0=C2=A0 partition_mountpoint=3D$(awk -v var=3D$partition_se=
t
>>> 'BEGIN{split(var,a,":"); print a[2]}')
>>> +=C2=A0=C2=A0=C2=A0 partition_format=3D$(awk -v var=3D$partition_set
>>> 'BEGIN{split(var,a,":"); print a[3]}')
>>> +=C2=A0=C2=A0=C2=A0 partition=3D/dev/disk/by-partlabel/$partition_label
>>> +=C2=A0=C2=A0=C2=A0 crypt_mount_name=3D"encrypted_$partition_label"
>>> +=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>>> +
>>> +=C2=A0=C2=A0=C2=A0 # check if partition is already encrypted with syst=
emd-tpm2
>>> +=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch-mode "$par=
tition" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | g=
rep -q "systemd-tpm2"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partition "$parti=
tion"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! mount -t $(get_fstype =
"${decrypted_part}")
>>> "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pan=
ic "Can't mount encrypted partition
>>> '${decrypted_part}'!"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0 # create random password for initial encryption
>>> +=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>>> +=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$partition_label-lukskey"
>>> +=C2=A0=C2=A0=C2=A0 openssl rand -base64 32 > "$tmp_key"
>>> +
>>> +=C2=A0=C2=A0=C2=A0 case "${partition_format}" in
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "reencrypt")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ree=
ncrypt_existing_partition "$partition" "$tmp_key"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enr=
oll_tpm2_token "$partition" "$tmp_key"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ope=
n_tpm2_partition "$partition"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "format")
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /us=
r/sbin/cryptsetup luksFormat --batch-mode \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --type luks2 "$partition" =
< "$tmp_key"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enr=
oll_tpm2_token "$partition" "$tmp_key"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ope=
n_tpm2_partition_tpm2_partition "$partition"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mke=
2fs -t ext4 "${decrypted_part}"
>>
>> We likely want to make this line configurable at recipe-level, both
>> regarding fs options as well as the fs type itself.
>=20
> I will add an additional field to the configuration string.
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pan=
ic "Unknown value ${partition_format}. Cannot create
>>> a encrypted partition !"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> +=C2=A0=C2=A0=C2=A0 esac
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if ! mount -t $(get_fstype "${decrypted_part}")
>>> "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Can't mount encrypte=
d partition '${decrypted_part}'!"
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0 # delete initial key
>>> +=C2=A0=C2=A0=C2=A0 # afterwards no new keys can be enrolled
>>> +=C2=A0=C2=A0=C2=A0 /usr/bin/systemd-cryptenroll "$partition" --wipe-sl=
ot=3D0
>>> +done
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>> b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>> new file mode 100644
>>> index 0000000..ba2b884
>>> --- /dev/null
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.b=
b
>>> @@ -0,0 +1,37 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2020-2022
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +
>>> +inherit dpkg-raw
>>> +
>>> +DEBIAN_DEPENDS =3D "initramfs-tools, cryptsetup, systemd(>=3D 251), \
>>> +=C2=A0=C2=A0=C2=A0 awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, li=
btss2-mu0,
>>> e2fsprogs"
>>> +
>>> +SRC_URI +=3D "file://encrypt_partition.hook \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fil=
e://encrypt_partition.script \
>>> +=C2=A0=C2=A0=C2=A0 file://encrypt_partition.env.tmpl"
>>> +
>>> +CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:reencrypt"
>>> +CRYPT_REDUDUCE_DEVICE_SIZE=3D"32M"
>>> +
>>> +TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_REDUDUCE_DEVICE_SIZE"
>>> +TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
>>> +
>>> +do_install[cleandirs] +=3D " \
>>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/hooks \
>>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/encrypt_partition \
>>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/scripts/local-bottom=
"
>>> +do_install() {
>>> +=C2=A0=C2=A0=C2=A0 install -m 0600 "${WORKDIR}/encrypt_partition.env"
>>> "${D}/usr/share/encrypt_partition/encrypt_partition.env"
>>> +=C2=A0=C2=A0=C2=A0 install -m 0755 "${WORKDIR}/encrypt_partition.scrip=
t" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
>>> +=C2=A0=C2=A0=C2=A0 install -m 0755 "${WORKDIR}/encrypt_partition.hook"=
 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${D}/usr/share/initramfs-t=
ools/hooks/encrypt_partition"
>>> +}
>>> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
>>> index b635a8b..1d29583 100644
>>> --- a/wic/x86-efibootguard.wks.in
>>> +++ b/wic/x86-efibootguard.wks.in
>>> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams
>>> "file=3D${IMAGE_FULLNAME}.squashfs" --align 1
>>> =C2=A0 part --source empty --align 1024 --fixed-size 1G --uuid
>>> "${ABROOTFS_PART_UUID_B}"
>>> =C2=A0 =C2=A0 # home and var are extra partitions
>>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home
>>> --fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G
>>> -part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var
>>> --fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G
>>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home
>>> --fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --extra-space=
=3D100M
>>> +part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var
>>> --fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --extra-space=
=3D100M
>>> =C2=A0 =C2=A0 bootloader --ptable gpt --append=3D"console=3Dtty0
>>> console=3DttyS0,115200 rootwait earlyprintk"
>>
>> Jan
>>
> Thanks for the review
> Quirin

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


