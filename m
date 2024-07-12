Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9112C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:12:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web10.3114.1720771915351009156
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:11:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Gs4gG+zG;
 spf=pass (domain: siemens.com, ip: 40.107.21.59, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjlhRkTcIvyTXGUSOVuRHZaQBVcfD1aQ3wCoRZntV1vVcYLGYbmHNY/fqPTBqXwrBljlG8mibjckSjHQyRK/exc/sB68DqsvDihaU8RU9fhviJB8ofQiWc0X39S7BRfEz68jgB74gjWWftxoj1ZS5NK6bQAnts6J+pRIZTcmJ4R9OfYVzjju4wInOveZzuKLJIz0ADu2CWPjM2gUXvHXHqWdgRKONq/NWYI4H86b4y/C76r821+VOkoUT/4E0SxZa4ylIooXPzhpuDMy+6GSpzT9wz9tcRl/+YDlQpAv8dIUsmAZaWcsKsQn8FdROGtuth66+3vS2LG9QQjC4OAScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcDCKB2WMx98TeV13qIe1iINdudIwQQAObevBfgu9n8=;
 b=wvzeRXZLZvwJ3Ajziefgz9B3kbMiRehzba3x1uDN1EAfA8ZZxR9w2U9r1j4ofBOCm2Vf/1agDGr6KJ0YRXdro/64KmbFdfU2z7MiLvbV/1uxjJRc03o0z2XVMYl2Y5yNvRPZBFUDr1IcTJS6tBcN2UWr2b+SB3xvBGZsY24218xjVY9O+APVQ0x/wKa7MAW1wowCrQaiH4w1834DQr8GVD79zw3/d6b+HWkDhsPq8pIFM2ClyDqgwksIbUCBcSfEba9Xar7NNDZ00XAez1h9kj65E862VY7jpI2F6BuvvohUejM8gaRZTd+gikqzjS2W+9+GCfvtOyv0qIOOt8DlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcDCKB2WMx98TeV13qIe1iINdudIwQQAObevBfgu9n8=;
 b=Gs4gG+zGjag/1BrUZbp4BGU9IFlPFYssxI4M+nFpfuTaJnk6sd20UCFjZMRCYN2ZYlVL7K2x5vKN0/4w112odK/nR5NfxxxkxFh1TOVssmR8Nu7FHDcsqHG2xZyldESpU3qs9A7j9pAcwXuW74thXWxhVIM/1HuIKdYyosXu8uJuH3s377jodv7pJq5WV402ci9Fc233jgkvPE1HloikoRigqLsFbJLV1cSlSGMqNDvdGulu6xiiLHE/QBghRmeovWgMoA6lUV8AHmnTgTCYCYIXTXFdSj/l7Ddb/G64w1xKkPopc0AZsisSmE1fWKsI+iupyOc1Nh1kHENUbdv2rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB8134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 08:11:51 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:11:51 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH 0/4] initramfs-crypt-hook: Speedup disk-encryption reencrypt and other improvements
