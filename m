Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11270.1795689018322784349
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=M5HJtOu4;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hu2NrzeusBVhl4W2lp0cjh0cPb11xdH3/F4/3CCeBH4TyOLPNz83nEYbI3OjDIakVIChFx4yIPE8eqMwjaJKDOKqC/yftT/Tt2bdVzdHmdv1vDwNs3OV7lQlspmqwN8WS9/0U88ifOeqLUhhRMGVXgUPXW8AdPD0GNAiEYiB9NnWT2qLxWrdx+o5varxQXzIFjAqOjONlUrSLMZ5wqwpe1SJUjtAV9V0C825dT1BdRV7Vzps1pGGFqPrdfPPYbBENWmdANLAAcPmNyw6EKiRLzrMCkns1Q9j+3sC2nXarFUeHb4p+3YKMo9YL6rFQFVOkfoPMjYUtKCVHSE7stAb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bDxJwerld9ywhWYolwpycASdACB7qVFkCXItq8iv08=;
 b=reiI9FkTdYHp4Qvn3fSxBJU+IGgFOy0G7O6faWl62a4XDrEUQLjAbnOUDS9qWFX7T5WdafAMJHTcjPK9iQmz7Jjd9KCkTTHP2WyQuXGn5rW8SFh7+9BpzmoBTbd5O6ZeR5kgiO14iGkUsxJuhoXmJdE8UGfOtvbHhAsmCWSUmjM410DRRPLqw/Vp5kUkfKsPY77gKxPx3+QUqNk/gVzPhDTyPAIX+xIiUEE4ZtP0Iwqn8O0ZevbzjsSrOy+mdWwyZCRyE8VYa53SaXCtoVK5I98aCsVXs9dUbc8xOcVbboyvmrtYHIS9Df7emdNXHmJp94hK71gJhojVUIe8xWdxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bDxJwerld9ywhWYolwpycASdACB7qVFkCXItq8iv08=;
 b=M5HJtOu4UWJWKo+dmtdNul/3VLZDH52OAbaiDbZlGklHnpb7sm9uLmqiVqEHJ4aAquIENvRiu9W8ckrChZpGeCOqRDwhNGWe5sx+Wzfx92u5nnJgvPF2e3XDfuXnRFLARqiUFLeBMjGHjjCX2nX5bbth21KnyhQj3Z+lBjPaizOOjogwDdq6LQbGGK+114+qfGcfS6pMjsTrLAhE3klyFgvHFFaWx0N/KqSsfXr6N733N/u6PmaUUU1mrHOWqljg9S4aDlgRSI2AuYEeTnY//6JFqijVRBZ5usVLvBfWQoINoQoC7HS9yhK3yS0qGlV1MPKDsVet7XZB5QY4Rfxieg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:17 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:17 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 06/21] read-only-rootfs: check ROOTFS_CONTAINER_TYPE and secure boot settings
