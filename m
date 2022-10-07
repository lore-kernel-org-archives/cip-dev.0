Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CB1C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 12:02:54 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.74])
 by mx.groups.io with SMTP id smtpd.web10.3531.1665144157703223446
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 05:02:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P0C1yMSQ;
 spf=pass (domain: siemens.com, ip: 40.107.14.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4wB5o/Ibh7Qlxq27JWsCT2VvpXT+uoaEaEpk6bqDF8uDfQhjeh8CitugYrYIFQDVI3o0F7IxJVBJIgB5hBQXEWFtUHI5LWzGDTzfxe9UgnuZLY7f8vp+Rz6n082LuJTs9KzTf/pWEYtKK5YUfZ2JFuGorunygAT0X3wn0LHGXAj6KbnLwP/uVLHK4IhIu6x/c5o358Gas2aVYwUruIhgGGLzm+zOQ5tLopHq1eAyFarWEiM/mJy2VtBtTKcYuEccp9xuaCya2jrVwGDb1PJ9SKwY6wqgBpQC6dVUSXJEQN1eCE8NMcvmPLm/Zzb30nYCSRa/TOgPExQIRUvheHCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrexlcI0d81/PcjgQHuUd9jcqtXFwsZ7pGjVjTS6eiI=;
 b=i8Cu6bLbooipUPTZSX54Paj2otk4VoSDTyVuo1oRm6RSOvCHUc/GiFtM1uc9PuoKBMTmXV+aNePQAPzzQkqqBzGAYUh3bj2t28b/YWm0Tex8VYzyV1Cas4JP43x5zmzXvHP80yVBQnWfiab+tWpeTEMugV7gkLefoPdvwcVNVMhGQg9iRrnlxaSKywo/fBoDViWZZAwqvVx5DfQxjoBqZQiXizBN3U8PVYztzuJKL9iAIfOYG6K775bTwQdMwBzes9xTjzS17oyZc4dM49E3SLXk8f44Edv2BMkWR0EehdZg7EbntzQtLVH9NbrJqgKU1Zy7ZZ20Vuk8PLWHx9HjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrexlcI0d81/PcjgQHuUd9jcqtXFwsZ7pGjVjTS6eiI=;
 b=P0C1yMSQs9/i55jMQeJ3klfgMDZCbsvdQKuZAL+l8uxCAFgEaZ9/KCTURFnhh79cjg7yvRJ6us89j1o1KnyomfWs9b12sXSbXO4AEqgn/vetqV3pFXLQTmTAgv1AD2hzuQ6vxrU+nf9+Bsw3HXdQJdLqxycQr22ZxlhmGI1bLII7n1I7IaJqcUhFxKt62Wsr6fuPTijKEChv3bXnpNf4yyydkz6IEN85XF3GZ4BRLa6urvd0ZRsVwLfdt8Kq8OCMJpQFhqaMWS9xyY3VJJnAOn3S2lMR+DQjkm3tD5PfmGbTZ5LchwwuxoQle4yl3x3I8UU100O6dm8q3JRI2gGMQA==
Received: from GV3P280CA0084.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::17) by
 DU0PR10MB6728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.24; Fri, 7 Oct 2022 12:02:34 +0000
