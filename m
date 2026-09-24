Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C33C98322
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:23 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5788.1790249778074354651
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bmBjnNqL;
 spf=pass (domain: siemens.com, ip: 40.107.162.2, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UctUGMxmPa2Ax19/yMyOqbS0pTkzQgtDo0nT1L5t591Zo6/IJSm10jRz6/YkZW5NoLkQY0nqmVffjYGZKCs87Ci9dfShLl5RlyBdkqC/bVCzsPfIPHPiDavNPhHj5ooEocJoipDhl+gap6ylAMW+zJhjg6vWvPOZb/MxsCuNRvNF/3UJ4A2Z6n98h49T0fTT2P/3iZaZZH996/xwwP18AYF4LiH650VVoeh1sU11TP0X35fGWHFvJvaA9uqlRffa80j1wH6W9S47rwL9KBuY/CT9EwtZ7RwcAvz5wOrmpKzca6S2az3ItmxkgHoOet4A8y4bN5/FCRT/fAy/rr98sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywh+sIj0TmsZOkcGedOzRCTaaLO+AyumuaqHTWYSv5I=;
 b=yiOELDu5EGzytmxHjLHce7y2HbzccEl6Gk/VhUqD5kBtn9JGMe6aFvXKG7rQEG7SDpYSonNaHbMvb9srTwLndi5cRT3Zuefegtnx1Epu2TtfbYFYPKDKKjoSIWdcdPYUDpOu/k82JCrzN19BVRxOU6zGm2Vaf8krxZMI3JF0gjmPcxLyhO/J6nm5320nNg11BFHDqwbycuMsVdKbrYs5TlFFnTw+NemUQiDSuzYebCNoF1c8OLvIThBmmW+NPzsIm4D4DlMAjSQOvkUFJPEh8Vk/9j/yJZNXHCJV/tCVHlkF/KTGAibLNW2UAGdSaG/UCqR+kvay4KQyDnI3xcWOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywh+sIj0TmsZOkcGedOzRCTaaLO+AyumuaqHTWYSv5I=;
 b=bmBjnNqLn+peCFNhSpVFHkY4TPEdho6iV5j9Ncl7VNudPqmt3BP7bZxtMUzVoSzMrMRUpooVjqNltfIrs975Djvgdq1hWjbjNM4hpJpUbXs2hrncBCMw2j9xx6EEu087A/EiC7TvXAooOf4Re0zbepd6DbSMCjfWudalYma56D2tjyr5L0kVsPg7q3Y7zb/IShV58qi0ljvnXhOefCuLD3mYg7qE5CO68FNdi237XpIgFOCJ2TQkMhiXKsosiMwM+C/Py5PBLakY0HsojSDKYzof/Zj59BRBgusaVip9i4FJXBdgKE2ma4kTzME+UsggX32hcNPrwezWABaMCKMyng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:10 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:10 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 07/13] Apply hardening configuration to the kernel
