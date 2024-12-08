Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB815E77173
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 12:52:24 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.57])
 by mx.groups.io with SMTP id smtpd.web11.77954.1733662339926754270
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 04:52:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aQSd+4F0;
 spf=pass (domain: siemens.com, ip: 40.107.21.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3Eku69ZaoWfbnkJX8zsqmxzz2EilmAbpaIqdgFYrzKKUzTgsOubt22cc+FvzktNqh4xarf0p0pmmVaVH/I4g57WuIlWQo6sYIQDjgfQBcdtqypPiHqnAO+v+Acm9Yz8CBdRydceEoE+IepXiGhiengSFnTNbAJikrp+AJhboUMcrpRaQg1d/lu9BBpimmal2uBkzJEoIqK8JOZfOSCVBKR1VVsYTH3CrYxT4bxBCbjv1DDb9e1AcrO+9fIgpVk8PRMwlVzCMHdJNq6r2llJZ7BCqAjwv1qBdi2kO7MYA993CpvyfmdQOcyLmLyhyY3BIwDCgT224RNyzh7jNgE4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHpPjnIYPcQfszQ16vVP9EKkKvcPQNP02JvbsZOQ780=;
 b=wiZscpmHzKQJLZ+s57ghdyHU2DUCf/2VVDUeeE2tP/XCqYU+aaIIifzXwUjsLAKpTHh+Uf05OEojq2JIub4wJNE5QvBi83s1V427996MvtZ9MCL6L3SWVeict6xpvcT4Rpct1JDvzFsDH1GH9q63BFT/b5P2qztlTuws088acC+5Rv4mA3dw+i++RWQOD8YxW74Y1ASTUqpeCOgWQFsrFiDHHV14gzNQWr74ftvcfWhFOi3IWidKYFam9VMlx9z878E5ZtLLLU0SxtouMxGypguB1Vw4dcGHwGhaCkZ2/J/T2XY4yUVrU2bpO+T8KpNE5ulbRitb7hA8nSVYkClrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHpPjnIYPcQfszQ16vVP9EKkKvcPQNP02JvbsZOQ780=;
 b=aQSd+4F0uMglUEU5CvmYpvXLcI505VYt9Bw2iboW3TXXVCjWaPNR6Q3JLmrI3Ps+6SMUGwiaBmhDMgOtwPadH0RGxk7BaymMZGQPeWwTW7nFcdbxDNDk+3jcJUGmswog8IgpqiCqaiRMMMBCDg2+OI9WP8XbHjgqz7X2Q9OevNCqilNvXn8TpUXJikC9X5Wb0frPTwm/dfFRV21+emmmy0jNbf/3+2WZd6CBSFbhV5+t4J/6gpK3Vj+mDrimGAm3SEN6WYpt62lf/+lhX4r31bIuIMNFB4kR3dvHYrIZmV2gtQ+Xck7+JCxPeOhPrzY+ShBeB32fLf6Thw/swS2OZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.9; Sun, 8 Dec
 2024 12:52:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Sun, 8 Dec 2024
 12:52:15 +0000
Message-ID: <638b9f92-37be-4d7f-b64b-e95fc85da037@siemens.com>
Date: Sun, 8 Dec 2024 13:52:14 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-overlay-hook: Fix copy_exec input
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb34174-3fa0-4a42-d447-08dd1787246b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEJidUZZSm1DdlhiK0tKcmVoMlJzN3pFNzdqV2ZJR0VaVG9HVUlnZWhzSzZ3?=
 =?utf-8?B?dzB4NkIwR1FwZG80SDJVeFZIYTlBZjRIWEthVk81T29CLzJvRXhOM1RaYzhn?=
 =?utf-8?B?SWU4My96TFBvMHFCVDU2Nnhobys4Ym11Z3hpZE1mdVZEM1N1L2kvMFBQeGMw?=
 =?utf-8?B?QWpqYW9HZVJyNnYwM3pMUlpyaWp0bXZKZ3dNMjRTYWtGKzdIWGNKVzM0bEtG?=
 =?utf-8?B?OTREdlRLMS8zUU1ZUjZjbTkxUkhaak4xWUhUTGhaRko1anBHV3hXNVNEY0J3?=
 =?utf-8?B?WDM4SjZPSFRVb3lGeDNxVGdkY0tpbmVHV1VUQnRlSFFGdlBTd0p0ZldKcW9K?=
 =?utf-8?B?SHd6ZWhJQTJSVXpTNXUxRzFVWkdJMHRwUnZaR2RhN0l1bENtcHI2MmV3QmEy?=
 =?utf-8?B?NDNmRndmT2pMWXY2MTBNRXIvT1lwU29VeEZXL1BuKyt3RVZCNFhDTEl4WEY3?=
 =?utf-8?B?alNTeXVhdnpId2V3aGNpa3NOaWJJRnltSmJMbzIrWGU1OHU3MVVQVFJnVFJ4?=
 =?utf-8?B?OTl1T3cvbitGVGlkdmZRbHo0Z0tTb0h6eUZibzcvd2lkay9GdGR3NHhEQURp?=
 =?utf-8?B?aFRKbGYvb2dmSFhrT2tLSWs4NjdUVXR2ZmxpY2REblljMktGV0ZKalJmZGZw?=
 =?utf-8?B?WWVBelBDS1YxLy9HRnJKVDY4bEtDN3BnSUMrMFNrKzYyQWxaS1dSN1Y1ZDBY?=
 =?utf-8?B?UlBRRjBIc2hNSlNtY0lHRkpla3FqcXJoMkFiUjBoclNFR0JpdEpzM2NSV1M2?=
 =?utf-8?B?UXM0Z0FJUmpTcFNmZklaYjA3RXJ6VnozaVp0dlZXUUE4ck1iQWJ2SjV4RFJh?=
 =?utf-8?B?Qi9qYmZiMW04R2w4Z3pjTzk0VEtPV3ZIZVhtU1RXTUJGaDJjMHY2WUdXcU5U?=
 =?utf-8?B?M2pGL1dWWDM1WC9xQ25UWmYrRTdZam85M2NWOEp2R0tHVDAvOTcyUjdndlky?=
 =?utf-8?B?cWdlUjNLUDk2WDhwZUdlOUcrRWVTUEFReUhrdHB6aGQ2c0h6TTB5T3RBNXJ0?=
 =?utf-8?B?VXB4ZkMyazgxV00ySmtUQXlmQm5SSEsvYU1obG5mYXEwYXVXcHNIaWFQdWYv?=
 =?utf-8?B?SGdpQzNiUjlZbWJTc0FOMlIvODcreExxNWhkUFZiaXlCZ3FYQk53Y3ZiQ2hV?=
 =?utf-8?B?UUhZZ0J2d1ArK3JjNUlOY1FEbDZLLzNya2Z4TUZRRzRucVQ4RFNwRldjZ0Q4?=
 =?utf-8?B?UjdQcTdTSXV1Z0N3Q3lTQXBWYk9xY01LVlk5ZHhmY2ZwTDhNZ3oyMzRNNjBU?=
 =?utf-8?B?NmMyV3JyR3JQaE1uT1ZEWFMyMnFidDBrZHp5ZlhTUXRVVnhjTklhR01kYVQ5?=
 =?utf-8?B?NGlWcjBMQjYrL2FiWnI4SGY2Mk8ya3RrRUxkT1owL3hGclpheG5udkFiZ0NH?=
 =?utf-8?B?cjBYcVpScG4xbDVIWTVFbGo1dWhjblZYMHl0MUVKYzd4YTFxaHlzMVplQmNm?=
 =?utf-8?B?cGZ2N0dSRGFpaWFNVSs5ZlVZclFvZzVjYThFZnQ3NmNMTGF1amN4bGpqNjA5?=
 =?utf-8?B?U2dWaGMxWVhzVUJISU4zVm9mZktJTzZEN2xZZFBSRGE2cCtDd3VLWHhjRit4?=
 =?utf-8?B?amlMdm5BV1dzTkRuVWZ2eWMyd2V6N3cvRU9jSVhWMm1OMDV2RjUwdHhxUUkx?=
 =?utf-8?B?VjIzSXhXZGlTekhBWGRlMlRzakd3cDlReTZ4NjJJSzNCOWJtS1ZwTDNlelJa?=
 =?utf-8?B?V1U0QXdMbm5BenZja0ZualBqY0dlRlBhcTdrLytTVmpwQWJaelBzMldCRkNV?=
 =?utf-8?B?WXNjKzBzSFk1ZG1SSStvS3U0amdKTHpldXBPRllkT1BHZ2YzWHhWYytkM01G?=
 =?utf-8?B?VElDeFozaFFLWFQ2OUtDZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnRVaFNIaEJtZDE5Z1hvQW9IRG9YS2JCeHlkVGpvSW9CaytSUVRCcVVGaFdK?=
 =?utf-8?B?Y3BIZHBseis0anRrR0Rucml1SUJ6VU5zSklKTUJpQzNQZVBPVWsvTlNyYXU2?=
 =?utf-8?B?TWdXNDd1L016K0paRU1mT1EyMEZqVzlSNHNBMTQrWHo2MHFUNHRKWGFhVnlJ?=
 =?utf-8?B?RzNTVGhYOVlYeFhsRWJoNnh4ZU9YaWsrVG9rYXM0aEgyeHF5WlU3aXRPNWZS?=
 =?utf-8?B?YlVPamUyYWlMQmdWcVBGbGluaE5FM2JHbGl3NnlXQXZUUm95MGJJMU5qRzlM?=
 =?utf-8?B?UXZObkdoSUJxeC9pOSt3UWhnQWZHemJDNldaT0xIUzJmZHhrTk1Rek1FVnFG?=
 =?utf-8?B?UXphWllhSlNXZSszOGttM3JRK29OWGRxWnNWWGZqTlZiUXVxcFVrcDVGODV6?=
 =?utf-8?B?QUpsUXQ4RS8xUkptSzFrb1FmQmJWOFhXczQ3RkFvRmpZRUp1eWprWXBBaGY3?=
 =?utf-8?B?S3M1SEtib2tkbytxbXBrczJqQTU4OU1JVjJqN28rcEQvbkJjN0JNajY4OWVT?=
 =?utf-8?B?OE81aTlFajFpWEZEVzFGcUdYZTI1QWtTa3FaL1Z5bEM3UWdEcCtLRWd1eXU4?=
 =?utf-8?B?Y3YvKy9wWVVoUXJiN0p3OUtZRCtldytRWmpKT256Q1l5TkNwYTI3bERRbEVL?=
 =?utf-8?B?S3F2dkd0VENEcGV5THQ1eE81ZmdhQnlIdTE3M1dBaDdWWUhIcGdRTGNaUmV3?=
 =?utf-8?B?cmFnQTlRdUx1T1MyYWpHbmVkVjRvTitielBURDZibVU0UWFnblgvUFU5ZkNy?=
 =?utf-8?B?a3V5MzNlcUdyNFpJSVRNVVMvQ3pVeXdsN1pqMXNWQkZ0VmhuQWJPRkdmT1JO?=
 =?utf-8?B?NVcxNE9IanZSWm5QMDVVVkdLRGhadVpRcFFPbXZOMnZHRzZabDRWbzV3dnY1?=
 =?utf-8?B?YURiYXcrOHBYNGh4VUJ2NXN6K1E0UnBkNFk1bFk2YkQrdXVURVV1K1Uyd0lH?=
 =?utf-8?B?Q0NBUFlFVUdTM3FscUJGQWVFa25rUXlYdnY5VFF3cS9wbWN5Q0hRSW1Qak1x?=
 =?utf-8?B?V1p6cHNpelhqei9JOGlqYStMcXJYdDJuUVhNSXdUVzFiejJHYUlLMGx0bXI3?=
 =?utf-8?B?ZWtGL1BNbkVoczZ1c1BJOWQyaW5WZlhRMXZvc2djbUhhT1N6cnpsUHJUVkUr?=
 =?utf-8?B?N3ZvLzhLZUNxTC9CdGFBREx1bjZtQkdMUlpKQlhpVVB6TEpFVUNEZ2QwQTIy?=
 =?utf-8?B?bmtUc3hHT1E4Y1lIMkVaRTZCNkdITE5WSzlLL1lrWHdGTEFJSFhjbzFVNXEv?=
 =?utf-8?B?Qmd0Y0w3VDFueFVFaThuZ0szeVlKbjNYcmVwZTRyRFo5bmo4cVBSc1Y1Ukxp?=
 =?utf-8?B?UGlkMndLUG9HdWw5R1JlMHhyVy82ek1XQldKME45bFBXR1AxR0U5MUxUdzdq?=
 =?utf-8?B?dStaYkF2VjhXQ1pLWkU2R3JkS3pIRU1jOW82MW04KzZIZk0ydWN0WUtwTFUy?=
 =?utf-8?B?MkYrOWpsVlBacEpDUCtkUWpzUWcxZVJuNVhkRm1TczVuL1hHem9DSU53ZGhB?=
 =?utf-8?B?K0NJV3kwN0R4RkVvdko0SWpWQnA4anpheG42VTlHdlhsbDc5c2x5RkViUnZ5?=
 =?utf-8?B?cjhObHYwcGhDUnlxSDB3UW1KOVNnc1dhYnBIOU1ENjVjUnhmaXZxdEF2dy9M?=
 =?utf-8?B?MWFDUVNwY1ZGNjZEanA1Uk1WTGo4TnFBZGJYZlcyVG5USU81ZjhPR241bzhk?=
 =?utf-8?B?NzdVZ1hqN3VaR1Q5L3BDN3k0bWJZeFYrQXdkT1Jra05DLzU4RFV6a2ljL1FQ?=
 =?utf-8?B?em5JYkJzeXNxbDVxL0pmalFmZFQyczhhaGVpZTNSK01jMXpPbCtRQ3B3UmtJ?=
 =?utf-8?B?R2VGQ2tFcXh4bVplWGtvNzdQdCtyNXoxOUo4d2RTUlpQUXJqL3pHWS9RNCty?=
 =?utf-8?B?cjVURityODVDQTE2MlcwTnVzclZZUEF2cllWTGs3OHloVnNaY0V1RnRuS1BH?=
 =?utf-8?B?YU9tV0FjV2xlOU54Y0s4NlJCVm1Od0toL041WkFNaGdpYkhOZ0p3NGRWbHBv?=
 =?utf-8?B?YnpHNEkvN2tqSEc5a3Fia1l3NUVpOEFzZzF4eDZIQlduSW5RL05OS1cyZ1Zr?=
 =?utf-8?B?a3ZUVG15d1E0VVZkTk45NG9OSDBydFcrQTZ6aTQvN3BDTE96QmlmTEpvenh1?=
 =?utf-8?Q?XRerjYhXlZPk2qpMNM5cZCH9l?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb34174-3fa0-4a42-d447-08dd1787246b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 12:52:15.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDgno8uklBE3waLQOofRVtGAm0gdp6ds1DznyT27W6KRc+4AXE4mI8iyDkNldLhEGuAcb+aJV7TBdHxl68ox+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4136
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Dec 2024 12:52:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17375

From: Jan Kiszka <jan.kiszka@siemens.com>

This variable name confusion caused breakages when using the hook in an
initramfs where no one else provided the dependencies, e.g. when
initramfs-crypt-hook was not used.

Fixes: 35a226b87671 ("initramfs-overlay-hook: Convert to hook.inc")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
index a9e4ca21..56ae8d27 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
@@ -43,7 +43,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
 DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
 
 HOOK_ADD_MODULES = "overlay"
-HOOK_ADD_EXECS = "mountpoint awk e2fsck mke2fs"
+HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
 
 do_install:append() {
     install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
-- 
2.43.0

