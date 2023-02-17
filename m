Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D36CC64EC4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:07:04 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.71])
 by mx.groups.io with SMTP id smtpd.web11.8489.1676646414032011975
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:06:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HDzPBF4C;
 spf=pass (domain: siemens.com, ip: 40.107.6.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqvTR8DbsmF3JDVOYMBR69jCfZIe5vFPUQazR02p0esOSI7ODDE+MMQqZBWDpUSnhw1l5e91cFI8pbVSj5VdVDm7PnVZOuJ7y+mk8k+h/KAd25PPsE550lSbcviZMYSFHMf0K7QxUmHqLJ8nW05fo3pH0E0MXbGY/LQAO/nnsr0vbEg4MROs+rcC88Pct6j3Q+8NYzoKmBQYDGKKE+C2tq173QZ7Qmb6VXiDV/oqJtIkqdyi3iSVdsMZc/z5+xfMDGMpM288aMeRQFzDbvz25pQB0jOdr3CO49+pxwwzofhlX5GdMWXpV3XDjvAXtOSU7ZZAwIW+e411JFU+z/2Mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F11N/vVHpt26qOkg3f09GbOokU27Lt9XBhJdWYmzuxo=;
 b=SpE1/bkOC54dksvYpltNlDcZ1VjqiaSGmdpuNdKpX9Hus/6rR4qP98xgSmPy+0kqQ3a+jnf+Oq/mVVhidpca5mVgcUHlJLU1SwME/haGwr5mQsk9S8wUckDUukeJTKDLkNIvuyZogOY1nRaYQ92W6N0XuUWu//9nUizU+Klo9yS+/t7Aig+4J6Or8wZD847EjvRCjx3HHt9Z0SIZLpHupL95kzuqWVcx5F5gXOf7nBenujZhAtF2UrUWrQdYfLdpmSgeYSY494+bP3PItpbO74n/r9dQxg2sEjkulbu16k+BhYN6kokdLdla/A6X74WKEkK9RzYguApVW8JCA1lIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F11N/vVHpt26qOkg3f09GbOokU27Lt9XBhJdWYmzuxo=;
 b=HDzPBF4C6jr47NAfV60zopSxFgESpsEUKAem26z0iiVCQ9vEoGKUeMspKxTvuvGZdMKajbE/Ygjv2/jl+b5RqubbxT7TWMGywsfMY4askWvoYB7x6FoJsLQOZ2uZ38ts9cMusqy4Xm3M3Q4LrUfkwxrO9A4Ll2OYLBvtqodzACWjhT02QHFYNoyAlr759WNmRaG7dmncNK6te/t4YlmORwBYJTbL3DSF1VuSUtNZMs/00e9+yzdvtM1w9SnFrq8yvxweCNoBfSCM9pMFtQb7eDC0inB9c4ALUc5ePX+CA5x0nEl/fegVqoK3+xm5Gg1wjGq9wke97ukdQ4l7cLxuTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 15:06:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%5]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 15:06:50 +0000
