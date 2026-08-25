Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C1FC61DC2
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 14:38:17 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23566.1787668694022419751
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 07:38:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gWLCx5pV;
 spf=pass (domain: siemens.com, ip: 52.101.83.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0KygZxMEjr3336yON8pPLiN6zFV4DySTidcn4WItDWNVMQgPmv6EXXYgTUrBqagJrWbBWwmUSb0xyOZVIRbnSvWzu8rSKuzoQSAjt+qBA/C8wRpZ9+I8zH98AP3GhkPfTRg9Q81/PGPx4qya+yuwcpOe4dUudcxi2dynjRZgQSi5v0sAomaZkHqX4+n96wW9++fi8kYfT3TT8hmCV+gdudrljyAXQkCs2xOpuuznTrEE7DQWIj/+wSY2qy7avnduBNtpert9eSmDqqE6SL4SUSNiEDkpjhbXxbIRy+UY5OmzlQTxYngzRlB5HzbRZK1DTnbQdDgz8BmgbvrK34usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnfaKG7u5ShQhGdnIKtLVOSQ6cojNKxdZfO+4rNIYkE=;
 b=sGpl+hCY+zS17qdyNxzvcP1jqUl+MxBNGrfbja3DLedI/9yaHKU3vkeDtxpQqVJCBCZwrG+Mi/A9OFaMFjqBF18d2uCYeGyUbV+xALSbdsanu39vArQ67Y2oyLEaO+nECKAT9GRq4uMD949+C6z80MOl96FRm/KXOwBbNh9kNTLhi+FpAxJTh7LH9hy7EoTP54uGH36TtvIc3mNd7QeIUccQURSyybYm28KBzz3Kq8KbW/7l6NoWTNVLzeHqeIHJl7kWrImoXMi0RcPHhxX3b1RxdnL6ZmE89YXs7qTOvqeB2/BDYtLjKd4cFktWbYIU2urHfdeLCihy3zI8Rz7Z5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnfaKG7u5ShQhGdnIKtLVOSQ6cojNKxdZfO+4rNIYkE=;
 b=gWLCx5pVyqt2EMyBPG7hPt9jFniwi+emJnyt+DeA9BZiKF/Ozhal67+d0Y4Oo8hkY2hXkNnTnwLcJz1mgyn3JnKWI8pY5DtdVi9eoLs3tcO8POQ+LKacJ1gawk/nRTMQNaJZd8xLRjmRvOV/HYq23chyekq/6AvrVvXGScv/kyb5PMh87jvv3Ba76oXs51F6LLwDsl69e31PszBSdoftLvKHf4+G3XCpOFZKx3WzCosHBEoXCeMfNUnP1JP3jfQ6O3zGQHa7r540RN3N5WhduJOlGOVc85SmHIn9y137VGVewF2+rMRlIIysManpkDwtUXM5zgmFLpOH/BF7ZbcH/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 14:38:09 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:38:09 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	alexander.heinisch@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 1/2] initramfs-crypt-hook: Move service watchdog to cip functions
