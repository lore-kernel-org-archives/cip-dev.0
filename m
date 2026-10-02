Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7CECA5FD6
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:19:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=UKxoOPjE;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHbsbthA4rjCZ674JtjNkys7vCiL2nr2MY05ZZ55z9QCPc+kiM29ckoOGQTUjME7rlGtn0jovCm3c9OF0gIWfeg8S/4w3V4YTVFXHAkbWo+KYBZ9e8tJFaEb/PcRVo7U5g4O8jBeQjxTHV6QrEjxwq5D+XyM9hJf/LXEL96VKhpmvj8A9zahBhVUSaHcNnTasxGNlWQ8ZDYp4yDeUX1BiqiYRh0yb2Kg3WArt0QF/Ri+VovvqOBva1aM7+fjzuI1LbM8+HW4Z7KlVpcHlQzKctIBS4ETBfRtM0uSC/Wg38t1MY274zIZTx7TCyv3nVJSu4oKoR6MdzeSp+GdWyKqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvutpdjI2EdHjcZKlNctz0zG90fq22/M6lilqCkoExs=;
 b=iQJgzYsnVZf8iXaiCea31/4R7MQVSbRm0bszWAdNpqIzaVxLqzun9F1Xj7zNl1gs+cATgs76p7bWijm/UUylrWI1Zae3rSypH77zQZxcS7wJ6HoWZB9tJ4H0LWfcJUnwP1O8XgOH9CZEri2H9jmh+8dwtF2CqYIF17qYe6G7yglW6hmv+f5nG/C495tLQdO3qYX5xe13WaXw3VaIKrSxMRmA14HWLK2/1d0v3z5CmEnbCi8HqwOelE+e0Nc4g+KBkUuwfdXzgvaw2nVa7dEcvPzxE9GgRxoOnLT476Udq6bV1KDvixOAEkScWBsJxvT8+IziCjVGJkcpyjwckgxrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvutpdjI2EdHjcZKlNctz0zG90fq22/M6lilqCkoExs=;
 b=UKxoOPjEpkiOXOQB5VpJVnQkNH1d99LY3/KQqjDjvo0jfEq/P+/iU+S+nnD21FYPSQLkcABtQ+K3j0H9U0897oDMLqNXA8qyYnri73AiUNZOs1JLPcGEF79pd3fVNviBlwlZoxKcZ2E6wYWtshqy1sYlFqzmm4o/FtW63nre/LV4/l8ppyyk5nVSzcR1u0F7l09+gCw99/31ugrUS/6oPaCywqUU6sLsxdE1Pj4nNjz8vRvt3kXpFZkhdBw48Tgw1H07IPrMcyT9cToHIC9rRhexNxwGEoIdJ29ekNnVUg0ukNq0lz+ulqc753K5atK2msfOxOrPy9s3/zEJhx4O0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:49 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:49 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 03/11] efibootguard-boot: emit systemd verity cmdline for dracut
