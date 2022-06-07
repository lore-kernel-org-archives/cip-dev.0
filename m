Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7068FCCA47E
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 17:38:25 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.84])
 by mx.groups.io with SMTP id smtpd.web12.424.1654623488327154885
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 10:38:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fcx2Rx8o;
 spf=pass (domain: siemens.com, ip: 40.107.15.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGgx4Fm0D+Qnl7+JKWkxuuiEDADhrMKC/SD/OPytnOJWCbIddC3E0oZbl3aHbMS86UXFxeEGaOW3ZyTEHfo7j0JRBNoDwLBkiBx1jyEaTD3W+Sntx5hDuU+2xgFN1w1QJ3pWgSLCoJzxawuTpoAUSPyTr2Ulv5oTf8YXm/aXw2gKsxewnFbqwADT1eZKWnq/XuM9ClJrnnj1kPuAk03elfQxmz+xFy0MG9V6PGdM8+70/5othR+2Oti7hypdk7C3axBSTQxJ5JizGM51KvD8anrZNIrH/ZKOn3rqJNhNGpQgVV9V/uFL0jh8iZW9bGytpMZ8vJ8i7V/4rKAueN/XZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgBz+lHxa8f0ChSw4XrlJtM8NCCtF6bya9D6+zc1/6w=;
 b=nrL8um4TIIwcCDpJ2xsVTJiVTpK+ncEGR//6c7ESDAsesh/63lkJdGSWKPYLVu1Cs8h8GK+athOR/bGGaJZfWRPngZqO/Dh929hk58+zFtZwDOxW/EKSEdWd4j5/hzBmwOWOss4v8+JKphP3JJ9kPtK4ZsZyQX9al+RuguufDmy6vcn91NZcZuNK0RriGlJy9HWOEz0jdglO2D34ti/9HPNzwbtlhlpSFqvYaSz9sUBKJiS6UWZRHhV+uYYsJ80AXVxwjFzKam5Q19qHjDFeb5oIzoVHhZeplv3bVwnyLFwOd5eUkrGfiT8JVnSTqL1+wEOo28fVF+eMCf36+tUZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgBz+lHxa8f0ChSw4XrlJtM8NCCtF6bya9D6+zc1/6w=;
 b=fcx2Rx8ojmmA4wJnwYS7MPULPr5WpKWmJHeps+Q5azwGtkfYsUpLauPWGm2zAGuX2sL1VSHSK8j9N/sdkG7nCWxbjrWBKibfCe8nPdpV9zohvwD++hsN15Ww3TDnUfdrxPf3GJMUttYUwFE3q5ySHDVxvwtDfFDEZtQBPnJTRrRqWP6kE6GhdW+WClRHeEz2BP9vhRO3TNGg9Mo1dPg7VVF/p2dTcK7r1uxzSsz8HvPS/FO01zngsQGCshSWXCDtpLee+T9TP62Z4AO8mlj51EuRLFp1fwrxjjbdloxA+FDorK5ktaXmwsXchyL2oF9VWQjlvUfulNA5DKpPgak8Yw==
Received: from OL1P279CA0028.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::15)
 by AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 17:38:05 +0000
