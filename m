Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F84C98302
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 14:50:40 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12118.1790088639673989370
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 07:50:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=o/RiFxt4;
 spf=pass (domain: siemens.com, ip: 52.101.70.17, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj1bS/Nfi/dCLhxCYd/l3Dlvg9d7u0KER+DslQc+8Gy+3cwGBb/istAanosfmpqZqY3iIIzwHQWHq07lmyFrBYInP6kIcEmnht8E+/oeANF6YQ5sTaGYq1TlkTwcELsdI0+XoCnZ/shoGs19bK9KdqgxzKDMyv/iVaPMlMnwMPUe9BWDOXnQdfT1fL4Eioo4f8HwCJCSJwczu5TktmbQOvSRwTcEHhw3DaF0KuWtW9TRaBymyrSC/WVU2DDD9eI6KOsLupOby+VM3stOzomPQ3cs2sUsnqVoo/hdnGXkD1oUwwVfUDMo0CFjh4jPMwbqEw6xFeogJyIfPzjrxpiSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emzNkthEFlRQ5TU2XmBp7ut/hNVx4zhaj2RNrpBfyPw=;
 b=SLJK2OsfPwvU4P9C76kd8Uvsg5BPB4Hp8sceWv6v+Uup0drt9PiOn4NXoHzrH5BAAkyztoG+8+oDaGvdhQ0rCJ3mk+PG5ZBP3O0MtsdAy/Y3HvKDqfZavgc/+PeRIjrejuhgtvMBHZXupZ87eiJasuafyChRV0AluhGjNQJXVoMBKVBrNx/5YttXWL+sTah/YWrTFviP5dWP7cZGlhjmlC56CqTvdcMtVra4PVsa+cvOfKEeWp7j4anhxkDK+aoZkMuTC6c0WqDN5EUSkPQng9naF5pHL3nh2ZoZM0tWtyARx+RC1cR2aCDed5SYPL4ZwbbaO1wkiqYrbD0qqFL/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emzNkthEFlRQ5TU2XmBp7ut/hNVx4zhaj2RNrpBfyPw=;
 b=o/RiFxt4Qd3j9cA9uSY2YZxAFuTdR36QySFnAzW5MVrp94ZCuXJY5bHOmcqiH7Psmavd8bphnOFenTwMJCY/fC8OpxYaRnLNx9rLFfzbgyJL1/MuVgLYN6b+4NQlPfJ14P/nQEktKVwL4zVErKqm6kO7zdNWd5zIGo575mbDkcp3OFsF3LKgbCdk2DRAVDRAh+KcR2KYzrJoZ1hsExLcgoiBgr1v21nxtq1yLpL/NJcMoTkhARm0pAD4U06I8jq+oxf9+Jdi4xMZlzZynkxebRZHx67cKwO/A68X8UArxihKIngscmBh1UanPIf9aECrcKoPYscq1cuxFLcgQyNulA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU0PR10MB5582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 14:50:35 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 14:50:35 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	kazuhiro.hayashi.f74@mail.toshiba,
	kumar.dinesh.h95@mail.toshiba,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2.2 2/2] Fix file timestamps are not reproducible for EFI certificates
