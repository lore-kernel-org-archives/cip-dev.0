Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6687C3DA4D
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:12:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.59])
 by mx.groups.io with SMTP id smtpd.web10.3114.1720771915351009156
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:11:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=apmNXLUZ;
 spf=pass (domain: siemens.com, ip: 40.107.21.59, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNz9OgLi7elP6tDRPmuvdAQTwFsEySz1InJLFzKKBxYpwZJGqv9GCOkOfN/E++ut9iinGrsIV2dxdgajuaS1WUrFLhoZ+K/LNvn6b7n9uZo5WZiDvVdHtaZkVodbAE30wub3XdePgEhKHDdhw+0qHGbBRVDlir6moL82US/GQvZLu00PlfuvDU2TwlXOfYr8l2lBQxGQdV1PRLZX7SWROwiPJPsvh3E9IcCMpFpL7MzqoVzHsb6ZtmxtOzDspyHeCI8h64ut9cSUMChPVDwIGk4dJhxRQEjfkvb0zUtkzhLqrTNQ8Ob76AlrzvwzYbmKm3vyim95bqtKotMi0eMPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q24Tu2uwjZfXJmLlSAJYpA5T7ljBNbrWYhvu3P6hfc=;
 b=QSYHuWKWyiyti04apZETHtQ0pXgo7BgIchHjlow9AoSU+rB4r3XxWaPNtil5mgwKOflJkh/IS8My5tWjeveljzJfVfEEub6gG564Drs3cbw+vTvpTbWN4JxvarXal/q9Yu9oWKG2x49v/Gr3QR5ZxQ2768Xhx7s3egWewGoPDUKF9NicIGj+cBYunyF2DfVtkCLkGZKKafu9YVsr+6FaY0lJSSJLRuW7ShKH6q8vnXx5FroCrPXMZ5BfNd62fIixenme0pHAAAvqLUKvomQ8oTXF4zpgJXfc6JEPfV9CYs/LNw4b0BQZ6BCXY4ExNOcY6evhqMXIAlWYF0YbG2hUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q24Tu2uwjZfXJmLlSAJYpA5T7ljBNbrWYhvu3P6hfc=;
 b=apmNXLUZEkqTY9xF6fD1k+TsuqUvyPX+3Zm/BuJ3Ag+awlVySbIuk5EOBzQMhFqJMrDvw/9NPcqc6mQXoNYWoe0m4QzB0jJ0V2jvESMbHzsknN+y+VWvWnZrVvBy40OAUXdHgGDxISb6LpNST7ErhCpOc8h1c1G8WA9rlJenaqUiaAwvZpfMhrI40f0+6+SHt3HNBH57PQXfkWpQeIhMPKF6mo3CHi7XsiTeHNtIvXFokxCzPfT8jxWxYM82setrTG1gCQWq8AGjkmooP9cNLFbow+W3Zg9aorT82Jjw1VU2CG+IEVj+9HLtD2/SV5bWhrW5EvFzGR/I8fm7ynYoPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by VI1PR10MB8134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 08:11:52 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:11:52 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH 1/4] initramfs-crypt-hook: Do not attempt to repair a partially encrypted filesystem
