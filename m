Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D4C38A2D
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.77])
 by mx.groups.io with SMTP id smtpd.web11.6076.1650614899337857414
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 01:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WcfQhW+T;
 spf=pass (domain: siemens.com, ip: 40.107.15.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUN6vW85fArWLb+KSnEOp3Dh99QspDxIW/VSSxZIiSdBtzfFBeZhXjz0w0I2UxIqvfxdxrvkdAMPrqo8LSlSwkC8REiejqsPSPXRVaqPXM1Ew8wf52qjLG8UGArFXM8F26/YJjCH4woZU5XvXC1Sl692a8OP/moROwVaPd9XVvk7Dn1NHattI/BWPQl1kAncmwsQU1hbdVwFxJpzbsCGcrcfHwyQjMvUTf+sDgzdZs47zUAt2LJGDuZc4uiewLM89Jb2duxZ/kvlHnvkqRFTqOJsIc2apg9pNRPpSCPC9eocWSqBvqzSbKFwPJldm/y/qrCLyLf3h3rflJRIcyqIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p1ezDW9b1Q1x+pTrsFf/MHrBjZ5O67PsXoOqh5Yu6U=;
 b=eoCMiExPU1bLeQ31wb2oPzBlJ8MJFnH/NDFkUl8fOE89oE7Q/MC8FtdFVchktBcMnCmmQkSp6WbzYGag1q+jqaXTEiX1ARwGvCL5GK27H8kPSdlEq63FeWyqqzcfkOoeXsWlKjmZad058l+8M1SoIvoLi6u701E7f4m+TmrNqDfzL03oPJYPqhNJUnczbeUf2aPZIAjiX51JsDVM/4jhBEvrFLejHFluNO5G0hipgXkjKd9FxXqfWnn6M/XkEpIJcLc/6vjbbY62AM8/OdUdnHYPrA1mtiTtEM/TMO2GkjJxt/10ZUslxCrzubBnNDxW1RGSGFDxaNRXdJCvEkWmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p1ezDW9b1Q1x+pTrsFf/MHrBjZ5O67PsXoOqh5Yu6U=;
 b=WcfQhW+TVhmZjapSJkcY6j68sZ/naa+ZlZj1/brZOgiqofEkdbW05qPRYf7IiE3lL18Z0DN7FFTHarhhd/X54VCyIGloZoNVIKkWyQwi0XrjaKjZ62yHGOfyDuAFZ6arYLa3CnkxELDQdc//KaJWVJkbDFaOh3qVHiLGzAaWRgy0Tb3sftfUwY7XXtuSlkMVHiokaqyFFsKbpqzyzClFVynOx7yaaZ4ajNHlm32kqmzHl69nI6UFyPh/+HB6Eh29JZjdDisH19l/PR4nq4D4Gw+Ldl7zoVJJXTF7RqBap0KSoLrzC5MqnHUlRor0m01eqSjEsK9DUnYDiQxeMYzszw==
Received: from DB6PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:6:2d::19) by
 VI1PR1001MB1261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 08:08:16 +0000
