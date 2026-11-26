Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11271.1795689023333075748
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Vg82clj0;
 spf=pass (domain: siemens.com, ip: 40.107.130.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWrWbMzKeTX4xd4tla6Yo1bClomAgbaKyf6fHDG18lY+7rPCex9YJB/S/4zZ1cul3Ohy3ArKMAJbDB4QselQ3iFeKF9NMzk9qYSQekFuM51Ctg0v0/Cvoi3uqw6B0hufz9L3wd6xJyXE0r8uxCtEBgO+sxOggYRCnbZwcGzchjEgjvQy5c1t7P6leU1Eqvn15QXkzjuQYcX04oXgfSyFZMQf3dvkZ1GQEEMElcj/nE9lOFXIfH+LFO3Kj+FmCQnfeGESC/sEDIXDF33rdO6uDfxyW7hlGabk/xOpQNHY0IOLCscNNSQ8Ky9dCJjK9bVuO6/EPBm+7WuvqJOcXSKclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkQnNND5ajpMabwF44itmZmHEf5GBmjWn7fe14OfTz8=;
 b=x7xbMNaEah7AfhvqnJq1yEmc2/oqOWPOvAV8iGe6zbtGY7J3ZwQvsWQUQTH45cyl9osiYcHM4ZQc9IHPwbqdd24jD64Qs3TO0RAV5RP6xehSh0OtO2hRZBmEbBgVFTP1V9JxwLQfsNOXxE1W/oJKdjJE6gwO/hHbhWmvJt0KF4EcuY/Mx+lz4GkBO0kPm3bZYE8uThlRX+4guOxkcDpPHCD+TlPf0389XvIpfo5sEnW8wcZ359xycHy8deGXXmn8BYfqyFytrBKzwPa/6T6GiGN55yUAEHxumYHzj0Yhs8GxBa5Jmg2u1pYC75G9+wB54dz1faoLE1vFHpc14k5n0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkQnNND5ajpMabwF44itmZmHEf5GBmjWn7fe14OfTz8=;
 b=Vg82clj03AohF06LpGczdKWJSs/wZv83jSd9GcGeffuiHItst87duLVeQ+498wVZqLsz6Ot8yxlwoVxncaTuOzQdgJY7+3Wo1k2cSYdkXQAgmMB6AUIETEqeRFbkVNMCBXIDXKpQOuG5Sr5LA1LAUO1B+3Q7+xnWLR2dtlLPYWI/O5HBEQoTUbr/BmMvF+fDmbzimSjKU04HFeQnLFh4Vem+Yyy9QxU1439xOooCjZlr2un8KpXmlzLaJeWCtMQnA3+BCJIrGafu1gU1JZ7X7vtIzbLQYieAZ0LI4pBVAmQdyY1tAqv7qkKB5lsQdC/JPEbdB/7Ou3sldVMF18v15Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by MI7PR10MB209735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:30:19 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:19 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 10/21] dracut-config-cip-*: add build configuration packages
