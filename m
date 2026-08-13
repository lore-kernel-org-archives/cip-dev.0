Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A18C5DF6B
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:38 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16258.1786617575466080224
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Qxvytpy2;
 spf=pass (domain: siemens.com, ip: 52.101.83.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSVRdTswhuZl+P0Xv2mjmMItZjoakrxAupHU5rfBubdsIkZUQ6C9js0rO4DiKqcBNqAARJ0kcDFbtFslE26EI9P3tsrRwxdQ+xJVybPue5bYxBDmRMpZ/0Vc1JdrJM/J0WZNG6BCisqvkqea5/mv8aRaw8nNV4s1MO0yrR06Xo6QyILDzM/vVcv/AF/IhoKqB0WoWI+ESfZGckDm+pI0UCZ1ywRKQHr+OKfyBW9rfwiEYYqEifyK//6qxnnWmf/Oo8V/VWM/rG55wCWCRu4lFlp2Vt9iQdEajhYdxFgh2Megc9LOgrOYSv5lVit6MIq0n3GfkjDWWaWAPHuKDKf0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OorSbSGAtn0nHqam8D05hJMcJcwKQFehxU7TvWbNUxU=;
 b=S7YhhtGZIjlJvjk6A999zyOiX3QB+457qr+P1j2gs5LifDGxN+pge826Ve8dG1Me/A2xRGvxAS7gI0S2NtzacvWpwFvHrYw2c7DK2Mu/vOHNqGC1ImW0OG4eWJ33sr10RcBH9jQ3uSpxMUtAmr9OHWajHwPlmclxYfW+K4SMPo/iZRRITzibqkFuXKQfckfsJAlL/O/753ANbl6rSCXUMJhbEQPUlto8NKCMBDiOzip52vrFqdQX87de1GNNipxuFzXvC958ds0hdPDKskEZhToi9Qlzmb/PtpIIgyncmzRLPtiQaCzlPf1DPn1BLdGWhytDBGq88iSrV9MAURugow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OorSbSGAtn0nHqam8D05hJMcJcwKQFehxU7TvWbNUxU=;
 b=Qxvytpy22+n7pYD356ziQZ47YmEoAdH9k+8dT3dVkmvGgCNm/SKRGMHQPGysxCcyL4hcrHp68b/zlTaBawTWyM/QGKuEn26Wgakd/7g1DSzRC/LNP2hmByPRwT0yKhAaZ7rVoXirvB2APwUTzE7wuakdfHzw2T8CEFFS/ZPy1fYdsTl0DqmbjZkLNU/No8Bpy5+jMNU6HSWlZOYenOKcbPe+08Vq5LJ1mkuYEH2jFhbdFC+w9tyqQ99lk7U0P9Jgwaw1hN1D7SVSahR/zYQhFD4kcQOV0Jv6EkBbXMJpfse1uoHfPDB1e/bynor0Zo3jlVY6izTnihk136UFMxdSgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:31 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:31 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 06/12] Apply hardening configuration to the kernel
