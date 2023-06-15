Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CADEB64DA
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 17:05:12 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.69])
 by mx.groups.io with SMTP id smtpd.web11.24250.1686848705270218254
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 10:05:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=S7ENx6wv;
 spf=pass (domain: siemens.com, ip: 40.107.6.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOSijTCBvrP560QjaJQZ4hbd9h6HURw5/+svnwTkIG+F7XEmypneTA9f6Vvhvv9J3UFXX+AnBkMQwGwoeA5xilTcTLdmX5EMQUVmrCNtlLdQkKPmVEDVCEgIAYCGCemX3UBC0RXYa9L+wWKxthllQb4KteQTAvk1FMYMnX+03kQ0Jcim2ha0jTyoQ/IrtIdXC+1k/ydSaYrPhh8HTRgSUVYfE/JHZpI1WT7fOSKXZTyaNPRHTwL3nQLrQQGP4W4s6QURgsKUIq2D/vfyN6u/dPpA9fggjngzfCq5jJphn5xoX4ZFBUzZmSCL2rXpYD5UZkWqqCLv/P1yWD0wXSUa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGOYwRzKFRawfyTo1cFYN+jidvtfKPGPFytIFKxCPno=;
 b=A5td6Fija6lyYYv2xGAzBRGf/YJk4J4xYKS6jCdq6FvOQD1iepkyaMZHCREY5vKg2MHdrTIxTivhSFfrUxW05CQViphujRu7XAJwmK4HCrRI7FX4nmMIWmHqlpp9osf+YaSm4xusIMgOFt3VlucK1u1pA5n5FXxkC0iGIWJC88y4gM/HNBVk2FfEtAZvaPlizry5gqnVK1LRZyu5BNfws/VoifvRackoR+y6NPRc3VDWR2AsuovVkVnPm9TVB1MxYB5f4ujsntZGH6YOVZefe5Igm3qC3EYYXeYoFAi9M+VzooLFbiaL2PAeyrxfXPKw79jS6F9Ct3Insg/6DLooJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGOYwRzKFRawfyTo1cFYN+jidvtfKPGPFytIFKxCPno=;
 b=S7ENx6wvPzkAjyurkJ5mWtU68JC7o9W/okVTRBYRfiYdtEuSGEQ9GZCn8tjoACFAwOqsxpmRymGRRqcI6JJwOGBcYV1e+FoZfP6K+8cia+qeRZsENHNjhr0ytolpSvZu3AsqZjoAYlmoCcC55mSNnuWSn3W4sS9E8P/cbMC3YtFVAiBcFPpZeuPMbt5/oWOqH44WKSSKWO0Fe5sJyOOMU274rLueOP9K5SPqKSVOSVng80dN1D6KkRRaRkC7SJ2cAKMKe/aSQpKBztdWKP85RV5BYsu3Oj1JORaMvcfmpHoVskvqtuJUWANE7qLmlS1Y8XVBZGE6+9DNldvBBXNu7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5425.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 17:05:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 17:05:01 +0000
Message-ID: <068a7d8a-1f5c-8582-296a-e71c9c6b48bc@siemens.com>
Date: Thu, 15 Jun 2023 19:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] swupdate: Add missing libebgenv0 to swupdate
 images
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5425:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e3da01-6efe-4ae1-ae72-08db6dc2a797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H46boG3+tC9ss5XUczd+dY+nwIB4R1L0dN/RO+EmGAPxnVo5Eh0V5z8nUpwf3qkx8FfW+vdeKFCo5ilXUUi6gvtvr5sT7N+0CpGUTEarkJuiedkmdBj021JiMhEUnuSnP0FjiZBjOwWIPe1002HQ/Gvbvm34S+dH1LZt+ITFjio1auAvDUCPKbRYVw2QTXfmF023i6rM2WBBGqpQq4qCGdPaaEPIh8OZ7nXYoZwqINw3uugsV+ZqF9VwOOsYEz0ZyPnj08k+fa9UXkKu2daceko9eGXCR/g4Qhtvo3AzCmOeq6rQpJ49fjaPOVyOiRwsBZ3dJ8FgCDyKDHiu3qFmiRSaqn/NeYnXy9LDdqP03tFNZzA/SJcRSoXyLQ9z7lQV2FP6s9abCmFoWP+ddt9Gi+57v7UKcc4HW1kK2sjpsv7zHcu/ewp+tbtZX4upqhiRbt2MXsO0TG/Onw5+GQv6o2iNGpKzFi8n1UPeH8xXxMFIJFc/YIhCYSSyRcM1gKmeB2BkxzQmMM3/BbY0nxtfgjeQEOABCx2WbAbLLABJpqthlTDlsYGi8XCh03FBfvyoiA0hKhQItAZ255HeTv3mnyqOXPdkNlAjApa5pcIJbK539wQPr2pNgpuU4tLcVPbQxX2id1lTOFhWmqgTj500tQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(5660300002)(83380400001)(186003)(6506007)(44832011)(2906002)(31686004)(4744005)(2616005)(107886003)(6512007)(41300700001)(8936002)(26005)(8676002)(6486002)(31696002)(54906003)(316002)(6666004)(36756003)(478600001)(82960400001)(66556008)(4326008)(86362001)(66946007)(66476007)(38100700002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEx5WngrTEhBTzBWeUZDMjF1SFQwVjQvU2xnUFViUThZTEw2TmF0RXVyMnBX?=
 =?utf-8?B?VkdEYk5XUUhGTmp0a2tGd0xCTnBvaDdMWTBMRzBVWjJBWkdIMjRJK3MxODZ4?=
 =?utf-8?B?Z3FQTEd3VzdQbWJtSTBvdGhPWHN1QlFkYmJLa1AyaXRPNk55YVJHd0h2SGR4?=
 =?utf-8?B?RW83ZDVlcUN4cm5ndm1ERW1FeVM1RkVValBtUitlOUVFMDZjQ0NVR3J4RitD?=
 =?utf-8?B?emp2SGg1NUg1SXRnYVk1dUU4aEdQZXFDVnNQSEgvOFNMcEFNQlFjcVYyNzBE?=
 =?utf-8?B?dFd5UDF3WWJlOWlvbktPc3VHM1I3cStFNEFxcVJ3U3p1eG56a29Wc3EyUnV1?=
 =?utf-8?B?MHVjbUxWcDAvU1NmS29YNGpndkdwaDN3enF2ZE93d3pVRTFCYW90K1JmNTVn?=
 =?utf-8?B?U0ttUVdsOU1FUzcrc1JFWk9NWlMzK1NTSTQ4ZnIzZVZOZ2pUbC9rY05kVGFu?=
 =?utf-8?B?aS95aEdUZlhkd0lMQWhqNTA2TUVoVjExTkd3RHpIanlsT0JLc1p0Y0NOVXZv?=
 =?utf-8?B?dTE2U2pYNUN6ZHI3bzZYUlFRVC9MTEN3MmgrVzFweFFwT3RjbUVETDZObWFX?=
 =?utf-8?B?U25pbWk0R2xMektJM2NzaGVyY2pwREZINGpDRlVjRkVYUUtPOFZtelpETXNB?=
 =?utf-8?B?Vyt5NWVyaWFZang2NkRRRG9ibXRuNk1idkViSjI4S293UVkwWU5PU0ZVdGJr?=
 =?utf-8?B?TnlUdHd0QXh6SXJJeWlFeVZMTHFuQURJVm9CSXJFalNHNklOSHJEK0g3bVRq?=
 =?utf-8?B?cXRiRzlhZW5jVEcvbFNvM2twZ1JCUkJ2WmxjUDdDYitLOWVuYjc4RnQ4cmlt?=
 =?utf-8?B?MDRxRWdEZ3Z5T1NmOXUyQW1xT0pxV2NCWWRaYWNDUERUOFErNmJkcE9QQXR5?=
 =?utf-8?B?WGsvY3RQNTBGMENPcXJOU3FRYUFhcTBYVHhjTjFld3F5WWloUmxuQ1JCUC8z?=
 =?utf-8?B?cUtDRVVBWU0xazhGQjhvbHNyekxLOWYzWXdQeWJ2NHdCMWVDaktQMGRYY09j?=
 =?utf-8?B?WFk0TTFHcm9zeFZZa1BwSmNUakNhdlZBTXA1WFhFamdaRnAwdCtVQ09nVFA0?=
 =?utf-8?B?L2htODdrTE1BRE1USWM5amxzdktRQXZUZGh1QWgwOGFNNjkvL3NOVjE0T1lt?=
 =?utf-8?B?cEVIcW14cUxTOFA4MmVyR2VWRHpsSlhVUmhlM2FiUGtkQWRtWkg2U3V6bHFq?=
 =?utf-8?B?cXFob0dxTUFoekNzRHoxdnJDWVcxaVB5dGtSQTNabTIwQ0JEejJTQXVpcVNr?=
 =?utf-8?B?RWkzaEgxT0dXYnU0Qjc2OElEdEVKQTdGb2FRTFgyNVBWcWVsL3diYnhiUWt4?=
 =?utf-8?B?M2V4ZHY5U3JBaEptbjFqUFprSTBTNVJKQUVHbS9zVGIrMm1VWlJOamJacThB?=
 =?utf-8?B?NktzZXdkeERvV3VlOCtRZEhxVTdySG1Pc3laUUQwWi9XSVZsTjhTV0p4eXhZ?=
 =?utf-8?B?elFWcDN4c2l5Q2hFN0t4SGRZa2swQnEwNGJVbkZScjhxRCtTQmxLQ3lQb0Zz?=
 =?utf-8?B?SmsxbW9nRmsyVjNzaXRzSnA0VGluV0RkaXdhbGpWdDJzQTJSYWZFcVozNVNL?=
 =?utf-8?B?YVJSS0VUYzl0OUNKejF3L2hxVjBDcmxpT1oxaVo2L2FkUTVZdWdsa3M2bXNi?=
 =?utf-8?B?Y2NwdjcraStmQUNGV0U3V3dBc0NrRmpBa3VaaGsrNWxFenlYYWZaL09WYzlt?=
 =?utf-8?B?dk1YTGVZOXdhUTF5NEZCZmMwblRzbzdEKzlrUUdmMVhSZWd0bFhOclEzQmhC?=
 =?utf-8?B?TG53eHlab2xGRXBBeEE2SUdCWHI2NFVDNUpPQnNuVldHbmEzZnc2MVRhaWhu?=
 =?utf-8?B?YjloU1Arb2F0ekV0MVNDMDRqZ2QrMGVFWEEvVXFmWGZmVEdvcXZxMEJNTEs4?=
 =?utf-8?B?bVBkVEY4Ujk2SmdibG5oVmo0dmtOWkZtVWdqZzM2eGRwWWJHb082aHU0Y3V2?=
 =?utf-8?B?STE3L211WXRTZG9XMWo4dGtyUzVFSGtXRUtLOEtGMTU2eWJpbGhUZXhMQlRU?=
 =?utf-8?B?MXhNdUYzVEc2dGhxcUhKQm93ak9zSWNUUnhaMW0xT0VpL09SNnFuRUp1TEZs?=
 =?utf-8?B?NG4vMEoyQkhJQjB4czE4anEweVdmZGR2MDJFWmlmQ3cwVGVMZHh2RmRTampN?=
 =?utf-8?B?WnNFQ1VFT0wxMmJPK2M0SXRvd2NEZGgybGFWNzFtRjh0aXpYaEZvTkFISWNS?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3da01-6efe-4ae1-ae72-08db6dc2a797
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:05:00.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ha9uvh86IIsTi6z3QZAR1ROU4KvkQE58fJ78QyHPK3XHi5eSpMZ6zky1X2unh7w+iNLeQ2eZZHpcAUiMejOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5425
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 17:05:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12064

From: Jan Kiszka <jan.kiszka@siemens.com>

With 2022.12 and later, this is no longer a hard-coded dependency of the
swupdate package. We need to add it to the image when using EFI Boot
Guard as bootloader.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/efibootguard.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index e6824eb8..c66ab701 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_INSTALL:append = " efibootguard"
+IMAGE_INSTALL:append = " efibootguard libebgenv0"
 WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES"
-- 
2.35.3

