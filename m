Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA70C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 16:18:12 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.77])
 by mx.groups.io with SMTP id smtpd.web08.14769.1654618687992218925
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 09:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ULpGrEXZ;
 spf=pass (domain: siemens.com, ip: 40.107.6.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/n+e8W9FlLxKWDreDrnVM2NximgqnxL/fOS85IEqASPRpRGDGCNEAOy4XiUw47hcS/agHQP8jKoMa/LvA7YnGbN/IfBywlOOqAeE/bbMV9frE4vH8dCLfG0wJ7T2Ov2PeV+67IiTNh3Ap5VuAyqURpFa08idh9PYnyfNG6v2yKzOOaim61ot2AYw1nt6d7xYaxwzhGzdDbqMovSq+2uC4Y+v4YO4GbOPWiDGCnY/nlQCDJtu0k4SRBDd7xw5VjhPggwpRBs2uZCE1fkObZyRLHnwPPqjwsex8p1f+pi95rRuFYrXSd44eD2TEJDbNQ7aPQAsholak9OMasmNTjbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YUbyxn4SRf+FsGuYeOD1xXJpnRajVdmYEbhRJ38zd8=;
 b=NUxWw1QD5n+zqIYluAzEF74gVKUeh9H97Mmskdd5FT/Ruo7r26NUL+U9B4bxT9KY8dpgYOv0Q4W8vnJmsCczpS0lmIYXBwtgZEhLisHar6A5EqWfojmCTQ+uCn5v1ncBDf3XWn0OoaTN2DFFfx3FgoDn9vzvHcykM9Mg+Jxyoa9qSogj9c38tC4SnbyY3UrbPoJsp3st3XVVrZqOQOvJFBBbC0nCASuRgc2HrIP3NcAKpoTxPRErN+ppaXe8mg5PMva5DwSDzfaMDnh1gZrq3Q12x05i52DRFZAwZBAulm/6X0gtruB56ekd4UJFOdfc99fidpob25HpMLwizZkJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YUbyxn4SRf+FsGuYeOD1xXJpnRajVdmYEbhRJ38zd8=;
 b=ULpGrEXZqBI2mJvroTuIWVofhxgACWpAsZB1EbiIB3ncdFGFRwoWyUznl/AfEOs8rAC1yJI6b8o+hvrLF6t/CL5Ggacbl+eBUIBnCrFfKOnw6S3vAQg0AOpmdP+l+IokDNp0pXU+aA0ECri9S16vF4uCqqEqnmH+5CrB/mOLFmVmqX/nAOZl6dCnaG6y4L/TNpCnYr8w72Wn6IauXNP9AxXWyw3iSg9p8SDWIMQSqqOIdzrZBLRSHEcL/A0g0Y5D+0ehBW++xqsjLXUzWoF3uBWbgcmnEeDtsnkttsjpnWQ8TZh+5mqd1OIgGrT8xvoTVFEsbIbXGeupspzVKWlnbQ==
Received: from DU2P251CA0013.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::17)
 by AM6PR10MB2360.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 16:18:05 +0000