Date: Tue, 25 Aug 2026 16:37:47 +0200
Message-ID: <20260825143802.3764929-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAWPR10MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: a35f6b31-3761-48cf-dbfc-08df02b67ba2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	4CTn2aCB2hjc5ltEyu1Ui5XQMBjqhRuKkQ20CedgHRsaiEGezXenLzrNqmaDvbhg5htlz4yVS264jMF494gWk2xp3paq/Tx1pt/XKd0usZrNTKtoRnqLzvu+CrKIEjsgt7Hgj2c5BioTPEHM5x93bidwEUF5q3hbnUyzr3ORfOcHr1k72FYh1ERZQY/qslC82TJTjmSYXPl0D4Q56vhi1Pp7qCdh8yEykLbnLUnxIsOxiPwlCrkFA1cNIX+g/hU3mBrfWqctGdZg7Hapqs7hk+zogUKC4CXJKH8Dv1SXLREusQ/NF7g9axahfPG6kuWK01/q6gV7mVcda4kWR6ZNAI15RgSfEhGY1ZN9ptwUPrKpLYyP/RloDHXE7Tt+jeItscUodRG7ws4DsjBND+TvS5wsvxZ9RHfwpNRQlB6cyCw/ZzATKbYHvFzR6PdpKArD89rsyIqL/ip2AY0oxs61riZdgAllTKc2/23K1q8PMbZheiuSSwGK1Kr09tOchQ5yTnznPCjmtGCapNJGnciYigKxumjxnh+40dJhPpWv5Mv95U2b8Xg1FAzwzZmG0oLZn++yamOzJ/IF4WuW/BC60YxJJmRamX3caui9rRFBHjv7LEVNVIukVOVBy0IcJ6xjSVPALqlT/r/bNR+df2yax78s2paYXCpmZEyv1EW5/7Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m2caoc8T9Mlq+UmBbkxirIO/KHA8LEpbghmCMAcW1S4uQsxonn5V6+LNl8kM?=
 =?us-ascii?Q?IdhUOv/xThu5h7Xa4Elh3f6CbleUDdLlod6Hr7ngvySRBj+aNyfOKkLiOqnH?=
 =?us-ascii?Q?LzXeriUffo6XcFvQTci4aAgzrHwUnRyDnksLLW+bSLlXpfaQ9KzmExbFAq0P?=
 =?us-ascii?Q?xp+Jag5M/iAp7bd3K07TLLBnXcG7no0TGduW7VIoK4tMfXQRgwi1dB7qhEOD?=
 =?us-ascii?Q?RsoQdMVhl9SCM628izneZ8qfyPGBNONMUW6WZPZBC4pDupJ401tk6eDg3uLd?=
 =?us-ascii?Q?SG0S3+Bn8y90Sh6Q5vRTLtDF97+57NrECpOVUEOyUitP8xez8IXvrPae72UK?=
 =?us-ascii?Q?HhfHOYL404p1w5UuGjl7RPbpsst2Nuf5ffeOoDtRn9TAkWTSPAegtJGpLSqc?=
 =?us-ascii?Q?eptXl1+dFvu7O58w9VRyzqRtOxReMG7zqZWt/EBnu8VEGaM6WP339HJ9kT63?=
 =?us-ascii?Q?STZFYwIS/93zoJETndQOf3Rv/6QeZGzYHvrUXPQO4XVc2lY6pdjVoLV3UYG9?=
 =?us-ascii?Q?YP7m4OW1NfmUDVhU6Q2P9UlWttOpp+6vxCTs4+akzRsUKTvlQQbOuOwFRoth?=
 =?us-ascii?Q?89xsqabZLMTpcyBKJIi2ylnaENuqCrNcfoPWsHEaBuwsUpJSfUSmFs6Bo1TS?=
 =?us-ascii?Q?ZAEZHD2vxMS6/7mM1uWImMhhKG1KiygnrAOadctEmkHNBPdbxO4igz1zw8oM?=
 =?us-ascii?Q?TUKwMqcAI6Zi+SduMdZylNj0Fm0IbDWW/mjxQPbWUWEpCOnrS+dVT8p8xAD9?=
 =?us-ascii?Q?lJzslGPh9OR76MMqOdcueDdG/4lb5UEpsADQgkYBTE2BVmoviOv6zy0cjxEG?=
 =?us-ascii?Q?SlU5fcN5C5YaHks30n+WNwCYe6D3w5xxcmdVY35Nn5WTZcu/52I52uuxiK2T?=
 =?us-ascii?Q?p73q+ZPidzngwITkgPy1zQQF+UnEPUYz2gcADase0x9hsafXuIvHln/1K2TU?=
 =?us-ascii?Q?umDertCszPUlJZ9hwV+Q/n5wN+wkUsIWg0spD+2fu1sU/4dpF02aVgpJbbvW?=
 =?us-ascii?Q?0rpYQc3QXDOolqXNsygEES2S8hDy7t/dqYfCUXuR/6CemnswJf3xN/D2bRhw?=
 =?us-ascii?Q?xQKUOYmqMhZJ3c2WVV036TSQhzjNqP59jCVCK7rGx23Y1X5B3IE4UnjlCiKE?=
 =?us-ascii?Q?YKxyQsA6sAO7+7udOOfgZUXZyUQ4MnkFbtZ5RMZZWHdBkkVZRGmf02nSyQX/?=
 =?us-ascii?Q?dTP+uSxSiCsPYM8YYLKKBCXbcJrKKX2UcaQxm93n2AwyGpB334v8YHB3zJhi?=
 =?us-ascii?Q?bxDDT/sPkTYa7VCETxorjXXeGJtkcQSBladOADLKGiB9kSKqLASArpsBVkDQ?=
 =?us-ascii?Q?a5aeGNmXsCtbrYSyO1L3wTZP39B7HS/bXJ6YPd+X8BEFmztUK07310jctwYA?=
 =?us-ascii?Q?HihGOXK+/Y5Fs4QfeBEiu1LxtD8rb7lsMh9lHVt0b9obEPwaeV7NSrkw7qB+?=
 =?us-ascii?Q?WnLIFBi5GCO7bvSzAyxxeD7XLvb6TrEzZSce8fgtRNasDWZAqGnzX3jL3s52?=
 =?us-ascii?Q?kUHf3IhNTlUMKzD4vabTBTCBVi2ov45F9rTTG8/GyPi4c6e7SV9Lvo7HLJ31?=
 =?us-ascii?Q?hzoZLkjkFfLX1z32rLmWkrjRO0JJJ/l+oEgTiMPwpLuMfoadP0pscqeK/DPf?=
 =?us-ascii?Q?xcEtDzK/7AUmCYV7EcVeVI4eEFYMFIRL0UoDzgOnj4n8S4WEvh+H7btREuMl?=
 =?us-ascii?Q?r46pfoFbLLEbVQKs5ciRhDLboH9hvBIlzlRYrqp0B09of6kRZNzZObSgJ81M?=
 =?us-ascii?Q?9WITgWJvqdVhWYSi6e7a4MnGCHzWcu0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35f6b31-3761-48cf-dbfc-08df02b67ba2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:38:09.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2SDW7LTWXsn11zPNSvqs5eMdxOm+81q5xDI6xCSFmPqo6R7FDlzGmGCfSkF58qthaV01HSNJOUIoOMvagjGuBDhn3Ju202izfJ8X4UjPuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7126
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 14:38:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23999

