Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18D9CA5FE6
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:20:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=f0x2Xvdx;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKASJwzjJtDx42jTgvVsUdP5haYTzYTS0XyvSH7b+EkzuLLnUM4W2HYh8b2jmBZ/13pEkp9X5WcG3Xyd2bAyjXClTZH3ZmMngQFVcZjViULv3vK2zrNJJNgKLADEqq7DyYoFA0gQk2Lezxe2to7d1ZLBRC8YKEBjDen4b+lfI/KGRlx9UnB/ZXIVtGff0G6RW+0UD0vDAgM0mFQ52Eq6a/tZ1Ivco9jVjNxad63R3lmtW5GjpjJRVHFc3jT6x7uuX7igoBAqOeKkIwiQ+1kuBukqUZjFcgEqeyYA+w9s5zV8eW5a1RJbt2lPtsm9pDz93QeXKGKXJW3G0hNx6pSAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZlBADfOUxDFddeFjHUWtgfpEfzTM61wTQehI5ucFJE=;
 b=Ey2jhbserOVEaaZTNsg2OqoVOpurwfWmNsvtsifm/pvjVP5aU5t1PNL9eLykw5NOQVgS9XnlfxHIINCZBIBnEbOLT/SlnV4Rf1ziVX6a7QLcIoF/cpQA5kXZfplWFe648VhmfIywDPyk0yE/gUMn5kNDokB+P8kyNrCaW49e4d/uQAJ+BbvrEtS2pVKUEqnHeg8ZqsIAQ0OreyLO20OkXLdYruAI9F6VOIWDL8NJRtkEkGdHprGwdGNrf2Ug35be1sR6beD7jtBdAjxf46OtCSK4YIhXaa4TohYN+U/SD1MyolpYn5UHoiae3Sdfb3h1xtevGplHe6lJLZFdw6Cojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZlBADfOUxDFddeFjHUWtgfpEfzTM61wTQehI5ucFJE=;
 b=f0x2XvdxP31cWba2EDNmyv2TkxYv30d78p5n5I9OXlwUCpTlPy8NVqoSNbO54fccxYoLxLYx6McFnD1sarDir5Ks/D9peRi7jOE/yO42Wlq3Rh611CFWYmZd59DKcF+o7GSd4V7nFOWZjayBTcaLlsag7C2ZtMTweLCk6ZuexvE7LLUcs25Wvga4730/J96E56aRvJkn60PQJScjATKfn5lgBAw8l0YttfoyP41kBwFYusHxSvMoPt1PX/JCEG0dOyElWbsUS4NDaHe6LOyNqEdLINy14SLYEIy3CeJjJMQY8oQQB/4CSQtq/T1fKmkB4/j0CF605r0NUnIhS2Laxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:51 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:51 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 07/11] factory-reset-helper-efi: use systemd FactoryReset variable with dracut
