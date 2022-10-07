Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01FBC433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 13:10:54 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.58])
 by mx.groups.io with SMTP id smtpd.web10.4167.1665148252956964099
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 06:10:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uOQK/eU9;
 spf=pass (domain: siemens.com, ip: 40.107.14.58,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3pvw3EKfgdBt314p9PxZM+iQ6OqWQvUF1YJIlIS9AaVAsW3KQ/4iUjj+TuBbxVYPHBQwGWb+SaKEjW/9eDxjUvl5UaR4vFaHsjlNpjFD57b4TtxizDdwYqOmRbxCRHbwrbZeAPobeW9ti7iwfTuGk0WdauZBlwmK1qbfac3eDIXZkD2UBbVewXc83cAokRkf9SJZUDCynDzOHZFK4uAsLK453hWs0ynq0Dk24pYJ0hIyW8/9jUZF0Xrf+8zxcDyFpgZNuGwua0kOiTq5R0JiEJZRXHyeb+6DdD8k/u11IHrWscqiwlf2TJU559PlyTKiqALxCSg0yDF/dqSv3Ke6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC46LTg32Z8PMrkMDrvDIdAyH/P95i9QV6g6uFzZyzk=;
 b=OI3F7udi76Ax95HPlb8gA0Sv1vGgUMboPDPu1QSQGUrAzgYjrGtF3S6doHC7hLV8ubKoHnl8/QNr+JDydH45XELsVG7pfK+1mYjTa+BG+sF/HLKynVEdpX54mi2EHCK/FhCv4s/nZYiLzCl97bvBRsRZf6BFBpi/+omG73nvXFE7CdY3kUcKj4irnu8KnFAdCfj2pijNbxhNvP3TjN9Bmpmjf1CY1i2q54awC7tKZYGfpwf0998ydN7NFbZAHrVgrPjTMBaH2fA1mb/XBtF+x5E7Jm+hCSblvtjhLCoGwxUlRLZjUcP3VurmcJSbfpJEuuPPaESPjgzZtk75jXj2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC46LTg32Z8PMrkMDrvDIdAyH/P95i9QV6g6uFzZyzk=;
 b=uOQK/eU9Hy7DuWge3ccLhkz5/Bfnk3HE7ngeBjPHzm5H015yPDFGdzwxb7hlBB/g+VcgRd5D5MdY4sOSEgUr+EFVNsTbJmJKf27yCBZHZ5j2PrJ1/W3+/TImh/iBEop6kimulI0xu4QRZwXC2dZFLd3Y+Z6AaGQxWzxSBU3YJFoDZyXhUup7kSTJtv8R8XLM5cxPkbISGg2hib2K7/EracMeDqfPt8hMaRxTFnVRqvI2aeShdo9z0xVYYwxj+SEVfE6gbiudMterM+C2RSn6xKNVxeT88VRmO1CvV4NoiJTzt2qd0ZlLd1PdpphmhNiwkVI89+CNG5lhcjsn1xoHNQ==
Received: from DB6PR07CA0193.eurprd07.prod.outlook.com (2603:10a6:6:42::23) by
 DB4PR10MB7015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Fri, 7 Oct 2022 13:10:49 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:42:cafe::73) by DB6PR07CA0193.outlook.office365.com
 (2603:10a6:6:42::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10 via Frontend
 Transport; Fri, 7 Oct 2022 13:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 13:10:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 15:10:47 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 15:10:47 +0200
Message-ID: <d45e2189-c68e-c87b-f1dc-83164c69adc4@siemens.com>
Date: Fri, 7 Oct 2022 15:10:46 +0200
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
 <237f4c8f-8f86-bbe2-9c62-d86bc2b1a431@siemens.com>
 <AM9PR10MB4869C618E2D6FDD8C617C101895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <55fb96d5-6fe9-b8f0-8649-f0c153ffd315@siemens.com>
 <AM9PR10MB4869009D33386D7F7304BA7A895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <AM9PR10MB4869009D33386D7F7304BA7A895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--13.435800-8.000000
X-TMASE-MatchedRID: gyGNsBFpAAw5QaOxwNGfvo9bHfxDWoibO5k/PxBAvv4HRzaQbsazqDgK
	qxRKlpUbUekjLrC3lTBHH7AyeolMkaVNzeXRGlTjYVoDTlX4T0x6DufCa1wWBz2LVJD+obB7yiK
	gKtIyB4r3Ru3JrjJxKEAc6DyoS2rIxdMDEDSgbA9RbTg1djx4TYaw96TXEsdWx64UvlSkg3GYaF
	4S+PMBO759Yrw3aQCH9lijtp+uizzWR6KNG5ytC91z8PUBYrV+nvp70Y6l9Aok3NzXU7fmeoxyU
	RzEbAdAzwO4AjhpI8g2sX5RAPlmCFiQTyESKwbI4Z3fuWes6vn9zlA2W6E9MBiA/AMvBVJEFASP
	1FmBuxZ7FqIgbQAcyLeiFqkxIdu24PkIhwvBc3q+L7W2wcUVqxHQbVLgwnYMzNIobH2DzGEO4jf
	a+nI3P8pQtXSznVsC6s5IQlEERpcASbyTkLMA9AhxhtZnDtnzRr1EVP8UqhPC0TXpqtexIiRoeP
	M4oGMVLX3qyf3ewG9osGAa+U7xDCd98RJY6NO8mZ1qYuQJVbvXznxnKDOSE1tTO+xodboGAZn/4
	A9db2RQKAQSutQYXGccffIoo2t1Yoko88aFBbZzrbszF3s2ealGv9OFH1+eUt2416ob94jBnL3A
	aGm9oxc4pb4OJgr2Bp7pikS0dkRQTWqzQfgfXION5IW+F5xoLEsdSh2aJpQItCy6ZX/lLzz3MFP
	wQ6W5gCOzL6v7C+dXjnF5s6t3kivn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt1of
	VlaoLUHQeTVDUrItRnEQCUU+jzjoczmuoPCq2iKCTqpxKzcfWcZZ+0yliE98g/2Hxj2MWxMOB2V
	GKdU81kr2y/dCk+
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.435800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 BA764B2A1782BEF75B86D70964D43A6AE6798E6F03901B9B222213A9CF5A50A72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT055:EE_|DB4PR10MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 986b9014-16de-4fa4-abd7-08daa8655ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5Myl4o73RZD31ILgMUPk/itg1C2/NsnE1OHKjNV2JnPz9Rt1niBgu2fL1WGwA5HFBdBOuDnRlcBCUTVBA+ZFQrWRb3MIURHIYL/Jh+UGUrEH3q5LNnEmq4VdsdoiOUvKPhpr/Ehv3Ita1FNaTOhwZvAJcNd1MV+yyfCH7X5067xoROzEg1/hSlchqcd9iWiLOGMkdgQlD/SFUTPGloHdP69bYntQN5myCu4I6FVZ/MAo07gM3NrE9wccOhVamZsNwJaAgkjI7yML4Yz725VsM9F3pauRromOldacTTcatYkb7I6Si92YIehRxeRqTRyiMvK5JqoQT+eiIqKXuzm1XHchjy+YeOAMc6xytCQl8l34pMBASyrCTcrAQLOg2aNAeQCrAOqJwmI9M/O/Ezkjd9zvVO5egv3adUTwjGfxjTXP4K6d5sTe76qGhzFOMWdC5mRRchJgb8KlZKBAsbXzA7skdsutoJI0J+LuXiXPTH3kY2L2e4nXe6VAW6F6vCYmZ6/GJZWmusQwXVO4CTitnY83sln2Xsz8455666rkNNopKZf1d4GIXRXvgYpc2YQk6uVzKUfm8Jz1VdVcPSzeYvm9qWLq67mwIcXzk0HCcXbmIDPQvkxpaxwTRrsld6Oqt7jcxXOym6FKx3iH1GN75GS7+5v+0ZFdkr8mcoG39lAnkKZnlAVGfaJOhnt5t4k5oDGTZYoIYLcyVnJMQf5jKBnW4ckE3cKV6SZBEfFSkUK70Xuk75ZhGr1oEV60Eu00g5nvyvemdPN5jnO9+/Rqo+zsXnMC9I2XeuX+DZ3JqCmAOdNtzXwzIp/Z70TGxyW9rOYsMDiGVOWJVHxToKqqoHNDhwWBP3LFqDmHZKfPpf8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(316002)(956004)(186003)(16526019)(83380400001)(336012)(2616005)(81166007)(82740400003)(82960400001)(47076005)(44832011)(36860700001)(478600001)(5660300002)(41300700001)(2906002)(82310400005)(356005)(8936002)(40460700003)(40480700001)(70586007)(53546011)(26005)(6706004)(16576012)(4326008)(70206006)(8676002)(110136005)(6636002)(36756003)(31686004)(86362001)(31696002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 13:10:49.5991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 986b9014-16de-4fa4-abd7-08daa8655ae9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 13:10:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9694

On 07.10.22 15:07, Moessbauer, Felix (T CED SES-DE) wrote:
>>>>>>>> On 10/1/22 06:52, Felix Moessbauer wrote:
>>>>>>>>> When using the cip-core layer in another layer that has a
>>>>>>>>> slightly different directory structure, bitbake is not able to
>>>>>>>>> resolve the included files.
>>>>>>>>>
>>>>>>>>> To fix this, we simply add the full path to the file so bitbake
>>>>>>>>> is able to locate it independent of the downstream layer configuration.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>>>>>>>> ---
>>>>>>>>>   kas/opt/ebg-swu.yml  | 2 +-
>>>>>>>>>   kas/opt/swupdate.yml | 2 +-
>>>>>>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml index
>>>>>>>>> 8b3ffec..78227f1 100644
>>>>>>>>> --- a/kas/opt/ebg-swu.yml
>>>>>>>>> +++ b/kas/opt/ebg-swu.yml
>>>>>>>>> @@ -20,7 +20,7 @@ local_conf_header:
>>>>>>>>>       SWUPDATE_BOOTLOADER = "efibootguard"
>>>>>>>>>       IMAGE_INSTALL_remove = "u-boot-script"
>>>>>>>>>     ebg_swu_image_options: |
>>>>>>>>> -    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>>>>>>>>> +    CIP_IMAGE_OPTIONS_append = "
>>>>>>>>> + recipes-core/images/efibootguard.inc
>>>>>>>> recipes-core/images/image-uuid.inc"
>>>>>>>>>     initramfs: |
>>>>>>>>>       INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>>>>>>>>>     firmware-binaries: |
>>>>>>>>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml index
>>>>>>>>> 8ba03c9..e32ce20 100644
>>>>>>>>> --- a/kas/opt/swupdate.yml
>>>>>>>>> +++ b/kas/opt/swupdate.yml
>>>>>>>>> @@ -16,7 +16,7 @@ header:
>>>>>>>>>
>>>>>>>>>   local_conf_header:
>>>>>>>>>     image-option-swupdate: |
>>>>>>>>> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
>>>>>>>>> +    CIP_IMAGE_OPTIONS_append = " recipes-
>> core/images/swupdate.inc"
>>>>>>>>>
>>>>>>>>>     wic-swu: |
>>>>>>>>>       IMAGE_CLASSES += "squashfs"
>>>>>>>>
>>>>>>>> It would be nice if we could write the options without the full
>>>>>>>> path
>>>> necessary.
>>>>>>>
>>>>>>> Hi Quirin,
>>>>>>>
>>>>>>> This unfortunately does not work, as the options are passed to an
>>>>>>> "include" or
>>>>>> "require" bitbake keyword.
>>>>>>> And by that, we have to comply with the logic of the keyword.
>>>>>>> Or do I miss something, @Jan?
>>>>>>
>>>>>> I suppose the key question is whether you are consuming
>>>>>> CIP_IMAGE_OPTIONS in your own image recipe or via
>>>>>> cip-core/recipes-core/images/cip-core-
>>>>>> image.bb. The latter should work - or are we simply missing a
>>>>>
>>>>> I just consume the CIP_IMAGE_OPTIONS in my image, as the
>>>>> cip-core-image
>>>> also contains "customization", which I do not need in my image.
>>>>> Maybe these should be carved out as well.
>>>>
>>>> Everyone needs customizations in their images - just overload it.
>>>
>>> I dislike the <VAR>_remove pattern that has already spread across layers as
>> upstream layers (including ISAR itself) tend to mix up infrastructure and
>> examples.
>>
>> Nope, I meant implement your own customization recipe - which is what you
>> will do anyway.
>>
>>> And please don't dictate how a downstream user does it's customization.
>>
>> I have seen no layer so far that does not have a customization package.
>>
>>> From a base image, I would never expect to bring any customizations or
>> examples.
>>> If that is the case, I simply don't use it as a base but copy the pattern (which
>> breaks the build here).
>>
>> Anyway, we can define a cip-core-image-base and make the cip-core-image the
>> usable one for cip-core itself (demo, testing etc.). That would also allow to push
>> some parameters out of kas-cip.yml, which is ugly anyway.
> 
> Yes, I agree. Setting bb includes via kas felt somehow strange to me.
> 
>>
>>>
>>>>
>>>>>
>>>>> And whatever ends up in CIP_IMAGE_OPTIONS should be "standalone",
>>>> meaning it should always contain full paths to avoid name conflicts
>>>> with recipes in the downstream layer.
>>>>
>>>> CIP_IMAGE_OPTIONS were so far designed for cip images, that's why it
>>>> has "CIP_IMAGE" in its name.
>>>
>>> Fine, but is CIP a pattern database that users should copy from or a layer to be
>> included?
>>> I vote for the layer and inheritance approach instead of the database.
>>>
>>>>
>>>>> And there should be a bold statement in the docs that downstream
>>>>> layers shall
>>>> use "requires" for including CIP_IMAGE_OPTIONS as missed includes
>>>> lead to weird errors in later steps when assembling the image.
>>>>
>>>> That is that nasty bitbake syntax again - we should fix
>>>> cip-core-image to use "require", rather than misleading "include", to avoid
>> spreading that mistake.
>>>> (And swupdate_2021.11-1+debian-gbp.bb should be fixed as
>>>> well...)
>>>
>>> I don't know if "requires <nothing>" works, but if that works then please
>> switch.
>>>
>>
>> Yes, works equally well.
>>
>>>>
>>>> But the key question remains if we should convert "CIP_IMAGE_OPTIONS"
>>>> to a generic "IMAGE_OPTIONS". I'm not yet sure at which level to do
>>>> the cut and suggest the reuse. Before tuning details, it's likely the
>>>> right time to rethink the overall concept (which I postponed so far).
>>>
>>> IMHO, CIP_IMAGE_OPTIONS is fine as IMAGE_OPTIONS is too generic.
>>> Downstream layers (basically leaves of the inheritance tree) might already use
>> that variable and this might conflict.
>>>
>>> Why not simply fix this include before rethinking the overall concept?
>>> The CIP core layer is pretty easy to integrate into downstream layers, except
>> for this nasty detail.
>>
>> Nope, it's not yet. We have too many ways to consume cip-core downstream
>> already, and that makes me unhappy. I was hoping that things naturally fit, but
>> the way you picked things up showed that they don't.
>>
>> Are you also using the kas option files as-they-are then?
> 
> Yes, via includes.
> But this part is actually not trivial, as you have to include the files in the correct order and play around with the weak assignments, order of layer.conf, local.conf and machine.conf.
> And unfortunately you cannot patch kas files with kas, so I was not able to patch the paths to the includes.
> Instead I had to work around by using the following pattern (which is extremely ugly):
> CIP_IMAGE_OPTIONS_remove = "efibootguard.inc image-uuid.inc swupdate.inc"
> CIP_IMAGE_OPTIONS_append = " recipes-core/images/efibootguard.inc recipes-core/images
> 
> Maybe all that is an antipattern and I should have simply used bitbake to include the recipes directly instead of re-using the kas files from cip.
> IMO there is too much logic in the kas files which should be shifted to the recipes and toggled via BB variables.
> But that's something which should be stated in the docs.

Yes, that's also why I was not using the kas files themselves in
meta-iot2050. But that one is also not on the latest isar-cip-core
version yet, so not fully comparable here.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