Message-ID: <00766d63-d1cc-c792-c5bd-8c7d4a3778d4@siemens.com>
Date: Fri, 17 Feb 2023 16:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 4/7] Add initramfs hook to
 encrypt a partition
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-5-Quirin.Gylstorff@siemens.com>
 <2012e77d-1892-1797-3161-b834ccebda86@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <2012e77d-1892-1797-3161-b834ccebda86@siemens.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070204040607040207010306"
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b512509-684d-4105-2157-08db10f898c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IVo2fbxxwO7i5qqU4OKYXsvrUMBfcnj4Jx5IQG21NdBgtzDTo/OhScrFJfMPgT+j+wmb5lOxb48sTAYM8jcMg6r3rS0f7B2nJuTeNU4NuHCs9M8PKPSM31g2VVVpC6vxiniIToG0K/PtEDoBBZPFaP1Omw9dkdZAS7MhPUsA/z9H3A9Fx/uwCb7j5hwU6rS3ZHorjNUBA9nG9V0yVofGnLdV7Ku3Wfnfh+K+X1xE6Vw0KyjyuHiCihsOGcf6PkS/WqE3rYV9wh8cYo2ayXnSPe46CO66T3EMMQNT4xq8uQDJSF3MBosr1RCNPnugiJwCIZD+Gd0fSFv+5F7sx6scRGXJqGP3isoq7oHE8fm8ATvFKGZ8vDOT5Jtfia5Mv7ffUbiopj3SZO9yKDpj53nLI1riTPrsP7oJJXpf+uS0ey/mhR5oSTcR4RVxPsvusAESkjoDxSWAo3EKSpzGq1yMc+MxzGEPkHBJsJkYnuib9D3aGwVb7laWdE0XVL4teEBDM2Lcn1bcZ2s5XXjPnSwdvpe7MxH1dbHiVJi6sl87vgNB1A8RGlNJDq7ikVm632YvaqIkojBOn9zYKNGDO3/9Td2gh/XDn1NQ+OoF+dzHwbbqwOY/wycNxgyXAQ3N4YehwsD/w5KlWWZf47uBAPgyV9ECMIWorbAxnmjNZVqdVdWZL6H+ttgKJOA8/8xEyJqo6lgxSiUfAqazvmU3HlnwZ1CAGDu7l+yEF+KfHcnRY+WUtcRvZh0ClIzK9SOkIZ9A8VSxLzS+oxY63NmW/ukm1w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(6486002)(2616005)(33964004)(186003)(83380400001)(26005)(6512007)(53546011)(478600001)(6666004)(6506007)(36756003)(86362001)(31696002)(38100700002)(41300700001)(8936002)(6636002)(5660300002)(66556008)(82960400001)(316002)(235185007)(2906002)(66946007)(8676002)(30864003)(66476007)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3hsbE52VG9VVmhFRzFRRFptSDBnc3BSbHh6b1l6SXlrc085Q3ZUdHZNUXRt?=
 =?utf-8?B?cVRXM0R5RUUrRDJWaTJIYXcxcXNDdW96RnhoMnh1enlQVGw5T1BHQ29aY0ND?=
 =?utf-8?B?SEs2YnluUWd5MXNTczlEd0hhdFZQYjFmTk90K3N0S05waHRWek9keFRUSXQ5?=
 =?utf-8?B?UGtvMzJTeHBxS2E3Ry9TdUoxejZheDBKeHZFL2NDa1c1cTR2Mk1JcXZsdHV2?=
 =?utf-8?B?cjJWTFUwN2VwazFPNGpLaFpFQzl3S2VWbWdMT3NtWGdNSWJlN2t4Q1lxa3Nr?=
 =?utf-8?B?cXR5Q1oxTlQrR3YxZkJFcFFEOTQ4SmJJeWpzMjlJK1l4SVdLYzdCc09rUXh3?=
 =?utf-8?B?M2g5YXJESFRyM3g2T3lUM2FIUUtPVUtOVDF3cCtwQ0orUnVQdWN3bVNKelYy?=
 =?utf-8?B?SUF5eWtSZmw1eVhTUWQ4dkZjeTg5enBVUHdIbEhHRnZuTzcrWHdTSWpkWklN?=
 =?utf-8?B?ZHJWT002bGJxT2srQWxTSDZiUUp1MnowVWJNYmV6M2dIak5XT2RZWHR6bFpp?=
 =?utf-8?B?elRDbWEwY01QMU5ReGs0WWo5Z0p0YVRsbEo0UExaQnQ2b2dqNzJJcXJKSTJR?=
 =?utf-8?B?cGwweFM2RGpYQ1puTE5tTEs2WjRHWWtzbVYvTFE4K1pmMzZQSThqZkJsK2ZC?=
 =?utf-8?B?RTFEK3duZnV2MXhzTFBUMzZLUldsTHNOWDJoL2szNm9ldWJBMFN1WWdqK3Av?=
 =?utf-8?B?U1oyTEszaVgwR0RZUFZiSnVjdUl1a0ZmNFg3cjg1VUVIUS9HYVJTM1pFZGI2?=
 =?utf-8?B?UEh3MXlOdWtHc0gzU0dlTGlJYnFWYURoczJpbzdIeXhEUUR5b054c1VTd1pY?=
 =?utf-8?B?OXJ1QXNGeTZDbDlwYU1Jb3FrdnVvQ2VzZGFVWU1VanpMTUJZaDEyUWRBTnZE?=
 =?utf-8?B?OGsvWVZvK293YitQWjJMbFpuZ2J2QVh2SVBxckp5OTJ5SEtxZmlnQmMxaFBs?=
 =?utf-8?B?aWFZeGZNMGhMZnFML0ZBM25nNnF4OGxIUmhiSkZqdSswWU9WdklWNVNvNHY3?=
 =?utf-8?B?OWV5Y3lRRXdFREZnMy82QmE2WjBrbEdNMXl4R3JrUm0zRnExZnJGTnBPaktk?=
 =?utf-8?B?SFRBZTN1K1ZZek1SYTFsWS93VHdkdmhzMGQyaFo0R0w4ZmZjejBQaUM0eitX?=
 =?utf-8?B?dUlPUHJyaWRaK3QwWEtMdTNsNTVkb1EwYkJuYXU2YWVBaGlyZlFOL3dCR3Av?=
 =?utf-8?B?dkVCbzM4YkhIODZUM0ZMMWwzMXR3WkhESlk1SGdQZlU0d1VyNTFYN2VlOGlz?=
 =?utf-8?B?LzJzZlFEUFk2NDRKK0pXV3h6dzJKWXVOa282Smd1NmFZK0dGMkx5UXBsYWY0?=
 =?utf-8?B?aW9vWlQyQWJ5andJVUU1YjBTdW9VMWRxZWdiUVEvU1B1Qm9sVTZndjR1aS9Q?=
 =?utf-8?B?MzNDRWhHdDIwSjgrRmUvMVBIRy9UUEhWVmJKcU41a0MzYlNuT0FYYlB0K2hZ?=
 =?utf-8?B?TGsvTkZEcU1Ca2Nmb21JVGRUbTc4YmlXWFRoajd4VDV4MVVJMms5R1RWZWdm?=
 =?utf-8?B?YjMvdk0vN3dnOHJJR2xza2dHend4NkI1amhoNS93a2JEWlJuZCt2MGJZNmpr?=
 =?utf-8?B?OTBjd3R0QVR6WFFhZkQvZkxBdnY0WGMyUmRPajZFY3FpWlJ4QS9aSng4cDdH?=
 =?utf-8?B?TnRnaHdxazBNSnIyNGM4VnpLODA1M2R3ME1pU01XdGg3bFFOcDErbFBza1VV?=
 =?utf-8?B?V1ZISXU5Z1R5NmVqblQ4bXJkVzlXa1JkbGpOZ09oNVZvTzFVZ0E4QzFNeGMv?=
 =?utf-8?B?OWtQMU9FemJWZTkzWklHNUdQVmxma2c4M1hXVWg2cFFCNlgvWWdUQ3NjdDRh?=
 =?utf-8?B?Mmp6MWJabElJWnRRTDJ2WU5JTURKL3U4RG0vYjFIaXhRa01IbDJpeVgrRUN1?=
 =?utf-8?B?WGZXZ2E0ZFVXWXkrY0k1VWM2dlBzek9rS1h6d0MwbXA0d2RNWkkrWnFjTTVN?=
 =?utf-8?B?bEd5L0dYOGNRcUZRSE9oT0U0UEdwSEdMVjIwM1F2dTVtR1VPNzNyTDd2UVJY?=
 =?utf-8?B?Q25BU0hmS0VYbllmd1NkV1doUnJZanFFU3ZaY0ZHOXd0VFpRWU9wZWRPQUh6?=
 =?utf-8?B?UlN5NnhoN0xmREVXZE80eFZiOEk4S1paVUR5dDBNcEJDU20vMHQ5SkNEL2tY?=
 =?utf-8?B?Vzk2c21qYlBkSmVGYUJLT2lrR1JQbWpEbit5REYrOWZPS1RlME5reEJaU29a?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b512509-684d-4105-2157-08db10f898c1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:06:50.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG91O8O/0vX20/7werRjbP60PAscENgehKiplPUTAC39wDzmRhGnK6Ly9Trq+G0IN3vWIsdoi33UXdepOGi9l+MBlChI5tC3hjTNRWiQnsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10726

