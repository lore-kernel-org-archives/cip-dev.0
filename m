Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D022C43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 15:16:02 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.80])
 by mx.groups.io with SMTP id smtpd.web09.13783.1654614958881091717
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 08:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u6Olry81;
 spf=pass (domain: siemens.com, ip: 40.107.104.80,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h261MzFtJ0pLE2v+bsj7B5d0Kr986K4dfd4V28pOwcVWImoblYKRtDtJ5nMZ4xo3fUGi+aTTjT/i8nyAcjQH33f/Ho/4QaXs37WWnWpX8/TWOb6ZI5nOX6YczFpXteFX9ORwHjZVU92vBH/2E8gTs4f+4cbib9jp2CcfpiNo4rAg223GwIBjU9jhcTwhWGrkWD9RCScXN2s70NuAeUM78v/HPfcFTLfv9DCovrcigX15VlwGPg3zoMBhGElJMXg/Ryn/qm2R36bueOjzVdIgpZQoyz5HGj8nekqFbaRdBfNoOdVvxfr5a8HOJwFcwboLwONwkei7EdcxEx1JJKXfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd548M4yPKreZu2RUbbSPF4TSmf5MyVj2Py3uCGLMio=;
 b=j6DiWiAc6S0hNBHBPKXnqeClA1Bv65iiUS7TCZh7Bk0UffGKXt8VPYPVhIDJR2HTmOU9Awel2oslNNeS4BeLEtutRpIPgEUnRVJnZUZF/jIXsPMTBU4CF5wA8v1/cFKydAhYPBFc71fBDqk/klFVXXA03REfFSMe+n9o8qceDUrGHCe9TInX/AexKkAi9i94LNjkY6rALpDic1ujUq1QooyA1Iky4lVUEjHaFgvh7lo/DMxA8B7lbq47Y09lHdQWi6H/SWEsrVZpa+jQOFgd20X8QZ4c7ENBd2f9CP39Ee88cwClRI9RsfY6VP//RcE4slbRUBX/9BaLJ+sIvf5y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd548M4yPKreZu2RUbbSPF4TSmf5MyVj2Py3uCGLMio=;
 b=u6Olry81rCWRJf+ozyAA5BvitEehgmzpckd1nRP0rjhVtTDxHsyozI/IthArCnYhWoT65ZFLyUo3JNwRoXYCJQIbYzQhQxXHadIrbBt4GqCQ1SdDOhdzYw1fWS+UIA0B3+9X//cSbkXv+IOlakgotr8NagEum2BVHCxY5H04Tt3P9Gx/r87Q3Edpak1i8HTx+A2/pgQUel19jIrq4brJrYJHvyD0fd3kbZa/7jUbjWzxkMshXw8YkM4xT25vSuyZr852Ry43a2II8EK2FV6ABYKbBXyDtW40mQDwWRzjQ9bsjXvsAFM4gYoYy+B7BZz9vXfojOebkOdboOFyG8ALxQ==
Received: from AS8PR07CA0005.eurprd07.prod.outlook.com (2603:10a6:20b:451::32)
 by DB7PR10MB2156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 15:15:52 +0000
Received: from HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:451:cafe::7c) by AS8PR07CA0005.outlook.office365.com
 (2603:10a6:20b:451::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.10 via Frontend
 Transport; Tue, 7 Jun 2022 15:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT074.mail.protection.outlook.com (10.152.1.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 15:15:51 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 17:15:50 +0200
Received: from [139.22.142.213] (139.22.142.213) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 17:15:50 +0200
Message-ID: <ba27551b-f111-2cad-f479-0e734e4814a8@siemens.com>
Date: Tue, 7 Jun 2022 17:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
Content-Language: en-US
To: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>,
	<quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
References: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
 <20220607135016.1856603-4-Vijaikumar_Kanagarajan@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220607135016.1856603-4-Vijaikumar_Kanagarajan@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.213]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--7.445100-8.000000
X-TMASE-MatchedRID: /RB2PwB13wPdDS6etHbe28U8jBVxKY1xPg9yfk4YC0YaLqFbxdotGW4l
	czE4XkmwZVGh4Dw3rH+4XQER51G1bXxs7qFZ9FbOj0IvV7jlqDjqeD5AzgrAlOFgDmzNVVKoq5U
	6sO8HwtNM+b8yxBqvAzt9QCEcdHOdfAAYXFaupyXTwqurdQMjUo5dVuh2ywvhXmFVlObh0PxBfk
	JWKY0KaQrVgpI9tRVko8WMkQWv6iUD0yuKrQIMCBBWOoA5nlyNC24oEZ6SpSlsZUSYh+N/e1Cyd
	PFc8gRcH9mGvHJHe+VsndRnnWJX0NUlvRTXGw0+QYIHouSQS6M=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.445100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 A338EEA7558419878FFB9614B03CB6112DABFD9C7AE4D1AFC17D33D6A773403A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1bbbc37-39d5-4375-f8ab-08da48989c25
X-MS-TrafficTypeDiagnostic: DB7PR10MB2156:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR10MB215683CD0AD0B0A9F809342C95A59@DB7PR10MB2156.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hXAxlSlY6+g5iHRLn3edsprxqAvapmVONMte1V2Jr/YnXN7PveALSkXkjhDKAazXP0fD9TN4nrhyhRlRYmXz3nC3aGHj8qWNb26BxI05G8djrNVXL1LY/WH47uBa7eVDVuxhk+wQJ+BH5I55aHVXZxNzCuthvPwOkHbDDdB1YhTdQenMnhjRcH1fU6QvgyAucGU/3FUmSgDkHXz1bdXDmVbD7FWR3Oz0+XzAuZJu++yBNYYfmsXs9WC7RkBhGJRzQC83ype9B+i//2U0WiNJnZb93XWs6M53bkoGGw8zmb55BdclxgavI1Um4r+K0BL9o+xewWEFsr2LhqnxpT34I8g6gNZD0SR2aNcNNOeZhKoB8dRzOJmAa/VhHxwqu1+K9pWD7YYrK9wRy6MgKHjzGaDY3dGslxBwEfJXYWFWyNj/nhMmEYmU3W6/axgUu45b8wmpEOZUpZELBf0/cqp+mSI0PaARwLtK2wyF1794lCxyJ26G/X7nFiNhLGD54ATA2suoQYDrhbSJjLoEJSdPH9Z+jdvRLVe3LeNRRp1Lof9OwU+/N3melMwHuadC5SmMSUgRUgN2USMsrKoNKWAR+9JUQi4MVYju0Rvfo5YiqWHL5rsP+z6bbK+oneo4DbCUlWmWKMj2WmvLnNacyBmxY+uojU0hB7EtzN1d0qOeI5TBRevfAoHaIWLKBdENF2G/L4+9ZGBihp/zCCGc7/u2lV9t9epoE7VZ/Pej6R9uab8Dlv0uVyOK/KWXzO9PXRlLhnlF7GYgHvKigsi7RRdw9w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(31696002)(508600001)(86362001)(186003)(47076005)(8936002)(356005)(26005)(81166007)(53546011)(82960400001)(2906002)(5660300002)(44832011)(4744005)(16576012)(336012)(16526019)(316002)(36756003)(8676002)(2616005)(956004)(31686004)(110136005)(6706004)(36860700001)(40460700003)(70586007)(70206006)(82310400005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 15:15:51.7528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c1bbbc37-39d5-4375-f8ab-08da48989c25
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2156
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 15:16:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8512

On 07.06.22 15:50, Vijai Kumar K wrote:
> Fixes the following error during cross-build.
> 
> Makefile:207: *** running tests on cross-compile build not supported.  Stop.
> 
> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
> ---
>  recipes-core/ltp/files/debian/rules | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
> index a485615..06b9070 100755
> --- a/recipes-core/ltp/files/debian/rules
> +++ b/recipes-core/ltp/files/debian/rules
> @@ -8,3 +8,5 @@ LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
>  
>  override_dh_auto_configure:
>  	dh_auto_configure -- $(LTP_CONFIGURE_FLAGS)
> +
> +override_dh_auto_test:

Was that already the case with the previous version? If not, this should
probably be moved the front of the series, right?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