This is in preparation for deleting all data during factory reset.

Also rename CRYPT_SETUP_TIMEOUT to INITRAMFS_SETUP_TIMEOUT

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/cip-initramfs-functions             | 43 ++++++++++++++++++-
 ..._0.1.bb =3D> initramfs-cip-functions_0.2.bb} |  0
 .../files/encrypt_partition.env.tmpl          |  2 +-
 .../files/local-top-complete                  | 23 +---------
 ...k_0.11.bb =3D> initramfs-crypt-hook_0.12.bb} |  9 ++--
 5 files changed, 50 insertions(+), 27 deletions(-)
 rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_=
0.1.bb =3D> initramfs-cip-functions_0.2.bb} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.b=
b =3D> initramfs-crypt-hook_0.12.bb} (95%)

diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-=
functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-f=
unctions
index a4c1fed6..bffd3f21 100644
--- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functio=
ns
+++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functio=
ns
@@ -2,7 +2,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -68,3 +68,44 @@ scan_for_partitions() {
     fi
     return 1
 }
+
+service_watchdog() {
+    watchdog_dev=3D"$1"
+    setup_timeout=3D"$2"
+    if [ ! -e "$watchdog_dev" ]; then
+        panic "Could not find '$watchdog_dev' - Please check your kernel c=
onfiguration."
+    fi
+    for _ in $(seq $((setup_timeout / 10)) ); do
+        printf '\0'
+        sleep 10
+    done > "$watchdog_dev"
+}
+
+start_watchdog() {
+    if [ -z "$1" ]; then
+        echo "Watchdog is disabled."
+        return 0
+    fi
+    watchdog_pid=3D""
+    if [ -f /run/watchdog.pid ]; then
+        watchdog_pid=3D$(cat /run/watchdog.pid)
+    fi
+    if [ -z "$watchdog_pid" ]; then
+        service_watchdog "$1" "$2" &
+        watchdog_pid=3D$!
+        echo "$watchdog_pid" > /run/watchdog.pid
+    fi
+}
+
+stop_watchdog() {
+    if [ -f /run/watchdog.pid ]; then
+        watchdog_pid=3D$(cat /run/watchdog.pid)
+    fi
+    if [ -n "$watchdog_pid" ]; then
+        while kill -9 "$watchdog_pid" 2>/dev/null; do
+            sleep 1
+        done
+        rm -f /run/watchdog.pid
+        unset watchdog_pid
+    fi
+}
diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functi=
ons_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functi=
ons_0.2.bb
similarity index 100%
rename from recipes-initramfs/initramfs-cip-functions/initramfs-cip-functio=
ns_0.1.bb
rename to recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions=
_0.2.bb
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.=
env.tmpl
index 787172f6..c9ae70a6 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tm=
pl
@@ -3,7 +3,7 @@
 #
 PARTITIONS=3D"${CRYPT_PARTITIONS}"
 CREATE_FILE_SYSTEM_CMD=3D"${CRYPT_CREATE_FILE_SYSTEM_CMD}"
