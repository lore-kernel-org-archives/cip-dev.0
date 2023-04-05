Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD4DC76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 09:42:07 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web10.125912.1680687718767210652
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 02:41:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iU0QWDnJ;
 spf=pass (domain: siemens.com, ip: 40.107.20.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IckZ5rCRwbsoWsi//yEysWBlMF8yqqTU1bzpfEzxZMfHXHMHADPDThECyaM/IUNVzi/12GUrw9ghcvuusk7/NPzwf146uMRForWXnDjLiaYLI21D9vJe39Gw9mVj4DNxmPWYyu5nnfulQQ0qel/Ie7NK+IkZN7GTCTCuI4ybcu35ox+nC6gP7BZC9FKHl8X4s80hecoJabKvUV1lPmOZOJNh2vzvZzmB0fgEfFgKokyCr89izYxo93sV30YvUAxV5intwqACPcuHsBPPs7te9dDMAS+aaWot1kmZWmvt0VpKsVKiwpaOjzoe2NYg2+GYwmWmyHyrUEckzmCqLs9Jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOg3zRqhgjmQqW1np9TjCpDrCxNzNDFiRSQqZZ1nkJU=;
 b=FjrcTUJAKvzTK5wcqcSSOyLinNbyTvn0TXo1oZtbQbUEoCdb619f9A8yDSYxBkl6+U+1Ql8r68ov70HiAehgZj6u5uUKWayC41X5Hs8DRZ5oZQGFkkruN8g9JUPC17k5sqvb2T7VxPXgbQ1FpN8rCZxAzrzThgyj0/Ns5F9o60rfKNvdd/xdNJfh47vqpsJx23Qf+SEV2AhrWKKXCDmKminVdZ+FlwDy2C5pZWC6pEF5B7fesmE3JNvncW9TfANTLJaBgPamIr/VcKCAt4JOyUPA0Pz9/dQxdEwTSktlhiDf1lJYOmw6Ab2unF0ac6bpgGfEUMI9cegpP+fdYz1PxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOg3zRqhgjmQqW1np9TjCpDrCxNzNDFiRSQqZZ1nkJU=;
 b=iU0QWDnJhp+7b1mwBCKW4pYnnxZQeCWp8x1hRxYyUMnhw6PYITdYPcJBcp+oaqnMM0HRt3cmnRdFzHTdnEkHTAhLcOTFuWN+tLA9eGngoWh6FZP2GupCiDKrt+6/9BF2TSUCkh00+jrFeBmmScsdaf5j7UO01z3FI0iWIZl4wDqaRsSA7KWbrEQnNffuoAE93O7d4FfL9U3g2RJTfpB+5u2IJ4S0/eFssVEfR/rmxjYolUZStfL8v54+4wjn/j7v8IH/oKDWnt/hsWDRl9pHQjEoULZpu7HsS2jpQZ2C9kmQ1WkGQy3prYqZvHuxkPjCe1dYCfP3NBHv+oMDB3LEVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Wed, 5 Apr
 2023 09:41:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Wed, 5 Apr 2023
 09:41:55 +0000
Message-ID: <1f6ac84a-96ad-711a-11db-f541130c0608@siemens.com>
Date: Wed, 5 Apr 2023 11:41:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] scripts: Address shellcheck findings
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Srinuvasan A <srinuvasan.a@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 3209ddc0-c2de-425a-5770-08db35b9fe69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6OM/vLYxH6Mecb0eD3SLohm4UVJ9zwQqrZ8hew7oh1wJL+7Tv1vK5xO1phI465aXBW+UxkI3N1bnjaCtHMpI3BfVNBBNI/qq7bSn+tb/0wHkKLM6DaD3XmxY/qaX+Ar4dEGcoegtP+jDas9g+V5E5jPbiHkS1JDYEIF9gnrBFwwXLWh24qW8/LqGIsJTRvFo+PHE/eMQn0maLp5FX4KlRCnMXWAizfMtfUJNpTuiTs3Xg9lsk0U58hlePrRbxQlK8l3gMSXsMAmum0t2nH6Lbxkc+BOPV9ItMi8qckiq+IiGPspfpqYw5S1GFJm2QMcw45DmejdrOwon3+j1ucwTkPr+3vH9voNZm5Loh2ijmSZA8ysdI5U2b/KRihVUA9eeRyLFu618zsX1g2d3eR5jNqCXaMfvc4TOXlQ+S37JWRbMRUjLpye33oF9JLb5YYxozcb5qWVoYUeQUdTkQRlp4ey0d4crqlGofGbMyv4mbPUJE7m4ZyFSHLedVduekAHIZloKyMq1gS0GoRByuBqWyF4bLzTgRHExpGXlDFvCaLL78NiRONdpd1vyCA4IlTjHc5bAaQ4UA8cu3i+khbNmoWqLbF0rTnx8l6/r1+xk6irARqRfO7nN0w8TLL/4lO25fWkQ48C1lO49muhFqz9pkw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(2616005)(83380400001)(6486002)(478600001)(316002)(54906003)(26005)(6506007)(186003)(6512007)(107886003)(2906002)(44832011)(36756003)(4326008)(5660300002)(38100700002)(6916009)(66556008)(41300700001)(66476007)(8676002)(82960400001)(86362001)(31696002)(8936002)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHNHTzZEYVA0b3BUUXIyeTZ5aDFhVi9WazF0TGU0TVhSazh4SG96bzJUK2tZ?=
 =?utf-8?B?Qnkrc3FIbHgvZGp0YktkMUpOOTNEVEtRdXZJT2J0NzBsa25nV2I1TDJGWmZt?=
 =?utf-8?B?dlJsODBzSGpwaCthSkV4Q2pLS21seXdMVk5BOFptTThnaFBvTnpsNmlzYndx?=
 =?utf-8?B?UkRPOGU3U09VVnVFWGxOeUtmUy9tRHRjVCtVTWdCN2hKRUt2cVFtSi9MQkdz?=
 =?utf-8?B?VTRGZm12L3VDRTc0Nllrc1Q0ZlJoaFUzd2RoSmVJSUliQXhpZEFwLzRSOFVH?=
 =?utf-8?B?VTRtT0hkYk1Lb25WZzlZZ2RCbEc4bnY4SGNzMktTUG1sWk04Y1N4T24yL0dl?=
 =?utf-8?B?RXJKTUxTT1d0WG82c1J5R3p1NmFKOWVKM3pMc2NkZkNXdTJZQ3hpL1NkUVJk?=
 =?utf-8?B?bHNudjJoaExwTVpSa1NJZ2lPT0J0NS93Wk0wZlp2VmhZRnZybHZ0YW5RejRm?=
 =?utf-8?B?R2V1Y0F4d2lUdkVVVDFxcnBSdmdoM2lRY3BrdWVoN3ZXMHpQZ0taNUhtREgw?=
 =?utf-8?B?enJpSHJwa2xhTXVQUGZLZ0lnbzhMR2lsZXB4SmVpb2tJZUt5NUcwemFnS2VO?=
 =?utf-8?B?VElWc0o0aGRzODJKM2F1UUtvMHdWT2tVaUtydHVSUmZpZWp2U2tDS2ZvOURE?=
 =?utf-8?B?UUs0RHMybDZ6VVkxSzdaNlRkWUZnQXhDeWFXZ29MZzhsUERwVFFCYVp5UVU3?=
 =?utf-8?B?aHJ6dkxTOS9hNGdaMW0wZjI4VTN1b2RmTTMybThhUlpHVWVLOEFxeUN0TTBk?=
 =?utf-8?B?U1UxZXdrWUxSQnNEQTJFd21ORXZuQTdoek5MR1F1eHdsQXVIMWp3OWpxN2tS?=
 =?utf-8?B?ZnVSWXdhMUlkSlhvZmFKWUpqYkdSVkd5TU9jY21oaEhjY1NzRU1TdCswRjRm?=
 =?utf-8?B?UUdyOS8rdXl2VXRuY2RZdE5Dai9pYmtMNXNSMUprREFLQjFncTVJTS9QUlEy?=
 =?utf-8?B?UnZMZE80dENnaHdZcmZ2Q0NzNW9RaVVsSk9YT1FuMnJVUDA2R0dFangvNm04?=
 =?utf-8?B?czZuYWRMeDEyWDFlNitrRXo0T2Vyb3lJanQwWHoyTU1Xc2wwbWNJaVpsWnJi?=
 =?utf-8?B?aFZsaHVIMmFqZjRybzJaSGxPNUkwRFoyTk0xbWJKWjFYeE9qQUtmbkMrSVMx?=
 =?utf-8?B?bDNGRDJ3TzNXR3pYSHJBSk5wMWIyWGt4MGNWWVEyMllNWVVIMDFlK1FxVksv?=
 =?utf-8?B?S1poUHQ0SVB0QWM4aURucnlKbXpyYWlPT1Q3eWZTZVJkOXpHRlYvTHhydTYz?=
 =?utf-8?B?R3kreWpnclRuYjRTWjZPYXFhNnNORk5xcFRpaUhGMjgyWVg2eUIxaGFPU0R2?=
 =?utf-8?B?UW1MRi83c3JieEF5cEo5SmY3VkZnWlJnUlRtWCsvYXlOTkpBdGlHdWtBWFow?=
 =?utf-8?B?Y2Y2L2UxNTkwMHRORk00eUpGUEI4SUMwL3pJTDMzN3ZCOFhucXptVVZZdzBs?=
 =?utf-8?B?NFJJZWlrcjBYWEZwdmRta1lJdlJPV2VLZWtvU08yYm1qa2N3d2UrdzJWM1Zs?=
 =?utf-8?B?V1pPU21yUElzeEVSYXM4UG9iN2pkb1oydXRpVy9VcVpwcHg4cGhIYWlNeGNV?=
 =?utf-8?B?c3lRTVFYT1ZYanN4RThTQWFDcm9pSXhQbHhRMTMvZUpHOVNjbmZmMHZ6QURB?=
 =?utf-8?B?MThNL3VSbWw3NWw3M24vWG1kWWVCTjFobS9Vd3hvRFlrOXVMbEJIWmR5ekNQ?=
 =?utf-8?B?YnIwSy8wQ0FLQjZOYStYMVM3VWxld3J2WXdFSGJtMzNSb2xBamd5anphd1Rh?=
 =?utf-8?B?N0VIdGFQT0RGL3ZwLzNGakJNc3MvcnUxRWtlVWhSSlk3NHdKdTR6ak9PRThX?=
 =?utf-8?B?WDdIcVBVQjYxN1BpWlI2TkppRTJ0cjF6YjN2MVhmcGxIbkZIU0tMaGhPNS8r?=
 =?utf-8?B?M2VZa25TWEtNV3F4cEUxc0J2YklqVTFxWUMvdjFmaHlySVJsa3libUVxbGtx?=
 =?utf-8?B?YzhTbWJNMFZtVGRSaUs5NktBVmNjVFZFTGVOSHBjM0dxTU9pNHN0eWd6eHVn?=
 =?utf-8?B?Rm1XNUlhTlRDZzBEbjc4WTVtZlNIM3ZDbFJtUlRHWU5VTy9lZm50ZHAvYmpw?=
 =?utf-8?B?dS92bk5KUGU2cnFxS1Fwanp3Z3NXbVd4Ny8wMzhyQlNKdHcxRXdrRWNlYlNn?=
 =?utf-8?B?aTlXdFpJQlVRWmI0c3RyRC9lc2lzRjFNVEhhT3gxMnozQi9WUjZRTUFiOEVY?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3209ddc0-c2de-425a-5770-08db35b9fe69
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:41:55.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4nHarXCicwK4Mwk3NLZZKzHieUSogCJ+dPi0Nkxw0CHDAHT2nQm5CIjNkF7HmSLN07oCNEMhOpekO9vqtLUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8259
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 09:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11179

