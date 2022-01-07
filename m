Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DEDC433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 10:23:00 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.65])
 by mx.groups.io with SMTP id smtpd.web10.4934.1641550979177263128
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:23:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tpe5G7sz;
 spf=pass (domain: siemens.com, ip: 40.107.20.65,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPASq2miDPgiCQ75wFwUabh4Oy++goHhugeqsqDvKEfhUtel8XmeoEV5Lnd3uT8pzzi/9Fo+7PPVd6w0MCizQ3oCRKCzJPf/ZMJjxmI7KLtrrlBTJRTQLQuXOtL1Jhdgd+itFIqjJarVrNrDJXg+G9YwgSMPMUm1sL7FTGFOGeDTOcJw4FcvkQP/DnOhTSKiPEo1Il2kyESIxzEtM5afFWX95Vlzu4yJh04JwENZkBsRsUFB7nF0gQhjuPIsFi3nysV+XL2XOcdbhmCCFm+4i+I1jBwjPZG2gpJdXg1BlF+nZUXa/NvTgcb5CA9B8jKEIuQ25cMffqBXMUt6EJUFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwDRMFsPNw2YsyT7Tl16fcfnX/KNMCauan7C2eNJqdw=;
 b=FopokBooXBZXey9Hxp2lpWG2wwmMDYFT8wwM4NCVaBS7J7ceRBtk28FDMNncanuYWnNax4G6ITTEZ7BfuTq3BWhT/LHJFUWMC8YAyX2sS77GHuu2/jdMpcDxtsejHXb1J0bVUHn5lfHPxhT/1i70UCnDIsbT3znWBtsqZ7zrur0wHiH4JiOS9egV6qFC+0kztOf5rhbmQVa9XcwLLuftpoKD018lUCzDrLbI0jMuE0Ag+QgWtucgiQNJo/C84U5u9X3FUEwca2DNXfipGphzQM4VE9KkApo/W8BDrjxU44Wj/4exkgbAGl0l6U96dTLL6xrtvUuOUra8KzzmyPGYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwDRMFsPNw2YsyT7Tl16fcfnX/KNMCauan7C2eNJqdw=;
 b=tpe5G7sziB5iimBdxFI60sDsp1ua486aGV6QYXJ9SNJ+UTtXSKm5pv1ibwKXvvNhV2uUkO95AMHeEoBN38CCAOlziSPm55uD97VPsOJaT+kWNCvXnbv81YslqU6euvxJf4dZgmIbJIB6wynRStzsV41IuS0X7ZuyrC/dIjdsd1d2hCEv58yFljTFg/TpJU4XIgs3FXFmXz0Qq5xTZU1wdGz3Oocl8s29+M4E8JGUe6qLPLQ0nGB6mVJjM9XyEQSE/xMoWnc9OIGxNOJ4K1erk99gOFQLqaEg9ng/PyJYTjPe6ggy2i7ezlZfIzGggBdFCOi9MRDCaDggqZufVB4E/g==
Received: from DU2PR04CA0266.eurprd04.prod.outlook.com (2603:10a6:10:28e::31)
 by DB9PR10MB4732.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:263::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 10:22:56 +0000
Received: from DB5EUR01FT005.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::fb) by DU2PR04CA0266.outlook.office365.com
 (2603:10a6:10:28e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Fri, 7 Jan 2022 10:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT005.mail.protection.outlook.com (10.152.4.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Fri, 7 Jan 2022 10:22:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:22:56 +0100
Received: from [167.87.0.113] (167.87.0.113) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 11:22:56 +0100
Message-ID: <9fd717c7-a154-ed76-d0a5-f8eb519e3a38@siemens.com>
Date: Fri, 7 Jan 2022 11:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [isar-cip-core][PATCH 0/4] Add cip-core-image-kernelci building
 and uploading system
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>, cip-dev
	<cip-dev@lists.cip-project.org>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <5f7b82d7-cda1-192c-9a09-e229fb1c3339@siemens.com>
 <CANgtXuNVEsC3pa2Tzz6a7i65uJap+Ga7yGSobC9UZZbwYds5cw@mail.gmail.com>
 <b0bd23e7-2ad9-69c7-41a7-bed2b3db7009@siemens.com>
 <CANgtXuPc0_27ZCR7au1e-C3y+-7De-nZQ2ddmjKAinT7Cm09_A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CANgtXuPc0_27ZCR7au1e-C3y+-7De-nZQ2ddmjKAinT7Cm09_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.113]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d65260-b294-4826-6106-08d9d1c7ac4f
X-MS-TrafficTypeDiagnostic: DB9PR10MB4732:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB473292AEF8E4B7BD824EA49B954D9@DB9PR10MB4732.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	p4QfEk3SQGOK/NXdwFhCQbJ1cII2xnhDdu3JnSgwU5OFwHodKN4beNnGE9DI0oxyUN2Fhd1X+r6nw3viJPqRWMS1QBmOBlTx6BcRbd876NSqLf3FD/pr/3qyRoKxB7g/Et0rgqRfVOvUOzk6oKniLVKiBA8GQCi8OxuQXxUt9Wci800SUVZR0FBGpw6A7+9KGBsP9bvqEY7rJUrtkgdKHFlNyNMvGfa+m6H5OvOf9PKnr3RYcK+01DXH9l4xMfxoltDXWwsopTluijnPgeQehDw/IztJ/EwqUcWYDm/LigC67LGxlwoMlpGaKRBjmdZp6o1lyz86x/76AQGvvpw+BjPZDV8xxXWAg9CDoyoHk2Ow3sNKd0dO+B14bD8HUvEN6NiiDS7X78jhlzu0sxGppYOclYn5d957PX73vId5UJdR+KoR085h8/nqyU/ALFiJo7mSLHIyQRUrXeHKk9ZwxJQyciAVsAEm3bKICL6ZLW/BntrFbHa5IV1QkRFZIHYv+frPcMvWgKWQr0lfu52qGX+jwsj8Pj3pVVfBiBFhEEpfSonDNEG7FXdvVxDrNxYajEDQVOR4t5Zgav3sMZkVhzHq+5R7MvHY/7yvGF2v8z1zr3XBsAjAtttnGKK+RNxUoi8O5k1k8NMUZ5omA+1fsVaZ0oI9J4Oxnb7MAF0dCI7lK2w/t6cTapveO6cwh7q+OHHrr3THkeTMD5vk06TJ3R+EX4sE1rKR7mG7u/RGCwMedVbVM/q1nt1faxI6b57TAUxMe/xg/Mv1CqrLO1NioJl2p6ivSW+zfWpt/V5KfobtlNCzTZs01nLNUTZKlzOas4cHXDcLrOwRltOZ2q76s12nHNvCLv51XtvhHsrCy1D99VgH/1IuwFuRcSrEFBhyAAmzoJYgc+b56gsWHFgjZzcd0DXQ7pYzNKld3vFuF7hMdKvkmYIItp9XOWz6aJJE
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(86362001)(8936002)(8676002)(2616005)(44832011)(2906002)(956004)(31686004)(356005)(5660300002)(81166007)(6706004)(36756003)(70586007)(47076005)(186003)(26005)(16526019)(83380400001)(966005)(70206006)(36860700001)(508600001)(110136005)(53546011)(16576012)(316002)(82310400004)(336012)(40460700001)(82960400001)(31696002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 10:22:56.8435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 44d65260-b294-4826-6106-08d9d1c7ac4f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT005.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4732
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 10:23:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7343

On 07.01.22 11:19, Alice Ferrazzi wrote:
> On Fri, Jan 7, 2022 at 7:11 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.01.22 10:57, Alice Ferrazzi wrote:
>>> On Thu, Jan 6, 2022 at 11:18 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 06.01.22 12:16, Alice Ferrazzi wrote:
>>>>> This patch series add a new image with settings for
>>>>> KernelCI.
>>>>>
>>>>> This new image is called cip-core-image-kernelci and is
>>>>> based on isar-cip-core general image with some changes
>>>>> needed for make it work with KernelCI and taken from
>>>>> KernelCI image base settings.
>>>>> The cip-core-image-kernelci images are built by GitlabCI
>>>>> and uploaded to KernelCI production fileserver.
>>>>> https://storage.kernelci.org/images/rootfs/cip/
>>>>>
>>>>> These patches are already integrated in the
>>>>> isar-cip-core:alicef/kernelci_master_refactor repository branch
>>>>> and are generating the images that are currently
>>>>> used by KernelCI.
>>>>>
>>>>> cip-core-image-kernelci as been tested and are
>>>>> already used in KernelCI production with good results.
>>>>> https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/
>>>>>
>>>>
>>>> Thanks a lot for enabling this!
>>>>
>>>> One meta-question: How does this image relate to what happens to a
>>>> standard image when adding kas/opt/test.yml? Does
>>>> kas/opt/kernelci.yml:kas/opt/test.yml make sense? Or should the former
>>>> actually include the latter?
>>>
>>> Currently it doesn't make too much sense to add such testing packages.
>>> CIP kernel image testing is done using ad-hoc images with a KernelCI
>>> built version of the
>>> testing packages for having a common base and better compare results
>>> with other kernels.
>>> cip-core-image-kernelci is currently tested as booting image with
>>> dmesg checks for each kernel (but still using specific KernelCI
>>> configurations and scripts).
>>> We are currently trying to implement the iec-security test as user
>>> space test that will use cip-core-image-kernelci,
>>> I sent a pull request for implementing the user space test
>>> iec-security but is still in progress.
>>> Because KernelCI testings and test environments differs from CIP
>>> gitlab pipeline test environment,
>>> we have to use a different file and merging both would currently make
>>> such different environments unstable.
>>>
>>> I hope that this answer your question.
>>
>> Ok, we just need to keep an eye on target configs and options that deal
>> with "testing" so that things are consistent and intuitive.
>>
>>>
>>>> These things you may ask yourself when try to add the image also to our
>>>> Kconfig menu ("kas-container menu"). That would be nice to have for a v3
>>>> as well, but more important is sorting out the option relationships.
>>>
>>> cip-core-image-kernelci are build using gitlab pipeline and there is
>>> currently no benefit to have such
>>> images manual build.
>>>
>>
>> So, the case that a test fails on kernel CI and someone want to
>> reproduce the image that triggered this does not exist? One would rather
>> build a regular image for the target then?
>>
> 
> Why not just using the pre made image from
> https://storage.kernelci.org/images/rootfs/cip/
> for reproducing errors ?

Fine, as long as you do not need to adjust things in it afterwards.
Granted, such cases will be less common.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

