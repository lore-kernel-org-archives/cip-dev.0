Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08698C79FAD
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 11:57:06 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10350.1788955016687113099
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2026 04:56:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OMPeZIaM;
 spf=pass (domain: siemens.com, ip: 52.101.70.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OX4gjiQQ2ZOLvlm0Vn7gdTod3/K+jAGVT/bcdgPnwbOn3G9ri/FzDWjmkbaMPGHnEMjEVfdImgMjuKU8qndBXlcdfd3gz16UsMluRrzCOVVO8vtdMK0Dw7mXJAEE7rNHv2Q1l9MvssJhVQeFaHtF3IP1azr6QbsOX2xh6udPWQhfx28UWiqj+Jkq0EEcOMg8NMGwBMnc8GHaZts3GM+Ib6heeNsiTfHQilUJUh37CQsXxf8qhiTb0MFPZqWgdzgrwCKLSSSQe5FMOj3OtCqb0+752/l6jQBcncVz6pprQKhIu2Z+SpEysZn8Gi9+V7JnNlPtJgKZ4GefR+ir1R6Jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0OCfSfcT4qFQhriUgVKbm7V9ILogPBjh725IiRvCAI=;
 b=seuQEbYJvS+pcYE71ry/CkW4cunrrCpsEqVow5MAk6D088Fk+CtwowVdbCDpnenA52+5mC77kIWYQlTPVZ80YdsyWJld0oYQxmcWxQzGtTiO4l3qXgun3yWWHNW3GscoRKdMZhMXU1PH/amm3Bol72GQ0R7O7gcqzy00AafjV/PbjARg6S1prpifGjMJWkcfXWfmpTExyZGy3pvzkEjGpPdXIDIXqUpNhGVHTS7mvUn/LAruaRMpsC0wlB7As0PDiraU/HNN8kygn6O9cLk/Lfq7NqzTjmHhbYmmmwDyJWxtEDitJJIf+HPDh1Twtf/r+W27TbPXuf2v5Plx+rnrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0OCfSfcT4qFQhriUgVKbm7V9ILogPBjh725IiRvCAI=;
 b=OMPeZIaM2xq9LZdlNLxTp9iZxHDegDURveTAMdKsNiTsKgR3HDQssL0JGI0WIBlCU9XlpqrX0creucP4pQSswcnl7ZSEyZv2PSUAFh/mb2+KMZx6CjRhtEXxPn0xwyDfwty9Ks67NC01S1rI0wEPrIBOjf62TdGzK2bz6ynXyRbZ5B4xrQOPEM2+gGtEGUzCUDW/8oXskx99YTVYd9RNpu1oLyrJTkw0L1XxI7htWm8yJtbXhn95aEVmGeEvfCrVcwhb/PRLjrdkpeTZLigHQlOe4I1NP/E+ZwPltXe2RBM5KDa+P7guSeaJHLbKc4oTXu6/X2Y92ZKluSdmz81P7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:639::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 11:56:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 11:56:43 +0000
Message-ID: <50c38fc3-ffd7-4c2a-8884-f37f49709ea4@siemens.com>
Date: Wed, 9 Sep 2026 13:56:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update Isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 89051fb9-20ce-49cb-e3d7-08df0e696ab9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	puKoSuCnQAYk4ncaD2zsGmOD4vBZHqJZbORqrOMEBgwJ+O5legsLgbZJfazVTRy/R3/upxfGWZ1fTmhOikThqaICQOJUy3M3UlACC+8d9eGBQQ5IAUFGKJRcOqSpiLabFlxIS1zQWXm+bIFjg2Wzc02iAEeDuHJbxGgx+6wi8z1GKqm4ziLkLTzFnBI+fN0DhsDU/RcSVuiCfdRzSNP06cuSxxsJjZxvM7GzbOMpKFpX9/xs7XGmxBqyzJGIBywOQ8rbp0I0D4TlR5IgbEiDTjX8pL/Er99EnOIEpGuLaC+a1lUt2h7OyEb9SmtArpbg/K2Y36EeSeIKDFt56w6Qas4yR4ypIaa4w2CWHJZxtTpMjmGxkbMG+Oa+fVaeoIA3fk9ddy5Pmp2T3A2c+WNf8iJTj4uXVdEMVvY/pVf2H+81+adfUkNWs9v/xb8OhUcR0GWu9EUtYCn3sCmy7WZNGs73XSlfg81yH8hZbZIOoc69uUSvIw/zw2LMA+9h/FfaNC6CjNTHs8MliUgZda1mxNAvfHK3eCNvcVx+PAwSXGcJ3c7BgNXr3vR3DBw+xHz+qIsB+1S4nH4oc5zYYs7+rdNtOT3MkrP8Ga1phjIkt0q9mvsM8sxC1SZPu4Z/5wBaGd9gMv7xAJEj5ora3fWd8iyeA3RMSmstBUM1uTJbBWM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHhaMFNVdGZxUFNLbTFnWWhId1hRVzcxTTArd3lDWGt1VElYZmJtTWg0OGF1?=
 =?utf-8?B?SVNVSkt4NW9jWW81aDhCSW5wZmNjWWZBaWZXaFdVd0RjeXViV2RyTFFzbnYr?=
 =?utf-8?B?cG9uOXZyNm0zOXFZSllTR0FtTCtSd1pnVVZWMnJoN3o2OHl6c2NIdXZxcjFN?=
 =?utf-8?B?T0o3bitQeVNBSFJ5MWxxcU5pQ2tpT25IcS9mK3Z1dlpheHpmcFFTMW5XVWdM?=
 =?utf-8?B?dVhRSjU1SXNrVVlRZ3h5K3hOS0JsRmpaU1dvREJORkhkUUFZWmtBVUZYOXNm?=
 =?utf-8?B?RUlNa0hNRTlaZHFaS3RzMGo1ZzBucFVXWWp3WVBtSE9OUlZIcFJUTHg4SklC?=
 =?utf-8?B?UEs5V2oyQmRUUnlodkJ3cmJKRVJER1pQaTdSYzF2TjZYZVZ1ZDdkV2NDMVEy?=
 =?utf-8?B?NGQwQmFnODRsTjFXa0x5ZnlzN3FvWGJvWVlvdkl2akRrSXpjUGN4UXVrOWVL?=
 =?utf-8?B?d2kvdE51WEdMQ09MTElNU0lmdXRKUmFjTlFGNUZPVXBEdURIanlxODFwTmJZ?=
 =?utf-8?B?dHc1NUE2UGl1M0Q5UnloOFhHTGpKWW10dUdGSXBORG92UVpRSW5lMEdoS2lB?=
 =?utf-8?B?RW9TRnpMRE00RkYxclN4Wk8zOUlhMzUxRDNYSU1SMXFoeFdLcmFKY1NORG9U?=
 =?utf-8?B?TDQyWU15TWp4RmE2WkV1MWpvV0N5SzExSGFGQUR2Mit3djFUSmw0b3JsQ0Vl?=
 =?utf-8?B?UmNJRWd2aGtTcWZzN2ZZOG12Ry9ZbGp2NVl0U1k3Q0k2N3J6YVFSMmlSRXZy?=
 =?utf-8?B?Tkt6OGxXb0FRSGkyZ2lDdGI3RDc1UnIzWTE2eUdDT2JPZzVlb0RDanRuOURk?=
 =?utf-8?B?VkhTZWFoa0ptNEtaQmkxTlNyS3FoYVdDL3NmU2o2MlMwZUVLMmVVb2xwdXpm?=
 =?utf-8?B?T25KbEdySlJSV2pnNlNhcHkwWEdLZGhVNysvU1J6N0dUZzQyNExBSzBVQ2xI?=
 =?utf-8?B?UkdyWnlaY2lQM1pRdGtXVkxkZXY2S0tCLzh5OVVsSmJTZGJxZGNpSVdsR21M?=
 =?utf-8?B?SUsvVGxUdHBJNyswTENKelRBeDlnMU8zajVLLys1a3lURlJHQU42dlVjSUd1?=
 =?utf-8?B?UURBL0pzeFpNK2RmRzJGbG5TRXBIZnVmSU02cERBY3dBK053bFJsa2x6Q25R?=
 =?utf-8?B?RjhmNkxDR0hxbUVWVXZWVjFjL3FjL3EyVHVNdmF3aTJIZTZEOTFFRXNWaWM2?=
 =?utf-8?B?Zk4rN3BuQlNUSE1vWjJuRW10UjRLQitKNTlNZVdaWkwwZWc3elExUlNFdU9k?=
 =?utf-8?B?Znh6RnFncGFmUnhJMUptcjZYZDVTUEdDNVcxTXpwMjhEajM2Y01uSVcrZEFv?=
 =?utf-8?B?akJyRzcxUmtvWEtRMVc3SXRHRTQvWlVuWXcyaUFuaVlzNU8yc1l4S0o2OFQ0?=
 =?utf-8?B?MU9EVVUwRjV1emY5Y1FoZHE1d0xOSHBUdzVHUWg0QStDN1NJdUlYblA3S0lB?=
 =?utf-8?B?N0FXbmkvRlY5L280UXptZi9NSXNud1BTTm5wTTErWFFCZ1I5NVBCa0hmTFVj?=
 =?utf-8?B?K1JOQlRreDJGR2ZORUJubE5acEFaOWQ2bUUrcGhBczQxbnAvdERTRFE4anJu?=
 =?utf-8?B?bnhvWUx2cGRlbTlBY2ZYajVQNEpYM1cxcW1CZlJ6ZHlQOStKWmpyNzRmMmxH?=
 =?utf-8?B?N0xMOG1icmo5UXhlTDBGbXM3VGhBcjFpdkl0VEJITmw0UXRxaVlycGY0KzJZ?=
 =?utf-8?B?WmtvemtsUzBTUTBtcVhtSzd6ZTRiNFJtTGYyT2lKRitBWmp0M3pVYitlL2dW?=
 =?utf-8?B?NGRKZEVuMG5Wb3psdDVMcEh5MFF1dERKSDJCM1luUUJhRVdRL0dRbGpOMy83?=
 =?utf-8?B?YjN0dldnNjBiSklPMkVMRFIrbHRoSWNxSUUrejhNSmttdnRjUWRaWmRucnZz?=
 =?utf-8?B?cDBSVTNKeDB6M25qcUZjSjVKODBTQ1NsejFhM3lGVzhqQ3ZEVTVpak4xYUhT?=
 =?utf-8?B?cXpSaHFNUkN4VmhWVTRjWTNLK2kwdE9MNHl3bXVIYlNzenZDMmMrUFhPbnR4?=
 =?utf-8?B?WDlBTjdZSmgyQXVxSUJSbmNTVDVFZk1wMHlnSlZDclpYR2MyRTBBUXE0cDc5?=
 =?utf-8?B?WlNmL2lUQXUxa1V2am9GbjArU2Z4MlpqOW4vSXhkRVliazRYQ3RhSDE2MzQv?=
 =?utf-8?B?d1NLK2xMZjVhZnVhYmllRm5QR2FqZjZhMENrcU9FUElpRmFmcHdqMWFWcEhM?=
 =?utf-8?B?WGtwcW55RVZKYmdJUVppWEV5VTQwRURBTVF0dVF2K0l0NHR4V3hKTUNSNE1i?=
 =?utf-8?B?NE8zYWFkMzVyc3FmRkpicTl0M0FOSHoxVFFLdlFJalZMTjhBM3ZTcEltM2xT?=
 =?utf-8?B?d2c0RVVmSGh4c3BMMkNJWUpnOWFXcnMwS2ZBSzVLZ3hKZDBMV3RqUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89051fb9-20ce-49cb-e3d7-08df0e696ab9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:56:43.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co//t5CMNXEEtCo1OfZXe9oSL1SXPnZdYjZCk3H5vj2jLWuLtAr9aibKxVDFRBnR1OLAKW1GZpI+EyilmPxVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7664
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Sep 2026 11:57:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24109

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes the build issues of retired bullseye LTS and allows to drop a
merged patch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...map-nobody-nogroup-as-dedicated-bloc.patch | 68 -------------------
 kas-cip.yml                                   |  6 +-
 2 files changed, 1 insertion(+), 73 deletions(-)
 delete mode 100644 isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch

diff --git a/isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch b/isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch
deleted file mode 100644
index 6c58c194..00000000
--- a/isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch
+++ /dev/null
@@ -1,68 +0,0 @@
-From ea8f6d883a494430ff7db4ee95a875edee23c020 Mon Sep 17 00:00:00 2001
-From: Felix Moessbauer <felix.moessbauer@siemens.com>
-Date: Thu, 20 Aug 2026 17:10:29 +0200
-Subject: [PATCH] rootless: always map nobody/nogroup as dedicated block
-
-The nobody/nogroup ids were mapped as part of the linear id range,
-with an extra single-id mapping added only if the range was too small
-to contain them. The extra mapping was guarded by "uid_cnt < nobody_id",
-but the linear range ends at uid_cnt-2, so it covers nobody only for
-uid_cnt >= 65536. For a count of 65534 or 65535 neither the linear range
-nor the guard mapped nobody.
-
-Relying on the linear range to cover nobody is unsafe in general. If that
-range covers the outer id that --map-root-user maps to, unshare punches a
-hole out of the mapping, and per unshare(1) this "may result in the
-highest user ID of the mapping not being mapped". That highest id is
-exactly nobody. This happens whenever the subid range overlaps the id of
-the calling user, e.g. with
-
-  builder:0:65536
-
-where the mapped block 1..65534 contains the builder's own uid. The
-resulting namespace then silently lacks a nobody mapping, while a range
-like 100000:65536 is unaffected and hides the problem.
-
-Map nobody/nogroup as a separate block at the top of the range and cap
-the linear range at nobody_id-1. The separate block does not overlap
---map-root-user, so it survives, and a hole now at most costs id 65533.
-
-Fixes: 4fedb1ae ("add support for fully rootless builds")
-Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
----
- meta/classes-global/base.bbclass | 16 ++++++++++------
- 1 file changed, 10 insertions(+), 6 deletions(-)
-
-diff --git a/meta/classes-global/base.bbclass b/meta/classes-global/base.bbclass
-index d96ebef4..8f81ab70 100644
---- a/meta/classes-global/base.bbclass
-+++ b/meta/classes-global/base.bbclass
-@@ -470,15 +470,19 @@ def run_privileged_cmd(d):
-         nobody_subid = uid_base + uid_cnt - 1
-         gid_base, gid_cnt = get_subid_range('/etc/subgid', d)
-         nogroup_subid = gid_base + gid_cnt - 1
-+        # nobody/nogroup need a dedicated block at the top of the range. As part
-+        # of the linear range they are lost whenever that range covers the outer
-+        # id of --map-root-user, because unshare then punches out a hole and
-+        # drops the highest id of the range.
-+        uid_linear_cnt = min(uid_cnt - 2, nobody_id - 1)
-+        gid_linear_cnt = min(gid_cnt - 2, nobody_id - 1)
-         cmd = 'unshare --mount --pid --uts --ipc --user' \
-               ' --kill-child' \
-               ' --setuid 0 --setgid 0 --fork' \
--              f' --map-users  1:{uid_base+1}:{uid_cnt-2}' \
--              f' --map-groups 1:{gid_base+1}:{gid_cnt-2}'
--        if uid_cnt < nobody_id:
--            cmd += f' --map-users  {nobody_id}:{nobody_subid}:1'
--        if gid_cnt < nobody_id:
--            cmd += f' --map-groups {nobody_id}:{nogroup_subid}:1'
-+              f' --map-users  1:{uid_base+1}:{uid_linear_cnt}' \
-+              f' --map-groups 1:{gid_base+1}:{gid_linear_cnt}' \
-+              f' --map-users  {nobody_id}:{nobody_subid}:1' \
-+              f' --map-groups {nobody_id}:{nogroup_subid}:1'
-         cmd += " --map-root-user"
-     else:
-         cmd = 'sudo -E'
--- 
-2.47.3
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 43aeb2d6..53d61bb9 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,13 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 436bc96f3869b4a139357afbabb039caf4df7c5c
+    commit: 589bee972846c1f88797465262d1efbbb254d4d0
     layers:
       meta:
-    patches:
-      p1:
-        path: isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch
-        repo: cip-core
 
 bblayers_conf_header:
   standard: |
-- 
2.47.3

