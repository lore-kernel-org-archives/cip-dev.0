Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EBC19F2C
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 15:52:03 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.84])
 by mx.groups.io with SMTP id smtpd.web11.8037.1659455513102296902
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 08:51:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Cf8hDz4d;
 spf=pass (domain: siemens.com, ip: 40.107.21.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snk+LEPTehlXnrN3irERPnm8+Pm5eGWo9Hxl4Sk558O7fuvWxDGEKBfPQ6h9AaTPtZFxflRnasKSZe6hkg7CoQQJyADGt6e/cMt4tJ/r/XUUo8Kb9xJyTC6620oBqdDX7NlRqe2gH9BIuOvearlqAOFneRhe1aCKNg1zjbo+glNgJibCIKGeSdhfO0ouKI0iSloq0dYXkpMj10ZA+ZeuqcMUodpyxQ6SAbbwGmnAKqOLcT2Fm+NZCCNDzuvDxm1K7RmIH6JRFM2gly+6dfGskJ33hCz7abAOYyizAhQBrr+WAZQ6yHLcdWc7/qnSdC0i3kaPPgTodYCEsQrFc55CbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7UiRso6aFFjMJnX1Hjo7QodZfQoTvK4JGkIIk4b92g=;
 b=V9uzeYTgxDoRLGbxQvyBWrQLKpHDZx+t38dnh0E5I9XKNPLpxZ9OmE8dzs2xESUhiBqhby78/f820ukBiZILrbhMX3euuFlRC1EqZTGAL0cJgPVQQddwvBc9L4/WLHuhWY7DmO8+B/I0Rl0Zqmyg/d0TL8sgR2zx1fq2RK0WEia+7TMRDtYKBWIBH/Unp5Hfqjx1iBYBYkgO8u9hnnnKGMAOstTIbtdj8aBtEoDWKzRkY7fEDHhxXs+/+ZF3muP62EhNJaHJXyhZlvIyI0DD7yWgTmf96pJNDyRrfeaU1RvuMhWs+KEQxGRqxuTOVE8FmfwMst3hp5+9UFAiPCsgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7UiRso6aFFjMJnX1Hjo7QodZfQoTvK4JGkIIk4b92g=;
 b=Cf8hDz4dvekGl1asqBiJYnLa1A/7rfyKkUIkJIPGvq8oFLfQauU6bdf7RQS13EKo7IbZjfdqYJsjHoSmDUI2MedFbB19L0Bh88vnwY6utdMfpa0ZOg1/Ma31ecuddtR260aiKPeNRR6s8TfBnRpfhgIdIZ/ditXbD9n1fH0wHALf1OXZCH3o8HHl5Zx/QaIO2ZaU5kSZtQNOX9vxkGiiSfQD183UKmSTQZVD//4K4UdEeHrk3SxmqPqA7cbbOAh1/ElymyyGi9AGYDL8PHNLVg79mSBUs6draa7t30Epo7cF2IUiTnAI94SMgTs6+py0ZeA8TaCk+3SyELTaUaxWBg==
Received: from OS6P279CA0034.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:32::10)
 by DB8PR10MB2810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 15:51:49 +0000
