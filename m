Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4CAC7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 10:35:27 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.82])
 by mx.groups.io with SMTP id smtpd.web10.126539.1680690918457609682
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 03:35:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ym6tY0UX;
 spf=pass (domain: siemens.com, ip: 40.107.7.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfEfBJJNXbZu1hb+dLjjyUIptF3tWaE6b+KLtOzA4ekraxtVODv6IiD3MASZq0J2VHoZBcD//LAyTrRo841O37cEHPQFP7o8Nj+bK/NujZU+6wVyOSIIvYFkJSRiafyaxlQg9IN87KYU1hF1IDM+fpa2XGaUofn62fza2MZOa1mynrzUlnjw6Bl403OoEoYaMdfH0bVJbhNqn1+cz2oct7gmklP9BwgxjmjKtW1G/y3ZH9f2GVugX3z3Tv21jugIn5P7PxzPpnY0IYrNJ3I2zK5CbxDDozzOnOxBPk80GSX9GkJhpVZ/xHLHTioAhfAgqoNX4RRRB/bxRTi/NkLX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afWxsulIkXbyjOVuImI54ycgh17v4A42vdzUaPmjyz8=;
 b=Xv3FuediZsIw62bfshnhISgm88IodnLP8cBL5Cs1/PLQkG1fqyFYokOtVti6OnlODsb2uI5RRE1GBIGc3CMv+YOXsjOqoFYur5MHPm9sufxT5R6+xUnjH4wQ+CLE9rZBUMt/oMjcs3uHulkK4UlFsIbQ4yGTVKykvPPUYb6isvF8cXjO5ByyLLBVCNOYc/UtsTpsstkoftSPbeAP50EWnkRIUXH1QH9DbSQgSJVRpKIZ5G4G+rulDRoCdTtgbyxviJ8Jn/cHgMm6cVPiQoR4efrR46nv85rfE3HcriQGi1Kyel92ID/nqO7jyuTFo3ygBhOIEbnVRAw+GYx9Q2/Ldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afWxsulIkXbyjOVuImI54ycgh17v4A42vdzUaPmjyz8=;
 b=Ym6tY0UXR+YiVFoZroDLF5kCEyG8EvV9Z64OW4dGva8nklH6ie4MSq6+LiaL5p0OdnbjRsejbp5NxUPrV7wddikg94bR3ZUQu4AHVrtVJniHUNRuMacdG8NU5cnEFjwWNn/ps4nWOH6Bj+0s8MT2CK67UB8V9lXHB4sINZ5CRvkcZgm6dFmOyHq1U5DRP0iSYzccPrWz/Qtl9czXrrBd+AU9OUecJEWlzA/km83yERDrkS30aA0I8ZAn6Ucs9DOf81MkOztP4rYNXONAnLgn4i8vTIho7n2KuVl+lSindnmLrjyepeqwI8fnqrVk6l4elnXxQenxq15hW80n1OuWdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:316::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.25; Wed, 5 Apr
 2023 10:35:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Wed, 5 Apr 2023
 10:35:14 +0000
Message-ID: <6579963c-5429-8bc4-e8be-441a70f6a1a4@siemens.com>
Date: Wed, 5 Apr 2023 12:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] scripts: Address shellcheck findings
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "A, Srinuvasan" <Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c7f31b-8dd4-464e-393d-08db35c170f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4fsnuas503DO1wktnmDe3DxsTAYRkp1TiuNyV1IdHTwZsmDsQu2jVViu88j3p9ibS+wXeJ7Cpc5AJUSJidgfJGH8rzjtIFSMSW1V4hot3CIoG0H/3nKBp+Xk0TzgO7UpKCIDwqGnJkFm9ofMW5ycl2D3enY9V674UlJ9LsWCHmsGM6R+ZFIh1arnsBQz3gikt1eToOABP4h6sNaEEhZZHVv3Y26PqjlfNT5YvBsU375GSL26g1g/oWQIpwSwa2yX4VAj1AfvPO2FG9+7vcOwLqX4fQibZEMP8XM7yZidDt0228DiurAZFj+NBCg78XeB5X0xZOyaFB24xUUnTylvQX4Xaa43cMewglZwKUPLv2R8jpXGLGX5cxP8Y4DpaiHy2/+I80+dEqC7kZP9E/o1GJ+3F5rzhgGch29X2Eekx1hVTX9UFmwEpx0gwx/gNIqhkgf0m/eZI62gFRubdwAXON2pGfzO3s6ZVEE22Cm5wKZGScjvjYuhcnO3T1rRmELTcmoFvvsjUPB2HfxDF7Adt9/Lte0icr3efEWPKcQ79cj1RBeflwYY+kn2cexVIGRJJuYgWTTphLAU7ye6Lue8KCyHzwN+g95hUiFTIrWkc7nI4pbNclbKJ9eBgJoS2GiRju+v0ZzWUoQPSN9AbaeN6g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(31696002)(86362001)(38100700002)(82960400001)(31686004)(2906002)(6666004)(44832011)(478600001)(41300700001)(4326008)(6916009)(66476007)(66946007)(6486002)(66556008)(316002)(36756003)(6506007)(2616005)(6512007)(186003)(8936002)(26005)(5660300002)(54906003)(83380400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aEhYM21IUXJSQVpCZlZDSGdZbXhmY2NKdFdaTDdqOTNTRUdaL3BEcHpYWnA1?=
 =?utf-8?B?WFZ4cHpOd3NzUllKWmJybTc5U2VxbXlCWWZlMm1teWJaWU1TNGhQWTVxK2lN?=
 =?utf-8?B?RmNxWXhNdk4xMEROZHB1V2VIQ0xvUU8ybnAzalRkb1p2YWRJYzE0dTFoc2tt?=
 =?utf-8?B?Q0hlemx2UUxicVFrS0FSM095eU9hVWRTbnl6aUMvTTZVUVRaRjBmd0RMVFRz?=
 =?utf-8?B?N3llbkpJRERENlkydkI1akVoTVpoRUNlRGxhbTVRWDJyNkh2YjJMaE41US9X?=
 =?utf-8?B?WTd0WjJJUG1ya0l3aEpTM0xmUVNLdDY1dHhkcSs0T0NsWm9JWWdNMi90ZUl5?=
 =?utf-8?B?TmF6WjVCZkFwVzRQRDdETjI5K3dZL2FveThudFQ1MmQ0WkwwMC85c0Y5WDB3?=
 =?utf-8?B?dDJ1TmhmSWdnOXpRNmFPL0xRdEZMejBvRHRvYitiemtCajlRWU92WlRNOG9y?=
 =?utf-8?B?dUZoOWVwYjN3YnVnY1prR0JtcEMzZkFCUGc1bmRLODZ3YVNWa3Q3Kzk0TEJ4?=
 =?utf-8?B?ejZpcWNRN1YxY1BCaEJoNmE5WTF6QzZYZS9tRjZla0t1Z3A4SVVyM0JnZ3Yy?=
 =?utf-8?B?K2hra0RvdWZEcTB6RWhKVHlzNEtESG9rWDA3WWw2TWNuNnNsUmNxL1VGRndp?=
 =?utf-8?B?aVphdmNqbE02Yk9vOWt2Ri8vT3YzWHVZK1VST3FXWHduUy9sSFhBUGxOZUQx?=
 =?utf-8?B?WXRLbkRvZm95dUVLM1lqbEJNeUxjYkJZWHE2WVQyL1ErQkV1azU4ZjE4b1g5?=
 =?utf-8?B?R3pXUFRNbnZTcDdLZ0psZTllTUhYbFVpVFdjajltTEZ6emJSWUdYbEx1MWpK?=
 =?utf-8?B?V0Vwd0JrZUJTSFBZOTc0QW8zMTVzTERGQTFkK1k4MVdmR0RjdTlFU1dvY3NU?=
 =?utf-8?B?M3cwVWJEaEJrRXAyQjJibVNoWVJsSmpxZzY3UFBZZnd5cmpCZ2FST2ovNWpa?=
 =?utf-8?B?ZU1wZTAzNTU1VFlWY1VlN0FRVHdER2gzTTl1L1V4OUZJM0xpNXpwbitaM0pn?=
 =?utf-8?B?bXowTnM1VyswVzdxMFErVUZ1QTMwYy81TjR3TEZDMDdFby9CdFp0MFhlU0tO?=
 =?utf-8?B?K2hDVW1XY0hZTWRqUVhYTmkxbHIvVDkreDRJcUhwMlhFbGxGSFBISFFRTEI2?=
 =?utf-8?B?ODl2R3lFSy9IYVkrcWRyVG1pcmdta0Y2d0xOVXJwdUc1WWFFWUVGTjdtdHhr?=
 =?utf-8?B?NitocUlwZ0VOVUZyQkFqMVd5MnQ4SVE3RGtyVHFtcGd2c0QzREtoYnRYZVVO?=
 =?utf-8?B?UzdrSXBXSEFqZ2hYbWtjTmF5UzQ2bTdrY3hRalNPZEJ6emk5QTVyenFDWUdK?=
 =?utf-8?B?VVVtVjFEUkZKWWl2aURsRFZKbi85OHlJQmZJOHRGT1lEcjVQNkxSOWxpTUli?=
 =?utf-8?B?cjVCYkZ1cFYrRzN4R05reWw2c0xZaXE0dy9zemJxZ2VSMjFmTXYrZHJwenlV?=
 =?utf-8?B?ODJnMFRLUW1INU1idk5kN1Mwb29jOVhvK0JYb0tCUldGQ1hKS1oxYUsxM2Ni?=
 =?utf-8?B?dm5NZGdHSDJTVnRSNlhFN2crQUEwSmZLZWJQVFBBUS9wVTg5a2FnYmdrU2pO?=
 =?utf-8?B?MldPZ0lGdWNtNW1DSkduMHVTN3YzRWZySE96c0RVbThhZWVSdWNDSVpYcjJs?=
 =?utf-8?B?RXpPVnpDWkg5Z2xPaE90VDFIb0ZzN0JFRHBxdmdqc1lGUERDdUNBeWF1RDRo?=
 =?utf-8?B?b05Xek9Gek1yL21TSTdPdjVhY3MraWpyMUtzRnJlZmw0U2NEeEdPY00zcnBN?=
 =?utf-8?B?VmhnMkRVTDJuUG42RWlBZlZGcFZBaFBRdW5pZjJrTzJuSCtCYnBTdnlYZGow?=
 =?utf-8?B?OWptQVB0ZGxmckpicHF6dU4xOElVc3lqYkI1UzlIMllYSTRRS1YyMnhjMk9y?=
 =?utf-8?B?VDNnZXBWNFhpTVdYcHJQbHp3Z2JCUkx4TGdDaW9ZT2F6d2hPS0FLY0JIMU1O?=
 =?utf-8?B?WW5WMlZobmpaK01PajlKQ0R5ZUhlYzBZUEJHdVpiMVpTb3ZwZVFINGkyUDZC?=
 =?utf-8?B?L3hMbTByYVYwV0lmOFJXRGQyRkNWR2Q5c0YyYlFNNTdSWEFNSmNFQXFYZzFO?=
 =?utf-8?B?Uy9IbGRaZGlXNjVxWGx4MW1ucUdjazJFdWZ6ZkVkWDUwemk1MDVMQ1JyTG9h?=
 =?utf-8?B?WFpheW9mdXljTkhGRWxRU3ZGUGlOMGNzZ29ycmtra2p1ZmsxdVZhVGJvVEQ3?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c7f31b-8dd4-464e-393d-08db35c170f6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 10:35:14.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RzpZkWMHHF/K34KPbRlOKTBP2IrEKXuOcs9v4JsYG2EU1EL+CvmMNPV669HF+bw1EG8B8e/4YBMPegspUNHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7115
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 10:35:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11180

From: Jan Kiszka <jan.kiszka@siemens.com>

Mostly quoting warnings, but also a non-functional stderr>stdout
redirection.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fix regression in deploy-cip-core.sh (KERNEL_IMAGE must remain
   unquoted)

 scripts/deploy-cip-core.sh                    | 21 ++---
 ...enerate-sb-db-from-existing-certificate.sh | 16 ++--
 scripts/generate_secure_boot_keys.sh          | 82 +++++++++----------
 scripts/start-efishell.sh                     |  6 +-
 4 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index b185a847..eaa8974e 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -4,7 +4,7 @@ set -e
 
 PATH=$PATH:~/.local/bin
 
-if ! which aws 2>&1 >/dev/null; then
+if ! which aws >/dev/null 2>&1; then
 	echo "Installing awscli..."
 	pip3 install wheel
 	pip3 install awscli
@@ -28,27 +28,28 @@ fi
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
+# shellcheck disable=SC2086
+aws s3 cp --no-progress --acl public-read $KERNEL_IMAGE "${S3_TARGET}"
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