Date: Fri,  2 Oct 2026 13:18:50 +0200
Message-ID: <20261002111938.3600786-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8cd341-7016-4c19-36be-08df20771180
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	SCZJc5hZ3QcguUDIFnkh4Paqa0wypBhnCgj5uV/nn1BkcngC9N611w3kh0zZ6/5N0GxTmoEaVGFOGE990EQOdvY1/pdjxY78lMNS9euDhyunySQX+mNG3a5Hi/TxarVrrY2/n73JRNzd8N9XFDtCygp0hJ+pPCLJXpYRktZhKu+311Dzr0vRV829gqQZKzEywROzh2O6SwcD2g+upzgfKAzrZZP+YTsycwzHDGC637i2mDl2Kn7KJpWa1lksUYBbcdmd5G/pkrBVmQl0EnB64UEkjKJATAemLfoSyf0rZCloZn3LTETpKnZr4ECnWnTgcjfK5T7X9j800dVXQ/uXDgQRUbRcaabM5YMbh/QyljyCzBhtdNzV40D9aNjECsdnnfHKj1638FgWPHQRq6GlrXoBNXSHKpUIGdukXQjSrvfxHmSD0lYQH/QvNjynaYjR0ePq9SDKbbx5/O+/RHX/ycsPnvEX+BIKo59MPEgxTz1XQDcd0m4NT9frE1S9Hz1AKp7l5BiLVqEBIMykzUhdpJZfuWzxntbUkpe1eazt1Q8vUYxMI1mtt4rem/Eke4X+tlBcqm2//F24XLqQoGMEmalXLetjM1MxPy+oGwLCwEsMFdmDnrnkFJxpTQILCB4G0/yTTYFqeMZfYmNLS8c2oo/dTEMI/Q4EzFqWhB+gwdk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DzChYyF/gv1/n3EX/LLMy327eFUxHU84+LJhsh5vIwB5SRD27ZnLl1Be7hfr?=
 =?us-ascii?Q?ecOqSq3FAy3GOfqhl8Roiikc87UNb6fYvp5oXXzso1FOf8riy9dzpf1GEQOr?=
 =?us-ascii?Q?CU1DqLz2qgcqEljzhEDMZQXrj/NVTFyOb7aRrQFT1Z5lqEYu/JQFLRiY8VW5?=
 =?us-ascii?Q?u6Y5J5JZu5yFfvcZilADGaajD7C2CbisL/CLXJ9e6/cJEeJzBgvn+76Q65yd?=
 =?us-ascii?Q?iG/uSi5eB92SMm2pCjoAfnie07SGgjowIUkT70WZjOy4IdiTvs/Gbl5XK6Pq?=
 =?us-ascii?Q?X8goJxVrxDVy/k8nLA2zznaqt2yIJrMNq8vTE8XREijS9EpIK/XLdO7k3R90?=
 =?us-ascii?Q?cLO4JlWoY7n9AUPMm+8gTojEO60aApekx4ULlwcjiqJ1meCqPe5c7KSCKU9H?=
 =?us-ascii?Q?vEuz50yQv+8o2Bczb2eUWOLkat4S8TIuO0Y3YzLyZTJLdpHstU1lxjwCXwx1?=
 =?us-ascii?Q?H6dQMWnpncGnIqoccPmfBFbviLNA0jVg8KjFFws61juyBEB5iThipG2XmGeN?=
 =?us-ascii?Q?yH/VIDlAA5JavnmATQp5FywIGw4R0rbIFbeQ3GvuaXkeveVPtezd6rdkSHvf?=
 =?us-ascii?Q?hnji9QoOWOs7uByU8r678Ix9YEoymCzegKVa83DLEgIE9dwq0d2uQnZ/O74N?=
 =?us-ascii?Q?Ol1j9cWkSXDIdkQI6hUquZBT5qOzZPXud8bBscdMIpVQFuNLb5r50UEQTP7C?=
 =?us-ascii?Q?glPNL4eI/CGOnF6OquYG18Ds6JnGQtFWIkOjdqmZn1dAKvP2ExJX9GSIyzMR?=
 =?us-ascii?Q?5XFuHh8yTg2C3lNAY0lAaWeGwBBqQByt50LQNGDqMBc7H6THy0TpATD9EGiw?=
 =?us-ascii?Q?FD0go+1yXyen9NaL/Ndw2Dn3vLzdCE38XAIyrgTvcLIvBxCSdk5FhdpYX5wi?=
 =?us-ascii?Q?LhFYzM2hsUSmAN26G3bdnTdMPySBplye2eVxc12wuT2lGFYED859Ze2lrUkq?=
 =?us-ascii?Q?ZC7AzgpUO20l2hOwEo3vrzS1sAxe2e7CXa31Nb9Yo+e0L/c7cFjmHyzksE+G?=
 =?us-ascii?Q?khXATZFrxfZgVXo30UUN6IUpBs1V2useFC269Gy25FKFRpGY5RGAy4JkikUt?=
 =?us-ascii?Q?G9iaMVUraJhUGRDGRYQvkHHc1clwh4qibLJhIznnk901Irky8i6Ehyzm2f0S?=
 =?us-ascii?Q?T0rtFZVskxoITdKktvkykUtuf/GXsZEPOZDfDAAa+GEsbDjdJbuwPqLrtqMm?=
 =?us-ascii?Q?irk8LbUxPgmbRE8wHyBNLUXNQ2SVEkzywvCToWFKtDoaD1H7XYGIDFV6bAmu?=
 =?us-ascii?Q?fd0sWaz0OH90ORO2Tlj3IAxDM9IjCtEoHh3Ii/AEUhWMzhm4nG+haTIj+Yyy?=
 =?us-ascii?Q?7Qp7/jZPkrqEdztWeB4JdLSOHyExqV+3TC0QPlh1QMGuNOk6NbQDyGP4aP8a?=
 =?us-ascii?Q?/WfyUU44Lr4xIqLo4LBkHAeXNhCPPAYyjaKeHkdUfY5SsC83WInDGQa3YGsU?=
 =?us-ascii?Q?uNRO7dkM/YlpTtp7FY8yCYeXyBCYBdRt6qYFenHbdIsJ5V3j2XAnia8gcjCw?=
 =?us-ascii?Q?Y5Yoju12rHRf2pZ4iTtw4Fp29NKyJyrBE4hd466SOb6egYIB8QBFLQERjT/J?=
 =?us-ascii?Q?Qxr18ivcj8J4LQCqGRuQCvHCSX60JuxYO0Iq5vj7pehDpOKjN1ZwBJr1CW5n?=
 =?us-ascii?Q?hBb40Kls1jJaXp83tdovG7QnXhY8HZsajh3iXi4xs9SCtvZv0xHDYcBw9f/g?=
 =?us-ascii?Q?IxpJU+dsw5jqG312NoC+W1UVIlsTWKQCsBpHaRWue2QDG0NX/SLjH2ydMTIR?=
 =?us-ascii?Q?ECYUJ2Jo+6fTY/r2vASqZTjWU8g9aKI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8cd341-7016-4c19-36be-08df20771180
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:47.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKt723c2JTNdxzZ0AKnpHRFwDBdbwYPdeG16hvt9b4ulrDnnzLgowpdu+SDO23tFfqGu8UEPAR5LPcW8b1ypCclL/G39UZtqDAbUpUmejk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24406