Date: Fri, 12 Jul 2024 10:11:39 +0200
Message-ID: <20240712081143.1376952-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|VI1PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 73aae2bb-b399-4d2e-f4f5-08dca24a48fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Zhwxs2fK6+CjOMBno18ORVcKQz7ySM3ZwAdm5Cro8DMkP/QGh/AZAf+PJk5c?=
 =?us-ascii?Q?QpozQOVM/KXjnmBNJi6PUWUVFYXhiD6PSDYx3krWraJ6+gt6kqSloxHmcAnf?=
 =?us-ascii?Q?dOIveQXYB7JfB9igfP8FGea93os4apF+ttTA7CDx0yvaQGI8TtTQ97pNmgxz?=
 =?us-ascii?Q?t09IitZ7GHKLN2OLyNZ+KLxbaZe2Eeasz2VeSY0VcXn4CmFyb8P726DeDxqQ?=
 =?us-ascii?Q?BYf8nvn14LQV9fC/YfNZKnTn6SE9Kv4eIPJknZNKJHQG1wgOUrstxNPyjILJ?=
 =?us-ascii?Q?nQZwPb3vNEoKJLDasCJlKGXKmGPoHhiJzR2QaZQuBzVU38o7KeNJC51CraAW?=
 =?us-ascii?Q?rNX5MSDOMVpODXc/g+1dcmH1VwMapR+3KInMtj+3XV31fMeHR0wlpTEyp/Xb?=
 =?us-ascii?Q?QL4b2uXZqi57NoAGXn2QmDdmSer6b8btDPzN+3yJw86NXmaml6UTsFtShPVg?=
 =?us-ascii?Q?B4SOCXLAMR5gDmByeNkrkKd+5SbLCdMl/CE7Ur1/jNo5vffBYzljsUOox1pI?=
 =?us-ascii?Q?GylwMmhBv5rSYMEmYtJZhgf9HNr1KIKIV5Br/yXlrU84ySqLfDxvlwMmFdVo?=
 =?us-ascii?Q?IHuqh1c/RGjhC8o7rDQ7O0HShMJY7WSJI0k2gOikl7l2ensf8uT15EpFkbev?=
 =?us-ascii?Q?zYcW01zntRrHC6hrUHqTdIQNCXiyK6lhMrVm7Wjfvz4gBTXmAUc4mdJxPcyH?=
 =?us-ascii?Q?L2KWi0oQjXWsf6SrV8cOU0ikLraJeo5JBtcToZTEbzciDVBRHaueEFK9I3HD?=
 =?us-ascii?Q?BDDUtwi7jTZY6LDrH1CdwiC6LGscny0aYsLwQFpVKgMPoFuY5THhArxSGTmc?=
 =?us-ascii?Q?gOAO+TPsClZPHzSw5eKmWbYHQgtPQ/dH96z68mG9SWmo3jgywVYHhm6/1h9+?=
 =?us-ascii?Q?gx+N0/d0dfk1mqkPSmINRTnKwfbz7qv94OKavNGKPIyD45EurUFtBN5PgIHI?=
 =?us-ascii?Q?Yp/MXLhExU3Rqvh8ab/6/GQCayf9DZwKfkOxlcb1R9MKnwIpIoVmHC2oiSh7?=
 =?us-ascii?Q?OJ/u2udMwU9Tfh75IeNBXus6PLTk/Mj+QWVoVOiWwa+39icrCTTb88YuoF5P?=
 =?us-ascii?Q?4UqTZzFPCN6WfhOvbishWe5UdCZGZILzlqLGqHfzVYNx5yTgppF4Ax+DsEle?=
 =?us-ascii?Q?t+XTbZIuKAAIWhzs5oxLYntrOhoNj9iPh3smqbzsC7JEkHiQGIyxiXu05thX?=
 =?us-ascii?Q?uDN/kAHvWjiRiOXJ0YK09e9DESrhii1pQZGL/y7FFaka8btAgS5UK345YmOE?=
 =?us-ascii?Q?eEPxlkiScvjBVs875qemJ7bk7XMn25iLtj0c/Yr/6EicpvDy3saoiZvJEEyn?=
 =?us-ascii?Q?PUb6MsZTPaNwEjWDNcc1TgwwVz2n8ix6d5n3N93sV41vZg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bVKI/KG2B31SmtucvjvO+lsNpHbF5hoh6i8kEwgEkwdV1eXzqGOD6Cj1twnh?=
 =?us-ascii?Q?zANfOJbGn0dA35RIS7IpGsacGeFK2XdoMvEW5l6DXZFUOEBEEKZHm5sr3siT?=
 =?us-ascii?Q?2ILuH7Fcfbw11bcEJgR2BZXUUpjpDyx4JJP7L+/2bU1uF7evBrRcoIjf0Hvw?=
 =?us-ascii?Q?cDaUAFVonCvGssVAjsM431ZjGqe9tndg8iIRXQVoge4i7ok57oR830YS6XKz?=
 =?us-ascii?Q?jQdu1DsKExXxHP4UQRKe4EJczvvPfvaFFjt4WNOWwG639XVn343TA179VnXD?=
 =?us-ascii?Q?Y/YHyL9Fhw+wdHhccQkpN+LM21EQ/SqyXnNsz77HFSJBXLMZsF5/QrGPkzbs?=
 =?us-ascii?Q?zhqscsXjfZSuwn/P40eYOvWLjB9da7rEKUkuvczj2ul/V7e34Ll0kYC1JyPK?=
 =?us-ascii?Q?L2VbvM90mzh8rHKoqyuBPTE4AmeDqBYz9vv5hnrqQt6pJHUJvn4Jzaq8SI3Q?=
 =?us-ascii?Q?Fl2AnMFpqgOBX9pLOTu9dJHDkjGOwtAhynFrR/LGLB07VygoLNFEyC+GWHWO?=
 =?us-ascii?Q?HHT1bZPmeSQUpZsYlGnGZVTHI/VUh0CPr7rcNDkSfotyKgvH4WbaZBW/0IdX?=
 =?us-ascii?Q?f/oyheqkDUw7yZbWOfzTAlA4aQOSVaJU3FG7sqdWvKt1wjf3RgMfInOwWtBy?=
 =?us-ascii?Q?wl7c+iZ4fxp0ncmPuJs5GlqyK5HK9cluRnEROkaLq5GTfxlrZ1sq4XOQ/pRn?=
 =?us-ascii?Q?daLAyJ3lyki+F+Zqq9kILb5OqCCAtnX2nPHHhkSAiLiLmoIBxb/C5QMhUNsY?=
 =?us-ascii?Q?qzBTkDqHoPWJnsbfUsYsuEb2obM64v492DCHSush26Pt6TaD9eOCqUNO1dRE?=
 =?us-ascii?Q?G/7jqWwiKY/gRDF3gF63na9fgCpHiom+4aGuqRcicLi1DNswvqUx1vgEFMHp?=
 =?us-ascii?Q?JabWUwt2fg+Jr/7jmBh5h+NsZ+adxWkvriJPxwnOIHZAvXg7yl30yOdtIE0c?=
 =?us-ascii?Q?j5f8574+WOuk5c58nbGAKu5Kuiyiqlkup2V1KwLYqgkO5PBGICwBfF7H4yPG?=
 =?us-ascii?Q?Cghh79E2LcZQpDQh3DU+hypG6WcgNBEhOvlZjlCQtjdj/bCINa3TD+na7lKI?=
 =?us-ascii?Q?OBEQyMru6GnZqwnZs9Zfc0K3qzP1supNPX5BsyWAp6r6kVtw/Eq8m8fXiL3l?=
 =?us-ascii?Q?gkeAIRlPiidjaWimjhfha/Ex1fiWQkxlaMP7zTGpBFx8iFzqhAPHxz+rW6KV?=
 =?us-ascii?Q?HtqJJ4MopfYVapQGuuVLjl8NqWThEa/joF8o7j2Jnbv0Xw1PUlOzVB1fHcmz?=
 =?us-ascii?Q?LEtenKmXI7G8nV51EWBojujqQwWbpbpM5rFIKjVtRny0m3okTYT91kXLFak5?=
 =?us-ascii?Q?mdgzskHSxEByj1A/auOVfwOjgzcjjGhH5WRP6/qTCBqxACDvpliY3S7WnktO?=
 =?us-ascii?Q?DiWCp+WqHcwxDeijvbIR1+6uO27HnIkjPKyk663uZqAPB9IEXV2v73lDb7iL?=
 =?us-ascii?Q?SDXRmI/KmWEZDMm+hAxPCxqiweBcHXuopc0ffOqyM4aY48jVhM755K2dYl/s?=
 =?us-ascii?Q?mMpvfIvcgUZmNQMJSrfl1+MmZq3asNCILlpxDMYyrONzRNjTxhatn0bk7HnA?=
 =?us-ascii?Q?/hwW3JOCdmiW8M45CQPa/4kEk2c9UEM3Fp/dAKzSXbWwW7CDYDoQnF4Y8qE6?=
 =?us-ascii?Q?6hrqTo5K5uvN2Rp6c6ycrJmt+kSwbA0lsVuWz2RNui6U?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73aae2bb-b399-4d2e-f4f5-08dca24a48fe
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:11:51.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqOddQpZX02L1lNknXbuXlDgDfZ0FrOo7RxDWcjIwE9ImOwkrBXsqVHorgBeUL3o/vgDCtZjCTH91raBu2bRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8134
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:12:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16457

