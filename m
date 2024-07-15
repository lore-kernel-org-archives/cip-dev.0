Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B992C41513
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 13:46:48 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.42])
 by mx.groups.io with SMTP id smtpd.web10.38516.1721051199476428444
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 06:46:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GYKQkfcw;
 spf=pass (domain: siemens.com, ip: 40.107.20.42, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1NW4BPc9eocgao+ag6js5ntQ7tuG7gV22Wel82sRNmWo10BH5I3d7j/XJQW0p54HFZbd2vv10vgH56rro9Jw1XNcLCrkMKbXtbgfK30uNyAHFBqnfONnKmt6p9tWUJQpCT5VhCIxyGNAvv4RnjBchGazm2ga2CvWyfKLiyptej81JPBsm/edzCHOYfiRNc+0JwyZ1De/DeqMZ15JwAqjShg+62a+cZoKilfOomlRFYlG+rf/TvkqBZTj0F0HYnK3vuDPB2xcUNxR07SGyQEpZUfj4n3HKvEQqJ6N452vh8zjkw1mS5Vpnt7ot5KWOmXQalqk6g5Gx00aT4szdSEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh23SGjVeAGUQ7fYmDH/4QReXYbWs7qDEPWCrtZ+yXU=;
 b=gTdxh/tnpERAHRtFz04QnYDPdqT58nDT2uGqi4wxpAjE6mn0tg68nR8BgEiLnEz/qUhbjH3gfFugA8mcWHMIf3AcNuVvgcXSQQg9rSBl2kWVJFaJUDnpPOpyVA8REu8TMsZaGHg2bsLTzK8I+tcq+SUU+F8eIdVpZFswaWrChyYryilluUmC6lEh+hsrjah2Ofh4C0oP1XFmgVRfrgocIh81v1P94clyPDhs5ZTwzslZGhovhvLaJJBQ/5k9k4zUpw80Y/dk0GL9nlasaXhKaN/dBz0lSkkFjlNjiGCntsxk0yLOkHA7P0ZQA6afXVD+DBRgxqHYD/Erh2BfYweTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh23SGjVeAGUQ7fYmDH/4QReXYbWs7qDEPWCrtZ+yXU=;
 b=GYKQkfcw9KevJk67LdjMuC4s8vFSitf2GVr5QFPPn0tRlLWFoeJNSHXzNQ1qaqlf+YyUEr7CtI/XY7BpTKVadpDEElM3E7WHJMb60mXWwkV1ZaIdBBWROkeF29iUmIe1deR4V0dj0P1Nxp52lg1za6+iuMp/D/S7mW9eTXsJdP8m/lmeyYcNUlnnkEjItCXWtJ/+4OHKFfy2iimXmcXUV1Hut1U0Zds4/8hjgkEk9C/RHem86R0T4DLgSZShk8ZY5BN4D0ZM3HORaNk+iazeASlNIwUgrUc9zXsTIw7ElktCcb7/raBL+yDbkXiIq4iDdY2ccDO0vxh2cEbywbhr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by DB5PR10MB7871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:46:38 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 13:46:37 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 4/4] initramfs-crypt-hook: Extend README.md for CRYPT_FAST_REENCRYPTION mechanism
