Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15713.1794915001116929499
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:30:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=UWHFtE7n;
 spf=pass (domain: siemens.com, ip: 52.101.83.8, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crHGvX3NaFLRC4pXI1huOT6DJETww/Cglx+r70xJBB/WveSPWe3kF4bstuoChf7pvR+qfcep5Y6CPivGMVoZEp/iMFggzgarZrY8zy7xF1f3S9Kgd0Touq9vi/YSAPQDWgEdNp2orQA9FEUHf+ki+SyB0zMxsrIAmcNflLF6mjyqxlPQKvdhyLCABoBhiSEaBRQUYlhfd3vPldLA/qKeHZEdit/SLb21ngRI7KJLCVJxWuOA4FNglckhwLZFtbW0oKH6N3KaBcpvVRlCYoV8JF5AteDIsMKdBeP7O/7EzhSyurpEY0mqZ1PZiKmZufjNk1cqK/njrb9P5ZUs9+zwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6r7JZkmEZOuAj1YR8Fn5XuMSmWLqn3Dq5khLx/h7Ps=;
 b=Qx6RPLTzl7Bh/vQElmzxh1YG8Hiax2ixViFiQETQl9NFSRtHALxQXcI2ZPWI22aisbNc+Q4nRGKL/Cu8v0Fsg0p4kPs2cRoWcHahwc2VUGBg23iGNOqvXW60dEjFnfQCpfCOnYu09nD8KKviweZIbBDArM3/F7/rUGuLDzk4s0uXibaYDD0RGD6GFCcI1yQ66UmzEwoBVsHAZM/cZZ7hjpGfQ/xVwLMt5PylwXYiDcAhZE87vvIRJtKrjAcSsH75ZCwc/IUQQ9sq5NZbYhUHWi9MHytta7y56e4zJ1WvYfSeE2k6gsVolxoyyPP8pDA3WtkodH6unSvmoMRnx/Bo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6r7JZkmEZOuAj1YR8Fn5XuMSmWLqn3Dq5khLx/h7Ps=;
 b=UWHFtE7nhExkHt66eE8Ussv31eIwLLv73/q+W9kuCiZ76QT5yn8pGTNZKJO4MMRMla6pvDOaN8ry3gRC6yWy/hrNof+kpgo7n/3t5aSocqplQLs+AaNatcFRbtYtsNRCS0GBpXvKUM4QFOhq93qE5z2lj/quND8Nnvw5Vqk9bkGbk+YoPMbeZSZc2kcw6gQX8FyMzH1sD71xudis0vCHV0JiMxR4y70hj8N4I3Fp53Xgf/5Y2S4iKVwNM0MCXyrcl8TawV7RbI10xr1Bbwus8V/Z84dwUNaLwaoCexRyPz71c+FU8+lbhe7ZUui44ESKo5VA8WtzCQhp7R1Fmu2u9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS2PR10MB6615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 11:29:58 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:29:58 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 18/19] Kconfig: add option to generate initramfs with dracut
