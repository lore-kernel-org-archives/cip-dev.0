Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F43C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 16:30:48 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.63])
 by mx.groups.io with SMTP id smtpd.web10.13739.1677083441011453961
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Feb 2023 08:30:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BXJJJgcm;
 spf=pass (domain: siemens.com, ip: 40.107.105.63, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCQ7lPZXry9yWnu9QLl5UZsE1jkadqSRT2UpsMLpsendch5Bd1t70+vJlFt/RlGeUv0zA3fN65eGgy3tSiyv6lMVQK2PKqVp+Yz4Lntd0m2rLiqP5nGU6swHIxZqXEUPad2jCra9BL8EDYikZc+iuiRU7O8z+z3EygUbAhjoTwhai2YCt2PcL9W4rZVL55+pNYiv5+SzkOOBOKI8O9zGWbrdAjH2C6ehOVYABfkkAWM2MXnGs8rqS1JvmJaZlV9Q83PybJ3ZaCrXHlyse+RZKKe/kurRVS7iBlWuat4kHa6a5AS94IHQ6Y7zaKzAfKi19BU1dy5kXQdNpjKeKItB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYLJlx/D9NvhiJYUY1GPP6pzt3acjru0E00qA0PNDK0=;
 b=S6YCvcSX6PIqoKWVodjtd4XmaBY6yEeqr7g1RrKFD9t6JzTCgRAviqZvEaQPoFfvWrG4+x3dPmvhNSXn537v10aEEPqAgup5w59qzzl1yFLNdKjve0isBO1e1haM/GKdBjV+ZnkY6ErHT47fiJY75hheJhTKRGACO1sNQJX7Aykz0Km39As9jaksopzdruKjzl6UGxISNwr0+z55cYM1Ew7hJixSaTaz0gcZmj60Aierv2UC977QaSUf8JZN45/4oWbr3ZXilOX5LR2Crg/9YjXjtJOeZ7wJJZ5UminHCK0G9Ed7PpJWSKsVSIZcwA2WhSgFL8qtPgJGdklxwXF0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYLJlx/D9NvhiJYUY1GPP6pzt3acjru0E00qA0PNDK0=;
 b=BXJJJgcmYHkM8YzFjV6e3EC6+dHoAeghvx9wV6C5npco9vHDhZSLhC9YXeWs6SEgUX2w7JDl9GPAVU1gcLyHpcpeTs6pvLns9UX2zIz6nW84wrhW9DDWe65pJwvfVtj5mI1FJWLdU/8CZHi+KZUBA5XLGNGnRdvqcrdToRufhpyCZARptygIyLDrEC+HPgEaAEU+Pu8ryu8RPccgEVVoSZrgcAUXb1GCgkeQtAAedWWKUJDDKVTuJ0/JU/dHIAUfbWuZK5NmLkwx7YB2UhaB6QUkztLC9TA2sHXoKCopaO21lipTaKjL4WDuGSrhiWq/A6BJVBhKz5GfAyXBdTv48A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS1PR10MB5626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 16:30:37 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%6]) with mapi id 15.20.6134.018; Wed, 22 Feb 2023
 16:30:37 +0000
