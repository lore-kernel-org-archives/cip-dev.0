Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33F2EB64DC
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 10:14:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.41])
 by mx.groups.io with SMTP id smtpd.web10.36183.1688984052935753309
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 03:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZtGOSjsB;
 spf=pass (domain: siemens.com, ip: 40.107.22.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJNMZGK4HPILg19D1lBjmBLdVwkIGHeDhxoEbusLTY3u9dHX3xit7j35rhfdIkC/AIB+UJXKhKBOrDpAdbrxOycOZ35KDB7AWEDsreZ4EQaNZXFInhses/+9HR4nozQFy6QZfI2Asizv3+sABMV+wsWpZ9DHxl91nafnB4vtU39mM9qOtBGcJ33NvpFrHZLbFxbXfxawbo+WXUs5ZdIyrHGP6Ody/ZZLxv/CoFNSvstGRmwvJsBMC2ip81nqI72BbKkDIpo0RaOnGjcz9u7/XwLTymkSr1d1T/b4Ve8edTsScSr+LJ+ufeIB7Ppa5bCmUuWvRl1HEH7sZmP1t3SrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOJa8Y11XBSgwVwB9Zu6UyIYvoLNmNTJtDsG7qtUVbs=;
 b=HxC6dbNJ6evElGYdEuB4donEIKNMFyAQsEHcXuxNoyh+R2mvBThVN8EKl1gwoARCQk0JbgAscqmjWgC6EOnib6fBZv/f9fM0gzIdi1DauM6zBeSU9bzCqcTLrxLudcB9eMcAEVbkDGsGc+2zR/8YdH0iCcfe+M22BzACR753zSOzV3/pktdW1B7F9Oq9GhWGRamoyUqQ2hZ5ZznptvvBywzWqVlOWLT78+BhL0QEa2lB2bLGAmKkh1G2zLf2q3vKduRb5ZuMKZDbi8gdaUeK3VsiZ+QECtKzHqlmASsR+Cwb8vrKX2ShcgTVc7KXU3XirjeWIjkQrYMT+2oteSKHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOJa8Y11XBSgwVwB9Zu6UyIYvoLNmNTJtDsG7qtUVbs=;
 b=ZtGOSjsBH9FWSVZa+P0jtmD9GYfpGHCLDLHiQp7RQ98pHT6xq6ncM6d/HG5h84AbAslLrwpd6fjwwExDJ5DQ7UG93x46DvXWwwHLFFx+3kKrEdUC7N1msoDnY/oGPNMK53WEDKUpexyZiewXIbdMkJ40n2KprcfUss9/nCd6pFKedMf2sfJuu5dkEZHxjly9JxC7NqYjuTj3ZfAyJFdmSDkCYwGENqP7F2iT6NSNm7vcCzLDodIDM/xJxfph2j0iQEyz9N/nHuLsTsbZqVk5BKFv7QJfyVFIs+Cd74ss45P81SlkngWmk/Un67YyDdbRtFlhNRxtCZ22uwGPm3jihw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:649::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Mon, 10 Jul
 2023 10:14:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:14:09 +0000
Message-ID: <175ddbd7-b652-2da6-02a1-f9758136ab32@siemens.com>
Date: Mon, 10 Jul 2023 12:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core][PATCH 2/3] initramfs-crypt-hook: Service watchdog
 while setting up the crypto partitions
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <cover.1688630668.git.jan.kiszka@siemens.com>
 <3e0c558a5b9b0643012484839a1dbf671c4708fb.1688630668.git.jan.kiszka@siemens.com>
 <b6ce4543-aa13-f5dd-8ad3-651b6a7027ee@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b6ce4543-aa13-f5dd-8ad3-651b6a7027ee@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4ef8ec-3c4a-404d-88ae-08db812e66a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d/4mP7KzTwpNlAO1TS0iSLXAGgn+/asILC8LhZ883s0nvr5SUisJofYlkIwwOKkvWgYbwZlg0RcoiGrqVcFiDV5mOwKUSuwxZOAI15JzBf894rKvTAEuqn1l0PkPOdKAEFdwdWt6lVgwKOx6TyQkDn6y0Cz4dprAobEDIes0znspJFNNXW79bqLFI9iWja1ejjG/74/YnfJ5HoeH5yd+jvM3ZiiK0v6FSvYX5Aky3GmdPqh+B0FD7Jc6iv08XQRPbgrAVYxxgRzNssETTmKx0MMbiyiUc5FOF3vWuEk4TI9U272FsBt0A15fOQmed4FgNRkOnlFy97IVVxHWdhZaUbcRgHZW+Df+3CvOZdYnIkAeMtpk0q9FXGGndzJBcLR6h2kbpCBGilOn5wJKV50Y+Q5KoTLCZcbuuPRmlB5YhYAoCbO7EVdG7x45xj/5aIKtWbEubA2rCeaZ5qXvkszQQQf8LGeRa6S1OodsGW8obOAef5y3fQqGqAyEFEaH7jwOkiA1Hsm92cZNvQkrgvnvSznbMAAXlLejhmgfUmCfKYbF/dTBt1Ul3jhX4qrVa9V4nbZSBUSL5vp3binWoGvdYY/Xe9Bzh20LZvsI/TODpk4aYrFQQK40wHdI4jQqjr4vk7p0RQ9cEgNHtF0aKMEv5Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(186003)(53546011)(26005)(6506007)(2616005)(6512007)(83380400001)(41300700001)(66556008)(316002)(2906002)(44832011)(8676002)(8936002)(66476007)(5660300002)(478600001)(66946007)(36756003)(6486002)(31696002)(86362001)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/dzqP5egmIItwvhBv+6TkOYBoRfJ5um+JVxrP7Iq/ZpFompqO5sihLer6dXU?=
 =?us-ascii?Q?TkRqXY5DF3BaaEkLSKque35S9Isa8i6dJbIwtKP8jInH+y/D8uE/l7DtSyV6?=
 =?us-ascii?Q?05o8t7y1CGrLzErJYj5YSPx4/TryDFc+n6I+fIQEl5kdYUp9kOCyyFR/nQhc?=
 =?us-ascii?Q?rZq/CZVE8+JtTJ56T+LrAOD/52W4tKRCugfPDWCKhp82kERWYWvPkUdzxtNM?=
 =?us-ascii?Q?UyVcz7MKhPb2vNvA194+NNHa09GrX/t2+hCYU+nTIaKw8SsBRLpxwnqFkfeK?=
 =?us-ascii?Q?oot9mlIte/oX+xH1OsvV6QaXYEmIucZBZGcYOqWcYdZxwl3rNhejth2+YxeG?=
 =?us-ascii?Q?FEw8UdSH7vDCdYkSAhikUa9Nksvr2c8YcYA4UwG9QLgwts9w9SNhYrmbn/3r?=
 =?us-ascii?Q?FSflHzlPMFDzH18VWUL8InC6zzz2UjiCnKSsnpChdqWccrAjUZB00bERVn51?=
 =?us-ascii?Q?KE69wRYc1zo8PTtrRHKqPRN/2tIGVHl1FZrYQ+Tb4ATn2MzNwj60WhXGarkg?=
 =?us-ascii?Q?cc+G56kg4JtNZdyCveYupBHrfaZ0wd5UI5BMwELEd9dU7Y3GTGH+xl1eWBYz?=
 =?us-ascii?Q?WyKA8WHLKfIngoWL8Q1azMJGf0Ags2PgWt4TgEat3oLwI5ImWdKyDPfqXgG/?=
 =?us-ascii?Q?jlzluIE9DKra61pzT2t/Z/8rPjeVRjmcb+p1XgKm50njz6xWPYWZ8hKIbR2+?=
 =?us-ascii?Q?4wKhhwMev04m3ySh8mAiqTI5WSv0J7VFS4qw1ojGLx4NsLt+h1jyYIvLl88L?=
 =?us-ascii?Q?TdXKh+AyWnJD4Hl512IvjEKaAE5QhwTTYjk5qpheprxgwB17RAV2M7bQ42Yv?=
 =?us-ascii?Q?3P5GsAwqMz4tjbavxWAdw6TzvsP8+6VqTGrpOjpxImIPSoRNM1mIsKe3+A4V?=
 =?us-ascii?Q?0CPOctG8dS/+0E4S6Pk2692D/VKa1INXZAvjzeTQEAzE94/MjnQ03iFBZqtb?=
 =?us-ascii?Q?3R2O8RWcvSbTGNDYiOn4iAC49PpbndMa7/D8N/3TecmzinCWk6H4jur/K6qA?=
 =?us-ascii?Q?A3ukeEk30V3AGUX5gBCpDXGNt4TpiSNfXcaMVLufDiV4sX4K9M4FoFyuGO9/?=
 =?us-ascii?Q?WeKiJLLIQEswtr3xTc0UlViWVU3nY7Hpy4KdF+NsLV4J0LJsVYopC/ZSKuLc?=
 =?us-ascii?Q?gIVX89R3ZoBBm9Ny29ar+w8VPbRfO8gZPcQY5qwIp/cnv7NPDSU/XNFcJm/D?=
 =?us-ascii?Q?/JBwS96+q1xFD3bJeQIFBrrt2vVz4Qc18RNIkA8+gk0fYTu0L6tJfajawwi1?=
 =?us-ascii?Q?3VwVzIt9holwFZGsDhgP3OiGI+GRcC0Be2sXaQa8cuPuT/GDfY60z70YexdO?=
 =?us-ascii?Q?OYVUpJIkFefwSrajlXy3Sx6spd987TAGQwdz9ETtLe432tunUTsqVl7wvdEX?=
 =?us-ascii?Q?SaHW9DieWuhWrd2/KDjaAnKk/r4s+s4CvHPmKOic+fvY+hQ2boANvkwC4zCP?=
 =?us-ascii?Q?llmwPT0qDLpl+RFIZBZpSj7LRRlFtw5dzsRqDAct9CnBZAaPa0/HUkeDBh0f?=
 =?us-ascii?Q?wk9ZQu3lg4aNdE15OdFMXrBqAU2SQSRhB8uDZBEqoHQrBXtyO7IHr/Gikbz7?=
 =?us-ascii?Q?5I4Q/3Be3t2QXhsg/nP6VTfGJjsqAAmwayMjxakjreOd503uquy6RKf0WA7m?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4ef8ec-3c4a-404d-88ae-08db812e66a6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:14:09.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnChcDYL9+wbY8HjnuOW+lMANqf1gQtkkpWXgg3DX64DaRZ32U0xetMgtOPHVuB+KJrPMi6sOxsVgNNZLDK+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7685
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 10:14:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12291

