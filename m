Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D9C433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 07:26:26 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.47])
 by mx.groups.io with SMTP id smtpd.web12.3046.1665041177134421952
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 00:26:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tnTQM5+M;
 spf=pass (domain: siemens.com, ip: 40.107.14.47,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsiPlVRNw/1wGF/uuSTYIb+yKhUEZv6Td6K6WGCOzJoFGKRtJDZYu1vt8EN0mdItRkhammW17ego2vkm5AWLi1XP7Dh8m2ngbKgWESgnjqfZg8J+0ejrVudmr6YVQJoFpYivmZjkXsRV8h9AqjrZ5Nbr4xO2KatcbdCLWEz52F1UOgL8QeYQJO/gbKWGvhT/I7yGxjvehioobJeOKgkrIKhe6Oy1tLiO8ikP22MTrW1o4aDsiunzoXgj1Lpc2PVugkO4N5iNIZlyOuqEGHh4dVKSodhKRuWn7NYI5HXm5B6KtKZgpd8ouuozAvqVTSun9gd5pK0xhFvapX6//YTtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePVqT5AGHrnrfuP8aQrWOl6jFyK+o69/5rJHPzCDJiY=;
 b=du8TFBEsrhxeWetezdW9PRyUTTndAAzAzkP1qRwXvjV1TWb3oJNqo90FiPgfcEgX8uL42zPHQnQyB9AgE68Uf/k8s/pumq8i9Pgr4V2dzdnqCBOsUYCCon8NbBq5Ked56TQiP7vs3BesEsQotKOSS6OuYoxDsNNU+PGsrlRGNj6Ip4kEUmiamHerCkEhKhsxh0Ib3mQJNRiI8BjKunvYYM5DPB1KaH46O60F6aX2yFnUnJ7/LY8OtoKA3jA7YJHHeqERIHZIau/PAUKtQQK0Mzi4Lb74p52ukwd4QcVO5FGZDc5iOndn/x4m9yY+OfqGK0VJnimaRvtdcOkl6Rz8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePVqT5AGHrnrfuP8aQrWOl6jFyK+o69/5rJHPzCDJiY=;
 b=tnTQM5+MYQmYMb9ZK7d1zsda6eeGR9JHlSTGi61elff75JlIbBSjzD1qHFAc8XsU30CiB5AzkNCZfXP4H50bZUD87Q+ehnfNtW6rBFaTGCnWC2pNAq3MTncrKJK4TnA8gQay0tADQGm7oCirWPxMowrhB7alyFV4DnzttD1IMTRrtaifqPqkPc+YO68BMGcbnm/gGOXCVjxjFdKlwP3IDRA6sifSUvH059MtTu9XPB49xyQyhMaIcGnKvVpIqIDkrR/vODSFd6u5xKGd3MbnWy2ljxod8ChZad0OZ4RzU+dKHoindX+bbBCxKleLeV8rASfuRPp7LMT0KDZcAbUcCQ==
Received: from AM6P193CA0038.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::15)
 by GV2PR10MB6429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 07:26:13 +0000
