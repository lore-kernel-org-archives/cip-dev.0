Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15681.1794914933922263860
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XeEtoO9P;
 spf=pass (domain: siemens.com, ip: 52.101.84.18, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZe0ieFaQ/r+oE1cb6IruMGlsp2uKCT5fNPLabg9x9myBn+iMcmsKs6owSc091Mh8Jh5NCfWibvgYymHh0m27r7yh6bl5sx+BUD7yvwWoJbvlrsPfwmvuEn3fjgN2XEEXb4XNjWmHvSVeFBE0pTPjGx0S9ycEMscM2gU4O5CWrj5KlRn4FAiHVMDKEaPMYupK7Waskxnoo9nyG37IJlVijWt0CY1SmbV2twdhGIWVnB40H9i5Uhfe8gHS7F2ET9kwReRUAIe3tthZ1iVwj+QeROpBaNS9AuVgTGmCRu2Q2x45U6ngJd+nytKiwV+w4Pf9nQAiFc9a1uu2ncLJrf5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLl0Yek/A1w8DTZnwo/XQ9h4QilL5NQOFqhEWIkhEoM=;
 b=vvu34FC5Ik1hzbGzUTQ/7eobNo3RT7xmHp9MBjTk8YODoudQ0WkU7QMdsioTzojmBq9pRQ4cdCJLRy7X4Pr4/Wv9/jf8iUY+80CGGmWxlqxf0eFdGSdSHolTs4DM6O2y9zxKG3TyqDakTYt7P+LoBYWT1w5EUHvAJoWelM32ZJJPB+76SkqFZzkpuvMs1d6m81J+vNkPj/YdDdzVDCjBMR0ilPFiY8rLPvptTfFjxt0FbzjB2dwlYqB8IIE0R5LkkFQOyzJDRdjL6Lrhiw6e6Lj9EWyxH23+PBxGpHJGgSJMXz4XZjsCncvIfsdUwi3Uml/wWrpBm44kTW/yf1Iecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLl0Yek/A1w8DTZnwo/XQ9h4QilL5NQOFqhEWIkhEoM=;
 b=XeEtoO9Puv95+tA5M2BI9/IdyhTarVeStOQusnHVtoVVOdKLro2V6MIhidUC90v/PS9gkP0yiU67E3Ew1NSQcUTM/Ge2fCnQUMoMz0PmwEwv6NJidNLycmc2QlqKEyIjzauA2+/ldKmGC/lXtkfBTbRy4yquVlAS88PKqPE92miub+IssNUIhxwQwJ4X07wXXGSaEyZwtpD5TAdaYom3Laq+ivLuiRhZfMXcGHjBQyeOLvnS58NYjlsv5Jwvpvw8O0fhAhsjW/dxINxX5LOLhjs7XZ2JCdLKLU5T9dLtmaW6QRpL8hZIpFxabiLi5KRVgA0FeVcNCnGl5aDtLcDsWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:44 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:44 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 06/19] read-only-rootfs: check ROOTFS_CONTAINER_TYPE and secure boot settings
