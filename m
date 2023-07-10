Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E2EB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 10:44:59 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.56])
 by mx.groups.io with SMTP id smtpd.web10.36560.1688985894084414450
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 03:44:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=H9y09iyk;
 spf=pass (domain: siemens.com, ip: 40.107.6.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/IBX8q02KeqH/kl1kQBXH++/SUsbUzJgK2oct8wzgGPbahF0JfAh2ZTYl1MKhgTNcQ5UbjLBOBrgQaIPaFYRIDkw6/Qdz/GQU5N5DQ3SwH94n8tqAn2GNow5GOUjzhsoZ4P6JL8WWV/tNp5cWU6BFkPJMEeG3t77cNdlzQQ0dWLMim+3QlHEwnokn+yOjVYjHldzstzBNx+7wrt5h6ixm67zx4Nen2KbJSSJL99mQBJVx4tVzseU9+Ks4nWdZX7EEldjrUcT2ciEaZ6KcTBQtMEAqRiwBOqK1k9nf4YOZaRj34ywI91Cct/jYtuzTrUoKqheDVelotoOUaSBu2rWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpJhWZ8HkbGo6SeoRqigqUdRC7EkcDAHVyE2xbD4dR8=;
 b=lrtjr6/1rLXiDm/5FaPlaoERiPdphnfk80pkAx1Of3Bf2Izo0iRzl8M9PPi9GsIKFo9NNRwgVyvWdLvJ8iLEgIe4znhawV9xTOFJoXz+t9UpzaENMvyrjZdPGs0xa4ZLKGDDUz1NbHjZzFJpbJiB5G+fniutMcKC79lAD/WoG4R+1rnJF2q+A8hU9nGEr5ZSq35Kc//uUAMk3zVxhoL/sPmmMP2MNuDsj1dLas7z7UuOMG/C8/VGHZZepKnBr0AwWZFYVMnzyZA6bLeaCqB7L9Gx3M5voH/N+9q966f6I8OjuRmu7Zn2FI1cB9XNtCq5XDwwuysqSATIepLroY71dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpJhWZ8HkbGo6SeoRqigqUdRC7EkcDAHVyE2xbD4dR8=;
 b=H9y09iyktJmJFk1fgJ6k3Z17nCelCx/1VU/kQuYAfXQrjtv2eoDtow3QxMCi8z5gmrTWbhW+YDV0PF2j25NMUM35rNdWdM3t30eKcPt3fFowOhfFux04EQKLAdqUn/cMJhdNfDNqywqbxN7Jv78WveEcMPmsw5hoDWrNhYPgLEcuqA3y5X6U39JlLFzLVN37v3ks2KmAKQsGRvmvYF0BoTMBurFqZJoKXHyTixLbPd5V/2JeQjSD1/Dzm5uyIY8FUEFvciFhyL6U2lpHH+nm7l2ognPJQnk53S+Qx8He6QELpbUVWHpWAdLqYgazynZVUwGSDtYYl20CWmRAIe41Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB6714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:44:51 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:7882:5390:f8d1%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:44:51 +0000
Message-ID: <b9f0ffcf-985e-ef30-ab83-2fd282947e44@siemens.com>
Date: Mon, 10 Jul 2023 12:44:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core][PATCH 2/3] initramfs-crypt-hook: Service watchdog
 while setting up the crypto partitions
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <cover.1688630668.git.jan.kiszka@siemens.com>
 <3e0c558a5b9b0643012484839a1dbf671c4708fb.1688630668.git.jan.kiszka@siemens.com>
 <b6ce4543-aa13-f5dd-8ad3-651b6a7027ee@siemens.com>
 <175ddbd7-b652-2da6-02a1-f9758136ab32@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <175ddbd7-b652-2da6-02a1-f9758136ab32@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b500f57-1644-4bdd-8a84-08db8132b080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qrjDF5OHMp78qQjFtSfk+/MoAv+h12ovaUURILvSfljnsgLfP7diY5Bx6w+yzLj5JnyG2XjP23rj+m4b4dGsX9KHDjjn4/aJq9L+zz6qFrbPZFcGpaezid3FG6AJ8zJAHjLOOwtqk5++je5KXwmEfYhhg668l4C+IyAQoFC63kVJDc6TGQ03uDeqYhFI4SR7en8oHmLEsJlvAxgKIdM1/s7+W0m5p4zH2cbTSZ8kM2QhkZufr3ncLzQoepUwnGda/eEh2FxkRhZCtzUjOxqvTo8kF1qjhAsDtSvX4vBE33uqHYUv//6UTAMEUTZ+rmLNypCXaygEkiZDgk7OUu6O/Jj+eQgit/TpO6xvJtXiVdN3Devnqa2fvWteHWSxO1gQHuoiKh1VHwuThU/9V5rmaRIe4EdrstMi3XRw/8MZfcZR6kWndfsWx9G7Yot86y7/0h2nOSlV6nT9+z12i9rEqf4ot36skTzgj5SxJkRGUsHkHwnNJzz6zoImfc1r6l7XCH5RSxoZEZ+JJIaQI8LcYqjSayDfeJIDkHm0sAaATYN0wngOqK5Ln8oeJROvhJDOqtFIW0buJ+FVxsZTwSMRN4tngL8dMU7vI7MjYr5+ldTfaQYU4AmWi1xDSFV2F2jEsVRan4HHijYXVcXbRo5rqQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(86362001)(31696002)(38100700002)(82960400001)(31686004)(36756003)(6486002)(53546011)(26005)(6506007)(186003)(6512007)(2616005)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JcvAdPJpTtP+9UcJm8o8bTSZoiUJf65jnO1wqTHnkiG/np51niPsMKu1b3NQ?=
 =?us-ascii?Q?fH/DDS3dhmf1zUPpyixURpN5d/PFxxWLNmz6P9H4iMrrZIBCqsBg5qi4d/4l?=
 =?us-ascii?Q?sikvwl1cKaQsWAopjisJsrqBDwReBfpXzR/1h3fPi1qffxdRqaqipg+CaRRR?=
 =?us-ascii?Q?rtHQfj3xrrBqxlxJqRWZ69dgRxL3ku7xnC9MEzf86CTEHjUOGQ+GYljYcF81?=
 =?us-ascii?Q?+0AW6i+qnfE8SLsPWPfV/3ytUkUX498RlfxmZdJY5ZbBPwCtHVjT6lvGkCy3?=
 =?us-ascii?Q?wwiLZjT/0uyq0jbKV+izebGLeIIxK/i6Jpc646tRTCxSepHMWEVQWkAx+1I4?=
 =?us-ascii?Q?DgU4o0RTJ42OOYmJMUQSxNYlLK/bQGehaXuncw2X8oU2/+sF2O7ieQVO+sWm?=
 =?us-ascii?Q?3TPF43ftBQtRKam2iNPnnz1ZgTB5p/Lxpgvg8cZRaGl2D2W7Y3u5JGaIGKRq?=
 =?us-ascii?Q?vQDrs8ETCIGG6n3m+HujhaNvcefZqB2F7ZsKgtf4dPzEFJXsFwDyqQy/n5IJ?=
 =?us-ascii?Q?5RSKE/M+BJgmtvb8u5R60/oSY5cVERKLfZBlax5VJeBN7O58fP15JlMMP56S?=
 =?us-ascii?Q?BDaTw6QU5loAW6kCGx2vE569H/6VJKeawDNl7CjrfvwM9l3htZGJCTYm8GdL?=
 =?us-ascii?Q?GuEkj5057W4KQanEUwGkkVqoVrNTHtG2Xwa8HNK1lzJ4+rWxqy9EM9bPga1/?=
 =?us-ascii?Q?TQae+A/arAiVXgloWNzCjl0oZlPRuUNQCULy+KDssiYMSsyMM657QdLpJs7b?=
 =?us-ascii?Q?Y9nNiI7kXYYnDh7iKVfP1qTOu/OfjGJt2bu5U/E9SfxL45dedEJ4W3cZELAb?=
 =?us-ascii?Q?qkQwK+2ubWyiFswGWQEJlgwo1VovqDOb4BsfMhqqpbv7MvRi7fZKwAxxNA2q?=
 =?us-ascii?Q?1SRo0G1x8sENaXk6SuJZMGVmX2fiBf8M51kxz1MZYsnhz3ji9jJtUn0jTvhG?=
 =?us-ascii?Q?IaM/hZMVVTKwTbSPeu4JotYsOZYonF9ILx09tKZGo4dH6U9A0DRd7kpo+R2D?=
 =?us-ascii?Q?zvt/WT3uOoST5zLWH5NW2bfPO1RYtnSITA1j4NRpCvyZLiK0nmuZWAA2fRdp?=
 =?us-ascii?Q?EyyaXkWV55NMr0dYQd8xPNPuVqLH1g3gdwHN6ZKgpbyslPidLF4PybfQhBOH?=
 =?us-ascii?Q?mnSHVSIq2+c9ng5Y7AqTd4+za75nUAda2q5BaBFuS6s6KALqhL2CW48so73z?=
 =?us-ascii?Q?Hgzg+bbUloPm6PDgHCnrKK2b4zCwx96EccQDpw+S8aQw8b7ZkGsNFxdHB6fU?=
 =?us-ascii?Q?GpsJVFWvZcWa3MwmSS3sT/5v4EemiO+yzU81Gj/KUibdkL5eWE5HZSpWW0Pa?=
 =?us-ascii?Q?y9JeS/C2wx5IB+eU5YOTzzUXM5iCLPBUlo9KDch/kiJHXucO5Uho87wdhp2n?=
 =?us-ascii?Q?Qlw8pM3iMP8TZbzfnaEjKTBRoJACwORV1AR9E2tZI7DPiUK3uGgm8bdxrRlh?=
 =?us-ascii?Q?W6oeIEaBH/lGVmMNjpONvHHzgcnAQLG5FZkIl7tZ0/ebMqeWDAVllLSMCaoJ?=
 =?us-ascii?Q?7tADT49NZ6Q96n7ivO8qdnq6S7fUq6EbU0RF9iVHjWJa5Nn5vw8NRxiMx42f?=
 =?us-ascii?Q?5FpvF3VkGRqcVZDoBsnR09uiuq+/XJSxBblcz9mQnh1MdXjyeAOCd/o3N8pU?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b500f57-1644-4bdd-8a84-08db8132b080
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:44:51.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36W0FWnlFb2OhdocbjHve+pUtG+cutx5xgu/62lQsUVV1JCFhMdJbqDfLJQ1MHxrdpxzsptDS2EstZgNePTeVKPf1foJhcMc3FQiI7GIORc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6714
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 10:44:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12292



