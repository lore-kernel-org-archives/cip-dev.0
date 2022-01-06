Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B19C433EF
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 14:18:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.65])
 by mx.groups.io with SMTP id smtpd.web09.9242.1641478693431430800
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 06:18:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Yy0ZvmPo;
 spf=pass (domain: siemens.com, ip: 40.107.20.65,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mz94Ngx28LXf0Jg/3IwhQFIpF3sBDMeKsWgumhRuwBd28sWctfItMs0qR+ZyQWGobB7JGBGbIfcX077QJ5Yl+t7igyY0kfvpww/bFDsU2pSLlAKCDmq9iFWBRmH7iRvdtFem1/DUUtsyvNK5aW0aZJgENEGXEYi03ixEdbH74QlbgPNB8DT6pHHQcUAP+Pf3MK7L/pu0h/0DHM586tgTCdMwApaLX126sBmZarWsi1wlvK9NAxHbkbVohQuhmVqHUqTvyWkAbftNkawQa09QC4toSzrQmNh7IfaeGqffUtE2/h5AB18OuzxIxJKcRgU+y/f6Tkwc0lvPI0A/AhDU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQnapCYXkq7Axhc34jrRtOK4zrvzhHhU8pWskwDSVhc=;
 b=f98F8rdDGj/GitTypqDneQAjIC0EfmHOfFua8fp+9CZzZIXWjCv51S+odjWnSpsHnVePUZtA3InJUeOGT4Vc3verFLVGco78wWE22Bgs5VRVlAqLaddk5TRS6Zu8ww73WeG3qV1rAfonlFzaSKiMtyKQh+xYuF+z8hDbemEykOJVdoRbpKi0PSNFI5st8vRwSVDeFmdWakEjCyeA9hD2S1yvd6Ymkv81ec2CKToIQroqWEjoih9FZdkrWVRbn3WJ6W8kEZAN8GuI8ohIgoutHZgErfOd/mvVJRkR2KkhUuTGfNqAt6wW05LPUdBrOLJAoynm/Po21s3QpuoZVNOMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQnapCYXkq7Axhc34jrRtOK4zrvzhHhU8pWskwDSVhc=;
 b=Yy0ZvmPoqSJwt8Ds3tYOyZQS0gyZmMMpWnrap3bbZ5Zy9srfKLmPAGtmBfNDukbVHdmJoxVutB5d0UmvbGA1l4Frdw6gFicxItsgoNfL/uRpGNyEz8ctVkr7Lvl74pG+K20u00Q4Ao2hfnkNixw128aPPglnLIMeZpG8DD8GuJyFDOVvpDo4QNjj1CFgxpA/MaGtggfsyLlmjJqbJindVep3YoW8EF1fFPiRLMmyVniQmSkYepCWgcz6TlORLyB8JF5Kv60/GNs4B1mF8aDxT0W0A3pF7XZJytABdkbpkD9JpfWyLVWqD+w0FoGB+3EV5aJjjmhYXFFS34TRRngI6A==
Received: from AM6PR0502CA0068.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::45) by DB6PR1001MB1189.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:62::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Thu, 6 Jan
 2022 14:18:11 +0000
