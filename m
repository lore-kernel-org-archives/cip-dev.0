Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02139C98315
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:41 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2973.1790237559227108906
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HJ2BDnLy;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkYcaQrmgMw21XPGhPJAm0uV6Zbk/vHbFktiKCmoEKWpJn1wMg3kWbP7P36UOGKtEMiexl/FBqupwcaKS0q9WuNRf4ApZ/9ehCjxsVdDJke8kVJ4yRA30jj6H8AyIfZ03IXVsXKcAPifgBhipnsEaXuoGEMPeFAc7u+pyatQo08pGIH/mfsaVwm28fFYEvWsamlJNwqfTm/VzSAuOQEmXA35EnaNkPb9yqJKaul2E1WOZ6/dC8CDwHxPgZaFlyCBG2mq32pICSi+er4J++NqVTI6BVNuB6xeSA1PPfXsIFu+CsmXFyrmbMiDg4sCs9BmFzhuHlewvH7sP74VXdlhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npkC7ybIH9OFl3oD2ehXPJpsHH+mIIuVSr7tDLsZ2mc=;
 b=xL6L9O6Es3uhsdfVAup7/ayrSOxvZCrcUqhR3ITxaDDfBsJIUtO1lDhWKcPAXZTa4Mc8podFnF+wn/S2ivvs9ZF4KhkOAWBCdYqCzEuwXxCJEdGYKW9GPj314SjiumaC2dLodtabrRYT32C8US9UO0YzOHq0U9hpyeW5I3KiHCZx8O3vGQrn/6L7DAQcn8s7+MKBdWEcR+CJCSHgzBT8xVtFBvvZUmwVmZkL5Pnedrao4QLYjfyzocorIO/czq+yRBrqTjlCfrfdxNAA0ELd6ytHwsSbtn20EoF9aZvri64PBhwWpbIZJ0tB6Wr1b7IFY30veAGH3q4SHGmcrPSAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npkC7ybIH9OFl3oD2ehXPJpsHH+mIIuVSr7tDLsZ2mc=;
 b=HJ2BDnLyPC8JlKl++rf4aGJ0zVNXYejEgQNPEmUqedLEBryoEddERA5apWkaA6FZCN97uduQ1Urg2Jl1AmjPqOYf8dnewNPWlCaMGwGwuXqNfUCkqx7Fpz77MILBJMsixzFYy8MCMNCy4wkOivXl18t/3jrpTpYLfYbVsgCYGfldezTh3L31ElijCii4/tTS0Py0xYYboYiUJ5qYvpTb7WOA5TZ/cxvNMtN9uKdwmWxRJSCFTqw8ugFpfDxGtZf2kGdPilgc3ldhm4qHH10Vxa1I00k5L6gFfW6EPD4qDJMvFz2GN8Z7XexF3k/ic9VV7zxIUeGj+rCdKmcoe5Hi5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:35 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:35 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 01/14] Fix file timestamps are not reproducible for EFI certificates
