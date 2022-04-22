Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE076C4708D
	for <webhook@archiver.kernel.org>; Fri, 22 Apr 2022 16:52:00 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.44])
 by mx.groups.io with SMTP id smtpd.web12.8216.1650631997028713278
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Apr 2022 05:53:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DFC4XLxI;
 spf=pass (domain: siemens.com, ip: 40.107.13.44,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1vxUVeGSwuChZtEI+mzdWVpdaB8O/NTE9TTshMcPXZtIHP+T9dh8PQl2Yl348UaRuywxGk1eplgWIFQyPGCW3EJ4rpu7Ei+kIIy7ev75UpqcP3lxEPSOd5dJbFzixMHw5BpSfNATzkJW1FPDSOZoK09IKNdIEtgUsypvRGwJV/5yBJ+52kEp4LdkPBa6fIYNHkhjIWLGjpGsW7JzJPpBLeZzFpFTOd8dCbV931OD8FcLDZfO/IHkFBudQ+Fnvk+EMF5eBTE1EL20m5rEtkLt89s0Nm3kFAVmyJ+k5bkRywNEskuKU/S6zyKO1qr6ekSv/ScUCbnQ5peykHILlFH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCFYLzs5y59a+n2sfHi/Kx+5I/jBGRck0DqDuFSuu8w=;
 b=XAKt/wGEykaGlV5x26hirGyWVFAfPKGf9g7eqecWLcQ00rm3l32Q8yabsvalYtQ2tAl2fcn3tKeRKTYe8NYz9PQH9rRCi97Q4dFk5c9gT6wBJvV0tACeStS7BEOSpyysehQb6pXemECdUTXlVhdKPuETqMdBzUajtU4+Ey9UHF4gxcTu+fZJ8DasGB11R+B11mafnmRCqd7RPl2xQ+iiZszP8pYRgJiCcPpeygzjwyjC+ARbjiQ2tIDtbPxzSHwYvxkTqU6QPUoL4gx5HpR7f3SkHZCezrKWzjGwBIBbIW5IaQzCmAovtvzta1gRJbgzm6Cjz68DtsMRvpx92Rl3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCFYLzs5y59a+n2sfHi/Kx+5I/jBGRck0DqDuFSuu8w=;
 b=DFC4XLxIDEbGnZFfpvcoA4Jllxv62p3BkzE1W4ulTjbF8Qt21p9ebjFhU2pOM1Lyovlt/oKAFfWUmRR2QZOwI8s/IaaesbVjpfN+7pfMqCHOWS5YCTfv5FvsUMlOQ7Xt0+mANmnykk1Rv5nY/8rCz/Bfp+nI33KffH39v+HCDOnNYfJSA5GLRiAvPL1IMdXa9Ywzdmxe4EwhYx81DdZD64aedEkh0aHzrUN69XbWNn0+h46Kxq7dlBKatD1IpI8daWt1/fNL/hSEMY2jI1cJvzSVzZ0N+hkMy0KO3Zy20z9x/1fyB4Cs1WX9dZd2ajQFIoQnB+q7elxaHlqfaPpuow==
Received: from DB6P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::21) by
 AM0PR10MB2132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 22 Apr 2022 12:53:13 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::86) by DB6P192CA0011.outlook.office365.com
 (2603:10a6:4:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 12:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 12:53:13 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 14:53:12 +0200
Received: from [139.22.137.211] (139.22.137.211) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 14:53:12 +0200
Message-ID: <c80083d1-b4d5-7e7e-a6da-f5dfb3892dd6@siemens.com>
Date: Fri, 22 Apr 2022 14:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [isar-cip-core][PATCH v2 4/6] customizations: Relocate /root
 under /home
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: Christian Storm <christian.storm@siemens.com>
References: <cover.1650613658.git.jan.kiszka@siemens.com>
 <c378b09452d1507e0f7c5de1c3d6543f2027b06e.1650613658.git.jan.kiszka@siemens.com>
 <f2eb1b22-0110-274e-9599-62d22b9ec133@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f2eb1b22-0110-274e-9599-62d22b9ec133@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.137.211]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.659400-8.000000