Received: from DB5EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2d:cafe::df) by DB6PR07CA0009.outlook.office365.com
 (2603:10a6:6:2d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Fri, 22 Apr 2022 08:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT034.mail.protection.outlook.com (10.152.4.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 08:08:15 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 10:08:15 +0200
Received: from [139.22.137.211] (139.22.137.211) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 10:08:14 +0200
Message-ID: <b4fc1868-d545-12ac-3920-56ead88c8f79@siemens.com>
Date: Fri, 22 Apr 2022 10:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: gitlab quotas and linux-stable-rc
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <962465f6-8d5f-93d6-1a51-51658c80e167@siemens.com>
 <OSZPR01MB812492601D8BE4113AF1EE8FB7F79@OSZPR01MB8124.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB812492601D8BE4113AF1EE8FB7F79@OSZPR01MB8124.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.211]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.120600-8.000000
X-TMASE-MatchedRID: 8xNMUprDHac5QaOxwNGfvo9bHfxDWoibjQCnv157N4q0pXj1GkAfe1MU
	1D6HvWHfnB5z0rOYaw5jLORo1y6rxvOB9ECQlLgbu86s0KtjkKM1LzFGMrS+QhfqkKQlk1I5Ien
	Jde9O8yr+7KZICEbEspHvdPXFwPsgSl4zVySO23jQf5KwDqIa2VnjMpLDrGz2tT4jIeGRd/UujM
	j6uE1hubbMVaqtU3gFzgwnwrw2qXxbJcQH3furV6epbdVIZ/l3TX7PJ/OU3vKDGx/OQ1GV8t8dW
	DYdvqmp1GcRAJRT6POOhzOa6g8KrUwcB2c9oswhV21A2ibGdsbZM9/C59xkixfA2OZhIpvLc8Lj
	C3HaV6U=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.120600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 53DF0888FA968B72F59FF6C9EBA5EBBF33927E0E0E69F8643822EAECAE01EA552000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5945e154-cee8-4ddc-1edb-08da243740f4
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1261:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR1001MB1261BB36134445AA9A5532F695F79@VI1PR1001MB1261.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ri5B8v/eHmQI9iXbVOh20R8SfCdsUDRzvXQobsLRpRys0qvJsvkOxxdnKFjO7DVmMsTwPfwvixcu1gHUuRa5D9bSAlRq396FzIxpPcahYI2oAQse6IGm6UyaGHIzcq8HgjiJFCL5oO9TZOedXpJEJi2TujwXBngFSaZGRK1gCpj7qhcD3IU5KYFLzIxZobCBwN+zMDUbWfvJQYRLDfuieSrhfmQf35AJd3b2YYChMYr0GVXZZ63GkAgol8ml3g5UnB6jyzFqHACd2Lq0lt0V2CRVfj+gi0XOiKrPamMwsO616ES19QlQwON81oGuuZ9dMuzJyjnZ/hbtmDFkzP/cqGJSOzLPOQEEmasPAuOmRmWKuh4I8bSMFcWOPnGLh/7zJpIz0Wgb0oBebiGiw2mu4eCOqcFs1UdaP6QoVgxmeTBDiiowzN8yAOYPttFi+lBh+cypgbKE5xuYDPWw2LtjiLpdY/CjcsoCO/bzHNjwPRb0eKOD6d+oWZH+Z3AjtvFGtYOjJ6MyRlTKyb+3l0Z0P802UxEDuHGZyyrK89ekXS1kb+ogJPEAHhTVvM1H7fLIIXn4dDI59+x0i0kQk9Wog2bkhgsEsBK5Iihe/9JlWS3Hj/XlJVKrNVLaz1sDQGMq88rdUP1jq3Kjc/K70BWLhCQ3yihQKvsAJp0kPFicnTzi4Opk7mznnWQW68+fZCZOt68hMK9aQNuPeYVwrE9Gn8yUSgGXJElBseW7qCUkiAybif/09Hq8Yx195LUhv03n3vdeRpAwNkzAgQWsnQ55Kph17m/YYL+luhnm8YWjOxOStB7c5QB5RikTDJt8H6DQFWFanbqzfbCKIM9u1sEh7dzHJF974P1Ma+n23mNxKKc=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(81166007)(8936002)(82960400001)(356005)(70586007)(36860700001)(31686004)(44832011)(70206006)(2906002)(53546011)(15650500001)(36756003)(966005)(336012)(2616005)(8676002)(86362001)(956004)(16576012)(83380400001)(4326008)(5660300002)(82310400005)(6916009)(6706004)(47076005)(316002)(31696002)(40460700003)(186003)(26005)(16526019)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 08:08:15.7107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5945e154-cee8-4ddc-1edb-08da243740f4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8182

On 22.04.22 09:03, Chris Paterson wrote:
> Hello Jan,
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 22 April 2022 06:48
>>
>> Hi Chris,
>>
>> seems gitlab still tracks linux-stable-rc:
>>
>> https://gitlab
>> .com%2Fgroups%2Fcip-project%2F-%2Fusage_quotas%23storage-quota-
>> tab&amp;data=05%7C01%7CChris.Paterson2%40renesas.com%7Cd08c7667fb
>> c54e6fcb5808da2423acad%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C
>> 0%7C637862032882240086%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
>> 7C%7C&amp;sdata=hAUL8ukZD1FaklEH7oIwfX2IONMZQANmfcrDObU%2Br
>> ww%3D&amp;reserved=0
>>
>> Should we simply delete this project, not just the repo? What is left in
>> that project? I don't see anything.
> 
> To be honest I thought I had already deleted the project.
> I've tried again today and it seems to have gone.
> 
> Hopefully GitLab's storage calculations will catch up soon.
> 

It's a zombie:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc

I've also clicked "delete" more than once now, but it does not want to
die. Maybe open a ticket?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