Date: Thu, 24 Sep 2026 10:12:10 +0200
Message-ID: <20260924081226.2844456-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: d10f8ff7-f76d-493c-2db9-08df1a139646
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	2ahNELck8YmZGiGnJhPoWdZ4hoQWRbBIMVHrHP2acpJLHffHzPPteYecftaBRtiqXsge6DNjmj+73Zz0R38Yxn8wKc3yWfL3ep626Kuzl613BZXxoeykPIPTbK+VyiLst3V2Cm9UQkSglgKvzjUuNuhMJF+ZMakJUcvQkA04ERvC8a5KDRcpHwTrUS3Q4T6z2jgnAzfsQvDqQuHJcJlvyzeAGcyj0v6yk2huJe2AJhLeTtiv848T2Z6Cb25e3AoYEiQ8MmtfUNs+mQscJ/VpQuMTRgXnj7A6ghhiwzTNpj+ry1qu4Rn/RiafyWt4fNfKA2dUZC9qOfD2u4sDDmgpwfYyiNUliIN94Guuupnx/dF7Iq+09fT3+WW2QQSnIjdjvH8rLqdRrvvrxVKNyE9ScRQsqclKJKXsUoTvNyPYXZsyss9hv/R1NWl/AUfmYYG0wJm0AU/A9N1vnBBv4Gb23ZpUJ9eKJQ32b7CCMaLXpbC9HJ0FMQJjaxvkuLvhNfsFhNeS8fnXcX+QxL+4a6/5yyPxHXbFzG3oMlWKV7Zye9MhT5qlCSVxZqbjQAG81qDgsb75WJawobwCiHDgHKYHo1a1WsD9flybre1biUCrAfptt7bB0SRAeyfRpQt2A3IQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yLsFu3yGv4vKnx0FmgUUW82c7zvZorh9xb6xsQdAkWt92Z6VPmHJnGAmADhI?=
 =?us-ascii?Q?uU9DsKi6tL9w9JrgCSeF7RlMUhO2t8aQnXwfTY7JMY0dkYoUKizdE0ZIMF3K?=
 =?us-ascii?Q?zCEmVe+OKocSklbIFVf8o4DiA0rWJiPAnEBETlmxeRaVmQawhKx4C+/kbVSI?=
 =?us-ascii?Q?WBBTkhH9s1+5o6YVpgtG//A1l87QHrPdxsBkcBP3DxYodnfHl5Nw6y8icCc/?=
 =?us-ascii?Q?m/7jpnT4niLjKZNReQgDz0plpF6421imslzwU0iziGWqS3K+ePTB9mmfSfPh?=
 =?us-ascii?Q?SylsdB7r7U+yQ9k5lT9rZo9+YO4zwzl1n8GaoaG0rvumA8Qjocn1T7UhWEVB?=
 =?us-ascii?Q?rdH+HyTJWOHn4a4JDluf1Rb1qFJjaAYp2g9LCt0HU894hybWp94ae67WPg1c?=
 =?us-ascii?Q?Gm+QIRQDNlt8x4vbe8zQdlM4SZ32pxRoUsIoah078RMGWxl2wICxJZh4tNz8?=
 =?us-ascii?Q?9n/Zwi96iyS5GUbiCNkIOOZb5rl0whS4d4NLZwcKb5TiLH00lOggJ/bK3BI7?=
 =?us-ascii?Q?hclTopX7SiZNxX94A8v+wszxCUkAjREJCNY9eFFw7g4Fx/Iykp5vPLarshYX?=
 =?us-ascii?Q?kiNgAN1xgzqYyhnzPXqntdPJery8H9Yocp6kfsw7fgHJIW/48xo30hcm4opv?=
 =?us-ascii?Q?CbgnhSzo/Oi/RVgPLbWRhn9OqEGUZ9oJvqX0HagY05ayuf52TAb00H1OeHc6?=
 =?us-ascii?Q?RbPqd40Zo4yjLLVVRSSD8SdSI18uFnVObtgfDYipwGJAMJsrnCTNhB4q28lI?=
 =?us-ascii?Q?lyWBbkehCk5e19P27ZXZZkrplcO40/LWUZHapGAQCH8hgvFqKubA7p6fJgqX?=
 =?us-ascii?Q?ssv6IKTTbXjQb8ztQGI0AzoRl8bp94QzHGAfAH0+mzZvQ+iP9T5yeBXZdW+k?=
 =?us-ascii?Q?d5MNCO6XHdwp25Le8yiDXAavmEPq7IaPitWetFrVupndFkEUmAljwTG3eKN3?=
 =?us-ascii?Q?27oCJMMRB30A/iRCjHEnvK1+97/xyBuqiMWBMPF0sd2fS+ZXrdFRjPPLPNCd?=
 =?us-ascii?Q?Z6zqZqs3KcvbPVGQhwjWK0gE6C4G1+VEjmlifD2DgaXK7BPTEvy5rU1k2wel?=
 =?us-ascii?Q?iT60QX1dWgrJJk4cRuT+j0DvmGEdFogUEeq89wYLEhp+mAExdBy7vEvew6oq?=
 =?us-ascii?Q?xSyYwTacM/mVa4cUGdcltdwc8BR7DeNFpfQAtPv9mtnt8kf3ta0KcoJ7ThWs?=
 =?us-ascii?Q?eQ7d+L03B1FlBkJaix+JMeVr3y6OzH+FxjNpmBIVCeCHyISsRENN7VtH+ll0?=
 =?us-ascii?Q?3nG5Z9nfUtj/ID0Dhc/svEUC72JppZneMB8LigDIGJMALujvg8BzgxwGXIqP?=
 =?us-ascii?Q?dxAh0jNbZq23QxfPk31rKG/8J+ePahK3d/vVNCf6spNYxO+I9MIF96vJNrpK?=
 =?us-ascii?Q?6wQQ8QcCp+2LeVTbkom2/3Yy8YXXIMiSVFzSjNdrT13OdaT1S08sqccNIvtf?=
 =?us-ascii?Q?m2seLHMVYBryeeGiiVkHjAVblrfueJ/P0aByGEPRIBEbkSgvg0IcnOdIfEHW?=
 =?us-ascii?Q?kvk3GKU0RLy1ITvqZCosV7mC9vbEjVh2y9+Xgx06V2V0qKfL7nSSp+9L7oSH?=
 =?us-ascii?Q?jAShOQ+SFDimGAMVl6YzIZp4hOIMjO98V9TX58fT5daM+fsQr8Wn4VaqyluK?=
 =?us-ascii?Q?nQ/XAPojPdiTA5CDc/cCYOYd/jNWFT67VXSaql+/dAMyteFc966QlQC4dyZ/?=
 =?us-ascii?Q?FkJsXGUkqgEMAc+2ksIaEODNgbfPiAoefqefopMFQ7jOJBEbL4iclncmI1lj?=
 =?us-ascii?Q?eW1oWWi2vbScNqKGfi+EsX6la8iFTXM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10f8ff7-f76d-493c-2db9-08df1a139646
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:34.0161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TDnh/6ymvPYBw4XG+oUnoNuJUkaUtZkHJPXflFMhBFc9fIL7yX6etpzBt2kyGo15MHV4PA5s1XFTE258BRnFTcM1MDlkSZLFmO/KfVk9/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24288

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/1=
62

