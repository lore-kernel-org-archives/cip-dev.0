Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E6AC35280
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:38 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.87])
 by mx.groups.io with SMTP id smtpd.web08.726.1649700514766255849
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 11:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NnAFnuaa;
 spf=pass (domain: siemens.com, ip: 40.107.5.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFQNuPECx6UMgFxslxg07ca+7LdqgPIqWn8l7wYSnmU75QBTTtOsawYNsaiUq8Sn4DhW7QDKibSX+q1CB86jo2zkPhWTshTj83ljckLvZknSKYfA1Ko/0RJ8c56oXiNwGHiGJxEeYOjFxgQWQbojDDfpyIOUYOIjLnroD53a+NkNf2xXJhvudkNJZCTInHBNxePKJ6ILjpQ72i/6luCRb1rOFESAeEF7riJCWb8wrgZClJ/n8SyvVuipQn19rAg2f+R7ZVzs7S/vgIt50Z2OLTSp/Pjj8r3+hK9d6OiVqcXFWgSxvYfVo6PR98aupTU8LA2EwOgWcd0B0I0vSTxP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHEYBiwY8yCc5FX3GUiLXNenLV/c3DhVqEXPonhhHX0=;
 b=F+imPTMvPStA5DOwFYFiepsQ85WMbaYICDxg1egE8M6M952TgwqY9/SG1jt16fJLTl4L3LSiqEXCjM2BgPTpI/3TPXTuWFboRzHKNpo8H9dQ3EUZhFZ15+duQArXco3HUHFtwXombpWX50sZp8C3puZ7ZRyb4kITgf8tR+g9PZbBxhdwv7LBZs0Th+Mbm2hsM5a8qmTOwZMUszuWj2qyncYLrD1Rhp9XoLzNwNkGxjfI/HY/T1pcMrZudP1+ETKHTQSD7vFxl5Jt5negJrjwzD46OjX1/vSRWTgfhqxLA49BkejASDmt79pc4s/PwIRtvW4iGDywV+exArMggB3Uog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHEYBiwY8yCc5FX3GUiLXNenLV/c3DhVqEXPonhhHX0=;
 b=NnAFnuaa1EfSDSMv0AYRrApWKTndj+JW/xR52c/RraUyeaBo69aEq4vL/Tc1OVSq7DSkuLbxU/kr0aa2EBp9s1pSkuMLEoeyTj4/gBtI3QxmBZS6cu5xv2ofd3OX/HsbostVXl08j3UFVo1rGDzoPycerf3dvomkYkmt9kmPyw2DsCU4ce7V2GuozpToYTHY8aADmN0a9/fCbJpXsgQ8qG+rwUd6XCPHk7CQ0uOVXXaFkXEeUx48h8zEJNX+JWuQPwXd0OoSRQXfOspLdPooDZpVn9Uyf85oFhhJfcS1jkCqXaLpiDTmFO5/QpXdT/qwYFsoJ1xSi7pcPLLXkApmKA==
Received: from DB6P192CA0001.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::11) by
 DB6PR10MB1782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.25; Mon, 11 Apr 2022 18:08:31 +0000
Received: from DB5EUR01FT107.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::8a) by DB6P192CA0001.outlook.office365.com
 (2603:10a6:4:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 18:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT107.mail.protection.outlook.com (10.152.5.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 18:08:30 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 20:08:30 +0200
Received: from [167.87.0.22] (167.87.0.22) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 20:08:29 +0200
Message-ID: <257197f9-3563-b5dc-2eaf-dfb002e3acd5@siemens.com>
Date: Mon, 11 Apr 2022 20:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: cip runner offline?
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>, "Adler, Michael (CT RDA IOT
 SES-DE)" <michael.adler@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <29265285-2084-12a6-4cb9-1b7a31d14a47@siemens.com>
 <OSZPR01MB687760863E6FD8E921C9B80CB7EA9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB687760863E6FD8E921C9B80CB7EA9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.22]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--20.555200-8.000000
