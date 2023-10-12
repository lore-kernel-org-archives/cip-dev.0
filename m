Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBEBCDB46E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 18:54:24 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.84])
 by mx.groups.io with SMTP id smtpd.web11.21090.1697136860543906235
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Oct 2023 11:54:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=R5l0UjM7;
 spf=pass (domain: siemens.com, ip: 40.107.20.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHcpRInpP6BcAIW6PS8BFMxfJZsWTXzwlQ4d0ANzbHLFsILuwh1CjEfRArOtmcKUZfOVU1ygPTjh1Q+utsE+3dnHEpLppLahB36VQjya3nId7zVEo+ZYYQ+a+zYo1eyGOWGKtU7ghPke8AtFr4gpH92neDktEPrJQANf1O/y1vZ998GuvxOUKkNkbupxfRs90DEOA01f1gV0Flgs3t7Mwl86YBs+HpcDTxtDVMI/pdL31hqpGzEAMPaOBCP05S4Ahb5OKj2vrgaEFk6rtpdUBigfpbsGc08kHs9WGP5R04snllOkF41WvRJLL/GWWf4MwJyGb45fnDIjCTh/fYQoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWsqKifnYp20Okd2hLqSGmakt/ZrbCy/zgJXWoYrFu0=;
 b=D+qZ8zTLBs/Y86xF3ZuedMTj0K85bxsC7xnepvqHg4qpW+TrGWXPAvfqFPuNVvp8loJ2ZJf48dxaFjbEPna8IFPTjz00hmyDo1wmmWmw8Zt6J4y+NjB6As1NrydVEuab/bdrpmMC9LiOjcEBwdy45NRijPa6BYngyq2oUoC9GZ8bhsdQdH+4NgFXn9B0YG6zSKnHdWamEMr/sz+2kfVUteHVwCagKOtWTWmPV48bnhMRgSQ1vxXhw8JP78aoCzm6a5Vif+W4f/zvFV4p39kdQOLuIsXV5JLkYRz8IOIKTN1LRM0SO7NC1PWujPWQNacxKG3q2bqM0OG/f+EripB8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWsqKifnYp20Okd2hLqSGmakt/ZrbCy/zgJXWoYrFu0=;
 b=R5l0UjM7vq1IT8KaKUFdrX4TYpCQ5dvMP4OBon7m9eZ6CaCesQHhBHwIEcGXcqsCMh2xinthpGLbriESrrRRw4sA/o2mK0IwwCPeUgQG6hLshnYjMzb1Ys4h+h4xzGc5VE9UcOAWYBq9mPGaX8PHr80Mm9O0m5mDyUNbg8Oq50/b3ijM5VZiE9Xjj3wb4cc2tLAGbv5u933GDdSG/1ru+AIxXUiDXJ/2sXuJI5mH6cVVeECEFezwhF0kSDk9TkH2h1EhpXRmoB4EDgr43+U3w4AtKW2oCpkfSJj36StPzRYtxDv6TBX6BgCclb+fczZr8R1KCmAWoASyQQN0puJE8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7821.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 18:54:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 18:54:15 +0000
Message-ID: <4747221e-c969-463e-bee0-6a3304e7a144@siemens.com>
Date: Thu, 12 Oct 2023 20:54:14 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] verity: Prepare generation of metadata file
 for Isar update
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 818fd982-9ce8-4168-9955-08dbcb54a1ea
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HwxxCbePUyA/HOG+yLD8XBo+VKjmNRd/WLKLeRTeJTEZftdfUEpHhxQLLuSEEzRZTI3LJkdwvd17SawicwB7wip+5Um7ePShhr1ezLtikb39aZMt/Hf2X/Dh/q+dhi0LLzCnBUeoEcpTkVxxVO09FqcSWT1ZrWs5tPITxyqyv+GQIQnt8/TSRt2rGZYxDSSnxfIFi2hnAdfQYQYxcLA5w/RDI9QpRQ7RzHCwK3dA8jUCIAmQ7A4WWsnU46DUPHiPREJ9H0Wxadn9gnOZHxIKg+ISpHWii3NvCZSNZDJV6IRXi/p6fXSWDsFmQ+etY/ZjHqu6u7dk7GoqICqZLp0OuBF6ujC8s3idZbCLnPXXLtI9unomN0gpBUaZSgSlu9t0TGA2kSqRgJtC8NbEtUZo085JO3OZ3pqOcQWpwUpJlFRGJQDMHqr7zowdxTC6boNGofBUCvGihCYv2Y8JaiBkad2k068pnSgj84AD7ewd9AMPPzyyeV9eoElHv//mA7BgPXGUX66Zxg1SWcjjyoAfsjFp28phqSSDJrKMwD8CGK9SZrO6084qAReHBwYsatRs0NroN4UIoke7Os5zYgE8/ykQo5lOAYrrspW9S+A0HoFIhEa+vwZeBCEeb169pTPPNANbLGnMPYDfggPhtsD88g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(107886003)(316002)(6916009)(6512007)(6486002)(6506007)(66946007)(66556008)(66476007)(31686004)(4326008)(41300700001)(44832011)(8676002)(8936002)(38100700002)(82960400001)(26005)(2616005)(83380400001)(2906002)(5660300002)(36756003)(31696002)(86362001)(15650500001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dTI4TktVbytqdy9rZTFlYzNyWDhlZGJMNzI4WStvZ0psZHUyMUc5aFZXbFMw?=
 =?utf-8?B?czlaTkFVeW5Xc054OEVaandCc0RVcHVva0VsS0lNbEp4dGpUaldNWnJmMzF2?=
 =?utf-8?B?WERaTUxWYkRYT2VXRklnUVpidTVaUWdNc0ZPa2RpK3NBNVFweHpEbm1QcWha?=
 =?utf-8?B?ZEtXUXhaaDgwOXdneTZuUDBpZXByMnBzYnBnVktTQjQ5Mnc5MWpmVHh1UnBu?=
 =?utf-8?B?RUJIc3JWOVptK290dmhNR0JzKzFKaEZia1Y5cWNIZWJGSEI1dk5CMUdKMDlI?=
 =?utf-8?B?WFFsMjM1ZG9PbkczbWhKZCtTZ0RBeUdxMElyWERna3NmYmN5eDVtdjBjSkVF?=
 =?utf-8?B?L0FORkJRUmtlQ0pXMXJjNko1MmFkZy8wTU9aRXBnNjVUVjZSQSt1OWpsMENX?=
 =?utf-8?B?NjdzSUExbU5DemJ3VEN1OVdsLzBvRUtyNUJnSEd5VlFQbnMwaXduMXVUQndw?=
 =?utf-8?B?R2VpY1R1eHN2K0VQNU0xNlBKMUFtaXVwRVRBZklZcGNBRmNROXo4WGI2L1p6?=
 =?utf-8?B?S0hJTHZhWnE3VExaMEg5aTAzTHpTNmN1WVZ3b1BjTTlocVpmYUxMUVZMNW1Z?=
 =?utf-8?B?S2dvSWRtNzM5dFczcW9Ncmo1WTVhL2YxMjhzQW0xR1NIUkoyOENvaHErODcy?=
 =?utf-8?B?UGhMbFVpdVRSZ3lMYVVIRFpsbi9QTHVWVVdjd3NvcEVZUThjNE9kTE9acERN?=
 =?utf-8?B?N3hNd2Y1Q3A0ODg1K3R2QkJZSWVTNEpiektwOWRubmZuaDdxSkVoNjFYdGdP?=
 =?utf-8?B?aFpVWTk4SXVRWU0xTG1ldEViVlZ1Z1p3Rkg5WkpJWlV3aHlWaDdXSk9yMWNU?=
 =?utf-8?B?TWdRdFUrYWNHL1N1UENiZWJQcEhCWllqLzc2ZWpaS3MwMThSWFduYkRGWk9O?=
 =?utf-8?B?R1NFZnJ4WUVPOC8zOUtBZkpvY0dReFpZdjRVR285eGhCK2dpU1c4d3czS0U1?=
 =?utf-8?B?NWJLYUtIVFdwZDBhRitsY1czbGVQNlY2NlBlZUE2bmo1a0ZOUzBRczNDVjAw?=
 =?utf-8?B?Wi9kanZscFNQajFHR1liekxsUUdmWXhNNFhsOTIwKzNlZDNibnVVaE1ISFda?=
 =?utf-8?B?NldrdG5aOTgwakk1QjBOdDZ3UFhRUVpJYnZWN3FmQi9FOXBGN1krUHV3cUNl?=
 =?utf-8?B?Q29aeVZYRzR2Q0NWUFNIWjhRUkd1azNkeVFob0Zpb0lkcnR0MzFCbVFBeHBF?=
 =?utf-8?B?WjNiV3AvR1BFVEYvNGRlUytkcjdaT29BY1VhQXZ5dzhXRmFWb1QwbXA0aVZF?=
 =?utf-8?B?dDArWWtySE80R1VrYU1CVlArelBsT25QZFdQc21CejhrYjdxSTVxWjJnTFZv?=
 =?utf-8?B?NkJlQ3BGQVRTOWRRYy9UTGt2QXdiRm4wTVRQaVlCZXdtN3ZicG9wa3ZFYWhl?=
 =?utf-8?B?UlVSMzVuYlVCcVYrYWgzRHN6eHdtbFpPWWEyT0JkYk9zRTdpWGlZRTNqdkJ2?=
 =?utf-8?B?ejlwRkdSbjRpNVFaMUxMRTQzaFJ2YUpFa1BFMFBoK3FiWW0xVjNyanpKbkVu?=
 =?utf-8?B?K3pVck5hVUY4RW9rYUw1OHpMcXJSeUZBOGdRV0k1WllrYWtMMWVlaytxYjdY?=
 =?utf-8?B?VHRya1dheHdGZGNtU0pKOHhJbDM5T2ZFWlJkZTVqQ1A3eTJrZVcwaFpqVS9G?=
 =?utf-8?B?TDVlZlFsdGNiMGdEdHZmRGdXbEdDK2JJNlpTR3FCUGdiUHZDQmRiWGNRUzFB?=
 =?utf-8?B?QlJyN0U4TkdKQUFBdmdVTlpuV3IyMGZLa3hNRmNocTVrVW00NkIxL3NCVUF1?=
 =?utf-8?B?Ynd1ZjNTa0Ywd1I1TzlyblV4Rnhid1diYmh5R25LMW5wcUo5Vmo0UTJ0dDc4?=
 =?utf-8?B?YmdkMk41RHQrMGhUczMwWTg0UjV1anpTSzJFNnE0Ymd4NEZQQmVUZkxsaGpB?=
 =?utf-8?B?Rm02WmU0cUVIdW1hb0k3QkJFUXNtMmJCZVpTZ0NuRTZHb0lDcDVmOFNSSzFB?=
 =?utf-8?B?NjgzWXcySDJObDljLzltNzg2T1R3TFlwWWxtbEhiOHF1UkR0RzM3MVI0RzlF?=
 =?utf-8?B?QjRzMlZ3a3p6Y2xVdmtsL3ppWFh1aWJyQ1BpL3NhWGcwRGcwank1UHpWeVNU?=
 =?utf-8?B?dlN2NE1DOHNkNEFsQ2pWL1NuUFNpVmdoU0llZjY0Zi9VVG4vVEwvYmVhSVZ0?=
 =?utf-8?B?K05QVE0yMkFDMmpOa2pySmFZdWd3eG15Z1RhT0pYU3FxSENhTTVCK2RxYTM4?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818fd982-9ce8-4168-9955-08dbcb54a1ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 18:54:15.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+cLih2F0an/STfXNdKOQbCyNbpacCEXbZWqozj+DbQfwp5FbXf1jCGjROxzA9ZC70bM1ws41bwLrssRekVjGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Oct 2023 18:54:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13393