Date: Tue, 17 Nov 2026 12:28:20 +0100
Message-ID: <20261117112833.316234-7-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc48e5b-e745-4931-4e02-08df449defb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261022115727099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: AElYQlTjMu+IQZVdHRTdnzSFb9nWqt9EromygZ1UT9Vw/VoLBPFU+31bCvcGHjzWt7Rx/R2Y7RX3MlTlVCJnZjbc3oUjSxMbsp4lak6ZcQhixq1ysBlwK4YTuLigjaQqBbXnRlmgHLzeQillL6i2Xd+OdMkoX5XGhVX6NcfspGSFTNdTeRijLRVhNdg8FnF+OszIay5PiF3XIZ1lvY63iWbxvd+/YcxJtJ2F4zGwWb6PvjbxN9QhRd9SkbJDx8jho3BgBMIqAipgYQi4+K/irmo8BIWQwfUoT0Qky7q8+peTZFb0Vi7AURhluoMzX1EiO4tn6BBmBDkuBnA4bj5hLKWT7cTVC/QxhElMeUgjNJX5862HDJKITceJlvuRM4wT76XJxNWQlOiuEtlXXNAPBImmz1nX0WvRJJ4zGe4v9CLrMoYLIm2PtIiCQc3C+87LH/sCasuP+4DJkiSYPfqUjVBpZ2eI9m72Sx3fV034W1TXuzmcl3N8/mGbxMobX799AbWuduXz+Sz6H1Z0JafXu6ehDWfkOIf8/fd/gXN9L2p1bazihqu1OrU/wAit58A6zv4opJZyDmV1i9hOyRZw1RTf0BDZdv6gF51JLReN3z2FiYsvA5nYX7TOgN0tAhgJyz0N/3wiQntYYa0dwIgzCYDrrYGyWXYfavGDDylA0to=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261022115727099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6HesK4tOhj44/rzqe3+mHTh/0xBAcSk7z1qjiTLsaBOMlOQtYx2bTIAR9LkM?=
 =?us-ascii?Q?roVdglfHXt6Am1bdbEP/dYkL0gaHjec23Lfi6JBYi1WO+V19JWRi+AFpxrgb?=
 =?us-ascii?Q?pzeLiYZgKsR973fhgJV2JA3vgtk/Pbn5yXtuVCMniSjDeyvBU9YF9m6NTUHH?=
 =?us-ascii?Q?ljvw+9EHU9r2Iiws05yqFGRA0GfBOe/oJ3gQBKDmC7QjC3zV61Cl4aKCCUL1?=
 =?us-ascii?Q?9fZfVgEkfgqHLsv63+OF4hv6U7m66EwKbnv0r4K4Hvwcf+ux/UbKdXfjAnrC?=
 =?us-ascii?Q?VuMfxwsfuyHB3Q65EUo0gD+8Maa880GVsjjSDeUqSkk9WTDFuTOyG193S9uo?=
 =?us-ascii?Q?4yvGYsYRGid4GQhR+wo0YRJ8YbB+iWj0CLmnlTdaHQBh2cwe/mlmvINXtJHi?=
 =?us-ascii?Q?ToE1DizMI5ya5DO/D7woKmVwotzc5LS4MiMSuehpf7are4ol+bhEtql9/72J?=
 =?us-ascii?Q?PO8DGQkYZbYQDKUvUpKC8sNmjT/iKBO/u4ztwbX1XdxCs0pWJkTtuqMaQRfS?=
 =?us-ascii?Q?HKtRzyqpPUzcnaS7+VK3hM3ZTUmOG+gU3q1yATpxuB8sIhJUPZGb6ijGyR7U?=
 =?us-ascii?Q?z4OgzXfG4PBzoArGpfKc25jrT/3w3kjqczkc7+2G4XwlMaqgn/V9KDGm+B0O?=
 =?us-ascii?Q?zWSU/sOWjhnJcXe4TXaW0GIK8HA/0XNBfCW8gkocz6t11JzM3Lie02N6/cLz?=
 =?us-ascii?Q?EGslmolffIeLfDkZcL/IwJHskCLCMUZz26paSrmw80AqD1k/KAJHya1U1YsR?=
 =?us-ascii?Q?yg1HtKUXlzmrJDl0iQ+7LKzk+MQMDsCm99gH+pGvpz/zWak9SkH7iZEchLBr?=
 =?us-ascii?Q?HaAmPWvUPn1MFMwiWIptY0qoBeu14STKHG/SR9w2kzGRxrfg+saHpL/oe3a1?=
 =?us-ascii?Q?jJiwlCwLhgM9A85k1A5y/xfp9Yb2RxvtBWVwuLh4ynSQbDf65skuup47MGBo?=
 =?us-ascii?Q?XqVfjH6wbewzSy8jmhqQ7egmjzzDeGawT/TOHbSYQCa5/6sNB5vj4uYXd0w1?=
 =?us-ascii?Q?mi482YTpDxiiSH7RHiYuQ9GP39STUBX+tF/WsUSqAvXyFJfOmaGE/WV78t5J?=
 =?us-ascii?Q?WFB2FVMdp/GvisIvpPdn0LeX6uEHouqbzX42kgQf7vC8x54KG7nZ5QzDm2YL?=
 =?us-ascii?Q?tX/EM+Taailh4ic3i31cWhF1TxfvFQDirjLmcxWydsrVtB4IWzt9ZHzOKYSP?=
 =?us-ascii?Q?Kps31CwmHBj28zXB6PRLIPpKhSnV+XLG1VQl7YtIQjkuiAyXfVq4igX9XDpB?=
 =?us-ascii?Q?/LZsU3cq+rsLtpbY1NzVUZvE5SmTzWivVCTff5awpTSBNmWlvBurbi55ewYX?=
 =?us-ascii?Q?UGa+1pvQ0DtGUmzeroVYxCaVBT8k70CkIIDNa4ZrmyLJKsrGGk9ZKxr2/kXI?=
 =?us-ascii?Q?mdtOV1a9LqPMTtJB3QgEI3uDNdVS0Y5rqyeqJBGZvMHnM2Rci9aXAFlMs8MC?=
 =?us-ascii?Q?1lOFAutbuFVrkk1+Rnn3f2zSq+AnrKz2oxLKZ1YLjxhsi0ieEVK9nijn1jzW?=
 =?us-ascii?Q?3cAv9IZA4xj03E1O+YpeQGDRm8t/SQLSfnLXoarjQFv2LKsKS/RCjDvJ1d4i?=
 =?us-ascii?Q?EpUnaW0iCOdLb5RUozJqfKayI/YJMk7XThqKoZZbncbLqUqfCYfdifuAcjjw?=
 =?us-ascii?Q?Nx412SWiJiRs+uIj33TxpI3M0NF555WhjruaDkvObr8K2hclajyvd6pXAC1c?=
 =?us-ascii?Q?2t62I12uweOXKNIeDbV8JrMvq6AtOGUTvWV1Ge3RE10IIfC7OElSkF5t+r8k?=
 =?us-ascii?Q?C5M+SuOvXgfYcbLatDe0f3O09RPhR/4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc48e5b-e745-4931-4e02-08df449defb5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:43.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EY5hmd5NOzh5ybIFF4tJfnIOQG9W5oytXSHhnHMKsSeyhD6vnl6PvKDJyH4ozik+CL6UQ4y6OYxyU3o6mOEtSYGLosZx2k4i0oPsYU9jCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24828
Content-Type: text/plain; charset="utf-8"

Fail early on settings that would produce an image that does not boot or
that does not protect what the user expects:
- RO_ROOTFS_TYPE =3D "verity": the filesystem is selected by RO_ROOTFS_TYPE=
,
  dm-verity by ROOTFS_CONTAINER_TYPE
- an unsupported ROOTFS_CONTAINER_TYPE

Warn for dm-verity without secure boot. The unified kernel image and the
root hash are unsigned then, so verity only detects accidental
corruption and does not protect against tampering.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 98d66774..c280ea23 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -16,6 +16,29 @@ do_image_wic[depends] +=3D "${INITRAMFS_RECIPE}:do_build=
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

