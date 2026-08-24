Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A30C5DF9C
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:51 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13127.1787564863403657251
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VsFf2/bC;
 spf=pass (domain: siemens.com, ip: 52.101.66.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zG8B+bv5pu/G1X5KA2yIpH3DJhcjn3JCqjARg1tZz6zfSQfwJt5FVEHA1Gbeko2r1H3i8Rn7HPbHR9a463dvy93V2Bfuol9YCuMekX1f3OZAomLnP3/szAir7SNC2rnPbdlS5JFB+aUjakf7TZT7/EFLyQV3ouh0j9mrCxnHSGcGp5YrSfTd9WBCn2zW+RAWlQn5gB+jGllYKAvvYJRiEXcSEaiHcEBu0x5tzkjt1DIZe9z1v4msf/9vkVpEPzDPZXeaoWG+h4hzzYgoTPq6g+MGqVUY2Vl/uMPgSHbGPs87kbpYKzvkdSzXscv8+d4LNLR5SRDhrGDGWWN7mlTN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7HliivO561f+la8hVMZSwaAdEl0WZm/BhQLsAT/bkk=;
 b=xqvHRPNJWu+Wsqrmngn+rGvHMva1zZLNjmRMhX0w7CDD5Pl7q8LFrASrpPZ7eV+9QRxdtTgF9o7NUbmjHPnllrtmhlwc3foe6qv82ek7f/XOg1cPBLySGLtjpjLI3NZXt2shIQb1UqA+j09aYY16pmAQHIxWBJtxg+hnCiRgeWK64SniKhyEI8G3MBTeckGFmpNDOAl/lY8nEksJ1FxK39FUbUt/F5rJo4dve0Ox1xzapahJFTGPc1CoTQDF3uNJO72fGPnaS3AJdz7q+iivlQj5pQm7MLAES8XSv6ffnUkrlL8WOlZu/Be1imWA2KOJelm8Oa4zEvD/lJu3SEXgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7HliivO561f+la8hVMZSwaAdEl0WZm/BhQLsAT/bkk=;
 b=VsFf2/bCVjiZ+zDlyBZGKhK86FwrEJAi76Dt+JMbSy95XGAjgBPGhSnmP8H8vGA4PHW6JBSbawTW7jqxbgeMnhUJYUngsTNlXQ/QxV9p5lvMIq7YeIlkiPfvAPzJO8l2/WJdnqFuxbX7+9XUVMb184tZKUKv5eIagUVFA4hEQfRIJEPDuNh3rxryKwJAze1mW6NhvYapwW5ZIrR4YCE1oamLnn3LJTJdLkM4XNo5SM+Cns5FTgvEAal2nr4xGJpNMH1qB4IMQYyRxdSIDFiSAbxLWuFxzQMjnxcnETBCB3eVAMQ0BXeNDwYME2oQFTcec+wpzFIx1UIjPyHg5RmK7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB8PR10MB3738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:39 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:39 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 10/12] Integrate cis-hardening into cip-core-image
