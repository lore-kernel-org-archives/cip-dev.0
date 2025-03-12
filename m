Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF6EC35FF5
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.57])
 by mx.groups.io with SMTP id smtpd.web10.34486.1741778805784328805
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oWFu7ATs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQGa11JWsAqnSHhAjHmAEwzBKha7ho8I4ZPjJ9os+NxdSFOauLopeZCe8mtfKur9AsYz7pMs7hBmEQplD4Rk93HPnFBeMnQQtps+cIl+Az+IQ0uP0lq3OGFg8uAJm8FbVSjt32mOIHwlf9CKDXxyCQ7C2/klaOTXvt/NTT8ze2YNw/ZmOMgLeEDJ+AWZdlTy97EjSKaRWP44VnXOJ3HF400bI7lkkHcZoCUgn9en+3WcJEw+KwntYD/6BN2qCSRkkFIBJpVVbGSMcl5PDjaWqa/VkkChINUfCytCU6lQFb1P+XHF++CY28b9WobBz3Cu/r85lpYIGMlDHou7/H674w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj1XaNqK2isYDmQ3LHO31LlzdDHdeoYKG0TcVSblCC0=;
 b=T+Mf/Y5C4VkZXl3bF4w69q8ZAPDuS9ducpiV8QH20aEJ/XVXw+Dhhp0pBjxdrh7uaoruRq9oYhYos9jPGUzippEoMut1NQWq000OGG40167BQBjik17/mUFybEbME9j+AkY6nQfOC6a62kkHTmYum+hGuIdSCPgRgYrf6TQv7fsGn8ocfq+6Cr/o0mXZYtbEuD0rnzuT9RbQTNK7Z3iJyEsTl8WTDlmep2g/Kj65q2jULcN6nsUH4qfV41XL3cyFzltS37iRW6VgPfy9/FprI449VoO/aeY5Unvr2HN/V2LAlYSWEK+jS04bH9aOSzyCNUTohcdgAM3UMgBrwy5AoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj1XaNqK2isYDmQ3LHO31LlzdDHdeoYKG0TcVSblCC0=;
 b=oWFu7ATs8OkVkFWXgSXFfwL0GutxTnj/IsZEnmFKIHtVWScNRMFXPsRjYaeQs7WsieEwmfxNmQAw1a6g5M6YU/VofU+WtOv9QBIJ30qrI+7UZQE5wXPueiH510+pmNxRxAur91IoHAC60rzgEWzBrmn+5n73aR13Wj0XcTAZM/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:44 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 64/85] arm64: dts: renesas: r9a09g047: Add pincontrol node
