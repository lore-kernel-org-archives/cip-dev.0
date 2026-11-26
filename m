Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11290.1795689093383602819
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:31:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YD9mGRAs;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB3rAaB2PqmK1eO0jIUEeBncmjCoCYNs99Kg7DPW7w0+R5OxTEqAV5+zNSjd+rpvdOFlGiPRSpV2dEz4h8IT92aSddM/rV4G4+njcQmYex1t8bmk477IgFmpUjCrYnwtoXd6fHME5yfl6jvnN2lHKy27hjBMpHeX03NIA3iYqVG1qCzs84ixbw4GGuoJfTxUmgGA9ypPpWftw3/x814557k3YekYGTmDgafkYGvddC4q0t+zRLZUMGXjxMk+8/5wPZfbdXYxPplNUnZU55Av6LORSp7AG8CXWuoN7ONPwaNvq6lEUsXaEWhY/+0S+PqWZ1ndy2LYDuJL/BZekOEtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCzPKNjXdkZWIdjDK9dPx3dR/3euxG+qjhr+wqUwUwA=;
 b=uj74qNGOqDH1CZb5L9VP4WT9lizNH0JuPki04b1yqDEf88TgMOL+6ETuYx4DTleSfjyjVKnyJLTMV8zftZXglUzzaXHUR/GaFtfv4+WF8NztFJ4MKO+mZnHiJAMocSgYOWQVeDIxuDK9fnSlSfbK1mugw3VTeidy4LDqCa2+vNea3dCekHpIDCSty5DuCC2akj3GcgYP8p1gT7nK6a+ZQI5ogsU0kb/bRfes8iRRp/BtPf6cX2RxU61rfhSTF1JyifmbmJnMlR6yMxedd6p7Z83hd+BiQ0sPIa+0HSrvcd0+gpe9ok4xPOhwySSMSi+jht8xD/qksUZKsZBEZYZ1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCzPKNjXdkZWIdjDK9dPx3dR/3euxG+qjhr+wqUwUwA=;
 b=YD9mGRAsg+GOEBiclyRkwaf+4PBgcsQFmUJgoNnJQzW8tOr3sotn/qDxKdQDZKrocyVBMrBuzcQM2x7TSut4BiXSfrr9KeVB8oHcDCwy0CcppktTIcxNwausHy9bbXXREYZjT+tbkqAIaGK2JLHl1/hHxE5ftxV9XmLouwf5qDzKLZBpPWLza7cgS7G33Tfo8E/lzO3ZsUmH50JrXRHxOERiFaREIlMq4wPv/KxBFOztuElrjJMCLNKqUkgwaisNgRyZrdbSvkt1za9DdCiaEbALtXAtBvjG8Yg7yYtKNcIpuc4gJaELhSxunobd4Be3s5UoNre358dp0fnROph8zg==
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
Subject: [isar-cip-core][PATCH v4 18/21] doc: document dracut initramfs
Date: Thu, 26 Nov 2026 11:30:04 +0100
Message-ID: <20261126103007.2922985-19-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78b2b74f-9785-4fa6-1888-08df4ba86eb6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|55112099003|3023799007|11063799006|261022115727099003|261022075727099003|261022113327099003|5023799004|56012099006|261102123227099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261009220027099003|261009223327099003|261021123027099003|261009221227099003|261009223027099003|261009221727099003|10067099003;
X-Microsoft-Antispam-Message-Info: EajJRE340dOWnZTKR5AXTnLoO080D30xdgDAioE2nvAAqYSssYiNY5kq+dmdTsBQzFwxSz2ijynUqOFBxIDPkUr2RPRDLnYEsZpOtqpwpjdIAz78kAQAw9/ZMW32f66W5nac43XG87pZYFn+9GXjylQ/8lv2DbRmJzbP74YzTloywGVlcgkExSwC/HZJpYDsRV591+MLzSPJeCAMNrvkOvp1OY4PXZJ1HdB2Vl6ta+4hDuHuLcrTthf0Pd3BTEWY3ztfNpxOJSIkIEsj5vs6RFyJXix/45WB77iulS01lDsV/wmNVbP6SWtTPglZI/xsuXtIum9uo0CT5mcW5sF3LsGvnzchtA2ZwyZT8UMD7IFtHpqgsmQKq/L/B4qt6jQfYpgdQGu8qJiv3OsNF47dKo36uEJvFoeuexNDR+qCHSwVBwbieZreJxEdTZB2ztXQxo0b5DR0iQwRvSHo5Bii0jUI3sHEmKZUF91tVHAcMdV+d7j3PKJAh/g2Z15gnFMLAzLzDITwInlqzkZJdQFnA9zMaUkU4tt0D8KNuA8tLVGvhsH49m/QEBCEBBy5H/6P6zK7Cxo2Cz+wDwxKd82UNKJ6eLHGJocKF2YEN55TzEn7RQL/8ihs1aJ5xPCP9GdEMhFSQjuo9uOkHTsFlZwyRQ3bVJ2AMWf6n/rUITK6awg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(3023799007)(11063799006)(261022115727099003)(261022075727099003)(261022113327099003)(5023799004)(56012099006)(261102123227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261009220027099003)(261009223327099003)(261021123027099003)(261009221227099003)(261009223027099003)(261009221727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opaQt8ufyvyASky0fAcbFzl44RP2DEoyoST4e03DKF/aFgfvw+7n2VJjkSrA?=
 =?us-ascii?Q?9/78R8hVuFKmrCU2rBdkBo2jy9mDQZ+MZItDG08ND7rQoISu4mxEKgq40ZQE?=
 =?us-ascii?Q?elM4HA4AezTujUVH3nVc7b05n3SJwRNJugzBGldyPzKUPozkrSvt9j1tPtC6?=
 =?us-ascii?Q?4FwnCX68kzeU/LOGvvvkHQHCPKGuVpZqHGmyTyUrCqtjHYiNSZ/DdtYEZP59?=
 =?us-ascii?Q?CBfazjcXIWIV+mVPyijMtLSDQHrD7240geQ3cnTcOyI0lFp6NO14MrQEUs0f?=
 =?us-ascii?Q?EeckJOEGhq27pCMVVVXb+DBIx8dWVuk6bzvILSIMqc7CZulho7C592Gwac9o?=
 =?us-ascii?Q?tg7tlGxSSfzJoEYmidfKh0n98HQE4q+o0pss5VujE6XOoIdl4GN/1JK61i3u?=
 =?us-ascii?Q?YHUHYlkQi0MheIt+ZDC80kldJykdK+Fatda4GsQUoNqdvqMFZaSMNRI9y4/T?=
 =?us-ascii?Q?WRBAHKdnyuvlr39D3mYESrQ+0yyBsK3bgJWOU8KSh9sSRTPdTa5Vx4/z5rRl?=
 =?us-ascii?Q?l2Zlc7vipPmLNcjeOSqBkJrN79E72LADgX12q0e9lD3mqolpNKTKZtnFHW/Q?=
 =?us-ascii?Q?BpRwedd2FSpz8gFIXYkQEA6JmINT1byLrFNoK89C03BAeTLpQMtk6MCVA7qJ?=
 =?us-ascii?Q?IIJZH2AKBYnhG1fK0gNmggT8rkVnnjXyHhLTQbAtIgQuzij752CjcnJ7BTCI?=
 =?us-ascii?Q?zuqyW5a0s8sDNjylZjOSYQmWgQzFecDxELMHPHQrAfH/mPTIScADQbdv0u1L?=
 =?us-ascii?Q?4/6K2CudsLUEtroGZZgp3I4YGMKILA4YRapVyaxnJW4LObr4Be3zR0rPqrDI?=
 =?us-ascii?Q?e9FRs5N47u3qKHEMo1PRwuXFoifvJXzan8XQgRclJq3k5keK/RCfnZFqTooc?=
 =?us-ascii?Q?GbT7Io58niNS2Sh9wGiAW6j58hZPuhlVJJyS2xOvje08J4+CERTVtkna/K36?=
 =?us-ascii?Q?fxZ4hUPyL9sm69jIrsL5j68Ev6of1ZQp5Q6ntENdFO2dx6DL9VXknd6lV46B?=
 =?us-ascii?Q?YiH0v1ZDsl2AGbMfByoEj4m0+H2YMEJk/H11ZHReZrUQm0pAF9223yWBO9Bc?=
 =?us-ascii?Q?zaEHM7TAySwKt4QhrRPhczxmdwbWtBcXcfoITCAAbk1dYhcux13WPM5iz48/?=
 =?us-ascii?Q?F2aV2W+fSMaVNVJqkXfvZHZhjHiYwlA2tvHMeGaz8JGUvckV24WqdYXM0h7x?=
 =?us-ascii?Q?vGVKk8meDcM/Bf9qRTLtCgzNbtzusQRCPCdUXwDfX/hiMow02j1fcQUWEOWn?=
 =?us-ascii?Q?FrGYXSomyLZG8QihgwWgle8tMUK7wsRn/RV15yltewSgdqDTKOn/n+eTCA4i?=
 =?us-ascii?Q?tLjHIspv0bAdQhLX1jbeW2SW69pMsmEZlx6ougl9CZyH8vBCfNPJjR4lNu2o?=
 =?us-ascii?Q?53v5MOu13+SFedEPv6UnA0COPiC1g6aHTqJhfoKes79iuuuXkbYW0htuBxpY?=
 =?us-ascii?Q?MTHdArpgbtvvFuPb9/8FuKKrah+sRYbQiZjSP62NhJfQaB2iyShdF/TA/jZu?=
 =?us-ascii?Q?FpXo6Dd41ktEDZVvDj8hOyVvcdKESMHzHFaYj4TUzFAz4veP8Z1DV4wvd8W9?=
 =?us-ascii?Q?afQSyej/T+tE1D1u6J2NANNGQDBCZRn1P6A2DdN4SjmhvArxWftGo1vPGK2T?=
 =?us-ascii?Q?MKwR2Zuynh/blMKRMsZcI2/UWinKOKOHpt3ILdxXpwWRginJd4OlkCTqLswO?=
 =?us-ascii?Q?DHHRl1tPQey/T7PbmKbzuh/+KtR/HtwBYln8N1aElurSAUHjzHRlALLTux8R?=
 =?us-ascii?Q?0RyvXai1KlQNcsKQPGkqn+hPbRI2xOI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b2b74f-9785-4fa6-1888-08df4ba86eb6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:31:29.4999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCqu+0T8GHDye0G+sA6CsnOGemHBOiJPy9sqZ3Dhw61HmnK1iSPTtJrXu95XT3ytveiaLeXJe1ipnvVee/ZKjzF94Qb9V/lBFRxWJp+qvls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25100
Content-Type: text/plain; charset="utf-8"

Describe the dracut initramfs, its modules and configuration packages,
and the dracut-specific behaviour of factory reset and secure boot.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig                     |   1 +
 doc/README.dracut.md        | 161 ++++++++++++++++++++++++++++++++++++
 doc/README.factory-reset.md |  59 +++++++++++++
 doc/README.secureboot.md    |   7 ++
 4 files changed, 228 insertions(+)
 create mode 100644 doc/README.dracut.md

diff --git a/Kconfig b/Kconfig
index a3b89e60..96f10060 100644
--- a/Kconfig
+++ b/Kconfig
@@ -293,6 +293,7 @@ config IMAGE_DRACUT
 	  corruption; it does not protect against tampering.
 	  Encrypted data partitions and, with kas/opt/encrypt-all.yml, an
 	  encrypted rootfs are supported.
+	  See also ./doc/README.dracut.md.
=20
 config KAS_INCLUDE_DRACUT
 	string
diff --git a/doc/README.dracut.md b/doc/README.dracut.md
new file mode 100644
index 00000000..c1f87d73
--- /dev/null
+++ b/doc/README.dracut.md
@@ -0,0 +1,161 @@
+# dracut-generated initramfs
+
+isar-cip-core can generate the initramfs with dracut instead of initramfs-=
tools.
+This prepares for Debian 14 (forky), which switches the initramfs generato=
r from
+initramfs-tools to dracut. It is supported on trixie and later (including =
sid
+and forky). `cip-core-initramfs-dracut` is skipped on buster, bullseye and
+bookworm, whose dracut lacks the features the modules need.
+
+## Overview
+
+How the pieces fit together:
+
+1. **Selection.** `kas/opt/dracut.yml` (or the kas menu option) sets
+   `INITRAMFS_RECIPE =3D "cip-core-initramfs-dracut"`, adds the `dracut`
+   override and includes `kas/opt/ebg-swu.yml`.
+2. **Distro defaults with `:dracut`.** `ROOTFS_CONTAINER_TYPE =3D "verity"=
`,
+   `INITRD_CMDLINE_STYLE =3D "systemd"`,
+   `factory-reset-helper-efi` as the factory reset provider, and no `/var`
+   entry in fstab (`FSTAB_VAR_ENTRY`).
+3. **Checks.** `read-only-rootfs.bbclass` fails the build for dracut witho=
ut
+   a verity rootfs. It does not install `home.mount` when `CRYPT_PARTITION=
S`
+   has an encrypted `/home` entry. In that case, `embedded-crypt` mounts
+   `/home`.
+4. **Initramfs.** `cip-core-initramfs-dracut` installs the
+   `dracut-config-cip-*` packages, which write the BitBake configuration t=
o
+   `/etc/dracut-embedded/`.
+5. **Kernel command line.** The `efibootguard-boot` wic plugin chooses the
+   verity root from `ROOTFS_CONTAINER_TYPE`. Because of
+   `INITRD_CMDLINE_STYLE =3D "systemd"`, it emits systemd's native verity
+   arguments instead of `cip.verity_root_options=3D`: `roothash=3D`,
+   `systemd.verity_root_options=3D`, `systemd.verity_root_data=3D` and
+   `systemd.verity_root_hash=3D` (both pointing at
+   `/dev/${DRACUT_VERITY_DEVICE_LINK}`), plus `root=3D/dev/mapper/root`,
+   `rootfstype=3D` and `ro`. It also adds `INITRD_EMERGENCY_CMDLINE`, whic=
h makes the initrd
+   reboot instead of starting an emergency shell.
+6. **Boot.** `embedded-verity` publishes the partition whose verity UUID
+   matches as `/dev/${DRACUT_VERITY_DEVICE_LINK}`. systemd opens it as
+   `/dev/mapper/root`. `embedded-crypt`, `embedded-overlay`,
+   `embedded-factory-reset` and `embedded-watchdog` then handle encryption=
,
+   the writable overlay, factory reset and the watchdog.
+
+## Build
+
+Add `kas/opt/dracut.yml` to the kas chain, for example:
+
+```bash
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/securit=
y.yml:kas/opt/dracut.yml
+```
+
+Without kas, set both lines (`INITRAMFS_RECIPE =3D "cip-core-initramfs-dra=
cut"`
+and `OVERRIDES .=3D ":dracut"`) globally in `local.conf`; the recipe alone=
 does
+not change the distro settings.
+
+## What is in the initrd
+
+The dracut modules are maintained in a separate repository,
+[embedded-dracut-modules](https://gitlab.com/cip-playground/embedded-dracu=
t-modules),
+and built by the `embedded-dracut-modules` recipe. Their configuration is =
shipped
+separately by `dracut-config-cip-*` packages built in this layer.
+
+| dracut module | Module package | Configuration package | Replaces |
+|---|---|---|---|
+| `embedded-verity` | `dracut-embedded-verity` | `dracut-config-cip-verity=
-<MACHINE>` | `initramfs-verity-hook` |
+| `embedded-overlay` | `dracut-embedded-overlay` | `dracut-config-cip-over=
lay` | `initramfs-overlay-hook` |
+| `embedded-crypt` | `dracut-embedded-crypt` | `dracut-config-cip-crypt-<M=
ACHINE>` | `initramfs-crypt-hook` (systemd backend only) |
+| `embedded-factory-reset` | `dracut-embedded-factory-reset` | `dracut-con=
fig-cip-factory-reset-<MACHINE>` | `initramfs-factory-reset-hook` (EFI vari=
able only) |
+| `embedded-watchdog` | `dracut-embedded-watchdog` | `dracut-config-cip-wa=
tchdog-<MACHINE>` | watchdog handling of the crypt and factory-reset hooks =
|
+| `embedded-sbcerts` | `dracut-embedded-sbcerts` | none (defaults match) |=
 `initramfs-sbcerts-hook` |
+
+`cip-core-initramfs-dracut` installs only the configuration packages. Each
+pulls in its module package, and `DRACUT_EXTRA_MODULES` enables the module=
s.
+Overlay, watchdog and verity are always installed. The watchdog is only
+serviced if `INITRAMFS_WATCHDOG_DEVICE` is set. Crypt is installed with th=
e
+`encrypt-partitions` override and factory-reset with the `factory-reset`
+override (`kas/opt/factory-reset.yml`).
+With the `secureboot` override, `embedded-sbcerts` and `secure-boot-efi-ce=
rts`
+are also installed. `embedded-sbcerts` enrolls the certificates on first b=
oot
+(see [README.secureboot.md](README.secureboot.md)). It needs no configurat=
ion
+package, because its default certificate directory is the one
+`secure-boot-efi-certs` installs to.
+
+Module notes:
+
+- `embedded-verity` does not open the verity device itself. Its udev rule
+  runs `embedded-verity-match` against every file system partition.
+- `embedded-overlay` is a `pre-pivot` hook that mounts the persistent stor=
age
+  device under the real root and stacks a writable overlay over each path =
in
+  `INITRAMFS_OVERLAY_PATHS`.
+
+## Configuration
+
+The configuration variables (`INITRAMFS_OVERLAY_*`, `CRYPT_*`,
+`INITRAMFS_FACTORY_RESET_*`, `DRACUT_VERITY_DEVICE_TIMEOUT`, ...) are unch=
anged.
+The `dracut-config-cip-*` packages write them to `/etc/dracut-embedded/`, =
where they
+override the module defaults. `dracut-config-cip-crypt` also generates a
+crypttab from `CRYPT_PARTITIONS`, ships it as `/usr/share/dracut-embedded/=
crypttab`
+and installs it to `/etc/crypttab` in its postinst.
+UUIDs in `CRYPT_PARTITIONS` must be lowercase; otherwise, the build fails.
+This differs from `initramfs-crypt-hook`, which also accepts uppercase UUI=
Ds.
+The generated crypttab binds the TPM2 policy to PCR 7, matching the
+enrollment done by `embedded-crypt`.
+
+`INITRAMFS_OVERLAY_RECOVERY_SCRIPT` is optional; if empty, the module's
+default recovery script is used.
+
+The initramfs is built with `--no-hostonly`, which `embedded-crypt` requir=
es.
+
+## Encrypted partitions and `:expand`
+
+`embedded-crypt` provisions TPM2-sealed LUKS2 partitions on first boot and=
 leaves
+unlocking to systemd's native `systemd-cryptsetup-generator` (build-time
+`/etc/crypttab`). With `kas/opt/expand-on-first-boot.yml`, the last
+`CRYPT_PARTITIONS` entry gets `:expand`: on every boot the pre-mount hook
+grows that partition with `growpart`, and after mounting, `systemd-growfs`
+grows the LUKS2 payload and the file system. This is a no-op if the disk i=
s
+already fully used. Only the last partition on the disk is grown. If the
+entry is not last, the module logs a warning and boots normally.
+
+## Encrypted rootfs
+
+An entry with the mountpoint `/` in `CRYPT_PARTITIONS` marks an encrypted =
rootfs
+partition, for example `kas/opt/encrypt-all.yml` sets
+`${ABROOTFS_PART_UUID_A}:/:reencrypt ${ABROOTFS_PART_UUID_B}:/:reencrypt`.
+`embedded-crypt` encrypts and enrolls these entries in a separate service
+before the verity root is opened and does not mount them. They must not be
+`noencrypt` and must not use `:expand`; `embedded-crypt` fails the initram=
fs
+build otherwise. An entry with an empty mountpoint (`<uuid>::reencrypt`) i=
s
+not a rootfs but a data partition that is encrypted and not mounted.
+With a rootfs entry, `DRACUT_VERITY_REQUIRE_CRYPT` defaults to `"1"`, so
+verity does not open a rootfs that was not unlocked.
+`DRACUT_VERITY_DEVICE_TIMEOUT` defaults to `CRYPT_SETUP_TIMEOUT` + 60 s, s=
o
+that verity does not time out while the rootfs is still being unlocked. If=
 you
