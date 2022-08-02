Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08078C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 20:21:09 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.85])
 by mx.groups.io with SMTP id smtpd.web11.349.1659471665226639879
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 13:21:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sGw2FOC3;
 spf=pass (domain: siemens.com, ip: 40.107.22.85,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNqmAMS4dUxUPyBpoSTXTsuQk9dtUvNP8BFR1FuI8s5Gvdo5CBHNkkMDUQh7eoidk83P7sje2Yv5Rzx0mGK8L43BOqXJZlPPcGpK2Tnb5KUSDKvhJj1fjP3H4AJ0Z4H2d7o1HERcQEKila2a2tveMsXXKpx8120T3RW6LY8SIo3txGckw1kbIsBPGO/wWbh6QSycctRf5CkUtjbEEethzwMlRV/IwIXL8cFWTN5H/SWACedPxSXjWloRkPLlDci+8GGY6k8B+lQjtBG/Iw6zPKw68p6a37NuJMirxGK0V0S7msiYCVw37xpNvdoy0lceVeptxZsu11q5dFG84xnYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJPH8PZ62EJ+/6ZhbiJokn1p6tn5RYXLo6+v1wisYPg=;
 b=DexBdB79VA9iaJDmqFUFcFq8/5XKBe3yo2xv04hknRjnyN+RIk/EUfkw7wolTLFe4sUmw7pIgKel9q1rivWQ5B1b4l8a+JqQ+Bt8FMUfcwbRToCXOS//CQxUNh5mFKTMn0leb/jBUeKoHAEipiED2Hq4BuPzQZf/UGnKI+OIicMa50NaW8xixpo+HvY0rHjsr47HC7k+dTbbuhy10M1HYXXxawgLXfAkmlq9US+7HWmRqO7qXqh/tuWUlI/uvKyxmD7ZzEEua9qA41zkoiPydlJQv+dk3hRQNJovH83dZ03Exz/K9iM7AQm3yPInZ5Q8K6+Nwq6lW+BjXPdNUgMhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJPH8PZ62EJ+/6ZhbiJokn1p6tn5RYXLo6+v1wisYPg=;
 b=sGw2FOC32KUXvHLIys4o7jBUWbUaZqbVG++okn9hLG+E2gn2tpoOk3XDLI3NfCbT+xwNMvl0C9UctrygKZSIZO8SkgJscQi9X+5D/jsdomtIUbz3f4tckqTNutgRGqNAplYig0yit5zNMVcbNtQtq2+A7HRz9hg841zMBPfLCfjD0VbFiPEqdQzIDygkWuir5eWp/tC6g0KfKIbrzux8+r1E1U8SNhmUQvKyw5Ly3l4oGYpJaJ6mLM/LWP+Yns9Ao3VXj9KseDNgEgrEbzE8qyAwuvFKICw9pNFmMt2DltMxJrllL06q8snvCf4KV0Eg9cckIczbwyPhPbe+/TT1hg==
Received: from DB8PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:10:110::21)
 by AS8PR10MB5041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:340::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 20:21:02 +0000
