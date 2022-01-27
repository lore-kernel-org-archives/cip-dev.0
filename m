Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FA9C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 15:38:42 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.88])
 by mx.groups.io with SMTP id smtpd.web12.29720.1643297919267797368
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 07:38:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vQCyruMO;
 spf=pass (domain: siemens.com, ip: 40.107.6.88,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArWFECrTXiw23aazvYjh8Yks53Qtms8YZzunkLpSTvUSa3OqVetx35FODEHYkVrzbgdqH0eB0Yt7TCWUZJeU+XlTSW+xnF/aspzfpzCshkD7J4DIMf7nQV5RS5pMh1Eb84D0jKPoIQwjmt+gVhxHtLS2l6oOfqy0a0aD2rF2R7GZN+ZTPrEMvm8pRS2VPyk7s3VyGQQEDtPvEyEwKspvLeVHZ24VX/qQGz7O3cNdaSBaPE/d12PNLECdWxKUuqfjXr/idYM1BUFPP9MqZc1fKeM8jSR0nx6NJKBF7XDkO0ZeIBqq6cx1HddmH7uCEFbexbI5eEfMZcYojtANnv/tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYNc56uFPbWhUDsJJFQzDGmQx/YaF3uC/jpuiwNU8pA=;
 b=SVNu219fCuMIP+l+tJNRln2bodWdYoAQmp/7VFhonMlZtur8FocOhGaBTq8XLI0P3rP6BUI59OrL/AeXEhp8wLCADBn9UPAOSAYYxG7V/eutIFFrJXHwVPnzNOTB2SQxIi8RRTQNmks7HefIuv9WQQBAVMJHmy1xssC/TmsxAAN2IKulAfYMcYIRkdZlj/MZzGNmQRt5beEpQrt8mCBZBdCWlAVN4VvttPBmTtrLt8sIsDvLXiKTvSX44HFfKvArleVUIgu9tH6SG2fY8G6NzGIAmipdXnLaoZ1ZW0CIyHamdkv2LfbsvPUa/U6NTxhbiqlr7JPX0vBHDIX5onwiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYNc56uFPbWhUDsJJFQzDGmQx/YaF3uC/jpuiwNU8pA=;
 b=vQCyruMOBudVi1g003ihELRO/zsIk1Hy6UWTxT3E/afstvj1hgyWdS80XKgOes7fAzyacPlyXeeBp7x2mceSlTa2naisIjSzaKXK62CQq1OeSugWfcdoHuWXP7d8vmKtWGlAfOgt5604cspKAYTp3qHqqc0rqK5iOEv7WvzZ+2hb+UkpBH7L2oxHAxujAItPpjrU+JDGi31Oidl9hDJuliMmYDwBtGybKylMzn+dh2CEBuBM+tVNMtar9bzwi8ayafvcIq9/+ZnEoSHwfh3n6ygipMuvfNycy2Nvfy3dEvXcbmIIK/Di1TX/eP+Z4GuGc5fcM6+pYhHfu/BFu9N8Bw==
Received: from AS9PR05CA0049.eurprd05.prod.outlook.com (2603:10a6:20b:489::9)
 by AM6PR10MB1893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Thu, 27 Jan
 2022 15:38:36 +0000
Received: from VE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::69) by AS9PR05CA0049.outlook.office365.com
 (2603:10a6:20b:489::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 15:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT029.mail.protection.outlook.com (10.152.2.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 15:38:35 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 16:38:35 +0100
Received: from [167.87.73.11] (167.87.73.11) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 27 Jan
 2022 16:38:35 +0100
Message-ID: <55706133-1eab-be16-f1e9-af1da7b34f0d@siemens.com>
Date: Thu, 27 Jan 2022 16:38:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core][PATCH v2 2/4] Add dmesg filter needed for lava
 test result
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
CC: <cip-dev@lists.cip-project.org>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
 <20220120125418.236990-3-alice.ferrazzi@miraclelinux.com>
 <4493f1b3-6559-8627-0725-faa35aa3508b@siemens.com>
 <CANgtXuPeQHOiUCKtK9MAd++whamLS-vLyTEqiRZ0yQe9mmEXYw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <CANgtXuPeQHOiUCKtK9MAd++whamLS-vLyTEqiRZ0yQe9mmEXYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d50d81fb-829c-4d2b-4e9c-08d9e1ab1509
X-MS-TrafficTypeDiagnostic: AM6PR10MB1893:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB18931D6F84690FABD3C56E2795219@AM6PR10MB1893.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2Y9DWc30KlburXPBO9VjRamdNjo7X5iAzvBEMgxocX1m8CDBtqyCtKxOwKSeGWjsMKdCeaQrUgQ6DW4McuVKphGzZkP6nk0UMM2fJ/GWaTNf56xTMebygzFtqwiuCa3vRRFsOpTy/qxrDB9966SzD1nBzCZMlpYuRZ9BMgIpql3ashZ2tW1JSevNK6AcB5IT1LS+AlCumimmR/lxbvJNDJCyCyH6q/3SIR6ywjsQHCl0dYha/5QVDGzf+NkSYWnBCZ9042HOYljEscwHavXsqxRloeoSP0AZ4SQrGS5T1j33XNY36FlOLcAiMVNTUuvWkqYqHUfXsCYBWMa/4UYm22J6vMEa786YuNAJqfjzz1jtx1pCTlzuyT4zEarTCRiARS27X+TOlK1XfWvZ8T8ZD9iV7qA40bNJIMFfM2Uuyp0NzH/nFblnM4TbsG9hiB/7dXhymlRS9kpmVWAoG+fI1mau4Kct+rnnreqDQCDukgZJYcb7tSW8gf8YE5bMg+RW25YlpnRrrDPUsDg+Bx2R/6LlUj+6L+hdLwNKgBqir2GpIBxdz/QlAWXD5YbKlvrjohLPP2nnMnO8b1TsiRLR2QQa1yNeal6jYHCf5dw0IkMjyZcrnlVdVwfxtw5KVQV76dN2LWmb6bK7Zt8QtrCewubzzaFNhir0tNlqaVGfW8/aVqKcEGVamXaqQhrw4HGDcGC8238eSWbvdMLcsjoOyjK02xsedM/GSIWgl/IMb/z6FFPFYqTtD9VZq+sAO//fzCxWTUFG9pbdRPkVsl9jn7pQ+L6oarvFv2WueqWzHK9S4q/wyA50m6/VI/KLdHkv+x+HekAyhIX3GHDxrIVG4g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(2906002)(7636003)(336012)(356005)(36860700001)(86362001)(31696002)(2616005)(83380400001)(47076005)(4326008)(8676002)(70206006)(53546011)(186003)(16526019)(26005)(5660300002)(31686004)(36756003)(70586007)(82310400004)(956004)(508600001)(16576012)(8936002)(82960400001)(40460700003)(6916009)(6706004)(316002)(44832011)(7596003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 15:38:35.7755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d50d81fb-829c-4d2b-4e9c-08d9e1ab1509
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1893
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 15:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7505

On 27.01.22 14:09, Alice Ferrazzi wrote:
> On Thu, Jan 27, 2022 at 8:19 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 20.01.22 13:54, Alice Ferrazzi wrote:
>>> KernelCI is using a dmesg filter script for checking dmesg
>>> logs result with lava.
>>> Adding the script to the cip-core-image-kernelci.
>>>
>>> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
>>> ---
>>>    .../kernelci-customizations/files/dmesg.sh    | 23 +++++++++++++++++++
>>>    .../kernelci-customizations.bb                |  1 +
>>>    2 files changed, 24 insertions(+)
>>>    create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
>>>
>>> diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh b/recipes-core/kernelci-customizations/files/dmesg.sh
>>> new file mode 100644
>>> index 0000000..3b096e1
>>> --- /dev/null
>>> +++ b/recipes-core/kernelci-customizations/files/dmesg.sh
>>> @@ -0,0 +1,23 @@
>>> +#!/bin/sh
>>> +
>>> +set -e
>>> +
>>> +if [ "$KERNELCI_LAVA" = "y" ]; then
>>> +    alias test-result='lava-test-case'
>>> +else
>>> +    alias test-result='echo'
>>> +fi
>>> +
>>> +for level in crit alert emerg; do
>>> +    dmesg --level=$level --notime -x -k > dmesg.$level
>>> +    test -s dmesg.$level && res=fail || res=pass
>>> +    count=$(cat dmesg.$level | wc -l)
>>> +    cat dmesg.$level
>>> +    test-result \
>>> +        $level \
>>> +        --result $res \
>>> +        --measurement $count \
>>> +        --units lines
>>> +done
>>> +
>>> +exit 0
>>> diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
>>> index dca0891..c3f677c 100644
>>> --- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
>>> +++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
>>> @@ -18,6 +18,7 @@ DESCRIPTION = "CIP Core image demo & customizations"
>>>    SRC_URI = " \
>>>        file://postinst \
>>>        file://ethernet \
>>> +    file://dmesg.sh \
>>>        file://99-silent-printk.conf"
>>>
>>>    DEPENDS += "sshd-regen-keys"
>>
>> This is a nop, you forgot to install it.
>>
>> Where should that script actually end up?
> 
> you are right.
> The installation script got lost in the rebase.
> sending a patch v3
> 

Found the missing bits:

   install -v -d ${D}/opt/kernelci
   install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/

I can add them to your patch if you prefer.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

