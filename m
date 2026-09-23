Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F013C98304
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 16:17:56 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1700.1790180270617730032
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 09:17:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mKwyyy8K;
 spf=pass (domain: siemens.com, ip: 52.101.69.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDBAxBa3xtDnd+0DdiTtvIe9311//g3XG/ScAhXvDsyynlekkb6Lh0rlX3Sg9wvuh4OOkz9c0YxsjI3sptmaxzAHDK/H7QhTdG/jKyalWLj0AQdn+KoBikD5yZea23r0rH3Lia0VdBh2GCjCBOymptRWVMP9vsft19IsJpbD6Yl3mHlJ2D/QFm6hm73bozBQxMR0rszPbWHzACW4f7sQz8uhLBvt8b80ysO0b/0ad1lW1n9iJRXHuPlj//GVoPqWXBQ4t6vxUc+EHd5RMAa6wuYMD+LX1qJ37dO6/cyFi4NYYK+l04MdTE+Fejd50TNtOXnqXm3fZswDG/DvF2ji4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvvKFMN+oiEya875qL2Hf8eWiJ1vkdoiCT5CrPf2m8M=;
 b=UiAu0m+JYR7zEDwQGM/8x3jkB7dJXnwUkKGx8fMlnGrCCaV5aTAgR69kGaBbCxhtZ6ACZIYuOyNWucuJgouursv17HiVCsUCeJUDMvl9kCFrtl7vfVOLygGRS/F6rvzPtc34rlOM2SGuTuYst5WIsSP+m18Xhfv3D6nWmYYWsJymTE6Q71GeQBXZWneM6uCgpDJqm9Rl6+Bpwq8cb3hgpzJbY7VTffjRWOKzUl/YEfFrV7XUgVbNeP1vXpZjFWDdyBFmbuCuW6bFDcbm8dmVItigH/MYFmwMTe5Vw5pqm7Ki7YjqINWqxY5TMi/uKFn+s1FwFUfOn5xAU95ZLGDBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvvKFMN+oiEya875qL2Hf8eWiJ1vkdoiCT5CrPf2m8M=;
 b=mKwyyy8KoNgTHlCgD0jxGmQcbulw8OaRD+jfr8rF6/LEULgjriTOPkHJIS42L7Otazbi2MMhbiLETTu+14YrmDiYeH0dp2SEaBBRo4XTk3YInxjq+DN3Hym3Tw9QyVTVrs7zcFxcUk3cqPl0XgVtxB3Y03X+zJFMXCvcfOVh5ZGab2SP+ZwyPvA5kErz0UvMzFNrmLps7/oqo0w3XkGwfhPPHiTGUfKHIGWSBst9X1+AVdA1Be3w3xlGrZRG8ViwGnQxudjgXLBuw2rPWnhdbPNk7kgG1E25mCJw2/9+fngeYdz1PQMA59fde/+Nt05STryRQpufjFHXbkpq5QNzsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB7373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 16:17:47 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:17:47 +0000
Message-ID: <174770f2-99db-468c-bf53-4f229f6adf64@siemens.com>
Date: Wed, 23 Sep 2026 18:17:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] customizations: Switch to dhcpcd
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: a660fefe-97db-4a1d-f174-08df198e34a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|11063799006|56012099006|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	vUVgef7EwXEFf1sTweSi6t47R7Rfl1ZgEf86+pGqwPcVi+kgUJv9oIafVPhKLnZDIxFDcNa3IPgIk7oGzqlEK8gle5yjnGbkl1pCX3fAfh8w9z7KDwzbdHYz+GBVHz0DhIOqie1pN9KwSIv3ze54+PKwYdDcZ2JSs1p44HyunCBlL+mFBXVMFEq8VesFgZuH17CUKyJn6XDYBSFj2xqY4OkG2Qz1Z1I9GRjU3LG++uyWKrud1+FF9do0KANz534USbWtMkuQ2yFZbEh5MRQ1wF9cvcnlkFPOJsPVCQtYuDsXxh5w8fR5cVqYc6f/YOwVxZ1xnRQkgLsDh6HfWWkEw9lzSUk+u36hOkh80w3FIDh1v63qHk/VuS7iZN9dP8OuY1xNxn61zE2oI8ZLP2XWggCxSZyeGd0MXNpzaGiDZ5TJHxROMeZyTahMNCHCbrdBY59yMxNAYcBv6D9mm/y1jRGS7zMc6C6+QeD50D6d+8jHvWn5Pbagq7q6Z/GGp0zh3DTA9nH9kK09zgZ2RurDBlxvxn0XRx1Ek1SXNd9i95+VqXqlpYVGLqFR7a/St0M6MbjAFBccq6DSBg35rmHfB8XbHUqUrRZW/YvsI1T5ss13ndMMBsV9FcCBrbbGA4fDQ8cpltj1qL6JBfbayFx/zEc4eYceR/LN3WljpEJ4RSw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aitaQ3dIUldIczhEeStSRVFzUmp0elhUV2xpQk04aHNQVWdFeCt0cTUxNkw0?=
 =?utf-8?B?RXc1MVRWdDlhdi9NbEV6eTFhaGoxcHU0MUhTY2FHOGpoUFNUNDNjRDR5aVJ2?=
 =?utf-8?B?czlTc1RDZnNhUEVtSzdLM1JhaFhyM1RZak1BMExIMGpHNHowa2NBNVRMRWlL?=
 =?utf-8?B?aVo3ZkgvRkdxVnQrd1FERjNkSDhwdW9Ua25NT0xjSHJHOWlFTlhqUWpieWFz?=
 =?utf-8?B?bFliKzA2ZFN3OEN5eU4xQlR0L3p4SXJaejVMdmh2UTlmY2tpNUYzemdRalJn?=
 =?utf-8?B?RXk4SHpsK3VHSmZhWUNGUExQY0FjcVFXdjdPZCs4V095N1U1UmJzcDJSY0lq?=
 =?utf-8?B?OUI0RjZPdHVuWGltNTFFOC9RMy95eEpCa3dhN1Y1MzNSQVZNYlRtM3pvazZJ?=
 =?utf-8?B?VU1GSWpQVHJqMUNxNlFGTmJpVno5cEhONjM5a1hPRldweUQvNUdIalhVQkJJ?=
 =?utf-8?B?VHpISkZ1N2gxR2dwSTBzY1J3ZkltdEoxMUd1TzRkdk4wbXAwVWU0UnhwSllT?=
 =?utf-8?B?b2NNTEwrQWwvM1BuOEZ5MjlxQWJDMGlSbVFZMVNWRTJPTHlGclZldVo1c2xU?=
 =?utf-8?B?YnJyUkYvM2NPTnA1NStmOVh6eWJnR05PZlpRQ2hyeTBJMzBNaHdZcHBFVTEr?=
 =?utf-8?B?REhPV2Y1WGxJcDVyMzlReXg0Vm9FeGZMZ3VldExva0xETENKUUVjK1lKQmZq?=
 =?utf-8?B?cFJiVHlRcTJ1OVFJUitWaDVuOW1ScEdRam05OFgydU5kVXJuTHVmR3hkaHU3?=
 =?utf-8?B?TUpnaUxkRlFGQmFYcWYwSTR5YjNvVmt0RzUxYTFrS3JRdWM1Ui80ek56VWEv?=
 =?utf-8?B?NnRCM0hTVy9iMWVicmVUSHkyWk9iV1U0enhtckdDM0dJRFlSQmMvTlRsV0ZE?=
 =?utf-8?B?dEk3eTRTUWpBZjF2Q3o1bmQweitEQTRxQWZuS3NHckUzQTdJbGtPeCtwZ0la?=
 =?utf-8?B?WERvNTdwTkJzYUlzNDRvOGdSbUFnaC92dWJZa21oSnV3RlVLZlZFTUxnb2kr?=
 =?utf-8?B?NktJbHZhRUVqNmdLeTZRY0hVTTNFZmhnTzZuSGY0ZEVUOXRjRlpZeWx1d3Ji?=
 =?utf-8?B?NkVNTDdrc0lnSXRxdVRNRjBQY2ltMVkyUzYwWTdISzljamFkWmt3TERPTFJm?=
 =?utf-8?B?OGdLSnliK2JCQ1VIaGN4R3c2UHNxUWNLYWRTc0h3ZjdQTVF0MUtjK3R0TG04?=
 =?utf-8?B?d3pOMk5rSFNyTjRUY2lveWg0UllaTjRlZFNZUW9ZSmF6b0ZVMkNQd1FINVc2?=
 =?utf-8?B?Q3BLV0lKZVNjeWNNY3ZWVU9meFJ3VHZTVVhodGQyRzVldWhKUE5mNGZXUTRF?=
 =?utf-8?B?WXl1WHZnWU93WVVCRkxCOThzQ0xSanBXc2RpMUJxV2hRMEFQZkJqKy9DeElo?=
 =?utf-8?B?SS9EUkFKNVZ6WmNoUHFsblhoYUJEV0tqbUVIckoxR3h3YzgxOFN1L2lvUlJR?=
 =?utf-8?B?cVcwaTlhdWJhcENjTEpnakpQaDluaXNBZTZmL2xscHN2SWg0ZWZQV1Foc3d4?=
 =?utf-8?B?SnYwSEFDRUw5QWl2ek1lRldZZWNWcm5kazZZU05kYkxMdU0vUlY2dGNRRXJk?=
 =?utf-8?B?cjRiTzQvcmdSMGdNVDI3SjlqZ0xJSzlXaEtYTUJKUzBZaUsrSmNuYXBESTZK?=
 =?utf-8?B?by90N2k0SStaZHluL01BTE5LVjlUMkx3czRzVFM3b1VmOW9MY01wMFB3U2Fp?=
 =?utf-8?B?NUc1SVMxS0pJTVZXc3U3a1c1ejR1OTY2U3pzOXBtZ0EzdVdNRmV1bGU0UitR?=
 =?utf-8?B?V2dVOS9wZE5iellDd3V5Qm1ldEdLZzZ3bHIvdERqeG5OSmNSaFZmTmkrY05R?=
 =?utf-8?B?MUtPdWErSGg3R1pXM2dsaFo2TEo0Qlo4ODdqZDA2YlVtUzhLVVlKczZBc1hr?=
 =?utf-8?B?Ukx0RHIxbE9Fc082TUhkMUlYdHRzODF2aDRaQXB6KzRIK1kwYjBOUDBMUWo5?=
 =?utf-8?B?WFdvMlFpQldLN2tHZnNMSkpzem9FKzBHdWhJSlJXRHFUeVNtRnU5dzN1N25Y?=
 =?utf-8?B?K1dpYnVORnNxcStHc2t1WndSL2kvKzVZbUJHUWVQR25oQ2lzM0l2TVMxK0cr?=
 =?utf-8?B?R1pudjBRWGV6L2dHeUkxUDhMbE80OXR4cnlZcHIyakVSQ05QcWErdTdNb3Vu?=
 =?utf-8?B?QlpzV05YUi9oL3lGWkVBZ1M0MlNmMVZFVk1PQWdQNGhjMUdDc09xcXNMKzBa?=
 =?utf-8?B?bDVmcXVpeTM4QnJWOTlvYW5CR2VHL3VMR3RUUE80K2dMazdXNndmSWFFQ1dE?=
 =?utf-8?B?ckllcWdkYmFla1pLelJIb3RXZ2trL1M5dFFIWmNwRlBQaytpV0lGUjZUVXJP?=
 =?utf-8?B?Q0xvNXJiZkpqKzkvRlRRTWN5a0U2dHByeUhEdWFDUzhmb2ZMTzNGdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a660fefe-97db-4a1d-f174-08df198e34a3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:17:47.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfQvuUPkc//4BxZR6pJDmJWlU56xONuyhGMw5NGOd80ff19+ijf/8pygMQot+FXdzcuSpl5w0ZLaaQ1/Z3Eauw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7373
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 16:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24279

From: Jan Kiszka <jan.kiszka@siemens.com>

isc-dhcp-client was dropped from the upcoming forky release. dhcpcd was
already available in buster, so we can simply switch over. Use the -base
package where available as we do not need more than that for our
ifupdown based network configuration.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 81a36edc..0fd3d4f8 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -31,7 +31,7 @@ TEMPLATE_VARS += "CUSTOM_HOSTNAME"
 DEPENDS += "sshd-regen-keys change-root-homedir"
 
 DEBIAN_DEPENDS = " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
+    ifupdown, dhcpcd-base | dhcpcd5, net-tools, iputils-ping, ssh, sshd-regen-keys, \
     change-root-homedir \
     ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
 	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
-- 
2.47.3