X-TMASE-MatchedRID: zzMRqZEINU45QaOxwNGfvo9bHfxDWoibPIeX4ggjD6QsisyWO3dp27vG
	YJkNeu61MYkmNIO7+hbmonZJqUP6wPXmS36YYdHyPEI3LQs5pOufQIQHBVsNazO9YdEjFZfC+Kg
	iyLtJrSDQEElETurAJQu8AoAyfG3RK+fbv4M7+TC1M6vEQZCbhnDWCEZXvYIHngIgpj8eDcC063
	Wh9WVqgmWCfbzydb0g3n8eBZjGmUzkwjHXXC/4IzsAVzN+Ov/sL53WvUf8ISqX+3qXuM+CF/JCh
	uj78D7ysg5O3Ij0kn0zLZ5WaIfY+w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.659400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6E5DC570E2F0F9A84D851EF36C18CD8111AD54B147368CAAAC504BF08341A9E72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04a05747-bfeb-4f73-12df-08da245f0fcb
X-MS-TrafficTypeDiagnostic: AM0PR10MB2132:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB2132FD8E0766B181AABFA4CB95F79@AM0PR10MB2132.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FR6BK9aoWlMqGo+vPpcjnVav0YkyBK+3kps0d+j4KyYWwaNnwtua/dMHGJI+gIvlY3uJTdSzNMCmHEIUqz/wlT2JhsIkxGG/+n2m2P7L3GcxE9KlXiMFrS3Dkg16Gwm/m/DaTSdQLQbYl+CcRP/b2684Nxq8wRPViBjaECB0YnHm1BRuhxa1C1Osjo1iw6jqemhMcT8RZNdQeGhvdv65ZllLSg2rf8Q44jJu2VBnJiCh9yagvW/0D7gspP+ntFllh4id3UGzrR9lFH9XrkFv9pn3259Yjw256PNBhk0DZHaoE/8rDKvGdp8vKFZDbwEdrrbMaaVgXV8ThDeeY0oilX5xFM7rTo1TuPzeH/86KcJn2RHiusdGm6FOFKCFeGc7aYjjO+MHk0OZvfCPqnmsJvksnyhu/pjpgBbi7FJaZ+v5NzapAW/tN/RWQMr4J5buc3ujdsdUBHghPuQs9ySc76gPjsG4opzgBIYyhWK2WjwabtJsDqgCPIRrltN2mAHdVusvDkkLuNLylAly4j3sMl+BZwVQX1s2Z82kHm+spVIuLUkOLSi36CRcZTMttIEBE7EAqt92HqyczptnD6lPFRGYGOBXEjTwc+DI70nkQ6szDBW/Nvzqf6xRF6GTYK5nZbNql+d+rT9+UkfloHbsS6dQM0exu9t20C77m182+5NymelNrN6oDBphnueRz2aXWJcl2P4tCCHToG4aIuT+mRp82w1btLm3C3oRVbEFPSW6ij6BtOcfhueMZc9aliU7oHARI1661+l/ZKcK6XgC6GEA50PLUvfJjN55GoiRkbhusfJUZwj7rv8kfqIrQBNYYVlo1weQdRt8g9FRjcgQqWqJNWMB5Ru6oSlBpoIAT2o=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(956004)(2616005)(16526019)(336012)(47076005)(508600001)(107886003)(186003)(82960400001)(4326008)(966005)(53546011)(2906002)(36860700001)(83380400001)(356005)(82310400005)(81166007)(31686004)(70586007)(70206006)(8676002)(44832011)(4744005)(86362001)(110136005)(316002)(31696002)(16576012)(8936002)(40460700003)(5660300002)(36756003)(6706004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 12:53:13.1181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 04a05747-bfeb-4f73-12df-08da245f0fcb
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Apr 2022 16:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8185

On 22.04.22 14:22, Gylstorff Quirin wrote:
> 
> 
> On 4/22/22 09:47, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is needed for read-only rootfs setups. We could also update the
>> account settings, but establishing a link comes with less surprises.
>>
> 
> What happens if the /home mount fails? Does the system fall back to / ?
> 
> This should be the behavior according to [1].
> 
> [1]: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s14.html

Jup, managed to stress this during testing by first misspelling the link
as "/homr/root".

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

