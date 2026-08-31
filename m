Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B64C624A5
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 06:27:52 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23847.1788157668398178399
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2026 23:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sZT7i1OT;
 spf=pass (domain: siemens.com, ip: 40.107.162.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpH2iZBRAlPl3Rr5Ee1CCAcrkC3KRCWPIDyY21oM1YelYIPF071aJBnMEETQJIb/PGshaDkw11OZzSafjbjAwZDq6aSoekE0V7WA7lBRBrhJawiEey0OhZFaNHJ3jDQ2aO0EuT+Zd7hB4vvR3eqIslJQ8OfhhtrSgBgBSjtUEHPALxd2V610R0gtUAkzNzGycEkSepPIAbpxtUZHqaZQEQJUUBg0mM6Dp7OS9h+iJjRzPxOo5jA45UuMYNdz1MFx9S9SwAPPSZa+Ttcza8WA9gq/eXnXF/5yUnk96guUBPpTmVr6SrHcblniInEqiovw9H+mRHVnnAj0/HoMX8+fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZC4zuNT3ghA5SyQMt3cV5NMxNC1YjVFIC9yTtiaPDQ=;
 b=LA+hhWrNvDCofD57o359mx9WHBj7tso4dCSJGXnElgN/Kj4VUWx0kWewNaXRC02Ba6CiAKj+Q+thc3RMtIBYgyNUfHGOcC2PByEF4z6kXylpsVPCZ6rv/GyDc30F222aLZ4vXCDezq/S8Vbc0ajNVUKbZOIqR6mgQg0hvK0LzQPmKqbwNxAR3SJE/TvU/5RnoVNujq7fbQFW93PLYpMcWOUXT4jaMBIoTViptAYDp83dedO57qMdKPPFSZi5hFhSYL+STQTcsvJaB+tfrCQgMHMzPIHvSxNApNLoJeYfi8yIXqdFygPE88JH5PNoBExRXwJ5InzbFNauCIaYzVn8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZC4zuNT3ghA5SyQMt3cV5NMxNC1YjVFIC9yTtiaPDQ=;
 b=sZT7i1OTuB/FBznGey2YsAIww0sBs+6DnnUePWm87fPukgk7OXcRHk1bbwRyTWlX0mSxYOdDxHWDaMB2ufEJhBF5bz1nxOl/y9P9zwhdeXp0LUhsfLVnWlosG3xqTr2KAzC8jmNgpONuNRhEZRmelGOHWjIhBOtPshsYKZRG9OUBMUG5eC0iSOkBFYPHzN+sbePXiuWvep8FXUHuvaYQJPsCduY+igKqyRmwDP11idALw8ahypJKkSTgYZWCwlxtd6lAyurR2wfjyesWT9v0nhVMGTdyXDyNt5yoI9MivDK2fSTg98XzHU76y9lLPZYcKZyjS/9eJbztzL4uKZy1Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:27:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:27:47 +0000
Message-ID: <e7dae4d2-5940-4945-900b-14e442977ab2@siemens.com>
Date: Mon, 31 Aug 2026 08:27:47 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 2/2] optee-os: Move common fTPM/StMM related
 code into include