Date: Fri,  2 Oct 2026 13:18:54 +0200
Message-ID: <20261002111938.3600786-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ada472f-dbc2-41d3-6aec-08df20771326
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	ITVMmTwg76P6HuUV6drA0urlPq3NRYtuoPD/HhOZXzY0sAhbFTWaRlyIV5GYTqoaGLqPGaJem0LIZfUKp1RRxEGaxSJrybZ2mc3OModnw52yrIYkbf65pPgHBgsHjWTcp5oWwrzgCZ976cOIuSWcxgxxtcnKBif5Hq8U8pb/dLcyPQkABY95a2gw+zyuEY1CQa9T1F+KglOnc5pW3Svq+YGIp+pZXJu7xhi/nePDeVWlCHYC+7YUYB0/KrsnT521CmznJIrudpHKk2Xx4nO20+gwZCrRfJsT0F9Zc7LdmRabbTweWl/gcWRluQs/DYin/tIh76scJ7Vet/3cLK3c9TYP07+EMwK4XSVjjKArzrnrnFmvmZh5Uu+LJXxyNGqNtg8hu8qUYlxkoTDNTfcwikst4pbkafUwGOQTqKNo6+Np/XKouVpmpiydFeqCmSeLgJimVh7vtcDubzfMXm4ZqFG9lD6bRneUUg1wLHRToPOJ8bhPJvWAWBStBjFAr3HZQdMDdj2VpjyuGvO6xa65oB95QiXLPy667WmI7/QMNrkSs4ga/XFYbETc2eTUTWlOj6d8JJdq7QU2S8hTMxhAfUIYCAmNZ2hsr3dKfiAlz3pXmgyYCl9Hpf0ZkMHy78rk
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3H4mLaVVYtJhSR62lhtKotXAYaPKFTskG8q4elnVIFhBU9eJ49gNjwRIX9vh?=
 =?us-ascii?Q?2DM16iHOOMBwz40eNvtrAU4ago39i2lBcvMHYv9LJaWleZv2MEIiOerbiG9P?=
 =?us-ascii?Q?KhvMmIjGu4lpOmvje0eWzqNmPXrogUoxi8+W26JiHR+83nMflS+IScDCb3fY?=
 =?us-ascii?Q?GkOESA3cQQihbAFlG3K4jrRe4hK6AUGXrQxmAfrErQCcdwTd7VaVfvnLdnHZ?=
 =?us-ascii?Q?6wgnD+M+04AVVWYw0tBgdUHnILieiDmghojYid26uoV/r8uQc4UL4DffyISS?=
 =?us-ascii?Q?7Vk5ia/MuiMU96C7xcFPGf3SWsQvo6jgaivxBssz5Vhwtseb3e4xQU+5a7NN?=
 =?us-ascii?Q?sVZOct3zQ3CaNuo8Bl3rCFRLdecjCE9Lgrg9IHiOvp3JtmU68ThP6Y0y2psD?=
 =?us-ascii?Q?titnE16gLxVcrwCg4BpKypT/2hpI5ZvC9/WZTCLpzEu+vHPo65AU9XmDBSlR?=
 =?us-ascii?Q?uE3LMAMWFkHNssymJMX+J34VN1gMBfzbnCSwg78u5p2Hjhc8oN1n+uK3yb2W?=
 =?us-ascii?Q?S5DoFzTbjsjAEM7c48ik1CVo2Nk5DkrR0KbjB7RCxoTgV6ZFOBeI6rjBBMHH?=
 =?us-ascii?Q?3C75Zrwejjfdwn/j/RsdD+kF9Js6LcCeK1H04xZQ7MDaBJdx6efXL1snq2F5?=
 =?us-ascii?Q?dePIZZfyZlHLjn9keQoldR2wSvmpXB5H5uGkJNuGGLf/bDDn8vT7LHC+jZcq?=
 =?us-ascii?Q?VLLgZWbFGIHhgTAsJEriG62BGRaXINY0eBw86/tokPIFvcD40dLjzKA7g6QV?=
 =?us-ascii?Q?Woid7O+aMXMpSCmk7BUGlildJBaYqDkqNvL653lTlhd9jkJ6zDvpSEQD5mXx?=
 =?us-ascii?Q?NfszS2uzaruEHLMvMzmDCuwpmXeUF67rxU5L60WzPKuZHhVSkpPmEqH4Shd2?=
 =?us-ascii?Q?bCcxCc7d58d86ljTOMOiuTz/JDjdtt0AEPDpNhVNU8X6HjUUJPLMbGtAICNb?=
 =?us-ascii?Q?e+qdWgLb75G5bW6rjVCrqXj9cWlCu7r4727nlbIqjmU+1Q36MpCLJeyHTkwt?=
 =?us-ascii?Q?vIM75DzJhdVZ+/3IZpvAvyWGqlVilWnp5E/DbAQVUUG/piqWgo67cvx5AR7W?=
 =?us-ascii?Q?M8Bz6cRMWsc224RTl7ngKtjGedIfo0n7k4B+R79ekYcVYi8H8RzjM1Gzm3R8?=
 =?us-ascii?Q?la1z6eRVYF+laLD6ZnIIyDPhelIOyLIqvezc4LeX1gmoVKckW8wOCZH3b0fB?=
 =?us-ascii?Q?79cRrQmnsVCvTkFTXSUSsiCU8HUKgCxtZwcOmoKSENkGk/AOdP5V9j4g6dPL?=
 =?us-ascii?Q?KEx/s80AFrdFkNKWYypeA0tQ57u3E1PxZrvCUgOxhn1ACu3gWcdO7ea92M8p?=
 =?us-ascii?Q?6leAs8oJDavMPADhwv6cpGCZ7++OLXUoexBHCJ5tdENkjTkm0RdEkHdtUgo3?=
 =?us-ascii?Q?z8sgU32gN3QsXfHgxzDK5gt6N1jtlJEbf5fPPrtlEMco8CkcSx3zJzBoop/K?=
 =?us-ascii?Q?IcglNzW2ZLcWEnVhjcDjXbUq9w/jAhKMW/VNeF3AEvpPWSGC/dTWKXlOKkpQ?=
 =?us-ascii?Q?MhoqlGmzrfVQBJAWp1tGQaLUwPUS5KXDzZCzfwNBP/51VLgpSTe+nN9GLevf?=
 =?us-ascii?Q?8/Cpg8qddIPEUfaQYgjAOk2Miw9kaZ6+EwAxPEPHagCtRvJCQnDI33lKCIbZ?=
 =?us-ascii?Q?zg/mTzzRXuDYxriU3ZlBWiBFlUPDZk9h4ltpTMlsaD3DXpuUtzaBiKL2qVCl?=
 =?us-ascii?Q?A0sJIDkiAY9N5Ny+H6lJsDifbvPSREkh8yun4JcHTRhH12M2Kza7cOcKOs9Y?=
 =?us-ascii?Q?dLJvuTzwE+Ey1CUscjqkrKAZKP5D7xw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ada472f-dbc2-41d3-6aec-08df20771326
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:50.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Tuq2ebMs3R3yhg0BSn/v7WAqbP5KxfuZbSyF4QXb1ZnfHAA5vRKzaKbiS2niJOj3SrotFKx18bG0caEJPnVn7weu6XzeC3GmgmvcvJ3DLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24409

