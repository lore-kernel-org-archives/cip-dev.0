Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30215C3DA60
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 10:32:30 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.71])
 by mx.groups.io with SMTP id smtpd.web11.12230.1721298746878820135
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 03:32:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ww7/lycg;
 spf=pass (domain: siemens.com, ip: 40.107.249.71, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzTEGFipYtqWnxOWiffg3q+Cu6cLkQBif5ddBDmbCsClBILbRndTm4cE2kONwQQ7E0KrKvqkKsY/p4nkTcSFSz/tnlR10ylOb4FL6MLAeZWPw4WZpNOTT6ibZLQD5ADRarOcNQaTdRuYukUCVFiWLr+0moG9XzV5u8QU5ZIlnnje4hXKNwCLJs3XmaIZezezW5dWXvmKtIzZbaOhINoRxyn2blQW+gDOfe+AoNxuuovGg2FYNTYU5pKpVlRCPBKZXRkKRgWzhE/dPC6fyAZKE8rrpTCOF+Hjvq16+Dd1MDHBncgeuCCc/gWrHgnhuUVxZOPkYygr7mDk53wU6ehk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmhf6pjsjaQn40nCtLLpSxwoH/tLp+yLPREUb6YFbWk=;
 b=D5FBoZsXpb/RmfNnMNhempdMbY5/iA8YRn9H/2fv8D6t7JQDM3iVRAsrclCIFOZSwH/iqu5o7Ag01XPcyIn9H30wPiCzN1RzCMQBqHHzk82fkRsCqw52gcF3S32Ra12aPfx/DOcx782G0qFx0tqbXob2kZM4znekvxSqa6BoltmqRBGEdp1AvL2ewxuIh5DEGN4tIpHkOYHYV4QRzZ6dWOQdDZtlQNVnQKjg/+LKwJrsFL5/5LIOvBUH+q1FvdY4APW7aUly/b6NwujStBtX7PpvSlcYpRHxC6jv8/D98wBjx3vlClpEDiiEeD0enJUUFXWSqljiPWeQ1laICxWHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmhf6pjsjaQn40nCtLLpSxwoH/tLp+yLPREUb6YFbWk=;
 b=ww7/lycgoLdmNYE6YVWS0DxQ4l5+WbUFNnzqu8rExzskt2wV46Lw99zunEPhK/z0Ese3bA2WYYca6QnG0I/TsCrbcfbGlYloIfypGbK54fgsqcFQg2bjxMWw+I4o6mKgWo4hCDDvdv6TjyMGoLOkXViuhUOFCdQxVai9uNejS471CmEu+Qv8SXoXizw5xBzfFEuih0U0DE5ix6vjTV3DX7S+aU4Oe5e1gXipjArZ7541FDuuHxlQ0+QJZKYq9woXGDUpFItYk+j6SmH7VyaG+RquebJzOV0wM12GqR9PaRRUhyta4TSVAaXfhcyfsXAAKxIc03ZrLB2Zo6HdqDPeWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by PA1PR10MB8389.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.31; Thu, 18 Jul
 2024 10:32:24 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 10:32:24 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 4/4] initramfs-crypt-hook: Extend README.md for CRYPT_FAST_REENCRYPTION mechanism