Received: from DB5EUR01FT039.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::6e) by DU2P251CA0013.outlook.office365.com
 (2603:10a6:10:230::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Tue, 7 Jun 2022 16:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT039.mail.protection.outlook.com (10.152.5.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 16:18:04 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 18:18:04 +0200
Received: from [139.22.142.213] (139.22.142.213) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 18:18:04 +0200
Message-ID: <f8d994c9-6b47-e89c-e8b0-bd873deef763@siemens.com>
Date: Tue, 7 Jun 2022 18:18:03 +0200
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
 <09fe54b6-73e2-66f5-a918-82e45e21b338@siemens.com>
In-Reply-To: <09fe54b6-73e2-66f5-a918-82e45e21b338@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.213]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.571100-8.000000
X-TMASE-MatchedRID: 0sa3XW9m2I3dDS6etHbe28U8jBVxKY1xPg9yfk4YC0bM1jffIgQXhuky
	95siDkZPfhcIM0AFu8DZTAEszxrPVLMvzGqxhbHA9ac+TfuB306klkQsTfdVClIWq0PbCp4xkos
	2tunL8DQGmHr1eMxt2UAc6DyoS2rIo5C9bTTxaUZYdYUDGltcL9K59TYQRtphqoeab9Xgz88Cn5
	QffvZFlYAjsy+r+wvnTx7y4qsCFyh8o7wG+qHTkHLTdpHkJeXELFD07/Dk8EYgCPGiZqtI8N8h+
	E5Uefev3vXRyr8nehpnyyhFu6pbB+y/Hj3i0VQKv/9UIaiB4/MMs9gdWbQAx6JVTu7sjgg1rXku
	ON8pnlGUAUfla+IhaLKXWmEvaG3ElyyR46PvItO2qNGaLuHnvk1+zyfzlN7ygxsfzkNRlfKx5am
	WK2anSPoLR4+zsDTtviI7BBDiM2LGI96Q5tzRkde5F8U4xz6elFp05QkwZDlBmlGqnbY0Dg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.571100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 A58ACD161F9D198189B5197683F5E8D1FEC57E205F69661B636D052B50CBFE082000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0be4a53c-3b5e-40c0-3939-08da48a14d43
X-MS-TrafficTypeDiagnostic: AM6PR10MB2360:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB236037C34A63E4D241CBA1D195A59@AM6PR10MB2360.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xzbSHUHi3TTNOQjWmy1Toa1JexvRjYdkgogiLBhwShE7/Frik2M86GS+5ighk1PmlmnWN3SP2NRdbGEmH9j4iuNq/sb7PIJxg3WBFgm/Peo4OuqlEFWdAyYN7wul9wgujJSGBzsWDSYjX9abCEbcqeVHxnytIPLn7bOnvcAbEiIa4KefkPJzhjEF7SORu5doU2jpcbDdcEw9Tg9vtEU3s9AS1T5gPgDcEJP73+HWb1qPknvP2/0dVwAvAL6vSs+5rkQvkmVDFjXvR1Fh0lzut2co+UNH14hiCl77goem8NoeV+NDdPobiqBV+wh0jCAXoBVJp/vvNUlu5xSNVlS/3TrbBxKlzEYn8/qmkFeKS/I6ddZnLVhCHdVbgceJwHBvwEvN0dhNpZchT4/iqG5FJWgPrd5E5kBig0XNoPsZHiuIYN5EvCT18zMIASqbymootPAR9ZzKeNZmSVjzDhRR+EvR5Lftv2yMQQtBtcS08ZYzIb/rkeSI6TwTRQt0EAQk5a/8K409btVzTuSXMSg2rJjk4MxGEJiuf8qGPLYGoLSxg2V7RarqwIOwk6vGhKPJhfBbwzg4FQbA2mQN0XfcVaq7hUjmkiOdb/wCkeF2Z3mPdU4X/N0z1lTYv4AhFBbqhCQHJrRAUxDZ2uIcZ9RjbF59ykwPFXlgzzD4pEh5iih5hY3kZUl8tU+yGGJA0JOx8EGdRN83+K9O9HIhxPaj6FlanGaHyYSXrCK0H76wsxQ/vWNXMzu+12chAMM/eSc8qf5w/NNLwM5Cv7VGnltLI2ml6S5o0d7YVE4uQ4WFCuJoGt70++9qsZ/xhGCMkAwhmz95VhGL1NC6LtTIFSS1cc32g8l0xhKbLW7+Mlfk+ls=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(2616005)(82310400005)(36860700001)(44832011)(8676002)(70586007)(26005)(53546011)(966005)(5660300002)(508600001)(2906002)(956004)(81166007)(86362001)(40460700003)(82960400001)(8936002)(356005)(16526019)(31696002)(47076005)(316002)(31686004)(16576012)(186003)(83380400001)(336012)(6706004)(36756003)(110136005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 16:18:04.8751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0be4a53c-3b5e-40c0-3939-08da48a14d43
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT039.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2360
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 16:18:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8516

On 07.06.22 18:14, Jan Kiszka wrote:
> On 07.06.22 17:52, Jan Kiszka wrote:
>> On 07.06.22 17:23, Kanagarajan, Vijaikumar wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: 07 June 2022 20:46
>>>> To: Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan@mentor.com>;
>>>> quirin.gylstorff@siemens.com; cip-dev@lists.cip-project.org
>>>> Subject: Re: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
>>>>
>>>> On 07.06.22 15:50, Vijai Kumar K wrote:
>>>>> Fixes the following error during cross-build.
>>>>>
>>>>> Makefile:207: *** running tests on cross-compile build not supported.
>>>> Stop.
>>>>>
>>>>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>>>>> ---
>>>>>  recipes-core/ltp/files/debian/rules | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/recipes-core/ltp/files/debian/rules
>>>>> b/recipes-core/ltp/files/debian/rules
>>>>> index a485615..06b9070 100755
>>>>> --- a/recipes-core/ltp/files/debian/rules
>>>>> +++ b/recipes-core/ltp/files/debian/rules
>>>>> @@ -8,3 +8,5 @@ LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
>>>>>
>>>>>  override_dh_auto_configure:
>>>>>  	dh_auto_configure -- $(LTP_CONFIGURE_FLAGS)
>>>>> +
>>>>> +override_dh_auto_test:
>>>>
>>>> Was that already the case with the previous version? If not, this should
>>>> probably be moved the front of the series, right?
>>>
>>> The previous version did not build successfully. The build was broken.
>>> Since I was upreving, I did not dig much on why it failed.
>>>
>>
>> OK, then we can keep the ordering.
>>
> 
> Hmm, just realized that we are not testing this recipe in CI. We should
> probably enable kas/opt/test.yml for some representative target(s) to
> close this gap.
> 

Err, no, we are building that ("extension: test", see e.g.
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/2554473964). Now
I'm confused, specifically as I've seen build issues locally as well.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

