Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15531.1794914931770418210
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CaDaSrVJ;
 spf=pass (domain: siemens.com, ip: 52.101.72.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSL+rSvha93rP5h7l73xgYPQ+8qLIbkWKA3nRdEGAzakTfK/1poYQnk3C38vjIx7MXRuLoDIdO7ESbiqZrQFyqM5xBxeh6ksNodxdExtFzqJtrZdHnkh4pT44+KGpIj0MjNJ2OQPMF6BxT/Xc9VBgVqpziu6kIe7HYLzdWFM4yY72cDtugX5oknF9Y4K5Dm9mju17H3hIhHSHpnbFfv7anA+e6xFR1Vxl7FV3+quU9KahNqfsFofwqV1J2JCZhOQY3p9qbKRpgRMOLG+tbYFeMWgTI6IpnnDysno/8ejWFkbn0LppHOgdV7oNB2ZU4hToaLTdJdsKJf6dEf7R5jU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hpt6O54pal57Ar9UbQ7c0oJNpP+kdTRqXZrTv7wuAw=;
 b=PI4fx/pPSdkpGX1BygAUnl9ScZCHRlNIuHrfqVJCDUHfuond8USKPDFiHan9c5ZcsXjJlPHCL4m6FCx0i82K180zwbD8ulxs6tl8jIS3QsquY8N+C95cZPE2JqV5PK250YS7KzApH2v+FPQ1okUx4TgfGB/HLpOJIWET31m+1DINFnh0IP/Jq9coytYu+i/1bQe0zR034zR7hkb2wHQjtpVBsuVay7KM4S/ajN9GCIoNM8h/BCoZekFAkvhQNL+lMg5x7UymeMWSAJLfTlbKGXmkHa6uqrICoSqaJ36qV1so0HP2zfScys43VpEeOoGYK2RWeYZSD6a0KBzxviNvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hpt6O54pal57Ar9UbQ7c0oJNpP+kdTRqXZrTv7wuAw=;
 b=CaDaSrVJAVSYOAws/R6uNFmLZGXhas6Rjy5uxGAlxjidWX7oUfTzv5DD1N2bHGA8tEe/FqG89HWNyvImLZ6XKly91e/qieENHF5BOTBU5kb/54Ra9ALWP9v7DeWWn0oWoF3SIFdyVwesvJQHSvvz15H6RtGUJ9/3PTEIkdmrvwJj27ZrslnIRr0MPncvgvKp+JnDVucLHREC6PGDa3ck5C84d1VBDD4xgVMvZa39sieCP3tnwhjeb4o6Kh46zHE8XwKfT73sJAbMQozYJ1It2bUU8t1hiFvoJPFlT2PpO+Xi46SnAZHK4/P9Po+gC2L/67Do5yxHlEVVWyk/vPJjqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:50 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 15/19] read-only-rootfs: do not install home.mount with dracut and encryption