Date: Thu, 13 Aug 2026 12:38:56 +0200
Message-ID: <20260813103919.184402-7-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 836e2ac9-b99c-4b33-6d65-08def9272871
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|55112099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 
	2b4Vq1CDcmbZw10m0T5sMyMvqOHbl9EMX6QVwJ5HvJINkyr4w/0HYf3v9RRwJ5qqKRzT1nWm84rOCgGHiJ99v4rwI1nLUVPdI0/CIqlhfdFZwgmTNy7MjWkQsR8zqNzRCEBxxYM0+1ot9hLfTCbj7DjKAO+fXvUG2wwykc2RY7Fb6DcOBemwXqsDeLroiLvcEvKYjNSUp2pTaE/HBYcbejtgR98TZ/3NnL01DmnEKY/6JCMHhb3eC9RlTEpUchYjl0aWFm/L6zsHos17C+QckoblqagVv807bdJAnwqeDEQNVB8IlDSmdQNSKeLEOd3vVcZC8JCdMXp9sP17GdRv1MAKwBGbWTLSq5cS+vknkT83anYyprQw16pv7WZVlFSmax52UHPAi3098T/8iNYJi2JTh8gRR7Rk81bn4QACsrtopUjeTcXOkuDXIw7XVefInCVd4zPylUKTPKasjUc5uQREIx3pcn6UuESxy1AISYjUnMVuythqQFt06paL6ROPOhi4/7e1PHguIBNLpSKBYlQa+eZkXU2dCd1oOJQvWBq6sflrpLVOZlJfHwxoT56CUM6mp9UeyY3ky2lY+Rutoz3xlKjvq6wAL+/k4eLKyuVg/cpNtf+vU13s6+tCNjFMJKfzclD1nTw65UmzWMzPkdoIsgXr+u6CQgunWLdq8ZI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bBqSoCcpzvm1Ezj/es6v+EUhExPzfNP7j2nXQZwN49lJJLQOw31V6VvA+a45?=
 =?us-ascii?Q?k0lobvi47XKaohI/FqMvlpCBCEWIl+jlEoT6Ho1JB6IEPPW5zv9/KaUOaU3Y?=
 =?us-ascii?Q?5jJp1kXHy1fCFMvHViZlkWM3Y8g9+HZvaRtVIOEgkNVhOYy6jRFi7p2WoAin?=
 =?us-ascii?Q?1LuuEpcFPO3l0QCbHxni8+biT9y8LQLrp5J2ekAXDMiFXQ9wB4EUMdPMbplD?=
 =?us-ascii?Q?SDgXKMdyC7NX3jPBMlc0i8t1dMM61IOUA6xwKgrJD0T5JeZYcCflqmfkObmd?=
 =?us-ascii?Q?q7QRfH6iHVLseE3PhrsRkf6EgaTBq8pBBdPeb6TLpZSQ8h5ELXJfpUz99TkC?=
 =?us-ascii?Q?GxM+A0GrMlChpFrln9JcFx02W5FYUoKgLjtTuALuTrYRB2NwN8DvNCm5Q7dj?=
 =?us-ascii?Q?cWQdcKgR9lQK61R3eJrD3P9E46ir/ZF8AL2ir0FYh6QWnmm4VsvZBd1Ffq42?=
 =?us-ascii?Q?9Vl6r5PX0xx0UeBy3/Yy5L6EPI/7FSlTc02jh3rOPa455JNpK0/yvqX4NpSH?=
 =?us-ascii?Q?dAcjxNjAjIpIZOH9aHFmjnPtHUUxSZkYj8eBw+amKA9oOUu6520IQNm5yX6Q?=
 =?us-ascii?Q?6G2NJBN18Nb0VLmWMW5uYHccuTLwBLHDNFon2+NYnXRSuVopXoLt/OV0B7YG?=
 =?us-ascii?Q?nZztLwQnOsxokfPpk9CP35WS+N9KYGy3mNwHpqUvIsUTAxQWUEVXdIzJWWmy?=
 =?us-ascii?Q?fnCTKKaSEhylhx9G/EdoMeSeXrc9V9WnqnHOn9jD3JiY10z3JeDi3kUL9adt?=
 =?us-ascii?Q?WExr+D2AKvfClUcI/JvD5E4shtLGarK4z8udSaMLCVwYtXY5it5SfKrEbhNR?=
 =?us-ascii?Q?q76kWynaCsOjGMuObwcm7Y4f4E60Tto3K014UosXpe3lHB1xvCcHKfzHNWph?=
 =?us-ascii?Q?Ir/J+K4P8pDVJZTDF/kJzOt39lkbXiYRlTAzawv1A699XZ3OysmAhyDGjnjL?=
 =?us-ascii?Q?dhOHP6l2Y6NQxKcUpmgX8VhxWPjKRsIlXHiLE+cuynHoOYlVdxsVbDKgH9Up?=
 =?us-ascii?Q?nVm0//WwCW4NCSIcdnCtZBMDqzmDHcO2Q8XQyn7o606P8P1U6ThWq8HnEKGv?=
 =?us-ascii?Q?CPoPNUFayMLMiyzE2JhWuozsKZ1ijVkSdNTArRZuh8Y5faNmqT+c4NReu2tc?=
 =?us-ascii?Q?JDZRfuYJqu0iy2+y3vhlt3EnIh8Y344qNRI0L6W4TErzA1rW+FFyV7kdb3+s?=
 =?us-ascii?Q?2BeK2fBPpRCYY38LEWfFoUfJv+ZTB/3gkek2SOr35imzl0YkUrMbg9IO1hUF?=
 =?us-ascii?Q?ETr8vFWQwE084z1W02rpZu7Y8LhOab2nw6wpGmHc4yMQdavF2YA4nLeJAVyL?=
 =?us-ascii?Q?1cYJ1gOvgyNxUSm0ytZqiMEg9Qw4cytbLz/ZshvhDYlMBvgyUlvf8bE+ETrH?=
 =?us-ascii?Q?Z2cIhjsbQ7SzYngbHSk0JbdLaLkODuhyTI6e8fWhx8dNYBlNP48HdFKWQAoE?=
 =?us-ascii?Q?vxhOIqBocXxpQA+yJ6UZvQk0yaVZBclySifGosM12SZhrkZ6lmC7/ZTufMui?=
 =?us-ascii?Q?bWd6VrL7uo0/QTyWH09z9V2nuA5xnhiakZAecFnnkVfNZAUVk7SEfI/zoVMz?=
 =?us-ascii?Q?BtPg88KmAf68DTqyep5vkw5R12tfV9a8Ls6/ACgir8bNOkBQBwDNehxJ5lGH?=
 =?us-ascii?Q?M1dURRemeJh8YsOe+oC61mG6+AqOLdfsBgRvtHW+3gQVluPD9bh0Fa6PXLoX?=
 =?us-ascii?Q?udFjM/RopU36NC+zfGXoV9uzNaJ2Ry0iaXvWGpTmKR1f2JMitG0FIRYksiWa?=
 =?us-ascii?Q?nbZPEG2FZh+lJJI94KJwMitgaZEeNAU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836e2ac9-b99c-4b33-6d65-08def9272871
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:31.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyNaLY6Z7jJra9Vx2c3BXbtELGMddhrAthtC+RRiLsFjRjIpt8VTgqvJd2rcKk60uN0ro4AXHUFfXNme0abnb+H5PwMhgYk5AksnzbRcSzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23922

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