Received: from VE1EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::a7) by AM6PR0502CA0068.outlook.office365.com
 (2603:10a6:20b:56::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 14:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT007.mail.protection.outlook.com (10.152.2.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 14:18:10 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 15:18:10 +0100
Received: from [167.87.72.7] (167.87.72.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 15:18:09 +0100
Message-ID: <5f7b82d7-cda1-192c-9a09-e229fb1c3339@siemens.com>
Date: Thu, 6 Jan 2022 15:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [isar-cip-core][PATCH 0/4] Add cip-core-image-kernelci building
 and uploading system
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
	<cip-dev@lists.cip-project.org>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.7]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d2b113e-633f-47ed-5dbc-08d9d11f5e91
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1189:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR1001MB1189FDB76C68E77344FFFCA8954C9@DB6PR1001MB1189.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y0k08Ax9MGFc4ugU6uQToc/AFrfLZqn7mnCxS/FWOqmuxSmL/+fn324ol/agSt+z6VrPdkzHPKOUvMTg2+6w12pxk5HMAvV1QSGgRw3AjviTZ5jnp00nllXkNZsLXs5+8Gd7z6Q5BntmAxv8fHQb3JE+OiCPaqCJ0BBJbFquPduEw48EeQa6adYUZyOJkPK1xXN+SaI2xlI1Yt7iwqwSaW204/1tsx6YlTSo76YeT95RvH7rAoP0JiZQJJkhtaJOVLJkKMHGlMzLDHw+PvUQyyiIuWMHa5Si1SX/+hR2EQWJqk+rVb38VYmcGMSbXVbeAbgz8GS+N0TYH9Tz8GzcO1MwpY+9hFiBs96pNQ4dU/KLwFuqdZqkLFP9TMa+NVq+q17ctpbs0Pbrww9yrV6V+nu7irq8MNc7AqTmRtvh1Hcq8YETvJ2PL5S7sP7lREyVhhL5p1SOijZNFmYOOSpakqBdcfFjGLoDoRp594lZQLB6Ug7tI7MxgoG+UjmgXZoZBMKzkpCkTI+xbKUIecPcIfj/65/FgrmEevOMkNOoIz4hAwHjx7sr2lQJ/lDgREhPaD523HOFn7Gc4wHnzYY7jc3zH9MK6mbeA5OH+iLGw+DHxbwAjvkJ4vKnp2buFGonlZpJXwJWJoqNEMn+QZMkLqqs44JCJwE0deTEvs2xeWteYlH88J1N1u9iFp2STj/B/ePncJAb2T9YRVwv3w3UZQeA1AP7SkButUhfCywNPb5NvZvCq7KRo746veHIDwOrZZY/Pj9asf2fmJSKdi0lqaY9wVu1PoXAO+RCy9em0ilfyVtWG2h73DGELEh7SkGza6zpMVl81sB3S427rAPPFQ4Ye58yJml93Irk8+6hV3EQ8s7+Nxb/NSzh3iR7DUTtv9n3fliPYP9YCPrF6N0RgZSSiP0HLyY4TwAWFY5NiaVKj1vfvSv11LGyRbJ601ym
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(36840700001)(46966006)(16576012)(6706004)(316002)(26005)(508600001)(2616005)(956004)(70586007)(70206006)(82310400004)(16526019)(186003)(966005)(336012)(86362001)(47076005)(81166007)(36860700001)(44832011)(8936002)(8676002)(2906002)(53546011)(40460700001)(36756003)(356005)(31696002)(31686004)(5660300002)(110136005)(82960400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 14:18:10.9787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6d2b113e-633f-47ed-5dbc-08d9d11f5e91
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1189
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 14:18:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7335

On 06.01.22 12:16, Alice Ferrazzi wrote:
> This patch series add a new image with settings for 
> KernelCI.
> 
> This new image is called cip-core-image-kernelci and is 
> based on isar-cip-core general image with some changes 
> needed for make it work with KernelCI and taken from
> KernelCI image base settings.
> The cip-core-image-kernelci images are built by GitlabCI
> and uploaded to KernelCI production fileserver.
> https://storage.kernelci.org/images/rootfs/cip/
> 
> These patches are already integrated in the
> isar-cip-core:alicef/kernelci_master_refactor repository branch 
> and are generating the images that are currently 
> used by KernelCI.
> 
> cip-core-image-kernelci as been tested and are
> already used in KernelCI production with good results.
> https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/
> 

Thanks a lot for enabling this!

One meta-question: How does this image relate to what happens to a
standard image when adding kas/opt/test.yml? Does
kas/opt/kernelci.yml:kas/opt/test.yml make sense? Or should the former
actually include the latter?

These things you may ask yourself when try to add the image also to our
Kconfig menu ("kas-container menu"). That would be nice to have for a v3
as well, but more important is sorting out the option relationships.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