Message-ID: <4ba7b98c-738a-7daa-5493-abd60806a5c6@siemens.com>
Date: Wed, 22 Feb 2023 17:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [cip-dev][isar-cip-core][RFC v2 4/7] Add initramfs hook to
 encrypt a partition
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org,
 "Storm, Christian" <christian.storm@siemens.com>,
 "Kiszka, Jan" <jan.kiszka@siemens.com>
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-5-Quirin.Gylstorff@siemens.com>
 <eaaddc097c329305c0b002050fa6ac202183c49d.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <eaaddc097c329305c0b002050fa6ac202183c49d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:610:b3::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS1PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a16f39-e55c-4ba2-effb-08db14f22138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gRMHy0kf1XJxc2JiavP5IQgAl9Xd9sx7JWV7FBlIKME5OJZ35SqSj87+ZpImQCNTXdZOTSuEML5cvNVrm58NO1I4JISqUQptvgeNovSYATVV8V/2I13QUhWWrOFY4kSPe2Le/9JxU9kUlpOi11PJ3Pah/dsvVBDitLpcAf6sDL4G8X54TgFqAT8zbcJJJZm1ETD3reW/k4xKC2gqqYMZwM6WT5Qjukhdu1lHuHsVuLE6azejKJE3xOP1HrECklK4/5+dcWy1R8eavK6hGcPHKlsHPLYZxeWvm6HtOKLkgepIHZGT5ufAOv63dO85ILHodexRvTayYbV8bFmk9k6hdVkfT2Qn6/wiCBBKg368PB+y1vpkvWXj2sETF0jI0ZyN3vfAi6jSVzgEVgQK/TYs70Ka+BtGNZavQjyrlDiLdTw+fWpD4x/WN635r3xlryUIOUuklC9zpE+HlUorWctqih1EQp4O3516mxJXRs0dr96g25h7fuG5N4adzGKueIWpLPDmjHgTpJ32q5yS26h96BpRPtj6Rb2zol7sZN28DLpDNLzfDw6yQmrgKc6he4U5nXmrDvcTimPd0YHFRXxZlnlr7F8cmsbQ74KSrJizZSNfnfN+34kUyyCUWFY6TObw0ULPGnJjhKkw3u6NSoHRtFvMOrx4ZGIW9w1sW5cKbzJ6iVAVs/VpHK4vZu6HOHw/T07SNeW5nVyPZThbqh2WRmnOMXcuxx8rlJVODKGhpxV95kNDuRlBoUACTRqpW8gF11JP3j9Lu7HMAlE0Fx2dKW4STkGjGeadpqkudJh3z60=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(31696002)(31686004)(6636002)(316002)(5660300002)(41300700001)(26005)(30864003)(6486002)(966005)(66899018)(8936002)(478600001)(86362001)(8676002)(66476007)(66946007)(66556008)(2906002)(82960400001)(38100700002)(6506007)(6512007)(110136005)(53546011)(6666004)(2616005)(36756003)(186003)(83380400001)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1n40ZB7LqOA/+CHEiPnoFizJvJ0ERDGLPIXC2t4tFQJVf+v0+SIP+rH3XqpN?=
 =?us-ascii?Q?EVmzSO7s9HOcbTY4kiIwbIu9B/AOTazuIp8iMdBGYKZraTlg2U/cHMZWMI3Y?=
 =?us-ascii?Q?2TKDmOE2gaWG25V6IwW5AZLD5tOi2p97KYJDiAgvUK2oU2ITVD3k2rQc5pGz?=
 =?us-ascii?Q?0xn0VVxo3vVinG5UImOALlYBrh9VmCjBmAiLzzxnlTlLrHT5Ma8n/pY520v5?=
 =?us-ascii?Q?lLYbkSaskXFqroViPtwdLc4QlE3ew6g21DQ9oxYifx/CysBwTwJHfWBsO4cM?=
 =?us-ascii?Q?iTvg9aRGjnuE/u3HPnAhX6fXKh6NW0P73iyzM8Wurou31LnXMs5gfOKE7EI1?=
 =?us-ascii?Q?o7X4NYMBLx7bU8eBEcvViOvgMJCwRmNcYrG9KYJbALBQV1x9dLAblxrTuNaz?=
 =?us-ascii?Q?3o0v+dHFNE48V3e7yg15Sv3Sc0gasRJeLTfp6GYTU49IMncobVo3C2XchcjF?=
 =?us-ascii?Q?4pAbyrTzCZJZXM1/SnAgF/b6fvd8Drx+sfs64du6MJS1cYbKe2+YiAXFRAeI?=
 =?us-ascii?Q?7qSfiM16aJGXW5SWoW8YB+yD1cb/0JQJEyzjOPCyEPZBpDy4kNxQf4TSF+zM?=
 =?us-ascii?Q?AijJtrUFCHh0G/UfY5LYr6+f0YWRCY1QadCj8TJ7A2IQFCesz6H8yKUgyZmS?=
 =?us-ascii?Q?8tJ+aIA8Xlbu+mJCSp1KPJA0GyDo9jzSyNUK6tkGSBsn4eMcvOXAeLbprUyt?=
 =?us-ascii?Q?bXUlE58NgdxBx9c9XJvdZjDxcqTHVSNTgm7jPtm4RUeYVqfFbk1ivSjtO2Iy?=
 =?us-ascii?Q?ZVQ4RT5LeTUQs48gg6B2BI94/1Sh3iFLIYGBsUel3Oha6qXuicPc3zP4WSqO?=
 =?us-ascii?Q?sG2aJsOu0uxQjHj1T/B0fXs8iMO9Yxl26fJEEl1RdUwvQFDUs2S4GqwOfzSX?=
 =?us-ascii?Q?FFxavni41+QfPQD4CJzQQzzykVVrK1dpEjSA7v4u6ayoKOx4yUj7491Ay68A?=
 =?us-ascii?Q?2a7zPeavnNEpGVr71biRNFL16U/h05uSpt/4AcpiVi7AI6QjICQDYSp26Y0Y?=
 =?us-ascii?Q?vRrIZpcI9jjxXlirsrVT6iGER9kAu3C+mrbtiDN1cBLjunt+bmvHQqAWQgXt?=
 =?us-ascii?Q?5vP+Fv22frsuxs7Egt7drcAk6n49jWVjzAfqzAR9+2v7bjaBZ9nz2xO3297F?=
 =?us-ascii?Q?SRorOedekqQb1PmrHvdIfZezvUdBjP571KuFCOuHYyYc/Y70E4HIINf8dZDZ?=
 =?us-ascii?Q?5Fuja+Y9miICKMEPxRfenCW/zcW74t+GvnNgzpBT71DGSteTZgqJ/7wkMjLw?=
 =?us-ascii?Q?WHP2mE2U94euXDq5d90NAxW9hKOLXlBw2rS3gMQohZDhCRZztoALwmuWKqY8?=
 =?us-ascii?Q?EJSE5HQtIP1vZrExhUky/Epc4OJ63G1P1Oi5TqCxIwyuHNqazxfy+VnG8fW7?=
 =?us-ascii?Q?Jd3tK/IlS+uGh/NE5NLs5DWlfW9Fq2avVj6QA0z0y0zKBVKfljj2zPbRPoit?=
 =?us-ascii?Q?FW5hFY05b38gf930NLNd3LKAeVYvONAjsXiIQv3uHXnaexpdKXg2W1/mP4Cp?=
 =?us-ascii?Q?tUZqQHGq5RvnPxFZpgnfwj9jWJZ7/7RRpeJ9678LmM0VmdGEpL2lh/MJUD5+?=
 =?us-ascii?Q?PoTslDW6n7/UkbMjICCh//n0xgVIYNlhNZOv6xRKll+29G9JSjyhZ6Ej6bsv?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a16f39-e55c-4ba2-effb-08db14f22138
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 16:30:37.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/Ipf819moNaLnwDNthwW6wUZdb1DKpV1LgkSQVegwiYIbHD7K94QiJAUDLHUk4OsSJxk9qlJo9ZEt/mJB7v0k6nxc8T+bWTIJyEvZU7UB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5626
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 16:30:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10783