Content-Language: en-US
In-Reply-To: <cb867b1c-31ef-4764-ae18-6c49d35e3a22@siemens.com>
Cc: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3140:EE_
X-MS-Office365-Filtering-Correlation-Id: abb32458-b609-4596-6933-08df0728f927
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|10067099003|18002099003|55112099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	wfkTPF2MBqQPv3izj+72i27J+4srR/qwBfbUfxzmhY0KZTLuINV2UAr/7mJBY9r/n0nP3BXvz6JPnUFHASmmJ3Vl8aNORuP0ALn0Ke+FFPyUfMPX0e4nq0G3HDshYBh3+FFXkNMgAL52/mSy7ZRzBBltogI003af6eElnEq7oD6xquvI01UvVYb0jPXWxkaibTAL1qrwQ3Z0VPX20mYhPNFDFYkARgTbKtVJeALb7OW6imx6Lv2U3tSEYBRAZ8OyiKZkjBIet9wTK1IYEbbXR8oSviQGxy9LLigSGmnXQ0p7dWgLloGoCwDvONwSTIFcykqLJ6KnptouPwcOWOYIIsxlnSXaJakwTfRBX4oHOBpHQF7Z/7Ok9ksUfkcpW/6xTTXqstPXNwuBfM105zlce3nM4n/CdANwi1NhuzUFarmqBM0Y00xg+LsQ40sZJqdFoj1QzNb9lC7hylfSEmciD/xcods8FdeWtawJbNwraUImL5FBHeI19deBP6ced/QapMHKSs/57m5bcCpwoB1IjspkleYfF+ZFzIMvdjsSzGp5emhQyRK4RupuJ+uKbwpNcgRVEeT70T221w4UZxq27YUqlsSbzK+uwCAmgOF70hkGDSrS1o/RdYg6ps8FlNCnSjjtknxisLS1+/QzVDQ3PYBS0LNpblsxCn/pRm2K1Fc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(18002099003)(55112099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWRrVHBha1JZYTdiVDAvUlZ6bTZzRWZqSjRIQ2RrOFdiNWFOVnh1Q2R0MnRY?=
 =?utf-8?B?RzhTVjJrVS9YSVdLNjhnMjR1NUE5VERzdUFnTHdQcFJNN1R4d3NzdXhIQUNm?=
 =?utf-8?B?NEg2QWNnZnUwamh6a2c1QlprYmt0UXVIZFY3dzlWWU1hQkYxU3ZHdVA0WS85?=
 =?utf-8?B?RXBhY09mYUlYNFJsM3lGNFZJNXZpYW9sR2pWTUtMa08vUlcwV211bXpnOFJI?=
 =?utf-8?B?cmNObWN4UWlwUFgxTkdEZzM2MHJ4ZXY2Z0xhOHhVdlVoRkM2TTdiZllHQWVX?=
 =?utf-8?B?WUpSVTZKZHNsMEErZW9vNnVxcWVNS2ZUREhhZE41ek1YWUJoM0IvL2hSMDZO?=
 =?utf-8?B?ODdJVUZXMDNkQ3pBUVVPNWIwWnU2bndLWGV6Ykh0L2J0WkxjcTdLckRURDB2?=
 =?utf-8?B?TkF0VGxiS1hUQkRhNUxScUJnVDhaUlFZRCt1UkhiYWErMDBJV2NaOUZnQ2lN?=
 =?utf-8?B?M1RpNVFwb3ZWbS80OXgyMitVbTV0VG9wbEI1Wkt2VkIwTXJVZ2pEWDJXeUJU?=
 =?utf-8?B?amJVRTRLVXErM1BVdlVUTkpUM2ZsWERCbjdueWNUNC8rek8rVjdpYnpUcTdU?=
 =?utf-8?B?bDlwYVJ0dXBRWkFXQ2RrZUF2K1RscGpXL3BRTm94YVpGRWJMNG15cFFDdWVE?=
 =?utf-8?B?WVF2Rkg4MFhFZ1YzSTdmbUlhVElSSzVwcSt6dzJ3d3ROVDV6TnhGcWRuckk2?=
 =?utf-8?B?SUMxWGJ4ZGo1cVFqajBHSWxKQUJqdmpHNWNManpHanlBVEh3WTJ5ZW5wZzFv?=
 =?utf-8?B?Vk5HVjBhNFQ1NGNvVXFvNk5BdE5FTDVCM3BnMkZWU1JDekVOSkhaV0plV0JG?=
 =?utf-8?B?MUtCenc0bkZPdGR6M0JLeGdYbEdpOVlUNUZQaE5QOVRONTZPaERreWRWOFFl?=
 =?utf-8?B?MzZENmRWYXd0dmRIeEtMVzBDVG5hQkhKbEZ5SEJmclRlOG9SQ0hyY2xEUmlL?=
 =?utf-8?B?VmoveHdwbUxkZTQxTnMrOW1DQlBsUFRtOXh5RmFueEhDMytJc0FXOVZNeW1J?=
 =?utf-8?B?VnFvbXNVWTdMMGw0ZFpLMWlDdnA5U3UxYmZkQXVXV2pkZFdPT0ZzOUV5a0ds?=
 =?utf-8?B?ZUtPL1Rwc2lrS1VQWExRZGd6aXcyeld1Tnp1K3IvY1lITWJUUU1ycE1sZnFK?=
 =?utf-8?B?WEV3UXhyZk5SN2tOVTJnc3M1dUJMN0pBeVdNVGdSRHJaZm9Mck5KeUF4Z0dK?=
 =?utf-8?B?NTNoQWhCMDNPMU5zTnZlSFJ3cWJpZUs1alhLcGhPaDBwdWdCY1J0RzhtNjQ1?=
 =?utf-8?B?ZytidG02bDhyNnFWK1hHMEpWRXFJVlhHeDhhditRRWJjdkVCWUt4cmYxNHNS?=
 =?utf-8?B?TDBESDllNC9hL09icURQditjTW1wZDNENHZoNTFvc1Z5S3JrTTdFMnpaUXQ4?=
 =?utf-8?B?aUY2blYrZGcyNGtKWjV5UjRjSGF6QXl5c0pQOXNUVlgrOUw0cklEMUV1SjVx?=
 =?utf-8?B?clNwZS9rRjBraWQ3Qy96eTltVGNvZ0pMREUzSFFsWFI5ZXFnaFlFNFcyOFlC?=
 =?utf-8?B?WFQ0ZDJ6NzdGZVRVc0RJTnVOc0E0ZkFkTGk1THVZVjRIbmcwdjJvWFJaaSs5?=
 =?utf-8?B?NFZiaTlKdSthckI2Zm9TVko3TU9CMmRCVWZmSGoweWJEQXhFVE9QU3llcmdU?=
 =?utf-8?B?YlpHdjRYTDYvVXR2UDQ0ck1qSWxFck41MzFwN0IzSXVrWm1zZTYzZDhjYmla?=
 =?utf-8?B?SnpqMUdweTM2dU5iYVZtZmtjM3N3SHF6aXBnYm5POFYyNFBwanlQUzVsSWRm?=
 =?utf-8?B?Rysxd01WditXNnZXZUJjeWxIenNyME5reTM0cWl6UFRINEZ2eG9FRFNFK1Ny?=
 =?utf-8?B?RWhPMWNXSGxYczZOV3BCendKSzdGN05RaHV0dHc1WVQwL3kyaE13c1d5T3ow?=
 =?utf-8?B?MisyNmw1YW9RQXYwdm8vRlRROHJwZnFkV1BsRFR3WU14blk3Z2RsZjVHbzV1?=
 =?utf-8?B?NWh6Y0tUQitkK0tVMFk4bFpMNkg2cWprY0l5S05jd0VKT0FyTmhpeXpuUGE1?=
 =?utf-8?B?Y0EwSkthaDE0dFp4SEZYUCtvYWptQ090bVZHRmJQcTZoRGx0anFicldmK0hI?=
 =?utf-8?B?U3AxdGtRTDJLV2xGREpUQWRyb1Q0aE9SV1BCSTBHZTBDNldtQkFndHhZL0V4?=
 =?utf-8?B?dzR4cW5tSnhnODk2WlROblMyN09uZ25lUFh5MlFVNWs4YldXeE9VOU5Gc0hG?=
 =?utf-8?B?b2lCVkwyV2lEci9XckFiNzNuS3NhUm15Ni9Eay9xYzVzMkNSaC9TclM4cXlW?=
 =?utf-8?B?d1JZL1Z3KzQwUnI4RXNNanZOVExFZmV0YkxKcy96YVZyU2ZHckxqQVJadVZl?=
 =?utf-8?B?cmRwNE9vOUd4ZkRqMG1YeVd1Y1RLOThqKzdlWFh0Ni9XM2Y0NExQdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb32458-b609-4596-6933-08df0728f927
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:27:47.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q12m3bPw/APiKqxX+qQh7fuQCcnXEtKIVNs+kKtI9TvO+UkVYVaaijqW8gOWZrCUXaCQpyaGmk8grENTRL4row==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Aug 2026 06:27:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24048

From: Jan Kiszka <jan.kiszka@siemens.com>

Before more boards might be added, better have the addition of fTPM and
StMM TAs concentrated in a common include. We can also avoid the complex
override logic by only including this file from the optee-os recipe,
rather than the versioned optee-os include which is shared with the
tadevkit.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/optee-os/optee-os-ftpm-stmm.inc   | 25 +++++++++++++++++++
 .../optee-os/optee-os-qemu-arm64_4.10.0.bb    |  3 ++-
 recipes-bsp/optee-os/optee-os-qemu.inc        | 18 -------------
 .../optee-os-tadevkit-qemu-arm64_4.10.0.bb    |  2 --
 .../optee-os-tadevkit-ti-k3_4.10.0.bb         |  2 --
 recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb | 16 +-----------
 .../optee-os/optee-os-ti-k3_4.10.0.inc        |  3 ---
 7 files changed, 28 insertions(+), 41 deletions(-)
 create mode 100644 recipes-bsp/optee-os/optee-os-ftpm-stmm.inc

diff --git a/recipes-bsp/optee-os/optee-os-ftpm-stmm.inc b/recipes-bsp/optee-os/optee-os-ftpm-stmm.inc
new file mode 100644
index 00000000..1d7b6334
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-ftpm-stmm.inc
@@ -0,0 +1,25 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025-2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# StMM integration, required by UEFI auth variable management
+DEPENDS:append = " edk2-standalonemm-rpmb"
+DEBIAN_BUILD_DEPENDS:append = ", edk2-standalonemm-rpmb"
+OPTEE_EXTRA_BUILDARGS:append = " \
+    CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd \
+    "
+
+# OP-TEE fTPM integration
+DEPENDS:append = " optee-ftpm-${OPTEE_NAME}"
+DEBIAN_BUILD_DEPENDS:append = ", optee-ftpm-${OPTEE_NAME}"
+FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
+OPTEE_EXTRA_BUILDARGS:append = " \
+    EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
+    "
diff --git a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.bb b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.bb
index 881cbc77..a976638e 100644
--- a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.bb
+++ b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.10.0.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,3 +12,4 @@
 inherit optee-os
 
 require optee-os-qemu-arm64_${PV}.inc
+require optee-os-ftpm-stmm.inc
diff --git a/recipes-bsp/optee-os/optee-os-qemu.inc b/recipes-bsp/optee-os/optee-os-qemu.inc
index 48a51b8e..2146f712 100644
--- a/recipes-bsp/optee-os/optee-os-qemu.inc
+++ b/recipes-bsp/optee-os/optee-os-qemu.inc
@@ -25,21 +25,3 @@ OPTEE_EXTRA_BUILDARGS = " \
     CFG_REE_FS=n CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_FS=y \
     CFG_RPMB_WRITE_KEY=y CFG_RPMB_TESTKEY=y \
     "
-
-OPTEE_ENABLE_APPS ?= "1"
-OVERRIDES .= "${@':optee-with-apps' if bb.utils.to_boolean(d.getVar("OPTEE_ENABLE_APPS")) else ''}"
-
-# StMM integration, required by UEFI auth variable management
-DEPENDS:append:optee-with-apps = " edk2-standalonemm-rpmb"
-DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", edk2-standalonemm-rpmb"
-OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
-    CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd \
-    "
-
-# OP-TEE fTPM integration
-DEPENDS:append:optee-with-apps = " optee-ftpm-${OPTEE_NAME}"
-DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", optee-ftpm-${OPTEE_NAME}"
-FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
-OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
-    EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
-    "
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.10.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.10.0.bb
index 0bd7c22c..d752202b 100644
--- a/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.10.0.bb
+++ b/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.10.0.bb
@@ -11,6 +11,4 @@
 
 inherit optee-os-tadevkit
 
-OPTEE_ENABLE_APPS = "0"
-
 require optee-os-qemu-arm64_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.10.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.10.0.bb
index 158030aa..e81e10f4 100644
--- a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.10.0.bb
+++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.10.0.bb
@@ -9,6 +9,4 @@
 
 inherit optee-os-tadevkit
 
-OPTEE_ENABLE_APPS = "0"
-
 require optee-os-ti-k3_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
index 1090e081..f89bbdde 100644
--- a/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.bb
@@ -10,18 +10,4 @@
 inherit optee-os
 
 require optee-os-ti-k3_${PV}.inc
-
-# StMM integration, required by UEFI auth variable management
-DEPENDS:append:optee-with-apps = " edk2-standalonemm-rpmb"
-DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", edk2-standalonemm-rpmb"
-OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
-	CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd \
-	"
-
-# OP-TEE fTPM integration
-DEPENDS:append:optee-with-apps = " optee-ftpm-${OPTEE_NAME}"
-DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", optee-ftpm-${OPTEE_NAME}"
-FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
-OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
-	EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
-	"
+require optee-os-ftpm-stmm.inc
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.inc
index a111364a..c77161d3 100644
--- a/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.inc
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.10.0.inc
@@ -30,6 +30,3 @@ OPTEE_EXTRA_BUILDARGS += " \
 	"
 
 DEBIAN_BUILD_DEPENDS += ", device-tree-compiler, python3-cryptography:native"
-
-OPTEE_ENABLE_APPS ?= "1"
-OVERRIDES .= "${@':optee-with-apps' if bb.utils.to_boolean(d.getVar("OPTEE_ENABLE_APPS")) else ''}"
-- 
2.47.3