On 7/10/23 12:14, Jan Kiszka wrote:
> On 10.07.23 11:11, Gylstorff Quirin wrote:
>>
>>
>> On 7/6/23 10:04, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> These operations can take longer than the watchdog timeout normally
>>> needed for booting Linux up to systemd. Add a background loop to both
>>> scripts then triggers the watchdog every 10 s, but only up to a
>>> configurable limit. Also the watchdog device can be configured, though
>>> the default /dev/watchdog should be fine in almost all cases.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  =C2=A0 .../files/encrypt_partition.clevis.script=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 17 +++++++++++++++++
>>>  =C2=A0 .../files/encrypt_partition.env.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>>  =C2=A0 .../files/encrypt_partition.systemd.hook=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>>>  =C2=A0 .../files/encrypt_partition.systemd.script=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 17 +++++++++++++++++
>>>  =C2=A0 .../initramfs-crypt-hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
7 ++++++-
>>>  =C2=A0 5 files changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl=
evis.script
>>> index 9a1c37ba..c38c0e94 100644
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
>>> @@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"mke2fs -t ext=
4"
>>>  =C2=A0 fi
>>>  =C2=A0 +service_watchdog() {
>>> +=C2=A0=C2=A0=C2=A0 for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '\0'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 10
>>> +=C2=A0=C2=A0=C2=A0 done > "$WATCHDOG_DEV"
>>> +}
>>> +
>>>  =C2=A0 open_tpm2_partition() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! /usr/bin/clevis luks unlock -n "$c=
rypt_mount_name" \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -d "$1"; =
then
>>> @@ -104,6 +111,12 @@ for partition_set in $partition_sets; do
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 # service watchdog in the background during=
 lengthy re-encryption