--------------ms070204040607040207010306
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/23 15:53, Jan Kiszka wrote:
> On 17.02.23 14:05, Quirin Gylstorff wrote:
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
>>   .../files/encrypt_partition.env.tmpl          |   2 +
>>   .../files/encrypt_partition.hook              |  49 +++++++
>>   .../files/encrypt_partition.script            | 135 ++++++++++++++++++
>>   .../initramfs-crypt-hook_0.1.bb               |  37 +++++
>>   wic/x86-efibootguard.wks.in                   |   4 +-
>>   5 files changed, 225 insertions(+), 2 deletions(-)
>>   create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>   create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>   create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>>   create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> new file mode 100644
>> index 0000000..943fe4b
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> @@ -0,0 +1,2 @@
>> +PARTITIONS="${CRYPT_PARTITIONS}"
>> +REDUDUCE_DEVICE_SIZE="${CRYPT_REDUDUCE_DEVICE_SIZE}"
> 
> Did you mean "REDUCE"?
That was my intenion will fix it in v3.
> 
> And what is this variable for?

If you use online reencryption on a populated partition you need to 
create the space for the LUKS header. The necessary minimum size is 32MB.
As an alternative you can detach the LUKS header.


> 
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>> new file mode 100644
>> index 0000000..96e084a
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>> @@ -0,0 +1,49 @@
>> +#!/bin/sh
>> +# Copyright (C) Siemens AG, 2020-2022
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +PREREQ=""
>> +
>> +prereqs()
>> +{
>> +     echo "$PREREQ"
>> +}
>> +
>> +case $1 in
>> +prereqs)
>> +     prereqs
>> +     exit 0
>> +     ;;
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
>> +    copy_exec /usr/sbin/cryptsetup-reencrypt
>> +fi
>> +
>> +for _LIBRARY in /usr/lib/*/libtss2*; do
>> +    copy_exec "$_LIBRARY"
>> +done
>> +
>> +copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>> new file mode 100644
>> index 0000000..e58794e
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>> @@ -0,0 +1,135 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +prereqs()
>> +{
>> +	# Make sure that this script is run last in local-top
>> +	local req
>> +	for req in "${0%/*}"/*; do
>> +		script="${req##*/}"
>> +		if [ "$script" != "${0##*/}" ]; then
>> +			printf '%s\n' "$script"
>> +		fi
>> +	done
>> +}
>> +case $1 in
>> +prereqs)
>> +	prereqs
>> +	exit 0
>> +	;;
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
>> +tpm_device=/dev/tpmrm0
>> +partition_sets="$PARTITIONS"
>> +
>> +open_tpm2_partition() {
>> +	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
>> +		 "$1" - tpm2-device="$tpm_device"; then
>> +		panic "Can't decrypt '$1' !"
>> +	fi
>> +}
>> +
>> +enroll_tpm2_token() {
>> +	#check systemd version and export password if necessary
>> +	if [ -x /usr/bin/systemd-cryptenroll ]; then
> 
> And if that file does not exist? No error? No bail-out?
>

I will remove that check and move it to the hook and fail during build 
time. Is that better?

>> +		systemd_version=$(systemd-cryptenroll --version | \
>> +							  awk -F " " 'NR==1{print $2 }')
>> +		#check systemd version and export password if necessary
>> +		if [ "$systemd_version" -ge "251" ]; then
>> +			PASSWORD=$(cat "$2" )
>> +			export PASSWORD
>> +			/usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
>> +										 --tpm2-pcrs=7 "$1"
>> +			PASSWORD=
>> +		else
>> +			panic "Unknown systemd version: '$systemd_version'!"
>> +		fi
>> +	fi
>> +}
>> +
>> +reencrypt_existing_partition() {
>> +	part_device=$(readlink -f "$partition")
>> +	part_size_blocks=$(cat /sys/class/block/"$(awk -v dev=$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
>> +	reduced_size=$(expr $part_size_blocks - 65536 )
>> +	reduced_size_in_byte=$(expr $reduced_size \* 512)
>> +	reduced_size_in_kb=$(expr $reduced_size_in_byte / 1024)K
>> +	resize2fs "$1" "$reduced_size_in_kb"
>> +	if [ -x cryptsetup-reencrypt ]; then
>> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>> +	else
>> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>> +	fi
>> +
>> +}
>> +
>> +
> 
> One newline should be enough here.
Will fix in v3.

> 
>> +if [ ! -e "$tpm_device" ]; then
>> +	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
>> +fi
>> +
>> +for partition_set in $partition_sets; do
>> +	partition_label=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[1]}')
>> +	partition_mountpoint=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[2]}')
>> +	partition_format=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[3]}')
>> +	partition=/dev/disk/by-partlabel/$partition_label
>> +	crypt_mount_name="encrypted_$partition_label"
>> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
>> +
>> +	# check if partition is already encrypted with systemd-tpm2
>> +	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
>> +			| grep -q "systemd-tpm2"; then
>> +		open_tpm2_partition "$partition"
>> +		if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>> +		    panic "Can't mount encrypted partition '${decrypted_part}'!"
>> +		fi
>> +		continue
>> +	fi
>> +
>> +	# create random password for initial encryption
>> +	# this will be dropped after reboot
>> +	tmp_key=/tmp/"$partition_label-lukskey"
>> +	openssl rand -base64 32 > "$tmp_key"
>> +
>> +	case "${partition_format}" in
>> +        "reencrypt")
>> +		    reencrypt_existing_partition "$partition" "$tmp_key"
>> +		    enroll_tpm2_token "$partition" "$tmp_key"
>> +		    open_tpm2_partition "$partition"
>> +        ;;
>> +        "format")
>> +		    /usr/sbin/cryptsetup luksFormat --batch-mode \
>> +							     --type luks2 "$partition" < "$tmp_key"
>> +		    enroll_tpm2_token "$partition" "$tmp_key"
>> +		    open_tpm2_partition_tpm2_partition "$partition"
>> +		    mke2fs -t ext4 "${decrypted_part}"
> 
> We likely want to make this line configurable at recipe-level, both
> regarding fs options as well as the fs type itself.

