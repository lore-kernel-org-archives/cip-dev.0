Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3FC00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 20:41:49 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.78])
 by mx.groups.io with SMTP id smtpd.web09.654.1659472888116292925
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 13:41:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UgmDklZy;
 spf=pass (domain: siemens.com, ip: 40.107.5.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLn1L0PIpbEEC7wnoMkObD09q4yzh9mDs/IJDlMjgal8UHTq6dgOXzjWTrBzgH3rW5q9n9RNzvWjYXwL23QfxO+NTafJ1ZbQj8+tCiTgd6KAD+EPgQP6B9feDZGxlejRr6UFC7h3KRivD73crz3lsOcQnnhNv8HA/g7NeSboaNWICcNs7aX6PQ7NpHSKT+Q8rQ6wHoRTwDzj0/a8Vs+OUfwcNbNVjZ/Cjt+ELuA5bRGrZIpGeLhOS6RK7q/Y7cZ9UtmvWUKiXrPh5MDFFapN6PRXFYFBisb7dgJWLc/kku5AvGfLWeLcbnEqgh3Rq9105TzD/jf1F3Yvx6cab2y9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xm6veh0K9vJf7pllfk87PnhNpKasB9mvA0IHQm+CRrI=;
 b=lSV6Q2ck8q7gkk6r5+tdosNxgCAZyqaRGo8ocA47WmW2Uk+PnEBIGMTcLdib0RE/Gsk5xXmdHJERCGwH1GC+RxzIm6jLJ3kONDAXmL+MIlN95JOTWyOaOGi+XS9kwkTi/lDvs87m+t0S46qnFlUnhpI1j5MEBF92C3N3Be71Y3CRQ1T8coHFOB8cKt//jms6STIi66HaVLG8Xng3jMRZY66TdkKaz1uuDwNaStzhdOEqYCEQES7NsqP/cA9kod3wabtjY6aPUXNc6aTnx/WJXnuVeFH4xTfgZpY5D9BXvoNoTsyAx69H2cCZf9tgXLn7FQUDMhhheLXzpP3lj/rs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xm6veh0K9vJf7pllfk87PnhNpKasB9mvA0IHQm+CRrI=;
 b=UgmDklZyED4h3cl08yDlMZTpBP3R8td01N0jojWrdQhG366N9PGZVsuOO1A0MFWCloMaU/IU5IQ99MNliUkGE4sF3y4J00O0f3rjpLYaDvuJ9kJLePrOfc9BO3HkV4bD258WsCNfKRgATiuN58WSSiKCiQxB3ShqMj7VEIXipxXnMjcAF7EBlr5LPg3xIyp3fcyqr7T5GceQzDD0FERipbv+Mppadz614v9f64snecSuAsLRoAhDLff2GR8sIHh+sKW+HK10XeDUtwP+JaRgzWaTtQPhOh6kZAqJsU8hYS77PdD32x44mt+h5olE5IGZdEf6t+7DbgXhNHnvAnOXCg==
Received: from OL1P279CA0070.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::21)
 by VE1PR10MB3773.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:148::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 20:41:24 +0000
Received: from HE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::5) by OL1P279CA0070.outlook.office365.com
 (2603:10a6:e10:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Tue, 2 Aug 2022 20:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT032.mail.protection.outlook.com (10.152.0.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Tue, 2 Aug 2022 20:41:23 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 22:41:23 +0200
Received: from [139.22.106.222] (139.22.106.222) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 22:41:22 +0200
Message-ID: <ed1abfd6-0bd2-c266-53bb-bfb17f51eaf4@siemens.com>
Date: Tue, 2 Aug 2022 22:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4.4-cip] Revert "ASoC: rt5645: Fix errorenous cleanup order"
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>, Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.222]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.393500-8.000000
X-TMASE-MatchedRID: bhFb7UFEN/fID8BjC3mwTL1Euivo0hwLKx2x0HdtdQE/ApMPW/xhXkyQ
	5fRSh265ioV4hcayuv1+Dha0AlenCfSKgHVDxJG76DD2zdKSt+0t1HmDlgaHMiNHByyOpYYCw5Q
	1lEuSkDeBbptjxI6rdaPFjJEFr+olA9Mriq0CDAgQVjqAOZ5cjQtuKBGekqUpIG4YlbCDECvS3R
	xy14J4N5mx0hiTmFZl5UbfbXfCCffxbSGtuy9QT3x5HeR2t8rRsBTJSD2iAW0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.393500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 71FB0E07939238459BCCAA90443DEE6B8061326CC4AE3B943B327E48955D1D412000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63c42740-32b9-4532-359b-08da74c75d32