Date: Wed, 12 Mar 2025 12:22:41 +0100
Message-ID: <20250312112302.1605750-65-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 68972cc3-46f2-47a5-f9c4-08dd6158c45e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yXotbaMZm8Is2Yx5kgqaGqoBJ6conjBAgBfyAGHVgPmM5xH3i7BUqsabbljv?=
 =?us-ascii?Q?5YdDvp3rfzJlR3NHdHJnrSazb7dP4cFU8VlrmktJ+n8jKaS/Gb+MxfFZLAPN?=
 =?us-ascii?Q?LcRzRoBRYD/Jn0u113zXADeHLVE7x1+1GuqkWUtcRppb5LDnhoFQ75V8Htmk?=
 =?us-ascii?Q?ev3Bjh+vXX6CYBm37tLfbxyJpLgcV05L9gwbfNbWT4wESybS+mR6LD2oCoGr?=
 =?us-ascii?Q?vO7AXhnKVdhgaFDmwZeQI3rkho5lYMmp1APVoI1j3bCCk03HJg4SvAWC5UuZ?=
 =?us-ascii?Q?T/TjKp8hHskBk4yKZ7/PAGlFie2E2xxBvB/rDH/bYmSCgdxz96OH/rVQoBw5?=
 =?us-ascii?Q?eBAypFsnNHG3qALz20i/dzwtZOPBqt9YmNWEsZA0IdJkKgfhOtHaKx/v/5Mn?=
 =?us-ascii?Q?WialByq4rpd/g9JL9B8pYme1CCZgj/h7bXaYqetofIHv0W4b0YzKGTGTWDwT?=
 =?us-ascii?Q?rmk/OC8P13KVkFGTnae11/+PzOAbnBoGVWrKvjyhVV51pBIZHw5+rDTawx8/?=
 =?us-ascii?Q?PAU4qQx7/FIV6fyWpQrNC8E0N1jeAhYGrMEaeDVou06/zoMzF4af8wgAB4Iu?=
 =?us-ascii?Q?RokNRlzJG1wlNPHL06BxOtCey4IpzjQ4X6DR/FWoZySUjiEmnOfgCgo3k5I6?=
 =?us-ascii?Q?9vB/9m8sBe3mlPuhNU9RCi/RTZnx4EQyoKs9o/cFbI8xJskVc6KVokG/sl/K?=
 =?us-ascii?Q?lXqwquPTDsYISfYjLSaGEcm+pqGfi9ENNspGbAGpHu/6U9n96W3v0hVU+qLY?=
 =?us-ascii?Q?NvxGNRR1LsW5mWEySHF2kMYQ8SfjLES7rtUsR/sDSxQYXfO2PqEP2ipaRK/K?=
 =?us-ascii?Q?73fvREcCqHBjy68lk46kb7+cAjjciQ/KQQzaS4C3IBO3J7DYyc7KN+7HkY6V?=
 =?us-ascii?Q?VCW8tHFPUG2vTCAUNdmtOGhddkcDAxd5GDFTR9CfGAWHMwNP4T+q4wHMGoCe?=
 =?us-ascii?Q?CyKr2Fcpe9y+aReWsnfaWSGRxuZQ54Dt/j296G5SEa5unMlXRRHtcgUed1Tv?=
 =?us-ascii?Q?I1++tYnh/FM4Gee0q8lx7MjLl59lRsTbvAfMir14OriqSGbREXML2cbNDIKt?=
 =?us-ascii?Q?vFGMlLt/Hzyyrdxfrdz4ht1yLhEjUEDnIQZdN4RxwFOkyqBYFqrYTzguMQD1?=
 =?us-ascii?Q?JF1l+FdpHxfwAYDK89b1X6zx5vJxYDondW2915NSWRexr2IJegOLwOOZ8Vsn?=
 =?us-ascii?Q?kC7W89kgkWNsI4f23BL7uJPnS+U/EThQdqla1zt52IqjY1CUio7jv7AOASns?=
 =?us-ascii?Q?DrFCNj+Dlhr0V33Wcl21CgYkH2Oy6Mdg7vb5pTiX2dD4V/Nmh+l+yXda6mlg?=
 =?us-ascii?Q?oLonhjzLVomorrLKgGSd66Pufo7TxiWvOAC0NiDsViuARVLeCrSaEuAXaLCm?=
 =?us-ascii?Q?+vYhYCMUmviLM/WB8zmIMEIjdpNRY5GDk/luAwyWg6eIvnp88jROUVm9zNmm?=
 =?us-ascii?Q?WkpQPM3zXa+hk4f81wlSEpJwZQ/Dna+3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Jc7gUtTs6QAD1MVyqsQXocFYVXGtiNtc7UYimFxtCzLaKtBnjBGZ+bd/s2Mb?=
 =?us-ascii?Q?ad9dtGYM8glzbnfOlCzFXbfYtyLIDCF1BSOqcLk2fsZshV68nCULD6Q7n197?=
 =?us-ascii?Q?D9Gi+31k1P+BRopPohLIFRw+4y/3AHdhmEErsD4vSt7iLwZduZzBYfp3wBvA?=
 =?us-ascii?Q?02/UjSJIl9yQSmZ9giZXZ0M3o93PthjCgDzsUsr65GQUcpjM0e+MLUBP2r9I?=
 =?us-ascii?Q?e+9VGcthh4S3CcKQIQHXrxypsguZ3wt5wxs80ICpIiAL315te3J9J5nXlgUD?=
 =?us-ascii?Q?dTnxG/QIXlJMpAH5Vrv7qXtZ54VUw6zoKwyYimbHejfEPHbDJwuwKDI3476E?=
 =?us-ascii?Q?6N0wLhukF2dG1K7E7h2t5+EGDHzr2rxEpVOGU2HRLhexCSecuYpzTGf7oit3?=
 =?us-ascii?Q?vV4xreRl4PeMtOdCY2JGt1z9BDXxjSFtpntfqpvMIG0WP0MQXdfzu5DWGIHJ?=
 =?us-ascii?Q?6+Kj6hD1+VfjOj2AAsH+TxIgAE7AUFftKkB0enS0trJB95CFU4GBxkrkIE9G?=
 =?us-ascii?Q?HD7VkFJj4ZOtgAcIcqaGMs6cX2XRCFGt3jJzN3cavN9rSoNmrepCqmrsjCQS?=
 =?us-ascii?Q?3pyS8Ec5lyuTkD67uO9+Mvk2IeAEXzHPvqIwLB2XUbygG+vaFVvRVn2Ftsoe?=
 =?us-ascii?Q?Ykv1UOsQjQPix4jgJ6iMj+r5HH3EanjaXss7sD/PZ7/CCX3ICphRNJzp7Q6o?=
 =?us-ascii?Q?ehwpyxitxlXki9uRcjRNY90nUpqHb5MJ14pRghxvyPbdy91bdks3kuMYjSNF?=
 =?us-ascii?Q?x581jD/dL2G06+Gj8Lki3EpbuymwBgNoVwRqe5pWs05COgO3mH4ncwLxUc9O?=
 =?us-ascii?Q?yzOIbu13dBT9302mSp1r5mtQXq06VUcsaE78aPsxhE2AUUgSk4WCpMkJcY6r?=
 =?us-ascii?Q?zDK7MbRECpAJ7g84EUqi2arnOApM++Nt3m57HQS3t32ZvyAcQTPYTX/IZNxP?=
 =?us-ascii?Q?DnmFqofiQXmK+Dn+pWHRw80eW2mCHAcRnZFddmx51pdYT9jik+zxNG85yqgN?=
 =?us-ascii?Q?1q5Bq5DUtyuy5pi0o4eRzKMMS+Isbru5+J5EREYVX0x6YTDrLDZ11cHeoODt?=
 =?us-ascii?Q?CUu7EAnms9FE2OfyFTnZ2zw/DbqLAHL0l+GRncQesrSG/6+8OQaWggXViiQU?=
 =?us-ascii?Q?iBbKEXR5I9dnC6H/CUdWJNhUnnDzXmdiQPpJAVyZKhO+TIjmzcMe78kibCFe?=
 =?us-ascii?Q?mxc8wspNGliwNASMID21o8E4GOlc5QQUyanJ0WO0zYCT2kPDPjNGd/bQAdW4?=
 =?us-ascii?Q?bJRMZC8qMpvRgwYcmxoiY+n7djaln8T5hbvvu8hhDp0mNtJ2TKJLEZzMW9CU?=
 =?us-ascii?Q?GhLSv0/dUK5a3lLiPbgyvGgvl4n5ybpaCkm3L1IVKK07+ssWY4+cXrCnSb7b?=
 =?us-ascii?Q?Pq4qBTRi9oxqN884cYnERCR1nLm4h5WSFmB2NFnTkP7BhHoZPaXGuyYQSNwv?=
 =?us-ascii?Q?jQWzstnRN7PKX+yZqne3qUefn1axXcgo9FIofjtpRzFx+KjRARY6D3x6u7ZS?=
 =?us-ascii?Q?9vNFi+ruJqDEtFXCS3UtJjMtLalPVcLicA4WZgr+MUEKfw2BZWJSKjGmud2k?=
 =?us-ascii?Q?+WvgklOC26aogd3buxgi3sELoUBvXNu1ECeTqMnLw8BteV5sj7v9NkWgLzlK?=
 =?us-ascii?Q?JEKRkqy/MmKVwDGj1P/vpbM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68972cc3-46f2-47a5-f9c4-08dd6158c45e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:43.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRy/ANSRfTbMyKLAQemJ1/IEFPZWyooKjx3fKReXN8OLaMcjhOiMiQz4m2psiBXbVPqkKEvCVnUweWkQtgz93htRXaomPkSH4mL/Po0AyjeyPG76Zr/vTu+jO7SZuZzP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18156

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 987040d4601e98e32c53837ef76aad115c4966f7 upstream.

Add pincontrol node to RZ/G3E ("R9A09G047") SoC DTSI.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241216195325.164212-7-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 39a7cfb3095b..15711f9b6038 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -131,6 +131,19 @@ soc: soc {
 		#size-cells =3D <2>;
 		ranges;
=20
+		pinctrl: pinctrl@10410000 {
+			compatible =3D "renesas,r9a09g047-pinctrl";
+			reg =3D <0 0x10410000 0 0x10000>;
+			clocks =3D <&cpg CPG_CORE R9A09G047_IOTOP_0_SHCLK>;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+			gpio-ranges =3D <&pinctrl 0 0 232>;
+			#interrupt-cells =3D <2>;
+			interrupt-controller;
+			power-domains =3D <&cpg>;
+			resets =3D <&cpg 0xa5>, <&cpg 0xa6>;
+		};
+
 		cpg: clock-controller@10420000 {
 			compatible =3D "renesas,r9a09g047-cpg";
 			reg =3D <0 0x10420000 0 0x10000>;
--=20
2.43.0