-SETUP_TIMEOUT=3D"${CRYPT_SETUP_TIMEOUT}"
+SETUP_TIMEOUT=3D"${INITRAMFS_SETUP_TIMEOUT}"
 WATCHDOG_DEV=3D"${INITRAMFS_WATCHDOG_DEVICE}"
 HASH_TYPE=3D"${CRYPT_HASH_TYPE}"
 KEY_ALGORITHM=3D"${CRYPT_KEY_ALGORITHM}"
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 7bc08e55..308527a6 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -63,20 +63,6 @@ if [ -z "${create_file_system_cmd}" ]; then
 	create_file_system_cmd=3D"mke2fs -t ext4"
 fi
=20
-service_watchdog() {
-	if [ -n "$WATCHDOG_DEV" ]; then
-		if [ ! -e "$WATCHDOG_DEV" ]; then
-			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel config=
uration."
-		fi
-		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
-			printf '\0'
-			sleep 10
-		done > "$WATCHDOG_DEV"
-	else
-		echo "Watchdog is disabled."
-	fi
-}
-
 check_partitions()
 {
 	found=3D0
@@ -303,10 +289,7 @@ for partition_set in $partition_sets; do
 	fi
=20
 	# service watchdog in the background during lengthy re-encryption
-	if [ -z "$watchdog_pid" ]; then
-		service_watchdog &
-		watchdog_pid=3D$!
-	fi
+	start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
=20
 	# Create random password, store it in the tpm2, sealed via PCR:7,
 	# to allow continuing reencryption in case of power-failure.
@@ -370,6 +353,4 @@ if [ -x /usr/bin/tpm2_shutdown ]; then
 	tpm2_shutdown -c
 fi
=20
-if [ -n "$watchdog_pid" ]; then
-	kill "$watchdog_pid"  > /dev/null 2>&1
-fi
+stop_watchdog
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.=
11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
similarity index 95%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1=
1.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.=
bb
index 49ccc076..27b186aa 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
@@ -24,7 +24,8 @@ DEBIAN_DEPENDS .=3D ", \
     tpm2-tools, \
     coreutils, \
     uuid-runtime, \
-    initramfs-cip-functions"
+    initramfs-cip-functions, \
+    psmisc"
=20
 CRYPT_BACKEND:buster =3D "clevis"
 CRYPT_BACKEND:bullseye =3D "clevis"
@@ -56,7 +57,7 @@ HOOK_COPY_EXECS =3D " \
     tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_shutdown \
     tpm2_startauthsession tpm2_policypcr tpm2_createprimary tpm2_create \
     tpm2_load tpm2_evictcontrol tpm2_unseal tpm2_getcap \
-    /usr/lib/*/libgcc_s.so.1"
+    /usr/lib/*/libgcc_s.so.1 fuser"
=20
 HOOK_COPY_EXECS:append:clevis =3D " \
     clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
@@ -89,7 +90,7 @@ CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
 # Timeout for creating / re-encrypting partitions on first boot
-CRYPT_SETUP_TIMEOUT ??=3D "600"
+INITRAMFS_SETUP_TIMEOUT ?=3D "${@ d.getVar('CRYPT_SETUP_TIMEOUT') or 600}"
 # Watchdog to service during the initial setup of the crypto partitions
 INITRAMFS_WATCHDOG_DEVICE ??=3D "${@'/dev/watchdog' if int(d.getVar('WDOG_=
TIMEOUT') or 0) > 0 else ''}"
 # clevis needs tpm hash algorithm type
@@ -102,7 +103,7 @@ CRYPT_BTRFS_SUPPORT ??=3D "0"
 INITRAMFS_CRYPT_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
=20
 TEMPLATE_VARS +=3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
-    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
+    INITRAMFS_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
     CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL INITRAMFS_CRYPT_MOUNT_OP=
TIONS"
 TEMPLATE_FILES +=3D "encrypt_partition.env.tmpl"
=20
--=20
2.55.0


