Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C89C433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:51:04 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.83])
 by mx.groups.io with SMTP id smtpd.web09.3518.1665143462721232594
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:51:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pL3ijXyw;
 spf=pass (domain: siemens.com, ip: 40.107.7.83,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yxw/yuc3/MFRQVSikVL+a/O/cU8C4ldra7ckRwATSuT4WbxxBE4K7Vr/VXd4Y0ANg+he82id/3BjYt9SpCw5W6zpgVRfA+lyK+zd1f5BTAZLghpUXc3iqjGhdJArkVAE5ekxIlZLleia/uVJCgQH1jooyx9hTgvMIJMzlMBcKPMBgQJGhmiJ6scDv78oyA1AY2EcSvvVcqrb52uakIXvTEypQTK3F2JfWQCQ35/RHulDAQKoTHxdrHjADQOAqRveevsXjIbyP2txheUx+kTO5Zt7I4U6OBRmV/uSqW2CWLtFXx7NirNNj80mK3JlSWAFi+P4XjfRGbH99Tq2BnDVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g5hr0JHQr8wsmUog9GC3HzlutuCMqYYsUMD2Tru7Tw=;
 b=l1htYMGHarDKvt3Lu55ZsP4zrvx+C6U4Ei6D0uVTdRZE1sUWspmn2ibNn75lmOL7p9+AwwNwONg7EZF4/Jblq9/iFW4ws885tDrW2FMQw316ziYP+CygTtn8BPNCJdX0OUOP7xD+8l75f3cVjaRotSngJGuCw1nnJMNsEs6s4wonsT31QHVGmyNWEbpoGyaf43j9eP0Q+9ma66UVwbKHTKpoWFJhQlfcflcYrYbxHK3VsGMoLgst61vdmsAKdXIcL7WMN9vWgZmjel/IqB7/1UYKdw0CGFzFyPWOO6LjnzPhs3e+HKWaSMCunLYImiysTi89sagP4YPiLD/EMJyyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g5hr0JHQr8wsmUog9GC3HzlutuCMqYYsUMD2Tru7Tw=;
 b=pL3ijXywg6yaHfEZKaoBFWmTOxh0N75+dxs4t1WrsyMNT7Ga6QqwKW4bOOk+ZWc69mhVq4SV9ezRoiPHUL4Yk0D4f4Y/mi3ascISdBh/riD5jvCVOeO34P6grXMzjDnUBIa5ZH3pBFlBz3u/iuugkiphXwY7JHE/C0FzEMclZ/6yWwx8SBP3P0f/TKpRgFaJjaNtg2xwljG3f/PerEqe56krgruVWnUJDkkjHXyInRQHBe3R6K+Sb0x+RAC/Bmg2Qh7VxuO8zIjjQplKQne5bxIx+Vk02zRXMHSjv2P5G8EPkvCnnXirpivFkHHI6Er3TEpKPJmpb0JcN6f/LOgDgw==
Received: from DB6PR0301CA0101.eurprd03.prod.outlook.com (2603:10a6:6:30::48)
 by PAVPR10MB7403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 7 Oct
 2022 11:50:58 +0000
Received: from DB5EUR01FT045.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::2c) by DB6PR0301CA0101.outlook.office365.com
 (2603:10a6:6:30::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Fri, 7 Oct 2022 11:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT045.mail.protection.outlook.com (10.152.4.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 11:50:58 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 7 Oct 2022 13:50:57 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Fri, 7 Oct 2022 13:50:56 +0200
Message-ID: <55fb96d5-6fe9-b8f0-8649-f0c153ffd315@siemens.com>
Date: Fri, 7 Oct 2022 13:50:54 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <AM9PR10MB4869C618E2D6FDD8C617C101895F9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.722900-8.000000
X-TMASE-MatchedRID: 2hWRz9pwX005QaOxwNGfvo9bHfxDWoib1xQ2OgXti5VTL5B6BWU2DXg9
	csuuqcCgfhcIM0AFu8DZTAEszxrPVNDqDhdAJf7mMz3hfWINayt2+9t+1OwlJwdHNpBuxrOoOAq
	rFEqWlRtR6SMusLeVMEcfsDJ6iUyRpU3N5dEaVONhWgNOVfhPTHoO58JrXBYHPYtUkP6hsHvKIq
	Aq0jIHivdG7cmuMnEoQBzoPKhLasjF0wMQNKBsD40k3VSs/x5W6FoWuW7WfbznBcjWg41W4FdEE
	mf6TRVBTJDyHMXec/bG819xxWXqwJqKgfLdQv5CxKmwTS15I7PE678vw19TDw1ZJPghvOynEqfa
	6mOo3hLtX9Gt3sULEj/21AwfBazEC4OeH1pk+kq0ApT6ZEBmEgTf0tSmYPmnN2lv+25ekmdzmB7
	1otxffC5SnAtH4tjpzKACX7I5tE7vzFEn8ElXn/RiXwPA6YLBGnqsZ8sRr2KRgPzABkqxIGpiq4
	KsutXCyPRAwD/3abbD0zVOu+RJh6vwoPy4UoLIsPAy0Qg+1LkDpmiSD/gHb2TJXSYk53OhT5ysQ
	Dj6eFkqqwCLMi+DvA0hMgLyaDPsFRlxiF1eFJss2HGkJe4cXoir9MqcjAA9JmbrB1j4Xwr4h+uI
	7dxXxNbeAkxuakSW3dRQwMbAzBN0R/I0f0ywrdJ1eSkdVNzz6JRmxKGXF5XQfyKEYQc1R/z7lvs
	CT1L8JvSvlpvK74Hjo+A3552ljSvn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt1of
	VlaoLUHQeTVDUrIhzhYvkmN3zwjaPj0W1qn0Q7AFczfjr/7Do83XUpo2Iw3dnLgslEKPYWkjL4X
	MvlAJINGVjmH1GKaRT6FShqOME=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.722900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 EDFDAF0E396177DF191B8C2970DC5B75A9673E43B236CE4CDF076CBBA83BFA662000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT045:EE_|PAVPR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 886549df-94f1-4219-714a-08daa85a331b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wMiS0ot1i/6bGSyuOda+YDtJq+00c07bcLfFLsuyveISvU4UTfXrp7KDfdZJEyCYpAYHoAv3DfbdU6uGY4uYwFgFi7b3+MS5AcjwFPVDdVDWPhFZXNM7b8VG/55vqS7VXMkKxJtNe9ETVFxaJjhkBPXGntvPwH7VwmxXEy943SJ2Pmsf1lUQw0rRZ9IQp2que2mY15B/5b60IsdMaf5NeaTd7um6Zi+Lh2fed6iWGkE/holnHb5JBsz4cLn4lEQTqwM3UJr+pZIFeZFqsa3fRzwFWQ8kWIicO09fP7SOeu2EX44uyUCZqF1Tgbc6WFJDZuI+ocQEmoZgAShTwgdmnB4XUIaiQ1JOLLCP4l9FJYskZF4BQgWJCNd9KDzN4tGMvKhxl1mrKZi9v/R6cgJSfJSLe0HaC3eOQhISNJjbjV4wgXzFcKsoEwMqbTgwq3+MA692w5T3G9Ug9mOmr8kMe6qREQhHGY9O/F3HKvVap/GCdtsr/tCSjTeofNqufxqX8tyeUaMEMkb22l71SIMyXsE30lse1qonDXV+6CbQiPOpisg8FeR1fht6N/PaoKGC5cUu0pAYPK91bHd2x2ALIJGeZ6begZcCU5OLD8YSd8BzxR2U30gEBJxKhLKuSpZM4byRr0maulQ3/8banOifUGtM33zRMpNSgxs/kSjb390wx21FPJ4Dgaa2spEgXFDhn+nHfLUOdQKciz6iXI8hGyPHtS+5YhJwi5NHsyvlmhhmXMOxCQHe4gKQbqXspTbvmW2GGPNiTR5H2ckwcxyOgMe9dkg9tSoI2LDJwqZFaDla3/AlBJpvO3zHf/kWcZzkUuS5f0SGC+xSFETESd7Ifg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(2906002)(31686004)(8936002)(5660300002)(6706004)(316002)(16576012)(8676002)(70206006)(36860700001)(70586007)(4326008)(110136005)(82310400005)(86362001)(36756003)(336012)(6636002)(41300700001)(31696002)(53546011)(47076005)(83380400001)(478600001)(82960400001)(956004)(16526019)(2616005)(26005)(40480700001)(44832011)(356005)(7596003)(40460700003)(82740400003)(7636003)(186003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 11:50:58.3524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 886549df-94f1-4219-714a-08daa85a331b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT045.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:51:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9686

On 07.10.22 13:25, Moessbauer, Felix (T CED SES-DE) wrote:
>> -----Original Message-----
>> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Sent: Friday, October 7, 2022 6:29 PM
>> To: Moessbauer, Felix (T CED SES-DE) <felix.moessbauer@siemens.com>;
>> Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>
>> Cc: cip-dev@lists.cip-project.org
>> Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
>> CIP_IMAGE_OPTIONS
>>
>> On 07.10.22 11:40, Moessbauer, Felix (T CED SES-DE) wrote:
>>>> -----Original Message-----
>>>> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>>>> Sent: Friday, October 7, 2022 5:11 PM
>>>> To: Moessbauer, Felix (T CED SES-DE) <felix.moessbauer@siemens.com>;
>>>> Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>
>>>> Cc: cip-dev@lists.cip-project.org
>>>> Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
>>>> CIP_IMAGE_OPTIONS
>>>>
>>>> On 07.10.22 10:53, Moessbauer, Felix (T CED SES-DE) wrote:
>>>>>> -----Original Message-----
>>>>>> From: Gylstorff, Quirin (T CED SES-DE)
>>>>>> <quirin.gylstorff@siemens.com>
>>>>>> Sent: Friday, October 7, 2022 4:08 PM
>>>>>> To: Moessbauer, Felix (T CED SES-DE)
>>>>>> <felix.moessbauer@siemens.com>;
>>>>>> cip- dev@lists.cip-project.org; Kiszka, Jan (T CED)
>>>>>> <jan.kiszka@siemens.com>
>>>>>> Subject: Re: [isar-cip-core][PATCH 1/1] use qualified path for
>>>>>> CIP_IMAGE_OPTIONS
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/1/22 06:52, Felix Moessbauer wrote:
>>>>>>> When using the cip-core layer in another layer that has a slightly
>>>>>>> different directory structure, bitbake is not able to resolve the
>>>>>>> included files.
>>>>>>>
>>>>>>> To fix this, we simply add the full path to the file so bitbake is
>>>>>>> able to locate it independent of the downstream layer configuration.
>>>>>>>
>>>>>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>>>>>> ---
>>>>>>>   kas/opt/ebg-swu.yml  | 2 +-
>>>>>>>   kas/opt/swupdate.yml | 2 +-
>>>>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml index
>>>>>>> 8b3ffec..78227f1 100644
>>>>>>> --- a/kas/opt/ebg-swu.yml
>>>>>>> +++ b/kas/opt/ebg-swu.yml
>>>>>>> @@ -20,7 +20,7 @@ local_conf_header:
>>>>>>>       SWUPDATE_BOOTLOADER = "efibootguard"
>>>>>>>       IMAGE_INSTALL_remove = "u-boot-script"
>>>>>>>     ebg_swu_image_options: |
>>>>>>> -    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>>>>>>> +    CIP_IMAGE_OPTIONS_append = "
>>>>>>> + recipes-core/images/efibootguard.inc
>>>>>> recipes-core/images/image-uuid.inc"
>>>>>>>     initramfs: |
>>>>>>>       INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>>>>>>>     firmware-binaries: |
>>>>>>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml index
>>>>>>> 8ba03c9..e32ce20 100644
>>>>>>> --- a/kas/opt/swupdate.yml
>>>>>>> +++ b/kas/opt/swupdate.yml
>>>>>>> @@ -16,7 +16,7 @@ header:
>>>>>>>
>>>>>>>   local_conf_header:
>>>>>>>     image-option-swupdate: |
>>>>>>> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
>>>>>>> +    CIP_IMAGE_OPTIONS_append = " recipes-core/images/swupdate.inc"
>>>>>>>
>>>>>>>     wic-swu: |
>>>>>>>       IMAGE_CLASSES += "squashfs"
>>>>>>
>>>>>> It would be nice if we could write the options without the full path
>> necessary.
>>>>>
>>>>> Hi Quirin,
>>>>>
>>>>> This unfortunately does not work, as the options are passed to an
>>>>> "include" or
>>>> "require" bitbake keyword.
>>>>> And by that, we have to comply with the logic of the keyword.
>>>>> Or do I miss something, @Jan?
>>>>
>>>> I suppose the key question is whether you are consuming
>>>> CIP_IMAGE_OPTIONS in your own image recipe or via
>>>> cip-core/recipes-core/images/cip-core-
>>>> image.bb. The latter should work - or are we simply missing a
>>>
>>> I just consume the CIP_IMAGE_OPTIONS in my image, as the cip-core-image
>> also contains "customization", which I do not need in my image.
>>> Maybe these should be carved out as well.
>>
>> Everyone needs customizations in their images - just overload it.
> 
> I dislike the <VAR>_remove pattern that has already spread across layers as upstream layers (including ISAR itself) tend to mix up infrastructure and examples.

Nope, I meant implement your own customization recipe - which is what
you will do anyway.

> And please don't dictate how a downstream user does it's customization.

I have seen no layer so far that does not have a customization package.

> From a base image, I would never expect to bring any customizations or examples.
> If that is the case, I simply don't use it as a base but copy the pattern (which breaks the build here).

Anyway, we can define a cip-core-image-base and make the cip-core-image
the usable one for cip-core itself (demo, testing etc.). That would also
allow to push some parameters out of kas-cip.yml, which is ugly anyway.

> 
>>
>>>
>>> And whatever ends up in CIP_IMAGE_OPTIONS should be "standalone",
>> meaning it should always contain full paths to avoid name conflicts with recipes
>> in the downstream layer.
>>
>> CIP_IMAGE_OPTIONS were so far designed for cip images, that's why it has
>> "CIP_IMAGE" in its name.
> 
> Fine, but is CIP a pattern database that users should copy from or a layer to be included?
> I vote for the layer and inheritance approach instead of the database.
> 
>>
>>> And there should be a bold statement in the docs that downstream layers shall
>> use "requires" for including CIP_IMAGE_OPTIONS as missed includes lead to
>> weird errors in later steps when assembling the image.
>>
>> That is that nasty bitbake syntax again - we should fix cip-core-image to use
>> "require", rather than misleading "include", to avoid spreading that mistake.
>> (And swupdate_2021.11-1+debian-gbp.bb should be fixed as
>> well...)
> 
> I don't know if "requires <nothing>" works, but if that works then please switch.
> 

Yes, works equally well.

>>
>> But the key question remains if we should convert "CIP_IMAGE_OPTIONS" to a
>> generic "IMAGE_OPTIONS". I'm not yet sure at which level to do the cut and
>> suggest the reuse. Before tuning details, it's likely the right time to rethink the
>> overall concept (which I postponed so far).
> 
> IMHO, CIP_IMAGE_OPTIONS is fine as IMAGE_OPTIONS is too generic.
> Downstream layers (basically leaves of the inheritance tree) might already use that variable and this might conflict.
> 
> Why not simply fix this include before rethinking the overall concept?
> The CIP core layer is pretty easy to integrate into downstream layers, except for this nasty detail.

Nope, it's not yet. We have too many ways to consume cip-core downstream
already, and that makes me unhappy. I was hoping that things naturally
fit, but the way you picked things up showed that they don't.

Are you also using the kas option files as-they-are then?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


