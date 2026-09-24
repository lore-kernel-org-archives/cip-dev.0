Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB8C98321
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:23 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5834.1790249777502329221
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=olV0EeEP;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJwQdLgSj8Hp9bhIRhmKEyWtgXc5N9KLOEr4254YlfdDunfcddAciIp52JokoZ3YKGuJk5KeCnSD5mnQ3+Y7RsvdbtHOr/OA7DpqyidWaLBbBG9a2GKVXXxFL/yk/3wvTPZIJJLm+Qkw4tKr7uq8jVD9byfSQYKL04FJqdCgHOXvvOPkOKVVUegdRpJIgNZvTGUwaaCkpjTDTojUUPWKlNgGZbrNZwLLhGpbql4vuHQU9weVOmNaPMJArFzPzx0squty3rJQNzESfsRpXRT2Crtcjm6OWdr97x5F5kWm0UnBr8WZWLvZBBu1+xoB3KciAqeojyv16xUGV2SNOEWlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+olIPPeuv1gGYwKHAAEq4zX+rGVxYfP9+SJ/39ejY/U=;
 b=yYMwaG+TFDsClwiayCVLWb3EGrMlsft5AyjTy2ZYdWAyfkSWvop6kE7GkkqlmA+0OJ9YJ7CEBcpb8LHVzF4wsrCPuX2/lDF/ZhzVftiriUmiBCkOjtRFuaPfgxFFUw94dO8ks0jDq16pmKU1XFohG+z0e7v9ieUgjwfczcoEfqhJRb+s4a4ss4mzVG3hFb0RIlwz+RvfMEeMMUjlbZx2kxjI/whyVzea34Z+BkVXLQT6GoAHe8HnaopCOKMiuuLmbPz295Hul1E5Zvpzh6qa87ESxpThibSLEzeMF+shI6HPkPAY/omW+25Xv+rvF/6Kn4AQeJ8LZnTV4Whz2evZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+olIPPeuv1gGYwKHAAEq4zX+rGVxYfP9+SJ/39ejY/U=;
 b=olV0EeEPGMBgfEVFNe9jPRDhWplyfI1IXccROUYflW68gyeE0Ts8vzL13jqdkmCYsOe8Mm+cVVAXxaRmzUjZBX2SViJkPIDqOugy3EwxQGgIg+62lERe6KJ+RzR/fYGqtyv3Ly4T4fTR9xty+NfTXubXJHZXSSbJVWqG0y4xxNInSo/VMTSMUm1by65qbK8/WhIOOnyJmu2PouO1yV3pdLbcG3gNe6jKStirNbe0152qkz+/YmVFyFq8rH6aatkIQOuhnTQQpGOH+WcSFSs5K7tDFxv+XVyJc5OLTKJ/9Cq/BTzvzvMGag5tVQzzgmKyrTDYSLfz2nnPYiBIVzU/AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:12 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:12 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 11/13] Integrate kernel validation into linux-cip