From: Jan Kiszka <jan.kiszka@siemens.com>

This will be corrupted once SUDO_CHROOT is switched by isar to use
image_run which will also out some schroot boot-up messages.

Rather than deleting the metadata initially, we truncate any existing
file to 0 so that file permissions are set outside of the schroot
already. That is needed to modify the file after the schroot as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I've squeezed that before "update ISAR to latest version on master 
branch" to avoid the regression the latter patch would have caused (or 
caused so far in next) otherwise.

 classes/verity.bbclass | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index bacf5926..9030c844 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -85,11 +85,11 @@ do_image_verity[cleandirs] = "${WORKDIR}/verity"
 do_image_verity[prefuncs] = "calculate_verity_data_blocks derive_verity_salt_and_uuid"
 IMAGE_CMD:verity() {
     rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
-    rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
+    echo -n >${WORKDIR}/${VERITY_IMAGE_METADATA}
 
     cp -a ${DEPLOY_DIR_IMAGE}/${VERITY_INPUT_IMAGE} ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
 
-    ${SUDO_CHROOT} /sbin/veritysetup format \
+    ${SUDO_CHROOT} sh -c '/sbin/veritysetup format \
         --hash-block-size "${VERITY_HASH_BLOCK_SIZE}"  \
         --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
         --data-blocks "${VERITY_DATA_BLOCKS}" \
@@ -98,7 +98,7 @@ IMAGE_CMD:verity() {
         "${VERITY_IMAGE_UUID_OPTION}" \
         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
         "${PP_DEPLOY}/${VERITY_OUTPUT_IMAGE}" \
-        >"${WORKDIR}/${VERITY_IMAGE_METADATA}"
+        >>"${PP_WORK}/${VERITY_IMAGE_METADATA}"'
 
     echo "Hash offset:    	${VERITY_INPUT_IMAGE_SIZE}" \
         >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
-- 
2.35.3

