Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2062.1794213697227911615
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 00:41:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=EoHVRKaI;
 spf=pass (domain: siemens.com, ip: 40.107.162.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RY3xjJusXhE9WPxHQ3rjH+3S6irZjS6SgAGbUSqdtQaWT1vQsBRXQWTni+hoHAe4c3XLSCod/wMR99MsDjc/3kNdxBuSnRuwbowCGQO+8/ObNBk9hJ8BUi+IF4mVj/KyL9IldR1v8dkMIPXDVQdE+SoJ7EFPpIiisxbvz9fUdC5SCpYdfTkjHN6XwGr3zNFp9PH0DkpniYSPt5BKmXZ+kPXPnT/imX0lJx1Okc5qdrf2WzWe1cQT+xlQ08Zzx5YB+Sre7AFEQ4TBNknTVHZeBzPWw2P/P5esz4JjZXmdVoXbNvsNeLHOAJy5uF5Q3f+tu65+Xi7JA6dWFf4HNI1UEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ8kflBR+q87eoYBGFgTlMpXPyz5vKcNbWmLalx7dYI=;
 b=mll116QqwHg5s6HVu2h/BWgQwdy074l0qPF5SHlKtbknOYcqlDUDXbmQzUgnOw/MqG2g7lcL9q86s9amV1X2e4NMPmvs16M20wCUmj6+1VG5iW3vw9esTwXAMVHs6Vgi9sMvvkjUDjhqUQAyYLU4gNm48MkzaMbeMfvwb13EXDwnDKz2Yc0i0Gqmg2MtfDkO483LufUsnVm4znSU8N/cOkBln2slsa0v79GCATZy/BrWYxM5kgupYaVOE55Oddij90D7AG0H5W7bukPfBz+SG8pk51zWGrnueUGe2lsvoA+Nw7vJSpxuAihZ/k0CUboVu9JpHNboTGY6D54vFVBGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ8kflBR+q87eoYBGFgTlMpXPyz5vKcNbWmLalx7dYI=;
 b=EoHVRKaIURMN6A3misC5M9B83yDoZ4saATz42aNFId5X7u+0C53i0awhsi1F487BzlXage3X8Evo941xEbNZdc5jLgyurhRPEb3CwB8H1FZs3dN7H5SkXbzKg+M5h8nbYOhZ6DtfsepWrtXRBV0Gg8ES7nsTuzpFy1596/V4VIyhh9/wrbDVcm/GYSXWymPi+kbsTsg3bcSO13sDbGU1B0boZErgQxNVwiMa0ItRQpyV2zMK+wwtrGejY0AyaSERLpW//6h5CcttzeJRA71f854aA0F8eZD7vohOTCs7D/kX8dCJoJiRej0cZczSCn743VragtUNQToc152NsCG0nA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB8398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Mon, 9 Nov 2026
 08:41:32 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0615.007; Mon, 9 Nov 2026
 08:41:32 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] fix forky tests adduser is not installed automatically