INITRD_CMDLINE_STYLE selects the kernel command line dialect for
verity. The default "initramfs-tools" keeps cip.verity_root_options=3D.
"dracut" emits systemd's native roothash=3D and
systemd.verity_root_options=3D, with the data and hash device resolved at
runtime by the cip-verity dracut module (/dev/cip/verity-data), plus
INITRD_EMERGENCY_CMDLINE (default "rd.shell=3D0 rd.emergency=3Dreboot"), so
that a failed boot reboots and EFI Boot Guard can roll back.

Also drop the LABEL=3Dvar entry from the generated fstab. /var is mounted
by the initramfs (overlay and crypt hooks); the additional fstab entry
makes systemd manage a second var.mount for the same filesystem.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass       |  6 +++-
 .../wic/plugins/source/efibootguard-boot.py   | 33 +++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 70152de2..179dcb98 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -17,6 +17,11 @@ IMAGE_INITRD =3D "${INITRAMFS_RECIPE}"
=20
 do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build"
=20
+INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
+
+INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
+WICVARS +=3D "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE RO_ROOTFS_TYPE=
"
+
 WIC_HOME_PARTITION =3D ""
 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs --ch=
ange-directory=3Dhome --fstype=3Dext4 --label home --align 1024  --size 1G =
--fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0=
f-58904f369524"
=20
@@ -76,7 +81,6 @@ image_configure_fstab() {
     run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
 /dev/root	/		auto		defaults,ro			0	0
-LABEL=3Dvar	/var		auto		defaults			0	0
 proc		/proc		proc		nosuid,noexec,nodev		0	0
 sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
 devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index ca97d7d7..f6d16310 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -36,6 +36,7 @@ import logging
=20
 msger =3D logging.getLogger('wic')
=20
+from wic import WicError
 from wic.pluginbase import SourcePlugin
 from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
=20
@@ -91,8 +92,11 @@ class EfibootguardBootPlugin(SourcePlugin):
         cmdline =3D bootloader.append or ''
         # the verity cmdline format is identical to systemd.verity_root_op=
tions
         if source_params.get("verity_root") =3D=3D 'y':
-            cmdline +=3D " cip.verity_root_options=3Dpanic-on-corruption,%=
s" \
-                % cls._get_verity_opts()
+            if get_bitbake_var("INITRD_CMDLINE_STYLE") =3D=3D "systemd":
+                cmdline +=3D cls._get_verity_cmdline_dracut()
+            else:
+                cmdline +=3D " cip.verity_root_options=3Dpanic-on-corrupti=
on,%s" \
+                    % cls._get_verity_opts()
         if source_params.get("abrootfs_root") =3D=3D 'y':
             cmdline +=3D " cip.abrootfs_root_options=3D%s" \
                 % cls._get_abrootfs_opts()
@@ -188,6 +192,31 @@ class EfibootguardBootPlugin(SourcePlugin):
                 cmdline.append(f'{k}=3D{v}')
         return ",".join(cmdline)
=20
+    @classmethod
+    def _get_verity_cmdline_dracut(cls):
+        """Emit systemd's native verity arguments."""
+        opts =3D cls._get_verity_opts().split(',')
+        root_hash =3D None
+        rest =3D []
+        for opt in opts:
+            if opt.startswith('hash=3D'):
+                root_hash =3D opt[len('hash=3D'):]
+            else:
+                rest.append(opt)
+        if not root_hash:
+            raise WicError("efibootguard-boot: no root hash found in the "
+                           "verity environment file")
+        rootfstype =3D get_bitbake_var("RO_ROOTFS_TYPE") or "squashfs"
+        emergency =3D get_bitbake_var("INITRD_EMERGENCY_CMDLINE")
+        if emergency is None:
+            emergency =3D "rd.shell=3D0 rd.emergency=3Dreboot"
+        return (" roothash=3D%s"
+                " systemd.verity_root_options=3Dpanic-on-corruption,%s"
+                " systemd.verity_root_data=3D/dev/cip/verity-data"
+                " systemd.verity_root_hash=3D/dev/cip/verity-data"
+                " root=3D/dev/mapper/root rootfstype=3D%s ro %s"
+                % (root_hash, ",".join(rest), rootfstype, emergency))
+
     @classmethod
     def _get_abrootfs_opts(cls):
         abrootfs_sd_keys =3D ["target-image-uuid"]
--=20
2.55.0