On 10.07.23 11:11, Gylstorff Quirin wrote:
>=20
>=20
> On 7/6/23 10:04, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> These operations can take longer than the watchdog timeout normally
>> needed for booting Linux up to systemd. Add a background loop to both
>> scripts then triggers the watchdog every 10 s, but only up to a
>> configurable limit. Also the watchdog device can be configured, though
>> the default /dev/watchdog should be fine in almost all cases.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 .../files/encrypt_partition.clevis.script=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 17 +++++++++++++++++
>> =C2=A0 .../files/encrypt_partition.env.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0 .../files/encrypt_partition.systemd.hook=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0 .../files/encrypt_partition.systemd.script=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 17 +++++++++++++++++
>> =C2=A0 .../initramfs-crypt-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +=
+++++-
>> =C2=A0 5 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.=
script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cle=
vis.script
>> index 9a1c37ba..c38c0e94 100644
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.=
script
>> +++
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.=
script
>> @@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"mke2fs -t ext4"
>> =C2=A0 fi
>> =C2=A0 +service_watchdog() {
>> +=C2=A0=C2=A0=C2=A0 for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '\0'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 10
>> +=C2=A0=C2=A0=C2=A0 done > "$WATCHDOG_DEV"
>> +}
>> +
>> =C2=A0 open_tpm2_partition() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! /usr/bin/clevis luks unlock -n "$cry=
pt_mount_name" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -d "$1"; th=
en
>> @@ -104,6 +111,12 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # service watchdog in the background during l=
engthy re-encryption
>> +=C2=A0=C2=A0=C2=A0 if [ -z "$watchdog_pid" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 service_watchdog &
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=3D$!
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # create random password for initial encr=
yption
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$partition_label-lukskey"
>> @@ -136,3 +149,7 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # afterwards no new keys can be enrolled
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cryptsetup -v luksKillSlot -q=C2=A0 "$par=
t_device" 0
>> =C2=A0 done
>> +
>> +if [ -n "$watchdog_pid" ]; then
>> +=C2=A0=C2=A0=C2=A0 kill "$watchdog_pid"
>> +fi
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmp=
l b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> index d04be56c..382fe45f 100644
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmp=
l
>> +++
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmp=
l
>> @@ -1,2 +1,4 @@
>> =C2=A0 PARTITIONS=3D"${CRYPT_PARTITIONS}"
>> =C2=A0 CREATE_FILE_SYSTEM_CMD=3D"${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>> +SETUP_TIMEOUT=3D"${CRYPT_SETUP_TIMEOUT}"
>> +WATCHDOG_DEV=3D"${WATCHDOG_DEVICE}"
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.syst=
emd.hook
>> index fa37b57a..08ea631a 100755
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.hook
>> +++
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.hook
>> @@ -36,6 +36,8 @@ copy_exec /usr/sbin/mke2fs || hook_error
>> "/usr/sbin/mke2fs not found"
>> =C2=A0 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
>> =C2=A0 copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>> =C2=A0 copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
>> +copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
>> +copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>> =C2=A0 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not fo=
und"
>> =C2=A0 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs =
not
>> found"
>> =C2=A0 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetu=
p
>> not found"
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sy=
stemd.script
>> index eefac4bd..cf513dfe 100644
>> ---
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>> +++
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd=
.script
>> @@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"mke2fs -t ext4"
>> =C2=A0 fi
>> =C2=A0 +service_watchdog() {
>> +=C2=A0=C2=A0=C2=A0 for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '\0'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 10
>> +=C2=A0=C2=A0=C2=A0 done > "$WATCHDOG_DEV"
>> +}
>> +
>> =C2=A0 open_tpm2_partition() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! /usr/lib/systemd/systemd-cryptsetup =
attach
>> "$crypt_mount_name" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$1" - tpm2=
-device=3D"$tpm_device"; then
>> @@ -111,6 +118,12 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 # pet watchdog in the background during lengt=
hy re-encryption
>> +=C2=A0=C2=A0=C2=A0 if [ -z "$watchdog_pid" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 service_watchdog &
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=3D$!
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # create random password for initial encr=
yption
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$partition_label-lukskey"
>> @@ -143,3 +156,7 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # afterwards no new keys can be enrolled
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/bin/systemd-cryptenroll "$partition"=
 --wipe-slot=3D0
>> =C2=A0 done
>> +
>> +if [ -n "$watchdog_pid" ]; then
>> +=C2=A0=C2=A0=C2=A0 kill "$watchdog_pid"
>> +fi
>> diff --git
>> a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> index 997f469d..db65ea40 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> @@ -33,8 +33,13 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt
>> var:/var:reencrypt"
>> =C2=A0 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to crea=
te
>> the filesystem
>> =C2=A0 # in a newly formatted LUKS Partition
>> =C2=A0 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "mke2fs -t ext4"
>> +# Timeout for creating / re-encrypting partitions on first boot
>> +CRYPT_SETUP_TIMEOUT ??=3D "600"
>> +# Watchdog to service during the initial setup of the crypto partitions
>> +WATCHDOG_DEVICE ??=3D "/dev/watchdog"
> Should there a prefix?

"CRYPT_WATCHDOG_DEVICE" sounded wrong to me - the watchdog is not
crypt-related. Better suggestions?

>> =C2=A0 -TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD=
"
>> +TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>> +=C2=A0=C2=A0=C2=A0 CRYPT_SETUP_TIMEOUT WATCHDOG_DEVICE"
> This indentation looks wrong.

Hmm, 4 spaces - what would you have expected?

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