The cip-factory-reset dracut module reacts on systemd's FactoryReset
EFI variable. Keep the CIP vendor variable for initramfs-tools.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper/factory-reset-helper-efi_0.1.bb     | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-efi_=
0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.=
bb
index 071b1ddb..bd455897 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
@@ -15,9 +15,8 @@ DEBIAN_CONFLICTS =3D "factory-reset-helper-file"
 # use systemd-factory-reset as default
 # https://www.freedesktop.org/software/systemd/man/devel/systemd-factory-r=
eset.html#EFI%20Variables
 # The efivariable is defined by ${FACTORY_RESET_MARKER}-${FACTORY_RESET_EF=
IVARS_GUID}
-FACTORY_RESET_MARKER ?=3D "FactoryResetRequest"
-# Use a new vendor id instead of the one from systemd
-FACTORY_RESET_EFIVARS_GUID ?=3D "abc688c9-fee3-41f7-87d3-1076e4a29e8f"
+FACTORY_RESET_MARKER ?=3D "${@ 'FactoryReset' if d.getVar('INITRD_CMDLINE_=
STYLE') =3D=3D 'systemd' else 'FactoryResetRequest'}"
+FACTORY_RESET_EFIVARS_GUID ?=3D "${@ '8cf2644b-4b0b-428f-9387-6d876050dc67=
' if d.getVar('INITRD_CMDLINE_STYLE') =3D=3D 'systemd' else 'abc688c9-fee3-=
41f7-87d3-1076e4a29e8f'}"
 FACTORY_RESET_TYPE =3D "efivar"
=20
 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, bsdextrautils, ef=
ivar"
--=20
2.55.0