From: Jan Kiszka <jan.kiszka@siemens.com>

Mostly quoting warnings, but also a non-functional stderr>stdout
redirection.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/deploy-cip-core.sh                    | 20 ++---
 ...enerate-sb-db-from-existing-certificate.sh | 16 ++--
 scripts/generate_secure_boot_keys.sh          | 82 +++++++++----------
 scripts/start-efishell.sh                     |  6 +-
 4 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index b185a847..186e88a4 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -4,7 +4,7 @@ set -e
  PATH=$PATH:~/.local/bin
 -if ! which aws 2>&1 >/dev/null; then
+if ! which aws >/dev/null 2>&1; then
 	echo "Installing awscli..."
 	pip3 install wheel
 	pip3 install awscli
@@ -28,27 +28,27 @@ fi
 BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
 S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
 -if [ -f $BASE_PATH.wic ]; then
+if [ -f "${BASE_PATH}.wic" ]; then
 	echo "Compressing $BASE_FILENAME.wic..."
-	xz -9 -k -T0 $BASE_PATH.wic
+	xz -9 -k -T0 "${BASE_PATH}.wic"
  	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read $BASE_PATH.wic.xz ${S3_TARGET}
+	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.wic.xz" "${S3_TARGET}"
 fi
 -if [ -f $BASE_PATH.tar.gz ]; then
