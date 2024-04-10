Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA78CD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 21:32:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.120])
 by mx.groups.io with SMTP id smtpd.web11.2465.1712784763629182313
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 14:32:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JHc01SkQ;
 spf=pass (domain: siemens.com, ip: 40.107.6.120, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9YtiwEVJUQ6qwJGKELojpqgdF3ak4IyMD/D0dnZvo7tsqakKWx4udzpLfW+SuqzmwQUuGkKWLkuv76v1R9x/WI83M+shlrZNB0KsCtN9IR1fFRZv7ReSO4wpqKe5DDGlSaq6z3EveFoiF2WZYKNA5yeVed05MStoKFDZonsKlWxEnB6nKHY8lHL1x/8csRtLFvsti+mu2RiPdcP2CBb4dBxEKW8E5VnjvNacMIMc2fMa6LrXlen9UDHzyjJYhJ9fjR27AaqWHrjRl0HqcWEO9XC7n1651RFDljeE7AbP8OjJn9Fnk9nIO49vWO4IUUdfpNf0xbDCY/UbDFLNrMqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubD3uhz1u7/VK1MvUMJ0lzzrhQzkSG3vuCKt45GV4GA=;
 b=NC+2W/Q9vmvY6E3I6OsDnkMgtfqzRxwknq6CmStVFQ2o2/32bm6bT2KEMXfbrOq/agW9EI0LZfVH0hlm0z6A5J/srDWQSgyp16hETru0whO55AViyiIeh1ftN5qzMcYFhSxYXLddKGVG4wDwZDBaDn2KJvv6DFX5RJn3KxdwVmDl73wpFVgLe8xHAzh4IpLKKVswMVblgbS2Rexjz6xLNldSfOGVKhIU7x6BI7LTLhyRwd/mboP4NRwIDxG/aqQmQhDl6ox+sd+aFxq+u6s5p6uSAYMWO/v+uOPvdMJF8hLiwTorjMWOiIZKe33gVQlu0+VFKGpetKJEk6wMyEIqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubD3uhz1u7/VK1MvUMJ0lzzrhQzkSG3vuCKt45GV4GA=;
 b=JHc01SkQ+cAyOkX99VEDtOM3CrsZZyGnUzfsLuazgQ9BUmbkfJ13mOSv8/fe+g7lsVZsE+7WvMr2SiOPCm/KkyEawO4P97CFPsgc05eSil3Sg96Fm86M+ROX1hXZoNqHgOBYscnLOyXNNtcD7KPSX4ECLMIOWAktkWJ9h/VeX8pebIlZjibqxlj6LS2ppWCY9okvdXhYrvBou+ZM9jPV0/wjKoWQ6mD3z+VRZmTN/IySj7BsZqqaRg7G9LORFYpvDvwDI6NrYASryGqNXrK+ac4U06EBM3ab0YpM+rBIRSs866N0+L3wT6v25LlFOsrBLvBQmCeCwNzMoydcu2dTFQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Wed, 10 Apr
 2024 21:32:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 21:32:40 +0000
Message-ID: <1d91a4c3-cba0-44cb-b069-82232e877679@siemens.com>
Date: Wed, 10 Apr 2024 23:32:37 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] swupdate-handler-roundrobin: Silence fetcher
 warnings with different SWUPDATE_BOOTLOADER
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6370:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4xfyZwR09H1hHrkskl2Yxidf/KPlId6jQnPQ2UOoEQ3/oMBvKK8CHLtcpT8ob1bWr4Xb41+09KqPVGItB0ZQ6rs7p0mSnusL0a6+SJu6VNlY5ljoNBCzI3+bskim50KkkXjJ79Wi2f3YrGcq6zqVnP3my6LSjcIQ3b/kqU/riX1ut27q6Rx62FmJX9/zQpv12GsCBzT8YVVuGp16cOpDK9zLLdeZ9uCmsV6LRxz30YnhjJWtBN0rqLXq6keZczoAOSUS1ijzdOwyKF2b3fGnL1BJ7Ey/sDn+RFwsMBJdR0z6/DLLsRHD4I3A34VEKUMBXvDRL/yaz3gluzYQiKHDqnJEll4G+OOqkyL9aKLovb3oQoISWuRgWqIoscCk9Ts2nfany0PpShgvHAp5bT4/SssMhs5SX6sg8dwq2I70aP+W75Kc8NPHg0Kx2GrrFU0xrlgWfp2qgMZC23zsgjo0onHOtAEwPEPiHP8wyzfSlQUkBWxQGU39pf5zvGUeGIWOQamv96CNFrLJcQxAjfS3Sjy9UUVXNN3PEdYvoTL/U96zSjLgPjFSlSXVKQp0gfdaMEkFKhpgN7a7ncu2blooSB6VKqMQQN9C/ImgIfPaZnE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkJMaXY0YXlZTHZFZkJVRld5NmJrRmIweitjM3JmUG5kTjJjSlM4YkM2MUp5?=
 =?utf-8?B?RGRaeVVWSU13WGFjSEloMDlQeDMvU0dyUmJpeTFkalJCUHRlQ1gxenJGSmJp?=
 =?utf-8?B?aXRYek9ML0JWdEpHbzdpeEhHdUd6VUlYNy9YUEJJZ0lRckpYekljb1VNYTVv?=
 =?utf-8?B?ZGxHOXltZ2dqWmtJK0hiSVgvcmU0bG9xZlFwZG1pM0tNZWlBeTJ5cit0TnVv?=
 =?utf-8?B?OVM1TE4xaS9abU1UbDRiWnNMNkFBM0laaHJwaTQ3SWhOdG9zZGw2eVlQZDhx?=
 =?utf-8?B?dDZGVEVyQ0h0bzNuWk5KVXBham9uNDZ6cnYwdXRmVzBkK3c1cXpGM0VVV3JZ?=
 =?utf-8?B?NWR5WWJHNWpzbnZremwzSG41cE50MjJLWU5QMk0vZ0ZGdXNUSzhIN0xpck9B?=
 =?utf-8?B?NzFYQVFrbmFTNDVtZW9nTHp3amxidndNbVBrZGZ0WFljQTMzVXFRRnk0ZlZt?=
 =?utf-8?B?cGlzMzFHcGg1eXhxemFGTmpYNDI0T3dTb0VLMldQRXA4eEJaK04zUmdBb05h?=
 =?utf-8?B?Y2VTeVM0RVZIb2ZDbllLQWUzVEVjZGhUY25xNXN0QVBtU2tZRXFYcXdOTkdo?=
 =?utf-8?B?N0NONnBkR1BpNkNmY0JVYi9tVEoyWUlsb3hXanZieloyTWJoemEzTTNreTgz?=
 =?utf-8?B?MVdhSzVUcEhIT1FYblBWVk04SEZ4MVNIVFhEQ0t6ZW9NVngwMDF4cDd1QWda?=
 =?utf-8?B?cG96eU11cXZ4MFBEU2QvQm1XbWVIMUFBaXRIVWJseUxzTUF4Q3o3eUhyanp2?=
 =?utf-8?B?U0g3V2RKV05vcjIzaDRvK0Q0Z0doNTBDQXJvVUFPV0ErQUFWa2QxN3R1eStx?=
 =?utf-8?B?UzJBb3NxUzFXTm1OMjdncm44aUZjNm85aUhhZEtORktMNDhPaHl0YnJkanZO?=
 =?utf-8?B?ZFFJS3dEY1E0M0xNR0FpQmZNWVI1NzFMMGZnajJnTGtrcU44NXRoU0xQV2Vt?=
 =?utf-8?B?ZmJmamE5bWRrZ3VxVHk4aENzUkg3SitGQUF5LzNjMDZEelVIaWZvMVBkTkJq?=
 =?utf-8?B?STFnVU15cEd4Tm8xanJkUys1MzdJa0FqRS9Vd3pkKzhKZDRmNGpheG1JODBT?=
 =?utf-8?B?eXJlV1l4QTQ5akkyM0RiNzRRWTU2alBhS0toVHlhSlZ5TWYwOXRBQ2Y5YWZk?=
 =?utf-8?B?MDZKV3hrbTFPcmFhcW9OVlNkZUczRlZoUFpENTlqREFrbFU0c3FQN2ZDdXly?=
 =?utf-8?B?RHM4MSs0bms3eFRocWR6WmVhaHZzd1MzZHhWaVFtSS9iL1VLSE5mUVEzTzg3?=
 =?utf-8?B?TlpZTVlGd2xVUEk5Tko1SHN0aGp1cEp4NnR3S015bkgxVTZyMDBTZ0E1R3Fo?=
 =?utf-8?B?Tkc1YTM0bnJQZmIrVVN4SzFoMkpIN1hJbnJMbStOd2pkekRuNnN3Y0lCY2RS?=
 =?utf-8?B?OXBCdnh1SWp3Z0dEd09GYUpGd1NuRXZlU1VXRjg4eC9sWnJETkcwZlJLZjQx?=
 =?utf-8?B?Vy9RZkRYc0lEQW1RM0E2V2E4L3JxL2hQQXY5ZGU1ZUxhNkRXY3paRFAyR3RU?=
 =?utf-8?B?YThpdERYZkhyc0E5cHNkMkp6aHNpMW40YW5waTZRNElIZDBxc0NqLzQ3NG5M?=
 =?utf-8?B?VVBpbGNVUnV0L3hGYkFWenFISlZLN2dSdjNOY0xZN205S1ZaeFFZbFNLM2U3?=
 =?utf-8?B?NWhWRjVpZENTVytHSkIzZEFLblE2NGJlbjdKeXRrdmlNOHorNDFZU1ZxNkln?=
 =?utf-8?B?eFpjKzB6NkZ3NTVySGMwQ2c4WExMbm1wd0FPSVN4VFcvb3hWRGhtUC9tVGZt?=
 =?utf-8?B?U2U5ZzFRdXZoa1pjNi9iQTNsb1dBMkp4U2VhM0N1d0VzOGEwMVIyaXcxc2ps?=
 =?utf-8?B?T0Y0a0M5VGhwaE1sdFFHUXpnNmUzVCtjMHg0YXI5Uno5TmpHSXdNbUQyRjc1?=
 =?utf-8?B?VTA2SG1qZ3dzQnhHaHRNanYwNXJ6T3pjSzFTSXFBVVA5bWsvT0YrWlE0eVM5?=
 =?utf-8?B?WG1ZRmIxZVYxWC9KSkxmNjFKQkFac0VYckFxdjBVczBSTVNKdU9iTzZEa2Yv?=
 =?utf-8?B?cDg1ZzNYMDF5YnJoY1RBSndxOWhhOUVkbEN4cTBZVnZqd1hQRWZya0NJRVJD?=
 =?utf-8?B?NkN4d0hIQ0dOQSt2TFhweHYyTFQzSUFQRHloa2hPN3BZM2NqY1hFSG1lNXZK?=
 =?utf-8?Q?IZg9dJksCv5SxrVlKDlLpeP7e?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33725cd-23d6-41b2-6875-08dc59a5bfa1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:32:40.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZI6qkRgRL5HExpIl+XdVTnwntx9kQAFXKKLmDnDa05fe0Ofj0oCngTEHScgvSF1s4MnocreUqIpNIW3ZtRLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6370
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 21:32:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15538

