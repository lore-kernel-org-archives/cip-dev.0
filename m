Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26153C3DA4D
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 12:57:42 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.56])
 by mx.groups.io with SMTP id smtpd.web10.6988.1720789046418024875
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 05:57:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FPEkGJIB;
 spf=pass (domain: siemens.com, ip: 40.107.103.56, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz5pFp0sAcFfuGM8JEATcUs5uNgUNF7H+qXQCqkhmLhfbH6a6np0jHPgn0f5SUI6yfwUtv1ME2Ab7OPSHThKHxJo3A/mO8fBEuL8UM9QS596sUXjmnBoBJzKFf79bo/AZR4TPxZyabK2IDnN8jrCP0aiJNeDTwTg9eRDrhtpXEKW2pYa8cW6+b3GYK0xMv0xmG9iH1DBkuW2b9/simSJyhTA6vGmu/VRxKZnZoLrq2Wdywol7P3FKtDmeTkdvuBtVIxMwOfYoli4T21S3NjOEK/OaPE16GoEBdHPeO+NCqCFvVePIdMHD48fG7SJebuCki9YtPcqTZYlHpYxH7/GaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6z7js6sYnc0wY1YDfaZV088CCCMQo3pre3jHYk9UNY=;
 b=cpoKh8eDKZWhaj7aLLyS7K7f/SLr19uPUFXZftcz+PYM31WLG4tHT8pB1Se7KDnjzAK6gkS4YE5r4WXL6LAooGqfaZDgsEtMko+wt87xsV6CSMuoCWzz7UejidRqEoO/pAd87i7veu9+M4PRIR8l2Z1JMERNFIJZzRFywQ/wXrbTqUQ9h/ZyCQs0huUYr0qmoXeaQ3KdwpG6XOM0MiIPenFURJnRReJaNH1gM3p6EaDwr1cTek8x2Q+eBPOuR9mVzAT868UgfoK/5Z3Ch1tYiCJ3ju7JHrUKyZTkR5Ut/eMG7fs9oUTRLvM51bJ3NsvpH+H8SK/aWq5rH25UrJDPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6z7js6sYnc0wY1YDfaZV088CCCMQo3pre3jHYk9UNY=;
 b=FPEkGJIBTm9De9LzQ7PpayypZunPt9cbF64hjGa8zEfrl9D6mV7CwacpFGRV/5qdl/YNq5XC2z4MPVagGRv3gOQfY7tjn+ClI8f2O8FdujDHp+CwEGIo4iWsIQ/s+9mQ6WTfagmZfasPEZSbD4YzX8Gc9Pdf151QOUlOzk6GIt9kLf/eMYd3FPHDIUUiHTk5VhwnmnL5/4ky/c8yQI0pDfvL0VCEnXp5BmWSV9USJEv9T8kCVjhoTTUVmlRTAB1d6cj0IDl7JJIKmijCdECw1MLfo9PEvAq3Mvsa3S4i1t8dr6KsHSS/4BAuDLhSKbv36P02LoKhOk0X92HGFigBCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by AS2PR10MB6750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 12:57:22 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 12:57:22 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v2 1/4] initramfs-crypt-hook: Do not attempt to repair a partially encrypted filesystem
