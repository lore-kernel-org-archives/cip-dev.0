Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1290C5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:40 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13124.1787564859150375495
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nO4oo0IF;
 spf=pass (domain: siemens.com, ip: 52.101.65.26, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOIFr9kFLT8VLlPDNY/UWBUvWWcBzpxjsEWqRSy3SoTCoLDnONj1Fi3cdFcAW1rSuMyFhLGMX7afGU8Vi6KYtgIdyF9U2WflR07a0OMxRordTdxw8oyd8TjjUVMJrYj4CL80oC1s32d+k+s8Aalq+EHzKE7qQYdDiWkLHGEhqHT8IO2yhCVIrgfJetRE9klUHYj7eVsdpBL3xGLiL0iQLpj2kqz64b3TOdsZ5bkcz9zKeJh5z8DanT47/u6MvYyYKxiEDnF+zw9R4e4qTXMEMK+rLcaGDp0btKx9iRKeUDnDfmVc0WNcZj4DVAPf64SVTbKHzV953+/1Hb7DAkoITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG1juqiC8l5uRKPgWN2OBatvxjBLJxOn2C2ckVrVf+0=;
 b=eyQWL9ikgcszdHG75ex1wYvNirlfmwNp9Fz1x9Mm6UevscL04rSQwDfIsJe3ZFWHBzV/yA72M2OeqqqSwJM9OBTZYq0kPhaL9/ia82pJfabM9qS/eIKZOzdMXnG4IxN4NoiAhcCTbRgVARQGMHg/MJETx6+4dPmkV/btEYQEuCA9w+9xWN0ogyjvxcxuWESOdpp8qp8+G5cOWNnGApqPhMyqIM8mJ9rJL0Yk3dpsr99fAdIQayBT7E8Rtfn6puFuyZSNU9G4iQf95Pq50KRuz/R0Zv3EFRI3mtglmCZ76xnreYciudo0WzD1kos0PNXrg2U/drr5HSFX+GTuh5CDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG1juqiC8l5uRKPgWN2OBatvxjBLJxOn2C2ckVrVf+0=;
 b=nO4oo0IF6OGrcOtS1kM6Di8XYiQGIwfB3EcIAU8OhFOsEcCshWnvITScMU83TtudaoQfJp/E5SNg9NFTCo54v/Kavz10UPWJPP5ARkpErzVAvV9Kx+glBUXZ0R2lYcZTyXesdtodk0lk4zhFUv/QMN1/2iQdsJ/YSkZVeSlagvUm3Hvq0GKnAaGGlvC7U7VJ314IqPVAm4LIxpIO1T8vnwk0fYaVkXDJwrpizzpP4u1S19MTlx5jHP6n0MyjzJXwGf8XqYNI8v/esk7V+g4vWcQCiQhrahr7yrzOVpSl68jtoCAR0lLM6DVW6bvKqxW1SIZJ4w1S9piHIbeJWa4+9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB8PR10MB3738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:35 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:35 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 07/12] Add class for validating the CIS options in the kernel config
