Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11290.1795689093383602819
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:31:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QQ60Nd4Z;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oujPMNfgPRhbwwgqkp+uPxoQlU5XeKKsM42goq7MxcO40+vXLO+mv0Up2RWKWFu/wqHd2zWNmuvtG1PBq6EKirxCUYt8WnAtDjcqE5/sRuGw4Mc1HuLMWaWwQONIxWVI6ynNvTSVejqhinyD8q8Us3VmmNx04WpkOvBPKzOLWty6+5recm5drOIxSr+peezujiy7HFhN6w+HfBsEtCPUHtaSMSxTD0kep+fHFuU2hs4Fpp0FFTyUCf5mka5EgnYfKCTaouW2PGjbwGFVnCMO7wlhlYIuCuhFW6yXFI1dX0pXvInBMR6J6kj+rlr6xZKN/JjB0DL79YwfGoDAtBxiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXVF0X9vZRZkzPECdeO7o6aHdJhTT2S2XqqGdXIbayU=;
 b=Pdc+SAl4wWJ2Nhy42KTpY2TsMptuzBvZlQjnGOFLoEBF2hmSTvDSTMrKCQ3spVVr6+PdetP2DOtTmnn5YxvVRvmhVYIcH0sHLM9XCNqMc41SSgfzAtBJZc8IGDAk75pzfw9orFVJvV0SoTs5K8w0eKdPavxqp8RysRoyafFwWHhKnp+GOacZWu0D0s2Wab6emLHdDIUHP34nIjX5Aack21C0uh64Yi6lneNlUX1SV7o7+jkby6CGRFrTtSewaowPiac6+sriMCSbwzAt/ZRE5kuzqbXYoFely7v2sEu03rTvbZ0OK450c81tPbDYncw64Gm+BxTV3aN3VccvgG7rHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXVF0X9vZRZkzPECdeO7o6aHdJhTT2S2XqqGdXIbayU=;
 b=QQ60Nd4ZrySaFq4vtskKQD/IqlDsw83CqUpxqSLy8RSnZ/J+6Sa65XoVEqg1vzHYaQoJ4yTKb0lJmuWzitAsVBuHQ1ZlJTbkT4QfiG7FLKZKJ2p2AkhCnLKDrxUMM01Ff8XJUZg+pi5encPCxwCLFbHfAUVU9DH6hEqCanX5JcvU3/vCyJR8rQCgJT+0wacMfsbCZ0r7TSCTkaOr+epJ/MYvukMSxZReVibqFF/Mi2MCxhxOF47dkSuWCrZa3c9bOW/bcarLuqIdGyggqG2mjnlKxay1J0iryMurE3qVieQN4EqrDQ9ipZzCQHOHkmy9pvls4zWIW5wKM9fYtEbZrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB9591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:61a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 10:31:30 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:31:30 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 19/21] wic: reboot on kernel panic with efibootguard