Date: Fri, 12 Jul 2024 14:57:10 +0200
Message-ID: <20240712125713.2066512-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|AS2PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c17044b-a37d-4eaf-acf4-08dca2722be8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GlHkRCOErz6Jdwe9UXLNynghBVWfmATZYSaTef40Ybd8EPwxCi1fGbyHpIaS?=
 =?us-ascii?Q?L4V6bNkr6nwoN9Nlv1x0T1z3JCWHYHUlAKx0UWDh+p6nUVckmo7ewPQdF3Iy?=
 =?us-ascii?Q?JotSHm3ok3NeOenyxBTGylzA2pAXqr8/nRqRjW1VAcjJ7y5ayRB3go3+IYDb?=
 =?us-ascii?Q?eb0IPkX7sdmx2xukhKrj/TnSR9XPuocJtK7KIM3okWf/Q2S1oRKFOIjfmfcq?=
 =?us-ascii?Q?NlHJ7L0qqyi7lSqOLGdedOUf1QWG2O3MCLAvA6AyHAjRGqqXUYJrIAqqJ2+o?=
 =?us-ascii?Q?HO0tXGrfIpPlGD3LO4NkoeoJWl2KPpd+3EziqDeugzM4ftE9w2Vb8O69SiXZ?=
 =?us-ascii?Q?ODfBo+tNQiqh9erBbicy3SviGNZTyx9Kls1MXy5WueBP3oZ4vvSv8PcyRCVf?=
 =?us-ascii?Q?UYWRoeHmAy0eEns6XCnsQ7ugRxY3IyWw0crONg/ZvG04DVdjdEwHJetiVkBl?=
 =?us-ascii?Q?iVfsrAOg/TTKyNZl/0U77Q7aribZt8TlIQFpVJojPM1gTZ/Z6NPZmzbzydh5?=
 =?us-ascii?Q?tlqFjjGMzf8xED0Qscl3+TUnM3H+YOULY6psQkb20kBleay1yekhu+Nd4xar?=
 =?us-ascii?Q?EzlFq5AbZfJ8TC/qynXINcZ1nt7IuAYekqBkdh+5WuUCZKhHhCZXp1FiPsnj?=
 =?us-ascii?Q?QWGudiAYDDBuIXMrRazh3ehdtHPvEt0I+uGkDJhNWXkZILWkXx+PcF9j+95c?=
 =?us-ascii?Q?dJFPKgcZPpUUpKuRCTccWsnCOBxt3JAFdrNhDwIewgafHIU8FS08DPpu5LlM?=
 =?us-ascii?Q?7e8jTCp7uCg+izIDyXuJ9qYFPwPWvsqsvK1BRTRtZ2muPs4LKDy3azsZwmAV?=
 =?us-ascii?Q?hi2bv5DtRbpZBJumLY8o043HVJva/I/LxHI+hbRinziFHpe+e3kPercz2Eiz?=
 =?us-ascii?Q?fSFkE3ODYjS8bgxKDsWoIXR9XLDbR9CmDxka3c6Esc2ObzCZFlTVUaDc+qCt?=
 =?us-ascii?Q?UkgPFhRhQgu1E5tjNjfwTxl8ZjTlExoV6PUE6CvY1TJhYxalmJeq3XPCbJe/?=
 =?us-ascii?Q?NVm31OtJpgcBrBVT3p7vfdY0Nd4+thc2i6/zP8+nmcHxtrZOm0ckejUuriKu?=
 =?us-ascii?Q?5u6IEywf9RwQA4VKL2wIVxgUKvzD9hqNkwiFfWMNHUF8gHGtR0y3Aq/iC78e?=
 =?us-ascii?Q?6DX7rLQd6HWVwfT1ODm/tlEs4d9aaH7nN8owx/kPoj/m1UxuK7Dg4Fv5/EPX?=
 =?us-ascii?Q?ZHXrFF+hB0LeZ++359gt6zQJHY6dVpHmb9EoBCVKaqx3E01mu9rsfqoEDT73?=
 =?us-ascii?Q?Cxy5YGfuRjzfb6h1cDsczn3wHREeKx7zLLM/3VEhbHZaGBXhy8Vovn5TdbOK?=
 =?us-ascii?Q?EFNUAUwralRZtSDvccOhzMzkLP39FOL7LAvtDsBT3n268A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BvJDIl+QqB+uMlB0sxutL0hBk375Vwin0ngZVR/rHFTUlIZG+SDHCai0SYSv?=
 =?us-ascii?Q?5kkLuQpxPVhTI+fxocwfRqxhwI9HbaxoDmU5QtgCGc8juoPm6plsrbWZaJNf?=
 =?us-ascii?Q?dE8L6uHb+CmcXZLPV2xVipcMkuFWQxXz8T7rrDzpliig4TggaZUGyLduvRgf?=
 =?us-ascii?Q?cOnXFIkvptDKC3xXatWqlPPm7lahGLuTc/lNXK8TxlmLrBtOeAGYQU96/U/v?=
 =?us-ascii?Q?2KpwgwbDyXuIGacHkVZlS2NqWYg9/30iv5sI+3wKqWHsot0Xbj43vmCVVUlf?=
 =?us-ascii?Q?qVD+cgZlqLSfyu+bqfCEDN3xMGQa1wqq2IewrhakZl9Fw6TqwXvgE4pF7CIE?=
 =?us-ascii?Q?iVyDLXd7s3mVpqT0eo+EdvvRDMe1yC4txbuIupuIJkYhcDbvwEpO86AAz3ae?=
 =?us-ascii?Q?+PBfaQbiplm6Fkm6R9ogu6hyr+Ou0TlZtmbOe/2o2yfWy1eWEgbZIy1VBd0a?=
 =?us-ascii?Q?yzCv6XSqaY9/4F17VxkjiOlZLCaAg833R4XBPuu0SYp62hNasYi+4TKN1gL8?=
 =?us-ascii?Q?r418FGQNVEwCTD8+cpyrRiNMjtA+9hBNjZtQiXZ4u+oJf5BpQLv3QCsC3497?=
 =?us-ascii?Q?7qtRwHf7AldnSo38nFu6SPocAEIj99+e6g/L6wZXMzHDpUZvl5a//XJzhHak?=
 =?us-ascii?Q?7U597DXyEFbq7bY/1d43LvP97gmKBsBHO3VfRpnaLdLBCpWbe30aJHJyyhPf?=
 =?us-ascii?Q?7IcXMsMor8izPJ84YoZSkGsYD9lO2i6W44J+ghlg9t6bTLm3l29aqCDPh3GW?=
 =?us-ascii?Q?NRGWi2oc0HPMN0OsfK22zcbZKavJeuDJaw6IdHP/CbmRce+O5re627BTDDYg?=
 =?us-ascii?Q?fUpPTcxj8R6S1TRzl2ZfIKvXhx6OXdM4fcYqqDBTGnlxlKhFwoU7KJuuTxom?=
 =?us-ascii?Q?x03Ukb5RoiVyTuNbFh7vNqFIlWVM+Xp+NXB2qTMU4x94sPI3T2LKumAiqQAk?=
 =?us-ascii?Q?DVLg8ucByEzlfhmPssbfUeb+ur+CBWLavImkWtrkoiOS4HPZVA6INXZCacXI?=
 =?us-ascii?Q?T5PzeRracKn+LhodbXeFIUjkjtroJ8Cmh68+Xh7jgIgmp5WFUEDxpfsmmJIm?=
 =?us-ascii?Q?K+nvRHkhfTnuEwxkuUwt6KYdCvJYPAaeyz5b/h5B9J8o1Mhlr2b4BGzW2Wqc?=
 =?us-ascii?Q?uLxbrlMRwvmgfbMrmU3jkAUjOfnPXEWoS1W98L6EyoWOduWUSM26SiffMSOk?=
 =?us-ascii?Q?h2ZMkkUECZJqlDlU0+lhDx+hFWocJO7D5YnDMEpTVV/OQbgIiF6oTplcYvxK?=
 =?us-ascii?Q?U5g7tQKiqaczJE7qyxYAVL6uooET2/VkwaMwiubqZfzm0eQb6wP+zc+y76vi?=
 =?us-ascii?Q?kWjvRWiExV/prmI3mNE/L0x4OD62rOWS1PZSKKyOe1e+v20zB5mrhcAqm/4y?=
 =?us-ascii?Q?2sKMz2CMZ5TsVwDF4wdnAm7UD3jic5U9yhy/4TF4hwWgWtI1anCOQD8dHeqt?=
 =?us-ascii?Q?KvN0teRZfT1BC/r5BYun2RSEMdPrIOD/y9I3WMOOJBxfDgXwwyFR5QymGzQi?=
 =?us-ascii?Q?badEb9ndP+IpbOL4tSYAzmFOe7g0E9afT2v9u0A+U7ZX7DRYhnVxHC/S4q7B?=
 =?us-ascii?Q?ouQ9OLv8AB7yNqCSamImzCSWFIwvcwfc+mK1RXcaYnELy+JelzxuTIbuK2jm?=
 =?us-ascii?Q?fXdzt0IJ4rCA8Zhzn0MNHl9DNYv0wc9FSvAIbbFm9oOBV9ExTH/XLJnhKMC2?=
 =?us-ascii?Q?Lfd+gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c17044b-a37d-4eaf-acf4-08dca2722be8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 12:57:22.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvpxOeMZ9DIUd1zPtDO437aAVCdJFO8pzH2cmMJA8UUQQ8yVr4ijbnf1NHLCgIPAu0Qb4ac0Stjd92g5+J4omA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 12:57:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16479

Avoids that e2fsck will repair the partially rencrypted
filesystem after power-loss while reencryption.

In general, cryptsetup is capable to resume a partial encryption,
but there is no key available to unlock the partial encrypted data, yet.
The key is enrolled only after fully succeeded reencryption, yet.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script   | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sc=
ript
index ff4c135..f943aea 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -77,7 +77,13 @@ reencrypt_existing_partition() {
 [options]
 	broken_system_clock=3Dtrue
 EOF
-		e2fsck -p -f "$1"
+		# ensure that filesystem is clean otherwise resize2fs will fail
+		# do not attempt to repair a partially encrypted filesystem
+		# ensure that there is no attempt to
+		# repair a partially encrypted filesystem
+		if ! cryptsetup luksUUID "$1" &> /dev/null; then
+			e2fsck -p -f "$1"
+		fi
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
--=20
2.39.2