Date: Thu, 26 Nov 2026 11:29:56 +0100
Message-ID: <20261126103007.2922985-11-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|MI7PR10MB209735:EE_
X-MS-Office365-Filtering-Correlation-Id: 18806c76-75d2-4bf2-4c00-08df4ba844d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003|55112099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: TibZ2JxznGgoujQli2krKJbUCod1TAHoNCD4A5iVDm678qiPu+MkowWOcHwXo3XI86kdRozNPT19y3CEHYfs0J586+z2aq+d8VBafgG86zx8RFy2EYfjPSemeNvH4uYWNWQhghUa6KnVyQ7St037V0mSXv2Jctc6S+oGl31Ojhtkprw24j3MjGzX0Bdef1RjbTyDfFjKB2PxPa57SnzHzmu5Sm3AQn8cCINBesUI0YF9pUMnxJN0HvqDG7uFWE1N2YwNba5gavD57aJwahsCUIS+nMZ/WP8DSUFM39voW9EPuVcq1dETWWJFRJJ5OQs/eczDAwDD+zmLpd/46jF3FwFAK2vK4aix77i1u6cZ8OU58CETErtMfEggBiRB7HV237KTlFDeQNhED0eBqUdJFkEoRs0eju6zYM2kJDNcCPNesuEY/0q8gqNLZ78He3nWVIYi/mKaOuvIYg0O7gb9Zyz/jHxGC62J8vubncnZokiBaz6IGwEYRIbp4kjEsm5JMwdAqcaILjSJgQuRg+bNz1zwbk/WFdO6tV8ReX+Mme0MHPPjZHwOvYbwSILfC6Q4mtAcjAT5t++I9Kja/qQ+qAmTKV/KHlc2zvQNok19jw5t0/N5f1Llem5qbeQnKh88IBraAAJcc44ZVgVA+4820bf+QUpCKoQXLK8RICXA3AI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003)(55112099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cY0WHZeUPWNeyFNmmq2T9nc6Owp6pW7KmfWJfWSJvx+0kN4vJXYFA04KqY3y?=
 =?us-ascii?Q?OgHWV6tjQZk8noQfH6u4MF4GkZy/unW+M+YXt2aCOKPK9c0WX+uHsO+StWXD?=
 =?us-ascii?Q?cuYCOT048LqhaTnFt0fxwmWXU21nO6i33KdsO6J3eB7AssqfM+tbmh12eNyu?=
 =?us-ascii?Q?boaziVQnU9B+o7Feu4PIXmkpa07V+xQ4BWBxW+Okqn+nwYeKb7M0pcXna9hC?=
 =?us-ascii?Q?hniruyjxOnj2SanaKHpgyWjMBDUAYCv+a1YHqxgZhv7m1DJEsRWs8qAoiCNg?=
 =?us-ascii?Q?ZPMuZQ2qQIoqU16RaTGr+/M1kaVi8obSpmV9b3+8vOWjEHuwGnksjreYv4hz?=
 =?us-ascii?Q?fnc1B3YyeGBksUBsvtnmiGp0gXXYCbeXDosH0EVePzLDGN7nwwYeq6C3dRo4?=
 =?us-ascii?Q?/mYAm8QQHltX/jQgkU/pQQXj6MMoV0KQmrz8dja/+aSzE/GdjW0W5Z18ttde?=
 =?us-ascii?Q?6dy9LvhhtQJwBDqd5HmdUA/oTnQIhLCqCGls12vO0/+e7Wufr/3HNnBg8x6E?=
 =?us-ascii?Q?y0kPTbPK8GFNqCDu5kUrZuoXIRK8WxeqM1iKyaq/WPExtQ8GjayOh9Z8YzqF?=
 =?us-ascii?Q?zJgZ8HoHv4/GjjZ25HTHfnkWSdRDYhmE217EMWhoVGDNcFPWreTdtLWi4fOP?=
 =?us-ascii?Q?4tK2ClxjbeM2UdDfPQs1m7032+SksGGM9eLn2dxmbRnjuO4sLsmH766x3Km8?=
 =?us-ascii?Q?bv0HtuEetaoHVpvZIorvjzX8trPSkWjjA4nZcd//TtyLHgWaWgROmj/cJAX2?=
 =?us-ascii?Q?grMJ7GUfMpWybFVr41C8OwqPPZ3O2FhwXASBvbpUqITq7fnXxeUG1ZmJs21N?=
 =?us-ascii?Q?cXZqVRdlaIio9Ux6hNmWDGR1qJrg0fc2zKtbkqHB2t9uRhS55KNoQvHrBYph?=
 =?us-ascii?Q?SyczHr2CNpa6TiJZCXB13VOBMvw3QofnMdNw8khX8z+SC9vuh93ZJY2+40ZK?=
 =?us-ascii?Q?Wo3L36qyW1xt4yaQz1w2xw3FlBJNGh6+NYlWXhnGIt6hYG4+08nvqur3NGBd?=
 =?us-ascii?Q?BTZ0vAeUwIDRvW7NhN0vxqOauSPdj+ULbjTheMe2qhJfXxrs8MHRkHDQ+G+d?=
 =?us-ascii?Q?ZcxlBb5bJjfB4g/+xognuty8CnAGPRFk06BBV/069v41FcOyYH7yYaWL6yxS?=
 =?us-ascii?Q?HQGzg1D1pBZldTwuidKi4MqFEhZPKEj4BqGpO258mMWdDoUzz8thuV+KAY2f?=
 =?us-ascii?Q?uV/QlZUwln8ogzBcIN1Z+gy7xU/vae1u8lQATXKAIQINJVLXWSMD7tZUu1k2?=
 =?us-ascii?Q?DZpbMMyNv1+cTZR8tnhVbqs0NXdnsbPhMZ/JNzMEhu1HgzsyyLry/W9EShIS?=
 =?us-ascii?Q?kfMn3H2nVlSRO6QC9r/7qo72ZKPYX6ogz3Xs5HkTUl1v9irLXYEkJ8QGzdV5?=
 =?us-ascii?Q?F87KqjpHYZ/0oqAOlXsOUM2blu+J6IHmqWTJdsoTGJkcarA6DH+0NkWMcD14?=
 =?us-ascii?Q?Ysr7l54DxQ9pWQ4njf4NvKyR45CWLZzWXTp/E5QHmI01Lc+MOrYN51RVyTnb?=
 =?us-ascii?Q?Dj26WtvzjpbhQwd74MAkLp4f4WMGrfLUXVJD6TNKlbFo0tCTBAT8aV8fp8Lb?=
 =?us-ascii?Q?80eA0W663vA51eFpvE835Hwksez4LDaDtzZFG/EqQAOCqUafYZsn7nV7Jzjw?=
 =?us-ascii?Q?77MKDfVCmNWxiuDIWxOQx+n8bgTx6LEenlbMDnVZY58Y1Yyp6EK0C/K8gdVr?=
 =?us-ascii?Q?+wE5BsaMjpZI9zrpuFc9TUDqLHa6yS4zpJ6kGXBfqYBZMFZ2cW5fhbHRd2WZ?=
 =?us-ascii?Q?0HNTfSBN15WXq2JqbcCnaRcglxW29X8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18806c76-75d2-4bf2-4c00-08df4ba844d2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:19.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQuSQBCy7fcpx6Ry6YBtxZZ1yu0XjQdfBaf55ylxUFc77fuBnjyrJxHcQmBew7JFzEVqvuhckGbntYtUQwURgN8g9IzNHUR8tpKVf31EKME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR10MB209735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25092
Content-Type: text/plain; charset="utf-8"

One package per dracut module writes the existing BitBake configuration
(INITRAMFS_OVERLAY_*, CRYPT_*, INITRAMFS_FACTORY_RESET_*,
DRACUT_VERITY_DEVICE_TIMEOUT) to
/etc/dracut-embedded/embedded-<module>.conf and depends on the matching
module package. The configuration of each package is a fixed file in
the recipe, files/embedded-<module>.conf.tmpl, which Isar renders with
the BitBake values and the recipe installs unchanged, so what ends up
on the target can be read from the recipe.

The variables keep their meaning, including the legacy
INITRAMFS_OVERLAY_MOUNT_OPTION and the default of CRYPT_SETUP_TIMEOUT
from INITRAMFS_SETUP_TIMEOUT. The values are validated by the modules
when the initramfs is built (timeout format, rootfs entries). The recipe
only rejects what it needs to generate the crypttab: an upper-case UUID
in CRYPT_PARTITIONS.

dracut-config-cip-crypt also generates the crypttab for
CRYPT_PARTITIONS and installs it as /etc/crypttab from its postinst,
as cryptsetup already creates that file.

The postinst installs the crypttab on the first installation, or when
/etc/crypttab has no entries yet, but does not overwrite an edited one on
an upgrade.

With an encrypted rootfs (a CRYPT_PARTITIONS entry with the mountpoint
/), DRACUT_VERITY_REQUIRE_CRYPT defaults to "1", so that verity does not
open a rootfs whose unlock failed.

The crypt, verity, factory-reset and watchdog configurations differ
between machines (timeouts, watchdog device, the machine-specific crypt
package). Their packages are named <recipe>-${MACHINE}, as for
swupdate-config: the arch-all packages of all machines built in one
build directory share one isar-apt repository, so a machine could
otherwise install the package of another. The recipe name stays
available through PROVIDES.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/encrypt-all.yml                       |  4 +-
 .../dracut-config-cip-crypt_0.1.bb            | 97 +++++++++++++++++++
 .../files/embedded-crypt.conf.tmpl            | 16 +++
 .../dracut-config-cip-crypt/files/postinst    | 18 ++++
 .../dracut-config-cip-factory-reset_0.1.bb    | 43 ++++++++
 .../files/embedded-factory-reset.conf.tmpl    | 11 +++
 .../dracut-config-cip-overlay_0.1.bb          | 48 +++++++++
 .../files/embedded-overlay.conf.tmpl          | 12 +++
 .../dracut-config-cip-verity_0.1.bb           | 46 +++++++++
 .../files/embedded-verity.conf.tmpl           | 10 ++
 .../dracut-config-cip-watchdog_0.1.bb         | 36 +++++++
 .../files/embedded-watchdog.conf.tmpl         |  9 ++
 12 files changed, 348 insertions(+), 2 deletions(-)
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config=
-cip-crypt_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/embedde=
d-crypt.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postins=
t
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracu=
t-config-cip-factory-reset_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/files=
/embedded-factory-reset.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-conf=
ig-cip-overlay_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/files/embed=
ded-overlay.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-confi=
g-cip-verity_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/files/embedd=
ed-verity.conf.tmpl
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-con=
fig-cip-watchdog_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/files/embe=
dded-watchdog.conf.tmpl

diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
index fa24939a..db7fc322 100644
--- a/kas/opt/encrypt-all.yml
+++ b/kas/opt/encrypt-all.yml
@@ -17,7 +17,7 @@ local_conf_header:
   encrypted_root: |
     # The mountpoint / marks systema and systemb as the encrypted rootfs. =
They
     # are not mounted by the crypt hook but by the abrootfs/verity initram=
fs
-    # As we use a weak default assignment in the intramfs-crypt-hook recip=
e we need
-    # to set all partitions
+    # As we use a weak default assignment in the initramfs-crypt-hook and
+    # dracut-config-cip-crypt recipes we need to set all partitions
     CRYPT_PARTITIONS =3D "${ABROOTFS_PART_UUID_A}:/:reencrypt ${ABROOTFS_P=
ART_UUID_B}:/:reencrypt \
                          var:/var:reencrypt"
