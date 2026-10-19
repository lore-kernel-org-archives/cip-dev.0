Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B09CCF2EA
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:01 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31404.1792405559440302034
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kaA/4+b4;
 spf=pass (domain: siemens.com, ip: 52.101.70.60, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTZBPhS7pJoZIcT26+cixd8pfg4HwPu3ty+8NEdACUR0GlVS3lmWjTu5sn5zTR8a6oYotNU5CF2oHjEYyqa8MDZJnXTQd2I2e+8oTg9V27MmOzuthUofkMCULxp1nNgQssM4AizAebkefVAvh+xBw8NcL2fQ8H4PQnsb38Eo8B+jeAhWzW+LHF59lyp5/M+nK2iVMNJnVl4UAF1cEPoLPgmmIQqJpDCsRBG8Abn0rk9pYIjfDk/XNMJZ2kNFfF2h82deIZn245gjKUD1j14PimhsydJ6zl5PZOxWN/z6QTjACdw/Y4CsqYm9mAbP9A1XID9z4v7vrdc4roIuAdpGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7SABbt3ftfqmtNCJjZM9ECQTkbvs746efrJrFQ1I2s=;
 b=UurRGWoXffkOGW90sSsPi+fEZ4Ipy8mr8E627WU8zoRSkz9bl6GoZAvV+xg4RktQpprfrj9sOUU+9xoIhTFelet6dAVwzw0ybNIby5bjnBGFH0PMzd61PUZ8cpZf73rT4i3o+yZtcLHzIbam/ND9Akh4E0QwhaZfNi8T3u3uIjiw5Jxtk2w0oZf+iGMcrjQWFf4BLPODxYo+Uw4ZaWILAaWKgHULe4I9N7o3hDwsfJTnrz5+Bo6FCGnpogAUzmjh2ZsOMi1ktDoREassCQPHtyLKurVsiOUSAlUv6AqomfK3MZeVLtJ04ip1SmznGuaRy3kS4OwMaz1Wfhh2M0FXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7SABbt3ftfqmtNCJjZM9ECQTkbvs746efrJrFQ1I2s=;
 b=kaA/4+b4qU0AhOO+BM/uEHW5vYw0X2dcOQDr8trPPAsYk10Tnk+p3ewvbFjQ8fMSAr9mso9sRvNzRDBF58ZL5CfUrZElKQOlUti9265OQ8dVppqY6Ep5as0VquynbktS1CVl/ngcRoUMhHzFj4YI6cMRf+lGpsWTb8xoQtliPR21nmeW6Y/XmzdQ7Nn1ZI7RPLCZKxurPllRoLJZ2/Cq6dpG4TJ2iaTAvkFQzTCtsnJ0Vzcs678tJG3iJ0TiL1DWOM8DD9yc0RyV0xzLpbQ91REtabPJQBbg/uw7hl9dPDIuiD42ZNbkB3DXyYrrSv6/yH2BLq1bQIvZboWePlpXBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:54 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:54 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 10/12] read-only-rootfs: check dracut verity and secure boot settings
