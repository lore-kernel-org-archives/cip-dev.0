Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD36C47258
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 06:22:36 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.72])
 by mx.groups.io with SMTP id smtpd.web11.17390.1706854950181298702
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Feb 2024 22:22:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UpwaM+s7;
 spf=pass (domain: siemens.com, ip: 40.107.7.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMeJeyijLZJIMDQ21X96FrFLYcOWHckSG1Rv2tk5Q3sf4dnAB2E27rlWaYqG+11EX1mivEorm9RqcVGRST3kvVnIn/iypE7Uk28ShBOOfz/kdPZuS7gkajwqpNqtGUzNftcAx4Bww0FX2u5pHHgs3XiN1uOsA1GVzdKrtg89FhTpQbyPf0uvGc+y7WqoZ23ERyqKEPqUA8TzI75ON7swAWvaEM6HTsKGzke6EvUWBSbEZQD/eO7closxchdGdFG1ujs1B/Syr+kSLFiZE6uqs/lUb8A7mu+mAKIywB2SUtPd2AcvBDNbTkWYN0HaPU93vOlss5afWseZN4f9JKH3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBYGey5Q9afQ5SM1KLpqCyrmitfnPZKv/cJQa87Zyv0=;
 b=DRxizeqzT+L4Vs+4xqTNoVe/H3Nv7lUAQQYlmz8lp6suVuUYa7POCHhg3QM0VE5mt/tn0GQAkbONooT45TpjQ33QWjDNNDOrp4xfgWhwJaKt/p5IATQEj4z0MayOegWrM4hvtCXGScET5NaVA3cNVz124GHShBz8E8wkOgbC2/JWlxc0pnanG2j2/G2wF/SC3GGNWmL8lbEhoOfrcgmX3Yx2iSX4HYkpW/z/VebzUhXtCykIS8NbS6NrgsuQGq9XnF3v8X026x9a2bAyHIr3HCJModltfL+HZZRxdkyrbtI26GLMAH7LMR8tNRBN53JBt29xjwep3Km+d1umMvZDfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBYGey5Q9afQ5SM1KLpqCyrmitfnPZKv/cJQa87Zyv0=;
 b=UpwaM+s7uOtmc6BjaAyCZk412B7nNiIRYkShze2nUZL1DImA40jt5UdzLd7xgKu7bTULFQtd/VjX/aA0TwTii71TSTac+AEgv8qRllbP3nTchSAu+ZJVhbUBR3RwZ+le5cZSVFzZ/Sut3Xh8WQDgTavb66ykPbsFtuy78D8zLB2foum26sIlD8efZmE6ZGSyjZspyDOaRERERZxMCfcxxTthMWywZ8v4+0+UBLTUMil3Qw66qJBbVvkoP7RTRIox0wt9/SFngQvWN2dcnO735z9YbqHB3m4Ikv4jHdColNkh5kwnU4TUWit4y2RjfguSScxNrkr1GTJWCTqrlN4VNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 06:22:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 06:22:26 +0000
Message-ID: <7ee2d595-a5ea-4d4e-b202-aa9b40e809b7@siemens.com>
Date: Fri, 2 Feb 2024 07:22:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip84
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: afaaaaba-d652-47e9-3cf9-08dc23b7538f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OJaiy84Gxy65a43foV6UtKX5Ao2AqKebiOjTJD7G9oqRkwt4dX9BwWOD/VUEpVI0VIIBA/ENQjMbIhDaERyu6VxRocONHTs63dTI0MxBdgrauW2AghdtxYU3lq3jFCQWvHXl9CwtSqfPcKooAKbGSGxF0H1yBnckxpa0pTE6CYc5b1IiT11+WUVW9q+j6P7mgj6cJKJxrvokx/yMqS04CONU3sM9ipTcxLl2rttTtk5/nuJYqPsVxudqbWAd8rS+6+guaZv2HWrBDfvTyCSX4XR4D2oGBOvUmym9Lt/Dv90jnqvD0w61wJp8ledFuwgsxEKn8CmrTSSwYul3gkWm5UEZqJDynMXgvN0xjetBq935iH5S7+hqHuvLTLudbMZp5KHyqWVKETK+zeFceSXmiT7yXSMhbMp8AvMu83bbQaiohBWoDNxfW+uKZcjoJ99mPEMJBtunDmUfCkMm3oEzv40w6HPRVldDMPSlvrwaJ8NRG2JS9cbpPRvvvh3i5ETzyl/5TsCulvsBwKliyKbeyPkd2Mlarsf7PS6VXZZwfuqbslQEgCcg2NH2+0jXhL0u6zqJaNc5OZFJq+nnRXXtiKn0iRLywcTTPZkMdUsINpPEpHgQaStC6e+qVO1ASrH3RT1x05/OOoYfYmEysh5cTA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(83380400001)(6486002)(6506007)(41300700001)(478600001)(6512007)(8936002)(8676002)(36756003)(82960400001)(44832011)(66476007)(6916009)(316002)(66946007)(66556008)(2906002)(31686004)(4744005)(5660300002)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U210VWNNWjlXelMza3QzOGlkcHpSWWxCcjlJS0w3OWpsQVNZVjZ4Y3gzWmcx?=
 =?utf-8?B?T0N3MGhaV3ZFMEgyYmo5a2Vud3NUNWcyci8wVXQraUxhL0ZObmV4TW5pTUpS?=
 =?utf-8?B?aVNCRStMWkpMeFR2Rk9yU04wSCsvSW4ycDdJZzdZNTBub3BESkw4cU1OSVdy?=
 =?utf-8?B?eW9KSUU5Nm5HWmlFYlY5c2xud1lIcFNBNFRRTFlXVU5vdnl2UjlmYk5maUVh?=
 =?utf-8?B?MjIwTkxyR1BHdGhCZmNiSFIydmpRRm5QM3ptbElFVTJQT1JMVjd0ZzdIanZX?=
 =?utf-8?B?cXZkM2xBMDNCTEFmOXdnY2IrWXlvMzZNV1Q0MEViZEJFTEZJeW9KeGFVK0pF?=
 =?utf-8?B?ZDUyS0k5cDVpWUpLYllpTHVlMjhIcDd4dVRYNy9NOXdGNm0zdW11czNRdEp2?=
 =?utf-8?B?eXo2QWFrVEdVTVlMRHZWcU13ZVNNTmNqa3VJekFZU0M3ME9vbVFmbndNT2dX?=
 =?utf-8?B?ZWVObFhrYSs0Y2ZLL2lLL3l5c0sxb1hIT09vYmlBVW5Lbnh1N2IrS3dycWZw?=
 =?utf-8?B?NGJWZEJlK2JmN0UrV0NGNUk4eDdOeDJFVlBmZG82ZDRqM0dQQm5UWGc4cXlV?=
 =?utf-8?B?MDJzdTFDTTdCWHRYdm9lSnM1SWpIb0lEMU1iMWZ5a0RaeCt5Lzl4SldVblBT?=
 =?utf-8?B?bDJrQmd2eUJWb1VSVEFsMTNEaFNjVFBVdWpEVUxMakZCcGw0NjhIUnU5NWFy?=
 =?utf-8?B?VlhRR1d5MWFsU0doOXVNaVpvRnkvVm5FdXlsaVFoS3hZWWRaTURZR1VHTG5V?=
 =?utf-8?B?bzIwQmhRdzdHYTNNbi9CamZyd1lNeVdSRFJhSmFKa1c4S2dpWUlwKzBqZHFp?=
 =?utf-8?B?N1RHQWJTV0dQTFNyRWVuQk4wc0xqbklycHVtWTd3eGo5NWxXL2FTQmhxbDdq?=
 =?utf-8?B?VWRPQWoyZEkwYTBhb0c2QWhsZVhUdEI0Nng4NDZLWlIxNGMxa3g2Zkg0cnBG?=
 =?utf-8?B?ZDh5QVg5aGJXZTF4VzdSUzZkTXJkQTRva29CSWpRMGtDUUkrcFgwSnVubmJs?=
 =?utf-8?B?bFQxY2UxbjFOaDM5NmFMc0hlSm1qOFMzZlJ1Um9IWGJqT0xjY1Y3U3dlYUd2?=
 =?utf-8?B?dzZPRUorVENzTVVLd3pMQTdONEZqRzhkMlNQY2lybW0xZG03bGNUWG1hWDZJ?=
 =?utf-8?B?ZjRrNVpUM1JjTG1pT0lzMG5MdEVleHVHSzB0UXNJMGV1WjRDRllpbVJ4OTRC?=
 =?utf-8?B?a3BsTU12SjNVMHVjMkpMZ2Vaa095VklueHlGTFRmTWVRcmh0M2x6cjZsTkNK?=
 =?utf-8?B?NFVncE41RHFDbWpBUk9NWWdrOGhObGVwdSttZEU5VVZKZ1Rzcm0zTFBUVTVD?=
 =?utf-8?B?MGx2eHZiaVZzdTI3cnExNGdWU1g2WWRCemVhQ1RZekNJcHEzTHExMGMreEVX?=
 =?utf-8?B?MmJkVG5tV3FidWhaSFlMOUxIR1lrb0hIZXFFSE1OUzZ4aE1adUJOSkFabzha?=
 =?utf-8?B?eGQvVFh6aHJBaTFxR0p4SS8yT2FPY3BwSWNmeU1PbjB4SldaRWUxZUJLdGJU?=
 =?utf-8?B?c1hEUTRjM1hqNXBjelZGanh3bHZoN3U2YWNxeHZRNStWb2ZFaWwrWi9rdTl2?=
 =?utf-8?B?Y1Q4OFpuSUduZ0FWOTNNZjFtcUp4dDdZcGNMaWZwd1Q0ZzRuSnM3dVVXZnNz?=
 =?utf-8?B?ZFRMYVlFbWJkWlZFditkc3l0RTJJTllXQVZuQXJrUU1nMkd4Q2VjVVlzNzlx?=
 =?utf-8?B?dGxxbXJ3eXZTanZwVUVWbERUdlZocUNROGhaNDYzRS9reFkrRE9sdkhvSmZY?=
 =?utf-8?B?VnlqZE1lMUFjcHFVQWlBdzUxOStyNURlcUZQdi9ha21mVkRoK0pUNGI4YmhZ?=
 =?utf-8?B?aWZTZzhCVTdXclJsUU9OS3djZTZiZ0hwOTlnTW9oOERXUHJlK1A3YXNNdlZN?=
 =?utf-8?B?cFlzQitkTmpGQkcvMjhybmJNMUtXTGlya25zYTUyVzZWckEzK1E5eW5hSE1F?=
 =?utf-8?B?bXZoWEZ1TzgrdEcwdjhnWHIrYUp4eFpWT3A0M2hkT2lFODUrK0JiQ3B0MUJq?=
 =?utf-8?B?UnVJVHJHN0lRbkY0V2pZY0tWczBRdlNJODdLQnR0eXZ6bXlienk5aVBaRUth?=
 =?utf-8?B?M0dWWEh2STNlN2I4U29acWFKdTBMVFN1MGJEWS9SK1FoaytHRnliL3VaSnNl?=
 =?utf-8?B?RW4waGtiWmE0dE5VTkw5Q0tta1l0aFAzeEJLeThhNXFnYmpGT01mTElxaGM1?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afaaaaba-d652-47e9-3cf9-08dc23b7538f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 06:22:26.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovdNQQLCMJedtpKVYo5lJf7MKJabJ+MZPFcSG6LMQr/68awsL+XpD0SN6AnYi/FT7u1aFdoDkXU3SCMDP5s22Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5720
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 06:22:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14601

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_4.4.302-cip83.bb => linux-cip_4.4.302-cip84.bb}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip83.bb => linux-cip_4.4.302-cip84.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip83.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip84.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip83.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip84.bb
index 051eaa19..0ea0a0fd 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip83.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip84.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "6cc43814b53964dd5d18a0d5e33da014773c54313ce25c57d8504a1e24fb96c3"
+SRC_URI[sha256sum] = "aa11943e7a262482b474d205b5cf0e1ff5a7ee17aa04dca9a09fcdd154cb2840"
-- 
2.35.3

