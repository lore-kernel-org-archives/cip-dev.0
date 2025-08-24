Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A73ECA0EEB
	for <webhook@archiver.kernel.org>; Sun, 24 Aug 2025 10:17:10 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.43])
 by mx.groups.io with SMTP id smtpd.web10.14176.1756030625126555117
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Aug 2025 03:17:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZFyhAeUM;
 spf=pass (domain: siemens.com, ip: 52.101.84.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJpdQoE8auEUJa/lv0v5nr5b3pAP4o/eIBCYDrT4p5IAX9zFjXtXXD04YJ48vUWc5Y3nGqwFb5DLg6EMshUNzSiSdiQW50jJu9heLq2p+9+CD+u0VGybkp3s3nMBFiPDEv80tcvj1cQet8DdoNjDB1BMm8KHZq0k049Bep98FZ3ukigeqR8ZcFAkRLCHTjcjcSTDShBvqw8cGPYnRE48gaydUYDIZxbtrWkjKj1qRhGuYxg/3X0GO3FEgT2CrSDy/dKPB8AmuN6FbZpBbSpaZYTwsgVv2q1lY8O3DpkbDnJ7f+fj/JJL9DhAK4XpVvkkKlCA/cErBElHMrzNp5hnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOAyk5rddm0GPhRfOFbum4sPX6nq6ByvN2PTlQH4AFM=;
 b=g0axBnxcg4SFqdVXqMo6grbUnCQDUhqcyzo7MkLDUUW179CR16dtXbvxtJcmJTPOy+5CK509pJaMZ2vyzmhCDLu+2baYq+tEeivx95vhf8o5HVw74aqRhz8OoQ0ooOsZCCCcR33AZkJ/7a9wAeghVBKI561Y4QtY0GfzHJK3VAZpJNgfQLTPQ+WZkxe6nyrvgjDOpmeloLu8OSee32Pgd3E1MbAK6q7XnNgNNTQ8DnYUidU43s+KGNDcCzTZfhiLNb0oRa+BEMTXGFBZRXw9Ai4An6YUGk9Wv7QFKZozf8d99aZZ9sEyFfOX4ehFNuZoH4SeMkfG2MSevL157zQB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOAyk5rddm0GPhRfOFbum4sPX6nq6ByvN2PTlQH4AFM=;
 b=ZFyhAeUMC8W6sXwFsca/p4tvrPlVsCSFyuQZTxVK6tQXiiF5cMkJ49oOFeVpplKaZT26Y4h32ticWgvPtGLgi+gC6oJ1fcPb/wn7J1oXCyQ5FUsQXel6WNWbWDJoay0l7iHrVrHVki8OJb1BePK/LpvB+t2816U9abBdCadIPCdRuf0pfH0WqIwP27tLzxs7cbKIXerHmLkd40+e3zdgmjU/WcFM/4OniWx3aC7ZTjcD8mCJABbTAlAId2pFIzoGj1t/4tn/sZGnligZknAz6qzBN/XhdM7GxyL7J8gX7k7RX+rEfZniaM9x8QhADT9Sz3LBe1xb2PjUlJ1gTWmzJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6380.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 10:16:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 10:16:59 +0000
Message-ID: <74d5d67b-6432-4777-9b7b-0057c6f41dbe@siemens.com>
Date: Sun, 24 Aug 2025 12:16:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][QUESTION] initramfs-overlay-hook: tmpFS for
 overlay storage