X-MS-TrafficTypeDiagnostic: VE1PR10MB3773:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KcCDSkGrqt/4AUx3oGlQUrH5yeGCS44uG2N3yv70kRh1G48b82Xx7pxeurpDg4W3jUsuIvTPbegdAd4FhK5glZL8KXPuf/LrBh82iZZtaBCBJIWEb9tt59oKBOKKU5yKnh7uUZPBYXPj3GXt41HhOAide1KaGLcASYDsnHvC1jNC6u9uQN29yK5RFECnCk9zJNGusO+1kCdHUpXgHsqckD/v1AVYEzzsJfs41EutMPh0Tzyr0MMEUbzHvm1ifq5KtpMve04fefvw0uu6wIVIHrEuitEUfPnFCuQmJEeEdmt/36GQJWftxf9Q8T8m/u5bT5wD6/ZyVJNP8QDEw2AwGNpeOQPRlV5lc2TsjANaqop4hyzhz/kpj+otuAwHtvxtgDLdEYkxlfOoT+l1UBjEFAjvebVaAD+/qAbXAdyYvyax30NhLTYzaGe8s3m0LV0hTiuwwmw9dbFylVqUKJtIATaVdiNXlDgklXs2zOqNF4EvVD36V0B1Nqn76dFOoi5b6yC+Vpyjj1YPIShnKzX+eDHmsbGSJLKi84qPNE10G/QlkQqDleBrnqMjGNrpDtnt3ZHj1hufpLPYn/ERJQg9BPXM1Pm3N3NeULJshAevdOUBPHmV/CYOa1R4FfpDOpYQ+1FSjNkLJc9wBpa8nLHe0RDDucyl5tkoQ3FU8b7Zy4gV3XIgGf30nstXnT8JmnU1EGPfyyDPisX4z6npRBTPZQtdvpiq4nRF3SgWd1VgCJsLiOqzj7y+uRl857Wp63zwEcnFprA7DgahceJKQ1onyvU5JILDaTd+QdAQP0vovlXIg/M4MI4BVEpDgUMhXTWlOpWeiyb3He4Umc9mIEOxvjAFKKAuB9AKfk0V6XjhMvHiTASPnzpJVcZkPbwRspcq
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(40470700004)(36840700001)(83380400001)(44832011)(4744005)(956004)(336012)(47076005)(2616005)(36860700001)(186003)(16526019)(70586007)(36756003)(2906002)(5660300002)(70206006)(8676002)(8936002)(31686004)(40480700001)(82310400005)(16576012)(478600001)(110136005)(6706004)(31696002)(41300700001)(26005)(82740400003)(40460700003)(86362001)(316002)(7636003)(7596003)(356005)(82960400001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 20:41:23.6294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 63c42740-32b9-4532-359b-08da74c75d32
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3773
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 20:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9030

From: Jan Kiszka <jan.kiszka@siemens.com>

This reverts commit 32ab6f27ac8264da14ff3b8dc17da1013fb5560f.

Misplaced in 4.4 because there is no btn_check_timer in this kernel.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 sound/soc/codecs/rt5645.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 15bc81ffcf45..b74840b5becf 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3676,12 +3676,6 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5645);
 
-	/*
-	 * Since the rt5645_btn_check_callback() can queue jack_detect_work,
-	 * the timer need to be delted first
-	 */
-	del_timer_sync(&rt5645->btn_check_timer);
-
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
-- 
2.35.3

