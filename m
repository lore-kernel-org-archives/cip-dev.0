Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FB1C28CF5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 10:37:40 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.87])
 by mx.groups.io with SMTP id smtpd.web12.10762.1643193459081316097
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 02:37:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kR1iCWeY;
 spf=pass (domain: siemens.com, ip: 40.107.8.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg93xTkl6+hy6Q/aIM3n40Kpn6SyqSXkyHzRvXmbT3OV7Tt5Iqe8oolN9Q4Eh2hHcmNjb2PjU+0GY1F218CgZichsxHFks8ApuZnsR3ekAGpevkpXpBBAC0ndEge0ACwFj+0W3CfW+34F8kD6SLFl3q3Zb+nYJ6QRJ3bqwVTn8fK/i0GlcjWzmCry65JIS5QSOdoCwb5CaDVzu1FOJWNc1d+ltEbXeGfGfeW2Bmt8zmBNQygcfIa9AghkrL6E+Na9a9WbAg3gxlw7ot67ABH7mdYPwa0C3ZPZ8Z/5W4hHchN8GlT3AUIKfzbsarU6PUaMIb4qRzrRAdRvutse+FBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P85hX1X6d9gWn42aGu4kLvfUwxkl74hsjd4mNqvaaZo=;
 b=X58j5k7J+O92DEj0vOt7LgHRITLbgQDhqj8YegTBD+jdiyoX0hncgqhPMyUS/pn096U2SvLfid7IhmATQW/UgbVsQSxnNUvZTFiXANtJtIvcREqL7j+6AmMayXte6PKk9eMdjofRRuVqrphA1d4y+4FSYSynYsqlsKvVdcmhL8iEY/IfVotm+L/9suFTAPq1HAIBLuDr2xaJwn+Bsg3wEEt+o/nrcqUJ8HAH/92FqSwtWoi5hS9WAkYG8tbpFJv3+W8PgVzsvsCj1c1ilD7YTf28GEibv4R/N1tESqjBqSSySO/JZ0a9gNoexuJ6OYrHamhc8XG4IxO1b+tPHgNBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P85hX1X6d9gWn42aGu4kLvfUwxkl74hsjd4mNqvaaZo=;
 b=kR1iCWeYsGBISQVIVa6tvJ6avMuxIXcSgOaEy7BorkOGeennvDrY9uuZyo+lwXXgh9Y0w7OeN73sKTJ85PI2DmI0vB9MmrTBCyY38tcqXjkhfMLPA64khCpherW20nREPMPUCPZew4YIfzKe7M7zKDpbGnN+nmdjOUXAn/9BY6ceakEPNsh+AhSuAnR+5VOrgiLE6neboJWGJEtA3AEw9N2npgDcLL4TjkxCZFLWmTtwtirmyeESO8KmsDX1NoJBZRWkvaQv6CK4Ibv9onaOFUuae8RP75jPsqZZ4KimlWwBJX9URFc+9yp4NCQa7+72aAZRQSCCzdxsFzfBK5NJvQ==
Received: from OL1P279CA0040.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::9) by
 AM8PR10MB4132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 10:37:36 +0000
