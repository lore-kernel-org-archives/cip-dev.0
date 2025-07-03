Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D14C83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 09:30:25 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.66])
 by mx.groups.io with SMTP id smtpd.web11.18400.1751535014877198706
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jul 2025 02:30:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cP3h16uj;
 spf=pass (domain: siemens.com, ip: 40.107.162.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G34QQuJYj4x2eTwoqwCTfYI7KrX+lJ2hn/PKiiIh0CW36B6zSqRGr4oSEdISvoyLTlWsGe0VZZJBJLl2IonGvNAdwI43kXl8lqAVwsgg3zJ5UKn2/s7qAnaTEv17soCWqiMwFPnaxBKLY6xshgG2eCW/OPCKRtDJSfS1TnhO/iI7zvJse/A4s590yRVXCqw/fHoMZ7hUYV2Kw+G6cmMHQrPDPLFlb/IR+IlSl3HiyvqPQcMMvOZUEV1ZDbACgSgMaRhyhDazBBDt/wBIXAyCFViDDD/7LH6UC7on3H6KQ0ccBzn/fx0dedVnxbh4sznYlBSzPQK4kP7BwTRSeBuiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djFGG0RV9q+vS8sX31fCk174Rc1AQU4m2RCL0VicD9E=;
 b=bLf4sd9RhhySYwd0uWdp2hCYSuqFRYiACKHfOIzRORAq2MNoqOO6Ohx3EJABE7JAcCzMn/6fTgHxKX9maVi3iOAFsUryeLz9kbROWqRHJSGUdGmRrFMPEBdZry++VymjTobhs9VxTH0NTj/J3cnMZg06x40q1Nd3t4dPZpzilqQ71UcWwyRIk2TcMM1l/qGGEa65mXnOUICD6WCq+51m96I9ENnBiiF0EBhkLnBu1F0c0+qgQlDSHAFSj4XWUeXf0zQCp8M3nun+d2j9cYuBg11XlAdgCUkjtK1Dg5c7xn7e6cDuwkpqoAlVq7O+dfP6bm57ueIOwiV6dBlm+02ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djFGG0RV9q+vS8sX31fCk174Rc1AQU4m2RCL0VicD9E=;
 b=cP3h16ujyJwCjKPMrQm1UgN4AQMSU95cBtMpqEpy2Yjv3lYRYIT2rqBYdKDDZEwdKaoW6vakHN+W3meaCA2lpry5X61t9IPdHAHO6vvgS8EYdgJkX3fKFARxDozwughnmcYRh26LqiSPrHGs2b8JlCwkSSBiOlptZO3qRj74qBpXw8UXWcorI59c8U+hlyqR0laz3v+TyNxJYRhs9T7uzuKzToP+iMUoJtJaymd1rgN6sDlvmhWI0cR/aqn5EhWfLaoa7v3nTEeZgy/zTZLVk01PAnHhn9E5P44Kyyu63Qji34mPmPyoxJ3PECjif2ba6C9+9Yn/WYJotpZjtOCAdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB6005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Thu, 3 Jul
 2025 09:30:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 09:30:10 +0000
Message-ID: <f6612c6d-5778-475a-975b-aaed0a0cc1eb@siemens.com>
Date: Thu, 3 Jul 2025 11:30:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] change-root-homedir: fix /home/root path to
 relative
