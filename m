Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF439C43334
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 15:29:57 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.54])
 by mx.groups.io with SMTP id smtpd.web08.8666.1654270190711338602
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jun 2022 08:29:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nB4rETB2;
 spf=pass (domain: siemens.com, ip: 40.107.14.54,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4SeF6ER7f2U2jLX+6JiOugclzxXvNnnUOunMGFI4SpPJ8pQpb3qBXl11iWCRYrCb8RYuvp5jWlB3waGM/TBikn4i/gn6J14rf7j8GV5f2ygz/Z8W2c6vud/lNGbpBRB6xwbCu68HfH1d75NHRnN6i1JFpqLX7zNxakgSSJMCXMxDQUxTKMo7evYrriItPx2kgP72sET70bCT+ZcJar+rNZHe/cnVf7+j01dDXaiiiOR5vmVONQFlaPet9GhBz8v7vBiQ18duu9pl1ntCk7djS2Ur3eizKUPFzQ0oA6e+gGZ0N4jO4QNSFj2rBZ+fv7SWLRptEhc6k5xYDUNkfKrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Uip6iMFCWBHnMOSLMY34A2mkgqGn62n3cyKRPbBX8c=;
 b=gnzuivYEtaGCeqrQg+13OhAcCLW75mqNJ79QKXmDTfeuI+Crqos0NjWBo1Yju1YEygdLwwikJ0SEXBF49Oi5dGuXFLdlTkdEvX8fbCyq1Z804EbS0rYhsjqiHdNXf1UkHPpDgc7hZpgK+6Ix/n7K8UJSe2DpL2ywDRhnsBOw0YL/ngzGWIlD9JXSZHIBDcxebg5MKrqKEzi37j3PiIRx4KNF3eQofAMzNODkPrsQO7/R7BYiCDmNUPLz+F8IhFNcLNvv1v0R3FctsN8rk94fxWRjzZa30dSmAcT1JpywkYRzW0cXuQwXKMpthnnq36AwLyvLKIbA5GGAjVB3R24JOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Uip6iMFCWBHnMOSLMY34A2mkgqGn62n3cyKRPbBX8c=;
 b=nB4rETB252Iban4eUErUTn5sjtKCW48HmgS6XK+jMhNBh1YDK+6uwA4l3cgtmt/yq4DZ4zrsozSNF9NzoqgC7krwrRq4MtcZxUT1oxZ+0FgrDqm0n6njR6EuV0+gNxcbgwcvVzvtL5cX2LFDasg6IMGLQFh9tDPJ9mdOtUOiyA3e1qdhYoUKhcDV7uLXltJHMvsYlLrIElBqUz6Ougcbpp06hl2HY8i5S3kv5MER9FnVOFlfW85yoP7Jtonpy/YYwBRuT9Z8y9SvdMLKeUJmKJY6P2p+fVVxFRx3nOshOXklZPHtNw4YqxdfFp+O0mkUnti4A8HLDISSBfwhZw6GEA==
Received: from DU2PR04CA0245.eurprd04.prod.outlook.com (2603:10a6:10:28e::10)
 by PAXPR10MB5277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 3 Jun
 2022 15:29:47 +0000
Received: from DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::8c) by DU2PR04CA0245.outlook.office365.com
 (2603:10a6:10:28e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 15:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT049.mail.protection.outlook.com (10.152.5.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13 via Frontend Transport; Fri, 3 Jun 2022 15:29:46 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 3 Jun 2022 17:29:46 +0200
Received: from [139.21.16.8] (139.21.16.8) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 3 Jun
 2022 17:29:45 +0200
Message-ID: <318eb3aa-286a-d8eb-f744-f89377a1578d@siemens.com>
Date: Fri, 3 Jun 2022 17:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][RFC 0/4] Adapt isar-cip-core to ISAR
 IMAGE_CMD_*
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, <adriaan.schmidt@siemens.com>
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <f1c75b36-4dc9-dcdb-b388-95add01ca821@siemens.com>
In-Reply-To: <f1c75b36-4dc9-dcdb-b388-95add01ca821@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.16.8]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.249600-8.000000
X-TMASE-MatchedRID: G9QKf9eUqNBo0FBZlmedTrZv+ayzmKtKPg9yfk4YC0a5kFk6DtF9f23L
	B2YI359FB+A0yBBPPYwMyjRdBmXLaAlfxg5ncm7ilYUFo9LzIpmMPz8Goa6fXUaMPBFKXyAUYFs
	T/TpvJqYH8UzOewTxw4A+sls4Cb83sA502JwhhUHfIqy7qrBQpy+pYxwv+BZOZf3zf+xpuLi7xm
	CZDXrutalOQjQcrzOloSnPJtmDAFLJIuRHt43jisKHlSQGL2ITmv0Xhs8HK83HrhS+VKSDcfioI
	si7Sa0gJ7XU0Q1VfIcn4JkU8L63Qcd+uwyEzGRili14pejvmEdQWjkLGApnaY9Ha73XaFhEAPiR
	4btCEebvRQsknAWmGgEOLeFkyQjGfChXsBZM1X+VeAJnj+FfencYbeAdGHHXXmFVlObh0PxBfkJ
	WKY0KaQbGuFb+x6MN1+0KsXaxWz7i8zVgXoAltkWL4rBlm20vt7DW3B48kkHdB/CxWTRRu25FeH
	tsUoHuIqcqbt3U1lej24AY2DIsLLvLdPeoJP831pmSEbbKUztoBmTSwRxjXg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.249600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D0B2398100C887D3FFDFF7D17B60A076FB011E8AF38495D0905AA341C54ABCDD2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bec04c9-a13d-42b9-1d1b-08da4575e44f
