Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B532C433FE
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 10:29:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.76])
 by mx.groups.io with SMTP id smtpd.web08.2814.1665138581105480218
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 03:29:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=s2yw3h6H;
 spf=pass (domain: siemens.com, ip: 40.107.21.76,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqIsGdfgkgx0TTC9V5LOlQ6Pe1HVaf1hNMM9CeKdsvGlsTuBDXkaJIS0pc9HUpBw3W41MWuxii1bqUWCk1eF7Jf05ZZMjeyV6OnNc61YXkRxprKnEauxYFgrQFOkaBkVOg+KX/oqubeUxCSogFvzvmd9pwZyRNPhfveHodBoW6hAkfWPcrq6O7ZOsjNpiCwVfhbQz9d63knSLmKN5Db0GOU4U4028MT3THzzCITRonXqzDYxZZNQTNFs+4KsRoq7eArWXaXjyJWUD8FiK+da8jCmsHKnKsvDgHsMnBPUTg0RyS4yNKRUzWpCK9cn+JBzuXmH1KEY3joiv1LAdByZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRTzJWECrsoiVOTSGK42aoMNdInflUFXyEdSJy/UX1I=;
 b=g53/ujUoznAtPZ9T1sFMdizDeV5pCPvUsv7lkMoS/8TrhciqBn0B+Vlzy9YadNtRfzQZwTVNvtczrbuuJ4gZOacGrlWa13OqVzFYWpAdiXZQCwvWolWeo+DS9Chw/Koo0jyZqugCQzhhuJUZqVMeDn2dxmxDmzDbK6gA2Hze8v23LdQtGmHKIOJg6hW43uzT/q9JwTCis7eRui41ZriauTsu+AuQfMlfMoG8JvSA2kMbMYlp5uNUZM+03cbYIHwzE8Qfk++oKvWksNkAxmrz89yjMXLRoYxUzWYCqO2+HJxXxTHFFE67rBNRaGU8DU+OMoaRO9jWFr0dZqi3OgzDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRTzJWECrsoiVOTSGK42aoMNdInflUFXyEdSJy/UX1I=;
 b=s2yw3h6HGeH8tD0CvcI0POcrQ/Z6yBPJVmpOh3wBL0K7KelSxIAUlfnnN8d2TjMLD4xQIzaXzdjR3j49IhF6cHD48LabmmaI0nQ+wEXYu2KpCNIxBxGRXRYsElSZMcH7B4vNFdHpFM3Ozwhq+qzDHY7x5hdT7uj00/82RSeXQq7qTbL0XyU3Uh2ZBPOjod89p8ryoeVMezA3FcunW9pXATnJ7bpeyh5JYWPodoerUe5gaIsCyUe2bNYg0jf0wU5Tx5BzV+wpjeV/i2NCVu+PeVwO5XFjauV9hJT1iNk/4AAdaAd1adsHLQPxRcp9CcOqo+romWtjlUueU04U6p2qOg==
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by VE1PR10MB3869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 10:29:37 +0000
Received: from DB5EUR01FT097.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::8b) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.39 via Frontend
 Transport; Fri, 7 Oct 2022 10:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT097.mail.protection.outlook.com (10.152.5.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 10:29:36 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 12:29:36 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 12:29:35 +0200
Message-ID: <237f4c8f-8f86-bbe2-9c62-d86bc2b1a431@siemens.com>
Date: Fri, 7 Oct 2022 12:29:22 +0200
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
 <fd47b229-9803-4298-43bf-9924dbd6aa7e@siemens.com>
 <AM9PR10MB4869AFE16C8761F01E5A7C0C895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <AM9PR10MB4869AFE16C8761F01E5A7C0C895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.091700-8.000000
X-TMASE-MatchedRID: ZCcPN3gXkNg5QaOxwNGfvo9bHfxDWoib1xQ2OgXti5VTL5B6BWU2DXg9
	csuuqcCgfhcIM0AFu8DZTAEszxrPVNDqDhdAJf7mMz3hfWINayt2+9t+1OwlJwdHNpBuxrOoOAq
	rFEqWlRtR6SMusLeVMEcfsDJ6iUyRpU3N5dEaVONhWgNOVfhPTHoO58JrXBYHPYtUkP6hsHvKIq
	Aq0jIHivdG7cmuMnEoQBzoPKhLasjF0wMQNKBsD40k3VSs/x5W6FoWuW7WfbznBcjWg41W4FdEE
	mf6TRVBTJDyHMXec/bG819xxWXqwJqKgfLdQv5CxKmwTS15I7PE678vw19TDw1ZJPghvOynEqfa
	6mOo3hLtX9Gt3sULEj/21AwfBazEC4OeH1pk+kq0ApT6ZEBmEp/51VneE1l3aK+MsTwM+1moSgR
	E9rhqixcEqqa7hWag/2a6ePNzgrip2zo5sC0TB6YjokWbnhUfExzvxkft9nnnVHXBUzVvZObD6n
	EJCPKbEtrBvERHaW3s5+nhNoK8J6sjXQwH/XtFQFzByzV52MuV76rqTtD9zC/MuWzsdN8Zy0MfD
	1GsI1ubKItl61J/ycnjLTA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/sejlDGa548LlQYfgu
	p6nGqCC7zPhIdchpTO5ABhoBPzwv4sCruI/7/Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.091700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9C0E0FB8B79B75E57DE7805B7CB4480BF73A8BD96FCBE85B3E3302754F2042E02000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT097:EE_|VE1PR10MB3869:EE_
X-MS-Office365-Filtering-Correlation-Id: bffc493a-4c73-4008-c32d-08daa84ed56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uY7FE9bp7bb9JlJxklcOEBkoqpHirSF98Y5CBjcaHH+q7I3YyKP4WBSiGSNGAkQhW8MBfA8576RZGFtFAOk9RsNA+GVdG9s4MgqbBtIMI0ratIeF3Js4vkeKDmP0oKhheXKvBJSTz7HSVMAYlvfoshEbKPcH+46UDyaqU4omNmoWssRD4gR0oz864o+po6ogOy0CIt8+E1cn9kJF8383ZhC97KAsfeKPmCuB5TsCwod2+UuTUrayZtPWkGcX4r5iifajgVrGrz16Y533Pr2+2aBgUokuYRsZHNCIBiR3J+3c0yvIOjTpKMAnjHSss0/0SDpAyZ8WQ3UjMlMjU/nWepWS8ZvoJ/HiodWLyzojUNBfAAeuMGa9BCo46nhOjneRND0XR8Jx6Ele/X1jxJ5MfJPgbB/gTFqtMSjwXYVgSTgO15LsDnZ5EAXH0alwZTaSWtuDIPYHza53TPknsLb/3hi6N2x69B6fAQcqfqzUQVQxE4qBII+D4CZ/RIRdLP/XbGGOfEwiy+k9O4TZeAeuqHEeDIgxGCPcFAjcfospWy7w8PJEx1cE9szGXOlhHRi52/G0sqR3xjXyhjV57ECX4qhLD+B3lABMlQJS23zZ/5saZLGtxoDC0Sf6XH9S0BEolsCkfLH7TN9hU+CUe6ntmZGxwnwqT4brrT5VGZWJKXyNeQu0PTnR64Y1/iu/R8ZslXeLuUl+3bJjP3BCiiC0WGAJR54XKbTlckQfGFOEHROPMwqAngJWO88bKx5f8iUfsHR2Pi2+41K/ThQUMl/zq5IuK9bNvDZ46ULIO7b79g5V/0SMENNEhXoIgEfNTk20RMRsTJSPxbOYsHjpVpaUVA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(53546011)(186003)(86362001)(956004)(7596003)(478600001)(2616005)(70206006)(31696002)(8676002)(26005)(2906002)(44832011)(6636002)(110136005)(16576012)(6706004)(40480700001)(40460700003)(36860700001)(7636003)(336012)(47076005)(356005)(16526019)(82740400003)(83380400001)(41300700001)(5660300002)(82960400001)(8936002)(70586007)(4326008)(316002)(31686004)(82310400005)(6666004)(36756003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:29:36.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bffc493a-4c73-4008-c32d-08daa84ed56b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3869
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 10:29:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9678

On 07.10.22 11:40, Moessbauer, Felix (T CED SES-DE) wrote:
>> -----Original Message-----
>> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Sent: Friday, October 7, 2022 5:11 PM
>> To: Moessbauer, Felix (T CED SES-DE) <felix.moessbauer@siemens.com>;
>> Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>
>> Cc: cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
>> CIP_IMAGE_OPTIONS
>>
>> On 07.10.22 10:53, Moessbauer, Felix (T CED SES-DE) wrote:
>>>> -----Original Message-----
>>>> From: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>
>>>> Sent: Friday, October 7, 2022 4:08 PM
>>>> To: Moessbauer, Felix (T CED SES-DE) <felix.moessbauer@siemens.com>;
>>>> cip- dev@lists.cip-project.org; Kiszka, Jan (T CED)
>>>> <jan.kiszka@siemens.com>
>>>> Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
>>>> CIP_IMAGE_OPTIONS
>>>>
>>>>
>>>>
>>>> On 10/1/22 06:52, Felix Moessbauer wrote:
>>>>> When using the cip-core layer in another layer that has a slightly
>>>>> different directory structure, bitbake is not able to resolve the
>>>>> included files.
>>>>>
>>>>> To fix this, we simply add the full path to the file so bitbake is
>>>>> able to locate it independent of the downstream layer configuration.
>>>>>
>>>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>>>> ---
>>>>>   kas/opt/ebg-swu.yml  | 2 +-
>>>>>   kas/opt/swupdate.yml | 2 +-
>>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml index
>>>>> 8b3ffec..78227f1 100644
>>>>> --- a/kas/opt/ebg-swu.yml
>>>>> +++ b/kas/opt/ebg-swu.yml
>>>>> @@ -20,7 +20,7 @@ local_conf_header:
>>>>>       SWUPDATE_BOOTLOADER = "efibootguard"
>>>>>       IMAGE_INSTALL_remove = "u-boot-script"
>>>>>     ebg_swu_image_options: |
>>>>> -    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>>>>> +    CIP_IMAGE_OPTIONS_append = "
>>>>> + recipes-core/images/efibootguard.inc
>>>> recipes-core/images/image-uuid.inc"
>>>>>     initramfs: |
>>>>>       INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>>>>>     firmware-binaries: |
>>>>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml index
>>>>> 8ba03c9..e32ce20 100644
>>>>> --- a/kas/opt/swupdate.yml
>>>>> +++ b/kas/opt/swupdate.yml
>>>>> @@ -16,7 +16,7 @@ header:
>>>>>
>>>>>   local_conf_header:
>>>>>     image-option-swupdate: |
>>>>> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
>>>>> +    CIP_IMAGE_OPTIONS_append = " recipes-core/images/swupdate.inc"
>>>>>
>>>>>     wic-swu: |
>>>>>       IMAGE_CLASSES += "squashfs"
>>>>
>>>> It would be nice if we could write the options without the full path necessary.
>>>
>>> Hi Quirin,
>>>
>>> This unfortunately does not work, as the options are passed to an "include" or
>> "require" bitbake keyword.
>>> And by that, we have to comply with the logic of the keyword.
>>> Or do I miss something, @Jan?
>>
>> I suppose the key question is whether you are consuming CIP_IMAGE_OPTIONS
>> in your own image recipe or via cip-core/recipes-core/images/cip-core-
>> image.bb. The latter should work - or are we simply missing a
> 
> I just consume the CIP_IMAGE_OPTIONS in my image, as the cip-core-image also contains "customization", which I do not need in my image.
> Maybe these should be carved out as well.

Everyone needs customizations in their images - just overload it.

> 
> And whatever ends up in CIP_IMAGE_OPTIONS should be "standalone", meaning it should always contain full paths to avoid name conflicts with recipes in the downstream layer.

CIP_IMAGE_OPTIONS were so far designed for cip images, that's why it has
"CIP_IMAGE" in its name.

> And there should be a bold statement in the docs that downstream layers shall use "requires" for including CIP_IMAGE_OPTIONS as missed includes lead to weird errors in later steps when assembling the image.

That is that nasty bitbake syntax again - we should fix cip-core-image
to use "require", rather than misleading "include", to avoid spreading
that mistake. (And swupdate_2021.11-1+debian-gbp.bb should be fixed as
well...)

But the key question remains if we should convert "CIP_IMAGE_OPTIONS" to
a generic "IMAGE_OPTIONS". I'm not yet sure at which level to do the cut
and suggest the reuse. Before tuning details, it's likely the right time
to rethink the overall concept (which I postponed so far).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


