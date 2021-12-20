Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D9C433F5
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 17:04:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.63])
 by mx.groups.io with SMTP id smtpd.web12.7830.1640019861906524052
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 09:04:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=K56PjAIx;
 spf=pass (domain: siemens.com, ip: 40.107.21.63,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEv6C473/a/Kix91rH5uHxSnvXx4yIvynXFLakAUBxPjmsdD9YCtORTes4QLbwLVMIGwmL4wVwZRS9ui4rtjLNyCkhI3ikQJAYg0T0R0OQDojEHUEzjnZssjw+lwmyOanTxNzS+KY9DqYy/YMWPZh3wqYP7Qv8PE848UsA+Z37b3Lvmb/4jbSEvvRZAenPpEI2yWzSjEq9aVEiLHjcEJxioZI+fKB05zeJ8lC31PWW1RNjja340fDzvB+v3DubJxWRR4Or4zDDi2Xkf2MWVv6FLMr7UGmcMSD98jBiLODC09tayOwYDy1lzm4W73judthdSz15Ucwk01HhpOYWl8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSVIgIjW9Se2qF9FgE+5Q8fxvRwvckovpxrqEOKjRHQ=;
 b=Rhz6FzENRKiw0ksKQbRSSqd8OD0V9o6TqrIDOYfXr2dKCJz4iNgNwCm1Bz1HSEYGq/PVrI9PAalTfI88SL0pMHX8VBE4uTcqAaZJ9GJIcjxQxPPv4JMk7naJZY1MeAqz0Xk0yZgGHo145ZvzO5XAWNggU/lxUM8a9nkmaqi+NWVXn+aKC/c3HbODCzI1nGE3h9jl59zCzBqSV/uwul0s72PPA2MKCNMBpJpGWPHQU8Wbxezo44KOj+Yf22VJNkSyjVIYOm0t/cNbzgfWoDAetmmtKc5xZ0SxFwsEZN95RRIFrM7g8hOGCUQq+wtxmoJL7lNwkY+PMiahKmzRMsbY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSVIgIjW9Se2qF9FgE+5Q8fxvRwvckovpxrqEOKjRHQ=;
 b=K56PjAIxmVFb0DgRMsiNWfjcPWw6L9RaNeHL7Uy02174Ujz53KSxkJYmomi+zChxPmQKb9D+FYOw2tsOcaKr2Xs1h6eL+Dihioh37MatEp54rnL1iNvlGD1OUgbnvHPF1hIdMbX66806lSuJgduvee99/7OcOltwXh/DHFf8L8txkc3vyKQKzcfUAcGfcEGCOoRyb5apwMSq1mL+0srX2hIrux5HB4R+ofIp9CrfIK7dNH0YCSND6B54HWYofj/R2TRmeJbayPcGbrNhtRXAwZfoiN8ywhE9X0t5ihBAtusQHruEycxtlhMX6Na+J5Q19zgJdJDQVuOtntuPi7fnrw==
Received: from DB6PR07CA0082.eurprd07.prod.outlook.com (2603:10a6:6:2b::20) by
 DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:b2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Mon, 20 Dec 2021 17:04:18 +0000
Received: from DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:2b:cafe::ea) by DB6PR07CA0082.outlook.office365.com
 (2603:10a6:6:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14 via Frontend
 Transport; Mon, 20 Dec 2021 17:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT032.mail.protection.outlook.com (10.152.4.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Mon, 20 Dec 2021 17:04:18 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 18:04:17 +0100
Received: from [167.87.72.253] (167.87.72.253) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 18:04:17 +0100
Subject: Re: 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33] 5.10.86-rc1
 review
To: Pavel Machek <pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20211215172024.787958154@linuxfoundation.org>
 <20211215183223.GB10909@duo.ucw.cz> <Ybo2lbHVaASDyAcC@kroah.com>
 <OSZPR01MB6877AA8378F08F7071E53A58B77B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20211220095806.GA21780@amd>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <39da7ecf-889f-1922-13b8-f05f1e949793@siemens.com>
Date: Mon, 20 Dec 2021 18:04:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211220095806.GA21780@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.253]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf0ca8c6-1bd1-4198-915c-08d9c3dac26c
X-MS-TrafficTypeDiagnostic: DB8PR10MB3116:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB3116DDEB1ADA114F02D16132957B9@DB8PR10MB3116.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	edIzKvR76jk+WspWLCF4hy5FQUjZarANI36oMAALWBX6L3H7PZ2h974J3ZANMK/y81bogKQhdocYVCmwoNv6tsU4UnPIEfDUVxdOpkprZt+JaqJKeudTvcrXHP5CUdx8OEKc7M/b60yCUEXfL9BXZnpH85E7CFugt6tfW2XulaoLAiEFihfG1px+L3CTVqcGBj7UFoeKjCRfouZogkp7X2wCiTmuEllSPu9lSLqJ1cW38wnhj3UPhpYnIfE1kO8zfvlp+1JrtyNinAOMNPAVP5vioO6D0OUDE39hc53lPjvKpLSe3VCNclFD3NhkqYxMQ10YuOyxRRjA8vHrYyq2As/rT92Y3kbPW+XcPDtJn2ehsSt0cOY+Ai71EjPnfM/MnQ36l+93gKEUDE5uhH96HAbgfqfk56/d+dgziBfveHQu1PBSl2YZHatH7WmRLNAN7NtR8e6kKUzipfqQf32GX53zN+zJmwxDD/yYeyLIqt1XriebTrzGKnx9es+L5dd7NomSugvf4hC0Qqh4G57sbn4NgJ/e4nPWvh/QwG+GUClCH+gkvnxe7IXCRUq0i6Lft1/seztHOGJcWn3lLECJz4voSFnoCjnKJlIGgj/BLBXj6px//ID2W9LkkcUDh0Dbs+j3qxTyISHPMo7z17FMoolHNMnMJ5pMoGoPJ0tV1rRPjAM2Vu6bIoDb0f5KV4MGnDnOGUxEkes7OQxv/wrstJFMuDgb2J73FVDcBOyI6/YNy2R6SsMYvArrlMuufzv2AWFjZyjy+nacrEMV0Gsgd4j3smAhyB7tGitxL6YDy19+alo4Zs5M7QpJM3mtwe54jtmvnzTN9z7KcAJkeLUVcdkL9jOfZbTJxQokoLaeDXKfFE3C14SxkL4NmJSNJI6biqU5wPIunt7/2rGSnUHIDV/7BxzLPMjRLWDKLF8TA8Q=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(82960400001)(2906002)(7596003)(7636003)(356005)(70586007)(83380400001)(498600001)(44832011)(53546011)(31696002)(5660300002)(336012)(956004)(2616005)(26005)(8936002)(186003)(4326008)(8676002)(86362001)(6706004)(36756003)(31686004)(110136005)(16576012)(36860700001)(40460700001)(82310400004)(16526019)(47076005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 17:04:18.1024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bf0ca8c6-1bd1-4198-915c-08d9c3dac26c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 17:04:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7220

