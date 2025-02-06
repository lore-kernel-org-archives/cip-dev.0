Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42955C02199
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 12:57:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.44])
 by mx.groups.io with SMTP id smtpd.web10.40015.1738846655605822346
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 04:57:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=xZCjIfJI;
 spf=pass (domain: siemens.com, ip: 40.107.21.44, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obMVZN3j5i61Qn0ylQ7m/bd6Fuh4xZNmXM48qoBRWTCeP1j0R6CeNbosrcGLCT46qb0XgQGZ02UBgQX0eAZubp4tjUesl+q50WDXkQGKWZRz8ldnAgqB/rQQgP+pfZnSLrmHAV0Z0jb4VG4jl9WQqx2lrYz9E0jHPzDVs1lYwkIJUWGPFyYKyLRYHp3ahqaHESZ5yDyJDGCKZYlRO6moQeg+DGBIiw2B55bPq9l8RK8JIHLVWmZNndMwrswp15D0i33wg/vHRd7GWyvOOsj/cgMb5wZoIjBHBqO+1iiIOpt7XaoANJnxbXVKrAcfKewsXWQ00EjF/X1vTIPTJy7gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52tNvzUvlXqQCL3thQgW+A7CiH4qK6NI1aagnQXXbPE=;
 b=N1hK0pnQgr7Up9Qp5EGg/+a8YbeDR4yjkhJ2SS2YsN9ouxIf7qZDoCaaymbBIM8iyPp9T4eamH20jtp+MHv4QF/wwL9dZioyiBFV/t32reKQMr2D3ykgPrlEXJsyyNLGUsu+M2YVCUwqeQjPIB271IpFiIGFCMEkLB30gM/7gboo4y43R4+e+dF+N9+XdrXT/bE+cnC5WRHdAaCU7PVTtro9b7ATQF9UI7SumVaGFiOmBgXvmTjfrxHaNCmETS37Mm1o9Az4JG3v2pcNrzH/ilBersXxw1RHV90nh9/m8CHYuBEeJE0g1hyzDNNuwzsCVmoINgUPeKf0CrFlhZ9lNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52tNvzUvlXqQCL3thQgW+A7CiH4qK6NI1aagnQXXbPE=;
 b=xZCjIfJIEvBraDHiX2hZimz6pTcmpJtIctZoLJmf8pQozV9vFA6gDbshOvbsgnmtjCR5Ui2wPJPr9/Y03/cuxTORfQdR0rPP2IgmuhX51/G1aVEJ5mE/Gh4vIepWIYGYmce7X9q41wKTq/3Rli0I9hOgvqXeAcpHYCFRKrJkrDFOkVos0hOSDXaltyqMSEIv7etxEjzDNBbPlnVsamg/ADbKFopmFbeN0Do4DmbZH6MK6i+i3lREK3q/9y/jsuX3Oe0x8W0WuIPU3+K2E8sxuII4zWyvhhg2+iB+WG5ROS6n9Te/0Jmj+C+WfScxhQw1W5l6jL5cNTJo8SfYVaZEIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA1PR10MB8931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 12:57:33 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 12:57:33 +0000
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [PATCH] cip-kernel-config: Update to latest version
Date: Thu,  6 Feb 2025 13:56:55 +0100
Message-ID: <20250206125655.164793-1-michael.adler@siemens.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|PA1PR10MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: facdb9e4-b4fe-49e3-948a-08dd46add281
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?P9uemu7t7Wi9bu02VabCFryJZrpGktigqcCSKHDbFN+eJGtop40ktpaipZWz?=
 =?us-ascii?Q?E1NTbbL/F9rMkbdK1T1Bbrx61DUZd5bDrt2y6MYe1gk6gEj3beiFGQLhuqOY?=
 =?us-ascii?Q?hHk82WM/LxjdXugvQb2ktzSsAwfWDIMl0WSu9tL1S2Mp3chm8VIax2eIjIRE?=
 =?us-ascii?Q?cFiyN+MRQoANsb1vSqB15a58xx/YfpCgr2CMC+z52cKjHbNoov5xeqr4hrSX?=
 =?us-ascii?Q?MtDNCqwrp1+GlTPEH/n4KJ9bHeVlzZ1ZZxJzGie14RQlMdWE2qjsmiwtwQlb?=
 =?us-ascii?Q?okQOlsatiPZjMBJba1nRaQ5zRt+HOFeDv99LS2SE/DkaWWbw83MOyfRNxnHM?=
 =?us-ascii?Q?qhdKve5W1LDaOXDz3niqL6sky+UPWKREnbLiRftaLAkBh+kJY6EHVopDr60V?=
 =?us-ascii?Q?CXeUE/UhN8WndtdaW8uD44h39wz4zAe6CGd9OOUPxJEX+/GeN4NM1mtLGGSW?=
 =?us-ascii?Q?rVVTeQrWsgi1HvGZRWXfdwYVbj5SkoSLmzG4CLCeVd5R5nBcIN9VmPEDRCzV?=
 =?us-ascii?Q?OmmfPDivWkJ2I2V3cpBN6jPID4KHlfagYt40o1axBJr8nosEeugoiTU4UVnD?=
 =?us-ascii?Q?HKStM8m/x7+JI+JhfTXrhLLPDBCvTjikv2I+Cc5zIRwqeRIKFAMHz5ZqlUSt?=
 =?us-ascii?Q?0VEViiKp/fXgw+LD0ZXW051YXe5JQNSyRWnuEr47iRZH9lUWfwxQ4qNJMm27?=
 =?us-ascii?Q?Ju44PjgauqB83mU9ZHplaOa+Vi2kF8NWRtgyZPN7g9FVwsCMhAhs7B72emoP?=
 =?us-ascii?Q?Hgba++6W39FgrDDjuIGEBvCwA1b3IGnkIWGapViLtHPOYmwsny0l1ji5Rkf3?=
 =?us-ascii?Q?Cx8iCsz5pIhcPP7BvdZUmo102SmTRg4/0rGu45H/MlvMbpksr7Bu3XRVBxUX?=
 =?us-ascii?Q?dUyb7tSYnSxWQ+/OpR6mxCcp37UuPlECdJ6c/tXKLenKVvw5wk5MJvA96VXl?=
 =?us-ascii?Q?LBIP+RubnM2HWHDl93+sJtJCE7yQti7i2n2+cs5ph7DGCKoPQEzEiiZmc5Fh?=
 =?us-ascii?Q?wnXliAq3KGZqBfm+cftncyz+UDyd1m/8hPRX56wYJ5eEUxVK6PWsUW6y69Gg?=
 =?us-ascii?Q?p/nCTm8STdOHFKmWDIRKhLkB3QZ5eGxCRz/ZxANZ4FZljMMDTGFGxZWb7Hl1?=
 =?us-ascii?Q?8CQBP00aVqzV6yU3zy5My0UiUkUTm+bDZCAWYVuFVjUXMFcK87y2guW8pIJX?=
 =?us-ascii?Q?67ZxYB91jL7o5o7pOMBdkYBSzcXXjbTrjauOYT4KixRT+tGKYdVBXxY4y1KO?=
 =?us-ascii?Q?BVevF/GqH2KsqO200jtJTOjm8bXkPnZgclRYb9eBHa1Dd5WbxTb6qNaD+mg9?=
 =?us-ascii?Q?yPCM+DYZU9VTBeqj9pqAbPaNeBwqyM3dd/8ki+JVLVuk/UduSV7C2Q5yRM3d?=
 =?us-ascii?Q?nrxpwVnYYMe/NfO8a/0B/lKBAGc0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tWV3fRcSgdX6h8sBYJE/vtn9hF54OnkxNCnZWKUcZED1jaNqU+NMjRDMbA2S?=
 =?us-ascii?Q?QSTyCTZvOhJpDTqNvgc11pnK2RoxSFgMW/F+y+CLdTLHmyPpbOAeMTGRmFxo?=
 =?us-ascii?Q?nt/1ZwpfV8ipJg8ik35TMlvGsbArOP8v9UWr9Ozkl1q5a+gohV7yuGM+moFw?=
 =?us-ascii?Q?N4AlzGadNMWt3ilsUIjzpMvcTw39RAU7xwF8gVXk0UQpP9BydYpQBEQBn2Mt?=
 =?us-ascii?Q?G9+4bRelcOJ9o+om8VAaJ32MhmurmYgJ7fo1F3BTip411zF0Gsd24Cn8yp0/?=
 =?us-ascii?Q?hZ/0Y5TQJuQsK5F6fTbRnYq9ul1LTxz0wi8DGVPInjpcDMadkXAEmuxDDIku?=
 =?us-ascii?Q?1D1rL0BHrJb6hmIo48tGQkHc/Ig0lq4EpIdbUrFRKref641xNNRGPwluSlIS?=
 =?us-ascii?Q?fJkJlJRTkQ9IeZicGr/DNBwVTtI+IiftTyi5vnwT/t6UL1tmgHEpGN1Z2FAN?=
 =?us-ascii?Q?usFHEUtgwA6dpUtzehAvuGPo7spBmWkAeMVcKjkgZb3ROcK7UMmGMRy3J5FG?=
 =?us-ascii?Q?t2MmOEITsqJQ5uQo3ocmlD9cI/JwWhgRuLsTw4LFiDlYBy7aVah1muDdHg4B?=
 =?us-ascii?Q?Gud4S4hlWA38HdMyBGc6i1DPVU0CelFIeL3KVVPBpQbEmaVqHs0mfdmJ2S4s?=
 =?us-ascii?Q?qJSl0w3VCr3zD7X4ByYFcSo+xvRnNx3y5ayHUgbmLWpPiDGCx/15CixJbQP+?=
 =?us-ascii?Q?08rHj68KvO1P2OxtEEZufl9hgclEyWnwTtl72NkbfdqJXgNMPKAB7apU9sG2?=
 =?us-ascii?Q?U8CJJB+sMezFhJC1FWEJtGGHNh3RkzUEEWUtFj/9mQ+DlWPDQ6K2K4WT6rVe?=
 =?us-ascii?Q?nAFedmCu5eBh+IJjBpJK0udFgtls/kMBHGCBNYztVbDIhGLrr5eVqd5Rmo21?=
 =?us-ascii?Q?kcIl7eWdXfdj3C8X4WiiLnLgIEcSXdGzlKajaf3+Uj2Pi0Mtz5Gs93Iknexy?=
 =?us-ascii?Q?QP4d/ZMi4IFJeNvAFQMKgfrIwlCd0qlRMWlyyQQAh5YZxbsYPJ33xmIBPzvZ?=
 =?us-ascii?Q?D1CgCojD4+5CmjstfZnkZjRNSQRJCuujlOHo8+UUbYi5RnmMoi4VZ9aYHk7s?=
 =?us-ascii?Q?IcYRO90RgLasSIflspmt80otaVq50Drukf77YzqyO+Ow8SxrXulnNsb1jbJ4?=
 =?us-ascii?Q?Yt1PnS9FaYgGbhjsfVfBJh1dDtM9qHK+DatPVh0lU9/Oi0Ck0a6tX7XJDSBd?=
 =?us-ascii?Q?ZD3OmuZG4sSFyROa6Gy6ovzUnvR5ypRcEXQl24+G9PWzSxcDPYPKgrTZB0pw?=
 =?us-ascii?Q?+wrJg5mbpfOwi0Uw2SBfmUEAE22/TbxEiA0sKq0QRbjnGhjg4gv8r5o4VZXb?=
 =?us-ascii?Q?4/NIl2sprv9Nt4zXwHNDdYbi2eUQJnLBeBB6vpJrFbMbbTvn1BfzU75+2AP1?=
 =?us-ascii?Q?3T/Kznfy7MgL8TM9ihz8U8m3H2jmadeU5KgnuOthaP0kjKa1YZch5/lRVcXK?=
 =?us-ascii?Q?mGwEuo5YfdR/0A79kL+C9al4W02n8Na+3MwaAjZg/YVsKeJDZGfWcgFZV0kh?=
 =?us-ascii?Q?pzHULIT+nN9s3wl5wcK7UxN4F+Yh04x/4qnJSxx1FFlmbEGY0uJzj8EghPlj?=
 =?us-ascii?Q?XTgiPTGrRwZZi5Qk992qDVdWTbOt3InQtI4IKooBzqijfrhYDjQ7z2TW2UmA?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facdb9e4-b4fe-49e3-948a-08dd46add281
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 12:57:33.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5RaEg3O5X2kh+byJnCJi5cNH95DCyg3ZG74WOMS8U+FtW4shRdL3eLaPcKWqQBbcK0QuaT+MdO8wQQIzcRDQcJaFfas3+pQIA6C+GduITs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Feb 2025 12:57:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17760

Enhances support for container engines (e.g., Docker) on arm64 and x86
architectures.

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/li=
nux/cip-kernel-config.inc
index d26ff3f..53bee8f 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append =3D " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=3D '1' else '' \
     }"
=20
-SRCREV_cip-kernel-config ?=3D "b14ada5877ab5280188f3549c21891b7a830896c"
+SRCREV_cip-kernel-config ?=3D "e486c93a916cb6f78b4917b7345e8818f96069f9"
=20
 do_fetch[vardeps] +=3D "SRCREV_cip-kernel-config"
=20
--=20
2.48.1