Date: Fri, 12 Jul 2024 10:11:40 +0200
Message-ID: <20240712081143.1376952-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712081143.1376952-1-stefan-koch@siemens.com>
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0294.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::15) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|VI1PR10MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d9f41e-59b5-4082-9fa4-08dca24a49a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4Oq40kwsT4Mmx43Accw90ToUwavNcGBLpFJQNJJWqOkwQc56Yr4Dfz20nsr+?=
 =?us-ascii?Q?OkCuhEcSa3IVUw58CpyOJ/qJ34BHP1YXiBsxBXNONUIxjC+n7/wD3HKo+qzz?=
 =?us-ascii?Q?XFQgokG4mvlyhHMpEZUkbsAo3mUFjjEW4lIWJhwzDVpHNg7wKaiT8+GHZ1XV?=
 =?us-ascii?Q?rK5whOm55KiJV0YQB2u2xQ7ImapPiMGD0BWMkY06y8sk8HTIhi2S0TKoJpEW?=
 =?us-ascii?Q?N/WmzhGv9s4VHU2gjqHSIUmo3mV53N0Oz9mOj7oW+L7BxZbkg2755WyvJo2Z?=
 =?us-ascii?Q?/wYDgWQEGKr8bxRNZRm7j56aAaFlbyV2c9pqDEaR3hqWj2JpspGmdve2ig3j?=
 =?us-ascii?Q?RPWpw9pcy3UkSEQCLdqMrD3LrGQ9DWnfKTr0rQaxMUIXjAIbsWWFE5Y4vCNt?=
 =?us-ascii?Q?ANlE0V3FFhCtdgQS8RsmkDnBY8h7kA5267P3Nc4582ZivMyQYKYpjaYzyGyb?=
 =?us-ascii?Q?snZGppi8hxzSjLzYQsnn3OKSJzTmcT1axICGekDfbBHBhdyC0wCNx776yUIj?=
 =?us-ascii?Q?teQ2EVY4RqAacznbJgTshSRICbsmQmxzS4LSfgvPjviMBYR3w5CgChpbYz52?=
 =?us-ascii?Q?XmY7QpfZqL0xVANNidivGmTe7WGcF1zKok4patJ9RgOESiywjanqw/1G4ADS?=
 =?us-ascii?Q?mbwBB5C9VwhMyAknHTaHfTrx5UJgZbFevY3XuWmokxomJZV2ZKaQXzasgJ1q?=
 =?us-ascii?Q?DYtkEeHB7Do6BpFa2uQE3GkhnzFv/PQ7brCqUlci1xavA/5YeetMlMl+hoj4?=
 =?us-ascii?Q?F58i8z2TdsQOf4yToH/TJa/N4XD0UZnI0PPcjRGC12Om3qKqu9/YlvwMlPTk?=
 =?us-ascii?Q?kjY50l+B1cbbxgzfATDeaCBv6ftcsHlHyykEVSLQG4BODOpKsDd+P7pjtejM?=
 =?us-ascii?Q?JoSY9hGeR/n7Yv/n6QO5ElcX4OC7TpLZKhdpyRf3i7ut/Uv183Nhakmo9MoX?=
 =?us-ascii?Q?T81RO3yszACrMSg7s2GB7BIY/0fWqJZq5WwO/0KLIqTjpyoLnbValjZCrJoR?=
 =?us-ascii?Q?ifDUYOMppeBpnQtFoehvjH8DmkLeBKJFouPt8vFM4cbWN/vwuUQl4moShxi2?=
 =?us-ascii?Q?UOyGvem8uWHzgveY78uVqXydqgLfYIEFK8FPd71/IObSTPtoUQtP24qymh5j?=
 =?us-ascii?Q?kp1OarGaBJ1u8ebtBexFOJvnmyjXb35U9DqNoMj8yDtMNM5OqwOF5tUXW18+?=
 =?us-ascii?Q?495kXtzDCdt/TNWHJofJDyDnYwJABy0aFF3J9yRh8vilZ17qosdiRkNGn2og?=
 =?us-ascii?Q?p13A0xqtWBPU775ty2q2/ggT9Y29IkvdbPsNE/LS+yJktPDXYbipnvpHU6jG?=
 =?us-ascii?Q?3FfUcmefEf5vBb+w91ca4fSvwCeXiNoynWso7TEUBcpk0w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hL+Y6iPq8DRh1XYaaq8nwAOCpJqjXRZTs5/clYTYpuVDpyeFafvs/TgAN5lJ?=
 =?us-ascii?Q?xs+E60WOzjow8Ij3FEpYG1g6J7BpNebHgX7aTLSdadlKYr6Lf24Oziq43kHy?=
 =?us-ascii?Q?NW0wgpFVTcpBrDoAyzkBsLtn8BaSwq03S0ta5ldtL0Z2dqCSBE+ZOsjI60Iy?=
 =?us-ascii?Q?ux1sl6VUpZxe8rn0KLBkyXCzwcRN4ls2tF6hXG7pAxJMqIVaGJntb7xlLbVK?=
 =?us-ascii?Q?uVNcybcEu+Cjm8X0oNgvnnVm93Fp7n7p+H+ZoRgCuXi9IurCKEnAUVi7Kmaz?=
 =?us-ascii?Q?Y6KzfhkVyEPefypiwf2vDpSScNPc2o/EGBNTuU0/VvkKKfyaDEEhgiUyUlp1?=
 =?us-ascii?Q?OaqqseD1TBA6+iOhMMQS1XC5/dP4ZKiZBOzT+YSK3uwJ+8cJrL12CdFLxRwn?=
 =?us-ascii?Q?ztz0K3/gqV4efpE38vmTmdIAsaumPesc+u6vkGO7TdunrlWpLE3PtLgBBjMW?=
 =?us-ascii?Q?F1qT2p8hldFUZsOh31sKstHL84jxVOBqryo4jKXkHkPjI9eZgUwkhUldf1M1?=
 =?us-ascii?Q?rGc6tVdmtmMzTSToI3v1vE7aWHz6rdGQCUsjAW15B1l7WmO3PHKz2FWQs0K3?=
 =?us-ascii?Q?uEolPATRJsU1ooV/PXfqZ9NKp4S0Htw30R1bV5jVED38lLsZeGSNPboyC+0V?=
 =?us-ascii?Q?3+1mWEzr7wfPLuXEq8Kq9mbQfQ7s82DTwUQ0U2GcydJmOVYbhGhovKynNcUG?=
 =?us-ascii?Q?AxoCH2/731MooTZ0mIJemb2KMrCwd1treJ9aPwX/GX2dcd/BTwd+nOoEE2f0?=
 =?us-ascii?Q?1cwoBIXJc4SiQJbk8cV8ucD5AU2MSZsVcJ1O9mR1ZcysnXa/KwEk44qRLokf?=
 =?us-ascii?Q?BXRLFwG9f3M07/91UJdtsKD8Yxkz5ZeF+pLSpvmkp1xTv4GxOtKaZXnnmKFh?=
 =?us-ascii?Q?g2VB2hB0sEL/ngHVEMjMYYl5mC24/nxEXKdeSVuK6HzuCvfm0TpKtaqyQDRm?=
 =?us-ascii?Q?q+xthOwu/ZAyMOf5bcUaErx/6sBgUk8OVF+cwflaIlUdE7P+d82LUWfKyzW+?=
 =?us-ascii?Q?fdkeT9iX0niSKcu94NGuVnEHCPje5xLtjBnB7+yOHVlBBl3wFMkQUUQpFQOc?=
 =?us-ascii?Q?omw8NkGxiXCbFwjfleS1Wxi0fk6O2F3IiLJC8qiHez9nN50PVzPTEuteDq9Q?=
 =?us-ascii?Q?Br9plfsTu6moqXQW2wfS+joNu5Ia/rPq9p9UQSGEBOHkaUqJyF8vTWodNP73?=
 =?us-ascii?Q?dZQDX3NNzyFd2C31mMu5+GsuYF5ObkPtnWcatHWA9/YmaB/vTjSRY1S8Slae?=
 =?us-ascii?Q?mbDoawxR6elp+kCTQJdS/aQ6VpW+RO/OmReFHeCeWLA5TgdKnxji2vB6FeLj?=
 =?us-ascii?Q?8dfnqIEJZmYVJgHEFYBLLMEiJ/msfqkaDrd/WBSuCGJi6iX3+fMqnSeYfCBs?=
 =?us-ascii?Q?z3STW2qFieNgXWyJZ7SWWw0aWPcxz90XomePRyJoAsbUo4LPM8RQBzpBQBYJ?=
 =?us-ascii?Q?QaM5lTMDOC5RerxoEFi+o/zVF6W+ssFt81k/DkUOy5g/6x21knqkmc5LKcA8?=
 =?us-ascii?Q?q7aopRW9z1BdFEZlYrMhtzP5W3GMzIGO6z+THGOcy8rAQrrulIXk5B02daqX?=
 =?us-ascii?Q?1NaEh9Y+Mr+Z5sYES7dCrcza+8Lyds8lPvSk+F/JDbzpNCD/dkK2f3TyZivk?=
 =?us-ascii?Q?MnNGLvaMOYCKQPh/6vxJJ1depcFVfkwJ/KJaT6fUF041?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d9f41e-59b5-4082-9fa4-08dca24a49a0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:11:52.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNayEHfK8UsJZQ3e6loHS+Br1WVLjnZqnieKUxApoN5AQM9sGVyO8T57RSTJ/q9eI8HfcKAnnec3h3QDQbydjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8134
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:12:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16458

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