Date: Tue, 22 Sep 2026 16:50:22 +0200
Message-ID: <20260922145022.167894-2-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922145022.167894-1-felix.moessbauer@siemens.com>
References: <20260922145022.167894-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::10) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|DU0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: ed29c8c0-f1cf-4a4c-95c8-08df18b8db43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|6133799003|55112099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	uBkaDSIwbYEA4pfHzVQqmnKjidXTO/OrI3C3pg3fj5vqrPXhPhFjZQHLs1GMFRQx/xWiNgKLhHRBoRhTcoEQUTpjSRzgiVQrrvibyCb32NoVtZeGhWgmsURbSRIat7pddYaCvlHjJprO3BK4BAe+K+F4473ORTaLAg29dWxMazcVIIgzFSaPf5lc/gN7LI0TcaAU0Lq2cbViGCkIXycn0+j1o02DIj9BanMIQAakjOj/+ZtBpJKE6VV/B2mDpHiU8k4mjy6h2vH9PIhk/yUF9SpzjNIF4ObDTgML8T06CShfzbEh4rXdcNumUMuJEqmB2FCAfW897vuuASEbAKlEuFdbYi/sRxAwTX7DCZZtKMilVwlIaT2bth7orGW+5+BC5Rzi2CzrHCVkOi88Mi3eUcjRNkKLn/ENG0utwWs/9NCTz2HoUF/ock5exAbdKKg49VN6uVEu1XntJ0JUR/1Qj3ALncO2vyXo8l7McQAAOUscunVGCSF51vHf6bWaO2AwivZ9G1u7ZGgmLLEKTmaH9hJZSNSVK7lbyoKcLXwDUPQXVoWh30tppKj41B/2J7ohXkj+q/++aTyLezR5fh6Ol+KtQUVwo3s9NuPADAmVpEq8Vb6bvCQ6eLehGtUupwvzipuSMSgMwQPXAH7pifuj0sppis8GKhizi843mmKl910=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(55112099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZGAWEn3aanyuYUEx+4Fdsh2oCDe2LO5fN7jDIbYqDFrRPT/4CrolpEH7F3zi?=
 =?us-ascii?Q?oK/k8sZPHwTzj0u0OcC7d/uNRu3NkFxfN2fp0EorhgiHI2jRg1nPkIDRvYJl?=
 =?us-ascii?Q?GKRh/nQ4RQhy4AxFI5kHYZr0J146i+nYlL2OoLevRDfKq+VbR8a4FEBIed0F?=
 =?us-ascii?Q?eCheoUE483WLCJDE+ZGsW9hFTJXKsbsSqDtSU3GIaWBBfs2hz4J5qMtKOgZ3?=
 =?us-ascii?Q?AFTxYDPIf0+eAhtAZ3+6j19VuYgGBO58xeIjrx8ijceiPZwl+KZCltOWjQVN?=
 =?us-ascii?Q?tuwQ8/HynCTQIEYhBHkSAYNRYvP1yTEyH98acK7f/FUds4Id3Vne7maoPI0V?=
 =?us-ascii?Q?3/N3U7PiCy4gapUr3QQBwo05i+bc5QQxClkFg/ZTHSBKrQnSWk0FyqDg7eLM?=
 =?us-ascii?Q?vrw/z83J+swZNgGuQFW/kv+0qfwfnOgmfYzGO77TWFeilnnRNfToXHFbFkcq?=
 =?us-ascii?Q?b79rSYC6CqYWWhIzYg7AfgK0kKmF7A0jjDeURKtFIvVN/CQd6Djhwe0ddlYY?=
 =?us-ascii?Q?dXaQOOhP6ybv3J2AS+xW74wsBK0beNs/3bcOLFuErNjnZK7NXbHPoefQSJaK?=
 =?us-ascii?Q?hK/NI2iKGRtOFQJqWQRIHCWF0wM1R88r0KX3KUlodopSklTID1l3NG9lLKS5?=
 =?us-ascii?Q?XuQUtE7q8kzL3UD7r6PgorqzCgcLy+TyYuUG53QNgOGoIuwVcnq1hjthvurb?=
 =?us-ascii?Q?O1qqE1mwXRtO2W2R+BLPDrIEtWU+ydOcMou6K1WYez+5HDtQoyLPh6GXdhf9?=
 =?us-ascii?Q?UpggA4rpG4gxtsGVx5P9zJTNYZAAmgZXVqcKEohtXBsJg5UuumJrMHi+2Oy5?=
 =?us-ascii?Q?qOe2pSDv9zBzW0iUDt/rYmD42GEuCD0og3h3D2LXBYg+d7BkLnoTRXYgCxuw?=
 =?us-ascii?Q?wHqayINhuK5TcEjbOItY5juKeLKra+rXI9yz61XLw2df3c2HKhW2oXM8Zcol?=
 =?us-ascii?Q?49knNf63Jjieb8IGzax8bCouhRfLb88+qERN1CToBR6cIBwuUKJ0SvKheSUp?=
 =?us-ascii?Q?ANllPm2Fz9pQ3oEeSuUcniO+YL9ZpdZfSmkKpUJAwvAjMmUo9Gqv+QDjIE5x?=
 =?us-ascii?Q?UiQUlYXW1iO/cEHkk6vyL2e5+mrG4eHFRerUNHS0zMhE5MDRJsRsvj9i/1GJ?=
 =?us-ascii?Q?crPmyYV/eTHgj4Mjh9MPRYPbEZB16HB4J+Ktaj9QerEg0GB0CHRFSYGJAtF+?=
 =?us-ascii?Q?P7to5wqAOq+mxYwNBZZHNgfERtuTfYLDY5n/8zVIt9s2GX5fRxrUWilW0rNq?=
 =?us-ascii?Q?NkU5jmroXxRk7/4VfBUMR+nu9UHCbtUtq/bmhhEYO3lYTPqNsE7Ha31+R/NK?=
 =?us-ascii?Q?0s5js64937/PWjFNL29dI0Y53Qa69WQ3bFuC/V9QVaZGXFh21NZW6H8SMqeL?=
 =?us-ascii?Q?qhpvUohqyGLAY07+fQOMNk88kXjBueBWCeZznwD365fXCTSHZfmHAjm8HIeQ?=
 =?us-ascii?Q?z/egkj91nMDIfzwygAPvp7vSOInPA7pCcpcC9NCAXLXGAlPsUbuMUapj8Prl?=
 =?us-ascii?Q?iWw52uL6uDFoyYlgRkHGMHiB/57MIjB8ZK3/S3qLaTn1kEL0PB+cjHjnU0fA?=
 =?us-ascii?Q?w2/69huH02U0P5vhfjOPeauMvmXE/+EW6lLHDeDvWT6bYAY5Gj/p5c+a5gtZ?=
 =?us-ascii?Q?kM6UqXm8KaIPQj+Wi5Tr/rP5Iy3Rv0vanpe8Secoj/X3hxATGif3fB4BaPLe?=
 =?us-ascii?Q?CygDAuxKRlRavRAn83T+bUh7IKO4iuV44Vc/Yo91L4in8mfXsVYZRvMb9Xnr?=
 =?us-ascii?Q?sP6RQM0WLQKcofx9sTmeKcuD70UXzNs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed29c8c0-f1cf-4a4c-95c8-08df18b8db43
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:50:35.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JRcL21N/dinKc3HeZJTg4c0GYDyaJEA3KZYaw8zXklI8E+oQW4jClef7jgprAaSm7b/Ao+LecPWMIi5ObTLhY+79K0bxwf7qsshbrsH9lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5582
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Sep 2026 14:50:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24265

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/1=
62

[Felix: let dch timestamp depend on SDE, pin timezone to UTC when
signing, pass timestamp in correct format to sign-efi-sig-list]

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs=
_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.=
1.bb
index b14d6cc..dfb0ff9 100644
--- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
+++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
@@ -28,6 +28,8 @@ SECURE_BOOT_TIMESTAMP =3D "${@time.strftime('%Y-%m-%d %H:=
%M:%S', time.gmtime(int(d
=20
 DPKG_ARCH =3D "all"
=20
+inherit secure-boot-timestamp
+
 do_prepare_build() {
     bbnote "Use timestamp ${SECURE_BOOT_TIMESTAMP} UTC for signing EFI cer=
tificates"
     deb_debianize
--=20
2.55.0