>>> +=C2=A0=C2=A0=C2=A0 if [ -z "$watchdog_pid" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 service_watchdog &
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=3D$!
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # create random password for initial en=
cryption
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$partition_label-lukske=
y"
>>> @@ -136,3 +149,7 @@ for partition_set in $partition_sets; do
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # afterwards no new keys can be enrolle=
d
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cryptsetup -v luksKillSlot -q=C2=A0 "$p=
art_device" 0
>>>  =C2=A0 done
>>> +
>>> +if [ -n "$watchdog_pid" ]; then
>>> +=C2=A0=C2=A0=C2=A0 kill "$watchdog_pid"
>>> +fi
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmp=
l
>>> index d04be56c..382fe45f 100644
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
>>> @@ -1,2 +1,4 @@
>>>  =C2=A0 PARTITIONS=3D"${CRYPT_PARTITIONS}"
>>>  =C2=A0 CREATE_FILE_SYSTEM_CMD=3D"${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>>> +SETUP_TIMEOUT=3D"${CRYPT_SETUP_TIMEOUT}"
>>> +WATCHDOG_DEV=3D"${WATCHDOG_DEVICE}"
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sys=
temd.hook
>>> index fa37b57a..08ea631a 100755
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.hook
>>> @@ -36,6 +36,8 @@ copy_exec /usr/sbin/mke2fs || hook_error
>>> "/usr/sbin/mke2fs not found"
>>>  =C2=A0 copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
>>>  =C2=A0 copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>>>  =C2=A0 copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
>>> +copy_exec /usr/bin/seq || hook_error "/usr/bin/seq not found"
>>> +copy_exec /usr/bin/sleep || hook_error "/usr/bin/sleep not found"
>>>  =C2=A0 copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not =
found"
>>>  =C2=A0 copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2f=
s not
>>> found"
>>>  =C2=A0 copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptse=
tup
>>> not found"
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.s=
ystemd.script
>>> index eefac4bd..cf513dfe 100644
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.system=
d.script
>>> @@ -45,6 +45,13 @@ if [ -z "${create_file_system_cmd}" ]; then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"mke2fs -t ext=
4"
>>>  =C2=A0 fi
>>>  =C2=A0 +service_watchdog() {
>>> +=C2=A0=C2=A0=C2=A0 for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '\0'
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 10
>>> +=C2=A0=C2=A0=C2=A0 done > "$WATCHDOG_DEV"
>>> +}
>>> +
>>>  =C2=A0 open_tpm2_partition() {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ! /usr/lib/systemd/systemd-cryptsetu=
p attach
>>> "$crypt_mount_name" \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$1" - tp=
m2-device=3D"$tpm_device"; then
>>> @@ -111,6 +118,12 @@ for partition_set in $partition_sets; do
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 # pet watchdog in the background during len=
gthy re-encryption
>>> +=C2=A0=C2=A0=C2=A0 if [ -z "$watchdog_pid" ]; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 service_watchdog &
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=3D$!
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # create random password for initial en=
cryption
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$partition_label-lukske=
y"
>>> @@ -143,3 +156,7 @@ for partition_set in $partition_sets; do
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # afterwards no new keys can be enrolle=
d
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/bin/systemd-cryptenroll "$partitio=
n" --wipe-slot=3D0
>>>  =C2=A0 done
>>> +
>>> +if [ -n "$watchdog_pid" ]; then
>>> +=C2=A0=C2=A0=C2=A0 kill "$watchdog_pid"
>>> +fi
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>> b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>> index 997f469d..db65ea40 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.b=
b
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.b=
b
>>> @@ -33,8 +33,13 @@ CRYPT_PARTITIONS ??=3D "home:/home:reencrypt
>>> var:/var:reencrypt"
>>>  =C2=A0 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to cr=
eate
>>> the filesystem
>>>  =C2=A0 # in a newly formatted LUKS Partition
>>>  =C2=A0 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "mke2fs -t ext4"
>>> +# Timeout for creating / re-encrypting partitions on first boot
>>> +CRYPT_SETUP_TIMEOUT ??=3D "600"
>>> +# Watchdog to service during the initial setup of the crypto partition=
s
>>> +WATCHDOG_DEVICE ??=3D "/dev/watchdog"
>> Should there a prefix?
>=20
> "CRYPT_WATCHDOG_DEVICE" sounded wrong to me - the watchdog is not
> crypt-related. Better suggestions?
>
INITRD_WATCHDOG_DEVICE as it only applies to the initrd.


>>>  =C2=A0 -TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_C=
MD"
>>> +TEMPLATE_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>>> +=C2=A0=C2=A0=C2=A0 CRYPT_SETUP_TIMEOUT WATCHDOG_DEVICE"
>> This indentation looks wrong.
>=20
> Hmm, 4 spaces - what would you have expected?

In git it looks fine. Something with my mail client settings.

Quirin