+if [ -f "${BASE_PATH}.tar.gz" ]; then
 	echo "Uploading artifacts..."
-	aws s3 cp --no-progress --acl public-read $BASE_PATH.tar.gz ${S3_TARGET}
+	aws s3 cp --no-progress --acl public-read "${BASE_PATH}.tar.gz" "${S3_TARGET}"
 fi
  KERNEL_IMAGE="$BASE_PATH-vmlinu[xz]"
 # iwg20m workaround
-if [ -f build/tmp/deploy/images/$TARGET/zImage ]; then
+if [ -f "build/tmp/deploy/images/$TARGET/zImage" ]; then
 	KERNEL_IMAGE=build/tmp/deploy/images/$TARGET/zImage
 fi
-aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE ${S3_TARGET}
-aws s3 cp --no-progress --acl public-read $BASE_PATH-initrd.img ${S3_TARGET}
+aws s3 cp --no-progress --acl public-read "$KERNEL_IMAGE" "${S3_TARGET}"
+aws s3 cp --no-progress --acl public-read "${BASE_PATH}-initrd.img" "${S3_TARGET}"
  if [ "$DTB" != "none" ]; then
-	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/$DTB ${S3_TARGET}
+	aws s3 cp --no-progress --acl public-read build/tmp/deploy/images/*/"$DTB" "${S3_TARGET}"
 fi
diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
index ddaf4c95..dddd9b5f 100755
--- a/scripts/generate-sb-db-from-existing-certificate.sh
+++ b/scripts/generate-sb-db-from-existing-certificate.sh
@@ -4,16 +4,16 @@ set -e
  name=${SB_NAME:-snakeoil}
 keydir=${SB_KEYDIR:-./keys}
-if [ ! -d  ${keydir} ]; then
-    mkdir -p ${keydir}
+if [ ! -d  "${keydir}" ]; then
+    mkdir -p "${keydir}"
 fi
 inkey=${INKEY:-/usr/share/ovmf/PkKek-1-snakeoil.key}
 incert=${INCERT:-/usr/share/ovmf/PkKek-1-snakeoil.pem}
 nick_name=${IN_NICK:-snakeoil}
 TMP=$(mktemp -d)
-mkdir -p ${keydir}/${name}certdb
-certutil -N --empty-password -d ${keydir}/${name}certdb
-openssl pkcs12 -export -out ${TMP}/foo_key.p12 -inkey $inkey  -in $incert  -name $nick_name
-pk12util -i ${TMP}/foo_key.p12 -d ${keydir}/${name}certdb
-cp $incert ${keydir}/$(basename $incert)
-rm -rf $TMP
+mkdir -p "${keydir}/${name}certdb"
+certutil -N --empty-password -d "${keydir}/${name}certdb"
+openssl pkcs12 -export -out "${TMP}/foo_key.p12" -inkey "$inkey" -in "$incert" -name "$nick_name"
+pk12util -i "${TMP}/foo_key.p12" -d "${keydir}/${name}certdb"
+cp "$incert" "${keydir}/$(basename "$incert")"
+rm -rf "$TMP"
diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
index 4988a689..8be05695 100755
--- a/scripts/generate_secure_boot_keys.sh
+++ b/scripts/generate_secure_boot_keys.sh
@@ -4,51 +4,51 @@ set -e
  name=${SB_NAME:-demo}
 keydir=${SB_KEYDIR:-./keys}
-if [ ! -d  ${keydir} ]; then
-    mkdir -p ${keydir}
+if [ ! -d "${keydir}" ]; then
+    mkdir -p "${keydir}"
 fi
 openssl req -new -x509 -newkey rsa:4096 -subj "/CN=${name}PK/" -outform PEM \
-        -keyout ${keydir}/${name}PK.key  -out ${keydir}/${name}PK.crt  -days 3650 -nodes -sha256
+        -keyout "${keydir}/${name}PK.key" -out "${keydir}/${name}PK.crt" -days 3650 -nodes -sha256
 openssl req -new -x509 -newkey rsa:4096 -subj "/CN=${name}KEK/" -outform PEM \
-        -keyout ${keydir}/${name}KEK.key -out ${keydir}/${name}KEK.crt -days 3650 -nodes -sha256
+        -keyout "${keydir}/${name}KEK.key" -out "${keydir}/${name}KEK.crt" -days 3650 -nodes -sha256
 openssl req -new -x509 -newkey rsa:4096 -subj "/CN=${name}DB/" -outform PEM \
-        -keyout ${keydir}/${name}DB.key  -out ${keydir}/${name}DB.crt  -days 3650 -nodes -sha256
-openssl x509 -in ${keydir}/${name}PK.crt  -out ${keydir}/${name}PK.cer  -outform DER
-openssl x509 -in ${keydir}/${name}KEK.crt -out ${keydir}/${name}KEK.cer -outform DER
-openssl x509 -in ${keydir}/${name}DB.crt  -out ${keydir}/${name}DB.cer  -outform DER
+        -keyout "${keydir}/${name}DB.key" -out "${keydir}/${name}DB.crt" -days 3650 -nodes -sha256
+openssl x509 -in "${keydir}/${name}PK.crt" -out "${keydir}/${name}PK.cer" -outform DER
+openssl x509 -in "${keydir}/${name}KEK.crt" -out "${keydir}/${name}KEK.cer" -outform DER
+openssl x509 -in "${keydir}/${name}DB.crt" -out "${keydir}/${name}DB.cer" -outform DER
 -openssl pkcs12 -export -out ${keydir}/${name}DB.p12 \
-        -in ${keydir}/${name}DB.crt -inkey ${keydir}/${name}DB.key -passout pass:
+openssl pkcs12 -export -out "${keydir}/${name}DB.p12" \
+        -in "${keydir}/${name}DB.crt" -inkey "${keydir}/${name}DB.key" -passout pass:
  GUID=$(uuidgen --random)
-echo $GUID > ${keydir}/${name}GUID
-
-cert-to-efi-sig-list -g $GUID ${keydir}/${name}PK.crt  ${keydir}/${name}PK.esl
-cert-to-efi-sig-list -g $GUID ${keydir}/${name}KEK.crt ${keydir}/${name}KEK.esl
-cert-to-efi-sig-list -g $GUID ${keydir}/${name}DB.crt  ${keydir}/${name}DB.esl
-rm -f ${keydir}/${name}noPK.esl
-touch ${keydir}/${name}noPK.esl
-
-sign-efi-sig-list -g $GUID  \
-                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
-                  PK ${keydir}/${name}PK.esl   ${keydir}/${name}PK.auth
-sign-efi-sig-list -g $GUID  \
-                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
-                  PK ${keydir}/${name}noPK.esl ${keydir}/${name}noPK.auth
-sign-efi-sig-list -g $GUID  \
-                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
-                  KEK ${keydir}/${name}KEK.esl ${keydir}/${name}KEK.auth
-sign-efi-sig-list -g $GUID  \
-                  -k ${keydir}/${name}PK.key -c ${keydir}/${name}PK.crt \
-                  DB ${keydir}/${name}DB.esl ${keydir}/${name}DB.auth
-
-chmod 0600 ${keydir}/${name}*.key
-mkdir -p ${keydir}/${name}certdb
-certutil -N --empty-password -d ${keydir}/${name}certdb
-
-certutil -A -n 'PK' -d ${keydir}/${name}certdb -t CT,CT,CT -i ${keydir}/${name}PK.crt
-pk12util -W "" -d ${keydir}/${name}certdb -i ${keydir}/${name}DB.p12
-certutil -d ${keydir}/${name}certdb -A -i ${keydir}/${name}DB.crt -n "" -t u
-
-certutil -d ${keydir}/${name}certdb -K
-certutil -d ${keydir}/${name}certdb -L
+echo "$GUID" > "${keydir}/${name}GUID"
+
+cert-to-efi-sig-list -g "$GUID" "${keydir}/${name}PK.crt"  "${keydir}/${name}PK.esl"
+cert-to-efi-sig-list -g "$GUID" "${keydir}/${name}KEK.crt" "${keydir}/${name}KEK.esl"
+cert-to-efi-sig-list -g "$GUID" "${keydir}/${name}DB.crt"  "${keydir}/${name}DB.esl"
+rm -f "${keydir}/${name}noPK.esl"
+touch "${keydir}/${name}noPK.esl"
+
+sign-efi-sig-list -g "$GUID" \
+                  -k "${keydir}/${name}PK.key" -c "${keydir}/${name}PK.crt" \
+                  PK "${keydir}/${name}PK.esl" "${keydir}/${name}PK.auth"
+sign-efi-sig-list -g "$GUID" \
+                  -k "${keydir}/${name}PK.key" -c "${keydir}/${name}PK.crt" \
+                  PK "${keydir}/${name}noPK.esl" "${keydir}/${name}noPK.auth"
+sign-efi-sig-list -g "$GUID" \
+                  -k "${keydir}/${name}PK.key" -c "${keydir}/${name}PK.crt" \
+                  KEK "${keydir}/${name}KEK.esl" "${keydir}/${name}KEK.auth"
+sign-efi-sig-list -g "$GUID" \
+                  -k "${keydir}/${name}PK.key" -c "${keydir}/${name}PK.crt" \
+                  DB "${keydir}/${name}DB.esl" "${keydir}/${name}DB.auth"
+
+chmod 0600 "${keydir}/${name}"*.key
+mkdir -p "${keydir}/${name}certdb"
+certutil -N --empty-password -d "${keydir}/${name}certdb"
+
+certutil -A -n 'PK' -d "${keydir}/${name}certdb" -t CT,CT,CT -i "${keydir}/${name}PK.crt"
+pk12util -W "" -d "${keydir}/${name}certdb" -i "${keydir}/${name}DB.p12"
+certutil -d "${keydir}/${name}certdb" -A -i "${keydir}/${name}DB.crt" -n "" -t u
+
+certutil -d "${keydir}/${name}certdb" -K
+certutil -d "${keydir}/${name}certdb" -L
diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
index cc8dc580..5ec85e07 100755
--- a/scripts/start-efishell.sh
+++ b/scripts/start-efishell.sh
@@ -10,6 +10,6 @@ qemu-system-x86_64 -enable-kvm -M q35 -nographic \
                    -global ICH9-LPC.disable_s3=1 \
                    -global isa-fdc.driveA= \
                    -boot menu=on \
-                   -drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
-                   -drive if=pflash,format=raw,file=${ovmf_vars} \
-                   -drive file=fat:rw:$DISK
+                   -drive if=pflash,format=raw,unit=0,readonly=on,file="${ovmf_code}" \
+                   -drive if=pflash,format=raw,file="${ovmf_vars}" \
+                   -drive file=fat:rw:"$DISK"
-- 
2.35.3