Date: Tue, 17 Nov 2026 12:28:29 +0100
Message-ID: <20261117112833.316234-16-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: dada9cda-2aea-46ee-087b-08df449df2be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|5023799004|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261022115727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 99dJyjD9+OiITKD/aTpgUA68IHj7l1PKfmRmbNE3+nG97YY0vD82XV2omv/p7FZkywPW0yTK/+sFqiVCzTwV0DQnN3e6Q71yzOU34VXa7altWiVKl47y+ka3elnRhPV2y9djUpfWz/uQhyxjVAyGygfWLzZieJntpqMk3DQtyTj1GaWFQ8fzzuLMJxB2tu4Zf6yLoqP9fS+FErH72OsJyvDVnrnfnIm4dbOT0xHKE4u1+ZyQZZ0PWM4kohZuy7U9VqJU5cq6mULEcNbaE/6VIT+VmgYKcQyCRR8vf7cHY0Rxk2c5yBBlAqJm7OAjEc5ra3DzhWKg9vc1dcU5DhbVskTaHVgFlPcJvSR4G8gImfAdcTcI667JYlTmuTTPO4aKpaqipjdbp7+Ls0r+bTc22ksq389AQBz34xNdnPBIm6LRLHx0nBAPBLOPKMNHrAdmyTBhqAGJNIFb4LyQIwU2GGL3qoMVJFEHawmh3EhFPqjvCKHdbCs5GP2r4/KbFv2vxjQN0ouDeexabvlhkGGkYSI8yI9A5X1f85X+IWBSBPcktDvAHDbgY7GAiRHK5alhY+iWz4LlGY77Jxr1T32R3s8dx+tcfUPZLwy2lJIfhf2DlKh+d2a7+6QaAQE85l7FM8eISnQc1QxhuWaiQ2Lfp6vX3VOJUMkQAQPAXwQfr5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022115727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSh1SDcFt/vPZOqTyEs1WVU/F+S9ZOHv2ifB7GpEK8HfFuK9xMEDZ5b5HiUf?=
 =?us-ascii?Q?A9i+tPDLsTeBUP/b6NkGdPLRwK0ZgDKE/KHlfe/LzJVdz2vvVLkatb3fTIX9?=
 =?us-ascii?Q?TJyrUzUhHnKguKJMiUW0BLV5Yt3klM9UBGCSSKJt1kcTnIitfqygEKokhQ5h?=
 =?us-ascii?Q?/zr5mD9bVPQWjsISItxg21p86e0wX3a/w/t5e2QoGzXrnEcUY7ki/DHhSF9a?=
 =?us-ascii?Q?KeP8wmMvLIKVbe12VY8GIAvXxOfgRySzhK1ozhgzo0WhGUkdq5Y01uoyIoRE?=
 =?us-ascii?Q?vYnROn9JtFm04bGrFRc0/y6Cz/ODXT+HMJXZ9hvlxBSgtWZAddJGqLzcDiAN?=
 =?us-ascii?Q?asD9V4KKJixrgQGExnAKUSYVmMz+SzWVt3YPtSa8oADDYjYT2Rj2WIjWQzmX?=
 =?us-ascii?Q?bGIGwJg+GSg+MSwAYrjnQXJ4mlyrUk0VMKB3iGK7S1UNR9qzXVFvJmB3vzeD?=
 =?us-ascii?Q?CbcCCoXSaUl88lwD6Gy3SXMxSJ1HpfnoRXhCM3h3uzv5zL0kFuPLnfSPhENn?=
 =?us-ascii?Q?LEcS+luf2eL6zAhyNPiiX3yVi18a5g0FmPoQjETu8AqY27FD9xh43nz9ZEPa?=
 =?us-ascii?Q?NFBW5v1qbFBjrrdpzP7ht3bjabZfUOjkGXazYEvOOhePc+cM6UvjLGzGyYQm?=
 =?us-ascii?Q?4WHphFjdaXxQTVaSdRk4Jc5lmmUtNLF8jtU1bDMCkpkvpJNafGIYHk/t4xa+?=
 =?us-ascii?Q?/DhIP+GzH2B1B42VtqRnv4avuxLEreaOac5oAFpkug/IyUzKks+0oSmVJeEp?=
 =?us-ascii?Q?+d24JpTp/jjliN4Lp01vl8IuzxVUZvhHHpmKxb2LYzqyWkiZXnQMLQJF3gRw?=
 =?us-ascii?Q?7HqVsh9m9L7ulvdybITVoTMtlE1E9Q2yetzgyujfN5pe43FikOiQ5v0TWxFU?=
 =?us-ascii?Q?RRNNVlH5I4sJUHXw7qf+p2c5QA7tZj61A+B5acyrS4KNd+ERUw/mpZMry5gL?=
 =?us-ascii?Q?FeSInMVZcYcTgQpQOKBezp2q5gRG37L6j/RXKPKuLf65ojB6DctPRkrCZUQ2?=
 =?us-ascii?Q?TONQVr8JH0SvANOhLdZM7DuyrYiybC2sPwKtAj4kSx0MfonINjOEsFbLaL1/?=
 =?us-ascii?Q?f0fE18PplnsqoHhG2yaJqUQWhyntLVii9eu5EL0LbYgBA+w8p7vwfjBCDQLL?=
 =?us-ascii?Q?wvPtkq3ac+9bV3351306Sx0N5b1udGwFjNyFodaAlrxGxZJbkCWy6oH/wOfs?=
 =?us-ascii?Q?U4XsFd/RNBAo+ui1f2ERyAGSE8MJuwQ4WFBSitpy/pkI1ReA2d/6RKaV42j9?=
 =?us-ascii?Q?aqFeP5cKKLkljeIOjI5tHFcazp9r3CoM9K/wcQfjMaIU5u2C3NB/NtT3+oWu?=
 =?us-ascii?Q?l9ZeqBRcypdjJyEpCLIa7VZVmSVFRgG3VUQhneNPOeO2r4Bjkps0UWCrqu5T?=
 =?us-ascii?Q?JE5PHdmeGrNkYV1KfQo292Uq2sncsBeYPgJjBFQFmu1yjfFSWgRpIN4vciNo?=
 =?us-ascii?Q?iCF2AA7KFFNDW2tJuBxXhBr9rKjmsILOcrW3Stb+6O3+9dGz7xuzWrZ9sv90?=
 =?us-ascii?Q?lLh87y+Om7cvbN6+fmP8UU/fr1KQSO6EOr5Z3P/U2HOEbcq4aEZw+lb4k82a?=
 =?us-ascii?Q?HfEuUEYJq9s+o2oYfHrCLRbFFVSvFQ2K6tPbgab0EBSthyQxROjjOt9AH3Oq?=
 =?us-ascii?Q?0rJd+VGdTJ7Q6Pn4ASnFbF4wqeDHBothu6/MRHyaEQcCPSGbQVKFrvP/aFJU?=
 =?us-ascii?Q?OJsRuup9rZhrXY9x+W14CRUyZyvC4MLkzHmeJh46h7NhuqcFu/B97x4Jn7cm?=
 =?us-ascii?Q?H9SQLyPqtbrvNcQkcXKGJr0NT+Gp764=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dada9cda-2aea-46ee-087b-08df449df2be
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:48.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU6mpbmHLAv3IfOFJ4tBcQd5PsigTqyJWFKthJdxW+PzPOse5g/c7BzLzXt6cx0c857648YaFHS8JTcIHW1AB/4zPnAUNEPofTHNmoOLNuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24836
Content-Type: text/plain; charset="utf-8"

