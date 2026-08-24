Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D507FC5DF81
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:50 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13127.1787564863403657251
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gHKS27JQ;
 spf=pass (domain: siemens.com, ip: 52.101.66.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMAxuoQZcNRfSXVizZ8yBFsLHS7Vr9JCz8J7qTDu1L4emexs3xQvDClO5VmhtWW57oDpw5a0Sa8FvEDAoLm3mOLeKdQhswTXQ7yf42JbXPng4y6BXP0tX4QzoH1bWpMNUUFO3ptUWJf60nhFXoCJ8pe7OTS+i1J8LLYlaP+vILqqSmr1G4A71aIGLoX27gLQK92GwFhhWlquScqhM1B0rp8uacB9i1jy0OJ0F7cPwy3D38LL7z0Jy1Z3HvWMRMiqJAhv8QsBubjnpq2/YqgCVF/Fx+7uDAm0scEiO2WwOcMRUn9It1uX9cvENxitbLM+FqO5hPVIUgbWLYaDxAeYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r80Qa+tC8IpJ0AtrA5KnxJ7nOm7FtC3xUyz4r6FUYrQ=;
 b=A4WCJWoQMNqT4ErF0eIhBw8nqGrlOLZxh2FakKnqDF897KU761FEnxmqUlVUQDYmwHKnSdJXaOjW79BTGlTV8sG/LaiZLNI/hWaeTX/Sg6knyA5VIWcopedFwnhe6gJ9wfFlhdq7wZ/xxwBzEQ94vhYXULZ21A0aZstHwYdLSq67MEgGvsxJkweueeJZkgEtszKej2TSSsGtgjjJS4uJbvELTNDbY2eDFa7y+vbsw3EmatGRpqTVK1ZZpxj5pdBy3pS8Gd38enWOBQ+NIUKwmax5raqMIVmDuIXtXcvm25vT4gpknnI4j1gaJ+B4x32yFP7a32A8vtWzb4Wz4EZrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r80Qa+tC8IpJ0AtrA5KnxJ7nOm7FtC3xUyz4r6FUYrQ=;
 b=gHKS27JQChZhnFKepAp9Qgsv5PSgpc/a/Gzp5kCZNvvohmIVoWY8k6oeBiYpeZa/KUWb+9wtwaLueeDqBkRCwc8LIdHghhQnBeqixpbcHwAgphJOQYSFD0wcvODgA1i9Jqz+wrcAz2CnuRKSV1Jv/DdL9CmvEhL5newkyyzSPGR/eWKf9FOLy12sYM2DDa8fLifLcMR0JbSQr/kULHt/WPxLrsfyBJ9BwjMD2BFNElX+cvLheiUCMiqzOAWeJraIoY+ulwfvCCbP0khC79StTZZ/m2QPKR40IeWR6L6tZEby1pxvQLLg3go9lcX+shzqJJbHk5MKWSU63OS/EMsZXQ==
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
Subject: [cip-dev][isar-cip-core][PATCH v3 09/12] layer.conf: use variables to control path of hardening config
Date: Mon, 24 Aug 2026 11:46:46 +0200
Message-ID: <20260824094721.2636375-10-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51165b7b-cbc8-4c49-2f4d-08df01c4bae4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|55112099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	PpFUgbcONkEXpC9BsFN2A1DUfsSR3sQsTuKMmzhgwUo/rP5tTb1B0s1hq47mQhe3HXSaurSt24/DpypIza56Ms5YmdqJUnHsU6KmoOw34QrBz/1GUJb0Ay+Jtrlex5NAT8jL5eCqqjC6gI2F0l71uwZQrWapOyr8VS6In5X531QLcjBr0gIsq/8XluA78lLajUEx/T/GL3mLiRG9zYRe9uwRJG4fyp4MY9HHmQR7w+XnYpNvflncBhhJJjLXIZ0IDj4lBkw4+nt6plit7Mn6R81tS0nKYWbC8k86+cxvIKaFD3keEyx93Rix0w8bRolgaVyECd2G020sv6j0NpdloZwxSW5y7q4gU4bN0KU8dB9TGYob649mv6o7iViaM615RM8Xo2SYH9Ry0XYtV+GUQ2YnNtS1LDHm9UNpbqxmX/zvu2RUg0L105EVNmKnirLM+HeV/8KHaB/so5UEdayUE48FRV0YcMvPD6tXtqUVMjVNJfaCAE/49ZbhOWo0j09buLNqQNFeuXd5jujV6gdFIiGAWBDWbBEtNEjhdcgyHTgyqCSyVToA/siA1btczRRGXYYOHNKIhWHSnmzU2eIyl4dF0e2Dtr/Fv/CmJAh2MpYGYR2zdESihSg2LN2zxl4a2KV661l8rcIDrtbxwkSmt7r2wYYIKYz+DMJBvCMN7tM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VVAxLw42tUsc22IXxRZT7kSaGyu9BxJxaH8qrBk/ueo0oIt/pg5ErXs3cFNw?=
 =?us-ascii?Q?obN1a1HR2o8nQGtqP/3fkpfexyBkSyJxA9DeM3lrz5qrFs7vWahxFXIzjrVJ?=
 =?us-ascii?Q?r83ivXd3RyORLF3yjJlcN0mQniazH/MZOhLE3oU9iEVVLzC6otklp1B3l0X5?=
 =?us-ascii?Q?C+VzMfTX+4p0itoCtgMu0I0Cq8Hm0GCr8NbGwX7Fx4V3Y9r4RHjuIuCqCaCy?=
 =?us-ascii?Q?wlw15G1OpO1MdlmbzEq0NHXyb16r1m+GJcQdK8YOeK3iP8yDKvfNzwjHeSNZ?=
 =?us-ascii?Q?3fqPci+EbK64ND8j8v03RAWWfPQwYA8yqQXUL4DNedfNA9ZkoLiP0Cz29M7W?=
 =?us-ascii?Q?XMinj4AUDut8rmtp42UHR4/bp+T5UaleDUvmZcPkItO+Hwr6WR5+6HNwt9ID?=
 =?us-ascii?Q?4F03Wt9akFpePAOVheEcStcFDIfUa5f1GBqbRJnNet31xucoix0Tb7R6pHRd?=
 =?us-ascii?Q?RZoAONcinBi47rcdJYYIFtbSbhJraT2iYq3u7RcrifBYD0vX1dISR32GXnUZ?=
 =?us-ascii?Q?hvGKimnwCrTfkbF2d/DPWRul4eAMFm6xEq29a+O4zl+4rOhOEY02YvHaHRf8?=
 =?us-ascii?Q?cL8QX24ii6/pSM7wOMgGlXftLclJPiAvtt5qVtI63uHXSlsuyEdNaIneXMLi?=
 =?us-ascii?Q?afCv3LOaejiz1VwEjeaB6MCNiJIgwfGmOGPvAV0EFsqHAFJD7rNFlJfrSZhC?=
 =?us-ascii?Q?W+vQ6tc0EPTVNAizhyYmK95d4EyfSsfPcYy+dZWDGrt/wMA/4eTWV1hxhv5O?=
 =?us-ascii?Q?bwQCkhfQ86tx+OeLgUgrnm/Bu1VWTl2l36eJ8j+sVADRk/eYqEK5fDncdZhP?=
 =?us-ascii?Q?iyYJ/rOHuGaBFTRmrjGICQ25Zz/a3q00fAt2rS+J3R+/Bs6mGM0dNcqjp1ki?=
 =?us-ascii?Q?8PMgRqmDkuFBUrVBIYMzX4460t4SYa6dJO+Zdv3j6eGCOUpy8pdUxS9LxBWq?=
 =?us-ascii?Q?QZQylqrPBuwzCoNpdo5ryxdW3wG0l8CtNtdr/nqJUKZrftEDPNJXuKCLvTqv?=
 =?us-ascii?Q?msnboM2+n/dyY8i0ArgpOfLYqHBVjXhnzz245bESPHDX4ZK4yJ4zrQ+lQbXX?=
 =?us-ascii?Q?QMJjS1kOVfxPf+OC8Ip9qcnP2aOAvQ27h2545bXYTUZMlKpILG+1hsoez1Ep?=
 =?us-ascii?Q?XUSeU0yXXrowNeHdIcwjCuPEV/LvfCyIspOUO5T5wlCXlSnhTNC6dY0wu0pf?=
 =?us-ascii?Q?VzSIbaxug4QOytXQHmdOM8kKbMco4SDqPvHdCn9Tzb89ckmoSITqsqz0AI+h?=
 =?us-ascii?Q?FVVhSHVGpcrU8zL1F8Yy0PDr3cFKfX/Nr89Vb+ZEyrOWCIWrdHU+LX20na78?=
 =?us-ascii?Q?PQpROsxr99fFKfOiClvWIdeVCdZwBl2NUhuk0IYas/a4cP35Idp3pBHZbK3n?=
 =?us-ascii?Q?xo/0LD3bcRoS1s97Ylf7fwbWMa/pCgE4ZHJ1wG4arX2LvghaKp7h4Q3hlvS4?=
 =?us-ascii?Q?XabakF77VIapLOnoueqKT+QiJ2G4AoTJCuhdqcUbSGIORxgSq4XyP5ld8Flt?=
 =?us-ascii?Q?Dc3wqSu2j09BCS5qgJi96pjSxTamQOa1ZSZgn067h+6clpF+jQS5IxuVePGv?=
 =?us-ascii?Q?fDQZCkrnp77sdu2y+/6QVQ/13gGps2vUWtQI/x17WCqYlNWSkAKWmi+iuP1h?=
 =?us-ascii?Q?eLvvOR/a9cMGdcYP9SPx6af1/EJnLbbhW1irfM2lWc1bF4JF9yKfzLtLXplp?=
 =?us-ascii?Q?J3ROq9+Zp4c3BvZ2gXNjUUBLXBwCkGAeolI1vMG08h4vTEpC5cn72AcSXC+8?=
 =?us-ascii?Q?onqH4JieA0c3ZA7qH2lbx//9JSW/9kU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51165b7b-cbc8-4c49-2f4d-08df01c4bae4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:37.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjjH9eLTzTNwn2h1ycqBfz8fe3IgsiM1fDj3TrZWmbLftg+GwOiv80szmqnZeq3WYkOvgSR5DqhUgd4inxoc2FCs7qJjncTebqCg5bjcjFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23992

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/layer.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index c51c3af1..61e25b22 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,4 +23,7 @@ LAYERSERIES_COMPAT_cip-core =3D "next"
 LAYERDIR_cip-core =3D "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] =3D "isar-cip-core"
=20
+CIP_CIS_HARDENING_CONFIG ??=3D "${DISTRO}-hardening.config.json"
+CIP_CIS_HARDENING_KCONFIG ??=3D "${DISTRO}-hardening.kernel.cfg"
+
 IMAGE_CLASSES +=3D "squashfs erofs verity swupdate delta-update qemu-emmc"
--=20
2.55.0


