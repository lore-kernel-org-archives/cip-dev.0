Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE20C4167B
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 00:14:57 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.48])
 by mx.groups.io with SMTP id smtpd.web10.52693.1701648888048518344
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 Dec 2023 16:14:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FAR1qs7W;
 spf=pass (domain: siemens.com, ip: 40.107.105.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIZs6VOAb+tSQ63qnVDcephWvhdqOAWDhwr7tIL/LGRBp9a5Zo+XG+mcP9frzC6nI99WZhv7vBs82kmkh/rATVlZMCG/KnpO3AVghzGQNVjrrdshDPOEj3pDlTYlt2+wbBzEuqZaHbVhIznTWG2cqWo6XnIqJBRnppqUaMfDcGiJGex0bF3KMmsE+REyia2Dh/QUCurEnaAt26KvlqbDp0yACQSDF/JhIM/pMeBmyf/Kdu3EpMITW9QnrwJvBBKEiX3UtznZi+D5MtqLLzGZoZXiGtR4Jn14GvZp62StjtbwVoGhYrUnbU1fR1mkglsNqNNq952xiBm5SOxlyyGbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR3PSPfsMsMkuLuz8y8+3mWjLK8mh3KtFmJu5PS5+RQ=;
 b=XJDhnunoJbe+bi4o8mP4pD2nSi8dUm91ZwdCI6pGOvEaaT5uaZCOUfVdOaGvzXvsvWBckIVhyxiuD/3fJtHEYzuytWFOY9utLPZT0WRccj1sXCGaFXQMUWK6ggw5fUEHPJCyc53derRZsyWAUeMxLe82qmJ4jHDgaEZt3B3PM2NVw7w6cpcDHme3/exh8zqV43eWlPzF1/PF4C4fi435OV5K0rwMiX10ENJpkN8ke+2S1x9ZyH7/KOQra7c1ycAH/JEagL5RDjaMSXIHHw7QWHYn7pf0XzJDfJIUjGunldQwxctcIrebFxsFiB6UnkuabeiJ7nMWDjSKVRVWlQrqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR3PSPfsMsMkuLuz8y8+3mWjLK8mh3KtFmJu5PS5+RQ=;
 b=FAR1qs7WyI7ewrQRkxiwqhtE4XTV8Ny64v2w5jroxWOa9SZnfIw7qn7PbMIgc60WvrFQu4sgo7G4vEDXNHQ2jnK0gMdy08qa3+UvaAwzZM4fBox3fiz4DP1ThOnMP9T0jjLMadZtSt2jaHZ6q7EfvsqDGFbUiWM8gzqvc7yr5DK4b1rYvssy02Scl6jlKKVAzm+lrS6wqUQPZ0Qp3ZiH8k02t0yKFPXralXE+4E4hDFZj8/Q7aol/TG7Gu1T1yi7ATO8vUyc7v7Q0RT85/QgXJlaRxBN7KNc/w2uluKLfQFiqEDyM/6jtkbVf5Nk5sDijyOz26cucQe1qt06LfFJoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5321.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:296::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 00:14:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 00:14:44 +0000
Message-ID: <b1fdcfae-b4b8-476f-ae24-fdfffb291bee@siemens.com>
Date: Mon, 4 Dec 2023 09:14:37 +0900
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.64-cip10-rt5
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0028.apcprd04.prod.outlook.com
 (2603:1096:820:e::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ea6324-66cf-4966-0ac1-08dbf45e03fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8Tl2tFQxZ5oZthKnR7k8i51OUnpjQPe7YZC1GNLP1D2RPZMEt6+G4BK944Bfdx4rR0CtDnscMICP2S0EgBFAg/cr3EjitNxztxfegjLNbX+b+awxMKLZjsydLgSvRMst8/CYiWoSfVts72GWEfeFCjvyAASFr+JUL7quL3wCPPPBfN3Rr6OMK9nLBZ/5NRSCxlaWCDd6e7SC9uvjMShAJz8G6ScisGpBVNW7fk42J0uAliQkbRpfCgHpekQBMjWT0t2ec1LBV7AaWSjEW9+ZDxaMzYuqfVGmJAJLPlcexwd8nj4LAYxiJVgrGB2EepZTizoPaW/c6ftDADtEM9jb3gecbv2avzteAIvx69eBAFbWz1X9U3SML4MKqJMzik/lf+jznwuW+1MWd0Q1LNR7jJ+QwVsZFMEu8VD5wWz7c0j1hLzm+3NA97UIyHNuwd8K0CdWKnKVKSdhA3BehEOK3qrf+8qOOFwdF2IotAqTuIOIIl5GwyxPb+EVlNfa4bn4vrMLsiI9CJnfFEFvweY7yPX52PdV2wdAcnFZVZ1Q6N7IjHvnzFkmtbH0UM806Z+fdaHiBBMbpcRcbn5hgICbpihpXI2vO4Uf9JJcuCQdUZcRu0NGsr0eJ5LPzNbA+cBB9k84bYebxBoscMJ8UOASKg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82960400001)(83380400001)(26005)(2616005)(6506007)(31686004)(6512007)(38100700002)(6666004)(478600001)(6486002)(66946007)(66556008)(66476007)(6916009)(316002)(8936002)(8676002)(2906002)(41300700001)(36756003)(44832011)(31696002)(86362001)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Tk1Td3lGYXJ4ZmRxemFhcTVWRjk0UUQ2aGRxK0VSM3lMRHE4dVhvTU15bkZD?=
 =?utf-8?B?MnUxT055MTROZjJiczNxaXZGM0hEZmJ4SFg1c1hNWU9rTER2NnpLNW5JcVU2?=
 =?utf-8?B?eEkvL2o0ck1xUlJ2c2FDQXVUTnhvVnhqeUZ4ZmNWL0FFU1pmcDVONGlSMTZ1?=
 =?utf-8?B?WHFleFV2WGxpcG10TnhiQnFhYUNDdW9XTGc5aU9HQk1BN0JnSUo0WlFlL1p4?=
 =?utf-8?B?UUlCb204V2xma0M0Wmx4ZmFHNzBNWTZCbitXUXNkVU9Vb29vMlo2TTlCajJj?=
 =?utf-8?B?ZFVpTi9ibnUrM0tVQ0NaTmM5MVJtc1hTSTA5aEVKZFNpcGJTZmxJaUo0TEcw?=
 =?utf-8?B?MVp2ZGRNY2liSVd4SGxqYWFiN0ZyaVhKNkdUZ2JOekgzblEySXBxOXNuS1dl?=
 =?utf-8?B?TUFqcjdUaUVidThIanVtY1NzRXh0VGVnV0NxUkJDcU9PUnV5QmpSUG14L3dG?=
 =?utf-8?B?dW9ETFEwRi9EVHdyVHlmRkQyY1VRaDZuSG93MUVCQzc4eEFwbGRSZmF1UDZZ?=
 =?utf-8?B?bDU5NWx5QnFsVXJzTFlhT2NTQkdic1Y5MlA4VWxGdUhNR21RdzM2dm9OaXlE?=
 =?utf-8?B?NXlVZXZlN2luZDdVamMwbkJvb2NwY1hFMDR3NVVncEYzTVBNQ3MyMzhITnQ2?=
 =?utf-8?B?OTZxY2l4S3VSYVMxelNDSzFBVXF3SGVpNWdVdG9xZ1VZTWJZelpnYWtjaGx0?=
 =?utf-8?B?NjVGbS8yU1BMNXJPUmlSOUlTV1gyT1lCc2hOb1pkZ2NyTHEwM1dhQTlrSjRV?=
 =?utf-8?B?RnorYTBLZUM0YUNwWWQyQW96WUpUY2tUVTY3QlZXSlhBTmZGdFJyMFR6cGZp?=
 =?utf-8?B?eTZaT0M5RjRtaFlnVGRLRzF6djlCSlFnSTcyNzAwbFBzdUhiYmhBUzBQOGNH?=
 =?utf-8?B?K1dlNkhQWGcxZ25XOHNOVzVTSWY1NjgzbFJvdTJoUEF6RFlWL2tMWkZydnNr?=
 =?utf-8?B?SVpFSXgzYWtWZXIzZDh6bzRObWpvTmh0d1IvYWdMUlBEVGpzbVZReTZKNkJ4?=
 =?utf-8?B?WlIvd1JHV2JubVlER1pIR3lWNGV3SVdjZ2NMS0UyTjJ4NDh3dW9KM3hBK2xn?=
 =?utf-8?B?dlFERHVNa0p5UmlHcjBXbnh2anZ3elAxS21vOG5mTXVIWkU1NW04akxpVkk4?=
 =?utf-8?B?V2JOTThOTUlNVC84UDY1Nmp4aTRwSlhFSTZWcmZuQ2V2TnVoNHg0NlRGZ3Yz?=
 =?utf-8?B?UnBvM2V4bHJ3MkJDUXN3MGFoM1BuZkVHL0tTNlBtWDVoRlZCQVVqZTRkaTVF?=
 =?utf-8?B?TDM1STRMQ3MzaElWaEJEUlJpbUlxMm5NUndHVW9qK0drYjdBOXVFSTZPTkxz?=
 =?utf-8?B?TFBnWjcrZ0dlMWFmdU5taGpkdGhYWHZBZG1LT1l0M0QzZHlNbkMrSUFjSmtR?=
 =?utf-8?B?Nndaa1VnTXMrR1lJeGxnNzFDcTlvQXEvYWhEUll3ZUorNEhNNkprK3k4UmFM?=
 =?utf-8?B?MEU0dGQ1dXZLMklPMnk5TlkvQ0N0QTdnTytNV0F6Q1FyV2l2b0U0OEwwWW53?=
 =?utf-8?B?K0VvRnc0TW4va0psZjgwUUJsczlwWWRZSHpWdmF3dmg1Sno1U3Q3OExzMVhB?=
 =?utf-8?B?elBkMnZURkVlM3poWlJoT0ZhaGd3UUU5RG9XZkdhQzVoU0RpU1d0TVJzMlNN?=
 =?utf-8?B?VjRUaFZYcmdrT0xMR3B3a1NLb2FwZmpjWVk2RGg3QkRlNmxaQXFIY1VSUEIx?=
 =?utf-8?B?RjhEb1d1YVVXZTNRRThqNU5RUW92RGtHR2VrcGlob2w2b1p0anAxY2N6REpa?=
 =?utf-8?B?REpFWkJVbnFqb2VpSjN2QmZjZytSbk9BdDY4c0RXVjVhVFI1eGtsa3BPN1Qr?=
 =?utf-8?B?UGpuNTlmM0JUTWt2SnBrTUM0cExFRWlEM0lBQVdybXo1QUZ1ZnRVb0YvbzNK?=
 =?utf-8?B?aDlXTnQyZkpTc2FuMUErTXFHbnJITVRTUGlRa1RsRnpTZ3JKNGozS2JTWTM2?=
 =?utf-8?B?YmN2ZENKWnR2TWlMQ3dwSlBqSVdJY09IU0hlQUNORE1nQ3pHSkZIdFJObDhH?=
 =?utf-8?B?WDdsS0dRMXk4alpsYktHaEY0bzhTYk5wN3d3YkEwVjREWWRxd25FUG9vOVpE?=
 =?utf-8?B?dnVNZGhIYmI4S1c4Z2R1bkI1NlgvSFVIY3VvVzJvOVIyK3plRDZ5TFJoYnpW?=
 =?utf-8?B?N2hVMEx5bjhiOVpBTmlyWVhFWmtMNUh0Mi9rMlFCdGZtYVUrOFFOYXFQV0du?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ea6324-66cf-4966-0ac1-08dbf45e03fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 00:14:43.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlnPUdWaErnB2Pgsbn3L/MKdWjAKfYOPbji4MvcnyoMh1uOi07Afd1s8Cqfw7qhwazYOpqjCpmID07Eq3gdgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Dec 2023 00:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13782

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...p-rt_6.1.59-cip8-rt4.bb => linux-cip-rt_6.1.64-cip10-rt5.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.59-cip8-rt4.bb => linux-cip-rt_6.1.64-cip10-rt5.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.59-cip8-rt4.bb b/recipes-kernel/linux/linux-cip-rt_6.1.64-cip10-rt5.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.59-cip8-rt4.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.64-cip10-rt5.bb
index 6385b023..d5285c27 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.59-cip8-rt4.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.64-cip10-rt5.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "8c8a68cf3bcbd6fcb126fbf9ec2c70dc125cbde9de5d864c0c36195449354f59"
+SRC_URI[sha256sum] = "9dfe41c5975565094399798d715bf0c246b318348b600c480eaeb87f0668cc39"
-- 
2.35.3