Date: Thu, 26 Nov 2026 11:29:52 +0100
Message-ID: <20261126103007.2922985-7-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: d900bdd8-1470-4636-fbb2-08df4ba84387
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261028144727099003|10067099003|11063799006|261022115727099003|56012099006|261021121427099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003|261102123227099003|18002099003|6133799003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ir3DH0pSu1H8w1SLse3KZYMCYEVgcBWG3SWHU0u5Eob6zLvnk2Omx/YXGiT3I0QuvDmTeeBIT6tXaPqWpjh99Nvwcqnvwx4xKSc5+66EFOhdZZgSZOSeSW8Sy/uMTHHuMZAM8O0Po3gB7NihR+F7fC7lh/0x7qOs6oCYOHxawyOYg2oqjKJz+sUIyfXot9vLmw4SLFo8b5+WAgzr83yfAQEChQ9vCKPR6dUZsoa3VB5Yhz+ZLDAJ0DaMg46yDftB8pFZjIBe4Ph2B+QfnAAoblQCHL2iqRAm4UX5OJsiOm7+fLLRxIHJvJ6aB23+NILh36FRlcDCUbd3B2wy/gFY0vJMJrBGrJ2vOhvn6i6MN5eqj8dMgNklo+kIu1YRgoMST8T5F6+VBPINlJhGCOpPFVGPAONV33ASQI81ph4WVRJbSfxEQPx3rF/Ga5deASBPjC+4wsjlrIZXEUs4qVgi5f96vR/cO2tdzVPu1BhGzMytMMqA5a5WR0q/+LhIdSavVnovqUvgoK85dxV9WrHZeHs5tHSIWVabCHpe8jAEF4HYk7Rgbn1RVEG8vfs2o51EcHDUZeWfpOpK5yt597uf3dI6yRz3O3vtsS7ibtQXRqHQjQlGCV/KVEq0/v9effKiXIyK0/GfBmfSVg/wZO8TYA5ltk0SHqdNTRMnVM7JD8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261028144727099003)(10067099003)(11063799006)(261022115727099003)(56012099006)(261021121427099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yPxfaB+5T9bJEYgZ/CN+0Nvk+YcW3fuhpmP14oNJtGP+KDFaxfxQYra1jL5P?=
 =?us-ascii?Q?6rAGHLFzkWloiMUhvgsgv/caOZBpIibxnl4QqFb/1vnHfc7Cax+MrbaExfXQ?=
 =?us-ascii?Q?JRibGPpURzjjQFbVoRugX0OJjoEL53tra/AWWkm9y8TPywiePqZKDZf6sPWh?=
 =?us-ascii?Q?zyAXFv+vOEAEZ/9WwoyfAKOryDIKde3iLVbL5gj8id1JUd6xEMOGZUqvEgL+?=
 =?us-ascii?Q?B7CF9NEp0f3vcD7zIjOeZW9R1Fb++T2jMhDD15VT6o3L4qDdoT6eApMTrbdd?=
 =?us-ascii?Q?iAFr9B1NdCgMVWbnZYQsyTp7q+UXYQorDWB3WtJq0fY5/om2NP2KldQjfpwl?=
 =?us-ascii?Q?Mk/zfE615ytekOrr2R9mg/Jdso0DdFEV30u0YU5wWtXC0TLxxDfr/L2m1yaB?=
 =?us-ascii?Q?P7gY2mK2Wxy4GU6AA+b/B4S/zyADvfCjeyect78dCj6ORzDbdkMIjLC9iaTC?=
 =?us-ascii?Q?+A1OpIlcrSVZ0viXynxHM61ujGFCIk8poB/olWRQuY8Kn++D8TBMtxpAKwEc?=
 =?us-ascii?Q?wFp7e7EhRtOrvL5bemWqwqVQZVqnYbdx7Jo4lFrKI+Ij7WP16bdER2U1owug?=
 =?us-ascii?Q?Zv+EckMoFb/7BDUIWEMs0L9xAxhl0Q13FXLcddeKZAh0S52Jz5uP3QxCz3P4?=
 =?us-ascii?Q?reuAC9HpqmpMTunbSUV5yhnfPhfWaf+4rQlwa83fl8uLd5G03FDkyBe29i65?=
 =?us-ascii?Q?osJLuai9nZPP2NiC8GDzwccWTVaBO+JjzDIjVx9mUHgdAdlDvIeNDgf+W/mW?=
 =?us-ascii?Q?5XiFFA3pmcTjlzmb7+OjWSGTUTZxmYOTzXzqU3+gvaAPiFVt8k99PH7pbf1F?=
 =?us-ascii?Q?IVisk/CTPwovmon92hImV9VLXyuW9YZvVcp2NSNroAuUuZ3+1gxVrfu4VUrI?=
 =?us-ascii?Q?VzL9z5RY3xh+XElgARujumCk+nn8CQ+58ElI3dGeeyG8uh+InZiETiEGYodx?=
 =?us-ascii?Q?jBMDx3ther1U9g0n/4bSI/iMOp+yIPa4P3QU/K0o6iDP3xV069BQ/S2LQJ90?=
 =?us-ascii?Q?QI4WUXuxlMqfDEU6H/oZQndGkyRVOs7y9QxHLse8gsWNHklWE+DEwrmxc7zX?=
 =?us-ascii?Q?90YKb3mrQJwnPouiNrgSuz+ymENwsCvMowLcDRooST89Y0exrgR6256BxUG+?=
 =?us-ascii?Q?yaYeX2rTa80GV3bI4LRx0cRwSxRqPcA8CMMX2TIY8UVkpP1ERykngjLKy/Pv?=
 =?us-ascii?Q?Xg1RzZ0zdaaVtitUMa8WElMLqJ9DD3VFIsl+UEFH0gb1DSa+0bBBFlD2/f9t?=
 =?us-ascii?Q?jXgbRpNKaqiz0UpndV/ETfcUM2+c5MrQIxqn3VsmdtFusGj59Xsc1PAA47T0?=
 =?us-ascii?Q?azaI4ltfQcrixViGQJi80KNteWcAPh7sk4n6u9Ln5wKOtPIkqhIwlw76sdQu?=
 =?us-ascii?Q?GVflf8vL5B+ZHMGiGysZS02r57N6fvrbcCT/slITzY9g4Ria3vMZPezAR9+X?=
 =?us-ascii?Q?GsxJqtqocuIZ6pvqZKOohtf9LZCnZfSNDFW31023yy3F5oGwm0RbhMH4+3yW?=
 =?us-ascii?Q?ugb73kQGX0sXgsYzB/Kws0rl2HfEhUsYBUKqhlfTlDtoLNYpfyxuuJapEs5A?=
 =?us-ascii?Q?ZA23eolI7zXKvNj1Lg+mLnLPWCc62Dw5LyLu939JpiED7jzjjkqb7c6kS5w2?=
 =?us-ascii?Q?WEL6wsDC6epb03EJH8O9BNVrcpMjZjFZnXVGH6myJ/sX3DizWxEqSzVxzzju?=
 =?us-ascii?Q?3XQs47EbG9BZqKvyy5nFq1twWN2/TY0U2CDXMKZoD/QD1ih0/JDukMk9xhTY?=
 =?us-ascii?Q?S7eCy0zSoM0h5Alle86DuwyT9Nlnong=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d900bdd8-1470-4636-fbb2-08df4ba84387
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:17.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6Q4nozNLOtEpgRDsDWMJ249xlE3x+JKlXj1Zyl8Qisi79QA4tbyY9HHnanHTIXw2mMtiNuP4SOE0s55FkY6kecHZ6pNW3PGm9OVCN552JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25087
Content-Type: text/plain; charset="utf-8"

Fail early on settings that would produce an image that does not boot or
that does not protect what the user expects:
- RO_ROOTFS_TYPE =3D "verity": the filesystem is selected by RO_ROOTFS_TYPE=
,
  dm-verity by ROOTFS_CONTAINER_TYPE
- an unsupported ROOTFS_CONTAINER_TYPE
- a leftover VERITY_IMAGE_TYPE
- a leftover SWU_ROOTFS_TYPE =3D "verity"
- secure boot without ROOTFS_CONTAINER_TYPE =3D "verity"

Warn for dm-verity without secure boot. The unified kernel image and the
root hash are unsigned then, so verity only detects accidental
corruption and does not protect against tampering.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 98d66774..945976a3 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -16,6 +16,40 @@ do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build=
"
=20
 WICVARS +=3D "RO_ROOTFS_TYPE ROOTFS_CONTAINER_TYPE IMAGE_FULLNAME"
=20
+python () {
+    if d.getVar('RO_ROOTFS_TYPE') =3D=3D 'verity':
+        bb.fatal("RO_ROOTFS_TYPE selects the filesystem of the read-only "
+                 "rootfs. Use ROOTFS_CONTAINER_TYPE =3D \"verity\" to prot=
ect "
+                 "it with dm-verity.")
+    container =3D d.getVar('ROOTFS_CONTAINER_TYPE') or ''
+    if container not in ('', 'verity'):
+        bb.fatal("Unsupported ROOTFS_CONTAINER_TYPE '%s', supported are "
+                 "'' (none) and 'verity'." % container)
+    if d.getVar('VERITY_IMAGE_TYPE'):
+        bb.fatal("VERITY_IMAGE_TYPE is removed, use ROOTFS_CONTAINER_TYPE =
=3D "
+                 "\"verity\" instead.")
+    # Unexpanded: the default "${ROOTFS_IMAGE_TYPE}" is "verity" for a ver=
ity
+    # container and must not trigger. Only a literal assignment does.
+    if d.getVar('SWU_ROOTFS_TYPE', False) =3D=3D 'verity':
+        bb.fatal("SWU_ROOTFS_TYPE =3D \"verity\" is removed, use "
+                 "ROOTFS_CONTAINER_TYPE =3D \"verity\" instead.")
+    if 'secureboot' in d.getVar('OVERRIDES').split(':') and container !=3D=
 'verity':
+        bb.fatal("Secure boot requires ROOTFS_CONTAINER_TYPE =3D \"verity\=
", "
+                 "otherwise the rootfs of the signed image is not verified=
.")
+}
+
+# Warn at build time: a warning in the anonymous function above is repeate=
d at
+# every parsing step.
+python warn_verity_without_secure_boot() {
+    if d.getVar('ROOTFS_CONTAINER_TYPE') =3D=3D 'verity' \
+            and 'secureboot' not in d.getVar('OVERRIDES').split(':'):
+        bb.warn("dm-verity without secure boot: it only detects accidental=
 "
+                "corruption of the rootfs. The unified kernel image and th=
e "
+                "root hash are unsigned, so there is no protection against=
 "
+                "tampering.")
+}
+do_image_wic[prefuncs] +=3D "warn_verity_without_secure_boot"
+
 WIC_HOME_PARTITION =3D ""
 WIC_HOME_PARTITION:separate-home-part =3D "part /home --source rootfs --ch=
ange-directory=3Dhome --fstype=3Dext4 --label home --align 1024  --size 1G =
--fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0=
f-58904f369524"
=20
--=20
2.47.3