Received: from HE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:a:cafe::b4) by GV3P280CA0084.outlook.office365.com
 (2603:10a6:150:a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.39 via Frontend
 Transport; Fri, 7 Oct 2022 12:02:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT073.mail.protection.outlook.com (10.152.1.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 12:02:34 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 14:02:33 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 14:02:33 +0200
Message-ID: <5a3458cd-2b7c-eba2-f7a2-26e678c05a9f@siemens.com>
Date: Fri, 7 Oct 2022 14:02:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Convert misleading 'include' to 'require'
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
CC: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.646100-8.000000
X-TMASE-MatchedRID: +UrwWuR4A/LHDV+dRM+ZPRQUkzPX5sTW07HCUMKHxrFqY4ZZuxIgV5ho
	XhL48wE7eucl7MdNw8RyKMxmuvaJna3aC25avUuavWpUlhrjisbaqMoBhXwtRt0KiTeJteVBfS0
	Ip2eEHny+qryzYw2E8CKveQ4wmYdMXWPmaFoiyJsgBwKKRHe+r17AVHufQxnnWiL4jy5OGDFc5e
	6ot8cRAKljOLOXbs2XpJLvB5XdVJE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.646100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 DE123E3C085D1F2D59C4830D674DE723B8D2C2125198E40269E19D166102C0642000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT073:EE_|DU0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 57059a55-cd5c-4986-29dd-08daa85bd1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zRXVj1NNcJN6/JYWk1fV6cBXv3K0zNb7KzZhCzS/RIWsEol7wXS+jLXR9mrAlvrVjeuZq1/xhud++Exo3hxJHgLeOFuEh35Q8g2PV2uL3JrIqv1GUc9iuZcSxwbgKq3mZD7fTPwv1AnLwhlGyOG5QoNEAXPYX1m7kLHI3uVnr2Nnlaa1BFuEte36/0PxqvOZ3TPv1w8X4pCfDgBOdGlRZN+fgooVZVTG9TZ7IawyjHhnEnZXItE1xd6JIcGhdaoCUjP9QmNm55WmPttwEFKKEJzen6E7aCqUUM/kGKiMgnl0sWTgEqQtcrb5qIzplTfOIqV6Kz9u+fAoq5PhDn/gTyMnoUi/zqR242NGoWgTfa+dawVdZhTOw3MKVPqGwn8C7IA46hI0oc0KxOUeOM2EqA98N3YW6FF2k/eaOyQNvcE9ZMGcZEdxL1gXAd5+diuKC/MDSWxuQ3gfRtrSeGur6TJMek6hAYP5ud4WMyAI8I1FsIvqy8CzWd1ZPCZCcWJ1PKxyGhlK431gO1pFJbiAhjz4znZaEH/RTu7eIHGUjrl+5xU16qKi8KEOebdkdkNavocyiEu6TaDSNYyh+2JK1YRxGzvjnlwxCIi8KjaLkMxQQ274kShl9iTWsos6mLR9jFe7Ty0WjlzjI4GX8+LALqmfs0aUaGpGYb5cwtB87x6a83HIm2/DyEo/i3Z83eiofDfHBeGsbQ8t03gS7eRkOc5P7TvCd23OFlF9pQsUvFx4mpd0X7zbcF196D42XS0yYKW/gWWmgEBZRpqXUZ2x4Cs8IYfIWynzho2quNHCyx0trXVyzne7Xlak9Kqc35PxY9yaikwSdDE4igFFcIQMgA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(82960400001)(40460700003)(31696002)(7636003)(356005)(7596003)(26005)(70206006)(86362001)(8936002)(41300700001)(2616005)(956004)(8676002)(82740400003)(4326008)(70586007)(478600001)(316002)(16576012)(6666004)(107886003)(6916009)(2906002)(36860700001)(5660300002)(336012)(186003)(16526019)(47076005)(44832011)(6706004)(31686004)(40480700001)(83380400001)(82310400005)(36756003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 12:02:34.0888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 57059a55-cd5c-4986-29dd-08daa85bd1d1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6728
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 12:02:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9688

From: Jan Kiszka <jan.kiszka@siemens.com>

Both recipes actually require the includes (if non-empty), so use the
right statement.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/cip-core-image.bb                  | 2 +-
 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 3f8c3202..0ec72208 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -17,4 +17,4 @@ DESCRIPTION = "CIP Core image"
 IMAGE_INSTALL += "customizations"
 
 CIP_IMAGE_OPTIONS ?= ""
-include ${CIP_IMAGE_OPTIONS}
+require ${CIP_IMAGE_OPTIONS}
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 086911b9..7bcf015c 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -10,7 +10,7 @@
 
 inherit dpkg-gbp
 
-include swupdate.inc
+require swupdate.inc
 
 SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
 SRCREV ="344548c816b555c58ec199f31e45703897d23fb5"
-- 
2.35.3

