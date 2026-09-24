Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211DC9831A
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:30:40 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5720.1790249439112830547
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:30:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=lgUSFAnT;
 spf=pass (domain: siemens.com, ip: 52.101.72.13, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkYf04g++oE/6oPWPEbs0t1/SUuMYm5sQq708de0Cf2J6VfDRh18GfvjefnJmNaLSvo8R9LOSOMJtGnNW7o+JJdK9t4UUe2Rp246AyJZKDAEnYamYKVKAUyRvDX9kEM8zBg8s8bVTe2lb6RsgH+dSfWp7qri7wVo6QX+4PkkSmRvcNQank5Wj3AbwxOIU/9Qphx5uafrA+og19HXK5d1A1mLA/xDk3fnGQkeAKr9lvrkwTEUOjNhu9v3e7wCN4k2L1IN1YMWVz7Dy+xlVNIDXT0SJ9JsDlajh7W++uStm2Jb4h0rj3A6mGQUsuxK0cRqXah8ZwkYfiivJcgJTmRvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npkC7ybIH9OFl3oD2ehXPJpsHH+mIIuVSr7tDLsZ2mc=;
 b=qCh1dKXlSngKIRNseM9lQQeYycGjwVKoKVRDzGjtji4ArOLTmb+FlFe1bY40J9psTeY+zaW1PmfQn3hRxMHiNh+AGCZ1qiZvn3ynE4vHuDv8lVBayh9WibhL2mHkEofvqqQ+eoldiS9SSzAl9KirpFSKaKj6ObYEv1e7X7o9q3litWfRWbmAjyzMKCYnbRhBU8jzXOdIX8WpZv+inUMTO47OtiE5DflqDlRY1CTWzeIcPlHnSGRpeUJ5hJbqVt8EZyRV+CmH8BoXPBmQSHq7ZRsYj9jKQM3JVq+3M9E5o1c6uX6Pe9uyIN0hfj26kyeKfP+xyxhK6No2Mz0ESD3PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npkC7ybIH9OFl3oD2ehXPJpsHH+mIIuVSr7tDLsZ2mc=;
 b=lgUSFAnT8a8gnunXtZVY5ZRAc7lGr3+YpFLGr7mNqaLgOGjBPNdHnVPYg+F3TiUwTF1xeipHcH51SMl0Uwz6mEv+Nh6dSH8HXzOcvOObuR/9TazkUBkoy8Gfcc+w4hBCInr3O5JwG5y9phV3KiPXwi6+yU/7OJuiOYQuF31PQNeNgrK9dJgcWeGHeViyLV8n1YV2/RArRwlsQQ2M/qtEwRQO6OvPALsPQLr7On2rYw1YQxWhA0Y790Rf1kXKI+i71RDmrZT1AU22S6nu0h4DYqREWioPXYnCKm/jT0iOwLlGotNmuY0dblhprK8BtlE39tIVqWmpAI9nZlCGyDl+IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 11:30:36 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:30:36 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 1/5] Fix file timestamps are not reproducible for EFI certificates
