Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11290.1795689093383602819
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:31:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ctQmuUNV;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmUVkpEcK2WrrAFDqIJjXDK7xxyJqVSsSzGNoG0Os6WXDfX8e3Xcm/MctweHDjEBEkhu7Nq31nItcu0veb6xMTWLxOjEFpdK7LpXFonyIT8ZS3HyAALU8ju7/heqrZyglxEiRnhQ0UIH2E0kifEeAQOyryCZ1Zi0nwm3UjXJuEdw227t0m2qFGiy43i2jHAL5EXhlS1tWzmw7ks5/qy4bEFbfhQrCh7EJMzRlPs4BFCvr/3+3QOrycWMy9jIrXdK6B+qPEB9eM+dRI6bZKeJLTsNj1juma+JxfPEiDgCjzgcd3GXIXzrsb8pTKq7jMum140P5RBk9EQ9rrE9JjzcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbD9UPtoBwD/diutqYpPZH9Al/DIYq2FLuhJ8/Euwgw=;
 b=fIwC04HUoV8dd06WXfFZQcsASw5rrROQEmrG8iEHf6efoHkNkbHpJ5HVKWPinYp5GFobx93ssHzeP93A1JDSHu9bgWARWv6ei4xFqS61eXDSEobiyHirY/nL8kzBL/k6ZS2vvWwEi22rXP3AU16SzlSvmuh04+2prSjHjtFi3GFT4MSFO/qQHEcF1ajoNka4GCxb5JfG1UuuvkhR7FwutVadY9MzYfiMK3jc+H8v92umUtseiIyo096mk3O9zbShGgpRfLkqcndYjiiYyz+8Qqc/vLQdWGWWAm0W75IGySEBNV+iRXwzNShTSi1M9BEOUFiw/+UltjGYDR7IKQ4frg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbD9UPtoBwD/diutqYpPZH9Al/DIYq2FLuhJ8/Euwgw=;
 b=ctQmuUNVIieQx91BPpB5iqnA/sTdsuwPkWfZ5BfW6IyjsZE9dxyN5iPZpNW1rIFFAjPbi5qqYENFp/6x4oYCiJ7H7IK409i5Zpr4wlvNAKqSH2NJLeYRgB+w4j4DggSXH7LepCtbvf16VX474VwzOH1LTUzGN68oBhiuWPfM6X1R4B3i52YdO3pCYbn2/ni6oxRuXaugyIKUKydZFpRZLstbB5LLBXR+VtkrNSS8CAuutfl02e3RPk+r9GCkuo+GA9heiQl7ufbRPn/GVba2Spe1+YNsaSbSrGps+Fi4obkMCImJSry/H0FpnscHS3hoLNQpHkD7TdLzz9pahB4BRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB9591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:61a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 10:31:29 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:31:29 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 17/21] Kconfig: add option to generate initramfs with dracut