I will add an additional field to the configuration string.

> 
>> +        ;;
>> +        *)
>> +		    panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
>> +         ;;
>> +	esac
>> +
>> +	if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>> +		panic "Can't mount encrypted partition '${decrypted_part}'!"
>> +	fi
>> +
>> +	# delete initial key
>> +	# afterwards no new keys can be enrolled
>> +	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
>> +done
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> new file mode 100644
>> index 0000000..ba2b884
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> @@ -0,0 +1,37 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2020-2022
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +
>> +inherit dpkg-raw
>> +
>> +DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, systemd(>= 251), \
>> +    awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
>> +
>> +SRC_URI += "file://encrypt_partition.hook \
>> +            file://encrypt_partition.script \
>> +    file://encrypt_partition.env.tmpl"
>> +
>> +CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>> +CRYPT_REDUDUCE_DEVICE_SIZE="32M"
>> +
>> +TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_REDUDUCE_DEVICE_SIZE"
>> +TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>> +
>> +do_install[cleandirs] += " \
>> +    ${D}/usr/share/initramfs-tools/hooks \
>> +    ${D}/usr/share/encrypt_partition \
>> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
>> +do_install() {
>> +    install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
>> +    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
>> +        "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
>> +    install -m 0755 "${WORKDIR}/encrypt_partition.hook" \
>> +        "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
>> +}
>> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
>> index b635a8b..1d29583 100644
>> --- a/wic/x86-efibootguard.wks.in
>> +++ b/wic/x86-efibootguard.wks.in
>> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>>   part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>>   
>>   # home and var are extra partitions
>> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
>> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
>> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M
>> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
>>   
>>   bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
> 
> Jan
> 
Thanks for the review
Quirin