Date: Mon,  9 Nov 2026 09:41:13 +0100
Message-ID: <20261109084125.21199-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU4PR10MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb1f1da-5036-4afc-ce21-08df3e3d4175
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|261102123227099003|261022115727099003|261021123027099003|261021121427099003|261022075727099003|261026121527099003|11063799006|56012099006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: UByaqGqo8hp1+l8RXvSQ9Fbw1LHvfJEqqNEuHCawTWf9SfuHH1sTxZQufvWZjfzSpxVgtN1Ow/snaQrNm+51tIgB8ILMExdFY36ZWfehPhTQ7LWP4vj0jiwGtC3EMIWDhfkxg5P1BrR+bI+ifpdXiclkQh86tPRhlYcgR4pqKItLPV07lDTxcAB8JQhwOhSOYmOM8S4Umv7jSKT6Ojand0ubHn7LR/TSVdpQtp3lE/wwhGCLzhgTNo/wA56ScmcNk2SScZotr/kiXBdySHIwF1qg/zL7SL64DzvFLWjbqtHu5fB1KP8oGL/RPp8y0I4RifNyRVnrybVl+ByE/OB4kvCs64U0HHDPLKeaexe+LWY+RCJPZjBamc4ga5U+M7ClihZLT+/1us2FllGMe/lOGN0EbejEA4FzZ65Bzig7QqvCbtH14tFmPsXccctoekSpROkabLTACCbHy2fMSdZbJaqrECTBcZ/nEU7NwNnoC+yX36sVhXkKBUI3Bwufb1pvDIsuD0Pgr3zRLRr9lp8P3BRwt/hE9s3pnpEp1e7G3/RpPIiZNxdPPsyNngD4kEwWpq2miv01ez/e4otZ7d+/Pyd9PlK9lINmUFezyUhrOZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261102123227099003)(261022115727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MGf8KsEcJE6o+GzImIsoz5OUz3hplf9uXwvp3xbNmJRtwR191+o5KK0n5GeC?=
 =?us-ascii?Q?BZKvSno2fwT416dbsBOsB/ifO0/mqVnSPLln1dCAmw+3IlOXrwtfpfTc92hE?=
 =?us-ascii?Q?wBFJmWapzUPGNeSH9xGZGa5iwvWDZAJAU+udu2TutxlRXMaxqw8iWRXNRMej?=
 =?us-ascii?Q?qUzWHzauqhaquXYyHY+IE5teNY+dzScjPGuQ5B7yjMsqY9h1WnuuIFCSSadj?=
 =?us-ascii?Q?ycipOIY2mbR8GnrOc9YrPiOphGPo8+/U8saKLVpLbfFGwXaSX7oHVhM7/MW9?=
 =?us-ascii?Q?X3DOBb63F2pVtOaVGI5xLgzgwwG5sJv8Xn1SO+fNiZkLsgUhmn4MHQWWVeDK?=
 =?us-ascii?Q?AQa7CD7z/RBsbbDIXWS7ts3bvHBC+Hc/bEPA42uII3p5yOowU3gkzDwcCbe5?=
 =?us-ascii?Q?+7MzpiN3XVSbAKIq6x9BjngGgBmhT5bvZc7fSYHbUHGDGj4qChWkYm8O3Yc4?=
 =?us-ascii?Q?n91Z/2hLy35b2sRKwcEmq0SUd5UiHQJ2RznSqsrbeAFVEjsiLQVtsQKXmIrL?=
 =?us-ascii?Q?l4A1em+UqYoExAMuDbSmIHucxuo0KTmmy50330pk+onx515/+O4F3U04IQTO?=
 =?us-ascii?Q?gHoXp6CTjgg5ykh+D7h75cmoV1dalR/XAcNl4EoCVF2XVAgfoVQlO/Ye6lAc?=
 =?us-ascii?Q?uUSOC5C3baNKqoLRM5PXQAjT+Gry94TwOX1xsEOHyA6huirzwPjApoxhMrOz?=
 =?us-ascii?Q?RFKjzGV97yS4pLjWmUBkX2nj4AIIqER4ukZIok36coF5pbps/Nl4caC2fEXr?=
 =?us-ascii?Q?65kGN4Z8gheFkpGCsqK4OShKaZDWQfSWgALaqatcDogPR+bxVALzBMPsH0xW?=
 =?us-ascii?Q?9UTEsp8FqSrcGtLtDsILbtQD+/vVTXc++E5eMW+gm+7AKYVMG4nJinTCr2cO?=
 =?us-ascii?Q?cMSOsi4gXdII6HQthnRtpR/Xk4YpVXObXUxc93/SoByLKpTzJ9ypVLawQ9J/?=
 =?us-ascii?Q?kHh4TsRTlZAcW61KaH150ryo9ElI2aJP+2DVLUbRRsx+uoC6Rlpgs/AkYVO4?=
 =?us-ascii?Q?EpKHo/XGHcNvLLMWfAWW40wITo+t6GNHiq1cgLnz2te/iDi+wZHYoYqHzE0N?=
 =?us-ascii?Q?3Ytpxmy8PPuvJzOawOWRsx0pFi390r+pbaJzUzNJuvIjVFyF1+AijJANCJq6?=
 =?us-ascii?Q?AEchxfkWmhDeqGkysRQOJTIywkvie351tyfsH8LcvOwoaF/S9q7x8cmIdllm?=
 =?us-ascii?Q?XpDqZxZgL5zsu9LcDRs36ZQ+bSuq4u80OOHaOmlcR0YmLeDuVWYeumF0bws6?=
 =?us-ascii?Q?WKBQv4sEtXMkoeAGE5OwDJai+3uWCNk4AsGgXv7COjUkLJFnJ60tSJEWTZPv?=
 =?us-ascii?Q?JGIhN3F/NpkpCbKoaa6RMkX3SYBhZEVeo+Nr/Y2t0YcxwlJ+7ZBcfmHsaPtR?=
 =?us-ascii?Q?G36Gdh2kDzF9xi0ExTGenaLehmJ0WOdBBhAOQ26r6a0Pbs9UNS7e0pdxxD5i?=
 =?us-ascii?Q?WAGf/Yo24LyzZPs6PYl8e7vhCdM3O51/4vfqc3UK7jsxXn1P1bJ1aZcgfpxH?=
 =?us-ascii?Q?JY8lvr2CZH7OoW9VlCesP2BdJr8vEy0Wtk15IuETbY0vIb7b4+WSDtjhcaWe?=
 =?us-ascii?Q?L01Ico9dbCpsRkJLCIYGubM4M89iWTBFiOKhz7Wr+xAh0TY+9bQtgr+hRvjw?=
 =?us-ascii?Q?lz/Wsyt7bGto46lOcWrJJKkHenkDWZ9lXGqVqj118C4a00E0codDtVn6WK8O?=
 =?us-ascii?Q?Coa0VFzw4fFWFKVp6YPadA4OPkMX8xiNlaSegdGF1tCPDhxFSsUPC5UHmkk9?=
 =?us-ascii?Q?67SOKv12QVsZMoeTDiXwK+OnQrr5fkw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb1f1da-5036-4afc-ce21-08df3e3d4175
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:41:32.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEhoAQasd3LPwFey3ftbbtqXvmmic77f13HalSGgNGBso4XvAHwop7qbEqb1GyoOA+YhoDaW+5ipW0mAEsQiOadfGCCP/rRDKHZUfM3LVTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8398
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 08:41:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24687
Content-Type: text/plain; charset="utf-8"

This adds the package adduser to security-customizations to run the
forky tests[1]:

```
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3DTC_CR1.1-RE1_1 RESULT=3Dpass>
TC_CR1.10
preTest: TC_CR1.10 Authenticator feedback
INFO: openssh-server Package  is installed!
INFO: openssh-client Package  is installed!
INFO: check_user: 'user1' exist
INFO: Deleting user 'user1'
../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
ERROR: del_user: Could not delete 'user1'
postTest: TC_CR1.10 Authenticator feedback
INFO: check_user: 'user1' exist
INFO: Deleting user 'user1'
../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
```
[1](https://lava.ciplatform.org/scheduler/job/1538035#L1072)

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes since v1:
 - Move the adduser dependency from common.inc to security-customizations.b=
b
   to avoid unnecessary dependencies for images that do not include the
   security customizations.

 recipes-core/security-customizations/security-customizations.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/security-customizations/security-customizations.b=
b b/recipes-core/security-customizations/security-customizations.bb
index 90af8f47..e5855a4b 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -21,7 +21,7 @@ SRC_URI =3D "file://postinst \
            file://ssh-hardening.conf"
=20
 DEPENDS =3D "customizations sshd-regen-keys"
-DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, libpam-google-authent=
icator, libpam-modules, libpam-runtime, auditd"
+DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, libpam-google-authent=
icator, libpam-modules, libpam-runtime, auditd, adduser "
=20
 # Append PAM module dependencies for password strength enforcement based o=
n the Debian version
 # - libpam-cracklib: Deprecated, but still supported in Debian Buster and =
Bullseye.
--=20
2.56.0

