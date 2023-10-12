Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E12FCDB46E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 11:23:01 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.59])
 by mx.groups.io with SMTP id smtpd.web10.8748.1697109779993616162
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Oct 2023 04:23:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=C4c6Ej5o;
 spf=pass (domain: siemens.com, ip: 40.107.249.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXQRlJVZGEiSRbGxeTK+Qmiju23JnyKsaKcXap5aMIeZUaPKDlFw5+ybYlJaAjqFMB1ZZIwUlKQ5den4WVuFb4QF1YbvOJtNo71g4fGpiYA/OLy2/e9FLp/a1BMI8J1pQV95pg3a5K0VP4D9cF9nGRwUeaEH03sv63uM0TV9tqvQfCx1P2YP0QSGyok0big7no+iXBzdQXDgW0BpexucKrT9rEcJlDR6I2GAPjXEzS9FsKVNB3aNWqGY4dZdfqMqZFU2WqfCjhwuGUYGpHyoP14tAvd39qEGVuFY1r5opLF63DiDNdjdaFqbsb7vumChvUyagoxwjz0ZWWnocDQZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYNySEi0hc8ARhNPNiLe3KTLMI7H5RzjmO1iaMrcOiA=;
 b=d34VjQTvUfIl4TbEU5cwvPVk9EHNRE7TnFSI9XoYaQIWNH5fW1l/A2Lp9j8GSXJuLXch8SXX4JS1QPTWziGZl55sVZZIJf5ZCJQC7/u2liZU2SoBD86on8+n/xp0ae6lQlSr015AxCNlbBHEDplHHJLqj0zIFUrtOI4AQ4u30HAiIqB3glbw+pyLXhnivDA6HHIM7Oq/rew2ZYhAL5dmB7LumZg7GzM23zHTFKLn5HivxDhoU+tjJrYd54uhv5dDhSfzCGJGVEOCX6luiOans3b8fEqtP95+XVt+fkmvLK9rbTjHJq4l82bfdtyjnOV7F8r2b0+VEDytdIxHeE/ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYNySEi0hc8ARhNPNiLe3KTLMI7H5RzjmO1iaMrcOiA=;
 b=C4c6Ej5oJkJWpRqbNNhbuJvjkX4YXZei6U+/tsiEj6Fizz4jXaVgJOwBoXNgPKahU7np4x9LWhg1MvS40xtVoaBaU7JJROYEG1ore26o/6wGThiEWyEkUj9D4PXJuFnTfxC0qrg8nMxcxLtYYyh2Msj7fyBhdQq4iKNZr+BAKNag+NOZWoaJTWwuEBImg9RteZPCytgPo+O4MYoqk7DFUobKPdCoiLaPr9kMaQ3BMQdsczuNFMObJWcPtokDcnhxXSNiA+h+Sg3JaYIkXNnwcDimEFDdTl1077xZQxQHfBFYWe+lDJyrvnm9zZczhjLjBfahWMWBRp4jOS+Zldf6hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 11:22:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 11:22:57 +0000
Message-ID: <b74cb5b7-db7f-4ef8-9559-b22b8ccec828@siemens.com>
Date: Thu, 12 Oct 2023 13:22:56 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] edk2-standalonemm-rpmb: Accelerate the build
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Schultschik, Sven Angelo (PD PA CI R&D 4)" <sven.schultschik@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:610:cc::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc57833-1134-4d83-0bc8-08dbcb1595bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LNQkiYmqqjnAOP9ZrhNRFE+Y59LVK/9CUHWZpBtNO0eaHsVaufOSmTicu+6vgDBs+qBCWJrteCm/oQHh/XrhLpXjvEuveHbu7/o5nRh93nVRmWClrQRCjSTWUpNKxm7oA4umjbes1lVKbvjaAXtJSiow78dK03KlYNtkfdwoJ8dVwmNXpa5Zw6cl+gfoER+GbDHsjUL5dLonh0trAlWJcK3XELfc/oUnztvPtQtyrOgInsfq+T/QxW2C/yGCv4PTHOiTkjtijXdaXXcw23XkTjTK9fsRZFGnWly+cH7WAIjoRWEBXo7M36YEi/fQbRxrV656R0QY1h0MdM/c7yWLYd1ogauDqYSgXWi3/O8PCsU7SU6vv0l0Px8/MDxRsM/f7Q17mT1yIvClFfRnbobjXgTmgKcN/oSCCocoDS546KClDGH14HcsHNqfNw31ZFmvnSDxHSIm3KGSeLFv4RudS8v63ECTHMTUhFv61af4cPN2PmSyw/4SF+aIXf4bx4d7lFRBuFrYOLuuqpp+5t3mbFiGHHdSKCSdwHDCm3Zduk+3oVSGV2yTRQPbhaD7zyhtPAkxrxVBKEl3f7TBjWi/syic7udaZaF0j5bdBXIrdaoDvKVY5MrErYvYZxMyG1dDYyT1X+gX3EGZNeQd3kvxrQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31696002)(2906002)(6486002)(478600001)(4744005)(41300700001)(4326008)(8676002)(8936002)(5660300002)(44832011)(66946007)(66556008)(66476007)(36756003)(316002)(6916009)(83380400001)(26005)(82960400001)(6506007)(31686004)(6512007)(2616005)(107886003)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXRBV29jQ1NUYnNtYVMrbnk4S0FieTVFZlFZTWRLTEs1Zk1YU1ZUaitBbGZm?=
 =?utf-8?B?T1REQ3F0S0FMVk1KR0VhbUh1ZDd5cld4RXNLSWtPSWd6Zmt5ZWM2QTRsYkRS?=
 =?utf-8?B?aFd6RThtY0NsMTdiTkV1WjhKTmhCTTd4cnpmcWY1SXpUNDl3SERFRHBoRFV4?=
 =?utf-8?B?QSs1emVQdGMzb29Tc0s1a0dWM0paSXZ2U1hTcmVFOFV1OVE1Nk5HZ0JDK2ZM?=
 =?utf-8?B?UmRQZnlNVW9mMjR5UTVTT0lMY1d6OTZlL2xpSWp4QVdRL1lBWWYzMkZjOGZV?=
 =?utf-8?B?WTlhNmF4K0ZRV2JZQkkwczdJK01ZVGJicDVPbjZEKzJ1eEMwQ0hUMUNESnFp?=
 =?utf-8?B?VVFUQTI0YmlpSGR6NjJYWERrejRIMGxmekJsbUlzQ1UvejVGWDZ0Nlc2bkhy?=
 =?utf-8?B?Kzd0N2dReU9YbDBuVHpuM3ZlVWZVN1NOck9Tbnp3amlSWUpDQ09RL3VVd20x?=
 =?utf-8?B?SUJ1eE1ZV2lHR0lzY1BFSlIvTldjc0JTY0VvWXBhQ3R0bmZTMGU5RFNnYmtz?=
 =?utf-8?B?UDF4dmFkNGdxR0l4YlhOZEN6K2JYNDk4RndzNUI0akN0VklJKzZkeE9Bcmt4?=
 =?utf-8?B?SDFDN1V2b0pUak1rb05ibHpnTjhsWENKeGxWcWcxQ1h1KzJ6RndFTERsZnZu?=
 =?utf-8?B?aE44Mm5iK0NpYmtvODJ6TU9nZXBPK2FScnYzLzJGdFprMWNrL0pyMFVrSGh5?=
 =?utf-8?B?eDdOYThLamxkbGFXaHpxbWY0NE01NHBZcUhhK1VrOFY5NHJwY3A5cW5JWDJt?=
 =?utf-8?B?TC81TFg4MHBIVktXdGhMWHNrMDI1d3NYRm4zWXl4a3MxeXY0Sm0wQlR0R2ho?=
 =?utf-8?B?dXUyM2QzcEtKSXBYbjE0Y2pyN0RVR1lNK2VmQ0Z1YWs1am9yT2xWeHBUTHIw?=
 =?utf-8?B?MUhYV0VaTVZGWjVqZGJGanM5TzFxUXU5T0R1ZS9xVUx5RVJJOTgwNjBYeWtL?=
 =?utf-8?B?UjdEOXRTMnp4U2JkT3dxTC9IMlU1MTJZNjk3NkZ4elBQTEZPOTJRd0E1elpq?=
 =?utf-8?B?THJxSWlRdmtJN2M4bHVHcExBQnNuYlBSb05OakdVUjY4ZkEweHE2NnZlTFgx?=
 =?utf-8?B?Y0ZidkNvQVQ2OVFaNGVMZ3Q2RERQWlpkVUxlemdpVWxXTjU2SjJNK3dpR1Ja?=
 =?utf-8?B?TkpGUHpCNmpoaThFSHg4UnNobGxaWXlNSVFRbVI5NFVqaStGR3UzdzhxWVA1?=
 =?utf-8?B?a1lERUpVSW1EbXFKR2xuNHZoTXdHd2VDNDYwQUVXU0V1TFIraXo0NnBWZ1Vk?=
 =?utf-8?B?TFljZ0RXSW9xMDIxZGhaNTQ2V3JwQTVHajZUYVcyYXNkNWczV2RmTjlpNUk2?=
 =?utf-8?B?R1A2aEhocWZwM25FRXk3THR5N2xUc1ZQN1JJRVk4S3U4bG9venVQeHF0eFRz?=
 =?utf-8?B?aGNYWDBwUDFoRC9yMkJlc05NN042MUczTXpFQk1HLzh4cFpWMStpbStzcVBH?=
 =?utf-8?B?Qjh4UEdpaGhXRGs5TU5uOXQ5cTNuMFhNTWVsRkJrN3dobDl6WGRWNTBWcWM3?=
 =?utf-8?B?b2U4UG1sNEUrQTI4LzZvNEtWQk4zQW8wandhM2lJSWpISE9STmV5VTkzOWho?=
 =?utf-8?B?d2tGRy82RmpxcEg2TkZYb2ZSV0JIT3dKaTRXcjdscjZLS2o2Y0tZYW4wSjJk?=
 =?utf-8?B?VEJ4b0tkbGs3Wmo5d2JocjNnVWlYd01OVG93L09XeGJxU09sYURUMFNBeE5u?=
 =?utf-8?B?QXNMeUluUEdGcGIzK1lpbGM3RjZqVDltblB2UDJ4ODdWWjlTUlRuQ0VjdFVV?=
 =?utf-8?B?VVdpR3krMFBtUmNmMFRzdU5kanJrK1A5SmpOK3NUSXZ6d2RTcXpBL2FnTzd0?=
 =?utf-8?B?S2l0N25QUWZrc2E4V2JpZEI5c2gzWVpCWlYyYjl2bmJoVk1DQ242VVNrNS9M?=
 =?utf-8?B?M091bDhMcTEyK3EzSXV6MStzK2s0VW94YVF0ZW9lTWFROFVDQnYrYkFHeUdm?=
 =?utf-8?B?YzREdkt3NExUa2RJUVh2S2h6TDBrbFlKN1crRE9RWmttRzlReDVRTUplYXFT?=
 =?utf-8?B?akNJZ0FGQlllRzNaYkFGOW56ekdGTjdJSXNuT1NEWDlVQ09Ib0ZWcVcyQ3Zs?=
 =?utf-8?B?WHpLYkFYdWlxaUo1dWhDYlpPeGJyUjh2TFhoeElBdzdOTHN6TWxOWDNCaUVw?=
 =?utf-8?B?WXBVVVVjLzE1bU01MWU5L3BOcGhiTDRkMnpnQjFwL2FPejBsZFZyVnUzQ0x4?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc57833-1134-4d83-0bc8-08dbcb1595bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:22:57.2086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OStPXfwTiW1mx4EVaHJBB0AHlE7xX0/h0boI+8kgWF2iDPanTuHxmohAhHVFrz46QO8UNHg8TDnduza3WnGFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Oct 2023 11:23:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13392

From: Jan Kiszka <jan.kiszka@siemens.com>

Also the first part of its build can run with parallel breaks released.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/edk2/edk2-standalonemm-rpmb/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
index 8d2c1dfc..9a6e1b32 100755
--- a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
@@ -51,7 +51,7 @@ export PATH=$(WORKSPACE)/edk2/BaseTools/Bin/Linux-$(TARGET_ARCH):$(WORKSPACE)/ed
 override_dh_auto_build:
 	source edk2/edksetup.sh --reconfig
 
-	CFLAGS= LDFLAGS=  make -C edk2/BaseTools
+	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) -C edk2/BaseTools
 
 	(export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)- && \
 		build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(shell nproc))
-- 
2.35.3