Received: from HE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:32:cafe::5) by OS6P279CA0034.outlook.office365.com
 (2603:10a6:e10:32::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Tue, 2 Aug 2022 15:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT037.mail.protection.outlook.com (10.152.1.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Tue, 2 Aug 2022 15:51:48 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 2 Aug 2022 17:51:48 +0200
Received: from [139.23.127.106] (139.23.127.106) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 2 Aug 2022 17:51:47 +0200
Message-ID: <327f7904-0059-8383-f58e-a96166518431@siemens.com>
Date: Tue, 2 Aug 2022 17:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][RFC 0/2] clean up kas/opt
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220801145749.42714-1-Quirin.Gylstorff@siemens.com>
 <a5ff72c3-25c2-43a3-ef55-ea30714d8db4@siemens.com>
In-Reply-To: <a5ff72c3-25c2-43a3-ef55-ea30714d8db4@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.23.127.106]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.270700-8.000000
X-TMASE-MatchedRID: G9QKf9eUqNA5QaOxwNGfvo9bHfxDWoibNtywwIf5ksXW4Mz461fsHEKJ
	5iyNYGPpR/IzlV+CMbaVKkReE4K0FOtq38W/Yl/coJpneC8uzLwGbfRE5Gg+M7+a7Hw+x9qZy73
	3NwuklsLPlmI4N1s8inJ9Mbn64cXRsDmNfXkN93yGcxsTB9sqP6/cEwCoNGfyRRDrDHhyfDcdX5
	RGQhYd7jb9TB28UbkiBKbFtRGbqfGBwOiAXd70LIak2s1BBB1FxEEtnnH5KRfvZFvZsQkL7QEPJ
	rYlsf/6vGAx/1ATZ5tpU3MXgdMFHvOfo+27i8pxQNfJnWyKdlg+mIYhsRtxutDKIRviENrHw77C
	RCdy4Lxirg8tJChsdCgiD6nrTME150WSSW/trHhBAcIMTJDcSrFAyycJEq7coKSCnzr6+g8ujMj
	6uE1hubbMVaqtU3gFXjesFOd0pM7i8zVgXoAltkWL4rBlm20vt7DW3B48kkHdB/CxWTRRu25FeH
	tsUoHuBj1SX3ABfyZveEA9oYHB3tphqbbMkyuW2zScYRkfr0fFhXMjdQIJpg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.270700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 8EAEC4221741923E1CE36D47655A5916D715B1C49E68973516CAE0A27E43AD1E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b46c8a24-734a-46a2-c61c-08da749ee8ed