Date: Thu, 24 Sep 2026 13:35:07 +0200
Message-ID: <20260924113557.3191996-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 829a5bad-6e28-4478-82e5-08df1a3006af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	d6RtnPP8HmwZsMji3+v6IorMRJkGSnuZvPYgM0Iv2flg2VVSVi0MwW9gOKsogIm7TQdso4QfApSfzZScyWjZQlNPOioqVX8HM3QyBnnRbF5bDSFX5PnU7NrN+zuCdpJg39wgfRkctxOaFHlX813ZoYUjOk4CxmZKfi0sle14n3XgMDobKkbgyoIKwzN2Y5UYi4CHmIxUJH19JwFrzczkx+hthJCzbamFhjIyhcV6jz4JpbfsSahOpOog3D0ul2wH0xionNMgmySogSQnJcJ6pblREVw5JSvT8hGGnlm0ZD61XswXg88F8PMxFYes/RtnY/RrhurZWZA2947x4KLz9za/61iSolVMYn5blVBllQp+RFWevdf/KUnq+wQEYuPFXQBvNI9EmvFew4U9B2MOmfGxSnBaCkE6NuU8wkJGylVk+z1lv5xQ1EiWcUffcb/xwuuQtlZq6Vw3W+EWoP9Du//EX5ES0mS0NcS1Fvi3Iwc0EXO0I0giHjGW4pC3fStNZEYI7FFP5/iZPcJxvd0OPOKk7V0YRz58ifAQbkSet7GHo2rfPT76qOS38gIHXuVgScnEvT9ulLG02EUIfwJUcMJM6jW8DgoXrpYm0mHFtSuikSuEQ2ETyg2MR9hSl//l99EdvhnrTB34ib/DWZUsUHpi5zwU49c0whUerdqQHL4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?03mgcziDIjw/Ae7ILXlqgJjwip4otpMt5Fe4nsIqVYFHXyDBA4wmeraJ25Bi?=
 =?us-ascii?Q?7upQcaVwEdOBpeYuF1hNblMqtgWRvvOw6CEYFtLBNJE9vddmnbibMVSVkiQu?=
 =?us-ascii?Q?sX0pCVivW7RCaYjVDWxjR3O5e6Q9Nf15fHH7gwqkdM5kGjYBq2Zw4A8aXUKX?=
 =?us-ascii?Q?WxFMjuT4vDwrvUgaY9rpbWY+C9vgC0TZcZ3yzxt3fJ3kGl9rYFq4lrXzx12c?=
 =?us-ascii?Q?sUZZ9OqNabtRMseFFFX+hd9Diemm/1NrhzizGedI7NnQyQEze7vDeFQjjNsD?=
 =?us-ascii?Q?zYbjoeehj03/zCvrDJestnMPPqu0EWKluQ2fty1Y8b2zNuEL5qK/BGXmdtjl?=
 =?us-ascii?Q?k4G7uQZYEOmMAEY8SxUvw4iVI4p6RjbiAxXB99IyGLHA1VreVBpIQHbNDZ+o?=
 =?us-ascii?Q?pficZ12ELRrMdYMd4cJwr3torBXoC5ToDqR0lOc350Yx/EPofrrK+7xhU2tx?=
 =?us-ascii?Q?6GHLKt+2hiPuo5+FJjRYiFI7YXucSWPatl+h8z0JDl+I+Mgb3y1sIva99M1v?=
 =?us-ascii?Q?KwxfL+k2G+Yg1XA60ubW9xJCO9fGe+32l8RqLg00e/U3l1y+s6AxjodNKW6T?=
 =?us-ascii?Q?fAzfDpxRw2qgPBVlAxcpweGPmIl4S1tyhPxA5GR7rPYKhg1c67lnFMAXhVHz?=
 =?us-ascii?Q?/GFi7Q3dxGiWmHgUoSfccokb5im71i3mzgRaS/k2M0TeD6g6Wwyc/3248sDk?=
 =?us-ascii?Q?DVGK8MipWGSHdmoWcLcp7PvL3cHd753TUSczEo2Hwze5mBpQBke+WMThmxMs?=
 =?us-ascii?Q?dKAPx9Tg1JTF7SvMV1vIQ5dreHkL+3GNaFm9ft5ZKO3arbyBlSWbvsuht2/E?=
 =?us-ascii?Q?WUnK8vC/quqGw9EtxcCi4iefNlxHLtygliU4wDX7nTdX31jVNKY0KLgfTUoN?=
 =?us-ascii?Q?NjDsyAVxrT0MSfnLKz0dHW7hmiGOIqJSmnoWYabp0r0l+aL+jVzxCrbAtxGW?=
 =?us-ascii?Q?tdptkpvCMIA+9v7GbZqETnnbvAU4X3NYRpNPp5YY1BnSDSHuYx+SR1MtEs2j?=
 =?us-ascii?Q?aZ7Y6e5YRKCY5tKMq6d2Xgu/KAUNLbpcZGNUUOx85Fow3dn1In6Nc0UwPF5y?=
 =?us-ascii?Q?IGdmy/dFQ44woTApRetb9UirpS0rbv22BeDSBM2vxapud27sMGfGqEKM0Uad?=
 =?us-ascii?Q?vK1fNGbEClP1mY9YX2jKt3mmW6RJgyig0B/Zz1BenWr2kbkk5i9w4DPDADAD?=
 =?us-ascii?Q?z+JSRCGvLlu101jq8csZXqryqW6saL5kcUMr+X/7ahl3PaSv0rq+RSXCsisO?=
 =?us-ascii?Q?blkZSRz5CxEY7uwc+XxZHgdx2Jc+fB+vaxFB2vKCiYVP5ohMQ1v5Ao3SA2F8?=
 =?us-ascii?Q?WB7t0J0YlWktYPZQ33ns3njoSb2I5vLguKaQ3HxtGjVeFtGBCdxI77t3uYRl?=
 =?us-ascii?Q?HTfTV9H5CwNvDkjgBEYgAR6OuM27zPGph/d26LCyX05mxRvOuTz4ZTeOFHSF?=
 =?us-ascii?Q?t/uaFjIvMAfdSBBukzihEWMfJadF1RCpXyxugaP+VoX223HDsWZHXEw1ZqJJ?=
 =?us-ascii?Q?06G9/dngnsjvT49GwchEpdstclWjSc7cAfpawHTuvHs7Z3GEYfTWyUBUhKsk?=
 =?us-ascii?Q?TUBb1m7I+/olOGKx/ewp9S1Og4ogaSILoHEcI4Ky4W6X3Ld0pKGi1nWEOFwG?=
 =?us-ascii?Q?DA/nBgkN33/nHu7uFT5rlE8Ng62BdCt3FuVLywgmu0m8PPWcmqQihQQG71Ah?=
 =?us-ascii?Q?9YG2zfu2yr+/iWQ27CKXVVvJs2UAIBkdjwY4RJAOqheRmOfB2feF/fRfQBpg?=
 =?us-ascii?Q?NqPEfGXSsTLnzj8N8k+Xd1yUJ1yFk/8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829a5bad-6e28-4478-82e5-08df1a3006af
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:08.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9Z1vsYICbzjlHGkq+VQdlvmUgDcTi1pnuPX4L01BI1SgeA7UJpR7i3w2atEltCspSUwO96xSpcxtibSI5f9V2N/rsAyjEgCcP+XscuyvWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24319

Use the provided kernel hardening configuration options in the kernel
build.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/kernel-hardening.inc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc

diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/lin=
ux/kernel-hardening.inc
new file mode 100644
index 00000000..9ad8f080
--- /dev/null
+++ b/recipes-kernel/linux/kernel-hardening.inc
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+OVERRIDES:append =3D "${@':kernel-hardening' if bb.utils.to_boolean(d.getV=
ar('CIP_CIS_HARDENING')) else ''}"
+
+KERNEL_CONFIG_FRAGMENTS:append:kernel-hardening =3D " hardening.kernel.cfg=
"
+
+do_dpkg_source[depends] +=3D "${@'cip-cis-rules-config:do_deploy_hardening=
' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+
+do_dpkg_source:prepend:kernel-hardening() {
+    cp ${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_KCONFIG} ${WORKDIR}/hardeni=
ng.kernel.cfg
+}
--=20
2.55.0