To: d.kauschke154@googlemail.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <unkY.1747720394864813878.o3iY@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <unkY.1747720394864813878.o3iY@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d60ff00-1cdc-44ff-9adf-08dde2f75c64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2uHtZsPTCxqeUjaxe4fLP8icHJsZ4NEAehYL1foCFxqs6Pjg5uQ0DEvwuJQg?=
 =?us-ascii?Q?ELnBwq6VV6xW5ESDWAVYamPdMW+xe9tp4lOm3zeao2CxrLg4qhP8+IPdFwQh?=
 =?us-ascii?Q?uuIyELTdmOwKzRk3AJFiwK4J5/sRuRwU53xVFRu243tM7w5kphTWxAOeOgtb?=
 =?us-ascii?Q?9hPjAVgxPDFrMVdQkVeVtEuSRL28FHX1OqDY8e31tleIe/0indhLd3nyYRwU?=
 =?us-ascii?Q?SJ7k50KY4dhAZmaGJFQB1RuR6tXujKNus/QvSv/fTtcEVRMNp8wCe4LNjXo2?=
 =?us-ascii?Q?ff4NbB5xJZxQte1BPvx9EcQf/sxj2NmAxy5PpauwaviaPKu6Yi0FC/lIOAGh?=
 =?us-ascii?Q?mNLrB4R9Ol1I4HuXxocJNvh4IBygP9UKg50E9gi/PGD5Qhk0/oFZJ2b0uXdm?=
 =?us-ascii?Q?h3uPqN5CJff8OKno2QdTgSidrE9GLikSNwMq/6dIFAUFDYi0+qyFhkmWsH7w?=
 =?us-ascii?Q?+yjrz5JJiQT5abZ9Pi2HYSxTVmCJUQ5FiGoMAIBGB3xfq33L43W6DKGiEcxD?=
 =?us-ascii?Q?qgX4VaSIP+xnVan1V6IV+xL6EsMkYAZGSqLArZEtEFV/WJagu5eb7lW7HeeK?=
 =?us-ascii?Q?Y/233pqnSpvJvmlXCgZfs4uJoOHh+Ouc0n873SMUMO/kMsVyx70DA7K/+Mdl?=
 =?us-ascii?Q?xd5ZF9G6IcwCfX9n0hLrdzL8M8TTu45F4df0PhtW5Bz89hSV5Q5M6F4XQpl8?=
 =?us-ascii?Q?vYfWGNLceiq+rY5BulpyipaoL1ElANDBjVH+qQU/dliB0dRr+5bETVKHkFfc?=
 =?us-ascii?Q?ITdTvr0R2Efmsbz7b6r0ooydDEgel7aWjtPENT5bBBGQkrP7/OZxtbeUlF5G?=
 =?us-ascii?Q?Umo/0fSN7nd07KhIZpnPqRi7lrsf/fU2n4ccUOxq+Rruv3A0K4WDg5/JPmJS?=
 =?us-ascii?Q?m/xJQd1SbngCWYraERmq6pIzFTe7zJyjiLdizZ6OZRUDqqHlkmmDZJLUgPgs?=
 =?us-ascii?Q?dBh/1eyFkPiUIX8wlT/45SpDs4wpnPVQw/od3CLMinHuoGjMonm4qcA6lPj8?=
 =?us-ascii?Q?Y3DNFNYKSMnA3Srv4UPymMxoMYWRElA+gdPOqhyKvXcdeUG7VJZ5N9mGDpzE?=
 =?us-ascii?Q?u1+LRLzYAf3/bRFpzod8UOKfrVcL3dfXMGb33fLCQpPvTU/zmuU71IMN781w?=
 =?us-ascii?Q?6XFBcTMV1wR2tiIAEzatoQhGS97K2ZRJoqMEf8my/MQUUeLIAzMOPWZ3sM48?=
 =?us-ascii?Q?gzbA5bBuQfvyeazB05zpiD7DOsPbQKXXRyDmLI6DT5txynvFgVpiJBZUlc1g?=
 =?us-ascii?Q?CavLFPXaU/7qDICO6Ax3lQg6E6BJGkExn+5X3SHPNmmnJzRaFUGcaVmS6yEe?=
 =?us-ascii?Q?vAR2ZPYoiyOoV7oJrMGFbwRjBSduMFZXywWcx8JLSIMLX/Kg8OnfJbVhF+fR?=
 =?us-ascii?Q?EVxnFgDPpIKONpMudje9lU2XcMrP7DJLycVvCFFK59xt8PVdplmmZVlU4IMv?=
 =?us-ascii?Q?TIoa9PBS/w4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6fV0bOVqqvINqFrOgYBXzALClsYXnc8mF9KTN4rZYmqLXcm1mqZ2kzzFKdf2?=
 =?us-ascii?Q?0MYKXb4NeOCHud2l1ehARl8EEpEYxv10qekY6OlXH6VOwgcH9EqLJ/B0U3p0?=
 =?us-ascii?Q?TVF1JSsyLhmhLujqb1r1kPJaR6c6iaz0h54VotxBckxJrrDUnwmHvuEptGuU?=
 =?us-ascii?Q?USN98un1MN2aPxzGS+05eZ22zvbdUv2C9S3OHjAYcOG5nVuptUC1F6G9rIZz?=
 =?us-ascii?Q?WmnGep5UAuEpH5nM27bgo72hq0mHYhMkUeGrAtL8ELSwgUxrKZ4Zw3a5g6Yh?=
 =?us-ascii?Q?F30Ev3kpV2lH3aq6Fgldx1xsf+meNL9BOuizDPg+qKFEiTPHlOtLJOGXZgoM?=
 =?us-ascii?Q?7gHLy+hjmv/VmgmtgAN7zGQz0fYYu63MwZAutPsRwBIG7iymxiQksfS0I2Fo?=
 =?us-ascii?Q?qcnpIZi4BlSI3bibf+peUlulFjoVmdiOgqfDoOoSrGb5G1xbbrjNxkU/CUV/?=
 =?us-ascii?Q?FeoMYuGA8YqVAJdKXHU5MCJ1q5shYAZWbLy6/Yu6ojMD1Uy/eniWprId4NOL?=
 =?us-ascii?Q?STpTKIp6goyxJIw+EGEfGwfTgqfVJOQrWmy8DeyFKburUd9Pj3b/gVXrvX/J?=
 =?us-ascii?Q?II+0lwHcaLhMD6dWBkb1VemO59tKUUlJiDS4Rq1G9yzPAAe/ezDfxtFo3y9U?=
 =?us-ascii?Q?pj9BFbrnYTXhPWmESb8xee96LRTZGJxBssvkLAIBRQdbc4B6kd4OK2u2/CnG?=
 =?us-ascii?Q?4myJuTxw+FJA6qP9vGVuYzAuQ17QrlVgKmv5o8DwzKEi0vCPl2GNYNZja++/?=
 =?us-ascii?Q?EF5yCrP9McrpbpM54ZG9BUGsgRSi+J+GOXRWtjrOOh2yYDkDDvhdR0U8wtxD?=
 =?us-ascii?Q?Nukqm+Hzw8o67T5AOybBURd8Eew0bAhIz04jmngYYb3WbsL6COHw0eqP+LBx?=
 =?us-ascii?Q?EgU0k8ClmyqpF8pmzi9Wk8uhKo+9mczz2yoxDhdNXmncQmzSSDqs5jcIdAbk?=
 =?us-ascii?Q?jHQGzJ3ltHC4PCSJf+VzVcE0Jtrbev+XckLWuS/LU32nojWxRldyZ87IiJtj?=
 =?us-ascii?Q?wvryvXnvqsNen85OCFlCt31Dcs+0I4G3O5AqlP2sUnecCIngOLnIL90UWeUr?=
 =?us-ascii?Q?J4Q1sOa/QUHWEHhCqIehxoelpUV1WM82vMvXGnT2xPkXxKNIKxXO9Bh7Gn7b?=
 =?us-ascii?Q?AG87PkijusGyZzsxKSn9iU36uqCEExzYG8cR7t8QDxioDMkJHZDKkDVsgeZJ?=
 =?us-ascii?Q?Q5Env3ZsiFsUEg70f7zHNCuz0+HbXfqd9ky4M9dDPr8PsfTpP3nCmxWbE154?=
 =?us-ascii?Q?F3LIXShA1RNZ+fyFkIddU3dfFocL4eNN03wBTC3SsVucNO/btu3dXDVoPn3h?=
 =?us-ascii?Q?RJ/PaE+ELBpQINHM0w7Rvi2W4N62Q4+VWmhhtZ9lWjxv0hO+eTshTbjDZ7JG?=
 =?us-ascii?Q?dQ2HfbCfidWa+N2GiAxplScO+gtBxU+H8nEDzHGNj9B2yuT+y+nc86kz+dt+?=
 =?us-ascii?Q?HIB4kxJa0IilnT6/GJuHyA87VF2lrVnveOkcH7ZPxLQ/ZteJOAw8RrtJjz3V?=
 =?us-ascii?Q?05X8/+zgXNpnzvU9OzF+0qCTAQMdGHvpvLYITRTWBK4EP7pvH6/4jq3rn2t3?=
 =?us-ascii?Q?ishaqd7RVMAXZjAZVTQnce3faKDyY3PngyKxmhaVzfH7T3m+WHFwppaxzh8E?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d60ff00-1cdc-44ff-9adf-08dde2f75c64
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 10:16:59.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyQmKgHqgIYyqzV4EoA/WT6zYA1YOziBkoi/hcVrjePZZm7GipJkq8VPwlFJNoy32o5VnsIMZ85cI+9w2knFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6380
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Aug 2025 10:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19957

