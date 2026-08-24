Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95C1C5DF94
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:50 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13127.1787564863403657251
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VCd2kKOl;
 spf=pass (domain: siemens.com, ip: 52.101.66.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcjyAKfoUzQQEYpXQHzii11pY/I/UkkZ7FSckK4qPxwBv6hN3ySFQmjv/Iy/7BkeUHMBCh1a1h8a0m6QLeB/UtFYjRMkusFY4tLVsvsr8DS1c7zkbF6NomcM/QMxnSTniLq+xchKUodUDCoAAcsAtGUFHgnd8KTw+6nNRy23FE6ZlNU5cTlq2Du5fKLNmJ0aqkwazKfVG+ZUEZBONpBRGYXfLIAlZIpuu08zlJeZnIm4B4XLNNEDdkpn4gcuTsIvvTczZ+safXucn/c8C9W/tsc/JoG1j1/nmIwWwjLAZmkxzASpCO8VqCR+kkkUA8jP/qabqozj7/wsIJj6KYbRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77QEiqmNfNU4uvXocWa06xPAOdzwUpcYvfp+ay/WN7k=;
 b=R356pkfrpABUrM94ISGBbFqCL6jmHNPDW73s+WPnBXK8KBttMVW3tufY4XowFhM8SwnIfBsLl0i/jivDPcx8Mp3Ol4g1v4owGH7t8ZwVW5feTIiWPvmKBd94Wqf21EWj+l/eAf/1Roqch4JniGwvIbQWeaeLYKt0OvhV+cwg7VVpLfk1boVKN4O1H6gR6vr6tn3Qrl30cGbdJ/xglM18Fa96NWTJwvpd1PQsQzKLGO3vJXIjh1w20ZjbnPPyf/VpyCf/vKDphUYDU3KrNYYS2Qh9fGau36MTRVzkr0BCtmyxXfMb6t0bxzQ5qLGawxLajfOMnqwn82yJ5inQjd1Tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77QEiqmNfNU4uvXocWa06xPAOdzwUpcYvfp+ay/WN7k=;
 b=VCd2kKOlu6Sr/d2i64HI4lQgRRLMmOxcDdU6gRnJtv3+XKr+l5wYYSpMsc8nK2FaWh1vyvipidcvlF5aPZ32X0bK/SAgSE0o4Q3Hh5AZvSXR73e5/L05pBqcEDixpnr2qPtUeJ3zD1iX/d2ENdEA77ciBtklUWy2XP9VGKXLK4yggcyP3Pepn0IRifkAt5HL3vjspE6UvQs03Ku7GnXD0wpFrd0XUBn1uqDr3nbtY5YquYIbYhvQ3ncO1dobPBfltwNRtXiayJo+JhywD8/K4l2PS9NJIIG8N4znnjKDag3owyCztHEZdppF/mcVKS+KAlvs9rA3XAiPkWHO5q4WIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB8PR10MB3738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:40 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:40 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 12/12] Add Kconfig option to select cis-validation