With the dracut initramfs and encrypted partitions, embedded-crypt
mounts the separate /home partition before the switch to the rootfs,
like /var, from the entry in CRYPT_PARTITIONS. home.mount mounts the raw
partition by label. With encrypted partitions this is a LUKS container,
so the unit can not mount it, and it was stopped about a second after
the boot, unmounting /home.

Do not install home-fs in this case and leave the mount to the
initramfs. Without encryption the crypt module is not installed and
nothing else mounts /home, so home.mount stays.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index b58331f4..78f1fc05 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -53,7 +53,10 @@ WIC_VAR_PARTITION_FSTYPE ??=3D "ext4"
 WIC_VAR_PARTITION ??=3D "part /var --fstype=3D${WIC_VAR_PARTITION_FSTYPE} =
--label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56=
-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153"
=20
 IMAGE_INSTALL +=3D " move-homedir-var"
-IMAGE_INSTALL:append:separate-home-part =3D " home-fs"
+# With the dracut initramfs and encrypted partitions embedded-crypt mounts=
 /home
+# from CRYPT_PARTITIONS before the switch to the rootfs, home.mount is not
+# installed. Without encryption nothing else mounts /home.
+IMAGE_INSTALL:append:separate-home-part =3D "${@'' if d.getVar('INITRAMFS_=
RECIPE') =3D=3D 'cip-core-initramfs-dracut' and 'encrypt-partitions' in d.g=
etVar('OVERRIDES').split(':') else ' home-fs'}"
 IMAGE_INSTALL:remove:separate-home-part =3D " move-homedir-var"
=20
 IMAGE_INSTALL:append:buster   =3D " tmp-fs"
--=20
2.47.3