On 2/18/23 09:10, Felix Moessbauer via lists.cip-project.org wrote:
> On Fri, 2023-02-17 at 14:05 +0100, Quirin Gylstorff via lists.cip-
> project.org wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This creates a new luks encrypted ext4 partition with a the
>> key stored in the tpm2.
>>
>> The initial key is randomly generated and removed from the
>> LUKS partition. Therefore a new key cannot be added by the user
>> and if the LUKS header is corrupted the data is no longer readable.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0.../files/encrypt_partition.env.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>  =C2=A0.../files/encrypt_partition.hook=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 49 +++++++
>>  =C2=A0.../files/encrypt_partition.script=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 135
>> ++++++++++++++++++
>>  =C2=A0.../initramfs-crypt-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 37 +++++
>>  =C2=A0wic/x86-efibootguard.wks.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 4 +-
>=20
> Does this - in theory - also work with systemd-boot or grub? Currently
> we have ISAR bugs that prevent us from using sd-boot or grub with a
> custom initramfs, but once that is fixed, this could be an option.
>=20
> Not directly related:
> As we put more-and-more features into the cip initramfs: Is there
> actually a need to use a custom one, or can we simply add these
> packages to the image and use its initrd? What is the benefit of having
> the custom initrd?

The initramfs could be stored in the image but as we implement an image=20
based update process and the user should not exchange the UKI -=20
especially in the secure boot usecase - it makes no sense to store the=20
initramfs recipes in the image.

