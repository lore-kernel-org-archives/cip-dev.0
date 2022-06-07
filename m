Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2079CC43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 15:52:32 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.73])
 by mx.groups.io with SMTP id smtpd.web09.14226.1654617144528102078
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 08:52:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HSkSNa+R;
 spf=pass (domain: siemens.com, ip: 40.107.15.73,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsFUtHt6dmQsqllDzhqJWKzQ+XCf4OMslcxikBNRntIXpfssKtq2cUw0Wfy0+Cyic8vvAtDgNyrv5TOoAVBcCg2wKOQolBmqjyhUpGt+97wUtR2b+enQ1PED0wEqK8oQVbfBQ5OFOGIhAfjCtoFBXc++o48r7ffjGXS0b7ilEwfMFWoVsjtsD/dPpdXp2QuViHUrxST9KS3NXOIFXjvj2eQVAL680QZw7CdX+JgWIK2WKFhOaw2B1hWrwJDz/VbXyWIJcnQ1UT8TuiOWFMvf/25D0Yb9mPiRDe+g4XWPO2xuWVlYfGTUnaWXuEcE7/4rKGufu94u/xYNaVT9S/5cYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnX2OW1m5JlsNEmG68hsdtiQtUIfuJHVHJOzW7jDiq4=;
 b=OZUnqWX2Mv1eP5rXxejklnH0LllHCR4Qs5TuXae8HEc714HCAQbpFMXqgmWGCOvKaP1qn99SKcQNg/ocVBLJX+7MJU4SbFLwq1cytvYSHhM4YIstDuCpKNHDTgS+bpYXtM3mmtpKm5NTZCQi8FqqfZRawnhWEiamg4HebFA2A5NpsWPDMBcLypre59h/qN0oxVJcmdfSXceLOkmFFN/wIoM+9ocRX0u7b5FsxiHAy/+/Jr+lSbVhAKHI3B7EfJHYR5K+beQHHPvSG5Re1JewIWAjaF7MzMkMd7ETIH399h2twzXZE5gJLcSvbbL5vE32PkVnTje7iiUdowJn5wqkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnX2OW1m5JlsNEmG68hsdtiQtUIfuJHVHJOzW7jDiq4=;
 b=HSkSNa+RdkNlqDaO8LdFeJ+W+RbBwOvXZt93yQx10WIpLZp9hmaaSb9jjNYojjLUJhd6AnyFtohHMZ02XSLb1ok9yaoI4j53linIIw2yHGCd7mPZ92WEkV5PtkOqUg4VSNuklWgqpv8OJ4B+xnCmYwxp5JAJceXK6o+iv+r8WmSYdge2o2cR1B1hULsqKBERoU7mCyj9uuottwLmUtrdYMWnNCusiMfGz4aPAUhDr6pvVxNoGwSWNApX+OhGuvqFdQgb3FxkYEYjoBAvt7Jfvc7E6NiCJdgpxWF2ty8VkcIc0tZHSkxfoI8v8HDA0UUpi8kerIK7Hs76+WHz9By9RA==
Received: from AM6PR08CA0016.eurprd08.prod.outlook.com (2603:10a6:20b:b2::28)
 by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 15:52:21 +0000
Received: from VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:b2:cafe::48) by AM6PR08CA0016.outlook.office365.com
 (2603:10a6:20b:b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 15:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT026.mail.protection.outlook.com (10.152.2.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 15:52:20 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 17:52:20 +0200
Received: from [139.22.142.213] (139.22.142.213) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 17:52:19 +0200
Message-ID: <1e74163c-3e62-f15c-9710-9b29f876782d@siemens.com>
Date: Tue, 7 Jun 2022 17:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Content-Language: en-US
To: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
 <20220607135016.1856603-4-Vijaikumar_Kanagarajan@mentor.com>
 <ba27551b-f111-2cad-f479-0e734e4814a8@siemens.com>
 <d29949d0f6024531a8fe01299f8a25f0@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <d29949d0f6024531a8fe01299f8a25f0@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.213]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.639400-8.000000
X-TMASE-MatchedRID: kxpaLTp5p67dDS6etHbe28U8jBVxKY1xPg9yfk4YC0bM1jffIgQXhuky
	95siDkZPfhcIM0AFu8DZTAEszxrPVLMvzGqxhbHA9ac+TfuB306klkQsTfdVClIWq0PbCp4xkos
	2tunL8DQGmHr1eMxt2UAc6DyoS2rIo5C9bTTxaUZYdYUDGltcL9K59TYQRtphqoeab9Xgz88Cn5
	QffvZFlYAjsy+r+wvnTx7y4qsCFyh8o7wG+qHTkKdMya3b6yFKle+q6k7Q/cwvzLls7HTfGctDH
	w9RrCNbmyiLZetSf8nJ4y0wP1A6AAYnglAWdCYbt7DW3B48kkHdB/CxWTRRu25FeHtsUoHu7iDR
	LV7SWJEPfki+C+6DkIUPwjrt9WQg2r1c+T7GX9qUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.639400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 536EB035E153D2F2A982F424E6178D8512982A4D6074C79ADC0A7AE636FCD3322000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985d3b94-15a8-4213-47f0-08da489db4fb
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_
X-Microsoft-Antispam-PRVS: 
	<AM7PR10MB39561D5ABB2BACE4B21268D995A59@AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZThLIlkU1B//3QtcxNUda2IAjPonEJNdgSgZWD7iI0HqH8Jo2vxJ85ePo8A4cXEDBTA6+YyhycGOngjNmButKWxplRiwLb3NSeIouTKPgNzbYQcG5PC0+36tkG51Jnig/E8jxK8yxYAOpNYeK1aofpiR/tSKVcs2f879/ItCmfDir+YZB/2FMGVhREty9qhkHPo5HIgU0qDbTSSr3sMTyN812Vi4Y4OAXwKRScrlR/cikRQr04ju3r2Y9fU5184V/dahGQOp4pPcraU4N9XjHNlDwrS2NwbtgiJDwJD46JtQH/6Hnu6tnhENYGLJDL3Fd5RNscY3AAfFBKrokgLBn4yWcdbLQ13GSz5qbNY9jeydqylOWg01M0mkCsnJppiTEPHUqlnNTQTG9896HJcUnDj2spA70fqUvjJ5Z8uSEaFHKXAycMLTOnfUQ7NiAOir1gjVThjLZH/Ufmd4eftrBtKSecVoi+tEJfy3iUI+m5rehQcFs5RZRUWaqFKEFrca1HDYLaXWnCQr/hAgSb0I3lmQRwm/kgo5Bj6wFzkubR2A5+rpTtmnIue/Q+SJ7fLF2qC2NctFabvPBzHfnddD3KXm4RWuIRCyk0z2mXvJVxR6Zd1gqV/aRnFZuuV/8A+eF4oypJ/x6f7M5z+O7LQ9kr1sFmULFHYR7U6ULGW4Wl4GTdxU43s1bnvnlOGju2od7/KoASCkiq9Uupvvpf6X74DT7cy/xErANPHBy/44wfQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(8676002)(44832011)(47076005)(83380400001)(86362001)(336012)(110136005)(6706004)(16576012)(53546011)(36756003)(2906002)(82960400001)(70206006)(70586007)(356005)(31696002)(508600001)(2616005)(7636003)(7596003)(5660300002)(956004)(82310400005)(316002)(36860700001)(16526019)(40460700003)(26005)(186003)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 15:52:20.9153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 985d3b94-15a8-4213-47f0-08da489db4fb
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3956
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 15:52:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8514

On 07.06.22 17:23, Kanagarajan, Vijaikumar wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 07 June 2022 20:46
>> To: Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan@mentor.com>;
>> quirin.gylstorff@siemens.com; cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
>>
>> On 07.06.22 15:50, Vijai Kumar K wrote:
>>> Fixes the following error during cross-build.
>>>
>>> Makefile:207: *** running tests on cross-compile build not supported.
>> Stop.
>>>
>>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>>> ---
>>>  recipes-core/ltp/files/debian/rules | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/recipes-core/ltp/files/debian/rules
>>> b/recipes-core/ltp/files/debian/rules
>>> index a485615..06b9070 100755
>>> --- a/recipes-core/ltp/files/debian/rules
>>> +++ b/recipes-core/ltp/files/debian/rules
>>> @@ -8,3 +8,5 @@ LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
>>>
>>>  override_dh_auto_configure:
>>>  	dh_auto_configure -- $(LTP_CONFIGURE_FLAGS)
>>> +
>>> +override_dh_auto_test:
>>
>> Was that already the case with the previous version? If not, this should
>> probably be moved the front of the series, right?
> 
> The previous version did not build successfully. The build was broken.
> Since I was upreving, I did not dig much on why it failed.
> 

OK, then we can keep the ordering.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