Hi

This is a patch series of 4 patches that will improve the initramfs-crypt-h=
ook.

- Do not attempt to repair a partially encrypted filesystem

- Provide full losetup executable.
  The busybox losetup doesn't support "--sizelimit" parameter.
  The CRYPT_FAST_REENCRYPTION introduced with the next patch will need it.

- initramfs-crypt-hook: Speedup disk-encryption reencrypt
  - When "CRYPT_FAST_REENCRYPTION" is set to "1" (consider security and
    data reliablity aspects when enabling):
    - shrink partition temporarily to minimum
    - encrypt shrinked partition
    - expand encrypted partition to maximum

  In practicular this will reduce the reencryption time for a device with
  a large partition from 45 minutes to less than 1 minute.
  Security aspect: When enanbling this mode, not all blocks
  are implicitly encrypted, it behaves like in the format mode
  that does not erase all blocks before.

- Add missing mountpoint executable

Best regards

Stefan

Stefan Koch (4):
  initramfs-crypt-hook: Do not attempt to repair a partially encrypted
    filesystem
  initramfs-crypt-hook: Provide full losetup executable
  initramfs-crypt-hook: Speedup disk-encryption reencrypt
  initramfs-crypt-hook: Add missing mountpoint executable

 .../files/encrypt_partition.clevis.hook       |  1 +
 .../files/encrypt_partition.env.tmpl          |  2 +
 .../files/encrypt_partition.script            | 58 ++++++++++++++++---
 .../files/encrypt_partition.systemd.hook      |  5 ++
 .../initramfs-crypt-hook_0.2.bb               | 11 +++-
 5 files changed, 67 insertions(+), 10 deletions(-)

--=20
2.39.2