Also this will add all the dependencies which often are not necessary to=20
the image.

Quirin
>=20
> Felix
>=20
>>  =C2=A05 files changed, 225 insertions(+), 2 deletions(-)
>>  =C2=A0create mode 100644 recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.env.tmpl
>>  =C2=A0create mode 100644 recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.hook
>>  =C2=A0create mode 100644 recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script
>>  =C2=A0create mode 100644 recipes-initramfs/initramfs-crypt-hook/initram=
fs-
>> crypt-hook_0.1.bb
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-
>> crypt-hook/files/encrypt_partition.env.tmpl
>> new file mode 100644
>> index 0000000..943fe4b
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.env.tmpl
>> @@ -0,0 +1,2 @@
>> +PARTITIONS=3D"${CRYPT_PARTITIONS}"
>> +REDUDUCE_DEVICE_SIZE=3D"${CRYPT_REDUDUCE_DEVICE_SIZE}"
>> diff --git a/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.hook b/recipes-initramfs/initramfs-
>> crypt-hook/files/encrypt_partition.hook
>> new file mode 100644
>> index 0000000..96e084a
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.hook
>> @@ -0,0 +1,49 @@
>> +#!/bin/sh
>> +# Copyright (C) Siemens AG, 2020-2022
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +PREREQ=3D""
>> +
>> +prereqs()
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo "$PREREQ"
>> +}
>> +
>> +case $1 in
>> +prereqs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0 prereqs
>> +=C2=A0=C2=A0=C2=A0=C2=A0 exit 0
>> +=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +esac
>> +
>> +. /usr/share/initramfs-tools/scripts/functions
>> +. /usr/share/initramfs-tools/hook-functions
>> +
>> +manual_add_modules tpm
>> +manual_add_modules tpm_tis_core
>> +manual_add_modules tpm_tis
>> +manual_add_modules tpm_crb
>> +manual_add_modules dm_mod
>> +manual_add_modules dm_crypt
>> +
>> +copy_exec /usr/bin/openssl
>> +copy_exec /usr/sbin/mke2fs
>> +copy_exec /usr/bin/grep
>> +copy_exec /usr/bin/awk
>> +copy_exec /usr/bin/expr
>> +copy_exec /usr/sbin/e2fsck
>> +copy_exec /usr/sbin/resize2fs
>> +copy_exec /usr/sbin/cryptsetup
>> +copy_exec /usr/bin/systemd-cryptenroll
>> +copy_exec /usr/lib/systemd/systemd-cryptsetup
>> +
>> +if [ -x cryptsetup-reencrypt ]; then
>> +=C2=A0=C2=A0=C2=A0 copy_exec /usr/sbin/cryptsetup-reencrypt
>> +fi
>> +
>> +for _LIBRARY in /usr/lib/*/libtss2*; do
>> +=C2=A0=C2=A0=C2=A0 copy_exec "$_LIBRARY"
>> +done
>> +
>> +copy_file library /usr/share/encrypt_partition/encrypt_partition.env
>> /usr/share/encrypt_partition/encrypt_partition.env
>> diff --git a/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-
>> crypt-hook/files/encrypt_partition.script
>> new file mode 100644
>> index 0000000..e58794e
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-
>> hook/files/encrypt_partition.script
>> @@ -0,0 +1,135 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +prereqs()
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# Make sure that this script =
is run last in local-top
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0local req
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for req in "${0%/*}"/*; do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0script=3D"${req##*/}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if [ "$script" !=3D "${0##*/}" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0printf=
 '%s\n' "$script"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0done
>> +}
>> +case $1 in
>> +prereqs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prereqs
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit 0
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0;;
>> +esac
>> +
>> +. /scripts/functions
>> +
>> +# get configuration variables
>> +. /usr/share/encrypt_partition/encrypt_partition.env
>> +
>> +# load necessary kernel modules:
>> +modprobe tpm_tis
>> +modprobe tpm_crb
>> +
>> +# fixed tpm device or do we need to find it
>> +tpm_device=3D/dev/tpmrm0
>> +partition_sets=3D"$PARTITIONS"
>> +
>> +open_tpm2_partition() {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! /usr/lib/systemd/systemd=
-cryptsetup attach
>> "$crypt_mount_name" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "$1" - tpm2-device=3D"$tpm_device"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0panic "Can't decrypt '$1' !"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>> +}
>> +
>> +enroll_tpm2_token() {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0#check systemd version and ex=
port password if necessary
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -x /usr/bin/systemd-cryp=
tenroll ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0systemd_version=3D$(systemd-cryptenroll --version | \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 awk -F " "
>> 'NR=3D=3D1{print $2 }')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0#check systemd version and export password if
>> necessary
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if [ "$systemd_version" -ge "251" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PASSWO=
RD=3D$(cat "$2" )
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0export=
 PASSWORD
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/b=
in/systemd-cryptenroll --tpm2-
>> device=3D"$tpm_device" \
>> +
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --tp=
m2-pcrs=3D7 "$1"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PASSWO=
RD=3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0panic =
"Unknown systemd version:
>> '$systemd_version'!"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>> +}
>> +
>> +reencrypt_existing_partition() {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0part_device=3D$(readlink -f "=
$partition")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0part_size_blocks=3D$(cat /sys=
/class/block/"$(awk -v
>> dev=3D$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size=3D$(expr $part_s=
ize_blocks - 65536 )
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_byte=3D$(expr=
 $reduced_size \* 512)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_kb=3D$(expr $=
reduced_size_in_byte / 1024)K
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resize2fs "$1" "$reduced_size=
_in_kb"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -x cryptsetup-reencrypt =
]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/usr/sbin/cryptsetup-reencrypt --new --reduce-device-
>> size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/usr/sbin/cryptsetup reencrypt --encrypt --reduce-
>> device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>> +
>> +}
>> +
>> +
>> +if [ ! -e "$tpm_device" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0panic "tpm device '$tpm_devic=
e' does not exists - cannot
>> create a encrypted device!"
>> +fi
>> +
>> +for partition_set in $partition_sets; do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0partition_label=3D$(awk -v va=
r=3D$partition_set
>> 'BEGIN{split(var,a,":"); print a[1]}')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0partition_mountpoint=3D$(awk =
-v var=3D$partition_set
>> 'BEGIN{split(var,a,":"); print a[2]}')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0partition_format=3D$(awk -v v=
ar=3D$partition_set
>> 'BEGIN{split(var,a,":"); print a[3]}')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0partition=3D/dev/disk/by-part=
label/$partition_label
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0crypt_mount_name=3D"encrypted=
_$partition_label"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0decrypted_part=3D/dev/mapper/=
"$crypt_mount_name"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# check if partition is alrea=
dy encrypted with systemd-tpm2
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if /usr/sbin/cryptsetup luksD=
ump --batch-mode "$partition" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| grep=
 -q "systemd-tpm2"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0open_tpm2_partition "$partition"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ! mount -t $(get_fstype "${decrypted_part}")
>> "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Can't mount encrypted partit=
ion
>> '${decrypted_part}'!"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0continue
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# create random password for =
initial encryption
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# this will be dropped after =
reboot
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tmp_key=3D/tmp/"$partition_la=
bel-lukskey"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0openssl rand -base64 32 > "$t=
mp_key"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case "${partition_format}" in
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "reencrypt")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reencrypt_existing_partition "$part=
ition"
>> "$tmp_key"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enroll_tpm2_token "$partition" "$tm=
p_key"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partition "$partition"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "format")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup luksFormat --b=
atch-mode \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --type
>> luks2 "$partition" < "$tmp_key"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enroll_tpm2_token "$partition" "$tm=
p_key"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partition_tpm2_partition =
"$partition"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mke2fs -t ext4 "${decrypted_part}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Unknown value ${partition_fo=
rmat}. Cannot
>> create a encrypted partition !"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0esac
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! mount -t $(get_fstype "$=
{decrypted_part}")
>> "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0panic "Can't mount encrypted partition
>> '${decrypted_part}'!"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# delete initial key
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# afterwards no new keys can =
be enrolled
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/bin/systemd-cryptenroll =
"$partition" --wipe-slot=3D0
>> +done
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.1.bb
>> new file mode 100644
>> index 0000000..ba2b884
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>> hook_0.1.bb
>> @@ -0,0 +1,37 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2020-2022
>> +#
>> +# Authors:
>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +
>> +inherit dpkg-raw
>> +
>> +DEBIAN_DEPENDS =3D "initramfs-tools, cryptsetup, systemd(>=3D 251), \
>> +=C2=A0=C2=A0=C2=A0 awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, lib=
tss2-mu0,
>> e2fsprogs"
>> +
>> +SRC_URI +=3D "file://encrypt_partition.hook=C2=A0\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
://encrypt_partition.script=C2=A0\
>> +=C2=A0=C2=A0=C2=A0 file://encrypt_partition.env.tmpl"
>> +
>> +CRYPT_PARTITIONS ??=3D "home:/home:reencrypt var:/var:reencrypt"
>> +CRYPT_REDUDUCE_DEVICE_SIZE=3D"32M"
>> +
>> +TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_REDUDUCE_DEVICE_SIZE"
>> +TEMPLATE_FILES =3D "encrypt_partition.env.tmpl"
>> +
>> +do_install[cleandirs] +=3D " \
>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/hooks \
>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/encrypt_partition \
>> +=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/scripts/local-bottom"
>> +do_install() {
>> +=C2=A0=C2=A0=C2=A0 install -m 0600 "${WORKDIR}/encrypt_partition.env"
>> "${D}/usr/share/encrypt_partition/encrypt_partition.env"
>> +=C2=A0=C2=A0=C2=A0 install -m 0755 "${WORKDIR}/encrypt_partition.script=
" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${D}/usr/share/initramfs-to=
ols/scripts/local-
>> bottom/encrypt_partition"
>> +=C2=A0=C2=A0=C2=A0 install -m 0755 "${WORKDIR}/encrypt_partition.hook" =
\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "${D}/usr/share/initramfs-to=
ols/hooks/encrypt_partition"
>> +}
>> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-
>> efibootguard.wks.in
>> index b635a8b..1d29583 100644
>> --- a/wic/x86-efibootguard.wks.in
>> +++ b/wic/x86-efibootguard.wks.in
>> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams
>> "file=3D${IMAGE_FULLNAME}.squashfs" --align 1
>>  =C2=A0part --source empty --align 1024 --fixed-size 1G --uuid
>> "${ABROOTFS_PART_UUID_B}"
>>  =20
>>  =C2=A0# home and var are extra partitions
>> -part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G
>> -part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G
>> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home --
>> fstype=3Dext4 --label home --align 1024=C2=A0 --size 1G --extra-space=3D=
100M
>> +part /var --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var --
>> fstype=3Dext4 --label var --align 1024=C2=A0 --size 2G --extra-space=3D1=
00M
>>  =20
>>  =C2=A0bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS=
0,115200
>> rootwait earlyprintk"
>>
>>
>>
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#10740): https://lists.cip-project.org/g/cip-dev/messa=
ge/10740
> Mute This Topic: https://lists.cip-project.org/mt/97027311/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