Date: Thu, 24 Sep 2026 13:35:11 +0200
Message-ID: <20260924113557.3191996-12-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 98636637-531d-4401-69a1-08df1a3007b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	i8HP9MADZMsysiRQWuFGdluc4pmvxNoWsICGyJRlEutiBmB1AVJA5IMxph2RN16A462QmDC62zsKO9IzAECAXoL4NTP5JzC5CoZEkikLAGANkLlpaXbApCq/j/h5ufk7ZxSuYJzwSsLyKQz66Mw49oCD/F1FdUeyj9/aTg4iPCgxRa03CZ43EZTlYMjyKJmE703o0dw7Q9D6YWXqfI2PmcB8J4GQok/pN5GGTM9hK3s9OjJkY92cGji1+fwBPkvn8XjPI2ZX9KUZvpC68Lbixowo0x8S2zEbIzug9gWr4bvPFnmzZ/Zv4Da60b602LT9MjrQrYy8Z/mE/XyAL6x7DCjoCpuX9G7ehtA3/2XYNScZbNvrrejLMIV3uXI+vdRTXkl9Rxrh16KN9R0OiCyFXM3+7+rwGCNeUrgkvmxH6bm+xJthHMvyCA0RhSkipQLk7arbCucUIjktd4E5JMHNy6Q3tYF2xd8dvJXUMlxuqfJv+XTjDz/nEGFZJ2+qtLBTYYBq1Qo1yhqyWnIcs1BXU6CXiJfuS09i8OmrICBEJudsiN81aj2b76iZMK8gfXt/zb/DGbijhllphTHcxet9zZuM2UHesnHCTmYS+qoV5+4IfffKaR6D3jRRNbCSAC+np+w40wcOE2eN7t/hDB86FjlCQe+jAMQVL/pApeFRM04=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G+DG2p6+2nHQfyCS7XaPmToVSSsagUGma3MjRiVdfu7zdjgrffPYpkCxG7j8?=
 =?us-ascii?Q?tV5d9gSKB9j2Z2010lCuy/Vq2MX63UsGNVGbdM/emEi/0UImQg3ObV91H2He?=
 =?us-ascii?Q?IeZabrH9MGnQ30GcYi3fYCF/RtEV8gudXT3Ji/sxDDAJ+2s0BCfnpS0LwYoK?=
 =?us-ascii?Q?doxxu5HVjtT7AfgTdhrs7jyo8twsnw1VTxYK1W/PBafcEGZ4rDrOHyDanoN0?=
 =?us-ascii?Q?2RMEqS+tAAIMmBp39biH0/pUZrLiEYSBdFAHWkvf9pf5L91kNdNFQnhXv8GP?=
 =?us-ascii?Q?lx+SN5JXcuIfIpLbUtb3y88ohk8VL4gOR6APZxTaZAkj8XuwYp2z9X4cgrjF?=
 =?us-ascii?Q?iXxdy9sL1ikPFryB7VGkQz/Llpsd99dsFDEFxjrBr9XNzoGnnlALdbIFdPJw?=
 =?us-ascii?Q?EZtpFzHuHE3xl29KYKXI4no+J0pFmgrJzPPVWKimp6pSUcDfbD3wB99KQQos?=
 =?us-ascii?Q?gqaepLBS9dUmbwXYtr+yLaazchVM+xzO9FP7jtrI0FYBQIi8m3bs0H2cINzp?=
 =?us-ascii?Q?WWs+/s1m3X+e2CdWdpQGUYwqJty6QTckqQkYxq+BBUIEgi8q+6RME1Ykm7jR?=
 =?us-ascii?Q?TF4ESFK89M/lYFRRaY1pIMDaXk65vVe/i8k8yDGgeigwKgZl/qeyVCam3x4B?=
 =?us-ascii?Q?7ta8fpL9XGp7HqVCbKwde9Uu4xhUTu6+wbAyIyGpMNR8qEvzZhP1fdG/nyet?=
 =?us-ascii?Q?tont+YBDwTfvbtLGUKjG5n239zDhKMkocZTi4OrwyY1jsaZbrDURf2mHsvbf?=
 =?us-ascii?Q?nIdseZOhhN3j9YohNQHsIbL4aXhJXNw03pRHUfVQYRleNAlB2ohQOyasJF2S?=
 =?us-ascii?Q?dUCaHH23/VZALGmd2qtmt6WOLiSzXBLVwrPgN790AADys/UGS9WwU8C0wi/n?=
 =?us-ascii?Q?NCPlJ7wmgl1zK0nahMgrfLnPTT/9D5NhrXf2oKCgsunDXCr2kIlO5SVRc/Cs?=
 =?us-ascii?Q?/SYvTF1+T2ai0LJTGCAxUQIAUldtxeIkdoOYjSa8HdpZIOOCPZmovZhRRo1d?=
 =?us-ascii?Q?GZ9be86lT6+djUiKKDo+RlpJX/MNE4RbDSDiPKdmFrjhzHzhQCnsob0uuc/I?=
 =?us-ascii?Q?TzBYDdIwm/wcodO4LGsaRH2+jsGuHJyJB49h714h3QlHBuax4yijV15Uh7Rf?=
 =?us-ascii?Q?KVR5CpkNkutgkoK8W/8ltV59dFWeSXgGYfmsHUUQUxb5ex3jTz/cnMor2vj3?=
 =?us-ascii?Q?BksdxQ2C2YghI/xm4XMtTnN4MWiAdu5h8ioYbkkInhqZUXyWiFlMXFcjfjau?=
 =?us-ascii?Q?J9gOh47czL725jNEcXQ8ZszKDVXlKirVAFilidkRD+78D5ozwoFfmFQJkmv2?=
 =?us-ascii?Q?uilR2JoI1WrOnx1QE0Dan9WgWPOZYgb3cN/ARe3857+NdCPycNc5bzOG3nvR?=
 =?us-ascii?Q?J4oLrebATjhmJx0I3LYenFbfo7SYKI9FVXDVANzkEG0Lv9JSL7XYSE1sz3gm?=
 =?us-ascii?Q?4Xg2Z+DezZJIZnqi5uPWO9lxHR1ZIsvA9YS8Y7gz8DY+vllsdBntjO/gAJo6?=
 =?us-ascii?Q?L/GAU4mLayi6bHV5ndqRMARZIdPMMWshSh7FBDdQ1wN6c1UQJcTDeE+TmhAs?=
 =?us-ascii?Q?+jIYrsLHRsuMVcvVLTLzYF5YfI08g4U3xAyezdsjNV0IjXqRbsFxG5KZLTNL?=
 =?us-ascii?Q?a/WtwBKYamG2Aeyo6GU/btUmk6pbY1VE+PV35HLxRF/veSO9Eor/H3MmJGKX?=
 =?us-ascii?Q?/ooi8z4LBPnWAERcW0yhdqi0Ng1hbIPqfCKrd3xLHLqlcoGEj+9VeYB8/V31?=
 =?us-ascii?Q?MhUeF9gmiU53IKlNa24k5nx3OyDU0vI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98636637-531d-4401-69a1-08df1a3007b8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:10.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7ylaAV8IsmnvUYuXXRIxuKJVBRs6MbROSpNAotxQ+f283vuEnTadUUl6Ce9quhRyz8IYT9hLwfcY/H9d1paIrXqSNv/Qmj/YQgvB0nL54Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24325

Inherit cis-kernel-hardening-validation for kernels built from this
layer if both CIP_CIS_HARDENING and CIP_CIS_HARDENING_VALIDATION are
set.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/kernel-hardening.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/lin=
ux/kernel-hardening.inc
index 9ad8f080..027598a2 100644
--- a/recipes-kernel/linux/kernel-hardening.inc
+++ b/recipes-kernel/linux/kernel-hardening.inc
@@ -14,3 +14,5 @@ do_dpkg_source[depends] +=3D "${@'cip-cis-rules-config:do=
_deploy_hardening' if bb.
 do_dpkg_source:prepend:kernel-hardening() {
     cp ${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_KCONFIG} ${WORKDIR}/hardeni=
ng.kernel.cfg
 }
+
+inherit_defer ${@'cis-kernel-hardening-validation' if bb.utils.to_boolean(=
d.getVar('CIP_CIS_HARDENING')) and bb.utils.to_boolean(d.getVar('CIP_CIS_HA=
RDENING_VALIDATION')) else ''}
--=20
2.55.0