Date: Mon, 24 Aug 2026 11:46:47 +0200
Message-ID: <20260824094721.2636375-11-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4601ed9e-12b0-4270-d5ad-08df01c4bba4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|55112099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	z4kOY3nUYldygPPTkGNT8MUU0bW9AAExHO7Gs85oVai88BwIlB+eXrZL+xo/AfpbiNFfIFmCOwkZE+r1yIc81EiEx0hifYMyKUOIuXmbVt/sm8IUBmN++LWFZiA48HbucyS1R8xPQD6VhzWQ5Aqa12EekQfM3khILmLPA1GuWRAgvQs8j3LZukig90avLTlIou8pnVX9LA5vuNKpsFTU8vmEMhvNK1bhtsrxLzgCfWv/6xVhczwQOQnibDQ4I0yhb6W3jcc3QE3U6nRYY1O1HYvWvWiuuDUeTMMKWILc0NWGcd2EeegZVsvuqZB+9rhAgeTSiC1I486J0Nn0UuIqMxdpiJ3gcUmfnIF+dsQk99SHiDRqWKdlxEFcf3H7tbG0OCgFQPKszv9iVjl2q3typbkqQiDk3Cb2Td/vLdiFrSo3arO9NZ3kQZeW+JsZCsTXIeqdwjvnALoDnvOJw+sHFXU3fJlAiwUdQ1cV2OyCdZflFKUebVggl+F9wlRk2XWAgBNu+xVWtVSJBOOeZX9sO5lEG2mmUUUcxVLKpOrko4gOXIajLGusXml9w5+RwBu7op69VA9hRY3t9xWNF+byF14FyTXtdUbOHtbmvhoYwPDDdwg5hA/9BQUCv6YIRoPVcfbP/5Jqxavs7KQ9s/H0ZuqxHhdy4cpgL2hpE5ft4L8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aNi62PDD+aPLB3aDK6clcc9ngvv5j+facM7bVrjoSTOSsQhAcKanuMiXsKGS?=
 =?us-ascii?Q?W4UBloTg3x7lqeNVAho7EuEM8wYkUL70fVpplokQ9kdy+3BbFa3jt6QeWdp3?=
 =?us-ascii?Q?z/cVme2Ob11ZCEksgjA1LSGxwTYF4ZUFOM4XJi2iNlYGya81N6pQhdX8qU4n?=
 =?us-ascii?Q?0dAqC0hNucHUJZiqn/Ps9TGKhJlkx6bHGSO9d3tVEIrQlhtbopCS0p3o/nep?=
 =?us-ascii?Q?zHfAiX/3PhsAqogycnv/MHgvTG0jaHWQbfbmbWWcjJKGgK9YJ1CVmKVFwhA6?=
 =?us-ascii?Q?4HS+BUI1MFeAuUd4+/nKieAYrPHTdz3ox+1y8Ys5H0GKV09cMfwPqZ2ERU0q?=
 =?us-ascii?Q?sw9eME0gttefFEgppYD6kSgubeYOpY0k8WDK/hzt7UaVoF2n9qIWfp8NbTW9?=
 =?us-ascii?Q?dWr1woFQZdNEzPyhyjrm+33PFhe72TXuk/h67FdIEVmJJEDSDU/jokacNloi?=
 =?us-ascii?Q?fmivyKmM978k6IXlBWcEmc/lip5WmQRBDo2uBT+UDCQV7r9eKLP5dDvkAXsI?=
 =?us-ascii?Q?dHejpKSO9T5YMURHiz+CfpWe4V5/qWxqOAQej1JzSjcs9Sg8HEFejalAykt4?=
 =?us-ascii?Q?CiV+2EY33fayC8zvwoUduhQA53rOIfJWI4Jz1iXfBij38TvTylEctsADtMLx?=
 =?us-ascii?Q?6ghDQaiX/tB2nDl+37NaV224exnT/LzAW9CK9myVBTEGl6fWXsKA14MXBg6N?=
 =?us-ascii?Q?m3brbTptgv0wBoziSjyUE2PEVAztKLXUlsGZ3oDL+a2yZdKSLD+4IfpOu4aE?=
 =?us-ascii?Q?zGjB310evtXrdsogeKmK3XKnhRt5OtQ72B1cLzrP4Ta8R3nNsf87ZRmtlvOd?=
 =?us-ascii?Q?Bt6rvKHBlsX4b8NSiuXS71E0/HuiuyT2gUeK0uiRJR2J5m6NRqKBAoOVWO61?=
 =?us-ascii?Q?/tskm+mDyuQsVesAdqVbQ+2WghrWs08lnCVEJh+ywm9/8iFHamhmNK2tRQZx?=
 =?us-ascii?Q?yM6iSxK6kemq0Abgz3LLfu9CLRILE0QARC7X0xgTDzgpP8NijugUxkuQu11b?=
 =?us-ascii?Q?b4zJ/9+zMzWmA4HAi5nG37hrEeddYxJ1CzaSV+yRqRVK/vxNq6LufjBQDz7v?=
 =?us-ascii?Q?CrlFtDy8coS++Ughvc68edm4m5cAM/7ocpf+BFJlbvscnUZ2zMR/TZUjmu2T?=
 =?us-ascii?Q?6jgazFH//Uv0sug99vt0xCoWLl1+Dgw07rXhPweIojAv60MHo0wzLTNLP6xr?=
 =?us-ascii?Q?IvvWknEnMex5BmcWCryC5ByJKWvaosmjLDd07ugAfdhBNXwukfstg9EJItpx?=
 =?us-ascii?Q?uS0hzR6qSrhoMrrLloZan7Lz5GMnYOG44fmkQPfY1viWZbCMd1cIV9TmIYXG?=
 =?us-ascii?Q?qFITlByL/LbSgQAzkaVN58kRaoLOjf2aJqVqiIuzkA36w6J94A71FY6H9jyQ?=
 =?us-ascii?Q?fCxYQk+AnBQb45oGN0Dmnt8MIPONducEwXco5Nf2X6zRil8pRI+TvqaTzdtP?=
 =?us-ascii?Q?NI6AGwiHlAAK8LY5ta00DnGrPOhJuHFpbd1iSmFJJu0xltBQXZdTdpXoXtjS?=
 =?us-ascii?Q?czgYk0J27wzRMQOnTKdczZzNhDiwR2O5Wv6kPLGjTH+8IvRPzoeEPAtCazHv?=
 =?us-ascii?Q?B2I0AGg0Cv3OOwlmmW7yyuUpQ1lV1v0axQw+bi5ARV/R9e8ef9ezemU9MEYy?=
 =?us-ascii?Q?2G+2NMV3CmHiaH6EVwj5lZQH4zx8ThlJ0xqWGkco+h9SfzTOGZU1xUPVNUU8?=
 =?us-ascii?Q?UyHjtDyU6weULXmzS1otFwC/EYcijzAz/RoAcY9nR84iWHzSalKljReYcNwZ?=
 =?us-ascii?Q?SslG7iKQHoSA9y7jatlQxcR+bbE0gC4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4601ed9e-12b0-4270-d5ad-08df01c4bba4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:38.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMl9imFUUqzU+Z9KXe5yEytRzxkOaCOInfSEOIlHJUDWiENZdDDeb/PFoNmE/sC5PYww0n1RphTLHsCofQnmtPHFoDmZd5Zpu7YdyjzNBfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23990

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image.inc    | 4 ++++
 recipes-kernel/linux/linux-cip-common.inc | 1 +
 2 files changed, 5 insertions(+)

diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/c=
ip-core-image.inc
index f6162cd7..0bcaf094 100644
--- a/recipes-core/images/cip-core-image.inc
+++ b/recipes-core/images/cip-core-image.inc
@@ -10,7 +10,11 @@
 #
=20
 inherit image
+inherit_defer ${@'cis-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_=
HARDENING')) else ''}
+inherit_defer ${@'cis-kernel-hardening-validation' if bb.utils.to_boolean(=
d.getVar('CIP_CIS_HARDENING_VALIDATION')) else ''}
=20
 IMAGE_INSTALL:append:factory-reset =3D "factory-reset-helper"
+IMAGE_INSTALL:append =3D "${@' cip-cis-rules-config-${MACHINE}' if bb.util=
s.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+IMAGE_INSTALL:append =3D "${@' cis-validation' if bb.utils.to_boolean(d.ge=
tVar('CIP_CIS_HARDENING_VALIDATION')) else ''}"
=20
 ISAR_RELEASE_CMD =3D "git -C ${LAYERDIR_cip-core} describe --tags --dirty =
--always --match 'v[0-9].[0-9]*'"
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/lin=
ux/linux-cip-common.inc
index 65335238..25197910 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -16,6 +16,7 @@ inherit linux-kernel
 MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
=20
 require recipes-kernel/linux/cip-kernel-config.inc
+require recipes-kernel/linux/kernel-hardening.inc
=20
 KERNEL_CONFIG_FRAGMENTS:append =3D "${@(' ' + d.getVar('RT_FRAGMENT')) if =
d.getVar('KERNEL_NAME') =3D=3D 'cip-rt' else ''}"
=20
--=20
2.55.0