X-TMASE-MatchedRID: 72nS2hokiaQ5QaOxwNGfvo9bHfxDWoibjQCnv157N4qdVNZaI2n6/1tX
	gpRlmDcoa067Gx0cFDQaZW50SGemhMUKZFvJm5zfuEw8uS25vrcCfzlsDCyVv1eHt48m1CvPKVR
	M3I8+7ki2HpC95B+yo7gZ+7EzWJ94QOOLVXP+lL2CbcjkMBtk6QK2MOxy7HCGKpEngz2rs6+RgL
	euORRdEoZw/Dt048JmYG32ZLukpVN6ipWzVkuu8DN360kR9zHUFfViMFFmQDLdCok3ibXlQX0tC
	KdnhB58vqq8s2MNhPCy5/tFZu9S3Ku6xVHLhqfxvECLuM+h4RB+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.555200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 803D0CB833FBCD28A399C84F65199579D56F00A95B7EF8D0C7B0286A4C94DCA92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c15ea28a-1d9e-4c22-050a-08da1be6491d
X-MS-TrafficTypeDiagnostic: DB6PR10MB1782:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR10MB178202AF4C5EB8E54A2A9A9D95EA9@DB6PR10MB1782.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ODmeuwS0MrgZ1NaIDHVQRCdhk+oLdNIcKuD3hYUxUnpoEt3xb01oQ5rJxb2cnrrgTYtvGc7ELCTHu6jGWVJgH4UYNQF4ioUitKSDLqwTLCC+MhusTmu8i61Fk1eOaoub1SXkYGMcA10mLsxpC1pEbSJKkvpiB8olhN1oNBswYlzsgwAi1LvlV+zX+t5+oGuRdOOmxYIpiuNhd3UKONkDdyic46H/PXUPKOW69Qcwi7PI8tO/wHbymIzYqvDLnDE/SCLwal4MAKU6UygqCHH8rabaZv/oeh+6CU5B2tjFRQPImdG1GNmAyb9vpy9hhlYmOhiywXS4PPazuMR1kKyHWh9DqJ6Zuo6IjdHqJ0v9EHUvf01KfH6Yz1DW2NcPvbqGiX+RGX5lXNv8SHLXVlmx4kX3GhYNuGN+9dK4mduNUUhuBpWprh6z9vB1jZYP4+uQTXgTOI92K40RhvGSfvZHbuHPM2zxutygqSu/EYOXogJ+aLo9PmYt4Sp1GnQIKtJWWYyitg6TC4XijiIpm/uP/+D2yju/ShHpRXJWMQKr2MFvEDEsXzOYnxV9BDLXLshqBcfxbQxgSPxiO2RVKjq4liZgQjlH0iWi+zbUVfPsCOPCmhSu2NnEsZehK2yXr/NvsEzK0rCbL/tX33jiZlUz1gQbUQ7eMt6DnHA2kPF1qAem4JrSuRpv0C43RciYu6ANaSQnEKQLSsa+KKykPxKNvqn6fbs71z+IQZCtpBCPRcf220FDm/TsME1G1eqDbYPjWJ2hnenMZ1TEv/kHk9bo5g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(336012)(2906002)(3480700007)(40460700003)(36860700001)(47076005)(53546011)(16576012)(6636002)(31696002)(70206006)(6706004)(316002)(70586007)(83380400001)(110136005)(5660300002)(31686004)(4326008)(44832011)(8936002)(8676002)(36756003)(82310400005)(86362001)(81166007)(26005)(82960400001)(966005)(956004)(16526019)(7116003)(186003)(356005)(2616005)(508600001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 18:08:30.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c15ea28a-1d9e-4c22-050a-08da1be6491d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT107.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Apr 2022 16:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8030

On 11.04.22 20:04, Chris Paterson wrote:
> Hello Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 11 April 2022 19:00
>>
>> Hi all,
>>
>> https://gitlab
>> .com%2Fgroups%2Fcip-project%2F-
>> %2Frunners%2F12564521&amp;data=04%7C01%7CChris.Paterson2%40renes
>> as.com%7C70144a163c384b25cda608da1be52901%7C53d82571da1947e49cb4
>> 625a166a4a2a%7C0%7C0%7C637852968294620917%7CUnknown%7CTWFpbG
>> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
>> Mn0%3D%7C3000&amp;sdata=h9ly7L3ROKy8AmavVS%2FqczZkna1TGoU%2B
>> WkF7gHqc3SI%3D&amp;reserved=0
>>
>> Any planned maintenance I missed?
> 
> Not planned, but user (me) error when trying to get the LAVA master back online this morning.
> Michael is already working to bring the runner back online.
> 
> I meant to email the ML but forgot, apologies for the inconvenience.
> Hopefully we'll be up and running again tomorrow.
> 

No problem! Thanks for the quick clarification.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