Date: Thu, 18 Jul 2024 12:32:14 +0200
Message-ID: <20240718103214.1583403-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718103214.1583403-1-stefan-koch@siemens.com>
References: <20240718103214.1583403-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0434.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::7) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|PA1PR10MB8389:EE_
X-MS-Office365-Filtering-Correlation-Id: b3143b04-a4f4-4019-190f-08dca714e999
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bl0E7rBNmUYqEeb8nvSOmOQxk8qw1VqTy3++lv238Kn1NconLeYnKD0W+Rfz?=
 =?us-ascii?Q?YIamESeyB3BHHPbjNTrEGqA+5acCx6EoTGl/L2BaC7YaMQrmVt1tkEl7GDyP?=
 =?us-ascii?Q?TDa4/DdiXO/4JSK1jcQjR7jwwhoLBOE+1NKJ5dhK4m8xXl0kPpTZFjpt5KEd?=
 =?us-ascii?Q?IT6vFdQo2GrRGBHHJz2fGaxbP/MGyVOXf9gui8V+fusvnXM2wsoHvRK98/dB?=
 =?us-ascii?Q?22FWJV+Yygg0YWC9ZAvnTRDRlw2MyVPYI6Xrd2VjEM8CHAUSamWwKZSTIz7s?=
 =?us-ascii?Q?TxsXvO24AiWVaWJa/5C8asVPnHSYy8UoevIxoDwb046TCe9kUWVmyQQ1mHcb?=
 =?us-ascii?Q?P/+Fifx0c5zBl+JLVMjp2tmJgNXMBeIGvRi0K/v+nVCdZyNKUXRpzHgSZVUa?=
 =?us-ascii?Q?3LyxwztroYYI8eHd9InFGAxsfBgzNiVjOHMohGNBN5BFip9VjoPgTDgeUHet?=
 =?us-ascii?Q?jlC1HGV26rzs9mq9crtcZVLgBu1InSakJtFMJTSk4DhlqeRFebpi7yeM4hfk?=
 =?us-ascii?Q?5DC5IyeOOwr4uw6cmxhApMff+q2TayPB414ozR3ea3JBkiDL5j4Uk5drvTGV?=
 =?us-ascii?Q?vbsNeLsmm6HZTNvjvoWPs24nbmBojgNczDLSn4M08eKCLtlCyVfpF1PQ72ae?=
 =?us-ascii?Q?FnSo8SVlzyATY/11WxaOvZ6IRn8QYfIHOKa2JQ9i0MXbry1sADD04VNINdCE?=
 =?us-ascii?Q?uyfhsDEOkfVmPNIm9GZeD2vP9mhcBANpJE/Js0E4JSgFy2iSakxWYoQ3lo8t?=
 =?us-ascii?Q?7xfZnaVGl9Rs99zU2jrERB1bMVXnxFnD3jYH4IKSf76FN7LXch++U9HwRpFn?=
 =?us-ascii?Q?Y47rATMYBqdOJ4/APBBS9Rpqd0CKcBvCgxjSekkAJblfgziJrZxurGfHQZzL?=
 =?us-ascii?Q?Rv6uww53Nu+b02N0DxWc1oK+U06ylP7As7h8LAYNDdYdR2Jnb0A0uFKXsz1W?=
 =?us-ascii?Q?h3ds5eRM74y/QlPiUuH/G3AtgdWzG1m3B0F4GbZn/DQ51AX6QwA4/nyILdqf?=
 =?us-ascii?Q?qvpj2cb++4/VWeDfg9BfNir6W7aOdSIYFxh6FSGKzFSnaWs+dEhsO9Uy7nBl?=
 =?us-ascii?Q?UrYoPNazvjMERkwk+3jsO+klh1ij1qi9a79JD3YE9ZguYDAbbki/C1ppHUnj?=
 =?us-ascii?Q?HSAzZnwyvvFsflReHD6KP4OiGREX7nq4N8ScscVxAwNnLDIJg0ZTMAO6UtXY?=
 =?us-ascii?Q?luzlsoallgVxxhFd3GT5UqMrvpNWXt1w97iIrGQ9oBKYb8LKFju7yXlE7KPF?=
 =?us-ascii?Q?gTJLvtPj3oTeiqg4bBooDmD+nP06KfTIsE6ZTfuctcj9fGQAs2Qxr1N1mDkT?=
 =?us-ascii?Q?l413KfAQ9yjVd5sS0j21bCm/bBs7zbZMH8HUfSot8y6w8g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WG9E4/ovJ9qW+UdLavKKD8/a1juvGP1dCjSb0VLGFmecLZqgMKhvshE9RWDl?=
 =?us-ascii?Q?zJrRnWK6+L2pOrS4cJxvPK2llpwifnw8FK7c+KYaOf34Kpii/EwNgG9nuP0O?=
 =?us-ascii?Q?eqXLLRVW3cf4i39Zxi6szHztqeHgV4Ryad/GS6FDNhrRSK7rds/OKz7t91nH?=
 =?us-ascii?Q?PtCEbguMnzfhJSsmHzVGwDepoXdEiGPfh2Ij2cr/NnbcQ8Cc6kqlwS8IXAUU?=
 =?us-ascii?Q?zdAKyudaVGBXlHVEBuXNRqehVB7f4TTtSYOi5ZIYBLTmk1bGCj1Mfa+T2+yS?=
 =?us-ascii?Q?+9ehvD87xtlsc1YgESdki6bFifULVZGYF2wi6CHS+ha9sHELeE4s2QfuHegH?=
 =?us-ascii?Q?BWbU7sQXkV3HYX3jcRCOzwDIKywwHHmr2c43C5qDklVaId5Bou9rsOT3E3C3?=
 =?us-ascii?Q?Jd4N9ru4xcROLX3UO0KfZAkJfjxOQbPt6FHshbYxgSVWYXjU4Fu8n+c+/dG7?=
 =?us-ascii?Q?sIUDaeDpF/ApPU+vquwMNmxaAszYEM+VsER9lUScSC8g9ElPLEhvHr18afMX?=
 =?us-ascii?Q?YpLsJ281cVPv0Wx8ox901Smwsf/zv39Q+qPvd2jlnlFGYv0PziGqa9E46TRE?=
 =?us-ascii?Q?AgqVWX0mN9Yms7gmIOkW0HIhplY/pLC3mfdeWyi3+X+/0aGatQepHtRar0lw?=
 =?us-ascii?Q?gZCe2rY+iUhvZdLGm5NWvl2aB+yjT7eTol2R5w82q37aWsHSql47Jw7B2FSB?=
 =?us-ascii?Q?Ky+erOyc0UFh7wj942zrX54zULOjpL4rg+kQcnfjzc3cDuXeaNQZ6a9E1Iuy?=
 =?us-ascii?Q?NikUvG2pb+kvQbbreYUapIyoM+ErMNdIR1sXaTnr4wm27wxnA0xhEiebBj9I?=
 =?us-ascii?Q?mFawpSxKvOmW44ruHjmr8hIE060hbisuEuNZv6db4yJY7MDiGSQJCzkWg/Xy?=
 =?us-ascii?Q?r8oQwMIHbWMri2i6/6reLtSyZCc8qvVibklQ+wurzph5+dRv/x+Oz7mgcgR/?=
 =?us-ascii?Q?GeQf5S764tKUk6ezLnYgjXeum2F3x92myCs58UcdyUvBPdkdTukLOTqgpXVh?=
 =?us-ascii?Q?1gHBoVk16eHuU/BXgQe+0gpq+9reZKMBBxCFyLcFrxy6INEbeXj6xZmV1zdl?=
 =?us-ascii?Q?ygzNwJPLazk7JzmE4R6Ldb0sdOMXPeQrDmzbsTSVZa65edFLPzMhzfrWPenm?=
 =?us-ascii?Q?9iWEKowwC0UTtwdhNusi+wJ5iERn26MgSCDElcKeyWOASFK2AWv3Jdb8eCM7?=
 =?us-ascii?Q?wlvINd4f+hKflMaqVNPgYbZmpy2/hkmmqQGm7kofeqapXnOlNTgIP2KW4f2s?=
 =?us-ascii?Q?aqW3ruqoT98Xo81Okq5KSpJtEnZZXpqDlJNP7gVRx5bodIBaJF8HwFt9adqe?=
 =?us-ascii?Q?/SsaBMn4m3tCMIECOWxJpZ4FckD6rbmx5B5PZQ1px1N5fBTtT2sWzHMCpVUP?=
 =?us-ascii?Q?hwqEiYqB7aCbFtbjj0CoF9ar99P6LHP49u5ntOi027okT7tG9D31R2qWT7ce?=
 =?us-ascii?Q?JZ/i8c8ibuX1XoOmbV79wGNCwODjQZd9XlxZtO6RfzPkEbabr2kTuC0nCUmI?=
 =?us-ascii?Q?+bnEdmRgTJzqRVWrMAbCdfTe3uuV0u5FggyIAj5bityLuVKRyEOcEYf7fsnb?=
 =?us-ascii?Q?mGYX8X2LYZPavd21ItYHA8ioT015aaJGN3hcKtGr9HVhI3mZGQ4R9FqTvQwX?=
 =?us-ascii?Q?Cy8n5tF7gfDhMp0WpEx8Paxzb4ZkbmAcpW8IxUKrp1l0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3143b04-a4f4-4019-190f-08dca714e999
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 10:32:24.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umEiPakYsPFR1lH6CWsgk3Loqtp3+ey6YIl2UTZHZMq3VrfJoIcmSJUuWZ7tOSJ08jmjaySjhDbGYqyklVmg4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8389
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jul 2024 10:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16582

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 doc/README.tpm2.encryption.md | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 3f7e89f..3efbd79 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -38,6 +38,7 @@ or by adding using the following command line build:
 The initramfs-crypt-hook recipe has the following variables which can be o=