Date: Thu, 26 Nov 2026 11:30:05 +0100
Message-ID: <20261126103007.2922985-20-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92f1e8a4-aa35-4ce6-e815-08df4ba86efc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|55112099003|11063799006|56012099006|261102123227099003|261021135927099003|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: wlKFMJvmXht0vB50KHALyUlw2lTJ4KhubXN/WN//GCohCLYrWu9BxtQ9aBFuMeb0K6nn79Jlz8YhqSa/boe6i3Ju4T/wS+N0Y603aOJfSlXqAlfbAioRg6uoG103kqX9zKhpWzA1BPIkTPqSJAry9QwhwGD/YLDuWUY6WSfce0W3syM7ysz1YAsCqIcFdRRyuAZ/QFRzOYeim1rkD4ZTf0p5FqIHgPp4cBmcXwuScx+nr/TCC+hnKw89BTgnSFElXPK8/spk8smMDhGmmhcwX7ZATmuul6o3rPTAAQmMRGIKYkCIN8XeC3LhGxPkRXtX4akiCTDxma7oK2vyxMkPz80PDhydQnR9xL45Aoph1OL8SR274XWwKYc+4w6KYSk4pVpuike3tCZyPbp/M0tu0xB8FJ5ihq+b1NePh5KihVRSd8/gVXKWwjZZ3BPsKk7gb1UkhBIGBqrQjea66OW+Fg3ycDSQ5e9PBU6zFpnVGLes8Roba4EdMOKlHzS5ZkhIhPxIE+GbGFgICEgBFMZgmCKoIaZX4c73+nL3N6/K+WNtNzCyqSyA5/X4aOb65hDQ5zy7EVUwsdTMehC4LcYvIAFiMfzUzzpV5zs02DZxVnNlh6fJid0V0NdAi7ErJBsnRl3Okzl2GjWT8rpmaYSw+tu4H8clyyIS8FGOEi/wNa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(261102123227099003)(261021135927099003)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PK23UM1Up/G00UssNwE+/d9yi9PsaBzbZmVtE/yfT+cJYF42aOll21UM4gYf?=
 =?us-ascii?Q?h/eRxkf23TGD1hNFwTefh0UgAyV/UWiAd+CLs1mVlEN70OB+rAPB/jV+xcOr?=
 =?us-ascii?Q?xjW13BgrYiDLw4mO52+4you7JrCicOp7yUKq+ssTZANT2NdVz6mhtclN1Y/Q?=
 =?us-ascii?Q?y+y5ECOEEAuKrNNnQ7dsE7vg7DQFkUcDQcf5LhGhR65n1Uj9ov3MYZ4LYFdZ?=
 =?us-ascii?Q?U3dbwaSbd0eMNLUjqTbTJ2hm+HdUUYk/luSctvCYZzdbBebHsNtZmQ+yucwi?=
 =?us-ascii?Q?KAT+ZIDlzAccUefNBgXMGunzvQfUZciRSTN6seHVvGdSgWUxNg65qFwHuVmU?=
 =?us-ascii?Q?ZM3/OqF++KnlffOLu9CzdtJjIO1bIodCmh+nrUrv6JUK9KXk6T5B2Z3lxqqp?=
 =?us-ascii?Q?EO4ElEiFCmsTX3GeFqkrzxN+zqZwZgnROhQ7drZ7DJW81Kr10V66RUUZJ4n/?=
 =?us-ascii?Q?IHvA6t2VPPszOiDvvouDPNOBhJ5y0MkGIWfsb26gENDI5Xh2wy3t1XH24Y4c?=
 =?us-ascii?Q?EN6qRZELtCAgBC0HSC4o7T2OCiMlzu3ussr1lKRSpwLh5gmbo9/1fjvppVCn?=
 =?us-ascii?Q?yUbdBJT9FzqhaGrfKw9v9lQD23qZelMTgI7pPFcWeuO3WZ5Q4cM/qZFTgQEx?=
 =?us-ascii?Q?6cf4owOKE4ETVAXljAoQcaxLlNyHJJwKl5w6IEI86VXToCDHlAQlXMqWG8vW?=
 =?us-ascii?Q?Szf2r4rR4ys4tgFfeRM50VbBmqlJRv+2IBrDQ2ATtQHa0TP+CFP93cTgFBlW?=
 =?us-ascii?Q?uNEn+yazLAYVlwoY9Jhw1qg49vBGw/z6V2++Kroxr35D9Rz37CABEcpJvISS?=
 =?us-ascii?Q?t1Y4grAAjAAO+TXcmi3dEXXgfsbiqUml+Bwr9hojkzmSAgBgjbgNYotA4uhQ?=
 =?us-ascii?Q?M+keM/u9HEgyVRgTc3MW+ZCDjdyoem3oRfCAC0ZN3dieaAkyFoDgp7IwegTb?=
 =?us-ascii?Q?qP+bg5ujxvN4BlzbLkLzoq++drrTBzJr0cjf4Bta36VBz+7usr0bQtHGx86D?=
 =?us-ascii?Q?nF0qamiUs72c7flJ81Y5l6K5vWVSFqwDwXxvlptW4cmLyZI1KfWRK0BmKxo/?=
 =?us-ascii?Q?EtOdCqewmCcaCdbQN1MRl8f7psbICiuk9mYJTnrPJpdMv0ZXf0VXNjiayTrt?=
 =?us-ascii?Q?mE4mniuCrz8P/RX0Ak7aQtvPzUCZ9lLqIC3L6v0G8DZ34KCj3XAu+mQLp2bZ?=
 =?us-ascii?Q?zQ3ZRT6TSshdA+//88PGzd+Hbnx3F7UyUZdg2sC57iv9wKexD3p8fg3u3del?=
 =?us-ascii?Q?mVFPW4pScmWtiDeFGK62sNQAtocszaXeq9zf++jEe5hZ8YeWgQyLI4iRtzO0?=
 =?us-ascii?Q?c38AgDl7zK/WbTl1SWKbuGC6qpLGaebYzjCp1r7/Rm8kRzLjNKxrLddOB+DM?=
 =?us-ascii?Q?Tmwl86BhmVy1bh9whfEzclKohV+liYINekfmCpOvdLk4cQTY4g+nID9i8iWc?=
 =?us-ascii?Q?GKGKFalmdk9ZmyOJE22/LCIAlFM/LS6rUGKLeStSA/qq+SNIcPiBruy9Qnm7?=
 =?us-ascii?Q?z5Br0+R04kq0Od2ttV2vbzuelru5KH1SZL/hGndadPld99is/rtKOSMtnaW0?=
 =?us-ascii?Q?y5p9vUO8Wb++EXo3MryapsBnIEgJnsWArzO/ON64g4ruoPBJZ4G911/KzerU?=
 =?us-ascii?Q?NFLFl0rJyaJCghHBItNCQrleF4vHM+4YybdkMMyh9EOt305QpJVRci5vJUTb?=
 =?us-ascii?Q?CmFEpuecUEZ+SXLZ3JUHDG5F7sNZm5J4sB9e2XC7KzBj7W0ZLQViaEP6Az+R?=
 =?us-ascii?Q?cO1LSsNQmPZgjDVrgfBN1E4m8ZObutQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f1e8a4-aa35-4ce6-e815-08df4ba86efc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:31:29.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Q5/M414fwR/NnNzAzpfRNPM1/We4iCP1EOx1896p215z7sqdjUKrRlLZyt45NhB/K5T0/on2i4+PJ61hIQCWVKCkAnjsoIWItJDKv3s2yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:31:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25101