From: Jan Kiszka <jan.kiszka@siemens.com>

If SWUPDATE_BOOTLOADER is set to something else than efibootguard, e.g.
u-boot, we get warnings like this:

Unable to get checksum for swupdate-handler-roundrobin SRC_URI entry swupdate.handler.u-boot.ini: file could not be found

Our recipe only supports efibootguard, and downstream layers may not
even use it when a different bootloader is used. If downstream actually
wants to use out recipe and also provide some own swupdate.handler.ini,
it should rather override SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 70ba522b..a185f253 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -17,8 +17,8 @@ SRCREV_swupdate-handler-roundrobin ?= "e6936b8c29a20cb6a6893faae57e12499ebbc342"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
-SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
-SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_BOOTLOADER') else ''}"
+SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG ?= "${@ 'swupdate.handler.efibootguard.ini' if d.getVar('SWUPDATE_BOOTLOADER') == 'efibootguard' else ''}"
+SRC_URI += "${@('file://' + d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG')) if d.getVar('SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG') else ''}"
 
 # The lua version used by swupdate to search for additional handler is hard coded in debian/rules
 # see https://salsa.debian.org/debian/swupdate/-/blob/6ccd44a8539ebb880bf0dac408d5db5de7e2de99/debian/rules#L13
@@ -37,7 +37,7 @@ do_install() {
     if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
         install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/lua/${SWUPDATE_LUA_VERSION}/swupdate_handlers.lua
     fi
-    if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
-       install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
+    if [ -n "${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG}" ] && [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
+        install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ${D}/etc/swupdate.handler.ini
     fi
 }
-- 
2.35.3