verwritten during image build:
 - CRYPT_PARTITIONS
 - CRYPT_CREATE_FILE_SYSTEM_CMD
+- CRYPT_FAST_REENCRYPTION
=20
 ### CRYPT_PARTITIONS
=20
@@ -58,6 +59,41 @@ The mountpoint is empty as the root partition is mounted=
  by a seperate initramf
 Both partitions are encrypted during first boot. The initramfs hook opens =
`${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
 during boot.
=20
+#### Speed-up disk-reencryption (`CRYPT_FAST_REENCRYPTION`)
+
+As the `reencrypt` mechanism doesn't work at file system level
+so it wouldn't detect used and free blocks.
+This means that the block-wise reencryption process could
+take a very long time depending on the partition size.
+
+Using the `format` mechanism instead of the `reencrypt` one
+would delete all existing data (without wiping). This would be very fast,
+because it doesn't matter whether a block is used or free.
+
+Set `CRYPT_FAST_REENCRYPTION` to `"1"` to speed-up the `reencrypt` process=
.
+So, this would be done:
+- Obtain used space of the unencrypted userdata partition
+- Shrink the partition and resize it to the size of used space (minimum si=
ze)
+- reencrypt the userdata partition now with smaller size
+- Expand the encrypted userdata partition back to the maximum possible siz=
e
+
+A temporary loop device is used as wrapper to simulate a shrinked device
+because the used cryptsetup takes care of the device size and
+the --reduce-device-size parameter is limited to 64 MiB.
+
+However, this speed-up lacks the described security benefit of
+implicit data overwrite. In general, there is no support for
+explicit random overwrite within the `initramfs-crypt-hook`, that's
+only implicit for the `reencrypt` case without speed-up.
+
+Some disk encryption implementations like within the Debian installer
+will overwrite the entire partition with random data for security reasons
+(e.g. wiping old already deleted data, hiding metadata, etc.).
+
+Keep in mind that a power loss while reencryption will cause data loss.
+The key is only enrolled after fully succeeded reencryption, yet.
+So, no recovery from already encrypted data would be possible.
+
 ### CRYPT_CREATE_FILE_SYSTEM_CMD
=20
 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create=
 a new file system on a newly
--=20
2.39.2


