Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BEC5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:40 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13124.1787564859150375495
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nSyJzttK;
 spf=pass (domain: siemens.com, ip: 52.101.65.26, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puWvqywjBPG9Mthr6UNYX018nGH9W5dhD6i+Yhxbhf03x4uguKDQnuXBJ2ZFqLGHd4kgw4ogm0igcZR3UM/l6kDRazv/bSnKTczKsqX4KaT9TALq6dA/ntvy6KHX9af9LLXpeDamjT86oXyS5qmLNk5Vq+S7iO5as0lZwwXHf/cVZ5WNF586Jtgm1+pXAKh2MI4WetlNpv5NIT9P50S4aT3nIfhmDCJq7Z4FGFkGmBY8Uxse9b55tNLATghAOzO5B8nBIFuOTundnyZIOs6g4zZfQMtj7pzNUc4cq3NEm8F2j4zHTRgz3EDbrmkSBYj4ZtPYPXQOLL1fLIswiBOuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OorSbSGAtn0nHqam8D05hJMcJcwKQFehxU7TvWbNUxU=;
 b=kxvovw9I8vAhMw0ed3bbxSXTpKjoAq2ZPc/aw4jYVGW0YFod+FwprDCjDPBXvv+JMeUe5U48O5RE8tZx+mbyxzwaU/5+/x1+Y9Ial4/+SAmojJylpn8ga8YtD8KQmNwFCn8BZ1QmewAg0pz2iuVY46z5RbQ/e9FdkncalU/jPu/X6vUqjLsM4N+LPv4P+rIUaKAHrUN0EJcz63RpXQ+rbpNPQFI/fx4reGUxCv7i5/Q5r73Qepe82i09VFNLrp3BpRARofJsg0FPDP6pknyw0DR7GgF13Xw3U33ZbBghliYl9BIt5fQXNjZ2BzV3oNGlCDMXRF9MATJoyChYlkloyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OorSbSGAtn0nHqam8D05hJMcJcwKQFehxU7TvWbNUxU=;
 b=nSyJzttKWTaFfrP3vQqM5jU+HaawjnA+R8yIEQb8YB0CGQP1fYq9MXkkK4SrYUKjqXP34hM06OrQVCIAefzc+DqjuaEuiRJ1F8HnJZF3e9ofTc/2XNDcn9tuTCZsQnh55oA2qhR/uVHjmDYJeB32tlsBbsSSGgIIfDAIB0fhsTjpYoixM0QPgcUhRyLzw8pYEVjN3sNPNfhUHw+BhlDsSGQLRei1EqRc0nzIkjd34EhVb4HEoh+f1oOZ09GNdiuySxByF6B/OmjVe6OY666V/0qFN0vCH5r5DXMV8KXjDW6HxMbOjsGJX3UyiGB7D9ExWhSmF8KYTt6oekJ175qXjQ==
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
Subject: [cip-dev][isar-cip-core][PATCH v3 06/12] Apply hardening configuration to the kernel
Date: Mon, 24 Aug 2026 11:46:43 +0200
Message-ID: <20260824094721.2636375-7-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6059f40a-35a2-490b-22c8-08df01c4b953
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|6133799003|3023799007|55112099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	vH/KQrFXoTekURZMbxclrx4LsS/p5HE6QC/K7x/MsTWLBXX4GUFD8c8nW3exs0ypsas2awiGsB93IlvpcwvzEmJ2qMQZ/uOOkhYx8lGBuIntnQRbmQ/EPv0D0U+mPNXCOZVorj9yj16quDxLc+SkXBvR/87F9F3lf7uXOVfphGqTlHvM5bdT19WwXJAfwqe+CeDUVT138JWyTmAH3HZh5B7zIFqF0sV6929tA9X6EA2Tl0gSB1p0xwcQ/9K5drHWMbQiRDZ7I1UtEFfSCd34Eaoo/IH4YTggCXx6DSftCzVYl1oZ+7G8NYbJ4f+/zKetY6opvTBpM/RnXr5XpiSq75jrIGTGr1vQbVnxrh0SXbWiz66xWxD3XBfUb1fvGKF2RvJbyAMunL+IQBPhWNrJ8I3gKirsoG45rHyTA/U59tLq9lyWNMKroF8nK+YzpMGBaAsbmrc8TC0F+UK8u3ciL8hFBT6sn1E8kGXz3dJRb7caXYYWA2z8JT+dSegxqqyo6Zx+H5x3KsyTVcnscQXViMjLkwb7nnEKO09+j1gPtqd2siUH349ZgRua5d+La3RXYz/zsjRSfgozQfTTlaoA93V+CswdmYeAfE2MGyNX+G1TUW8yt3Oy3JyFJ5vAmxWwJcNSJcJgygZMRWmSfp/A1YlBGUFd6hrefaKS3SHHsvo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(55112099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Crjw+ek3NHs+vF54WDJOecoNZt93v8QEQiwYzl+4fDWGhhQ9MtnlMb62KNXf?=
 =?us-ascii?Q?kLWtuoXBGSelzfg5tK/Q67Y+vzw7Gxy91AlQhHdp/ekQCNGdFUvc8lyd7CCc?=
 =?us-ascii?Q?cxhqhUUA+ZXfYb4a9kNH1egDiAbSpB8lDCgDMRDJJZAsEp+Zz6rV5APJzvsm?=
 =?us-ascii?Q?9fjx79pRra04bPPwf7mqWcUcNFTt/NeyJRPgFPQoFsmBEsmn1oTYV+IcrS8n?=
 =?us-ascii?Q?ef/06HociVih54tbwwcOTuCVmRtPf1qxDAVBXfiICwYnpl0r6Pv1kJpIf6Li?=
 =?us-ascii?Q?FNql38ZhyfphtrliQO0HwP1Zl6AyMtbldhjusfaNUHjT6fi1+RO0arfTxSNa?=
 =?us-ascii?Q?Ofca0DMEwUjuNh8TgtfcNGtLm9zqSrjNKsi2wlkNd7TCRMsAWLTT3pHbXyKB?=
 =?us-ascii?Q?GgHlsoOCUbc6qiT+ablm2HcB7sSYUr/Rtqgwb0ikwbD1PMmJOFHUIE2uB24T?=
 =?us-ascii?Q?G0RLQt5UEJ7OaVo4HW7fQduNquo/6ROqUQWi7WlYgGVQUej3ENJCWC15ITPa?=
 =?us-ascii?Q?byGytFp51YRiAXwVKHI4orDWX7/hPKOGAmWmmauav9n3CxVI+W8skdXZujhR?=
 =?us-ascii?Q?2yw0kSfJ32KMCM8uRr0m9jVY4MuNjMXupePtKYR+RifomttrEbZMgFG61Ubi?=
 =?us-ascii?Q?KxvyJL/ix0pzudAu1k4VIFt4Qhr+yFGAiF32hdRXy5zOmA5v1Aicz53xJar+?=
 =?us-ascii?Q?WGmzeliGkUTiZzYmdcSxOkpUJMmmDNsbhX3SrxHtyDTbXLptU96kZc0qksJy?=
 =?us-ascii?Q?zPypLRUdbhDz54b+tOWL8/WyQXiIyy8Tx6Sgthu/KuNFFaCFxb8F4kJz9JpW?=
 =?us-ascii?Q?rHIeaxv3PnmE+vbAVmRRXfwphE72yuTYadgiOEwHnjbO3HQHJ6Bc4xhWrETj?=
 =?us-ascii?Q?9kid8HVSQtkl0+JXp3KNbKJGIfZ4HZiFVh9tD70jf8/KzJYYicfk5woU4Yrp?=
 =?us-ascii?Q?2aMIB8hgBBNFK32/YJLVz06N9j6ueOS57cOElpQRtPba8NXgg8qPlmLfcKPg?=
 =?us-ascii?Q?9FmnPo32l/2SOvQp7ef3ojNaxd2nMUPvehBsVEcG6UxpyEglAlCWdyBz9Ggo?=
 =?us-ascii?Q?+/C8s9rBmdR4RuxIJ8OFfWuW9zOaCvBwnSwU9f5k4RLjzIT2+2IaDpy9jQ0J?=
 =?us-ascii?Q?G+qcWoTRppwut69TTFODmjC+g5VFzeno3YuQCKQaT9eB6mvMRqvOvXd7Wjwj?=
 =?us-ascii?Q?yrvXObkPZCq+7sDO/bWW7QNqmsYU1KAuE8vFMthkqL/yh7muEQxVJHUBzhdL?=
 =?us-ascii?Q?tEvSG/C6u/BMhAKqkjyjXSLsIPx++0LCLzANicA6D6r7mC28XP6s4o0ans1e?=
 =?us-ascii?Q?M8dCLZF9lGzdJ1+h55n0/jqSDl9BYnNRahNYkIJtkxhaASF2RwbWzTaWQIq/?=
 =?us-ascii?Q?xWBgTEtBY3XhOCoYvD5PZeP//21/AlVTpACAYw1Ma247SNLjfLtXBrJKXGjO?=
 =?us-ascii?Q?gg9ovYL7ZItNRITYglk30DhKyuVPyqbZPF6D6kRDAFSh71gAo5529lKFFtLd?=
 =?us-ascii?Q?6gfIG7IDpMYrUktVCweMIFxMhPKnM4lSw+GdiPqoxeSwuQjZsuJNIb6xRip7?=
 =?us-ascii?Q?tUYSMZ3oCXVAtZOZBABYCWWQ13RSrS/v0TvSl+2ZLoPmdBJnibLRMWZUP3LF?=
 =?us-ascii?Q?aEKyvLgFbIXkZIVVeRyC6pbvj++YC6l1HU/EdHpvdRLnNYYoNxXrtZaezerC?=
 =?us-ascii?Q?JESbu8+TpkjVi5d+ifs4PYJ+fq7ycNv6ndSUgIZhq+TjVg9URaN03WQT/9QA?=
 =?us-ascii?Q?4UCe3ulCfYAg/RbpDoE4XKC25QQPQp4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6059f40a-35a2-490b-22c8-08df01c4b953
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:34.6463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aesmMT3BUJL2HEcyIN1cAHc5WUoDs0+bJCVT0y0a0SgmMoGTZIruFZR7mWJb7Zdsqa4C63Nap6wU+XXz4htUN0BrH9MNne2Hccmux4rUJjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23987

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
index 00000000..2b22fca4
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
+OVERRIDES:append =3D "${@'kernel-hardening' if bb.utils.to_boolean(d.getVa=
r('CIP_CIS_HARDENING')) else ''}"
+
+KERNEL_CONFIG_FRAGMENTS:kernel-hardening +=3D "hardening.kernel.cfg"
+
+do_dpkg_source[depends] +=3D "${@'cip-cis-rules-config:do_deploy_hardening=
' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+
+do_dpkg_source:prepend:kernel-hardening() {
+    cp ${DEPLOY_DIR_IMAGE}/${DISTRO}-hardening.kernel.cfg ${WORKDIR}/harde=
ning.kernel.cfg
+}
--=20
2.55.0


