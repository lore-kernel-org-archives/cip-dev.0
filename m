Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F46C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 09:11:23 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.73])
 by mx.groups.io with SMTP id smtpd.web12.2429.1665133876959007885
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 02:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EIzgeBDZ;
 spf=pass (domain: siemens.com, ip: 40.107.1.73,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8S8StP0PyjQnWhAvLQjBHQF/px4SUs6KWQiu/JnoLpjo3I2GlxGyq8DQHhkCv5amQEp0bUqjVOcGB7hAzAm7wHuHHa7I2gkM02bPrYraWIbVYXzxuj3cu3OpjLOfBGvBwDIIWZ7CnBJTISpIyaWqCHDJqAqnhaJGuOkeDNXW96mVy4UYQbrdx5IiIRqIvNGK43pSuiTi+ez0sZXCJ7AB431oGbi/86yMgW+NXY5GB2ZCJPEj88JRFocbbdnQ1vy8A3E9xXdWEolWIvuWUo0pMTdB+eDDyU+uQagX/u0PpxSvlQ51GKh7HQy6Pz6HwE628yirZ6qSnVA6rAMion2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bVygUoL6r1MnHh0ZGw4bN9nXz+TBgmPyn4BekxwwPg=;
 b=D95oWh/jkClMMWT4in9A6hI2WMkSAi5crPif3lSf1xxiNDis5aKxtZm0ntr88Ag82lyIXPocug3Z/T7CIcHZ8D6D/SJHdHHEkbpfOv/GqqXME9p2zwWKM0LkjjDW1hhrTk309as1wzQWimNsjZp27gDJnYLk0oNzHI/P8Zd4b7jNAJKPaR9CmwrymG0qVk/Jwqkh+igBLwF1AuUCFoiRYn/mE5NnD71b3/BtBBVFLDEoOa78B42Ji8a+Btuv3/wO4PRDSsMJFPL4b9324hHU9V21V1eFRDWjV3tV/8RSZxiptr3snNv7xq1oJYhw8RMCLGl4QcLZbfzdzHCesTyPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bVygUoL6r1MnHh0ZGw4bN9nXz+TBgmPyn4BekxwwPg=;
 b=EIzgeBDZyi/zoj+CZKfyiR1P8tUTFkqn6o2JZZSKu2KcL4RVCx12zsA4p8F2PHTo9FiqlRRhCOBpgWdTR3b7lLtzSjcymQDruk/eeVt2WH/bK1+eNGhW2O4bMTNotipmPO7WPAGcJ+fWgmx2x/wIxxBMTDeBuQvhoOKZK1MBmAnOSgxh2HvEYLwG4RHmDe7cEk6F2N4wczwf3bNwnkOV5u4lDzQJbEiI5siPFcRpXusuqi1dALeG7iOBtIAp5l5UvQ5mdZYFQqHUhicG49hrMDScAbKuUMYRzBDN1RcV6oOlcJjzswrqlRX8ONMBcTvFdIJyQnBYYrmRH/2WF1CsIg==
Received: from FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a8::13)
 by DB9PR10MB5504.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:307::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 09:11:13 +0000