Date: Mon, 24 Aug 2026 11:46:49 +0200
Message-ID: <20260824094721.2636375-13-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5627804c-dbb1-4371-5e15-08df01c4bc91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|6133799003|55112099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	9Z762RuwErBm72oVkt450fQXJNRnNb3JrhwOWCXeMtrRybKTlWvLnOallXSEzyY99Clf6nAdzZ7IAKlIBRw8ZOD5P36QvnNW/VuxXRZu9QlMnzRujcGYglpqxsD4xOoOKJ5f6rNX9F068sb4ufwj6yJ0mme1chG8K56fGP1gEx3d5IAZNGtmQb9dSnlmn2ybTiyrFpFAGXYqou/RgBDVEFKyEOKLuM5zqAaFOnMcv4+3CF/IOfArf3TlGHvon72Jxl4kgdkpvfvNGCqbmJaAcFX8bs7SAE50gKHwx10SC8lFYWKlSgt8pj29ZR39X09wD550qOpBxqpGjWG5LH/x1T75UWqw8TmI+98Bdm6cfV8OSYu9BuiBmPnY0QZ8NBmoY15w1AFjmeWbfZ+Yzg8WdOwuUBmhFHM0EL5Y+y9+UubLpKFKJgnwicuXPTBgFV+gO7WayCkn6dNTU//ePbRA+81X4JIBxBhbxAwymvUNI0kxB13ZBCuS3N+Wvg0lPosz50TW6QQVRN9b7aolaMsm4Oxfv2njXYY0V6bmU26thxV7JTh31vqf2DuidGjSpcO2uquCuzlHufhtGZRkzrb4+k8ql0P3FsyqMxaxHE2U84W2d5k/JsNQoKjDUuAaHIM/8twY88yMjzwGw/8fOyy+3H0LUDOnhS22OxZF9KKtyVs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(55112099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8QF+REqzohP1VSYjya67TwGhaXp0/28/MigpylX2gBjxTPqX9diGkpct422Z?=
 =?us-ascii?Q?ZF6zXD0yKNuCUD9nKpQsG9eCWC4NHKm/gnoV8NTg23Ka6zRJVGmdfWDSO3X7?=
 =?us-ascii?Q?gF+CvmQZSbjhXv/b57+8cx8Xj75XpQasuFSN1v87SNVJD6lhJpoGe7cQUEAY?=
 =?us-ascii?Q?0fBoO+hxvvx1OmYVwdj3GzAAm/mopaEQUQzEEr8PSDkoeYQil4dXOLRUgTrV?=
 =?us-ascii?Q?uF6BPa9mgcQTBU656NRNJjZoX+AmJX7seekJaWbNpAPxLq7T1K2kkfCcBhPY?=
 =?us-ascii?Q?fWTTXvaOU/olwHVIFTUw+OXh8QGdU+wT+AyPUHpqmIY8OoOzEsAsBWnU2DL6?=
 =?us-ascii?Q?ds07z27mG9VKJ8DgzlNjRj3Od70UUcdTH+bE33ex+LxUH6wZMpzJQslRlUEb?=
 =?us-ascii?Q?AAPRDyi1erbBPUBnYoqmHBy+Q3Qy87L55SC1JpCU3xQDXx1OS3YmjN5aXnsU?=
 =?us-ascii?Q?JOh40WIwrQIS+orFhE42qBRgdgfslRoP/J3LiEM2fqfqXe73oKpn/jUyNC6l?=
 =?us-ascii?Q?byCCYQWJoaKponexeWbddazj8GAJsXN7DhChOuy3NGZ1FKx6wcMRHYFaMODe?=
 =?us-ascii?Q?SQFoDQH4SV43aj9G4rl+s6GTwV56KlqN+KZTu4mQi/6nesPGnQLO0wByeaS+?=
 =?us-ascii?Q?HYoxVJZrTGWb98qIRFaxXK/6ZaD4H1LyJj84hXhA8G+uz17c+cWpwYyqAyI6?=
 =?us-ascii?Q?li9oWF2O8dd5B7M8RF/bAd7RN4Fvb1AcxIDkiDdL+xvbZzZ6gRtFl192+F1J?=
 =?us-ascii?Q?bhSE0b8/gR9TgRmhmoEkAqk3UV3Ud9yTqj3+rqupmKPCJZ9Z03hkjPsGHEvK?=
 =?us-ascii?Q?EbZd7nIP0vygMVgVsauKOWRrJtx/28C307BdfJJtUMSCkZF7gioBJ22Oyfgk?=
 =?us-ascii?Q?512ukPu2jMaGNoaLlj3+XbztyF+SfxUgwpLGUwaGWw8Wile0mA6Dy8NMXuny?=
 =?us-ascii?Q?pDUr+9Wa/7Tq8UevyQ3PbwwoCftSbZYQUDyI8y+UPTaef7ObsMDoSYlIJ+Wh?=
 =?us-ascii?Q?A0rvp4pF3OeSSi8T5KbU5Mh/qH8vKjuVd22gQ9tjCZ7fpAM92znGpsIpC9Qy?=
 =?us-ascii?Q?2Xrug4UeCRsR2fEC8sxYKzchPpizx/507rEesh1tVIJyaGkqamXsOv4eyurt?=
 =?us-ascii?Q?cgfljpPAUDiFEU1rybgBZ4ysIGIA+QbsL+kj/FurJ8P+AaXW6yBxmuHlRAva?=
 =?us-ascii?Q?/OuNvVzrbrLIX0dPFHSQr8PW4NVpEtxnibehlzPpgfqNNT/xOLUTJ8IdFhAU?=
 =?us-ascii?Q?Q0TUdHCtG+sjoodjAU74Q0ZUAO0SniGNvPWwWxwDvW4E/APbDsTo2uTPNAbr?=
 =?us-ascii?Q?rdMPq6+6bI4r7burv8ua44PuO073WU707An6JDD7OD4JOoYLFHZI2fPU6lux?=
 =?us-ascii?Q?x85SrGwb45YJP3nEAQyGthpLDGe8Iu/qIUT4KKZ8xMLkE2cb2q+EOIM7FrOW?=
 =?us-ascii?Q?vhuQomtVBR+uEnrxWJIKUV9p8hTU2729AW5Uc0JaBmRvCbSGF/rNdN8wNcoF?=
 =?us-ascii?Q?6mFPtqgas5/xWErO8pHS249wo0hGcQC4LbbkCBlaRSECHUyN21k5w7JGeAGk?=
 =?us-ascii?Q?GOM2xVj8foKzLcUqd46a0u8NOYJM6ullga/Ykc/jE7kTfkTK1H+zpIfm3Pcu?=
 =?us-ascii?Q?Sq2cgAgU910exU4Ix15pP7uHX03WGZyqfvvm2nT410faAFYpT+UkghjAIpO0?=
 =?us-ascii?Q?nsgwpKCDnOX+VopR6cCy8VIQmcKdYfSrFc3oGUCvvjg1g6q84Lhr6wQcT+bz?=
 =?us-ascii?Q?AHg6ZUjx+Fww9KFdloj21E6f5i8cXg4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5627804c-dbb1-4371-5e15-08df01c4bc91
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:40.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKYhfuVP2QR7vOpz9TmXSPCPmbcRt9dV5e1jr8wPyRFcObgvy38buZ43Bxk6gONS++GxhCIOCpXgzxNnG1iWlP/O4Agnwu9Of8muRzDSJRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23993