X-MS-TrafficTypeDiagnostic: DB8PR10MB2810:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5qiUF/Wp6hhJF+8V9zXOWPQPbB18JiPrZWVd/tFM9wKYvM/C0DZva5R7lQqOVFIoEjJq1282kUQMrQfDvE0v9QFYK2lgCOl44nguP+kGfO6Uf9Q3OV9qlr9h5lONL0cLZTz9sdwbPnIOFS2QeIlatOOKW/c7pdmHhqziRmmNOZSl7/Z+mcv6MpOTqUvbjUFYne2CrWAQetb3VRqB8FMbe77h2QacJz8FOj4IUsRj2OnNq71/xZA0n16vdBR4VJ5zMIsePJb12eHIEz5Gaqxdrm4d21N/lSv/YVmaC49K+Pu6WPVQR1E8sWMeef5hCbs9R6XgD/gp7BgAQ2Wau+Jxp7zkJoH4nfZ+Rx2t1O38MP5t0AXaY2IqS+DhA3KHzL6OdyueaYK1k+18iquzN/YKbaVuwtzDJauKojAZKT5IK7cx2MOtBMm4eB6zRCcOABf0PJK8lEgwEqh/AcL5CK5g9jxluy3ByqTLZegpLUoCq7yGUtcDgdvmthMtz0ZWbu3Yxo6BSjWyuip6CVH/mlmZkq5oXJxxcTOKi7CSSk1J4io74kn/YgD6ZfM9szN1cok2fyzY2oGUrMsoPfcyj70FY/BYHX+AL7keKfjW7zDFL+NXPID35gTeIK7VqX95Zc+YbdhGW3F1KEM80KNZ9EVmE621ZF+LHMMU3Rzz3WiypMiyA3FXkyHqvyUWbFDCebEm/6UeF5/7rfH0HugR4X7BC5pT5MHgIMfnSF83ytQ2MdR9YGQNebrjWYtUUra/U42tEWfcE+7ZWA9Yc2M81oql7U3Z1rnh9fHngx+ZGcIDXD6yTkJtSK+i05qWfuSkJuBvLNlRAZyYXjtNxB0RuTNPjmGm/IEQr3fkfSw0vJApyzwUvjE/jOR419cxhEoUw9k5SPLDInrIGZAu7VxAwwUDNQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(5660300002)(40480700001)(110136005)(82740400003)(356005)(6706004)(82960400001)(2906002)(81166007)(316002)(16576012)(82310400005)(8936002)(44832011)(36860700001)(2616005)(956004)(31696002)(86362001)(70206006)(70586007)(53546011)(16526019)(186003)(36756003)(31686004)(8676002)(26005)(336012)(47076005)(40460700003)(83380400001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 15:51:48.7116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b46c8a24-734a-46a2-c61c-08da749ee8ed
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2810
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 15:52:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9022

On 02.08.22 11:15, Jan Kiszka wrote:
> On 01.08.22 16:57, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Remove the kas option for efibootguard as it cannot build a image.
>> Move the package installation for swupdate to the include.
>>
>> Quirin Gylstorff (2):
>>   kas: Remove efibootguard.yml
>>   kas/opt/swupdate: Move the package installation to swupdate.inc
>>
>>  kas/opt/ebg-secure-boot-snakeoil.yml | 10 +++----
>>  kas/opt/ebg-swu.yml                  |  9 +++----
>>  kas/opt/efibootguard.yml             | 39 ----------------------------
>>  kas/opt/swupdate.yml                 |  4 ---
>>  recipes-core/images/efibootguard.inc | 26 +++++++++++++++++++
>>  recipes-core/images/swupdate.inc     |  3 +++
>>  6 files changed, 36 insertions(+), 55 deletions(-)
>>  delete mode 100644 kas/opt/efibootguard.yml
>>  create mode 100644 recipes-core/images/efibootguard.inc
>>
> 
> Thanks, applied.
> 

This breaks something when building kas-cip.yml:kas/board/qemu-arm64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-secure-boot-snakeoil.yml:

NOTE: Executing Tasks
ERROR: cip-core-image-1.0-r0 do_image_wic: ExecutionError('/build/tmp/work/cip-core-bullseye-arm64/cip-core-image-qemu-arm64/1.0-r0/temp/run.do_image_wic.24213', 1, None, None)
ERROR: Logfile of failure stored in: /build/tmp/work/cip-core-bullseye-arm64/cip-core-image-qemu-arm64/1.0-r0/temp/log.do_image_wic.24213
Log data follows:
| DEBUG: Executing python function set_image_size
| DEBUG: Python function set_image_size finished
| DEBUG: Executing shell function do_image_wic
| INFO: Creating image(s)...
| 
| WARNING: KERNEL_IMAGE not set. Use default:
| WARNING: INITRD_IMAGE not set
| 
| ERROR: _exec_cmd: bg_gen_unified_kernel /build/tmp/work/cip-core-bullseye-arm64/cip-core-image-qemu-arm64/1.0-r0/rootfs/usr/share/efibootguard/kernel-stubaa64.efi /build/tmp/deploy/images/qemu-arm64/vmlinuz /build/tmp/deploy/images/qemu-arm64/linux.efi             -c "panic=5" -i /build/tmp/deploy/images/qemu-arm64/initrd.img returned '2' instead of 0
| output: usage: bg_gen_unified_kernel [-h] [-c "CMDLINE"] [-d DTB] [-i INITRD]
|                              STUB KERNEL UNIFIEDIMAGE
| bg_gen_unified_kernel: error: argument KERNEL: can't open '/build/tmp/deploy/images/qemu-arm64/vmlinuz': [Errno 2] No such file or directory: '/build/tmp/deploy/images/qemu-arm64/vmlinuz'
| 
| WARNING: exit code 1 from a shell command.
| ERROR: ExecutionError('/build/tmp/work/cip-core-bullseye-arm64/cip-core-image-qemu-arm64/1.0-r0/temp/run.do_image_wic.24213', 1, None, None)
ERROR: Task (/repo/recipes-core/images/cip-core-image.bb:do_image_wic) failed with exit code '1'
NOTE: Tasks Summary: Attempted 160 tasks of which 139 didn't need to be rerun and 1 failed.

I'm pulling the series from next again (wasn't pushed yet, noticed locally).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

