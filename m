Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E3C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 09:32:23 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.83])
 by mx.groups.io with SMTP id smtpd.web10.15375.1678699938979065493
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 02:32:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gJ6qLbTT;
 spf=pass (domain: siemens.com, ip: 40.107.8.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G32ZwQZWhywbEYy1eOhYaPub1SfI+jTD/GnIgdJ8cI3CgKkbTFNGF0+oYaeWveWf12LGKZGM71VLJI3ugh/v4okipBN1LUxU3k7EMLzr/AIA5StfBQa1N5KQfZlePaVuzKyO+3cyu5EacQE/Pohva8WljLD8MtDO1Jsp875Ldubh6PBHvebhHJrh98oawt8nalOcIGIKG/pSDe7VpUX8nbSwEHqAVenpWHt9qww/TCm1VNCLt7UtezUnbHXM3xP04XMCRz3cXBUsbBrC6R0BFREo3ofmBnTY5VRDuRIDfgKZStiDS+cKU+naCGdzOJ7VkDVCdfdqAv2kkNfyVoeOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te9F4SrkIaRsKpM9DjqlKct3e9tEey5uQ3kbJk+5Kh0=;
 b=Q/5kFL56j/4GBzRfQYVIg1WKD9QC/gGjEX5RJczrXtDEB+i9nFTmlCLjwEV9alWpVXiw9dVeatbL/cSg8QUraroZuGWR3rjab+tsjKIP8jppP3BghYI2QhN0DcuQRU6U131tzmqxpsRYdPdW1z4UmzbVnMLmKuIrDhukejEktMylTpNreP8g+PtwbMLwZoK6WAvNWaGauM3mNqklNjFGRJLXxuc9fVD+/I9N7wOwmdv6cTi4lTXVVtfUjSNe2HB5AKBzNdPPyx4kMDicbT/0VbiwXn1asMJJ03VJx6VLz9sK+BLzaf96kxylrTnxzc63kIe2Bzcgc+DOvnK8w/mXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te9F4SrkIaRsKpM9DjqlKct3e9tEey5uQ3kbJk+5Kh0=;
 b=gJ6qLbTT+B3T98X3g+N+8ibaFfQA64uLNFZ8uJlV6LWaHqk9uEYbcWGo3KZqjeJlBKOIRxe+Qcf4GlNLQzCEW3+uMMkq4FGQ3CPdunPodZgGWEtwAA6LyencJ9RR8ln+FRL70x4HZifuHok+oHVCzzGNMH+tnxakkH6UnVYTYy5qZ8eQtOZitCkul7o/jDIAIu0TMHJs9e+pZe8c1SdKAekwDSPCGhnfFRz/99JLBY1iHnuYkbSeAwQKBGvr5WN6kCyCqvdetVQlrMzYQOkT5Efef0tm4tPIZGHtJDanZvGk9UuQ5Zd+pnAnw5wx1zezu8LQyzRhaJSh6u1GTy3oxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3946.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:32:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:32:15 +0000
Message-ID: <1abbec1e-0543-6e36-c63f-7518e0410754@siemens.com>
Date: Mon, 13 Mar 2023 10:32:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [isar-cip-core][PATCH v7 3/7] start-qemu.sh: Create a tpm2 device
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
 <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3946:EE_
X-MS-Office365-Filtering-Correlation-Id: e11ce2ad-d6fb-4be9-5f3a-08db23a5d520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xSJ/VrRPOathLtd1S0b5hSA8kudr4ap9rNmdJRnx1moM5SXVcnOEpu+MCsZkg4XSVNmI83S72ShXJFuNdq1hH2swi7sSN5HCqjoVt5MDuoEPl+hE1dq0APTihysc+IkptVotezbVLoL8zDCP0+mONfmHez3n3CAZtZ1hixzfweHKjaOAgPh9/g5Dt0X+t0aWLFYDvAajTkrlMBMcN7mnhXM5YMw0OHN71QnDor0+7VLd2ozvGtQ/uAqYS0GsWztGOjziAaxP3kBqR7JimP0e8KPTc7cVCVf6LY3IbrPZGyGWjAZE6sBlH4g2Kz6JLIoze38MCCKITr9e1PkHjhaTutLxd5Vfmp1bKXFh48+CHwyLxvNYz39Sz+fcBeHr8r4O43atU/YQL89O8jsHHcV/AW8a7rQ6EKJ3GmqRaUfi1qRLHFZlxeB4cXiT6/wOuVzlFDbN88q0oSy3TcO1bjl7NZyISIDNkVUngxshbr5dIRhVNIGbISzkdbxBl0Aitouv+bidVC9zRwXD2aODrChLjyWNDgxi0LCgdTs2Rf/aH6Hk244hVMcUYk1up8vefkSqrF2QhX+eegmveMZGkD88OIpqr6s931JLZGmvQPj3UumjkSbccZw2aQQxLzPI+9TivwTWxFuyFw8ISbIsrF3IhHO2TR4m3CD90d/OJSg8BbNSM0y0y56Njkmo2Cj+jov42Ztax78IEbDEs1RaNK8MjlRrY1sJy4VNHewj9CLZfzA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(31696002)(86362001)(36756003)(82960400001)(38100700002)(8676002)(66556008)(66476007)(66946007)(8936002)(41300700001)(6636002)(478600001)(316002)(6506007)(5660300002)(44832011)(2906002)(2616005)(83380400001)(6486002)(186003)(6512007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlJBVjc5UnZOL0NmRGJxSUpDSkEwVC9OVnFZM0J0TllrdjhlbkYxeXhUNWly?=
 =?utf-8?B?TTdzeUpzTklmeUxubXNjcUFGMWlXSWV3UVBOajBYUjNmY2VlM3BzT25vdVNV?=
 =?utf-8?B?R0djU3d4Mmx6Qlg0dXJsT2xwWFV0UFlFMTIwZWlmVHJkaXlVUGZmc3VML1JN?=
 =?utf-8?B?ZE85aHRMOEx2WWR4anlyOEJrTXJHMTVyNWF1aThlU0g3ai8yR0FEaXBsN1Rh?=
 =?utf-8?B?SHUyWW1HcFBnaEt1aVJHYjMvM2J1RjQyaWFmYmFHWGQ3VkhkaVJrclk4Tmhs?=
 =?utf-8?B?UUpUWURGMTROcExZQ1J4eDRBVzZHYS9MaTNuR1dUTEw5ZU5Odm8vQTBRMkFw?=
 =?utf-8?B?N3pDY2ErakZNQkZjQXNqZzNldDh2UWFsRktwcG01ZmNob1lQdmkzTVZraFJ0?=
 =?utf-8?B?ZjkwbnR6bzJXMWlKVm9nbGxaLzg3dTdJM00zQU90VmJ4TUo2NkcwekFtdXA0?=
 =?utf-8?B?QUhLVk9Ia0NaUG1VN1YwL05pRE95RGwwY1psemROdW96RkxhM0x2WVNyMzFn?=
 =?utf-8?B?VkZvYTQ0WWRRM09nay9ZQ0VtMitKdmVLZU5pdVgwVjVuRThzdFFyaTB5ZlNI?=
 =?utf-8?B?V2UvMUMwdGM5WHNjWGozYWpYTHJkK3NsbEw0OHFqT0tpOS8wdGxOWDBWUHBr?=
 =?utf-8?B?dXdkdkVHMDVHSk1SbVhJVXY0ZWdkSU5tZVg2d0ZuZ0RrUStUTUhNYUtRazhq?=
 =?utf-8?B?bnlUb1ZXY0k1T2lGeGpURDkvUk9FdytFeVdvdGszVGpadHFvU1dOY0F2MzBm?=
 =?utf-8?B?SHJMVXhQTkNPVVNjeVVSL0JWNnRKL3RPR0MzVHBUV3lTR25VekFqbUpxS3V4?=
 =?utf-8?B?ZnNJZUhSOXlhdjZhRVVuck1pTWQ5NWdIRmtUNEkxdVlDV2lrTUxqdzcrb21r?=
 =?utf-8?B?ZmFEM2RxQkFiL1VTeVRMRGxLanUzOHJUalM4ZnBpcS9hbDhlREp2U3BydTEr?=
 =?utf-8?B?Q2h6anBTQlhZdWc2dnZjVTRDWi9VOFJBdGpRdy8yYjRGRkNjQWtLRGxrZ0Q3?=
 =?utf-8?B?eVRFOUkwM2lBL2V5OGFVNHpGb05YYno4YkY0Q1RDVEVSekZxY2pVTU5YT0oy?=
 =?utf-8?B?RVU0eWxnckRJcTR3RTFxR1hTRTg2ZVBMaFptc25zM2tsblNneHl6VVN0ODls?=
 =?utf-8?B?b3ZmRnBvRGkxSzhDQmVsN0hPTlBibTFXOHBObU1EODA4anNDOGlUZzNvVHRY?=
 =?utf-8?B?bGpOZ0hndVpUcUNDS2loMkk0Yno2MFZkbDJrN1k0dWRicXdRSitOcG1DZXl3?=
 =?utf-8?B?blF0OHRLaHFBc3IzNTJJYW5PV042MFU4elp0bWhBY0ZsZHhyK0picCtxRDgx?=
 =?utf-8?B?cmdBYmZnUDdpYU9WeVRmUVFHL3ovbmpkalFRcGhrbUhMbElCanBaV1ZpUm4r?=
 =?utf-8?B?RWREbXVlUjQyejNQTWRWbWtOWm1VajJyUHhab2VVR1dTdUM1bnNjQVF1cm5E?=
 =?utf-8?B?SFVaNzA5QmlJbFBKS1RNWlZqbCtuZWhIVjluUnhZMGJlTW9zaFJnaElVa1Y3?=
 =?utf-8?B?aUhKdElpSGxZTEZydzU5WVlZMEN4MTh6bXd4TE1HWG1UenhhOGRvVU1XbFNM?=
 =?utf-8?B?eldlS2ZZWDh2SUMyTlE4Y0ZQanIyd25Qb05JUW0vRE1UMnhSRFZsbFhXSnR5?=
 =?utf-8?B?dWJjK1BDL05iRmYwS214cGxqUUE4UGpQOS9xRGFKTFVMVFI4aUdXTnBrWGVz?=
 =?utf-8?B?S2ZaZzBqc2VHMXUyalFna1p6eDd1Zi9qdmJWK05JbzNUZWppV3hxVUI2L2Fw?=
 =?utf-8?B?RVpBK3pvZ2JRWHNKamgvZHh1RE44Wi9HZGZUMW9wdlJmdVJXYVQyb2c5VzZB?=
 =?utf-8?B?UDdPeTVyTHVqZEZUZXBoWFhJSHFUWC9ycU1wUG16aW1YdWRLaHZzUCs5RW5l?=
 =?utf-8?B?TWxqdlBNSVkvTG5haGJuMHo4YjNNZTJrREdHYUtadWVoRjN3RlZGQnVLTEg4?=
 =?utf-8?B?Z0Z3VllrMHduQk5NaHU3NFNRVE40TWwrN25USSt1MlM4c3RsNGtTRmxiNjQr?=
 =?utf-8?B?ZTdQeExCSWd2eTN0RlEvd0N6d09KbmdxdU85ajRaWEFoNGk4aU9zRFdBOEp3?=
 =?utf-8?B?eU10Sml4RUE4RXRvZUZzVUs3Si84MW4zeWY0bjczR0JpM0dJam5KK3U0dkU1?=
 =?utf-8?B?UStHYlBWR0IydExOTTJXSzBpRGNTS29sZ1YrR1hCWmZCb2hiQ2RoTlpmaEdP?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11ce2ad-d6fb-4be9-5f3a-08db23a5d520
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:32:15.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nsVirAMZKvxAvE5V3MTw2qR0h0UYkVu9FjLu/3yEvW1JikHFQJGHnr4k70pxTDgS4Ydl+N6yiPbP6hT3yn3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3946
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10997

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows testing the partition encryption with qemu.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
[Jan: persist swtpm state aside image in deploy dir]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This one became quite different, so sending it as v7.

 start-qemu.sh | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index fcfbc5b7..44fb4196 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true" .config.yaml; then
 elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
 	SWUPDATE_BOOT="true"
 fi
+if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
+	TPM2_ENCRYPTION="true"
+fi
 
 if [ -n "${QEMU_PATH}" ]; then
 	QEMU_PATH="${QEMU_PATH}/"
@@ -129,7 +132,8 @@ case "${arch}" in
 		;;
 esac
 
-IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}${TEST_IMAGE}"
+BASE_DIR=$(readlink -f $(dirname $0))
+IMAGE_PREFIX="${BASE_DIR}/build/tmp/deploy/images/qemu-${QEMU_ARCH}/${TARGET_IMAGE}-cip-core-${DISTRO_RELEASE}-qemu-${QEMU_ARCH}${TEST_IMAGE}"
 
 if [ -z "${DISPLAY}" ]; then
 	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
@@ -143,7 +147,20 @@ QEMU_COMMON_OPTIONS=" \
 	-m 1G \
 	-serial mon:stdio \
 	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
-	${QEMU_EXTRA_ARGS}"
+	"
+
+if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
+	SWTPM_DIR="${IMAGE_PREFIX}.swtpm"
+	mkdir -p "${SWTPM_DIR}"
+	if swtpm socket -d --tpmstate dir="${SWTPM_DIR}" \
+			 --ctrl type=unixio,path=/tmp/qemu-swtpm.sock \
+			 --tpm2; then
+		QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} \
+			 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock \
+			 -tpmdev emulator,id=tpm0,chardev=chrtpm \
+			 -device tpm-tis,tpmdev=tpm0"
+	fi
+fi
 
 if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 	case "${arch}" in
@@ -158,14 +175,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 					-drive if=pflash,format=raw,file=${ovmf_vars} \
 					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
-					${QEMU_COMMON_OPTIONS} "$@"
+					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 			else
 				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
 
 				${QEMU_PATH}${QEMU} \
 					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
-					${QEMU_COMMON_OPTIONS} "$@"
+					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 			fi
 			;;
 		arm64|aarch64|arm|armhf)
@@ -174,7 +191,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			${QEMU_PATH}${QEMU} \
 				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 				-bios ${u_boot_bin} \
-				${QEMU_COMMON_OPTIONS} "$@"
+				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 			;;
 		rv64|riscv64)
 			opensbi_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/fw_payload.bin}
@@ -199,5 +216,5 @@ else
 			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
 			-initrd ${INITRD_FILE} \
-			${QEMU_COMMON_OPTIONS} "$@"
+			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
 fi
-- 
2.35.3