Received: from HE1EUR01FT098.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::78) by OL1P279CA0028.outlook.office365.com
 (2603:10a6:e10:13::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 17:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT098.mail.protection.outlook.com (10.152.1.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Tue, 7 Jun 2022 17:38:04 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 7 Jun 2022 19:38:03 +0200
Received: from [139.22.142.213] (139.22.142.213) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 7 Jun 2022 19:38:03 +0200
Message-ID: <7f92b230-df1c-6b7d-3c8e-3ff29840730d@siemens.com>
Date: Tue, 7 Jun 2022 19:38:02 +0200
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
 <f8d994c9-6b47-e89c-e8b0-bd873deef763@siemens.com>
In-Reply-To: <f8d994c9-6b47-e89c-e8b0-bd873deef763@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.213]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.103600-8.000000
X-TMASE-MatchedRID: ObgwaKFsELDdDS6etHbe28U8jBVxKY1xPg9yfk4YC0bM1jffIgQXhuky
	95siDkZPfhcIM0AFu8DZTAEszxrPVLMvzGqxhbHA9ac+TfuB306klkQsTfdVClIWq0PbCp4xkos
	2tunL8DQGmHr1eMxt2UAc6DyoS2rIo5C9bTTxaUZYdYUDGltcL9K59TYQRtphqoeab9Xgz88Cn5
	QffvZFlYAjsy+r+wvnTx7y4qsCFyh8o7wG+qHTkHLTdpHkJeXELFD07/Dk8EYgCPGiZqtI8N8h+
	E5Uefev3vXRyr8nehpnyyhFu6pbB+y/Hj3i0VQKv/9UIaiB4/OcpnIIfxsoW6JVTu7sjgg1rXku
	ON8pnlHnIIpKUjQg+8hyPab4fvVvK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrQ4bc8usnRPscYrFMBiowQutg/ainz5Nsc/HrS
	wMewucWeFuLFW9eT4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.103600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 5F7F6CCFC44E19B36861614B1ABD69D20407593CE819862DFBD7BC430F0B66A22000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d1defef-03cc-45a5-df3f-08da48ac7a54
X-MS-TrafficTypeDiagnostic: AM8PR10MB3988:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB39887867980436AA38675A7795A59@AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nIjdQ+BmYsH01W3koeLhEQgSpjsToi6a7Jdtd6182aqcoD1qudQ1ec1cEjlvRKx1+RrYydeyGvw0z6QIzr1pDKYc7Fif/+VyNsAMm5L/7rEiAnZIy1oYiIbrjpG8FUyH0LXiODiD1IZfvv04wSw7TV4cpKsGSQCpH9+Z1LxomLq+5tmgjtdBnTMgmUMh6u/oiMBDdqpYE6lGmfyhc7Dk22ivoRX2ybYEZYfdYhD5iH0sukI9QOtufdo9Y45dUVBmLl/HvWUGDmZ/p7pBBu1uM9qyRSADlJdYw+a/CaFiOmH5XLPhM8NkbPr5im9W8yI9KPu3osknz7+LCfhJfXbEzLgd0Z75ucdvGaeGaTaQrrmgsbRsVxv4iI6SgJWhOgD8XXCz/+Ee1QCDkBBHSYgQftc5DwojNW0YS2GxgBd0xCeslVtQ3zAZabyx5y3P4zy3Blnzf2LqddeORGN7c+uWkcSH6T4XXpcOFyg3hiFCoHRKY9Bz3vYzG0lACGQvkM96AUjAc2j136F2B6JF8j6X7ohk8BuYsC61F5U4w90I+SGsF+g07s65DeqGsQhW5E5gCYe6eD06/+kEW73MTH0z6DR4uYRQj6CdpvCoYveuNhDYZj+l4IRAKPVrkN12q62aN2Lj6tNNlAcXEJr1C3S9I5vSYqhk80mtc5rX6fizPMad//NTGV+H5ulIfdenFwCtOBDK1mbEtd9fGvHrcu7d/CM6JabYGw/KQ+Kn/m1eVh/mzNNv1T+muWjukDjZbb04lNHYJD0GkW0GazILqnfcQPOZWdKB9k0MLT6y66l/iWkc2h9cR6fKkWXJeMQ06EwK
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(31696002)(53546011)(70586007)(31686004)(70206006)(966005)(8936002)(5660300002)(16526019)(186003)(508600001)(956004)(2616005)(110136005)(8676002)(47076005)(16576012)(356005)(82960400001)(26005)(82310400005)(40460700003)(2906002)(6706004)(336012)(36756003)(7596003)(316002)(83380400001)(86362001)(36860700001)(7636003)(44832011)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:38:04.9365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2d1defef-03cc-45a5-df3f-08da48ac7a54
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT098.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 17:38:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8517

On 07.06.22 18:18, Jan Kiszka wrote:
> On 07.06.22 18:14, Jan Kiszka wrote:
>> On 07.06.22 17:52, Jan Kiszka wrote:
>>> On 07.06.22 17:23, Kanagarajan, Vijaikumar wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Sent: 07 June 2022 20:46
>>>>> To: Kanagarajan, Vijaikumar <Vijaikumar_Kanagarajan@mentor.com>;
>>>>> quirin.gylstorff@siemens.com; cip-dev@lists.cip-project.org
>>>>> Subject: Re: [isar-cip-core][PATCH 3/3] recipes-core/ltp: Disable autotest
>>>>>
>>>>> On 07.06.22 15:50, Vijai Kumar K wrote:
>>>>>> Fixes the following error during cross-build.
>>>>>>
>>>>>> Makefile:207: *** running tests on cross-compile build not supported.
>>>>> Stop.
>>>>>>
>>>>>> Signed-off-by: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
>>>>>> ---
>>>>>>  recipes-core/ltp/files/debian/rules | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/recipes-core/ltp/files/debian/rules
>>>>>> b/recipes-core/ltp/files/debian/rules
>>>>>> index a485615..06b9070 100755
>>>>>> --- a/recipes-core/ltp/files/debian/rules
>>>>>> +++ b/recipes-core/ltp/files/debian/rules
>>>>>> @@ -8,3 +8,5 @@ LTP_CONFIGURE_FLAGS = --prefix=/opt/ltp
>>>>>>
>>>>>>  override_dh_auto_configure:
>>>>>>  	dh_auto_configure -- $(LTP_CONFIGURE_FLAGS)
>>>>>> +
>>>>>> +override_dh_auto_test:
>>>>>
>>>>> Was that already the case with the previous version? If not, this should
>>>>> probably be moved the front of the series, right?
>>>>
>>>> The previous version did not build successfully. The build was broken.
>>>> Since I was upreving, I did not dig much on why it failed.
>>>>
>>>
>>> OK, then we can keep the ordering.
>>>
>>
>> Hmm, just realized that we are not testing this recipe in CI. We should
>> probably enable kas/opt/test.yml for some representative target(s) to
>> close this gap.
>>
> 
> Err, no, we are building that ("extension: test", see e.g.
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/2554473964). Now
> I'm confused, specifically as I've seen build issues locally as well.
> 

buster vs. bullseye: the former worked (as tested in CI), the latter was
broken.

As suspected, patch 3 needed to go before patch 1 - or folded into it. I
did the latter while merging.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