Date: Tue, 17 Nov 2026 12:28:32 +0100
Message-ID: <20261117112833.316234-19-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0396.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::10) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS2PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: aa664ab3-83d4-40df-c116-08df449e1b15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261026121527099003|261022115727099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: H5toFCdrwcdqQn7apDz0gNGefIBUx+7QbkK3qWwFgGMLAmxcwTeQdE6sf9vOTtedBR6x6fS1YT4J/YHJgOzLCODh9C5PKp4PC8E9245x4/VoayiYNiduopTJ3ANhSwFyrmr8cbZZ+RzaJazXUai5Uqnvs/ZLgZrXuHaITjwnL8N8rYBHJSe+4SmgNvPiL4vVeKwcjwIu5AagK15wDpO+PXki3+PsBxg3zSTYQ6BnoBMaI4QIwVRRdsTjgdCzsWJwQpf3n10W/kGeVdf5cMW837HdEaDwKvAUnqXtUyvYe4EG82EUqTv8Tps+5L1I1d93NfTDSqJsZ7tijDm0eCWG/KCvBSyPtpk2wr7cVK66WDvC6kMgj86CpXZQgWie0Oii06FTHfCBSrO7CVS6dQ5HQssRNOeEqjq8zeKcwafEyr5CbmsC4pDdwk/xuowKBqRgRAGg/fip7t7ba8MIt8OvkVS2HAyFT9kGCSa/WWSg4qRv8cgdRuYnOkKYjcfuQrXejZqLkWUeGNCrs7n9PgL7D3Od+RC7Bk6LxoZqFNG1uKZcGXdd6kTEE+97eza50GGC8I53BIKY61pEC/0+iKZPKFdlg2JaiGX+vfidHOyBgP1Gb2v5aOWFm+G7Wv+Xa6XEys+6u/4lCeI6R5o59suWLEFW0NdJeKAUnoKKQlcV4WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261026121527099003)(261022115727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdJ+myvcL8E01hllzzoBv95zgEs/F64HFLAVb9rG51/uXKLMVYdvXbRVHfge?=
 =?us-ascii?Q?zs34jp2w5ODwVo9ED6VxdBdCoCr7mjvahQKxN7pMopyhDfzvmCP0FQ1LI60k?=
 =?us-ascii?Q?lg7j995nq3GWoq70bAcO0ZDvnoVbxyyPRu3xU6gh2te2eQs3+cAYDl2Z1Fxi?=
 =?us-ascii?Q?eZetQbBc3g6pVBQ4wTLDbE2hFfnqBzQGf4NGy+Tyvzdt+oAZbMJWk/dgD0hE?=
 =?us-ascii?Q?HX1bHEXhQIDnc46a96hPzbRXjf7TjzY0tF4kH+rtUICJshRkDZKOj3a7It4+?=
 =?us-ascii?Q?8jJ9EXrXcM/Ut3xB6Qjko7rjRPrwmzC//PLHzVW6sF5S7q/BDjHQzdi0K/t9?=
 =?us-ascii?Q?BBEqxd/CFTzU/DUZ6f9ehZ882UPtPqGrY2reizL+33mzaMKEpgk7LTzfvjhv?=
 =?us-ascii?Q?LF7RXK6oKqVubBKaVMct/qguzGmtKVX1f2vQ5khscQPkjOvXiz0+LY9zGk8v?=
 =?us-ascii?Q?Spy0ZZM+4APB8DMXbIE0B6AMG0WlXQagQQxFDuRxIgk/mCrXUqsjpUPwfR6F?=
 =?us-ascii?Q?kQhB8LFEbohsfGFgM50yVV5q+IdSoI70w0o2EMX8oz/xsh5/4Jr/rbCqigZy?=
 =?us-ascii?Q?PjJtBiYNMyaggRohl61tYCfWoTEfqRUiqLEcIyiD5hyQj8Abm9EKX0VM4T2v?=
 =?us-ascii?Q?/yU5RJMg/7R/Cttwb+3l6eCHCnz2zYncVY/LpI+KovIkxXz4vHA7BR+vk2ns?=
 =?us-ascii?Q?uOrl0CW7XEkmwivMfq0261PVSkyjpM6g4E5cSPjGkFpovD8MJDCOcgzjYXg9?=
 =?us-ascii?Q?nt06wEANvRcmB3ZtoysP/V4Ohinr6GK0U6qhO0iDfXIHBFOtNcUfJbP7R1ho?=
 =?us-ascii?Q?zj9th1GjYBDIw6r1bQ2VqyeeTpk3aJh0Zd4nIlllXti29kuxmUuOjqLf5ElL?=
 =?us-ascii?Q?6zz2mg1obnEbbSlvYp7CJw3E4HqXJGBUlxeJ85E0h3R/mZ94yhpnSBFyk3VC?=
 =?us-ascii?Q?k8HrSvBfI2oQgVHE9l2ojhZfj2tOr9xVirLTSprikK92jbRfq5ZUIrAYy4Tm?=
 =?us-ascii?Q?FgPQ9UMOJQGWqt4rNUnZWTdbGvAxZKaqSDZVvPGuMAGmpj98sdkjrSjMzhgd?=
 =?us-ascii?Q?Wvi8sY2URAownM4MrrdxYUKD78rsrd1xykDl2aW9YgLEk2PbyMg2jJj8THj5?=
 =?us-ascii?Q?kOsfW1Sqd2t0SX8WX/uwXd6YV595h0/zDEI5sa/i5vxOeCbr949ihkUv2CEf?=
 =?us-ascii?Q?oKXFuUd45cIgioEN3sOM8JrHhh4QvO26WckPfGJkv6DGmMVOrrLdjiluTW7o?=
 =?us-ascii?Q?9ATiJjrKbCP/pnW1c50PFgJKAg5Tep0g5KYxoDdT4GpSN5cQKrHGif0wCy6w?=
 =?us-ascii?Q?jVzsiKPXUhOg6BH0mpJWe3VhGIeTm/O+bBjf0cDHevrulNsun2BwQYp9lA6a?=
 =?us-ascii?Q?KXtpmNjsr+xVSgs6EGjH3BVRYxg8VZQ3KANhBrbW5M+s67bsSiqNI7lFMVg/?=
 =?us-ascii?Q?mhHWrFYeOhfNWFPbFglp8qxSgLhQDq5YhBmr4ab4y6xRCZl1+fTW9i0M7C+e?=
 =?us-ascii?Q?DVuIqBUOJFbLIzjaY9PhWSjBxWBFs4DAW0pQnVOp/44bxRZ4UXHyscSxFgb4?=
 =?us-ascii?Q?eyaf6Ewz2QI8W2TCt0Yk0LoTi0BZz1YVYXXEtBMfu1cj63i7kkbHUsmJmSIx?=
 =?us-ascii?Q?1FsTfcKcUI9J1bYlVK8cwl38fZ9rk9M4/KkV0+JxPBWvDTXImDRDJec2P5nL?=
 =?us-ascii?Q?/MIqXeBHQmjcBF9p6fG4tZFVf6Wo81h0exOLsHBP6uIgiFG4WfTPgidNmUnK?=
 =?us-ascii?Q?RCZDoOX+3vgCNz42kNzdqDgOEKlhDDE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa664ab3-83d4-40df-c116-08df449e1b15
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:29:56.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/Trhfpw32xfpkF2Pn0wmXsOUbAqWZVdJB407c+Z15bcvUD0iEcU+wkuQe0b+FC+Vo17zBJnmayMQ5MzbYJbBO98a2WHPMQFFq3skkTCSbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:30:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24839
Content-Type: text/plain; charset="utf-8"

Let the kas menu select kas/opt/dracut.yml. The dracut initramfs is only
used with the efibootguard-boot wic plugin and a verity root, which come
with SWUpdate, so the option depends on it. As dracut always uses a
verity root, the separate verity option is not offered with it.

Encrypting the rootfs is not offered with dracut either: the
embedded-verity udev rule only matches unencrypted filesystem
partitions, so the verity data in an opened LUKS container is never
found, and the encryption of the active rootfs partitions on the first
boot would have to happen after they are already in use as the verity
root. Encrypted data partitions (/var, /home) are not affected.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                 | 22 +++++++++++++++++++++-
 kas/opt/encrypt-all.yml |  4 ++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index 929373d9..18ac94aa 100644
--- a/Kconfig
+++ b/Kconfig
@@ -279,6 +279,24 @@ config KAS_INCLUDE_TESTING
 	string
 	default "kas/opt/test.yml" if IMAGE_TESTING
=20
+config IMAGE_DRACUT
+	bool "Use dracut to generate the initramfs"
+	depends on !DEBIAN_BUSTER && !DEBIAN_BULLSEYE && !DEBIAN_BOOKWORM
+	depends on IMAGE_SWUPDATE
+	help
+	  Generate the initramfs with dracut instead of initramfs-tools.
+	  The rootfs is always protected with dm-verity. Without secure
+	  boot the unified kernel image and its root hash are unsigned:
+	  verity then only selects the A/B rootfs and detects accidental
+	  corruption, it does not protect against tampering.
+	  Encrypted data partitions and, with kas/opt/encrypt-all.yml, an
+	  encrypted rootfs are supported.
+	  See also ./doc/README.dracut.md.
+
+config KAS_INCLUDE_DRACUT
+	string
+	default "kas/opt/dracut.yml" if IMAGE_DRACUT
+
 if !KERNEL_4_4 && !KERNEL_4_19 && !NO_KERNEL
=20
 config IMAGE_SECURITY
@@ -341,10 +359,12 @@ config IMAGE_SECURE_BOOT
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
diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
index 8ad40eeb..a9290685 100644
--- a/kas/opt/encrypt-all.yml
+++ b/kas/opt/encrypt-all.yml
@@ -17,7 +17,7 @@ local_conf_header:
   encrypted_root: |
     # Do not set mount points for systema and systemb as they are mounted =
by the
     # abrootfs/verity initramfs
-    # As we use a weak default assignment in the intramfs-crypt-hook recip=
e we need
-    # to set all partitions
+    # As we use a weak default assignment in the initramfs-crypt-hook and
+    # dracut-config-cip-crypt recipes we need to set all partitions
     CRYPT_PARTITIONS =3D "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PA=
RT_UUID_B}::reencrypt \
                          var:/var:reencrypt"
--=20
2.47.3