[Felix: let dch timestamp depend on SDE, pin timezone to UTC when
signing, pass timestamp in correct format to sign-efi-sig-list, print
bbnote regarding chosen timestamp value]

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs=
_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.=
1.bb
index 75927ec5..dfb0ff94 100644
--- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
+++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
@@ -20,11 +20,18 @@ DEBIAN_PROVIDES =3D "secure-boot-efi-certs"
 DEPENDS =3D "secure-boot-secrets"
 DEBIAN_BUILD_DEPENDS .=3D ", secure-boot-secrets, efitools"
=20
+# We need up-to-date timestamps for the cryptographic operations
+# but we must reflect the chosen timestamp in the Debian changelog
+DEBIAN_CHANGELOG_TIMESTAMP ?=3D "${SOURCE_DATE_EPOCH}"
+# sign-efi-sig-list expects "YYYY-MM-DD hh:mm:ss" and interprets it in loc=
al time
+SECURE_BOOT_TIMESTAMP =3D "${@time.strftime('%Y-%m-%d %H:%M:%S', time.gmti=
me(int(d.getVar('DEBIAN_CHANGELOG_TIMESTAMP'))))}"
+
 DPKG_ARCH =3D "all"
=20
 inherit secure-boot-timestamp
=20
 do_prepare_build() {
+    bbnote "Use timestamp ${SECURE_BOOT_TIMESTAMP} UTC for signing EFI cer=
tificates"
     deb_debianize
=20
     cat <<EOF > ${S}/debian/${BPN}.install
--=20
2.55.0