On 20.12.21 10:58, Pavel Machek wrote:
> Hi!
> 
>>>> I believe we should not change build requirements in the middle of
>>>> stable series.
>>>>
>>>> To our testing team: 5.10.85 introduced new requirements for the
>>>> build. gmp.h is now required in our configs, and maybe something else.
>>
>> Hi Pavel, sorry for missing this email before now.
>> I can look into supporting this, depending on the answers to the comments below...
> 
> Thank you.
> 
>>>> Easiest fix might be to add
>>>>
>>>> # CONFIG_GCC_PLUGINS is not set
>>>>
>>>> to our configs. Alternatively I know which patch to revert.
>>>>
>>>> But I believe -stable should be the one doing the revert, as the patch
>>>> does not fix serious bug and introduces problem. Faster compile is
>>>> nice but let mainline have those kind of changes.
>>>
>>> But that commit is needed to get gcc11 plugins to work with the 5.10.y
>>> kernel tree.  So either we "break" it for old and obsolete gcc versions
>>> (i.e. gcc7), or newer supported versions break.
>>
>> Well this leads us to an interesting point.
>> At the moment we use GCC v8.1.0 for building all of our kernel trees (cip & stable).
>> What does CIP want to do mid/long term? Keep upgrading the version we use? Or try and support a specific version of GCC for 10 years?
>> If the former, when do we want to upgrade?
>> If the latter, which version?
>>
> 
> We should do what our users are likely to do... they want stable
> kernel, and will not update toolchain in middle of product
> maintainance. [Updating toolchain when starting new product with given
> -cip kernel is more likely].
> 
> I believe that means we should stick to specific version, but I'm not
> sure what version it is. We support Debian distro, likely gcc version
> from that distro would be a good option? Perhaps we should ask on TSC
> meeting tommorow?
> 
> 5.10 kernel was released in Dec 2020. At that time, gcc 8 and 9 were
> maintained, and gcc 10 was new (https://gcc.gnu.org/releases.html).
> 
> To get some results for -stable testing, easiest options might be to
> disable gcc plugin support in Kconfig.
> 
> Best regards,
> 								Pavel
> 

The natural pairing would be "buster/kernel 4.19/gcc-8" and
"bullseye/kernel 5.10/gcc-10", indeed.

I'm definitely not able to attend the TSC call tomorrow. If you want to
discuss this topic, someone would have to pick up the kernel WG
representation.

Jan