diff --git a/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb
new file mode 100644
index 00000000..7d7b0c5c
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-crypt_0.1=
.bb
@@ -0,0 +1,97 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+# The configuration differs between machines, while the arch-all packages =
of
+# all machines share one isar-apt repository: name the package per machine=
.
+PROVIDES :=3D "${PN}"
+DEBIAN_PROVIDES :=3D "${PN}"
+
+PN .=3D "-${MACHINE}"
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration and /etc/crypttab for the embedded-cr=
ypt dracut module"
+DEBIAN_DEPENDS =3D "dracut-embedded-crypt"
+
+# CRYPT_PARTITIONS elements are <partition-label|uuid|/path>:<mountpoint>:=
<reencrypt|format|noencrypt|format-if-empty>[:expand]
+# The mountpoint / marks the encrypted rootfs, it is set up before root is=
 verified
+CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
+CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
+# Defaults to INITRAMFS_SETUP_TIMEOUT, like the initramfs-tools hook.
+CRYPT_SETUP_TIMEOUT ?=3D "${@ d.getVar('INITRAMFS_SETUP_TIMEOUT') or 600}"
+CRYPT_HASH_TYPE ??=3D "sha256"
+CRYPT_KEY_ALGORITHM ??=3D "ecc"
+CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
+CRYPT_BTRFS_SUPPORT ??=3D "0"
+CRYPT_BACKEND ??=3D "systemd"
+INITRAMFS_CRYPT_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+
+OVERRIDES .=3D "${@':expand-on-crypt' if ':expand' in (d.getVar('CRYPT_PAR=
TITIONS') or '') else ''}"
+DEBIAN_DEPENDS:append:expand-on-crypt =3D ", cloud-guest-utils, fdisk"
+
+CIP_CRYPT_UUID_RE =3D "^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$"
+
+# /etc/crypttab is created by cryptsetup's postinst; shipping it as a
+# conffile would trigger a dpkg prompt. postinst installs it instead.
+SRC_URI =3D "file://embedded-crypt.conf.tmpl \
+           file://postinst"
+
+TEMPLATE_FILES =3D "embedded-crypt.conf.tmpl"
+TEMPLATE_VARS +=3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD CRYPT_SE=
TUP_TIMEOUT \
+    CRYPT_HASH_TYPE CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL \
+    CRYPT_BTRFS_SUPPORT CRYPT_BACKEND INITRAMFS_CRYPT_MOUNT_OPTIONS"
+
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    # one crypttab line per partition that is encrypted
+    : > ${WORKDIR}/crypttab
+    for entry in ${CRYPT_PARTITIONS}; do
+        label=3D$(echo "$entry" | cut -d: -f1)
+        mode=3D$(echo "$entry" | awk -F: '{print $3}')
+        if echo "$label" | grep -Eiq '${CIP_CRYPT_UUID_RE}' && \
+           ! echo "$label" | grep -Eq '${CIP_CRYPT_UUID_RE}'; then
+            bbfatal "embedded-crypt: UUID '$label' in CRYPT_PARTITIONS mus=
t be lower-case"
+        fi
+        if [ "$mode" =3D noencrypt ]; then
+            continue
+        fi
+        case "$label" in
+        /*)
+            device=3D$label
+            name=3D${label##*/}
+            ;;
+        *)
+            if echo "$label" | grep -Eq '${CIP_CRYPT_UUID_RE}'; then
+                device=3D/dev/disk/by-partuuid/$label
+                name=3D$label
+            else
+                device=3D/dev/disk/by-partlabel/$label
+                name=3Dencrypted_$label
+            fi
+            ;;
+        esac
+        # tpm2-pcrs=3D7 matches the enrollment in embedded-crypt.
+        # nofail also for the rootfs (/): the plain partitions fail to
+        # unlock on first boot, before embedded-crypt encrypts them. A
+        # rootfs that cannot be unlocked stops the boot through
+        # embedded-crypt-root.service (FailureAction=3Dreboot-force) and
+        # DRACUT_VERITY_REQUIRE_CRYPT, not through cryptsetup.target.
+        options=3Dtpm2-device=3Dauto,tpm2-pcrs=3D7,x-initrd.attach,nofail
+        # Generated from CRYPT_PARTITIONS, which lists each partition
+        # once, so the crypttab names do not collide.
+        echo "$name $device - $options" >> ${WORKDIR}/crypttab
+    done
+
+    install -D -m 0644 ${WORKDIR}/embedded-crypt.conf \
+        ${D}/etc/dracut-embedded/embedded-crypt.conf
+    if [ -s ${WORKDIR}/crypttab ]; then
+        install -D -m 0644 ${WORKDIR}/crypttab ${D}/usr/share/dracut-embed=
ded/crypttab
+    fi
+}
diff --git a/recipes-initramfs/dracut-config-cip-crypt/files/embedded-crypt=
.conf.tmpl b/recipes-initramfs/dracut-config-cip-crypt/files/embedded-crypt=
.conf.tmpl
new file mode 100644
index 00000000..c68a9d56
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/files/embedded-crypt.conf.t=
mpl
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+CRYPT_PARTITIONS=3D'${CRYPT_PARTITIONS}'
+CRYPT_CREATE_FILE_SYSTEM_CMD=3D'${CRYPT_CREATE_FILE_SYSTEM_CMD}'
+CRYPT_SETUP_TIMEOUT=3D'${CRYPT_SETUP_TIMEOUT}'
+CRYPT_HASH_TYPE=3D'${CRYPT_HASH_TYPE}'
+CRYPT_KEY_ALGORITHM=3D'${CRYPT_KEY_ALGORITHM}'
+CRYPT_ENCRYPTION_OPTIONAL=3D'${CRYPT_ENCRYPTION_OPTIONAL}'
+CRYPT_BTRFS_SUPPORT=3D'${CRYPT_BTRFS_SUPPORT}'
+CRYPT_BACKEND=3D'${CRYPT_BACKEND}'
+INITRAMFS_CRYPT_MOUNT_OPTIONS=3D'${INITRAMFS_CRYPT_MOUNT_OPTIONS}'
diff --git a/recipes-initramfs/dracut-config-cip-crypt/files/postinst b/rec=
ipes-initramfs/dracut-config-cip-crypt/files/postinst
new file mode 100644
index 00000000..bc2489b3
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/files/postinst
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+# Install the crypttab when the package is installed for the first time, o=
r
+# if /etc/crypttab has no entries yet (cryptsetup ships it with comments o=
nly).
+# Do not overwrite a crypttab that was edited after that on an upgrade.
+if [ "$1" =3D configure ] && [ -f /usr/share/dracut-embedded/crypttab ] &&
+   ! cmp -s /usr/share/dracut-embedded/crypttab /etc/crypttab; then
+    if [ -z "$2" ] || ! grep -qsv '^[[:space:]]*\(#\|$\)' /etc/crypttab; t=
hen
+        install -m 0644 /usr/share/dracut-embedded/crypttab /etc/crypttab
+    fi
+fi
diff --git a/recipes-initramfs/dracut-config-cip-factory-reset/dracut-confi=
g-cip-factory-reset_0.1.bb b/recipes-initramfs/dracut-config-cip-factory-re=
set/dracut-config-cip-factory-reset_0.1.bb
new file mode 100644
index 00000000..6c0a7b41
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-factory-reset/dracut-config-cip-f=
actory-reset_0.1.bb
@@ -0,0 +1,43 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+# The configuration differs between machines, while the arch-all packages =
of
+# all machines share one isar-apt repository: name the package per machine=
.
+PROVIDES :=3D "${PN}"
+DEBIAN_PROVIDES :=3D "${PN}"
+
+PN .=3D "-${MACHINE}"
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-factory-reset dracut=
 module"