This is for testing the cis-validation.
The following rules are failing as the prerequisites are intentionally
not installed:
1.3.1 install sudo
3.5.1.1 enable firewall
3.5.4.1.1 net_fw_default_policy_drop
5.3.1 enable pwquality

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Kconfig b/Kconfig
index 19f8e24b..87db5438 100644
--- a/Kconfig
+++ b/Kconfig
@@ -368,6 +368,12 @@ config FACTORY_RESET
 	  This adds the necessary packages to request and execute a factory
 	  reset of the persistent partition. See also ./doc/README.factory-reset.=
md.
=20
+config CIS_HARDENING
+	bool "Harden image according CIS rules"
+	depends on DEBIAN_TRIXIE
+	help
+		This hardens the image according the CIS Debian Linux Benchmarks and val=
idates the successful application of those rules.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -384,6 +390,10 @@ config KAS_INCLUDE_FACTORY_RESET
 	string
 	default "kas/opt/factory-reset.yml" if FACTORY_RESET
=20
+config KAS_INCLUDE_CIS_HARDENING
+	string
+	default "kas/opt/cis-hardening.yml" if CIS_HARDENING
+
 config WDOG_TIMEOUT
 	int "EFI Boot Guard watchdog timeout in seconds"
 	default 60
--=20
2.55.0