Content-Type: text/plain; charset="utf-8"

Without panic=3D on the kernel command line a kernel panic halts the
system. EFI Boot Guard only falls back to the other A/B slot after a
reboot, so a panic early in boot, for example a dm-verity panic on
corruption or a failing init, leaves the device hanging instead of
rolling back.

Set panic=3D5 in every efibootguard wks file, as the secure boot wks
files of qemu-amd64, qemu-arm64 and x86-uefi already do.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 wic/bbb-efibootguard.wks.in                     | 2 +-
 wic/beaglev-fire-efibootguard.wks.in            | 2 +-
 wic/de0-nano-soc-efibootguard.wks.in            | 2 +-
 wic/hihope-rzg2m-efibootguard.wks.in            | 2 +-
 wic/qemu-arm64-efibootguard.wks.in              | 2 +-
 wic/qemu-riscv64-efibootguard.wks.in            | 2 +-
 wic/rzt2h-evk-efibootguard.wks.in               | 2 +-
 wic/ti-am62px-sk-efibootguard-secureboot.wks.in | 2 +-
 wic/ti-am62px-sk-efibootguard.wks.in            | 2 +-
 wic/x86-uefi-efibootguard.wks.in                | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
index ca4e0228..828325b0 100644
--- a/wic/bbb-efibootguard.wks.in
+++ b/wic/bbb-efibootguard.wks.in
@@ -18,4 +18,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt --append=3D"rootwait console=3DttyO0,115200 omap_w=
dt.early_enable=3D1 omap_wdt.nowayout=3D1 watchdog.handle_boot_enabled=3D0"
+bootloader --ptable gpt --append=3D"rootwait console=3DttyO0,115200 omap_w=
dt.early_enable=3D1 omap_wdt.nowayout=3D1 watchdog.handle_boot_enabled=3D0 =
panic=3D5"
diff --git a/wic/beaglev-fire-efibootguard.wks.in b/wic/beaglev-fire-efiboo=
tguard.wks.in
index 70779456..862c4d89 100644
--- a/wic/beaglev-fire-efibootguard.wks.in
+++ b/wic/beaglev-fire-efibootguard.wks.in
@@ -17,4 +17,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 part /var --fstype=3Dext4 --label var --align 1024  --size 512M --fsuuid 9=
6be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5caca=
f153
=20
-bootloader --ptable gpt --append=3D"rootwait watchdog.handle_boot_enabled=
=3D0"
+bootloader --ptable gpt --append=3D"rootwait watchdog.handle_boot_enabled=
=3D0 panic=3D5"
diff --git a/wic/de0-nano-soc-efibootguard.wks.in b/wic/de0-nano-soc-efiboo=
tguard.wks.in
index 63c7589e..fbdf9725 100644
--- a/wic/de0-nano-soc-efibootguard.wks.in
+++ b/wic/de0-nano-soc-efibootguard.wks.in
@@ -17,4 +17,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append=
=3D"rootwait console=3DttyS0,115200 dw_wdt.nowayout=3D1 watchdog.handle_boo=
t_enabled=3D0"
+bootloader --ptable gpt-hybrid --source "de0-nano-soc-firmware" --append=
=3D"rootwait console=3DttyS0,115200 dw_wdt.nowayout=3D1 watchdog.handle_boo=
t_enabled=3D0 panic=3D5"
diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efiboo=
tguard.wks.in
index b78e7275..c8f0029a 100644
--- a/wic/hihope-rzg2m-efibootguard.wks.in
+++ b/wic/hihope-rzg2m-efibootguard.wks.in
@@ -13,4 +13,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttySC0,115200=
 rootwait earlyprintk"
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttySC0,115200=
 rootwait earlyprintk panic=3D5"
diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootgua=
rd.wks.in
index b6523252..9c366add 100644
--- a/wic/qemu-arm64-efibootguard.wks.in
+++ b/wic/qemu-arm64-efibootguard.wks.in
@@ -13,4 +13,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt
+bootloader --ptable gpt --append=3D"panic=3D5"
diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efiboo=
tguard.wks.in
index 2f03bdeb..b26cbd9d 100644
--- a/wic/qemu-riscv64-efibootguard.wks.in
+++ b/wic/qemu-riscv64-efibootguard.wks.in
@@ -13,4 +13,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt
+bootloader --ptable gpt --append=3D"panic=3D5"
diff --git a/wic/rzt2h-evk-efibootguard.wks.in b/wic/rzt2h-evk-efibootguard=
.wks.in
index 71bc6795..77b67581 100644
--- a/wic/rzt2h-evk-efibootguard.wks.in
+++ b/wic/rzt2h-evk-efibootguard.wks.in
@@ -11,4 +11,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt
+bootloader --ptable gpt --append=3D"panic=3D5"
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62p=
x-sk-efibootguard-secureboot.wks.in
index 8ab3bca6..1c25594b 100644
--- a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -19,4 +19,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt-hybrid --timeout=3D0 --append "rootwait rw console=
=3DttyS2,115200n8"
+bootloader --ptable gpt-hybrid --timeout=3D0 --append "rootwait rw console=
=3DttyS2,115200n8 panic=3D5"
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efiboo=
tguard.wks.in
index 66ab62ed..44db7a4b 100644
--- a/wic/ti-am62px-sk-efibootguard.wks.in
+++ b/wic/ti-am62px-sk-efibootguard.wks.in
@@ -19,4 +19,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt-hybrid --timeout=3D0 --append "rootwait rw console=
=3DttyS2,115200n8"
+bootloader --ptable gpt-hybrid --timeout=3D0 --append "rootwait rw console=
=3DttyS2,115200n8 panic=3D5"
diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.w=
ks.in
index 9cae346a..54bc9d26 100644
--- a/wic/x86-uefi-efibootguard.wks.in
+++ b/wic/x86-uefi-efibootguard.wks.in
@@ -14,4 +14,4 @@ part --source empty --sourceparams "${ABROOTFS_SOURCEPARA=
MS_B}" --align 1024 --f
 ${WIC_HOME_PARTITION}
 ${WIC_VAR_PARTITION}
=20
-bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk watchdog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1=
 "
+bootloader --ptable gpt --append=3D"console=3Dtty0 console=3DttyS0,115200 =
rootwait earlyprintk watchdog.handle_boot_enabled=3D0 iTCO_wdt.nowayout=3D1=
 panic=3D5"
--=20
2.47.3