+set it explicitly, keep at least `CRYPT_SETUP_TIMEOUT` + 30 s plus time fo=
r
+udev device discovery.
+
+## Constraints
+
+- **Verity is required.** A/B slot selection is done by roothash matching;
+  there is no dracut port of `initramfs-abrootfs-hook` and there will not =
be
+  one. The `efibootguard-boot` wic plugin selects the verity root from
+  `ROOTFS_CONTAINER_TYPE`; the file system inside is selected by
+  `RO_ROOTFS_TYPE` (`squashfs` or `erofs`). Without secure boot the unifie=
d kernel image is
+  unsigned: verity only selects the slot and detects accidental corruption=
;
+  it does not protect against tampering. The build warns when verity is us=
ed
+  without secure boot.
+- **Container type precedence.** With dracut, `ROOTFS_CONTAINER_TYPE:dracu=
t` takes precedence over a plain
+  `ROOTFS_CONTAINER_TYPE =3D ""`, so such a setting is ignored; only an
+  explicit `ROOTFS_CONTAINER_TYPE:dracut =3D ""` fails the build.
+- **fTPM/StMM.** There is no dracut port of `initramfs-tee-ftpm-hook`. The
+  initrd only gets the TEE and fTPM kernel drivers and systemd waits for t=
he
+  TPM. With `TEE_SUPPLICANT_IN_USERLAND =3D "0"` (the default of this laye=
r,
+  kernel 6.12 or later) nothing more is needed. With `"1"` the
+  `dracut-tee-supplicant` module starts `tee-supplicant` in the initrd.
+  The `tee-supplicant` path has not been tested on hardware. The
+  `tee-supplicant` in the initrd has no persistent REE-FS storage (tmpfs);
+  use RPMB-backed storage for the fTPM.
+- **UKI systems only.** The non-unified-kernel efibootguard path
+  (`unified-kernel=3Dn`) is not supported and not tested against dracut.
+- **One generator per image.** Isar's `initramfs.bbclass` rejects an image=
 that