Received: from VE1EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::d5) by AM6P193CA0038.outlook.office365.com
 (2603:10a6:209:8e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32 via Frontend
 Transport; Thu, 6 Oct 2022 07:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT054.mail.protection.outlook.com (10.152.2.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 07:26:12 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 6 Oct 2022 09:26:12 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 6 Oct 2022 09:26:11 +0200
Message-ID: <361ca4a1-cd1d-2ffb-4b62-1f1a6e049bf6@siemens.com>
Date: Thu, 6 Oct 2022 09:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "Pavel
 Machek" <pavel@denx.de>, Chris Paterson <Chris.Paterson2@renesas.com>, "Hung
 Tran" <hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <dffd60b3-a074-c62d-bb6e-ae9c268195b7@siemens.com>
 <OSZPR01MB701920EE0FC4FC6B7FAEF37AAA5C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB701920EE0FC4FC6B7FAEF37AAA5C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.140500-8.000000
X-TMASE-MatchedRID: fd9c05JWinA5QaOxwNGfvo9bHfxDWoib1xQ2OgXti5UT0vQc28rNUf6u
	GOfv9tMUtXl9IxEPXOoS5LnfGo4vrSCXC32XlLoPl2SZRvRWU3oZqwjVzzmd1p1U1lojafr/jok
	Mbd75JAooYw/JH0PMsjxTJjE+nPo21ClGHEoQe0Xw78bL10OTJKRxb5HXXW4zw4LlAWtyEiUj9+
	iycgC4IM07ZorZdLCAGyQB1oR95Ao9FmfB5h3P+ti8PtI5hTclSOMJ2vAKCWD+xRIVoKNMvAGo1
	vhC/pWj1R/ptYWR8C6ffYZLd4eHV0QD9vOU9UhOq3USk769Wfv9WTVChOPp5v86OKweA/McVa3v
	Vo6qkMMhnmSpmb/95dPLnr6G+Iy7je0iRmKtYnn1wPpfVw5S7Rntnm3pEHIprMcMK3Nm8dm8ATk
	xRboyZtTGF35SmL4UpbL8RVIDsB0BgSFJD62vr2rKvcc8pGgFXOFTT+immjZ+J3gtIe0gA9qEDf
	kP9tYEBaq8VaDdeDqHzS+w/xzBDrQKLhvag+W1LxxHBMdDc7oy7wvC8Uc6Hfbta0OAYFzyrixtt
	RG+E/P9Wn8yUrAKBqPFjJEFr+olA9Mriq0CDAgBi3kqJOK62QtuKBGekqUpI/NGWt0UYPAgaZ3W
	MPU0R95yQty19sPosUFi2WCBb1otJQ4zDGn4xrc6cJ4uYUQo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.140500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 11E31DC57530FCC56FFACAC60F1D6716C1B620476C79DAAD78807D5F68DC1A792000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT054:EE_|GV2PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 59335baa-a7e2-4e19-b6b3-08daa76c0c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MMqRWHiuTHAeHAuijwXUasMnJPkhJMinHVBP2VrQzuxoBZcNEUhbmQnzEERJ4EcWJpBhnPQ0O9EtThembZQKZV43b4NiZcik42PRHQ6+0lk3glQ9UwMInaRWQ6flw8sFyQ088UIckGmUOtz4vOFM+z+X22OsaWd8sFNawvZWTr0gVtTg59Vx9yV4dmKz7qRdPGDJr/liGGmwnrz9DbYYxMNGBFWDcx1aGpIy8cobPuM6V8HGLC1DrGxwgi4M/4c+kUExdkNXcVeikB6ClZCwiewTpYgzS7J6FZpDWUDkurkRQijL9RlXAG+atZLqMtnNaIClKg1tvW2d4Vep0RtIcfZF4yio4u1wK2YbCBpk08Myl/v8Sfb22jGQOXe/qiIqkrIdGkpGqosYduOnpocTh4QjLi11TOmTRTv9WympFbQYEP2SR9734II9CWMpBL+19IlgCg8wGFWB0Ozl6ixe5KFX5d+JUwHuHssDZMzDhf06zuhTH7ncb8xWkKLmjvjIDIph7JpQLu5jsmgWV7+9MNbURcsR1DzyueYAkcacJxbEgP44Qft4n3cY3GCLwYqy/M1zJSVcRZybrsgSDP4/5stXxp/EecKdoa3mwPXGjylTODQB70yZX7bx0ToYByMtXxgEwWg2dAMDhGuEKRhtgaZoNO3G2Hq8MX49OORd9LBHzA5rj0ADrU3NLQuEK3RGs+YhnIBR5QiYjUppBnPLESh+YoMtLcFFTSJIwyi0/ytfMYgEhf9JsaX7gggkrn3vR258LtAkqX/hrymQN1rJUa5upmBY7nI48sK5L72hZL3tug6eb8w/mP+348WlnUqZq57bH2i7cvgk9kcABqpYDB6uWfum0pB/mwXIyIoVJPfGh02c99V8OLEV0nlSOS7rIznKScF5qV0vvUOb8FCdbQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(83380400001)(26005)(47076005)(956004)(336012)(36756003)(2906002)(16526019)(2616005)(186003)(31686004)(356005)(81166007)(40480700001)(82960400001)(82740400003)(53546011)(36860700001)(31696002)(86362001)(316002)(110136005)(16576012)(8936002)(6706004)(478600001)(44832011)(4326008)(70206006)(8676002)(82310400005)(41300700001)(966005)(70586007)(5660300002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:26:12.8572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 59335baa-a7e2-4e19-b6b3-08daa76c0c2e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6429
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 07:26:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9659

On 06.10.22 09:08, Prabhakar Mahadev Lad wrote:
> Hi Jan,
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 06 October 2022 07:50
>> To: Pavel Machek <pavel@denx.de>; Chris Paterson
>> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
>> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Hung Tran
>> <hung.tran.jy@renesas.com>
>> Cc: cip-dev <cip-dev@lists.cip-project.org>
>> Subject: Re: Preparing isar-cip-core for RZ/Five
>>
>> On 06.10.22 08:29, Jan Kiszka wrote:
>>> On 05.10.22 20:21, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>> But due to the weird U-Boot setup, I had to add some hacks,
>> rather
>>>>>> than a proper boot process.
>>>>>
>>>>>
>> https://gi
>>>>> tlab.com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-
>> %2Fcommits%2Fwi
>>>>> p%2Frzfive&amp;data=05%7C01%7Cprabhakar.mahadev-
>> lad.rj%40bp.renesas.
>>>>>
>> com%7Cc8b33a1b0332467e04ce08daa7670053%7C53d82571da1947e49cb4625a166
>>>>>
>> a4a2a%7C0%7C0%7C638006358079991069%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
>>>>>
>> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
>>>>>
>> 7C%7C&amp;sdata=I2ajBytTSsUvSHp5wmkA1rgVz83rW%2B6aHGby1O2tyog%3D&amp
>>>>> ;reserved=0
>>>>>
>>>>> Test by flashing the image to an SD-Card switching to SD booting
>> on
>>>>> the module.
>>>>>
>>>>> Maybe we can find a better solution for the boot procedure before
>>>>> moving forward with this.
>>>>>
>>>>> Anyway, now we have a real distribution on this board. Pavel, can
>>>>> you re-check what you observed, if those issues persist with
>> Debian?
>>>>
>>>> I believe I was running Debian; two versions and Ubuntu, IIRC :-).
>>>>
>>>> Can you check if ldconfig and gcc work for you? That were the
>>>> roadblocks I was hitting. If they do, I'll be interested in details
>>>> of your setup.
>>>>
>>>
>>> Hmm, seems the issue persists:
>>>
>>> root@demo:~# ldconfig
>>> Illegal instruction
>>>
>>> [  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at
>>> 0x00000000000380c8 in ldconfig[10000+83000] [  297.146768] CPU: 0
>> PID:
>>> 497 Comm: ldconfig Not tainted 5.10.83-cip1-riscv-renesas #1 [
>>> 297.146775] epc: 00000000000380c8 ra : 0000000000015382 sp :
>>> 0000003fffe01c10 [  297.146782]  gp : 0000000000099da8 tp :
>>> 0000003fda772800 t0 : 0000003fda7787c0 [  297.146788]  t1 :
>>> 0000003fda8065a8 t2 : 0000002acbbda7a0 s0 : 0000002afa2ec890 [
>>> 297.146794]  s1 : 0000000000000001 a0 : 0000003fffe01d18 a1 :
>>> 0000000000000001 [  297.146800]  a2 : 0000003fffe01c88 a3 :
>>> 0000000000000000 a4 : 0000003fffe01d18 [  297.146806]  a5 :
>>> 000000000009736e a6 : 0000003fffe01c80 a7 : 00000000000000dd [
>>> 297.146812]  s2 : 0000003fffe01c88 s3 : 0000000000000000 s4 :
>>> 0000000000000000 [  297.146819]  s5 : 00000000000105a4 s6 :
>>> 000000000009e670 s7 : 0000002afa2ec850 [  297.146824]  s8 :
>>> 0000002afa2ec710 s9 : 0000000000000000 s10: 0000002acbbe39c8 [
>>> 297.146830]  s11: 0000002acbbe3938 t3 : 0000002acbaf2610 t4 :
>>> 00000000000925a8 [  297.146835]  t5 : 0000000000000004 t6 :
>>> 0000000000000000 [  297.146842] status: 0000000200004020 badaddr:
>>> 00000000a01253cf cause: 0000000000000002
>>>
>>> (gdb) disassemble $pc,+0x10
>>> Dump of assembler code from 0x380c8 to 0x380d8:
>>> => 0x00000000000380c8:  auipc   a2,0x66
>>>    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
>>>    0x00000000000380d0:  sd      a0,0(a2)
>>>    0x00000000000380d2:  mv      a5,sp
>>>    0x00000000000380d4:  addi    a4,sp,416
>>>    0x00000000000380d6:  sd      zero,0(a5)
>>> End of assembler dump.
>>>
>>> Do we have any instruction set restrictions that prevents the usage
>> of
>>> distros on this CPU? Under QEMU, we come along here as well and
>>> execute this without problems. Some infamous Intel CPU comes to my
>>> mind at this point - hope, history does not repeat here....
>>>
>>
>> auipc was introduced with ISA 2.0, around 2019 - please don't tell me
>> we are on 1.0 here.
>>
> I have seen similar issue with yocto dunfell release, If I go higher up to kirkstone release I see there is patch 
> add-riscv-support.patch [0] (I haven't tried this release yet though).
> 
> [0] https://git.openembedded.org/openembedded-core/tree/meta/recipes-core/glibc/ldconfig-native-2.12.1?h=kirkstone
> 

I doubt that something that fundamental wouldn't be in the Debian
package as well. And it works fine over QEMU.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