Received: from DB5EUR01FT106.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::45) by DB8PR04CA0011.outlook.office365.com
 (2603:10a6:10:110::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Tue, 2 Aug 2022 20:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT106.mail.protection.outlook.com (10.152.4.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Tue, 2 Aug 2022 20:21:01 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 22:21:01 +0200
Received: from [139.22.106.222] (139.22.106.222) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 22:21:00 +0200
Message-ID: <0d94ada8-eb64-4b72-c894-c2a87f7db01a@siemens.com>
Date: Tue, 2 Aug 2022 22:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: 4.4.302-cip70: 'struct rt5645_priv' has no member named
 'btn_check_timer'
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.222]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.876900-8.000000
X-TMASE-MatchedRID: ZpedOW41UV2h2Abh7nzIbW3Vq/WK81NvJ97RPj0PB2gSEYfcJF0pReEp
	CHUsKYYG1JVSTP0E9d4gpGmJAKdhm4rCJDCJ5NCw6cOaz1Rw6AR3GG3gHRhx115hVZTm4dD8QX5
	CVimNCmkGxrhW/sejDZ6ba/D5x6cp4vM1YF6AJbZFi+KwZZttL2YhUL5GYRbtavP8b9lJtWr6C0
	ePs7A07YVH0dq7wY7utsl1cesvX3+KG8J9kW6rJ8xa6yp+nHdhAPbZr2AF6XHbY4t+TBhyCw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.876900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 44798BB67CBD3FF75569B4D9CB4470132F41DD856FD8E3A9B3ED9138E9F05F222000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6bfbc1-5204-49be-a550-08da74c484ed
X-MS-TrafficTypeDiagnostic: AS8PR10MB5041:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+d3JFCdbfMkqpbeQ+izDpcsnCicAt2l9pa6XY0xL/9VD16iPg83ntohE9qaxpEu56wYMURR/MvDFBPYCoFU+VeFRH+KNlFsq+k1FxTPmkW9QyzCABDNNqciD/mNk5bsVOdZMwha8imgksuE8ziTPfpGREbOx9lrQu4amC4JMfp43kuR/55X3bYPHyjGlwqCmZhu+7G0JRnpx9ZYU95KNvh1r1YvJ27UKvPe78VPh8g3A6xr/7CObv0BDzrrKT9H9KFbNhh4I8nHRyiJihSELUeAzaHiHctNTnYJmbMdJX19+OkfsK1yfJXZJesgQ+VqbVnOdT4e/x/e/8srJ6IABjkoIaBFAkBJsnQN2BhgIEpP2xDiS8pM3oH0P+HD243TRd5sRCL9g8v4Wa8/5yYzv8D8OcCIwDiy14HwxK/IxaWuEWCA0iqcOF1fYzpEw6n2hq7CWg16J26crJlJxegcrfoeDzjH/AY90DM7Nn0pFB1ZJnwWVD6rlGAR0o9/oLZmNaK/69kHmp/8VsgS214pk4MVq7uMtzivmtXiJ5bM2ZD6JGAFJr0ivxwhwmDhoWzd8ZVd6T+DQ16uAsX8p4llP81lU7jMJtcbMqkrKecOjOAdJFjULrPWbUseORf+eSgMa/2cvf7gF0iBPGuhbkH9RKHct2PlJQeils9zGh2FH0vn/zynGW3bQWniQfuzdz925p4gf602LoATROaFf4vTcq1Jl9nfQ4MDBwJTB+v+yIDSXMKJfLYEuRNQWuthmN9alhYlpt7mmnELUFm3gf5IxaXRW+FkvJjVVUhbfvz3ZYjndSU+nUG7VpZF/lniPIvofw4wYtNd9OpDbnXgkGmz+eHMmxfmZkIJE9rxDlwz+/WnN+Mx1cPNNSh5STtfLf92e
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(186003)(16526019)(7596003)(82960400001)(40480700001)(7636003)(82310400005)(6706004)(31686004)(36756003)(356005)(110136005)(336012)(47076005)(16576012)(316002)(956004)(2616005)(478600001)(8936002)(4744005)(5660300002)(44832011)(2906002)(86362001)(36860700001)(82740400003)(26005)(70586007)(70206006)(40460700003)(31696002)(41300700001)(8676002)(6666004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 20:21:01.8144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dd6bfbc1-5204-49be-a550-08da74c484ed
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT106.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5041
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 20:21:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9027

Hi Pavel,

we have a build-regression in 4.4.302-cip70:

 ../sound/soc/codecs/rt5645.c: In function 'rt5645_i2c_remove':
 ../sound/soc/codecs/rt5645.c:3683:24: error: 'struct rt5645_priv' has no member named 'btn_check_timer'
  3683 |  del_timer_sync(&rt5645->btn_check_timer);
       |                        ^~
 make[6]: *** [../scripts/Makefile.build:280: sound/soc/codecs/rt5645.o] Error 1

That's related to 32ab6f27ac8264da14ff3b8dc17da1013fb5560f, a commit 
that either does not belong into 4.4 or is missing dependencies.

I guess this slipped through because the affectd driver is not in any of 
our cip configs - but it is enabled in multi_v7_defconfig...

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

