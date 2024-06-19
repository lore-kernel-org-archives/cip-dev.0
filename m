Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263B3C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 14:18:04 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.57])
 by mx.groups.io with SMTP id smtpd.web11.22080.1718806680208477706
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 07:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fZFU+1p0;
 spf=pass (domain: siemens.com, ip: 40.107.7.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy6114Nq4VlzIjFPGbkdkxYi85WxPGdbnu1Ih/RG8VUEixBN/cDkuhkaoNLdQbgjJQ2aXfYQ6Qf8RwVYdz6dcJkivpJ1eUtM7QgJxUGe/bE1YK5ulCQdwzEQS41XdQpX40ndRuDyWVoE+Xp56qa1Qw+yiwceG7wQZ3lI4Po4zIEU08BCeaIsz6R6kT94bUlAfzmN0jubUb2JaS4/A4LGAfFVo66qFTAUQD8RWDLiZFRDO8sh88U+8g6zazJ88yGba6Aph3vCBNwMbAUqKN/R0SyMIYurcMrZbMRNepWhf71rfTdW25fVjB2xbYyTQUnmRmtao6G/DLwy1q6KiJFkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXkIy3dhF4aHPRm6BX7L/EAHfJHjjitp5n2+MakwR/0=;
 b=KYWCY9257eP5LvcskF+dG8qkRvO4WIwCay+jimdc7PKkVftcKUtJof5JWhplg/iQcpTkes17lLQ13XjNpf196qffgGYSOiB9olfh8KACV/zCak4LTPtqqObyulQE+LDIV0daNpnKKetIePSiZqNIydF4T35rMCY+RcItcIprHXQ94hUZ7nh285oEviFgRM8cf6zkPQdPr5TTPf6uQWzifzPBKrzQ5T7gyuhiwO6YrhceoL8CeVL9eng3IS8s9RCebezokxhON2aygoZETGpH0aBthtbcwGdiamkn4PCYCqFnBOSe8V6Cbpql+z9IhI+7yBZGpJFML3MY0lx3PvWvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXkIy3dhF4aHPRm6BX7L/EAHfJHjjitp5n2+MakwR/0=;
 b=fZFU+1p0hzcgB0ZtqK9TtZe4OmkmiFqVSNotQyZYKK/McQXaKPeSeQt3nhGum/qFn+aAmHE3NsADV4pubJ8rfon/7p+KX/U7JrxUP2MGuUS7GLZsxp+G42ZUZMgg9zpCzlZbCisCco8MwyDGBqEXxChj/OZK1doIe206K3zdcuEwWd84Bk3rn/XHF31WyX8AL0+KVwsPLGkeEiPGccfxuuyAK02zY5dgvI2Y1sMrriQ9qXlKLv0xl4SNaMPbFrpZIxkz6iOgleIh9zHCu/aoIUFphQPbRgR2yYCHgQ5Y7/qUZ1grWymvNgAwXwcD0yhyMtyG1YJ8tyWpXQMYo3JD3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 14:17:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 14:17:55 +0000
Message-ID: <541276ee-fc34-494f-8e99-6e1967c72c7d@siemens.com>
Date: Wed, 19 Jun 2024 16:17:48 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Use small runner for CVE check
Content-Language: en-US
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:610:5b::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 365817d6-5615-4895-f3de-08dc906a9d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VTUrSTBnb1g5VFlOTlNMRVRWY1dHMDJEa3JOU3RGbFIrbzRuUWszQ1hlRGY4?=
 =?utf-8?B?Q0tOY29sRDMrVEU2czd3cURWd1g0dENwNjhsRU1wa2JTQ2RGV2J6S2I5aXph?=
 =?utf-8?B?b0FIQ3daQ3ZIY3cxeW4vTVo5STlYSkVyNTBxdEhMWmZ6Z0ZlMzE1VXEwNnM4?=
 =?utf-8?B?eEJDbU9kT0NDa3hPOHlYS2NyWE5mYVR3WjVYKzFKNEVvb0RhOXd1Q2wvZWIx?=
 =?utf-8?B?ZkltL0xJcldCTlR5bzBFMHd6Q1ZSL1lMYUFIUWN5TDUvYnlwMktqNkg1dHMz?=
 =?utf-8?B?NkY0L1pCL1lUUThpaWxlUFdQN0tYckM1ajdDTy9ESFlleFdVellGWjhJZXhY?=
 =?utf-8?B?V01GQlJCVDh1c0xRUEFKMXRJQWJVMnkvSzJWY1dGell5QkQrWkxsMW1zS0Vr?=
 =?utf-8?B?blJmV2RIMWV5WEZwazFUZks0TE9HNCs4R3NLZVRKVzFQckg5d05NKzBkZHVn?=
 =?utf-8?B?Uzk1c2FjWkxMZTREM3VZNFAvZHFPaUg3UWVYZUFzSzlEWHQ0RE1zTFN0MlJS?=
 =?utf-8?B?YnMwKzhiSTlQN3p0dS9obzRTMG1QR01RUVhGOVI4bzFpUVpzMm4wNVN6SlNa?=
 =?utf-8?B?Qy9XcElITUc4N0EyTzdwMnBDVllkVm9UNkY1dlBacjdJVlIvU3ZqY1NoNFRV?=
 =?utf-8?B?R08zYVJqZzNOeXNkUUhKaU5Td0JZY2I4RHdHMEdFSXhlblZZWmUwMGVGWGdn?=
 =?utf-8?B?R1hRc2NHTEJSVW9GOUNlTDRCMnN1VEdlck4vd01ZUFpKYzk0NE9NdlFacHlk?=
 =?utf-8?B?R1czSWJnYjBoTWdJZVVyUFBlTm55YklQcE5tV2tvSW0zbjN4alN6TXRUSUkx?=
 =?utf-8?B?bVRyNm82R3l1S1ZLMUJkM0dpVElnRndmYXdsY0x1ZlZ3a3g0SEZaMG9qVGdk?=
 =?utf-8?B?VjREbTJNK0d2T05QQ0pqZHZKT0ZHUmVJRHJYc2JXWW5JdHFMVDdlaG9adHFk?=
 =?utf-8?B?SVdSQ1BXTytGQlVUQWxqRDlaT21nSkFQSFZyZ1lGTHFuNmtGcXlLc1lqanV3?=
 =?utf-8?B?cWQ5ZG04RmRFcE9xV0pTdVQ5VisxM0ZrQldEcUVZYzNSTWg4WVRjSGNpQ0g0?=
 =?utf-8?B?RjFYZnpkemtzL2dSQUQwSk1KOGc2RldlRmRpdDBzZ0ErSFlnMTVLVmdlTW1i?=
 =?utf-8?B?Qjc0dUkwTDRRZXI5OEROOTcrMHdZb0UvenV4emdTMHE5OGJZQTAyRWsyNXpp?=
 =?utf-8?B?SUNKTFpmbFhaNWJMNXBXVk5pQkJhQlhyU1c5bTF5TWtPakJOS2dNZzZkNWRY?=
 =?utf-8?B?d2w0SGlqemNjWng5QlEzZ0l2VFZNMzFselk3bWxXVE1FdjcyeTYzeUFIYXF0?=
 =?utf-8?B?bFlrdEhiVlRVbnpZMk8rTkRQR1hvMEs0WnBZR2diQlp2ampBS0Z5RWkwUHIr?=
 =?utf-8?B?emZDQ3BhNXIwb1JwQlVMQWdhR1ZVZlJEZnFJcUVTdmFlYXJXNWxzSWwxLy8y?=
 =?utf-8?B?SDZhelhGaFNIcU4yVExmdDFrczdhRHJSazE0REFNNEtpMG1SWHBXVm9uRUZp?=
 =?utf-8?B?aVd6UFp1R0tjNEhDK3AzS1c5R2cvd3VacWxHVzBlUkU4bmU5aWFsYStONlh6?=
 =?utf-8?B?QnBjSVdFTlBIVERFTWFBYk9NYVFuTUNTRldKY3VxTS84NDV0TjljclBablph?=
 =?utf-8?B?am9xaE5JeUFJQ0ZGVHNxa3NPSG16OHE5ZHZ0SEhFY0JCVERobGw1OE4ySGRV?=
 =?utf-8?Q?BhnFU/v06ejZ3A++JwBq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0tMNFkwRHUzbXRXZ1g2bStUU2thSkZZL3J2QnpQRlozbEpwYm1OelErNHRC?=
 =?utf-8?B?R0czTHljY0F4bnpUNCt1L2wzZHVSNmJXYWEyMk5RRWN6TGtTcnFac3NsY3ov?=
 =?utf-8?B?dHdIZGtKczJEaGxYMFpPSVFrSGs2Qi9OTmsxQldsbFptcE1NSXRYZk84cldo?=
 =?utf-8?B?YmRMUjJaVEN2T3VrK2pxVVJiVm5CSVduVm8xV2JwUVNWdWtMMHZCME9CVnVx?=
 =?utf-8?B?V2RDeE5jQXN4SUJ1L1c3aUtiWWtmbUR2WmxiR1AyY051REowUU9Kd25SU3hF?=
 =?utf-8?B?cmUrUzZCSjRpS2QwU0ZMbFdhU1hUZjRIRmZGazhoa1ZML2NuVDdzM2pyQzZL?=
 =?utf-8?B?ZmZ4WFVEQkc5QUtncWF6VGFrVXIwb2FQOXU0RFgwUkJmUVBMd3ZZMEV2NGNO?=
 =?utf-8?B?QmMvY3IrQ0xWVkhORkwySGxyckRYdGxPbzVRcXNSdlNBVUNTN1RKTlF2WFVL?=
 =?utf-8?B?dVhLL3g3TXB5UEdsZkduVmhIM0Z1YmpoaUxTUlFFUzMzTkxuYVIvNjZrZ2Rj?=
 =?utf-8?B?TGdYMHRlb2JJSEpkUmh3Q1VTcndRdzd5dkNUd202dFlneVg1UFhRWm9TRnZv?=
 =?utf-8?B?aDJ4RmsyM1NIYUFHUGxHa01DNGdzSFptLzQ2QW5tOU5SUUxpOU04UVlia3Zp?=
 =?utf-8?B?S2dWMkNuc3RObWNHNXBjdVFIYmpXbDZEYWFhREVoTURIZUtlcFBFQTlheE11?=
 =?utf-8?B?R2FMRUJRVEgwSjNXTmlUWXdvSW9qUGt2SGJxZ1NRd1p2a0htNnYxY3pMK0ho?=
 =?utf-8?B?dUpTSkYrVFhIVUNNd2RqaG5adXJuV2RlcXFQcHY0K3MwdHlIdUFMNDJOOW1r?=
 =?utf-8?B?YmcrbHFseEwxWE05SC9nRmVLaWJsN3NVbHQ4MHBuMHZCeGM4ZExaR0Z2bXVB?=
 =?utf-8?B?VE13amZqVW11RGFFb0JBTzJ6WXR5UmM4dlhhNlRBcnM1QTVvQ2NadmwvcXVK?=
 =?utf-8?B?cVNLZi9BVmJWL1RlT1RhdDdVRTdDYlAvMWRMVFJHanJQZVJ1UVJaaWR3Z3hI?=
 =?utf-8?B?TmNidzA1anZ4L05QVGJkWDUvc3o1bHBuQXRMVmpoWURMR0J0Z3Y3Rm9ybCtk?=
 =?utf-8?B?NnlzV3ljeEh1ZUovNXJJN21Tcmh5VmREOUs3ZExER29oYVRRd2oxUlJKR0RW?=
 =?utf-8?B?cHowNE13QmVkaUw1bEpWaG0xajhNTUxDRExhVHlaaG1pQXJEWE80R0JLbzlY?=
 =?utf-8?B?TFdpV29kemFnQlFYZ2R4Q0ZXVUNhVTJNUEhIUW43M2szWWlNeWNDUHJJcDhq?=
 =?utf-8?B?OEx6NTVYSDV2UnljSlE2eW00V2lCWjB5L1BYdjlvMWlQV002L1RLSi9PRU5H?=
 =?utf-8?B?b3VLY1FuelVNS2VLZEgrajZ2bkUveWZFdTM2d3M5c3JIVmFkcTg2enNJUlB1?=
 =?utf-8?B?U2RiWTQ5ZGkyZlllb002MjVUdVpWNEtZUTEyZFVhUGVoVmhwczNyK2JkdkUz?=
 =?utf-8?B?cmllQWtIS0M5UVlaOG5qcTA3dkVvUGt6YkpVTkpwcGRCcjR0ZHBMa3lvRVN1?=
 =?utf-8?B?Y1czTGNkTndoRUR4S1E1b0s5VE9kOHZIOXU0NjJkdmdGZ1d4ejd3K0ljLzFh?=
 =?utf-8?B?R1IyUUY3OHJYZ092SjNXbkFTRy9EUFdrUzVlbWkvbEwzdDR1QzNNcVZQUHlK?=
 =?utf-8?B?bWoyazJjZVBpWGFOMk9pdTk2WVpkbWp0YjE4enpXODJWM0hXcjcyQytKaXJL?=
 =?utf-8?B?U1lpdjRCMEg5MVE2RkhkVUhESHVpOXJpdkpYcnpzdCtBQ0h2RTRQTm5PeU1N?=
 =?utf-8?B?em92Ry9EdjFlN0QzSUdTbHM2UHdrWk1RT3pRWkVQQTJ1V1UyOVlvVVNnR3F5?=
 =?utf-8?B?Z29tZTg2UjROSmJTOGFXcVJ1OUJDaDFzaVpHK1VPdE5EaHZ1K2Q1YjNwd2Rv?=
 =?utf-8?B?QnBaVXIzbWh2bG1sN2MxZC94Nlp5eVNvWm5uSHdBYVRUdGNOM0FEcEtVVXNh?=
 =?utf-8?B?UzBCOTY4QVJrd1l5My9VY1Y5NTk3L1NEZkxCRXdSazdBdy9OWlZnV0kyOUFS?=
 =?utf-8?B?SjNCUHRIRXp4YSs5UmR3RzNaYnhhdjVucFdUTVZRU0dmNm9rYTYrb01lLzhy?=
 =?utf-8?B?WUpqcDZYREFYRmd3eU9EQlduT3AvYlo1S1ZScEhWUXEyNHE0SVZiSXV2RHZD?=
 =?utf-8?B?QzJSa2dEd1FvT3BzLzYrRG9RUVVVSHlLN1h6SmZkaEJPelQ1K084Ykc1UEdG?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365817d6-5615-4895-f3de-08dc906a9d17
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 14:17:55.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zIVZApDm/joJ+RZV4aeo4dijH5CiV++ofwKmWQvullzD5+S0ZCXkUMwEVVyqueY4q8D5pzyelkBGoIVts27bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5668
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jun 2024 14:18:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16297

From: Jan Kiszka <jan.kiszka@siemens.com>

The absence of tags stalled the execution.

Reported-by: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a2834292..3cb98f7f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -458,6 +458,8 @@ cve-checks:
   stage: cve-check
   needs: []
   image: registry.gitlab.com/cip-playground/debian-cve-checker:latest
+  tags:
+    - small
   script:
     - scripts/run-cve-checks.sh
   when: manual
-- 
2.43.0