Content-Language: en-US
CC: =?UTF-8?Q?Enes_=C3=87olpan?= <enes.colpan@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5c7e69-23c4-444a-2bab-08ddba143488
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g+VOCdb8t1HLYtqnXHJYOrFv982yfvcy9zh9vKyq/MbJQ4iQsGvChvD0243i?=
 =?us-ascii?Q?2vNyai1H2aDce8Zq1Low9TGdsvdnCy+pOjl22qAZXidYo24VyJhFWbeIVU4T?=
 =?us-ascii?Q?tWAZtMplnL7OqQipPQKkxXmrGxWpKtNKEaGh1yQhJ/0Q6hT0pG06jzW/GVcy?=
 =?us-ascii?Q?7m1bQLpPxi0C6YkdtHbY/rw9qu1lJzODvejU+od0+Lvpd2nJ3HJrHNahWLeS?=
 =?us-ascii?Q?Kv350GWUdoALw0LPeunXZK9E7Iqj77pru0QDe8LhHTI/JJFW1CUfU6wmj5GO?=
 =?us-ascii?Q?WSV6rgJAlmX0IWD12KCcX9fZlpck+7W9jGXB5OK1tt14ae2L+oqI0lTuIutu?=
 =?us-ascii?Q?7kE7jRV6lmYsYCCOvvJ+958ZwwxBLPYkpavIhs/uAZKKguvU7WqqoqoGa0OL?=
 =?us-ascii?Q?myjLd2ZIfO/gFAPBrC+dqxH/HE+whO7ciqokK4GwnpLaMvf91dOB7VCnnHod?=
 =?us-ascii?Q?s9dT/vLx/sfndv/jIE9Woqnh7wXDEUHtdKmgtimoaqIDbdQDDyL7AjuIsl/z?=
 =?us-ascii?Q?SkwjH/ZbmjKU7OST9Wy5zZS4K4EB6Ige2IK2nCgnGcKMpqTHNGkxxnGnOuXN?=
 =?us-ascii?Q?t8e7KKnNurF9H0kkIs00w5QE1PATf4KCXEF3/cH2DOteVJp5iPnQco+QlPwO?=
 =?us-ascii?Q?WmtNxMYTAQ9FQTONGH5AjOpgQBTL/tpSaI3RKts5AHissVxOuX2VB9Q4YDUK?=
 =?us-ascii?Q?MnDNK0tRN8CUO3aMm7KUyZUkiwtAwOW0v2TDyWTwg2nDFIXfvkGu7NeIGf7s?=
 =?us-ascii?Q?GBQWpIcW0dWxpGmvnIHsH4j2BhRwPfIh/eBFxOtyoS2zP52EcdtkGzUTMC3O?=
 =?us-ascii?Q?6QIubPEvbHperJzxwM0nCViiDym3l87znnyl7fnvS+UHmFLVJEKo/31w3cPI?=
 =?us-ascii?Q?KNHw4oiKjN9wMm7fMeCTtHAMsWGC5MBxiUWSm9gd4qF6E15ZkA+3fVw1jkL6?=
 =?us-ascii?Q?Z4vwDCj8nBtiQ6gF7LgdWDI81su6LZi9nWmWDt0kUDvESAdsZYj4yTxH+Ube?=
 =?us-ascii?Q?su2CVn+n17U01CYa6In47EFXYCCG35OpwOYRRbHAtwCDpH+QQKsFpUmsbHb7?=
 =?us-ascii?Q?rLVWvZONYRG7WjdlWbt/temiIVhkeEMQm0C0sveh8KPsE40/+QRIobp6/IYM?=
 =?us-ascii?Q?feoWKlQIg9kyK+lnQVUF4UQ8bV6h/Mao8NruTnnr4fI3H/RmviEbgQ2o6vUm?=
 =?us-ascii?Q?kpaJtW9bvS1f7shjd5Chs5+MmdChQZS6ltnTBbcUmZCNP1ZnQEV9mc3djT58?=
 =?us-ascii?Q?jVDAEVUKeuFbJjB4eWc0uTqyn7LG3APzTYOfdfdz51K+DlWXAM+coLkBfQb3?=
 =?us-ascii?Q?ipcLoIEU1aoxBSTS7s1Jmfyy/tUdMV3SRPf9rToGS0wdZSljgEmpcN8oKwTD?=
 =?us-ascii?Q?Rf2OkTpT2996sOv+gR4W0LJcwPGm+tvY70n62GtN3a8tIgttW6VHFS3fJw3N?=
 =?us-ascii?Q?b8P4rWGXaS8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YOps93WfSysQwF6dIrmd/QwD8xlHyOqkmfjUIrl6t3b8E5XvKWIBrZjuZstv?=
 =?us-ascii?Q?S87v00UYmxVB7RMSmw4L/zn8Stl1KNQPIgy/UKBbNK6fdzoJ/esMOH9beHIi?=
 =?us-ascii?Q?bcsxmtTyEtq6gK3+OllYRV+v5Lu+6gpkOOdE7uND6VeOHzheiaaOSV8Drh2P?=
 =?us-ascii?Q?wNuZnraN+wNI3M+vW6gAdSiiGJG+sesguZfkrDnNjfU1huDuvcv0PKe9JxEQ?=
 =?us-ascii?Q?NZBVvWZP5hx3Pbs6xo44aDjfKohFA4xPISuPKbKWSIOi//5Xrvayb09a0+r2?=
 =?us-ascii?Q?SQQAWLPQEpYXs7KFh0bwmaF2hHZWfoXLP0nEU+HSew5lw60Bh2II+YVOqbgC?=
 =?us-ascii?Q?HIQ00qzduAEu0JHlEA9fI6+mzQfsuCJpdtm9Jsmkp2CJBMtt0WZ5NbjCLTVl?=
 =?us-ascii?Q?esP0/4dgZ3lEC5ftLZ15G8XT69+5KoGkTAJyxPQASyJrVspk2XSEZEYQ0mAA?=
 =?us-ascii?Q?QNn/Sr2uzJyL5uon4ExLrqkA5LgbsVNqbawIxqBDOGP1Iq1ma+5yoK7/3V3R?=
 =?us-ascii?Q?Fb4gpo/zUzQtPePW4Sh/3PSs9mUsLIucxArfKcEcw8D9AqyKm5kwRGhHJ8zc?=
 =?us-ascii?Q?K4MB4JIIXo/PIkXhSqLAv9X0lNoh4J5jbTK4/0VZj8H2m3YTeetVQrtYZKjc?=
 =?us-ascii?Q?RYPvSBvFN6xAiOce/pkYqOrEd9kw0+BBHclntQLM65TjbyU4sI0+uTPvHFs+?=
 =?us-ascii?Q?v/1wBXTeVViKH/ARZDuktqoYNHGqehm8Otd2c29VNN+Z5DyirZII+5Yciu98?=
 =?us-ascii?Q?LuwLLsU7lYBU6sd+2x2xoQSVIF9YVMYorKjs58NzxP0OKByiec3MYw3rY4u3?=
 =?us-ascii?Q?Hjyn2CtckxKM1Lje293GsBJ1QTmxA9z8deaOSVktE5ETXwsqCVQ64FThVYga?=
 =?us-ascii?Q?Z8VXUfKUB8TPQXvCpKMVOdJgwMOAjThMvFEDgM0KjvEDIJEsFR1FvjJh65h1?=
 =?us-ascii?Q?gDmz4CIQV9csmourG2/oe3q+cONzDCWPOlsSpsetA2BIt/yATRDQ8DOsdC7X?=
 =?us-ascii?Q?4osCwK0EjUYS/DTNirfreQLLJK9ObZHxVB+liTMDTqp28ttoDjRqs/aQXYDR?=
 =?us-ascii?Q?XuqDhKt0hspb9epW3oImH+dDVNdQ2LoyNGGZI8pwjN9L0OU09H4g83Ayejoy?=
 =?us-ascii?Q?ylSYo4327i4hB6UefLhJlRxgHQkergXrGwfgAy9dc2WiCbcAQDyCj9dqNbxy?=
 =?us-ascii?Q?cb5KEl3ZuL//ecrr3ag0M50x4WZ1gkvroPRRzVSqL/ugFekUsaH5aiT/MHme?=
 =?us-ascii?Q?l8ZEAxEjaLDHHd6N9zb43KF59ki8mAJ4YdKazSCKq0hUf13XM2q4i2b7Lhbu?=
 =?us-ascii?Q?t8uo5fqkH4CPyU5K4DB0NB3+RWoO2grJdesYVIFWfMVWFzQuox+zv8bdTzAw?=
 =?us-ascii?Q?sj1x4CgKj65zdMh+OomQmH7UM+Q8ayLlH6/kc8TbloojtTX8QPu6oFd/vYGB?=
 =?us-ascii?Q?x6sCI6ZK7g2KJvkIoMgIzzRI5RiItGHMRB0f/x9kWMC0nylH4IkWhBfShMUO?=
 =?us-ascii?Q?Oc+/xiVQ4iLyW27fAjdnF55QCMK7G9B3k8Dlzikrd6c4xDUieoI+mpHMfvvi?=
 =?us-ascii?Q?CU0XK2AVQai3T2qKU8dZnajsUSZp3TLclaixCo9+JNWPV1v6JXI3ePDQSiMN?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5c7e69-23c4-444a-2bab-08ddba143488
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 09:30:10.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpUuySQglX0NW5St/m0B6V8pmNUs8R14g9EVWac+76VQnlQpMEFVyU8nkK+4GqpS04ufr7lYwuVMS7kl8GLY4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 09:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19322

From: Enes =C3=87olpan <enes.colpan@siemens.com>

Relative path linking should be used during initramfs stage, otherwise /hom=
e/root is not a valid path
prefix / causes no such file or directory error. /root/root is a symlink to=
 /home/root and /home/root
path does not exist under initramfs' / path.

Signed-off-by: Enes =C3=87olpan <enes.colpan@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/change-root-homedir/files/postinst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/change-root-homedir/files/postinst b/recipes-core=
/change-root-homedir/files/postinst
index 918c5ab7..4735edee 100644
--- a/recipes-core/change-root-homedir/files/postinst
+++ b/recipes-core/change-root-homedir/files/postinst
@@ -17,5 +17,5 @@ if [ ! -L /root ]; then
 	# usermod --move-home can not be used while the target user
 	# has running processes, also we keep a symlink here
 	mv /root /home/
-	ln -s /home/root /root
+	ln -s home/root /root
 fi
--=20
2.43.0