Date: Thu, 24 Sep 2026 13:30:17 +0200
Message-ID: <20260924113028.3191076-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113028.3191076-1-quirin.gylstorff@siemens.com>
References: <20260924113028.3191076-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DB8PR10MB3308:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0b1d49-50c2-4980-8c3f-08df1a2f403a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|55112099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	QPHQYCrVOyn3vN0OUy1DLCb48G8KasiRdv+1FfhbHjWVl6VKgX8GIb3XGKKwrzK2KjdHeicsBF9SyPRwa9U7GFR1WNyGgHTgO7KYaMhgqY1bA05GdUMiZCUehxXaIjvlzssgYWdAbgQBg6TLJJRPenWFi/TRLrtxX1WK+y8m5kXwYHWHTY4g0OxTPK9jo5cvTeX9o8mcpSdZEkl/Bq2DXgrT4jo6K/ttxg1i2eAnFmy9WaY7WSSJS7JuxwuFm8SYALGCWCLhiJxAoWQlOI66Vxuizhr2ASOlKlamNwgVFv/KPz3LMLKZy5kesrgatbTuJCvs55lbPt1IVfFegyctrn5fYiWCUtlKqZ7Bjn9jGLayDGGsMX835/FIttJLjUoqok6fDvQbJ97osKw3SbasvebM655y3a886aYb47RJAR0BhFcL8kSh3Arb8gLBrFZ+sbRIoosBPGN1nufPcPeKwyOTcklM90XOGI0lKUFRu+RYrpqDF1dI3Syrgujc4nWtHU3cl6u112CP0/1BgERHWdRXnz+6Nf3UgpX7jwbszPcoBZoevunhPJxoP/05nrBRlwFIMUznCN2eA1F3aPad5J4qtPYKADvRajJrNC48vco+aHOzKpmMrwP4oKxL2Wzn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AbzuwwHWWLd3yYiPT135nNN6VRqGmeT7Fu/EpPxONYrrlCsFYHImEqh37Xit?=
 =?us-ascii?Q?2GTn4FxztkbHU+FJDnbf7oQwtxI2ytJxmVdr3j/HS/vBXyajoMz9b+5VhxGR?=
 =?us-ascii?Q?V1REiqUxci+p16OZJS6tiAuiqIeXzPh6I+BhUnCA0g/A3+Ndyf1vePV9Lj50?=
 =?us-ascii?Q?5LR/3o5k0HR7JPF2bFKzLAb/1lyQ44reu6ertnbjIrCKH54hLYqj4KssuJ3v?=
 =?us-ascii?Q?jdB/wlOB97hQXKTEtRmu6SKl5j3MigU0iQ33auI5+HaReNKlkisOb31uRQI+?=
 =?us-ascii?Q?G35nJmMT5BP41C94IBo8PbM5RBagcfCsHvo9hF4bzLG5enmDK7VKDxhH8ryr?=
 =?us-ascii?Q?mhcykVm0LQxYX0TMaE6rGcI34NlubX7rG33j3Hol5vSLoBSP/N7aDlar0P25?=
 =?us-ascii?Q?7pDWcROA9nP9mikcOe5qwpsTg6vu2bD7hfAQD3frKQ7SXOMoYPE1ZWTxCCRN?=
 =?us-ascii?Q?M5/bPUuilU1Oz2W3rqcCpnwlMItF3YuW0TDUE58XDVtUb/6b6jZLAdWWCK8g?=
 =?us-ascii?Q?G/3STYgH2lEB8tyjXKo/70MWvrVcXNskSDbmVEmYQuga87yJ8ees8IdSErR4?=
 =?us-ascii?Q?xmCFP+dtbbhTTZWB/PkMvMHQ1sh5n5du2DbMR5N1j2b7bJnSBfbbXMHliRS/?=
 =?us-ascii?Q?saE5dA/y9Nv2psgUoXLGPbsZ5OnRl09jPSQkML1QXiDAadVYhBznYkuaCRvD?=
 =?us-ascii?Q?Y11zVw+H3fWmFp/RYa690hg0HQNAB1FH9fim1fLE/yW6GmQqwZ6YMT8ipRHX?=
 =?us-ascii?Q?GY7QIRcsX1b9anLb7lSkoXr0e53IcCzmUbeKKJun2ZgCPGzRkHR2TfMYflZf?=
 =?us-ascii?Q?1EMKS6tHbC54iTG4YbrhT7dSHoPhrJ4X3V4lUIJZmR3ikJ/dPVIwsFGR0WB3?=
 =?us-ascii?Q?h0UCc0vQ4Q9Ca64icS3gAKUJS6AdGMkvQTxeQqYL8l0hUqE+6yY6EwGFbHJj?=
 =?us-ascii?Q?Ro3WgBVs+6v9r7NKRHyriSU3ue3dX0m9FYgqtYAFhA4H9DsUI+InkQh9OvFm?=
 =?us-ascii?Q?ndLSPXytKIgwyX6BWDMANOgBKi93A8cBC6pFxgbH7U6WsBnRsxz0timSj7aD?=
 =?us-ascii?Q?WE62g1BEPGjbmE1yKUHZD8dJNgC5JZ0E9oC7sxe81k87T0ettgoAdXDM9pey?=
 =?us-ascii?Q?MLcLq5DuoDzA8qcEdxVoEDgyWbPOVb7g8XlDhATJoVK5NhZO57gbLFTH4YYG?=
 =?us-ascii?Q?tZvxbrAe7cID3whunARAKVbv6RlIJ1ygssXgftu6U8bJP6K7LEHaxIi0l1kU?=
 =?us-ascii?Q?dnR/CZwrDiOG/HeYqilI+/af2AobcFDbkBQkPVUmZEV/DydcND3kE959fjaE?=
 =?us-ascii?Q?8dQMu0ZDe17LxzSPrmDfz7IVk8zjOfiF5b97EWGOOgjsb94hONr81C2tjjQj?=
 =?us-ascii?Q?EcnxgjmtqnNx7Une3kZ3fzWHg+rYCXfYbO0fopA2aO8qbc1oPQcHbUo3GiWx?=
 =?us-ascii?Q?TrP0W2senPCR5qVw5kSuz9WKNLB50GdRM+F9wYTD4/03ZEuIxSP80pWBQAd7?=
 =?us-ascii?Q?jSFwKAknDH8eJNrHiLsyMX4imocWzD0+rTfy3FTyb4faV9fnVLmvUq+nt2gD?=
 =?us-ascii?Q?j7w2XejtuB0hIhvMtXYDudqSiHzPUM3qhoCzWMDagPlXmuYfeCABovrR9xfj?=
 =?us-ascii?Q?/rj1nITiSXjXIbyuOCabaMv2GTihvBTtTP5eiGq0Up18X5j6Lmr7jtZpCre2?=
 =?us-ascii?Q?PMWzzLd/t3/BfcmCvXDPgY/EuR3GS8+q5TcWORQPJRIlk53U46v+fmhwLGZ7?=
 =?us-ascii?Q?qO8+Cmz3BIKwkpNjMDZi0CjSeZwIHNg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0b1d49-50c2-4980-8c3f-08df1a2f403a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:30:36.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIJBCOtk3kG1fDhhzJ/dGnYZEtiDyAgPBl9pTEOvF6OPHemjxSwcyKjtL7FtSoOlFd1/rIlB6pXp+XXcffSgezsx6BmQr9pDqh8anaEo70M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:30:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24309

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