Date: Mon, 24 Aug 2026 11:46:44 +0200
Message-ID: <20260824094721.2636375-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB8PR10MB3738:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b1da80-2455-44b1-0801-08df01c4b9d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|6133799003|3023799007|55112099003|20052099010|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	IZRI749p4gKMR333cfoa0ZU8UVxmfYUOyJ3mxXpA8jJdQkHp168tDw/xRVrWiPDcE1tijRJynIENCrdZqE1C+kxyrto7bMRlujxu/n7a9qK+T97JO65IQsAaIks7uTbtYMv0JAyYY7gaoyZdTjgmXhWly5qD4i8IPChjBEe9V60QssfxaKB5XTZgQjZe9ypwJj1oae4HJnojjzOUxUpnS+K3T+wLP1UqHFTnGg4gusJ+1+gsxrr65OlM1EvBzE40XZkiPuUMvMvSZIWkrebf1QL4LTGi/GH/7CuRGMEmpAHb3xtsMZ30MvWPd2xTlKuv++xnWMhPKbjm348+akjLCbxkT5GrHoELacRORujL8s3ucOwwtxjQNs14HP30//ahAHI8939KdbysE+vc+a4zK6PScrURvqVSzf6fenyynYmX1OHd2JTRGqsGoQhTsDSjGAu+uxvLPkpjOmZUxIK5K7v1P5y0YL+5T5ifuKaHE5cv4rGqt8WrtAoT3RiUGayYAxt80msb2MoX6As48FIp5ELpN4WEETK/xRThVgu5LVGagJsvo9yrZDqIz4DSC7Tydm2nBkzs3w3RcwiDwFwJ6e9aMjzzt6uBcv+8jJHLR10fEvc9Xdce7rGMnhjy/QaLa/t3B6pZJpZtcRw72VlY/vg6A/xaPrw9tk9EHaKJR3U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(55112099003)(20052099010)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+6rcIw8l8vcbKm/tyDHYp+AnqGbheaY+QebYAveIWEPWRId2F7dLw8BBwmwR?=
 =?us-ascii?Q?pN0UZ/klV34vHZLqbbQ8G+9MVc0jCkrgyFRtC8RzHNVRhHckCSEv+kc3XkZ2?=
 =?us-ascii?Q?+Oat75GWF75sNzuO8knMAVp/nIejD2KlktvfEhT9b+eqMrv88XKIBoWWlsft?=
 =?us-ascii?Q?Vgnms6sB1hayZIf/3LkCB9zdvJkRg+DvhaHz4ihquwt7nsY1Bqy55a8vm/qO?=
 =?us-ascii?Q?9t6osvqxdP96ZGPc4oLY+ugzkHAw21KBcUbJ2LyThHOsMvrnhmNZi+V/Tf3z?=
 =?us-ascii?Q?Z9bIynvIxJIE/qCqEZ21dYNABA7nWnSWuVux2yFfixQOpUy9gjJHRKXT0XMZ?=
 =?us-ascii?Q?9kxj/kU10OaeqelMkuW1TyuCxu01hp366LmdoTatibMLvBY9Ioqmid9rsTwa?=
 =?us-ascii?Q?c3NYvhW4rZ1PLe8N5KuKs30P4neA66++E2tm91dqqqMNfY4joocarfpWR0aw?=
 =?us-ascii?Q?qvIBwztrN2pDIW58E0Wf9SIMckIU6dQzi48gbiKgtpXM+iqnVyC81rrAOrCu?=
 =?us-ascii?Q?aJs7ocfMORsWmLipSZXvKBrShAlzUOc6WlfuKg/hwOg6C+1NwxK3/DwSn5QG?=
 =?us-ascii?Q?TxLM8RG9KJN3tBYLeHgh82W9AIgZs1mLxs7ek9z36NAUY68sM/4EHGjALu91?=
 =?us-ascii?Q?vSlV876D0/dseuYlGJh8lCd/nZxpwT1wXT4jMPANGXZmjhLlMUPhDKRctV1g?=
 =?us-ascii?Q?GzZ9Noi+FEP0eDI4LXm1YDCMGhPbyRCyGyGtaI/1aa+5SPFazC20hkcTtPa+?=
 =?us-ascii?Q?X3OFCvqVJzHEbOQU2jqNp7WXbUtG0MlaD5FKUR5gDYT3AJClkcKFsGNymL0t?=
 =?us-ascii?Q?DWW5S4yOIGUHlaJWX2uGB98DKB8sDvM+tUVaNaerDGWag8dEyyWiINF9Pz5f?=
 =?us-ascii?Q?MG8cMNoMmkN/qe8xHQOAGBvXxNw2mjFZ+bmsbV9ZLKmw33bAYl5z/l54CYyK?=
 =?us-ascii?Q?NXyu4y5gfdM7n52sNCeCkE0zE4Wfy+amYXo5O4OLMfdPK9UUXVCuM4ibQm0d?=
 =?us-ascii?Q?r8M+lXnda6YSSDHSZZFOvPgI12GtPNB/CUC005hewCHplIdnXGpDujHdkfIy?=
 =?us-ascii?Q?+qH5vnEMgCYnS3pbE1oKvWfym9sBvfalcbk4tpUJI9Al9c2PSWyWRd80KjMg?=
 =?us-ascii?Q?CcDsVFRAaiSOz4lv2G0O67YhErQeGnTTaKLlcUtTD1Z1g+3SyoFEQWClxKis?=
 =?us-ascii?Q?63eT458DrDJhWsHH6RAcocJtVULHx5JvtwsNJG4CewO+sODQlPD196P6aFV0?=
 =?us-ascii?Q?VM6dNKMzihZvdHAv2TW8ee5GNyI0DUVnYl8SL19HvZvswZ9k1ToisOLIdwsq?=
 =?us-ascii?Q?LP2ZHITwMtz6an/VenPi15Ryh1E9jvo0y0FSRa9D/8Lyr54S5agSQD3d0BbC?=
 =?us-ascii?Q?GnBLpHbPbE9hA2TgWxm4IyEowcPtdoQd0xRZVrGbmE1hoz2Vc3XgbncNYbn+?=
 =?us-ascii?Q?vHxWEGi+dj6+itwP9qaj9dE6N8mINUyP/zQBwAVbo6dqZcPMH4UqJQzF4THk?=
 =?us-ascii?Q?ang3VM2sFbEslA0VWNa2MYPa+3JO7QmBPLshYPiMWVXm7D3wkQGUoNoV8WzJ?=
 =?us-ascii?Q?XxJxH+HRxfHquoZnlLALtUihRToxlIzViUDxgzYOOTVXasqce6A9iZYm/96q?=
 =?us-ascii?Q?HkABY4HVT10x0dZleQ6onIiO6fm1teV3ovXP7ztP75L6xSv/PjYA4lQ18wic?=
 =?us-ascii?Q?pD8n54HQpzk9desXjI6gHDjQROiUL+HPN9qZtjrG6SZedp+aLTXuWF2qFkHf?=
 =?us-ascii?Q?iaE1kzT8UbvCepIEWayZf9SBv47UZo8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b1da80-2455-44b1-0801-08df01c4b9d3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:35.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc5nUDDGCVcSp2p2Yc3VczhPPx7tYhN6gs7JCQ8vXfCfnZkLYF/SdFy2WinUOSNywLcX5nvXFDRdMVteqtjYVimkKQBsgDIDAByBYrl22Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23988