X-MS-TrafficTypeDiagnostic: PAXPR10MB5277:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB5277D9861523CBD88F7D292B95A19@PAXPR10MB5277.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q3sqHqnc+jjovXV7uU+WOUWrLea4Hj2dRrXRHacfjjsuUoI42c0HJRZv7VhO2YfYdkdiIZnuWhm94N8IOI3k4tT/LdVE+U6hV0o6vcjhjDIUR6NLWEyMJuTzHusyv3TPHAA1o19CLCPr0rIlOo3dCQV6MYIXPlgk5nSLjGXkCIuDCv3mJtEfxaZNJlzUW41amcFOKV7xVUOafSETuV2qPrrhCIoD0Wos07L96a1yMHwftylA7G8eK5obWX/HAlqSnhqb3M6N1TwjIdTPpILnSVRtR4hhDe5xFj222Yoh2E36/I9fVQDk/tVxs44QJuZ0JGeLHl9Yob5wWaAjrE4zY1L9F47VAFcx6Vr8c004CWFsCL9AYXgoQySny4RJMoulVZ5nSYJbtz9RuiCx5PSoqw+9JOsWCYyLOQynQ4guoOhhhYMQgTQ9U+M6HxgKGONeaGxo1GlTqc/mWbrn2kwt9U0pOF805ieNmPZEFW5UGnQkglVEmDGDgQ1J0JbhysG/OIinSmMilBRNnDC16Iobh5wWs86CS8nPgodxSLqro2J70vixR8KetKi/tKzYdhuLS2EE3cH+4X7LAWYWPMeJnUixPKGD0qEpUOY6wJ78dhjNpVZn32JC7YSkmsfYB5HBEJHE6MrWqgrd0i7GjRPPPkEXhGpQxyNoIAuod4kwvr3rmh2jw3YVmTR7kETExvcN0c7AdEqn4hBu2iKsokXXLUJjrRLFjQoBlWqwGQ6xNtmTOGsMn0GkBuq+9V7jAfcca2PJGVLUMQuJQWGMWYtDavhuYPwKUK+cT5w7YJQ36+yQ7k3NGOtDuJj2W9B8Vl1fw+MVt+bXFijBsTFBRtJy1/G0KTyyGGZ6BwAma6p82LkLejvVXtd1ZnRUmHEtViTzKmUyHh987I7G76eLhUUybA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(966005)(16526019)(82960400001)(2906002)(316002)(36860700001)(186003)(26005)(2616005)(44832011)(36756003)(47076005)(31686004)(508600001)(336012)(83380400001)(53546011)(6636002)(6706004)(82310400005)(8676002)(86362001)(8936002)(16576012)(5660300002)(956004)(40460700003)(70206006)(356005)(81166007)(70586007)(31696002)(110136005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 15:29:46.9445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8bec04c9-a13d-42b9-1d1b-08da4575e44f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT049.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5277
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 15:29:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8490

On 03.06.22 17:27, Jan Kiszka wrote:
> On 03.06.22 13:56, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This series adapt isar-cip-core to the IMAGE_CMD_* introduced in
>> ISAR commit [1]. See also ISAR API changelog[2].
>>
>> This new feature remove the *.img from all wic images.
>>
>> Also as new naming convention image recipes no longer end with `-img`.
>>
>> The image types wic-swu-img and secure-wic-swu-img were removed.
>> Rename `squashfs-img` to squashfs according new naming scheme.
>>
>> To use squashfs include:
>>
>>     IMAGE_CLASSES += "squashfs"
>>     IMAGE_TYPEDEP_wic += "squashfs"
>>
>>
>> To create a verity based image to following line need to be added
>> to the local.conf or similar configuration:
>>
>>     IMAGE_CLASSES += "verity"
>>
>> The modifications for a read-only root file system are now part
>> of a bbclass which can be include directly into the image
>> recipe.
>>
>> The modifications to generate a SWUpdate update package are
>> also no longer part of the image build process and in a seperate
>> bbclass. This class needs to be included in the image recipe.
>>
>> Please check/test the interface changes for swupdate and read-only root
>> file system.
>>
>> I tested qemu-amd64/qemu-arm64 with swupdate and secure boot.
>>
>> Quirin
>>
>> [1]: https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add96ecdf14
>> [2]: https://github.com/ilbers/isar/blob/next/RECIPE-API-CHANGELOG.md#changes-to-image-types
>>
>> Quirin Gylstorff (4):
>>   ISAR update
>>   start-qemu.sh: adapt to new image names
>>   Adapt swupdate and verity to use new IMAGE_CMD_*
>>   scripts/deploy-cip-core: Adapt to new image names
> 
> Thanks for this update. I'll have a look and also try to apply it to
> meta-iot2050 as test case.
> 
> One question: Is the series bisection-safe, or are the patches 3 and 4
> needed to build again. Patch 2 is likely needed to run the result again
> after patch 1, right?
> 

Hmm, patch 4 is likely needed to ensure that CI is still passing with
its deployment jobs.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

