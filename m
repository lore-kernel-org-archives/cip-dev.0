Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D0C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 16:14:22 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web10.14357.1654618454897396858
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 09:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QJYpOm0/;
 spf=pass (domain: siemens.com, ip: 40.107.20.61,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmrfd09wR+rtwBlbsxXfEIJJbtdyQu+4UIFJfh1EMb+Ri5fna+9NNtsEKLSIr//WgHWgg+H9ibn5vazuwFPupgEmaM7q7dFLX/LBP7d3KGfBnvVkE3B8ZieKuKI21ah4z6+AI8zsRizzY+Slfaaew6qniIw4cQRUwfROyNwxpXWLugwN4gAaakm4M5V5476QstxrGH+MnciS41uaPmK/Va8vuZjqskl0yg1Fq70BfEvT7xtlXwYG5MEqG51xxwe/QS3SbXTUOGJZaAxYEWKwxEYAlLHQuzPtefJN85r/6gtvLUjXERsEHiD4DlA2vcWWuQzc5zwMihTjribPBdPAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j25IjW18yTRhNUwJ8UcvDgpf9SXElpigrU0Eo2GaCug=;
 b=X21139cIRDx/Unh/laMHSFFVSW4sHnE6L0VrJCybBWG6ftHsP6Ykg6TG8FNMq/Q4D/I+fixJK8v18yjCT3BiIR8dKyQvPsX44De7XvuwILb7FtG10HYPDllZ1CoEj2Dc+83TmUPTsQBdrsvISEeLQwvj0n8SHKWf3Dxrub9xNjkbVxsUnZINH6oE86HogAAeCZSDve7Vg1nYPcyylMIJ/CFCiQb8DYfkmWGpXhBzYlD1a9ulp+BPKD9zdCUUWjyZkytg5OiYjj3CaYFFpS6WPx+USUuyceGgbAe1A/AiixZPD1UWrrJd6Dq81Sj4lXrmYyiKMDYNG2X6/c6uNhDh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j25IjW18yTRhNUwJ8UcvDgpf9SXElpigrU0Eo2GaCug=;
 b=QJYpOm0/wu7Y8T2c/6RIlqHbf91716LGxPAe3+EYdXiaxfZ4FTipZBzwJNhtb3Gbx30ReGg7FzoYWARxxhEhEpdY54ReNPCG9Nygg5PBQvN6yrmy7Qif8uV926xGqsAXaZMnLI6XtMEoR5E8fjDfWMicj7eNNdLUmDhYY+DkTQtOooB3NAPQvvSbzh5wWHJ+hu34dv+XthKRdPDkWY8f0WACW4e2LMFdDdyNd109sO7Qmorjm3SlyxwuWiO4G7Z9NGdReiod1oyu47/RWvdcJIyJ96QdNDwtsOvaZ+1PbvqNQrTt4s+o+nOZRjdpju2Ltxxi1nNc6kL9C5MZjMzpig==
Received: from DB6PR0301CA0032.eurprd03.prod.outlook.com (2603:10a6:4:3e::42)
 by AS8PR10MB6246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 16:14:12 +0000
Received: from DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::6e) by DB6PR0301CA0032.outlook.office365.com
 (2603:10a6:4:3e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Tue, 7 Jun 2022 16:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT058.mail.protection.outlook.com (10.152.5.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 16:14:11 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 18:14:10 +0200
Received: from [139.22.142.213] (139.22.142.213) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 18:14:10 +0200
Message-ID: <09fe54b6-73e2-66f5-a918-82e45e21b338@siemens.com>
Date: Tue, 7 Jun 2022 18:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
 <20220607135016.1856603-4-Vijaikumar_Kanagarajan@mentor.com>
 <ba27551b-f111-2cad-f479-0e734e4814a8@siemens.com>
 <d29949d0f6024531a8fe01299f8a25f0@mentor.com>
 <1e74163c-3e62-f15c-9710-9b29f876782d@siemens.com>
In-Reply-To: <1e74163c-3e62-f15c-9710-9b29f876782d@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.213]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.267600-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKDdDS6etHbe28U8jBVxKY1xPg9yfk4YC0bM1jffIgQXhuky
	95siDkZPfhcIM0AFu8DZTAEszxrPVLMvzGqxhbHA9ac+TfuB306klkQsTfdVClIWq0PbCp4xkos
	2tunL8DQGmHr1eMxt2UAc6DyoS2rIo5C9bTTxaUZYdYUDGltcL9K59TYQRtphqoeab9Xgz88Cn5
	QffvZFlYAjsy+r+wvnTx7y4qsCFyh8o7wG+qHTkHLTdpHkJeXELFD07/Dk8EYgCPGiZqtI8N8h+
	E5Uefev3vXRyr8nehrccmmIMLVy+Svn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt1
	ofVlaoLUHQeTVDUrItRnEQCUU+jzjoczmuoPCq1F8oxkcPywBKUy2ghYiY37r8UEHsYfcEZJ/ZT
	w4AMgyPVBduLSKyyu
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.267600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 57E1D8C4F536BCD4BE36D856AF0BE53E439E6BDD73A1914EAA841C9F22DDDE062000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a036ace-25d4-47bf-447b-08da48a0c236
X-MS-TrafficTypeDiagnostic: AS8PR10MB6246:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB62465E361B345B8CDDD8135095A59@AS8PR10MB6246.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LEzCdBZUewubTl8sVQ53XW/fRwyqWivMvkaX2zHOfgcgYeDq/Gsa7uJqMKQy94WIq+/q2ruL36gtxtH67g+lUlC9yblM2QH8GB6tbJ+02tmcz4ZDBaSdAGWCBxXaYXQs7mg/jgv6Oto3uzqE7SzmFsMsb9BIqaON4bJMrz2WRBVKkCl/H8gs+jDa2Tl3QQVw4BYCW0V5Tt3sHc57KUyPYLWCDB8Y36eewmCo+jYlUC/eZidOX0QQEADXjnYdFGRZJVXxkI0nbRz09BLKuShIwFuARnh4KXwW6OSb5k7vguyFnIianjMeta704qo2YG/PWsma/swj5QuyPnhvaUu0OEwBwHFj3LaqOeYL4GYXuPIYOV7TiuxMmksaVd7Su3oWaGNQsipDJ/b1lQl6f6nBXfcPExVusqic3jSocH8Tt46dMZOEfkjqGEgoS58vnz771tjq567n8xuU7TW15/ULYCvyWxpbT2MIRzfT8CACB2CYjfWgHgM3bNZVK5u+WRV6gUM0IeBJnU+cItUhm1g87fGV3AP0jtPsSH4aSg8gWh6QLJRQtgPEdM1ejjc8tqB58oTaG8w5ohnyPC4RnnGPcAse7TsAzv1Zr826o3vkmEnQfUDRatMMDubK8Q5+6gP6HksEjIlH6O14RtO8EJVbvWuHBOuqcZL38bjH2uBM5BLCb7Dg4cYCCl/3fzvjCqoVyqFQU2555xKgTxurxVJg0gTaHnLVflIMyNKgYlt8QbA=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(316002)(16576012)(83380400001)(186003)(53546011)(110136005)(82310400005)(16526019)(26005)(6706004)(47076005)(336012)(2616005)(36756003)(508600001)(7636003)(2906002)(7596003)(956004)(31696002)(86362001)(82960400001)(356005)(36860700001)(8676002)(40460700003)(44832011)(5660300002)(31686004)(70586007)(70206006)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 16:14:11.6025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1a036ace-25d4-47bf-447b-08da48a0c236
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6246
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 16:14:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8515

On 07.06.22 17:52, Jan Kiszka wrote:
> On 07.06.22 17:23, Kanagarajan, Vijaikumar wrote:
>>
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 07 June 2022 20:46
>>> To: Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan@mentor.com>;
>>> quirin.gylstorff@siemens.com; cip-dev@lists.cip-project.org
>>> Subject: Re: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
>>>
>>> On 07.06.22 15:50, Vijai Kumar K wrote:
>>>> Fixes the following error during cross-build.
>>>>
>>>> Makefile:207: *** running tests on cross-compile build not supported.
>>> Stop.
>>>>
>>>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>>>> ---
>>>>  recipes-core/ltp/files/debian/rules | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/recipes-core/ltp/files/debian/rules
>>>> b/recipes-core/ltp/files/debian/rules
>>>> index a485615..06b9070 100755
>>>> --- a/recipes-core/ltp/files/debian/rules
>>>> +++ b/recipes-core/ltp/files/debian/rules
>>>> @@ -8,3 +8,5 @@ LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
>>>>
>>>>  override_dh_auto_configure:
>>>>  	dh_auto_configure -- $(LTP_CONFIGURE_FLAGS)
>>>> +
>>>> +override_dh_auto_test:
>>>
>>> Was that already the case with the previous version? If not, this should
>>> probably be moved the front of the series, right?
>>
>> The previous version did not build successfully. The build was broken.
>> Since I was upreving, I did not dig much on why it failed.
>>
> 
> OK, then we can keep the ordering.
> 

Hmm, just realized that we are not testing this recipe in CI. We should
probably enable kas/opt/test.yml for some representative target(s) to
close this gap.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