Date: Thu, 26 Nov 2026 11:30:03 +0100
Message-ID: <20261126103007.2922985-18-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU4PR10MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: b37e9fb5-befa-4da3-7aa7-08df4ba86e70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|55112099003|11063799006|261022115727099003|261022075727099003|56012099006|261102123227099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: tdr5Kl6Tk0RPwI4ZOMTXYyFDW8g6s+N/HieKA9FaIt8DxkAA57Vf4oZlq4vnQzVhcy7BIWydKOngauA5U9rLumoRnQQTQa+Y9VOhbejwwRI5YInC3tvwI5y0jb1M9sSiSv0Nwgt1/M7y0rrVUN4FOgZjRifoKugXOTkjXQKH1rA1l8Gbl5cvwODcGu031SY43PmLxyCpiJqZdX3LKKCujjidTvQLslqqIqqqRXsm/CjnOPLpdnC99kvssVpkYbIsf4zeGtetAerACrt46r9CuHtcgpN7MOonNjDxEidyMDfdp9NkTidOvDG2CYBbYrT2GgxGDPapeWTNwns8aFPtFmG4xTOzF1uvnhMB/u9q/hHOeOInQbTPw8I4Swmk+kesbCbTXJOdxet/CFcDL1VN5y56uCQKkyydqXHVdfovhTlnhSeyXT6l3oLlorY+LkOhG+3cvPSNnYRhH6FZaNbjxGA302vCMrm8DSOaxwSqMhD/6AX2vu0wLtXYSV7rON4qW6Jb6MD2PkTeJ7dDWTx6oSHk+3JzVGx3PlK7E7uX/EEVaqxG47xDJVwDpFdJGJ1t4ZxnuxkFEsuORRCTo6r8TGjjNN4hCfLPnkgpJCYoFtD3ogU7ZaDxgesny/cdJG+1sJhBE8oDxVuzgbwhplr4N2E6lYWBqnJZmyHC2cZhxuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(261022115727099003)(261022075727099003)(56012099006)(261102123227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtJfMlpr4640HOAd5PfmsywvorNWBK2xZghGjCl97x64nRrMqQTvZ1mcmnBV?=
 =?us-ascii?Q?AnzZl3jYzTda7svNQumZ4z1+3r78YxWtdGfMX2StMLblI5ECU8LsFRXLTiDx?=
 =?us-ascii?Q?O7O5TgX8L+aYbb+SBfAM/+S+PnsqjHw/SiZn8Cd9Z/ZGMdi+9w3sVCrf/vD6?=
 =?us-ascii?Q?vSJXe/idK104mvkPLY6hIV4kpcLt2Z1xpwA+kZSeNUivYGc5ieOQeEXAoTn2?=
 =?us-ascii?Q?GREW/RL4c3WdxTKU89hyvolQegV4JVlFVPdnmZntPFjv4XpouL86cU4jT70C?=
 =?us-ascii?Q?7lnKY9v8ao32DP4BMEDVWZKKO3CMeB37CfMvYiUvnx0Y8myNXttvQcsMgGbI?=
 =?us-ascii?Q?Ku4un/sUFmtx+S9TQLeJw17AYDGIKelL/8STDWlChv1q0MfVgaiwCg47lOlG?=
 =?us-ascii?Q?DkWbi50usX941xbHjV5m4gAZpMhiuPl9CMJGeNnssmH4xM9iM7quZPg2P6c2?=
 =?us-ascii?Q?x8b4iTdsUQk7mzK8roCNtPhfQXhmLeQsCYJlq0TLbM6jOn2+g70N6fhWYOH7?=
 =?us-ascii?Q?uBt3sxwH17QsDO97Ipj+j/umbbxP/55w1YtiANDQxslwtJUuKAHbww/Jutw1?=
 =?us-ascii?Q?3XNdGN6f3Xi9cabws3B+1vbDOJvE6BlHJOoBQJvowJDRtHpoXKV28ezWS2n9?=
 =?us-ascii?Q?T+AL069y8I8DlEo5fKtND4XBTJj/c0PdaSaqkGNq0dqZY8CY4bv5hiH0fJVI?=
 =?us-ascii?Q?udkrEGcLNxZkbEgFyNmzC41ctVW5klwRUrg697wcEGcw/MvlzFP4I7GC7bcG?=
 =?us-ascii?Q?oqJp6NrDhYj6WRTv7JObC9kMdqODDpj4T63Wziw1AEkywPlw/ZNB9/fG8OGn?=
 =?us-ascii?Q?+jxtbYZVQmiC1oY7ISK7haY2/TJbnhxs876M+5/t/a9mefOMKwIflO73563f?=
 =?us-ascii?Q?+rzsjztMUzHwU2h0pqeE49rTmisGm+QpCbe91V4doPeAbpoy5eTywxGVJHp3?=
 =?us-ascii?Q?Xcbiqtl+nt+i0cGeaUGRwFVu+n0ev+Wp7x7jf4EpWA8MtuCAt/OSX1S3NmjG?=
 =?us-ascii?Q?oEDLyYYUJlmBAb9aSxOxXNaO8CNp06vFUtaYdBdPZQNIrrjHRH74fXfFsVHh?=
 =?us-ascii?Q?BNfMLm11duM+Nwp+hj/ISbX/J6sH+92PGqOIdyHSgKTaeum/kz3ek2YvPhPQ?=
 =?us-ascii?Q?XA3npJlNMKrG1WtVwkx7RqbNL9Bz8oqHEVP4Lbg90IUIm51Ot2yBN7h8XRkm?=
 =?us-ascii?Q?z08D7Z5t0T0oLfimi25fTSB+QuNyVgO7h1PwDRSCvobxskc62FDGc0Z7XalZ?=
 =?us-ascii?Q?eiL0qprbrbhpT+eNE9voGO2K5BWBpzaANM7jTcT6KDTuYVhzY3onlzU1GJNs?=
 =?us-ascii?Q?ZrJHCtu8Cu4h8RoR9beg1QEEaENPJJ27blts/pHq18c+/yMFIRnUbIWbuKLD?=
 =?us-ascii?Q?Kt98a/58FFEixsJ9a/tXHsoNpCBHBQzkvE5yK3LFe4Ev4Cd2OxxLRF6s4YF/?=
 =?us-ascii?Q?KruNuqv2weJwg9onQGjSHgYkKTp6TwMDtf2TQ5HlPbb9o3G5eEW1t+tbUNVl?=
 =?us-ascii?Q?1Otu0CYoF0D8kxih7A/tLvlZEVi2oA14zYA1yMRnvxYHJdqvWPbA4O9/cAMw?=
 =?us-ascii?Q?C/CdQ/jKQbOBxx5DpeYyeSZX8w0Q7dWIQCQHXVOZJtS5QVHZ8xcxbFbaZpfG?=
 =?us-ascii?Q?x8EH+LyTNzQ3TzGIlrL4bBjjGCKfldrTdz5cPkCjNN22CRg+knPFD/H+itOK?=
 =?us-ascii?Q?8LlqjpJbowR1Vw38YHDAMer30vcla9J07CmJp934RiG3EtCGHD7JbL4FnAxd?=
 =?us-ascii?Q?dDnXRfYCmT0ZBzv+yqZNsel1IdxQTzc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e9fb5-befa-4da3-7aa7-08df4ba86e70
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:31:29.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWMU5B4R6KTZ1FtZsiSPz2U/+V3lD5qLzLfhYN6WbiF83AQGwmU7rfW++05GMGHRTVPweVnu3LFlPfPs7gBeEw5uNCa1TgCzEnrqDaMJAfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:31:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25099
Content-Type: text/plain; charset="utf-8"

Let the kas menu select kas/opt/dracut.yml. The dracut initramfs is only
used with the efibootguard-boot wic plugin and a verity root, which come
with SWUpdate, so the option depends on it. As dracut always uses a
verity root, the separate verity option is not offered with it.

Factory reset requires EFI variables with dracut, so it is not offered
without them. fTPM/StMM is supported: the initrd gets the TEE and fTPM
drivers, and tee-supplicant if it runs in userland. Encrypted data
partitions and, with kas/opt/encrypt-all.yml, an encrypted rootfs are
supported.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index df71aa36..a3b89e60 100644
--- a/Kconfig
+++ b/Kconfig
@@ -279,6 +279,25 @@ config KAS_INCLUDE_TESTING
 	string
 	default "kas/opt/test.yml" if IMAGE_TESTING
=20
+config IMAGE_DRACUT
+	bool "Use dracut to generate the initramfs"
+	depends on !DEBIAN_BUSTER && !DEBIAN_BULLSEYE && !DEBIAN_BOOKWORM
+	# IMAGE_SWUPDATE is only available with a kernel (not 4.4, 4.19 or
+	# NO_KERNEL), so these are excluded as well.
+	depends on IMAGE_SWUPDATE
+	help
+	  Generate the initramfs with dracut instead of initramfs-tools.
+	  The rootfs is always protected with dm-verity. Without secure
+	  boot the unified kernel image and its root hash are unsigned:
+	  verity then only selects the A/B rootfs and detects accidental
+	  corruption; it does not protect against tampering.
+	  Encrypted data partitions and, with kas/opt/encrypt-all.yml, an
+	  encrypted rootfs are supported.
+
+config KAS_INCLUDE_DRACUT
+	string
+	default "kas/opt/dracut.yml" if IMAGE_DRACUT
+
 if !KERNEL_4_4 && !KERNEL_4_19 && !NO_KERNEL
=20
 config IMAGE_SECURITY
@@ -341,10 +360,12 @@ config IMAGE_SECURE_BOOT
 config IMAGE_ROOTFS_CONTAINER_VERITY
 	bool "Protect the read-only rootfs with dm-verity"
 	depends on !IMAGE_SECURE_BOOT
+	depends on !IMAGE_DRACUT
 	help
 	  Wrap the read-only rootfs in a dm-verity container. Without secure
 	  boot, dm-verity detects corruption of the rootfs, but the root hash is
-	  not authenticated. Secure boot always enables dm-verity.
+	  not authenticated. Secure boot and the dracut initramfs always
+	  enable dm-verity.
=20
 config KAS_INCLUDE_ROOTFS_CONTAINER_VERITY
 	string
@@ -383,9 +404,11 @@ config SEPARATE_HOME_PARTITION
 config FACTORY_RESET
 	bool "Enable factory reset"
 	depends on IMAGE_SWUPDATE && (HAS_EFIVARS || !(IMAGE_FULL_ENCRYPTION || I=
MAGE_DATA_ENCRYPTION))
+	depends on HAS_EFIVARS || !IMAGE_DRACUT
 	help
 	  This adds the necessary packages to request and execute a factory
 	  reset of the persistent partition. See also ./doc/README.factory-reset.=
md.
+	  With the dracut initramfs, factory reset requires EFI variables.
=20
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
--=20
2.47.3