+DEBIAN_DEPENDS =3D "dracut-embedded-factory-reset"
+DEBIAN_DEPENDS:append:encrypt-partitions =3D ", cryptsetup-bin, tpm2-tools=
, dracut-config-cip-crypt-${MACHINE}"
+
+INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
+INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D "0"
+INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D "1"
+INITRAMFS_FACTORY_RESET_TIMEOUT ?=3D "${@ d.getVar('INITRAMFS_SETUP_TIMEOU=
T') or 600}"
+
+OVERRIDES .=3D "${@':btrfs-support' if d.getVar('INITRAMFS_FACTORY_RESET_L=
UKS_FORMAT_TYPE') =3D=3D 'btrfs' else ''}"
+DEBIAN_DEPENDS:append:btrfs-support =3D ", btrfs-progs"
+
+SRC_URI =3D "file://embedded-factory-reset.conf.tmpl"
+TEMPLATE_FILES =3D "embedded-factory-reset.conf.tmpl"
+TEMPLATE_VARS +=3D "INITRAMFS_FACTORY_RESET_DEVICES \
+    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE INITRAMFS_FACTORY_RESET_CLEAR=
_TPM \
+    INITRAMFS_FACTORY_RESET_TIMEOUT"
+
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-factory-reset.conf \
+        ${D}/etc/dracut-embedded/embedded-factory-reset.conf
+}
diff --git a/recipes-initramfs/dracut-config-cip-factory-reset/files/embedd=
ed-factory-reset.conf.tmpl b/recipes-initramfs/dracut-config-cip-factory-re=
set/files/embedded-factory-reset.conf.tmpl
new file mode 100644
index 00000000..2eedb7bb
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-factory-reset/files/embedded-fact=
ory-reset.conf.tmpl
@@ -0,0 +1,11 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+INITRAMFS_FACTORY_RESET_DEVICES=3D'${INITRAMFS_FACTORY_RESET_DEVICES}'
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE=3D'${INITRAMFS_FACTORY_RESET_LUKS=
_FORMAT_TYPE}'
+INITRAMFS_FACTORY_RESET_CLEAR_TPM=3D'${INITRAMFS_FACTORY_RESET_CLEAR_TPM}'
+INITRAMFS_FACTORY_RESET_TIMEOUT=3D'${INITRAMFS_FACTORY_RESET_TIMEOUT}'
diff --git a/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-=
overlay_0.1.bb b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-=
cip-overlay_0.1.bb
new file mode 100644
index 00000000..3a0215d6
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-overlay=
_0.1.bb
@@ -0,0 +1,48 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-overlay dracut modul=
e"
+DEBIAN_DEPENDS =3D "dracut-embedded-overlay"
+
+INITRAMFS_OVERLAY_PATHS ??=3D "/etc"
+INITRAMFS_OVERLAY_STORAGE_PATH ??=3D "/var/local"
+INITRAMFS_OVERLAY_STORAGE_DEVICE ??=3D "/dev/disk/by-label/var"
+INITRAMFS_OVERLAY_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+
+python() {
+    # to be dropped end of 2027, like in initramfs-overlay-hook
+    legacy_var =3D d.getVar('INITRAMFS_OVERLAY_MOUNT_OPTION')
+    if legacy_var:
+        bb.warn("Legacy use of INITRAMFS_OVERLAY_MOUNT_OPTION detected. Mi=
grate to INITRAMFS_OVERLAY_MOUNT_OPTIONS.")
+        d.setVar('INITRAMFS_OVERLAY_MOUNT_OPTIONS', legacy_var)
+}
+# File name in FILESPATH; empty uses the script shipped with the module.
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D ""
+
+DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH =3D "${@ '/usr/share/dracut-embedded/o=
verlay_recovery_action.script' if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRI=
PT') else ''}"
+
+SRC_URI =3D "file://embedded-overlay.conf.tmpl"
+SRC_URI +=3D "${@ 'file://' + d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT'=
) if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT') else ''}"
+TEMPLATE_FILES =3D "embedded-overlay.conf.tmpl"
+TEMPLATE_VARS +=3D "INITRAMFS_OVERLAY_PATHS INITRAMFS_OVERLAY_STORAGE_PATH=
 \