Date: Mon, 15 Jul 2024 15:46:30 +0200
Message-ID: <20240715134630.1640160-4-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240715134630.1640160-1-stefan-koch@siemens.com>
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|DB5PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa66632-4f02-4af0-5663-08dca4d48c8d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9p3bXT3s7PwviSzJNCpFsGKwUQvh/w9kwtrNKyy0SAQ3rAQ8u8LxqexCRMQ0?=
 =?us-ascii?Q?QUpwok1EvzwFAOu8LFeK2GZXbI+bjgM6OEDkvF9/czsU4jUumCxWQePsz4sA?=
 =?us-ascii?Q?q8uWszKbW6Ja1Ru305l8A5JEsYQjaGGzrfwnhNJMa5xGNDfgeEYANuU5uHjr?=
 =?us-ascii?Q?zNy7KIoXk0K1jTSwULfoLoGlqsM7DOjlqDI5RJbkmqvk1wQLCrBROoPgGWvm?=
 =?us-ascii?Q?1kEeqJk6qG5E2CCj7aDP3NhfYocZfKi2OqhLnmdKAydFeBAJuWq7MtyeSHWJ?=
 =?us-ascii?Q?8GoXkNixWWdpVum7Wpkf9oTSkLLXVvcAC3Pq0EIumlIT47jZqo3qAIenZ8fk?=
 =?us-ascii?Q?VsDMAwzTD6PAXtzB/yndKUrTtwdge3BJN0c0Z89InCv2MEvN743TjgqhXBJw?=
 =?us-ascii?Q?23agZWJNmjIx2ueWacoLxWz0GMVxSrlivgN3rTdWDZa374Pur5eXC+SHAsHU?=
 =?us-ascii?Q?J5duUao5Sha/cilx92BJ0W5w0nl1Mil65z3bCyckSk8EHGZ/PesSLm6MaAla?=
 =?us-ascii?Q?8/nBrOhuX/I2RE+1TDMVwCHfllK+2Biq9rskb5Zxu4pTN9PgNbpStWAy789M?=
 =?us-ascii?Q?zWuK4qfyvkb6Eme/OqOKfRJgmNLDQ1jRlcaFUu69ATaRCTqc5jkV7ES73028?=
 =?us-ascii?Q?n5RQ+9/XJkQKU2elu5Qn7dvGcpKRk8nHwh15RjNPnMQ9DHAzYBrPSZlsnDkt?=
 =?us-ascii?Q?4/H6pfQYyzndoMSXZ0drbtz2Ci00YBdjzibpJQoYRQCGCnqA58x7A953N1o7?=
 =?us-ascii?Q?IPFj2Z8JpreLap8f5sy49hU7pBcI845hun1txUOMeUkb9kzGbRfk/F0c7cKj?=
 =?us-ascii?Q?QnQ0djg9Y3R6Sb1XVixy2qo6KLKyKTBhTeq6Rh0xuVIci5l9JtMFEjPZpoPM?=
 =?us-ascii?Q?XTelpyYsEFR3X6lQtKA0whBIzeE1Rz/vAT6wpl9pIqpuJsz+aO/ee9ym9qpS?=
 =?us-ascii?Q?uPs8aEOYu7Ttt7zlH5vEp1QBqFITRSdr9SUK9BnByBx9Zm7N1EJWZC6XXKvA?=
 =?us-ascii?Q?gKQSQXGBTY1t3eHiZbyDR0pqeepQIEY4t1ifOWbULU7ZuSmTaHImDFYwNY55?=
 =?us-ascii?Q?TGQtDKosCaAX9B8CY8vdG71GIBcH0mh54cqDPkCZIBNBoyQV+BweNg1AUq0Q?=
 =?us-ascii?Q?oEOt2ZiVoCwdzlLk9EDFCfzuOomz1XSliiVjPIBTv4PPw/ZsnXz7OJcC9486?=
 =?us-ascii?Q?bF4iyvTQq4C1/XwD0ZEe/wooYuuSzyEa8qEmp5RHt49Aayb9jXS4PD07vec4?=
 =?us-ascii?Q?p1sOnPMuPJcGZGSu55vC+NxBoWcatXL+3cBFVKXdnl2Fnxb9hS+m+XIbw0wL?=
 =?us-ascii?Q?83wvCam/WNxWomC4CvPQTj7QH8AqWjpPXXBOykYGLQ46Og=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QsybTZTIRvvjPzXqXLOixaUgWI0dt+xiYOGPgoWS/97oyrl70R6NiTb4UfnH?=
 =?us-ascii?Q?USagto1WYLiT8SZhEHPewtQSwsHWZ4AqBkznemHP/bjMKQAmoV20OBVCJwuB?=
 =?us-ascii?Q?zPFJN551R9q7iHzfEujvlLrCJhRKATgLPi6oXPFUMPlfIvrxrDJMrTSA6Cnx?=
 =?us-ascii?Q?8qti+zah3sF/CCDfow9wLtKGBwNAt1MOpu2W+rDiFFxdybgbcDh7ym0khrm5?=
 =?us-ascii?Q?ABu18TAQlboWSibbcsOBtFoiwU04jkyP6BNEbJlxpOoRPPEmhIVq6tkOjukV?=
 =?us-ascii?Q?Js+EG1KRu3g8ssMsEmT4652zuxf+X1kxrfKFN3FXOaTKUqE1i6HIwzMOuxve?=
 =?us-ascii?Q?9zFBfFv2UvdondvMXMAJkqw+o9S71LPAXiN1WICBxKuy/NaAsmfz3MNFT9Ei?=
 =?us-ascii?Q?/SRiTk0hXe46mueFdozCz8Pa+OlVqbSx2s++F9N5Ywk9WnAzlTWTW2YL+e/R?=
 =?us-ascii?Q?xlc2mEjhNl2SMVrHu1PbA696AzdnpYFThx5BStsXmfwxonAoGEIGQ5aGrGJZ?=
 =?us-ascii?Q?riv2HcP8LbTlBXQ5NKUTyDdVKQ/duqkRc2oEo8RYnWCKC+o2a3yiy0VF2g0z?=
 =?us-ascii?Q?f/6ub6A+OEnTa9vtwr8cVKrvUHws9TZ2DZ/CiSxQdE/hE32haM5+vK7C9S3D?=
 =?us-ascii?Q?mEXB+ofvST92G58XYh6S9h2/MjxEY6wPhEGOVmfZfNdF1t1JSiibYVs/+W32?=
 =?us-ascii?Q?CYre0T9LLQJuImpmmUXXwxipfMIpAaJQjy0u/t4bhiTg27ITg6EaaWefqFpJ?=
 =?us-ascii?Q?ZC0X6+U4wW/nOonulrE6rCmQy9nB6fwRehTMgVyOEA2JaFchVULb5lVj0oi4?=
 =?us-ascii?Q?e7hMdB3DSieA1O3SVBSB1hIK3qAhYcJ+X/EBsQ05XkFc/mkUCE0UpSBufm0G?=
 =?us-ascii?Q?WBvC9TpkA79vHlFDrwdlJ+vM4Of/DpgdgaGpsC02bFfM2IB2Xa2zNGQ0NXA6?=
 =?us-ascii?Q?D7CoE8+qqd71fP6BNcPGXlkdbE9bKZi63fUnZbdxvpE50zMEJZdA9wiWOW6z?=
 =?us-ascii?Q?A56jhvLpYRUIxIOyfNTOFdFCNnyJJlW1GmzPad47exPFr1jRGwDL113jCv3Q?=
 =?us-ascii?Q?fmbkFrn3X8nEliFcRzKpgxYgHmw6iJ4W90bzzOCLWfeeXQSvL3F23k5Rye6t?=
 =?us-ascii?Q?VuVKuL0EeFrjpOgTXv5KUHqIjNnSlOfDl+5+AcRjXcVVF2C+hodkndgn9VIL?=
 =?us-ascii?Q?vfzNwcKdPgujwq+jU2YUEbi6T6Znf6lKSxlRmkop/u+8IOxeqSUfZFebwMzL?=
 =?us-ascii?Q?IktpIkxY/7v7PIn51CMpP7F+aDzZMEfKfJKjsk2tGqzLKL+nzwQKLJZ3D8tE?=
 =?us-ascii?Q?ZgxLSENHK7heyaA7skjA5OCmYwpCB2F8ercXUu9wWQRbavG1xKIYLf5+ATeT?=
 =?us-ascii?Q?WnY48Z7crPJYY6tJomNbRrjj2fnVU96aen0bRy+IzJNxv5uhDznAii5Q+J6F?=
 =?us-ascii?Q?WJkTCyEbiVUv+hRkQJZDhVpBReSdPcdHfsUEjPo1iV6/boQ/XQzT4h3pbWxC?=
 =?us-ascii?Q?a017uoLNuhg/TU0MRH8JJhvl/52oZpE98OwqqzoRtupy5YGEvDTF3Clo9nSU?=
 =?us-ascii?Q?YZxHGN6F6Vc90vH0wJR1vxi0jqD0l5jZwUhlwjz45dszdN2xf1PpBDwJlOsn?=
 =?us-ascii?Q?skDG3xHjmusEguR0FN3jahYeqGZ7O3Z4I/aAGtjuTCfd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa66632-4f02-4af0-5663-08dca4d48c8d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:46:37.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSlSFBrSwdfRzUspGGxFqslMtRaDtLtwWjRcWCVOQyRDKedvM2HVOKkcsxvEE6moa4AT0Pp3BPNpbh2ObzMYMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 13:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16497

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 doc/README.tpm2.encryption.md | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 3f7e89f..a1e6dd3 100644
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
@@ -58,6 +59,36 @@ The mountpoint is empty as the root partition is mounted=
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
+Some disk encryption implementations like within the Debian installer
+will overwrite the entire partition with random data for security reasons
+(e.g. wiping old already deleted data, hiding metadata, etc.).
+
+However, this speed-up lacks the described security benefit of implicit da=
ta overwrite.
+So for security reasons, it behaves identical to the `format` option
+(there is no support for explicit random overwrite within initramfs-crypt-=
hook).
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