If CIS hardening options have been configured that change the
kernel configuration, this class checks whether the correct options
are selected in the resulting kernel configuration in ROOTFSDIR.
A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
the CIS rules for the kernel options were correctly applied
(compliant: true/false).

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-kernel-hardening-validation.bbclass   | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass

diff --git a/classes-recipe/cis-kernel-hardening-validation.bbclass b/class=
es-recipe/cis-kernel-hardening-validation.bbclass
new file mode 100644
index 00000000..184da7fa
--- /dev/null
+++ b/classes-recipe/cis-kernel-hardening-validation.bbclass
@@ -0,0 +1,110 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# If CIS hardening options have been configured that change the
+# kernel configuration, this class checks whether the correct options
+# are selected in the resulting kernel configuration in ROOTFSDIR.
+# A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
+# the CIS rules for the kernel options were correctly applied
+# (compliant: true/false).
+#
+CIP_CIS_HARDENING_REPORT ??=3D "${DISTRO}-hardening-kernel-report.json"
+
+DEPLOYDIR_HARDENING =3D "${WORKDIR}/deploy-hardening"
+SSTATETASKS +=3D "do_validate_kernel_config"
+
+do_validate_kernel_config[cleandirs] +=3D "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-inputdirs] =3D "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-outputdirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_validate_kernel_config[depends] +=3D "cip-cis-rules-config:do_deploy_ha=
rdening"
+python do_validate_kernel_config() {
+    import os
+    import json
+    import re
+
+    deploy_dir_stage =3D d.getVar('DEPLOYDIR_HARDENING')
+    deploy_dir_image =3D d.getVar('DEPLOY_DIR_IMAGE')
+    boot_dir =3D os.path.join(d.getVar('ROOTFSDIR'), "boot")
+    kernel_config_path =3D None
+
+    if os.path.isdir(boot_dir):
+        for f in os.listdir(boot_dir):
+            if f.startswith("config-") and os.path.isfile(os.path.join(boo=
t_dir, f)):
+                kernel_config_path =3D os.path.join(boot_dir, f)
+                break
+
+    if not kernel_config_path:
+        return
+
+    hardening_config_path =3D os.path.join(deploy_dir_image, d.getVar('CIP=
_CIS_HARDENING_KCONFIG'))
+    if not os.path.isfile(hardening_config_path):
+        return
+
+    report =3D os.path.join(deploy_dir_stage, d.getVar('CIP_CIS_HARDENING_=
REPORT'))
+
+    kernel_options =3D {}
+    with open(kernel_config_path, 'r') as f_kernel:
+        for line in f_kernel:
+            match =3D re.match(r"^(CONFIG_[A-Za-z0-9_]+)=3D(y|m)$", line.s=
trip())
+            if match:
+                kernel_options[match.group(1)] =3D match.group(2)
+
+    report_rules =3D []
+    with open(hardening_config_path, 'r') as f_hardening:
+        hardening_lines =3D f_hardening.readlines()
+
+    i =3D 0
+    while i < len(hardening_lines):
+        line =3D hardening_lines[i].strip()
+        cis_match =3D re.match(r"^# CIS ([0-9.]+): (.*)$", line)
+        if cis_match:
+            cis_number =3D cis_match.group(1)
+            description =3D cis_match.group(2)
+            config_option =3D None
+
+            if i + 1 < len(hardening_lines):
+                next_line =3D hardening_lines[i+1].strip()
+                config_option_match =3D re.match(r"^# (CONFIG_[A-Za-z0-9_]=
*) is not set$", next_line)
+                if config_option_match:
+                    config_option =3D config_option_match.group(1)
+                    i +=3D 1
+
+            is_compliant =3D not (config_option and kernel_options.get(con=
fig_option) in ['y', 'm'])
+
+            report_rules.append({
+                "rule": {
+                    "name": cis_number,
+                    "description": description,
+                    "compliant": is_compliant
+                }
+            })
+        i +=3D 1
+
+    if not report_rules:
+        return
+
+    with open(report, 'w') as f:
+        json.dump({"rules": report_rules}, f, indent=3D2)
+
+    non_compliant =3D [r["rule"]["name"] for r in report_rules if not r["r=
ule"]["compliant"]]
+    if non_compliant:
+        bb.fatal(
+            "CIS kernel hardening validation failed. The following CIS rul=
es "
+            "have kernel options enabled that should be disabled: %s. "
+            "Details in %s." % (", ".join(non_compliant), report)
+        )
+}
+
+python do_validate_kernel_config_setscene () {
+    sstate_setscene(d)
+}
+addtask validate_kernel_config_setscene
+
+addtask validate_kernel_config before do_rootfs_finalize after do_rootfs_p=
ostprocess
--=20
2.55.0