+    INITRAMFS_OVERLAY_STORAGE_DEVICE INITRAMFS_OVERLAY_MOUNT_OPTIONS \
+    DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH"
+
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-overlay.conf \
+        ${D}/etc/dracut-embedded/embedded-overlay.conf
+    if [ -n "${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" ]; then
+        install -D -m 0755 ${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}=
 \
+            ${D}${DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH}
+    fi
+}
diff --git a/recipes-initramfs/dracut-config-cip-overlay/files/embedded-ove=
rlay.conf.tmpl b/recipes-initramfs/dracut-config-cip-overlay/files/embedded=
-overlay.conf.tmpl
new file mode 100644
index 00000000..2c39c2b3
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-overlay/files/embedded-overlay.co=
nf.tmpl
@@ -0,0 +1,12 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+INITRAMFS_OVERLAY_PATHS=3D'${INITRAMFS_OVERLAY_PATHS}'
+INITRAMFS_OVERLAY_STORAGE_PATH=3D'${INITRAMFS_OVERLAY_STORAGE_PATH}'
+INITRAMFS_OVERLAY_STORAGE_DEVICE=3D'${INITRAMFS_OVERLAY_STORAGE_DEVICE}'
+INITRAMFS_OVERLAY_MOUNT_OPTIONS=3D'${INITRAMFS_OVERLAY_MOUNT_OPTIONS}'
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT=3D'${DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH=
}'
diff --git a/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-v=
erity_0.1.bb b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip=
-verity_0.1.bb
new file mode 100644
index 00000000..ebd00176
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-verity_0=
.1.bb
@@ -0,0 +1,46 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+# The configuration differs between machines, while the arch-all packages =
of
+# all machines share one isar-apt repository: name the package per machine=
.
+PROVIDES :=3D "${PN}"
+DEBIAN_PROVIDES :=3D "${PN}"
+
+PN .=3D "-${MACHINE}"
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-verity dracut module=
"
+DEBIAN_DEPENDS =3D "dracut-embedded-verity"
+
+# An encrypted rootfs (CRYPT_PARTITIONS entry with the mountpoint /) must =
be
+# unlocked before verity opens it; a failed unlock is then fatal.
+def cip_verity_require_crypt(d):
+    if 'encrypt-partitions' not in (d.getVar('OVERRIDES') or '').split(':'=
):
+        return '0'
+    entries =3D (d.getVar('CRYPT_PARTITIONS') or '').split()
+    return '1' if any(e.split(':')[1:2] =3D=3D ['/'] for e in entries) els=
e '0'
+
+DRACUT_VERITY_REQUIRE_CRYPT ?=3D "${@cip_verity_require_crypt(d)}"
+# The wait counts from job queue time, so with an encrypted rootfs it must
+# exceed the crypt setup: CRYPT_SETUP_TIMEOUT + 30 s + udev discovery
+# (see the embedded-dracut-modules README). Add 60 s.
+DRACUT_VERITY_DEVICE_TIMEOUT ?=3D "${@ int(d.getVar('CRYPT_SETUP_TIMEOUT')=
 \