Received: from HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::5d) by OL1P279CA0040.outlook.office365.com
 (2603:10a6:e10:14::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 10:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT059.mail.protection.outlook.com (10.152.0.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 10:37:36 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 26 Jan 2022 11:37:35 +0100
Received: from [167.87.32.162] (167.87.32.162) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 26 Jan 2022 11:37:35 +0100
Message-ID: <45e2a270-d6af-23ef-21bd-e608bb295621@siemens.com>
Date: Wed, 26 Jan 2022 11:37:34 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CANgtXuMcfX6JUBj_pf46Ukhd9rMK1j53a+E53jseUmzXkVQu2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.162]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faebb733-d504-4fdf-0cf7-08d9e0b7de6b
X-MS-TrafficTypeDiagnostic: AM8PR10MB4132:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB413248429F62DCB00FB5600795209@AM8PR10MB4132.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ld4KuOGTwX6bSvYJAtjMQBsXeePmkEZVc3dk/vpqXKQYE/aa1A5TfKSecXGCWdk7Dcxavy/C8sFYJf+swYXFnt5kN4j3pFtWXtyQQcsnzGWH0RasqFMqCgla4KlAJYCZ5RtZgD/NPQiXcWYI9H4rugdEP1VCgJOnlTy4ETd4Pl861Blpxn+7hYuVi6yTze2eQ8vmjZb6HbSSJKLE3XR/FeL2tGsyxc7xkbUJXK2VIkuSNcjd5Qg3SaEWIhFI/DBE/QNxxoOqDcTK+pWcwTWPHXSnMzyHmKl6sJLhfGFTkp4iOZdB26ynoX1fth2o1rG74OfEs8z74rAOuqNIG3R99NOGGKW0XEPaEJYQONKvqcnU1ylxz+05HegvLdzAJg8BEe2xuPXV0AWccFlF6v69yUnOjYc7yd2i66ZAnoeScXz48/NUq33i+cREDqzcDtmsjaqFax/YwDRFIcfPzS+5LgwVgce93wKb76HePXAzdZ1VDxFHLQSavpDBtTmB2SH8LcV5HKSHooLb4tvwrBru9eKuT0HtYSxf7ShoFRqPQDuMfiOw2obK4i0wwdg10omqvosizB8sjZTO1jvh7WvEL0xtA82R02nTt8gE6xNgmxc138zDB5AXcOwNan33mhRyJ9fdnTLgihIqK/a3EmWwGASe2JzK/2y1bCMSnv1vhh37QnFRej923c3R7FmuSRFC1mcit7VEZxsy0FbNyOCijtzBpZ9uG6K2jCEdudyvKkZK9rOsSyqE3iu5vVB4+G6i3rCtzt1OyWKK+lhAi/vbAI6r4rvEXRopw0B0iK+2TCivAfE7vfSkOJpc8iH9NyT6OLrb4zhhcv/zRjXHSBq0624tYL8purZ7DCD/dztO9fM=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(966005)(2906002)(36756003)(4326008)(86362001)(2616005)(16526019)(5660300002)(70586007)(70206006)(336012)(186003)(26005)(44832011)(956004)(31686004)(8676002)(6916009)(16576012)(82310400004)(356005)(81166007)(47076005)(6706004)(82960400001)(316002)(31696002)(40460700003)(53546011)(36860700001)(508600001)(3940600001)(36900700001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 10:37:36.4049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 faebb733-d504-4fdf-0cf7-08d9e0b7de6b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 10:37:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7486

On 26.01.22 11:27, Alice Ferrazzi wrote:
> On Wed, Jan 26, 2022 at 6:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 20.01.22 13:54, Alice Ferrazzi wrote:
>>> This patch series add a new image with settings for
>>> KernelCI.
>>>
>>> This new image is called cip-core-image-kernelci and is
>>> based on isar-cip-core general image with some changes
>>> needed for make it work with KernelCI and taken from
>>> KernelCI image base settings.
>>> The cip-core-image-kernelci images are built by GitlabCI
>>> and uploaded to KernelCI production fileserver.
>>> https://storage.kernelci.org/images/rootfs/cip/
>>>
>>> These patches are already integrated in the
>>> isar-cip-core:alicef/kernelci_master_refactor repository branch
>>> and are generating the images that are currently
>>> used by KernelCI.
>>>
>>> cip-core-image-kernelci as been tested and are
>>> already used in KernelCI production with good results.
>>> https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/
>>>
>>> v2:
>>> * drop trailing semicolon from gitlab-ci.yml
>>>
>>
>> Didn't you also want to de-duplicate the customization recipe, build
>> kernelci on top of the common one?
>>
> from my understanding we decided to don't go in that way,
> because changes in the common part could break the more generics
> KernelCI settings.
> 

Fork where there is relevant different, use the same one where there is 
not. Duplicating files/99-silent-printk.conf and files/ethernet is 
surely pointless. The latter will actually cause unneeded maintenance 
efforts when adding new boards.

Please also avoid needless diffs between the recipes so that they can be 
re-aligned easily when boards are added.

And I still think we will eventually miss the wireless setting from the 
generic customization packages in kernelci, ie. the only real difference 
in those recipes now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