+  mixes generators (with dracut selected, any package whose name contains
+  `initramfs` is an error), so there is no hybrid migration step.
diff --git a/doc/README.factory-reset.md b/doc/README.factory-reset.md
index 4b1a1ab9..be09389e 100644
--- a/doc/README.factory-reset.md
+++ b/doc/README.factory-reset.md
@@ -5,6 +5,7 @@ To enable the factory-reset functionality the following two=
 elements need to be
 ```
 INITRAMFS_INSTALL +=3D "initramfs-factory-reset-hook"
 ```
+  With dracut, see [dracut](#dracut).
 - factory-reset-helper which provides the helper scripts to set the factor=
y-reset marker
 ```
 IMAGE_INSTALL +=3D "factory-reset-helper"
@@ -28,6 +29,64 @@ As the factory-reset is executed before the disks are un=
locked in the initramfs,
 variable `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE`. The factory-reset of =
encrypted partition is not supported with the file based
 marker.
=20
+## dracut
+
+With `kas/opt/dracut.yml`, `dracut-embedded-factory-reset` replaces
+`initramfs-factory-reset-hook` and is installed automatically with
+`kas/opt/factory-reset.yml`.
+
+### Behavior
+
+- **Trigger:** only systemd's EFI variable
+  `FactoryReset-8cf2644b-4b0b-428f-9387-6d876050dc67`. With dracut,
+  `set-factory-reset.sh` writes this variable. EFI variables are required.=
 A
+  build with `factory-reset-helper-file` fails.
+- **Flow:** a systemd generator pulls in `factory-reset.target` only if
+  the variable exists. The variable is deleted before anything is wiped. A
+  failing or timed-out reset (`INITRAMFS_FACTORY_RESET_TIMEOUT`) reboots
+  (`FailureAction=3Dreboot-force`) into a normal boot.
+- **Plain partitions:** zeroed, `wipefs`, and re-created with the previous
+  file system type and label.
+- **Encrypted partitions** (`encrypt-partitions`):
+  1. The LUKS keyslots are erased (`cryptsetup erase`). The unlocked mappi=
ng
+     keeps working because the kernel holds the volume key.
+  2. The mapping is zeroed, so an interrupted reset cannot leave a partiti=
on
+     that still unlocks with partly old data.
+  3. The mapping is closed and the LUKS signature is removed (`wipefs`).
+  4. On trixie, the TPM is cleared (`tpm2_clear`; disable with
+     `INITRAMFS_FACTORY_RESET_CLEAR_TPM =3D "0"`).
+  5. `dracut-embedded-crypt` creates a new LUKS2 container with a new volu=
me
+     key and TPM2 token, and a new file system.
+- **File system type:** encrypted partitions get their file system from
+  `dracut-embedded-crypt` (`CRYPT_CREATE_FILE_SYSTEM_CMD`).
+  `INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE` is only the fallback type for
+  unencrypted devices without a detectable file system.
+- **Watchdog:** if `INITRAMFS_WATCHDOG_DEVICE` is set, the module configur=
es
+  systemd's hardware watchdog (`WatchdogDevice=3D`/`RuntimeWatchdogSec=3D`=
) for
+  the initrd on every boot, not only during a reset.
+
+### Caveats
+
+- **All TPM2-sealed partitions:** clearing the TPM makes every TPM2-sealed
+  partition impossible to unlock, including `CRYPT_PARTITIONS` entries not=
 listed in
+  `INITRAMFS_FACTORY_RESET_DEVICES`. List all of them.
+- **Switching from initramfs-tools:** the dracut module only reads systemd=
's
+  `FactoryReset` variable. A request written by the initramfs-tools helper
+  (`FactoryResetRequest`) that is still pending when an update switches th=
e
+  image to dracut is ignored; request the reset again after the update.
+- **systemd's own variable:** the dracut path uses systemd's own
+  `FactoryReset` EFI variable (systemd vendor GUID) on purpose. Userspace
+  systemd components must not consume it.
+- **Unlock failed:** an encrypted partition that could not be unlocked is =
not
+  zeroed. Its LUKS keyslots are erased and the TPM is cleared, so the data=
 is
+  unrecoverable. `initramfs-factory-reset-hook` behaves the same way.
+- **Power loss:** a power loss during the reset (after the variable was
+  deleted) leaves partially wiped partitions. The next boot does not repea=
t
+  the reset, as the variable is already gone.
+- **Forky:** on forky, `INITRAMFS_FACTORY_RESET_CLEAR_TPM` is ignored and =
the
+  build shows a warning until TPM clearing moves to
+  `systemd-tpm2-clear.service`.
+
 ## Verification
=20
 - Create a test file in a target partition (ex: `/var`)
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 23e23c3f..4e494901 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -191,6 +191,10 @@ local_conf_header:
 Replace `demo` with the name of the user-generated certificates. The user-=
generated certificates
 need to stored in the folder `recipes-devtools/secure-boot-secrets/files`.
=20
+The example above builds the initramfs with initramfs-tools. The initrd ca=
n
+alternatively be generated with dracut, which replaces `initramfs-verity-h=
ook`
+by the dracut module `embedded-verity`, see [README.dracut.md](README.drac=
ut.md).
+
 Build the image with user-generated keys by executing the command:
=20
 ```bash
@@ -308,6 +312,9 @@ deployed to the Allowed Signature Database yet. This al=
so ensures that disk
 encryption on first boot will only take place when the machine was securel=
y
 booted so that the encryption key is sealed against this state in the TPM.
=20
+Images built with dracut (`kas/opt/dracut.yml`) use the `embedded-sbcerts`
+dracut module for the same purpose, with the same conditions.
+
 The certificates needed for this auto-enrollment are taken from a package =
that
 provides `secure-boot-efi-certs`. The `single-key-to-efi-certs` package is=
 the
 default provider of this in isar-cip-core.
--=20
2.47.3

