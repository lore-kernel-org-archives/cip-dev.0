Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B797BC28CF5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 11:49:25 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.83])
 by mx.groups.io with SMTP id smtpd.web12.11322.1643197763674159117
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 03:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HXjZQzL2;
 spf=pass (domain: siemens.com, ip: 40.107.6.83,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFjE3OwxDiDH72bfTSnakgHlE65Y9LE2h+wxuAAWiUCWQg6KHlxnsyb2KkMt89Ikzro77ZOH3ktVI+xctYis0HVIoU4+vcW7J4mRvAIPxSzCY5J3bzfbNkAp5S+eXaQv2oZxLmlaRzDMkxwsqOJ7RQyCSTaHSthIyWUMsTyTCSG9AFjxLMusNIoXiLCrU0wgYPAtq4+FGBMp06j1xmIpRXyjh3vWfKI7hA9WNbznHBo4HVBqpWXZyxP048H2jMEQp18GUMt5Dx19tSurVPjzYO4ZSFsbqbz5WkGfM+HoQGPXUEzPHmU3MxeQE+NNsWb+ELFajoey70Y8NJW92YbaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9SZTCRdZ9WoChmVnCqqMK08prMqpgXwSpDe+Yq+cN4=;
 b=HTXPxr9l2aNv746K/PZgqLecIbSBzPGBfuVrIuQJfzdv90o18+ByuHTfCvXfjgdH9RDDj98790/FDwFcJCl/P34B9ghyc65gmHv54K8lm+1vVqL83JojOMj8eTs1l8oPk8RhDyT23qVdSDd2vbI5kDitmHEwCmaUgDrsCDxUKsnV9tXkm2tUpghuwzTZBYJAtDv4VAKTcRPVXuXKiuyuvfcJhXG2T2Ed5dX7rJNaXIKikJlUwU6N+J+HXW0V9EScMHz5rk95u06EW7qcBEpnsDbZPGkwr/bzTj/8hbpNwItC47EmK6zYoPqcxWiUc0ipNXPQb6Ll+pNIzQbFDUg5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9SZTCRdZ9WoChmVnCqqMK08prMqpgXwSpDe+Yq+cN4=;
 b=HXjZQzL2BAT7Y1zNYvPJuDb8Y9g2ft1kdFyKBcDa7BVjbDfA/AI6b4eefw01JVbDYHHEiE8CsstSercrjkfczT2+7DMTBhbky2NrF2NgO9Xh1oh0DaMBpHICM9xTaiRwKhvIgnBsgBmXGVS4N4z3DOY0uhWJ3keEEn9Zx4IhGkccB1ewp4pxjqGq/Du1kJihS1JP/LmOMjcq36cYi40cx0lRMEmu0hoR7TPAg2OymvxC4gnafjtAbuaE3JPwmc+TsfgeGizOI5deG2tSlYHksv+8aWxikY83M93GMsNJ0fMH9EH0I9GJ0SEg2hM5m7ixnHWUIRWPylXDOEZNEmnhfw==
Received: from DB6PR0801CA0061.eurprd08.prod.outlook.com (2603:10a6:4:2b::29)
 by AM8PR10MB4756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:366::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Wed, 26 Jan
 2022 11:49:21 +0000
Received: from DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::bb) by DB6PR0801CA0061.outlook.office365.com
 (2603:10a6:4:2b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Wed, 26 Jan 2022 11:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT018.mail.protection.outlook.com (10.152.4.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 11:49:21 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 26 Jan 2022 12:49:20 +0100
Received: from [167.87.32.162] (167.87.32.162) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 26 Jan 2022 12:49:20 +0100
Message-ID: <f190faee-942d-ebdc-802c-c944b1778b4e@siemens.com>
Date: Wed, 26 Jan 2022 12:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [isar-cip-core][PATCH v2 0/4] Add cip-core-image-kernelci
 building and uploading system
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
CC: <cip-dev@lists.cip-project.org>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
 <5de7f456-6428-ed67-de99-797058f6ede5@siemens.com>
 <CANgtXuMcfX6JUBj_pf46Ukhd9rMK1j53a+E53jseUmzXkVQu2Q@mail.gmail.com>
 <45e2a270-d6af-23ef-21bd-e608bb295621@siemens.com>
 <CANgtXuPvyVDYrk_CnLKtjEe4H2btxTprGRWX1-xJqOEno3=gXw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CANgtXuPvyVDYrk_CnLKtjEe4H2btxTprGRWX1-xJqOEno3=gXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.162]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aeea644-c09c-4565-d1b5-08d9e0c1e434
X-MS-TrafficTypeDiagnostic: AM8PR10MB4756:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB47567C9E5F5F7C911B35F43195209@AM8PR10MB4756.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HaLsfolgUb6W4ap8uuHLmhB5s5gnKjQjX+oS3bFUf3b1UTbDT3/+5WrnBXpta/df9rc8hm4/RGhZtpMjHVqVsU40b3yPCfYOvsmJGC6cq4eWwaThUbIsb6IpidfS3FtgEMXcWwdHHzwnlTztV8OhY4WVTQKkvhEfZSLv1EiEcdMcV5LK7FjCBLzb6bZ5ePkiz249XfJIfr8TGn8/tnpKaB+ruSIrd3UfudQCofGY88qU7QRLKZ/8PIVxJLABFflgqDt2RION8MrN5zH4SVcqf4C+eeLlQGw/pJyMfH+/IMGOMf2cP3eIV+W4EDWoPkZN9n8d8DKHo8OKjhdKoHjD6G0bYpH14KyquW+GrCtTAPhskwjVEVMoeQ4IUXyr3M46pkcqQco9EHYtnKyn9i05wjact46wJpzctmQwMZ+ewi1mur3upo5jAyHwZgyQZDJ7qroMciPD4jq32Frf15sGige6XD6z73oqJTiUPmYDSTSm7q+xIS2Gi+VBVRlqENjSukKzZGBQTGhsX3s6JVrKvFIzjuK5Oh0chsGyXqszuOLXKFg69GlJ1aqdMOgqcaPnJ6Z2S3eaM64yX+pt2anWt8g7//NbUF0S7lScnOQnYY66qh1er/KIkVGbU6he9gFbtQ2YZWP2rdcAedbHt+fhhNYKUHJfB3oPi1vyiJ1PH4GrFeeBRhoY8LxQObvHoX7tfLdWb6MRpAMiPj4w2X5mZB2oPLvPtQI+QUq557qhL4nKLFviEcciKp0eozsa2jmC6ZeKze2o49pPfOWYi8rZY0078SVknezZbAS19QMO+xPpeDZxgdCB8I6nukA3KLRA63kCnmLLq3x1gOyn2xgE/jaNjsdUTn0uz3gkHRf7tzJSSKOlOJ2h5kaDgvLmkxAdazDegjFJYRZnrUGG0m1s/zT3spTnH82YtjIX/gLOWVMFtmRTLVIwrSCeI4m7zV+l
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(508600001)(8676002)(8936002)(70206006)(82310400004)(186003)(356005)(5660300002)(81166007)(44832011)(2616005)(26005)(70586007)(53546011)(6916009)(316002)(336012)(6706004)(4326008)(31686004)(47076005)(40460700003)(83380400001)(16526019)(2906002)(36860700001)(956004)(86362001)(31696002)(966005)(82960400001)(36756003)(16576012)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 11:49:21.0987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4aeea644-c09c-4565-d1b5-08d9e0c1e434
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 11:49:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7488

On 26.01.22 12:43, Alice Ferrazzi wrote:
> On Wed, Jan 26, 2022 at 7:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 26.01.22 11:27, Alice Ferrazzi wrote:
>>> On Wed, Jan 26, 2022 at 6:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 20.01.22 13:54, Alice Ferrazzi wrote:
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
>>>>> v2:
>>>>> * drop trailing semicolon from gitlab-ci.yml
>>>>>
>>>>
>>>> Didn't you also want to de-duplicate the customization recipe, build
>>>> kernelci on top of the common one?
>>>>
>>> from my understanding we decided to don't go in that way,
>>> because changes in the common part could break the more generics
>>> KernelCI settings.
>>>
>>
>> Fork where there is relevant different, use the same one where there is
>> not. Duplicating files/99-silent-printk.conf and files/ethernet is
>> surely pointless. The latter will actually cause unneeded maintenance
>> efforts when adding new boards.
>>
>> Please also avoid needless diffs between the recipes so that they can be
>> re-aligned easily when boards are added.
>>
>> And I still think we will eventually miss the wireless setting from the
>> generic customization packages in kernelci, ie. the only real difference
>> in those recipes now.
> 
> Is not as we are adding dmesg.sh script (please check the next commit).
> KernelCI have a different environment than CIP current gitlab testing.
> 
> That's why the last time we decided to merge as is.
> https://lists.cip-project.org/g/cip-dev/topic/88235357#7341
> https://lists.cip-project.org/g/cip-dev/message/7337
> https://lists.cip-project.org/g/cip-dev/message/7340
> 

I misinterpreted this.

Then I'll merge and clean up on top. Duplications should be avoided 
where possible, and it is perfectly possible here, to a certain degree.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