+    or d.getVar('INITRAMFS_SETUP_TIMEOUT') or 600) + 60}"
+
+# The configuration of the module is the rendered embedded-verity.conf.tmp=
l.
+SRC_URI =3D "file://embedded-verity.conf.tmpl"
+TEMPLATE_FILES =3D "embedded-verity.conf.tmpl"
+TEMPLATE_VARS +=3D "DRACUT_VERITY_DEVICE_TIMEOUT DRACUT_VERITY_DEVICE_LINK=
 DRACUT_VERITY_REQUIRE_CRYPT"
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-verity.conf \
+        ${D}/etc/dracut-embedded/embedded-verity.conf
+}
diff --git a/recipes-initramfs/dracut-config-cip-verity/files/embedded-veri=
ty.conf.tmpl b/recipes-initramfs/dracut-config-cip-verity/files/embedded-ve=
rity.conf.tmpl
new file mode 100644
index 00000000..73e0e5f8
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-verity/files/embedded-verity.conf=
.tmpl
@@ -0,0 +1,10 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+DRACUT_VERITY_DEVICE_TIMEOUT=3D'${DRACUT_VERITY_DEVICE_TIMEOUT}'
+DRACUT_VERITY_DEVICE_LINK=3D'${DRACUT_VERITY_DEVICE_LINK}'
+DRACUT_VERITY_REQUIRE_CRYPT=3D'${DRACUT_VERITY_REQUIRE_CRYPT}'
diff --git a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip=
-watchdog_0.1.bb b/recipes-initramfs/dracut-config-cip-watchdog/dracut-conf=
ig-cip-watchdog_0.1.bb
new file mode 100644
index 00000000..d2f55a46
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchd=
og_0.1.bb
@@ -0,0 +1,36 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+
+# The configuration differs between machines, while the arch-all packages =
of
+# all machines share one isar-apt repository: name the package per machine=
.
+PROVIDES :=3D "${PN}"
+DEBIAN_PROVIDES :=3D "${PN}"
+
+PN .=3D "-${MACHINE}"
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+DEPENDS +=3D "embedded-dracut-modules"
+
+DESCRIPTION =3D "Build configuration for the embedded-watchdog dracut modu=
le"
+DEBIAN_DEPENDS =3D "dracut-embedded-watchdog"
+
+INITRAMFS_WATCHDOG_DEVICE ??=3D ""
+INITRAMFS_WATCHDOG_SEC ??=3D "${SYSTEMD_WATCHDOG_TIMEOUT}"
+
+SRC_URI =3D "file://embedded-watchdog.conf.tmpl"
+TEMPLATE_FILES =3D "embedded-watchdog.conf.tmpl"
+TEMPLATE_VARS +=3D "INITRAMFS_WATCHDOG_DEVICE INITRAMFS_WATCHDOG_SEC"
+do_install[cleandirs] =3D "${D}/etc/dracut-embedded"
+do_install() {
+    install -D -m 0644 ${WORKDIR}/embedded-watchdog.conf \
+        ${D}/etc/dracut-embedded/embedded-watchdog.conf
+}
diff --git a/recipes-initramfs/dracut-config-cip-watchdog/files/embedded-wa=
tchdog.conf.tmpl b/recipes-initramfs/dracut-config-cip-watchdog/files/embed=
ded-watchdog.conf.tmpl
new file mode 100644
index 00000000..55d31f44
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-watchdog/files/embedded-watchdog.=
conf.tmpl
@@ -0,0 +1,9 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+INITRAMFS_WATCHDOG_DEVICE=3D'${INITRAMFS_WATCHDOG_DEVICE}'
+INITRAMFS_WATCHDOG_SEC=3D'${INITRAMFS_WATCHDOG_SEC}'
--=20
2.47.3

