Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF70C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 07:47:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.59])
 by mx.groups.io with SMTP id smtpd.web10.72368.1705304830875156263
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Jan 2024 23:47:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=YVxbvWeN;
 spf=pass (domain: siemens.com, ip: 40.107.20.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvQdxeFjn9L+DR/5EHMziAv1jBP9FBf1jm7udVOqDBooCNNjmIjj3aMEiEKbZxsuxpO1sMLrQP77lPbYOH5/szWGoFsCBcF6dCBpQQNxehheJraQCuOs36pcE4nIcDN66ZjBRf8ndvNetnS2984A6SE9qomwlYIrhgZDQJzrVTT0xZlrKhE7oFMI8/b+4lvwrIFHKq2yOlb7w4m8d9IbDsD+bXk/7d0hec0tkEww99Zk2iXK784FN3jWI/N665ScsEZIk9OfLmlNCIrWvzcKu2vUW78QaQB3J46xKTlPSVZJU5egYoiGh1B9QRoBDsuCyrZa9ljBH3aTH9knSYLN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DVaDTlWrJzA0usYekWcgyZu5ZE75xVSoeqtGQUOwBQ=;
 b=ehmPeZcXc85KuI07aOdj4tgPkUwWo+mC4CifMrVV2SRk2GZoQpUstWbvPZ9sgSyLBIX7w22ZCiNWIptVxS6d6eCljjm7pPemFiec50LiA1M1n1XFelLlzNIX7xdALcGwAlMURNrq15Y3sfUtvdfI3yJTKb5OA+o/Pi2GEj9yIAdKlf2fwKTYgK6GxSnzYLJhK+mRun9UfupjRgvlaApun2X8FuKjfDTBX/11ZHGTJGRzhDzkoTZWQ35C+8w+nVW9pG3i4s7UDtKIIf/Zdtw9COhlYB+F7/KAZLTaeLs4Yfbb4jvKFh3dfgnO3S/JdrbrzoK1T6xbnBub7CGFOYbSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DVaDTlWrJzA0usYekWcgyZu5ZE75xVSoeqtGQUOwBQ=;
 b=YVxbvWeNYw8hEZoRcv23t+kHhS7gnK4wtn4WLbmINUJLpB1m86gswqLN0I5iDo/vE1CKJU6nHjsU3D6fTrErtXd/eY82biJdBn0Nj0fwFDjJiOicGIrNYGAPwlWn2nZk66UuDEfwRdUntDc15v5Ni/QYkNbTtnh0VTEhkbNdgXcKsB5HzXruuhq7TJVaIzn429qsgLT3//i87U9aE/2N9+xOxLV7DeIrby9VbTfyI7XdUpipAeug3UgaKsEAZKyI18KjjUhx3mNJ+5t2mY6CKZ7OAjBFobxB3QvVQyDKaFFjeXZwEHuL3WF/YAmDl6t7laiC19B1NWU9d/SIMHQ5TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 07:47:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 07:47:07 +0000
Message-ID: <891fa572-6c47-4ad1-8e48-1cb62b4751c7@siemens.com>
Date: Mon, 15 Jan 2024 08:47:05 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] start-qemu: Fix inclusion of QEMU_EXTRA_ARGS
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d226c6e-c4e5-4f60-3e72-08dc159e2c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	URnX4G4nlN41IXE+SFL8QagUfsP4pEfojCnHHFexmnZaN8pjwK+Rc/lXlD72Xm3wux6BNz93AU/BMpwBO7aQ+e9GvIpn/RHFcDHegL0EHBZQ5t1cX8h9g12enDWlG5Grs6GGAkzR9lnygrNyC7vYfEqQdMj8wSex39/rjDxaPC7Du792NMZVK35dZvwu/JSSFWEuOgMYIsoQijqgqI7prcpWB7VEcn41hIoK267wOl5ulC4jyJKQX5Zr+XsVXawpvdvnaY78A5CL+weoxDA+Epo5zwHP2+ktRYGzm+8kDjRnM+Ld2OhD/iSGCPJWLxz1UyYlZ9vcMuzZcjORhJbxLe3mUS5XSVu5i+0t3BJyn2UsYRijPQ1kJp6d1jg7ZNBPNBdMLgte5lxsE3aX3TzDC59bG0ZZh4zjfCFBplS9dP5SrwmWBGUvI5IjgYNRYyHsea2lWmjhaMi7fVaxcw7S5YK1rdQaHaTzSsNZZqC1d/FlU4+acowBTnEZ7UvgJAWyDF+QoMENL9Ofj4uleTnWrbgFycGuo/Y682+xQmvWch9P7INjBbxS0Ribm1sphh9mdMSnNuEfQrtPId9XnKX2lRRkq+KOToWCjWYFQQAc3iZ3zQVMcRYkoIZ/o4ws7nlYBRxQ4Rj2qmN0b6NzqgsZDA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(41300700001)(36756003)(82960400001)(86362001)(31696002)(38100700002)(26005)(2616005)(6512007)(478600001)(66556008)(6486002)(8936002)(6916009)(2906002)(316002)(6506007)(66946007)(66476007)(44832011)(8676002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VThQQTcraWFRdFZKWWtySHNsWVVYaVkrR0Rvdk53UiswdnVxR3lMaERybnpM?=
 =?utf-8?B?UWVUN0ZuaUZBYzBHcUtSK2pkUVNoRjc5WFl1dWJJaTJCQUw3YWZIdkFpeUQ3?=
 =?utf-8?B?Rk5QdWtTV3NtRU9wTHYyYWtvbzhJM0o0bG9PU0IyUUZ6NFEvOUdIR25mN0Nu?=
 =?utf-8?B?UzM0RTVsei8ydW9lcUVTaFpMS2hZanRaLzFYZy9wbGVEa0tLNU5oSWtqNm5h?=
 =?utf-8?B?UGhQd0JGWWt6Sm1QMHVKUGtvalBDMkpwSTkzSkJnWHVHdnhyT1V3cGVZOXV0?=
 =?utf-8?B?c3ZRSkxBQTRIeUMwWFlxYktObUd4WUpnUVNkNnpLdVlkaDBjUjlKNG1wa01i?=
 =?utf-8?B?ektGVEFJV01MeTZVS2ZQVUVOeG9EaFowT2FBVVZCZE1kWEVYRGtkODl6RlJB?=
 =?utf-8?B?VER3OEw3dTRsOFI4aFg0UFJZa08wd3BYcUtXMGVqRzduMnlHZFF1cGN4aEts?=
 =?utf-8?B?K1ZBMkhvck9XQ1I0R0xyWk0vY1JaV1hLeUZVWGZsTE56M3hwSllrdEF1SU0w?=
 =?utf-8?B?QWdaWUc0TnAvdk1zUEZ4THlEalJzbEhiRzBSM2FYRlFQQ0FvVWlkZHE5ckFH?=
 =?utf-8?B?bW1UblhnTkhIN245VFZZN1RCenlzNmxTdTFPTkFVK1RoVW9lSU9ieUEvNmdK?=
 =?utf-8?B?SkVqWTd3RTJhaDFnRU52LzZiNnZPWVhaV1hRaVdsQnEyKzVubGgvWEp2clkx?=
 =?utf-8?B?YmZHOE5kM3k5SXZ3endKSUVvNHhhQUZ1dThSNjgxU1VRam93Z1c2NEZObkVx?=
 =?utf-8?B?Z09OQXljaEdmK3RnaldUQ3MyMVVWRjBtR0VCQXJDNEdXSFR0Wk4xMGFVTnhP?=
 =?utf-8?B?Z3lpdUowNXBTSm9Tc2EzYUtSSW1rMk9walAreFNmOVlQVy8wbDE0eWExeHpB?=
 =?utf-8?B?ekpaQXV4VlQrbVA2MnhTMTNzUHRrL21HU3dnekpmN3NnWGpXUERPd0RZblpJ?=
 =?utf-8?B?cCtMd0RHMFh4cDhrTElzbTBZejdUUStDVTBHUTVzSC9ScDRLSnRLYjRXZ3hr?=
 =?utf-8?B?Qk5NQ29FTG5LaFl3NVRNQ2JOOFZRdlBEaFhXTy9GSzlSeU5wckVCVFhFR0tx?=
 =?utf-8?B?YitxNldGTjRpclNqZWpTRWc2M21Uc2ZNbnVBSUwzVUZpZHVGZEZLWnpGWCsw?=
 =?utf-8?B?QTdqYnNkYmVvc3pXSXVlRTdtdUJ5dVBFNTFKR3hrSVNMRFgvS083U2RmNkdR?=
 =?utf-8?B?QkpHMnRiZE5uRnlaVDVkWjgwRWtma3BNTWViZWVDVzFLQkNRSmRwYmFmY2I2?=
 =?utf-8?B?cG1iVUt0a0FnMGJFaVlWUXk3K0xVRElUMHlTZndOa2pzdU10YVhmOXVSdmlO?=
 =?utf-8?B?T2tLU2w4ditjdS9sVkIxYjJ5TjArODJuTmtaMVZ1TENZclMrdkxMbTJ6cFpB?=
 =?utf-8?B?SVVycG1tdEVxSnVGM3crK2s5WjVqU1lUbWtFZndzdHY3WnF2SHN4V3lrN29h?=
 =?utf-8?B?bVNPblpyckhjR0lzeHJFWnI4M21RNHFKMC9NUE1PelRqVWQyQzRQRU0xUTR2?=
 =?utf-8?B?ZEtQc3RkV0lIZWJJT1BLdFNTdUdCemZLVldBQXBjU2hDUE9aN0hYZGhzMXk1?=
 =?utf-8?B?dERXeE5YMHNkMURFVFo4eFNXSkdSM3p4azRxZ0JQWW9uZGhYejl3N2g0TmdZ?=
 =?utf-8?B?U1ViOEdJSU1tb0FHaXoyQk01VWJmMVNLQkFZQ2NkOTlPb213MGFVQm1YdFJp?=
 =?utf-8?B?a3dhU1RlelVsVUFwN3ZJMmYwVEtPWThycXYvV3NlOXgxbTVmL3ptckVaZUIr?=
 =?utf-8?B?U3ltY25tRk5RTFF1cHdkTm5Pc2NGNHN2N2NuZVMzamwyV0hWWFZTd01Va2pu?=
 =?utf-8?B?RW1SVldwYXRTYzJaUDRodGlURDhLV3QwaTYwT2ExSWgzQkx1VXg0bmQ0RE1s?=
 =?utf-8?B?OUxmNDRWZFJFN3FUZmZiK05NZGJRemhyY1ZYRXp3bjZXWVRTZWNYWVRQL0du?=
 =?utf-8?B?dG9LM1pua1hNY3lUeW16REVodG5BaE1sb1NqMmpaVkk2SXlDcGk5bjAyYWhZ?=
 =?utf-8?B?ODhCODdjNkJuMU0wbkdJMm55UFJHa0NqQ2lGT2ZqK0w0d1doZnloUDFBLzRD?=
 =?utf-8?B?c0xJczlOdzJkMXIvNlNSd1lPbll6bWhpVVR1OUpYQ2dlckFzVTVYS3ZFa3d6?=
 =?utf-8?B?U1hEUUFGazJjRnhHNDQyam9hVG95S2ZUcWhpUGhXN0d6K0pwRWpaem9MMXgy?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d226c6e-c4e5-4f60-3e72-08dc159e2c53
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 07:47:07.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi7oJ/Dt2ieD5BNhtiZ3iM/8tZjndU5vngQD6p4u/2THfk5HeAmgCNeu61G0G15VJMtCeZpziBAw6gjgwQOZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 07:47:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14376

From: Jan Kiszka <jan.kiszka@siemens.com>

This was forgotten for the riscv swupdate case, but it is actually
better done via QEMU_COMMON_OPTIONS in the first place.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 080f939c..98af9717 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -165,6 +165,7 @@ QEMU_COMMON_OPTIONS=" \
 	-m 1G \
 	-serial mon:stdio \
 	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
+	${QEMU_EXTRA_ARGS} \
 	"
 
 if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
@@ -199,14 +200,14 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 					-drive if=pflash,format=raw,file=${ovmf_vars} \
 					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
-					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+					${QEMU_COMMON_OPTIONS} "$@"
 			else
 				ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.fd}
 
 				${QEMU_PATH}${QEMU} \
 					-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 					-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
-					${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+					${QEMU_COMMON_OPTIONS} "$@"
 			fi
 			;;
 		arm64|aarch64|arm|armhf)
@@ -215,7 +216,7 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			${QEMU_PATH}${QEMU} \
 				-drive file=${IMAGE_PREFIX}.wic,discard=unmap,if=none,id=disk,format=raw \
 				-bios ${u_boot_bin} \
-				${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+				${QEMU_COMMON_OPTIONS} "$@"
 			;;
 		rv64|riscv64)
 			opensbi_bin=${FIRMWARE_BIN:-./build/tmp/deploy/images/qemu-${QEMU_ARCH}/fw_payload.bin}
@@ -240,5 +241,5 @@ else
 			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
 			-initrd ${INITRD_FILE} \
-			${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+			${QEMU_COMMON_OPTIONS} "$@"
 fi
-- 
2.35.3