Date: Mon, 19 Oct 2026 12:25:21 +0200
Message-ID: <20261019102541.672620-11-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbaaed0-da87-4715-0b0a-08df2dcb5af5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|18002099003|22082099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	qvN6xq513rKv3SAVPvk7cM4IL73eLgGgsT606UorgdWWR8Out3hqjFJFp4SQbY61lY+zrqi5jicmfXt014q+w7hXhqySgYiuiNTdZXy2N38hpe6eyf55qFmelIvnfAgov4dNW2C7D3DH48T0imy+f4dMbr/1AT5kGsNBDx3vssPjBAFGeKuDggMVSX2/+zslPxh6XpSbbGYGsWmAIu8SKvdfJqlhO1l1UBXdWnlvLzInXu9eqDJ4a6BSHntFl1GAX0KiMgkxjf9qfDVrWNW+Mldv8IOKVg7LyF1cVIwKjtZD7vF3VlXKR5f/4F7Ho9iLKrQjvohRnoGupGBfvjGCSURwNooAbyYfDE04193hZxFkEZDrsKT8o9Qm1WZeSLrwieQzPYCu+22qB0uaSkBggrnJnG3GSJ014rXO3M1Vgmx6CX6XBMVi9S6kEmk3PdGdVwCMSZlzjC7ANHgOWLTTJXtXj3jIhpfENS0u790xcPPj5dNllKRdxPm5pjM5MNDvdgOka5BGDDp12/IuiNTFLu4Cut5P4wmEgyVjzNmE/7VcscHMIHs2fNoqrTVDvbpePHz4/0lB6cIK9bdv0ECtcs7HQpLDrb92AGrNVoTIzGr0lZxRlJBGnwVDleN+EutvoIhspNkeksOfIUx+vtrr9nd1CXixCQVbAYQc8MK5rgU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?440AgxFyTF4zDwEnB2640vJpsscjmYpoY7CVvuD1EXUrvH6y1l+e9snNOt+V?=
 =?us-ascii?Q?L18HCl0FSmdBy3cHsCegfVNTe7Dna9PqHxSPEeogjJLV6MExs2evSQoaqW68?=
 =?us-ascii?Q?Gv7FWUVKCnlPTClSZZ+dsJ5BCA1SwKyDHEcvqChCrNPmRZONbvNcs2SfXtNm?=
 =?us-ascii?Q?IZN46J0QpuyohYcQjt7vt40kdtzG0aYC+bHSCEkbLYCfX07lYIDcfSE8zqt6?=
 =?us-ascii?Q?xSEYuUp5yibermYY4zIVBh8sBOQ9N8pP4hZ7qmG/I579/Bcyzifk1slsmENt?=
 =?us-ascii?Q?2aBSYHSJwBZFAvL9E4d6mwU+ONQKsIjAyLkHEVrk4wryealIeuqq9MfWiyXv?=
 =?us-ascii?Q?rpfWHm8ymnAJg8gmEJVkbWtf1ab4AsGB13EXvHLUuAhH/EYvJTGaiJgmCjJU?=
 =?us-ascii?Q?2swNj7PCUKm61qAzoyc+iPlACaI67McMLsZ2m+GFUElrGoPE1TODuXOKJ4sN?=
 =?us-ascii?Q?QlqI1j8AhaLZU8rG4mCNW6DjHyCxYxCIexgKZv35Pz3eNYbpcqRAjoBOqIuG?=
 =?us-ascii?Q?Z0ayigws5eV3xeIy/a8cqjgRk+zss00xGgpqr5gXExxwUwoLbIDAXTJ6NfW1?=
 =?us-ascii?Q?ZfaB1WNnT6lhglSAS8dAA5V/sF/kh/4kSG+xE0phZuxlDimw0LDPnsnyXyxL?=
 =?us-ascii?Q?VetfbvlYEBE0Kj0BF2xwkB7fQsuVmWG6/TEY2HHsNK2JoYjNjU3NQ8yra8te?=
 =?us-ascii?Q?7D9OxPKf3M9mFGAecdh4Bxnj/GN3gUjCb8fyJRbSy3yed8KUn1IuBNhAc+yF?=
 =?us-ascii?Q?Es/4Q6AxmmrtkJbhGgT6N8TJt/oqrIHjjyoTgCehE9P3YYCamHX6Brb44WMF?=
 =?us-ascii?Q?CzgqrtrNBoTCMdvFKeTTVRYvOtFWlNYnXZOwCnntR16Vqp6xPaZgLCA0ureC?=
 =?us-ascii?Q?drTohcM/LeJXgkXAkoMqS6/8OD1TkTc+CE7cmGbk1/232/V2dy5dQ3ybltXI?=
 =?us-ascii?Q?f8kwh7A6WlSTqX6AnMnw2DmEYcHHZo1TQt8gZQYMy9Oc4T3A96w9iRQQQUv9?=
 =?us-ascii?Q?hogf1AGRJiFRnF94WCF8GkShYyTYN0xzis+pJSYPFCP/jYJ2flJ/n5WvFAmC?=
 =?us-ascii?Q?vZM9kHPwCvzKU2XyfH5c5u5lwInU1hmMMk38TPQoCDKX/a4ujjGED3xI7abG?=
 =?us-ascii?Q?9XN80ojpdeSP0vc00NFRQu0+DetfMcJmxCzl1vym3vemMgQykpX10jR/lkXd?=
 =?us-ascii?Q?uiWp94eCqHoUPTLiK6bFqmmV8/H0W4poxuWG1h6u67FW+WdCQdreU57cDE29?=
 =?us-ascii?Q?GDiGcVomf5TJ55nPI6FCr0OlW+X/NkbMEMPwWdP1r5xtIP0Z7pseeyG2IL+q?=
 =?us-ascii?Q?zobHR4fYQgjeldyEd7pEsXwCfp5MHsQtiGToOP0c0t4rsQk0elAlOEpUuLkF?=
 =?us-ascii?Q?rzhssXEKiCSIe72Z5AuZxGradvDzA8C5+ewtjQxjMz2QzIgwjJEzNR8outgh?=
 =?us-ascii?Q?N86UWRC2VsiqIJhKUydvjWJa+uT2NZHbgOzIVZRR+jT7OteedIZ9pJ07UIbx?=
 =?us-ascii?Q?IO4985VD+1SA0qkiggDLGq1TtMxpus/tes0FuAO5sc+79TEMtlHIQRrbhn1B?=
 =?us-ascii?Q?pnoGr4H+aJhMXc4Brrg6BFkyGR/oUGprm/gsn6u+zXMI+xrLovKxJ5n0q80Y?=
 =?us-ascii?Q?sRVxo654/TyXJAjzMGFO8OkB/hie5XCphK4n3fYXVn1acP1MMox3nYnEcgBG?=
 =?us-ascii?Q?zt0WRZapBngRQGc03cx8e1HptKq+EF7SK4239rvHmisOcpjAV9OBt6F8NGmt?=
 =?us-ascii?Q?uZAjq2Y+4jGVh3jGsvVzY60yjGUC25g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbaaed0-da87-4715-0b0a-08df2dcb5af5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:53.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Iq1GuG010xM1hAU0iH0lFHANLaOzu6DuGtfr6NrFxmZp1tzP+aWS0Xl2C3A33uZ/sqrPWzV3vHE6OOSWuf9lbgbtdSixJ2K8BHd1ObPBlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24490

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 631fc6a2..15935365 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -22,6 +22,19 @@ INITRD_CMDLINE_STYLE ?=3D "cip-initramfs"
 INITRD_EMERGENCY_CMDLINE ?=3D "rd.shell=3D0 rd.emergency=3Dreboot"
 WICVARS +=3D "INITRD_CMDLINE_STYLE INITRD_EMERGENCY_CMDLINE RO_ROOTFS_TYPE=
"
=20
+python () {
+    if d.getVar('INITRAMFS_RECIPE') !=3D 'cip-core-initramfs-dracut':
+        return
+    if not bb.utils.to_boolean(d.getVar('RO_ROOTFS_VERITY')):
+        bb.fatal("The dracut initramfs requires RO_ROOTFS_VERITY =3D \"1\"=
: "
+                 "verity is its only A/B root selection.")
+    if 'secureboot' not in d.getVar('OVERRIDES').split(':'):
+        bb.warn("dracut initramfs without secure boot: dm-verity only "
+                "selects the A/B rootfs and detects accidental corruption.=
 "
+                "The unified kernel image and its root hash are unsigned, =
so "
+                "there is no protection against tampering.")
+}
+
 # Rootfs image type written to the A/B rootfs partition by the wks files.
 WIC_ROOTFS_IMAGE_TYPE ??=3D "${@'verity' if bb.utils.to_boolean(d.getVar('=
RO_ROOTFS_VERITY')) else d.getVar('RO_ROOTFS_TYPE')}"
=20
--=20
2.55.0