Received: from VE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a8:cafe::b) by FR0P281CA0113.outlook.office365.com
 (2603:10a6:d10:a8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.39 via Frontend
 Transport; Fri, 7 Oct 2022 09:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT013.mail.protection.outlook.com (10.152.2.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 09:11:12 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 11:11:12 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 11:11:11 +0200
Message-ID: <fd47b229-9803-4298-43bf-9924dbd6aa7e@siemens.com>
Date: Fri, 7 Oct 2022 11:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
 CIP_IMAGE_OPTIONS
Content-Language: en-US
To: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>,
	"Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221001045257.441816-1-felix.moessbauer@siemens.com>
 <56f5db40-c995-fc9c-24e3-07fa642443d0@siemens.com>
 <AM9PR10MB486962A4EB295F82550CE2BA895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <AM9PR10MB486962A4EB295F82550CE2BA895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.805900-8.000000
X-TMASE-MatchedRID: AnkS0S6+UFo5QaOxwNGfvo9bHfxDWoib1xQ2OgXti5VTL5B6BWU2DXg9
	csuuqcCglFENJQphsMKabGVEnOoMFnggpNBbPCpFCfW5oX1MTG4hOgSF6241nfi9hrAKwILaAf1
	C358hdK8GmHr1eMxt2ZCdKyy8S4OmmgMeh/2YB/K1xeVYq+llfs66BgIQlQw1rSAIWhdbeu9LXP
	A26IG0hN9RlPzeVuQQAJXGP8jDjMZLdJZpgOytEaCaZ3gvLsy8R/oM2cgUsZrKXbIv3mQNY8kn+
	x60J9wan7jOJQ+rgvF/IVL4iJwbqodws3imTlh7F5EiEx8TI/u0pkxGORLSpPlNbKGx4Q7UEDnD
	EqNPdure6dEbvIyrxaJcNRKYzfnkK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsiuavR0ffQAKDYDKq9BLK39zsAVzN+Ov/szXzzPeok393VPe9/Tzpe3tkl/H
	qanZouiBGZhxAsnYobdsWjPfbwoA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.805900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 129D02D6E81EB841D5F980D7DB3765D2882679D2A20F3D24BEEACD487008464B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT013:EE_|DB9PR10MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b66a940-0c1a-45c4-111a-08daa843e19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1zceBx33u0FtF7NJwLZTG89z/SZsqLBlT6pl/Y/kW8amvCcOP0aHTXse3EV7lIQ6/IitHp6uQPt46q94uNLtWC7S04tE476t5dYOka5lagSuTsdv4ia/ka2mc6C9w4JdClrxFYOVSndcX86mUgzRY6M7hOoeJjFzF++CovNl3BYy+fTHqqRBffQaiQ85FMi0DMXeWQfMm6f8C3h1RaPimg+odsw3+kMfWxpcycmF+/BnEvC3ZqIAr4f1PUXXd530K1b9xdpuNfJsLrCObR7lbvmQrYFRGdNglyZLDQ+3zCAs3BGv71/7qH+/SYf+tnj+gEBRX95x29ta7YtMvqrvYoPfUXWEmurPcQWQ98nfYqtLZQNzEW+x+EfOmdDH/0DDMpF42z5le7CAMq0AvhZnLH99BQgfcYUCnip5ERSC1HUtKdeuqW8NsCYLWhTWHm9fc49aHt8tSIJqCjafa4v4sQaBnXRcvVYWzTifMayAkpMb055aLGrGvQ8h3DCIZyhQ2DnmXshaL175IQ1ua964gWJSW60X2hBlwThotfTk0fJUEVPjNTSkWZ0dB601LRHTIz4J7tWMTzl153/Xhruls8mYdhVeP+cGKeRpjcHbuemML+eGXqbRT3Wgs+tbXSnXXls4Qj8wwBa+BXAI8ggKaQUZ5eOEygw+AdSaVfintLuEy/IFapsYe5qn/b6qot12WWFx4EnT+IqrlgA97Hr7Ldxt9Q0GUTpT78obCRjipn+K39C+C+v98dMEwJx16e6HI+q+zYMGVmEHf+j0YEkD6FgfP+7mYt/y5c29T0E8xXMsSzaH2BXb32BPVFuppkd9ug7FkqhqtW4An7OGD1zBuemTz6twRSSIgFsGanJuh+w=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(31686004)(478600001)(82310400005)(110136005)(5660300002)(70206006)(2906002)(53546011)(2616005)(956004)(8936002)(8676002)(336012)(16526019)(6706004)(83380400001)(26005)(47076005)(316002)(36756003)(4326008)(6636002)(86362001)(40460700003)(40480700001)(70586007)(36860700001)(44832011)(82960400001)(82740400003)(186003)(16576012)(356005)(41300700001)(31696002)(81166007)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 09:11:12.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8b66a940-0c1a-45c4-111a-08daa843e19d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5504
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 09:11:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9672

On 07.10.22 10:53, Moessbauer, Felix (T CED SES-DE) wrote:
>> -----Original Message-----
>> From: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>
>> Sent: Friday, October 7, 2022 4:08 PM
>> To: Moessbauer, Felix (T CED SES-DE) <felix.moessbauer@siemens.com>; cip-
>> dev@lists.cip-project.org; Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
>> CIP_IMAGE_OPTIONS
>>
>>
>>
>> On 10/1/22 06:52, Felix Moessbauer wrote:
>>> When using the cip-core layer in another layer that has a slightly
>>> different directory structure, bitbake is not able to resolve the
>>> included files.
>>>
>>> To fix this, we simply add the full path to the file so bitbake is
>>> able to locate it independent of the downstream layer configuration.
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>>   kas/opt/ebg-swu.yml  | 2 +-
>>>   kas/opt/swupdate.yml | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml index
>>> 8b3ffec..78227f1 100644
>>> --- a/kas/opt/ebg-swu.yml
>>> +++ b/kas/opt/ebg-swu.yml
>>> @@ -20,7 +20,7 @@ local_conf_header:
>>>       SWUPDATE_BOOTLOADER = "efibootguard"
>>>       IMAGE_INSTALL_remove = "u-boot-script"
>>>     ebg_swu_image_options: |
>>> -    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>>> +    CIP_IMAGE_OPTIONS_append = " recipes-core/images/efibootguard.inc
>> recipes-core/images/image-uuid.inc"
>>>     initramfs: |
>>>       INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>>>     firmware-binaries: |
>>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml index
>>> 8ba03c9..e32ce20 100644
>>> --- a/kas/opt/swupdate.yml
>>> +++ b/kas/opt/swupdate.yml
>>> @@ -16,7 +16,7 @@ header:
>>>
>>>   local_conf_header:
>>>     image-option-swupdate: |
>>> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
>>> +    CIP_IMAGE_OPTIONS_append = " recipes-core/images/swupdate.inc"
>>>
>>>     wic-swu: |
>>>       IMAGE_CLASSES += "squashfs"
>>
>> It would be nice if we could write the options without the full path necessary.
> 
> Hi Quirin,
> 
> This unfortunately does not work, as the options are passed to an "include" or "require" bitbake keyword.
> And by that, we have to comply with the logic of the keyword.
> Or do I miss something, @Jan?

I suppose the key question is whether you are consuming
CIP_IMAGE_OPTIONS in your own image recipe or via
cip-core/recipes-core/images/cip-core-image.bb. The latter should work -
or are we simply missing a

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

in cip-core-image.bb?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