Hi David,

oops, I think no one replied to this question back then, right? Was the
topic resolved in the meantime, or is it still open?

On 20.05.25 07:53, d.kauschke154@googlemail.com wrote:
> Hello all,
> =C2=A0
> I have some questions regarding the use of the initramfs-overlay-hook
> feature in CIP Core:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/
> recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/
> recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb>
> =C2=A0
> Currently, I=E2=80=99m using the default behavior where the overlay=E2=80=
=99s upper
> directory is located on a separate, persistent /var partition.
> An wic example setup can be found here:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/wic/
> bbb-efibootguard.wks.in <https://gitlab.com/cip-project/cip-core/isar-
> cip-core/-/blob/master/wic/bbb-efibootguard.wks.in>
> =C2=A0
> At runtime, /etc/fstab includes an entry:
> =C2=A0
> overlay on /etc type overlay (rw,relatime,lowerdir=3D/root/etc,upperdir=
=3D/
> root/var/local/etc,workdir=3D/root/var/local/.etc-atomic,uuid=3Don)
> =C2=A0
> In this setup, the root filesystem is mounted read-only, and directories
> like /etc are made writable via an overlay.
> =C2=A0
> This works well from a functional perspective, but due to the use of
> persistent storage for the upper and work directories (on /var),
> all runtime modifications are retained across reboots.
> For example:
> /etc/machine-id can be modified as expected,
> but also a file like /etc/systemd/system/attacker.service could be
> dropped during runtime by someone with physical access to the flash of
> the device.
> These files would then persist across reboots, undermining runtime
> integrity.
> =C2=A0
> Questions:
> 1) Is there an existing way to configure initramfs-overlay-hook to use a
> volatile overlay backed by tmpFS for the upper directories?
> 2) If not, would it be feasible or acceptable to extend the recipe to
> optionally support such a mode?
> 3) Are there known reasons why a tmpFS for overlay storage was not
> implemented yet?

Not sure if there is anything preventing to specify some folder on an
existing tmpfs mountpoint as backing. With trixie, /tmp should be
available for that, e.g.

> =C2=A0
> The goal is to ensure that the system always boots into a clean and
> controlled state,
> without retaining any changes made during runtime =E2=80=94 for improved
> security and integrity.
> =C2=A0
> Thank you for your time and expertise.
> =C2=A0
> Best regards,
> David

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