--------------ms070204040607040207010306
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
GTAwggdkMIIFTKADAgECAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEBCwUAMIGeMQsw
CQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQMA4GA1UE
CgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjMxHTAbBgNVBAsMFFNpZW1lbnMgVHJ1c3Qg
Q2VudGVyMScwJQYDVQQDDB5TaWVtZW5zIElzc3VpbmcgQ0EgRUUgRW5jIDIwMjAwHhcNMjEw
MjEwMDczNjM0WhcNMjQwMjEwMDczNjM0WjBlMREwDwYDVQQFEwhaMDAxMDhZVTEPMA0GA1UE
KhMGUXVpcmluMRIwEAYDVQQEEwlHeWxzdG9yZmYxEDAOBgNVBAoTB1NpZW1lbnMxGTAXBgNV
BAMTEEd5bHN0b3JmZiBRdWlyaW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCA
qN/x1wdiSvw0dSlpuclq8Fwi4S3ldLu4MdKANA3DfDb+nd5jbRSKI09GYII3iFV4YkNDUtlq
73VQoJX0udyZM8JoYQ5Z5HaOBNWcXTcjL48LKsZrKsk7UUP2FBn3/bR9VGslALN+8em+6qVr
ZDkxVfRl3xEMi5EgVtorSAIP/RfspM9XWb/WhZJCASsl4fY8+pOjrGxQnitRc6VYXwUZAM7r
L1qX0eLGwAnaa8b5OvNtAxE2VVkAjyTnE5NoiCnbsi6Q+zX3/Ai8zv4pqkbUsHNoLg+qzJsa
CdD5TtfpwNgJgdQfD6Z0F89b7Xg36G7KZllulvicX62fFqzwx2dlAgMBAAGjggLUMIIC0DA4
BgNVHSUEMTAvBggrBgEFBQcDBAYKKwYBBAGCNwoDBAYLKwYBBAGCNwoDBAEGCisGAQQBgjdD
AQEwHwYDVR0jBBgwFoAUtvmR44WfDDy2iXJTnkE0jXAq+b0wgfcGCCsGAQUFBwEBBIHqMIHn
MDIGCCsGAQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkIzLmNydDBB
BggrBgEFBQcwAoY1bGRhcDovL2FsLnNpZW1lbnMubmV0L0NOPVpaWlpaWkIzLEw9UEtJP2NB
Q2VydGlmaWNhdGUwSQYIKwYBBQUHMAKGPWxkYXA6Ly9hbC5zaWVtZW5zLmNvbS9DTj1aWlpa
WlpCMyxvPVRydXN0Y2VudGVyP2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9v
Y3NwLnNpZW1lbnMuY29tMEYGA1UdIAQ/MD0wOwYNKwYBBAGhaQcCAgMBAzAqMCgGCCsGAQUF
BwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kvMIHKBgNVHR8EgcIwgb8wgbyggbmg
gbaGJmh0dHA6Ly9jaC5zaWVtZW5zLmNvbS9wa2k/WlpaWlpaQjMuY3JshkFsZGFwOi8vY2wu
c2llbWVucy5uZXQvQ049WlpaWlpaQjMsTD1QS0k/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dIZJbGRhcDovL2NsLnNpZW1lbnMuY29tL0NOPVpaWlpaWkIzLG89VHJ1c3RjZW50ZXI/Y2Vy
dGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAdBgNVHQ4EFgQURT1zRzKUlh+WlA5LZInILLrGEJQw
DgYDVR0PAQH/BAQDAgQwMCcGA1UdEQQgMB6BHHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEALJcoEKoIAxLyJV+6HTpKciBe
E3w7ht2RSQjG/7EAgjf+kW0Nrp4TyrzteHR3A2sTmRJC2M7/DV763W93qPzPiinqtNlUEDte
KJlHBfr0OUio7i0RZqGvlCGPK1R6lu6e3n7NtApww6nPAveS95UuJnkYzO3gI0I2gUYqzTeJ
BYLxC++jZeO2Va1vSDnNjFUrcLoPrDeU6T3uLXrOF/3XMKlfiXIybQZoWPgNhVhu6N9lJAJ0
2eHQQVWeoaQKmoNuAki/YE1guHR+Rz9dyYa1vawjDNWX8z7wZzNq5c0riHbHYfDpYEfcfli5
/aQB1z3Zgz5SePHBkXMsf+jSrDJKAqmaSyhn4xFpxo8ZnJWQwDg1KbE33/bL0LpGMK7D6JmK
dk4s6t/717RYywFqBvBELzKYKnfQqSQy0AsuGOmrVKXlQXKc3IotXwreL6MOLuzGuNuPuXHi
NgZFiZC09CfWqlJFWTrIsLoT4KXoLqGOM7kjBDoEAaM+QAsy/aFPATsXv+KPfGcK8o5hziPY
g/HTh/c80ZPxq7H87VzCxgu20vxq5rMe6GUZTkTF2YKajVhFbFKp+bM+Uu8MOXZ6PNgsTmzL
8PqdrRK3TNT1S7v6wEQ/oeceSE6RDg6A89vg5QLWIAYMHt30IO/nTXgdL9uAcTuQLjmkWmiH
fWWqzhyrQVowggeEMIIFbKADAgECAhBavnHi3TH66Ts7d1icYK9VMA0GCSqGSIb3DQEBCwUA
MIGfMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQ
MA4GA1UECgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjIxHTAbBgNVBAsMFFNpZW1lbnMg
VHJ1c3QgQ2VudGVyMSgwJgYDVQQDDB9TaWVtZW5zIElzc3VpbmcgQ0EgRUUgQXV0aCAyMDIw
MB4XDTIxMDIxMDA3MzYyN1oXDTI0MDIxMDA3MzYyN1owZTERMA8GA1UEBRMIWjAwMTA4WVUx
DzANBgNVBCoTBlF1aXJpbjESMBAGA1UEBBMJR3lsc3RvcmZmMRAwDgYDVQQKEwdTaWVtZW5z
MRkwFwYDVQQDExBHeWxzdG9yZmYgUXVpcmluMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAxtputBhOSIjdX+ZhaIzZXOkmsV3YBSNTrnA4MTG+TtL5wgss1pfH/YFV8CHLacVX
/cYnD09uaxevNSGV3rRLZF7A77gNl99BE8qqHPAXoB+/ZVQHzo3QdumqpqaO4bqTQYsk+jYC
eDEIlGyzDep9EAMdLK9jWoeYG68ayc6G062I0f8MUHC+oY3G14O454N487PcWj66UMh9zqGS
z0lk5AuGpC1xSks42Fs9TxNgLlh74UZPUZZWtp4+05eyyDay/kkuztI0jJmYMtg0ft7vGOuU
MzFVcxau7llvsv6z94ep/rmC0n+W0lQbTg9FEkeAE/ui/9uE5SqeMp4DSPk5MQIDAQABo4IC
8zCCAu8wKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICMB8GA1Ud
IwQYMBaAFNbv+6fnKrHAXUxohcItj1ZmfoLuMIH3BggrBgEFBQcBAQSB6jCB5zAyBggrBgEF
BQcwAoYmaHR0cDovL2FoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpCMi5jcnQwQQYIKwYBBQUH
MAKGNWxkYXA6Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpCMixMPVBLST9jQUNlcnRpZmlj
YXRlMEkGCCsGAQUFBzAChj1sZGFwOi8vYWwuc2llbWVucy5jb20vQ049WlpaWlpaQjIsbz1U
cnVzdGNlbnRlcj9jQUNlcnRpZmljYXRlMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zaWVt
ZW5zLmNvbTBGBgNVHSAEPzA9MDsGDSsGAQQBoWkHAgIDAQEwKjAoBggrBgEFBQcCARYcaHR0
cHM6Ly93d3cuc2llbWVucy5jb20vcGtpLzCBygYDVR0fBIHCMIG/MIG8oIG5oIG2hiZodHRw
Oi8vY2guc2llbWVucy5jb20vcGtpP1paWlpaWkIyLmNybIZBbGRhcDovL2NsLnNpZW1lbnMu
bmV0L0NOPVpaWlpaWkIyLEw9UEtJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3SGSWxkYXA6
Ly9jbC5zaWVtZW5zLmNvbS9DTj1aWlpaWlpCMixvPVRydXN0Y2VudGVyP2NlcnRpZmljYXRl
UmV2b2NhdGlvbkxpc3QwHQYDVR0OBBYEFJc32FVWG9Weg/eke9wkqBgOTMDHMA4GA1UdDwEB
/wQEAwIHgDBVBgNVHREETjBMoCwGCisGAQQBgjcUAgOgHgwccXVpcmluLmd5bHN0b3JmZkBz
aWVtZW5zLmNvbYEccXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTAMBgNVHRMBAf8EAjAA
MA0GCSqGSIb3DQEBCwUAA4ICAQCOXIgWGNMyJfE4Gbdgzqirk9am/SdeBV32YV5ZTNz43Zre
7Z3LRqtrhr09B+BfB/gfDcxAMwQctI15BwW90Yj7IveAf9/vWf3XPkUOLjc5Yicd4ABlWsvG
kZYK7UihD51ZYzDh3Weym8pp25LPLUA07M4+0s2J2RFxz0NqT9Ab0N9zqQKP4lCTM2nHh58+
2QUNlKGGyVG6cQkiZffWp260dL8sliUR96FMDHT55PYv6GoNOtUqA1rDpk4seZQFxDwBNW+E
E1DdKD3CXNMOyv4ZuUjjQvjhS1gleaVMxD+k1vTV4jFW0nnNX4uYCyT4KVdDlxtvs3xSVkZV
DWm2u+zo1biCfgGFtWb9ZfC2hv9GdOr14MJWONF3QDC4uINewUFdsAcD+nGab/7FiAIYNI2r
BDsih5BgMuWHIEJKGKWykFWkh6tjlkaEyWqdoFMpeVzd5wlp4fP/wZ7xg1OddBnhbYb1nCuC
xtYmQfSh9/Xp1u6WQMLYaQHvTULBVCeGzClFY4FPutT4pO7RS1F5L0GaFnjcIsiBp5I9ICAZ
PSdnIpShfEm47olJARhAx29FBN5JlisbzveSNBuNHS9QH5II0K7AClrOcATYO7hnxktvMh60
V4q0S6YD90WWkkRnwv7R3M9Zpohzs0kot3z0vsivYPDq+50h+kABUbjvO/x/bjCCCjwwgggk
oAMCAQICBGAcg7MwDQYJKoZIhvcNAQELBQAwgZkxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZC
YXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5zMREwDwYDVQQFEwha
WlpaWlpBMTEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxIjAgBgNVBAMMGVNpZW1l
bnMgUm9vdCBDQSBWMy4wIDIwMTYwHhcNMjAwNjI0MDk0NDU1WhcNMjYwNjI0MDk0NDU1WjCB
nzELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAO
BgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpaWlpaWkIyMR0wGwYDVQQLDBRTaWVtZW5zIFRy
dXN0IENlbnRlcjEoMCYGA1UEAwwfU2llbWVucyBJc3N1aW5nIENBIEVFIEF1dGggMjAyMDCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMoDusEPTAOAEOTwI7QkSd3bwzwKSgMb
uzXxUPaoYsEWCApzGe4ezh9ZZz00w9+lbkiSnuEkWuwX+FP50LLkgP1NUksigbwtsZ3dODeB
/H1GVg+5cV4oaWB3Rht5ePYFCROwskp4lUS6DGlunKc+t2NBkHesB0EWeiaJeZSJn0gAt2aj
FyEVP2wpwRHCaR/SjwmQPfCU1jqwuuU0+zS06ELRdS8rBiN0PXstS6Iboy+3jPpPlKnrtAum
jO2NTsfDBDt3q18+ZO48oKZENPda4FGfF0mxGP+0Xr0OII14W1bCMUwFEP/4UWlvFvtjpjUq
orhWV4bxJGe7E/oZ1nmmRn382sl+N3v2Ml/yyb59m7RChDRCm2QC2nvrzfi0hN6oPOa2VHZs
yqepMYHKJvBej2vk/twapZRsY43vbPztA51XFHcrdnJbsqH9RYqXVu4M275l0SN622V1vzsj
+kgMKXIxHfxT7jAl9v8HLFLTc+e9Bre29W1+wpw0d9qDbGGQYO+UN31TusMxpIhT1F5tLkeZ
wTLXUlFwA93cGTpArtn7XS03qCJ3E2IeUcwZydQOwH9FNTBIhUva0WXaefe2YofuefjC+Xox
FjvKzs1NeI8TarI2B1al9iruu2bzP72mS+jWdvk6KukQXEAtrlfaMLc+TmseQGmOxpD29HPK
dphnAgMBAAGjggSCMIIEfjCB+AYIKwYBBQUHAQEEgeswgegwQQYIKwYBBQUHMAKGNWxkYXA6
Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpBMSxMPVBLST9jQUNlcnRpZmljYXRlMDIGCCsG
AQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkExLmNydDBKBggrBgEF
BQcwAoY+bGRhcDovL2FsLnNpZW1lbnMuY29tL3VpZD1aWlpaWlpBMSxvPVRydXN0Y2VudGVy
P2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNpZW1lbnMuY29tMB8G
A1UdIwQYMBaAFHBtoFDsqdAsZ50ZFf79BHM1w+LUMBIGA1UdEwEB/wQIMAYBAf8CAQAwggIc
BgNVHSAEggITMIICDzA1BggrBgEEAaFpBzApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNp
ZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCATApMCcGCCsGAQUFBwIBFhtodHRwOi8v
d3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMBATApMCcGCCsGAQUFBwIBFhto
dHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgQBATApMCcGCCsGAQUF
BwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCAjApMCcG
CCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMB
AjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGh
aQcCAgQBAjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wNwYK
KwYBBAGhaQcCBTApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8w
NQYIKwYBBAGhaWMwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5zaWVtZW5zLmNvbS9wa2kv
MIHHBgNVHR8Egb8wgbwwgbmggbaggbOGP2xkYXA6Ly9jbC5zaWVtZW5zLm5ldC9DTj1aWlpa
WlpBMSxMPVBLST9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdIYmaHR0cDovL2NoLnNpZW1lbnMu
Y29tL3BraT9aWlpaWlpBMS5jcmyGSGxkYXA6Ly9jbC5zaWVtZW5zLmNvbS91aWQ9WlpaWlpa
QTEsbz1UcnVzdGNlbnRlcj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDAzBgNVHSUELDAqBggr
BgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCCsGAQUFBwMJMA4GA1UdDwEB/wQEAwIB
BjAdBgNVHQ4EFgQU1u/7p+cqscBdTGiFwi2PVmZ+gu4wDQYJKoZIhvcNAQELBQADggIBAFAr
jdme0uraRt5tKTzku+CORk9YnWvp+waEbNw3rQfUuuosObdJNmOMD/j9zv0lTELANwSNRP7Y
jhwyrWDycV80FbhK9EsIUh3frSCc1sbd3/9eGzkMsgSuY60GIHydwsZQe9JFyRDCCO+Rfz2G
Xu+wKh8ENQti6w4U2ygQw2aqtIsFQVQDczqjisfNBkGVSJyp9yXxa2JOrEOjddx5yHf1pVTU
2kNPah3licDQoZ0mCZxyluULJw3RKOWjl9P8A2VpIAPqbeJgaWor+/BzkzvtQ3yaJB5PPGlD
2GFQNJRcNUpQdpDs7cAUkwToikr3ygGVUgImfHghnDDZaYG0twxefqA8+h9lDckAHI+c0VMC
DMt4TAn6bFohAcIpvtafQ+L/+k5hXaBKv//k+ESHakvZud2DAKxw4bssHoc1F/Sse5kGOsbS
O+Ht3igs7vVY6coaYXY0VmMscrJUJtlfySCvNmDpxcJnxxj9P+/h2hzXiQPfjinEj7P6jNQI
2O7Cik2TPY5XLVNGjz5xQrEFLMDyKIwNLdghRLhzMSn/PYo5bqasZ/W982lSGGOErw1XpKVM
sRCyuzWZ1q3sQRd6uJioIiUmj7/V/wHFh4kpvao4oEcQ2NS8NVEBIMRt9qt9XEjVXWWiHVhd
ZCuH/Dy0Im4oK1++s1MjHl5Hd5LqtrtKMYIESzCCBEcCAQEwgbQwgZ8xCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5z
MREwDwYDVQQFEwhaWlpaWlpCMjEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxKDAm
BgNVBAMMH1NpZW1lbnMgSXNzdWluZyBDQSBFRSBBdXRoIDIwMjACEFq+ceLdMfrpOzt3WJxg
r1UwDQYJYIZIAWUDBAIBBQCgggJnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDIxNzE1MDY0MVowLwYJKoZIhvcNAQkEMSIEIHyYZDGBwqQxLMOqk1Aq
DMinoh51GxW+Lxl9f7zPpTDIMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgcQGCSsGAQQBgjcQBDGBtjCBszCBnjELMAkGA1UEBhMC
REUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1l
bnMxETAPBgNVBAUTCFpaWlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEn
MCUGA1UEAwweU2llbWVucyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM0
6383MIHGBgsqhkiG9w0BCRACCzGBtqCBszCBnjELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJh
eWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpa
WlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEnMCUGA1UEAwweU2llbWVu
cyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEB
AQUABIIBAFfWe4m/NVCyZq+b5uzYHLUpDM3JHjq7Bh9S6VzQVbGfukHN993emWAwJIMry3Wl
xtMYaR3cn7sXxRRN56wYbzS2wBD9rvjUtWscMHYk55ZtTdwNw3senM44WNA1lcsnKSo20ogC
4Ba1DJDz9znvDqvfNgalX2NTS7xgXRiK/myNy9hOPU8Jkd8LbfeQjPVmdwxGV7qRmgFuHtf3
cWHek9ZcUxYaoJAoC7CeHri36MOIONN9zuCF/wlmydYxOUhx4/zuSLMWe3C3dWdQLUNXxeO8
MamHB/NV25lz0oxqhlpUjG+CvgJFmg2tTriy7tgKRNVy88I+fe0YNynlI9ST2OsAAAAAAAA=

--------------ms070204040607040207010306--

