Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA0C4332F
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 19:47:59 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web09.15507.1664912877380885944
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 12:47:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=k5FL6Cl6;
 spf=pass (domain: siemens.com, ip: 40.107.21.81,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8nWUJCfaMQ4EvttqJj8+/p+d2/oysW8ENhMcGDDdJ9G6rev+iuaTPrQBKvj7e3nLqHGfj9V66tSa/7elApxuaXdpi5o9qIAfAcbnZaGJkXOGFOKj1LEIw5zlZ1vuzO8uGjzMZAknanU8WUDE2G/I+En0adqnzuGv84RasjrxFns1jWKvHDQkzxuDBeybBmejeC4pgwd5lKo2DUsewhi4UbhALtt5Sqp4Tb4gjyVrDjRfxkL5/uaLIsEC+MRHNqBPggE9Orhd6WV6PPgRpE05AIckISq3e5a5pp4CFRokqwIuoBzCrvMe8L40Mt2EZHqfYhuSjbqSo0fF29WAYTixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXPeYkm2+HmCWolzHNEkcF2v4D7KQ8sp1N+XOTcLDks=;
 b=HoKYSf0Mz4XXN6Xdj6/q6YFXrQGCj9PHYs/GrWy1R4KIAC0BpxcyaSNwR/dqXPjOlpLxVk9y9KsVzyfUQHzvg4DmC8dnwuuEX7L1hrBgO/noqB/DUHzvoP70dTY/PDGhbOD7NRZgK7xC9JZwg3qFnb0e5KORA0QipuASOHtoX+M8UnpduMCWQoaF3DknHzHAJ3Zetbq3IEIrkqmYNzKJ8WZxBMZHNIgN1TaRaLnjS9cFacBGpNZaSVFl5wDzkS0t7qsCVQFjGWN5FHkwBb6KZ4kYCKze1zConANxpXcD5kb9ExFXphrCqhQozmZkdKgR93qQ/+XPREFBC6Ll8fis+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=renesas.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXPeYkm2+HmCWolzHNEkcF2v4D7KQ8sp1N+XOTcLDks=;
 b=k5FL6Cl6yblAibUrOpgNsUmTXw/GQR5HGkKzHCIuaChkv+KOpXtE1uSPTEBX8hz+WplYgbMZPQpG+miy989ygdpNUV9EQHpgli35OweY9p/gfigwVU4so6x8OlAh/fJ+yhx8z6hodc+/VQ1IIiespXMmKr0YxSatuiJJY7EdN0XL5zjU8o9kUkmNF1+9SILFdwf7SzsPMQnMRWKS8EPyhpt4okqjY1Txg+HAxQIeT83c5W4XGGXey+Vv8E/KhjFqHdIUaKBG2rp0L8hTPoOT1UaKWibrmANhOCUEgzJqB9/jVDDUgkypRM6eWcMUSt00pa3GDpcApcanTCx9vGP72A==
Received: from DB6PR0601CA0006.eurprd06.prod.outlook.com (2603:10a6:4:7b::16)
 by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 19:47:54 +0000
Received: from DB5EUR01FT095.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::ed) by DB6PR0601CA0006.outlook.office365.com
 (2603:10a6:4:7b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Tue, 4 Oct 2022 19:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT095.mail.protection.outlook.com (10.152.5.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Tue, 4 Oct 2022 19:47:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 4 Oct 2022 21:47:53 +0200
Received: from [167.87.17.190] (167.87.17.190) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 4 Oct 2022 21:47:52 +0200
Message-ID: <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
Date: Tue, 4 Oct 2022 21:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Preparing isar-cip-core for RZ/Five
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Hung Tran
	<hung.tran.jy@renesas.com>, Pavel Machek <pavel@denx.de>
CC: cip-dev <cip-dev@lists.cip-project.org>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
In-Reply-To: <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.190]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.939800-8.000000
X-TMASE-MatchedRID: a5BZ5OU5Jug5QaOxwNGfvo9bHfxDWoibfHiU4sgyENKSJLHHb2KALSIL
	dc+InEErhnD8O3TjwmaqvdBo59cuvYJ7FIx7rr75HJfBKeADu1Jekvfhupum40+zv2ByYSDQ+If
	riO3cV8RemWwoCXDj9U12MsUfZOu5m0gaTU0ieiL0Iu1L7a9dfybZZYAQu9H5nVTWWiNp+v/aCn
	4DqCiXNi2D3rEYFrWrbcIAC4/H04lZGVkkvtEl3bsmzCPdqRjh7fg45MYQVOJTNl9jB9u8gA73P
	4/aDCIFgS5EXD2qbc3h06w0q6p9rOrc8uu0MOs1zbPoUo0CxxCdJYZJuTnwNmj110VUgQaLZZUe
	n1+EmbkQjsHZD9zVXujhqVa6NkR5jh5+Vj9kACfyaQ1cwlUuNlqlZQsfv7CJKwi7MItzaY2T+6g
	5ulhlrnPoYZUERzUBBuhMNLfO6UDJXhxyVL4EjPt+q7shlFAj9ZRkVakSSW1/x01PzgWkxmvaom
	g0i4KNOFiq9T5j3bU9jhwT+rGqFHPZRzBSY8VLycXhF6YHUDiROBVNmXUDuBfqkKQlk1I5rXkuO
	N8pnlFoanv7G9bZRGBt9mS7pKVTeoqVs1ZLrvCG184Y5LIraU1+zyfzlN7ygxsfzkNRlfKx5amW
	K2anSPoLR4+zsDTtFEAkLaTcFnrNjGXjP5lKlJL5xPGxHkmoyISBEzSQ8OHEln1dhOjq9w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.939800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 A317742DF1D2A788C528DFF5E764DDCD184EF957B169057C6372ECDDD48DBD5A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT095:EE_|AS4PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 23df28f3-e1ea-452e-dc4b-08daa6415402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ag6e5XwhP22VPBmiuzC3CWiiqek2+xL9v+YRi7H1leNxtlrocm/+/5cyl0T3p1hzfWJ2h68URAjazMYDPRfAT2BKZvNkrFFp5V7G+J5UK8iRU1xa6Vme5Ih0Ywt+sF1h5fGYOHnSCjW9gX+owP0BaCZJ/4FBMEuyGYMh7KUrjkZ/z7dIPgWiK0lJLseAZKsNpNMiM1CQNkk5rRDi6I3buc1wkCNuvzRomz2D2FRgjFNdSeSFT/4UB64rDmQ/x86D3kx8ogoyTe+Y3i449er4Azq+SgGfUU/8opTFwT7KHKV+RH8ILVmKlvPfTq0yd1oB6P5Z4Fu+P0aFH6jlAauATcN1joi3kEfEuOxIk4GsjlUsh9kZYnY4w12ulz99Ovu1IY6zmJQQ0NiGdb/XJxPltejGVryaPJuTU27WLIZ+tZ1FbJW5+k8AIQj0XbyHgVWvzuEFeLK201BEXMS0OMFf0Pf0ciaWWp+dw3Ulnb5OSK28hdcj0Xe95IAIynYrkoGJVRbi68FoTvU+3ciiIzbO3ky+0ZW4o90clBv/G14YkX8y+gCa4vn0GGs4HqT9enxtODZV3bWv7z8zLt1EKzHn+vGNOnW9GcjqihyMlEVc/Sj6Z3ROej0KEBVen5xWRY9et09X3X8sVr5rAgincI6DG1zzGp15IS5VxK5sAjGhZn0ZmsSfj3tGx8IUQejC007iDGgo0SGsghaV/ypmgCLdbGnxoU4vQW6ozsSnKdw7mNj/4NtGNBYIJkMRdMvHPNoyuf3hs9ndrKzlG+HicJlcYiNUU7Ena5GL1RoojK55HTBqFlEYJyH2lde0frwnvl97LechTOEUon4zMfQILj3Z60t7Zu+czHx2f1+oPjjep9L0GrPE7ZY9vb8HZU53muzXjQsUWauRO35fAszD/SqCeQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(31686004)(2906002)(66899015)(82310400005)(16526019)(16576012)(316002)(44832011)(5660300002)(6706004)(36860700001)(70586007)(4326008)(8676002)(70206006)(966005)(356005)(31696002)(110136005)(36756003)(8936002)(41300700001)(86362001)(53546011)(2616005)(956004)(26005)(478600001)(47076005)(336012)(82960400001)(40480700001)(82740400003)(7636003)(7596003)(40460700003)(186003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 19:47:53.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 23df28f3-e1ea-452e-dc4b-08daa6415402
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT095.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 19:47:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9639

On 04.10.22 21:36, Jan Kiszka wrote:
> On 04.10.22 20:28, Jan Kiszka wrote:
>> On 04.10.22 09:15, Jan Kiszka wrote:
>>> On 03.10.22 22:12, Chris Paterson wrote:
>>>> Hello Jan,
>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Sent: 03 October 2022 19:36
>>>>>
>>>>> Hi Chris,
>>>>>
>>>>> after getting qemu-riscv64 ready (patches will come tomorrow), I also
>>>>
>>>> Huzzah
>>>>
>>>>> had a quick look at the RZ/Five eval board you shared with us. But that
>>>>> raised a couple of questions, maybe you can help:
>>>>
>>>> I can try :)
>>>>
>>>>>
>>>>>  - Why is the default U-Boot hard-wired to a very special boot mode? I'm
>>>>>    missing standard distro boot - which would include UEFI as well.
>>>>
>>>> Good question.
>>>> @Prabhakar Mahadev Lad or @Hung Tran, could you help answer this?
>>>>
>>>>>
>>>>>  - Where is the U-Boot tree (upstream support is apparently missing)?
>>>>>    I'm still trying to understand the instructions how to replace it in
>>>>>    QSPI, but first I need a fixable source tree.
>>>>
>>>> The Yocto BSP is here: https://github.com/renesas-rz/meta-rzg2/tree/dunfell/rzfive
>>>> The U-Boot recipe points to https://github.com/renesas-rz/renesas-u-boot-cip/tree/v2021.12/rzf-smarc
>>>>
>>>> You're obviously welcome to fork/fixup as you like.
>>>>
>>>
>>> How is the upstreaming status here? For UEFI, a U-Boot from this year is
>>> needed.
>>>
>>>>>
>>>>>  - Where is the kernel tree (also no upstream support yet)?
>>>>
>>>> Kernel tree used by the current BSP is here: https://github.com/renesas-rz/rz_linux-cip/tree/rzfive-5.10-cip1
>>>>
>>>> Upstreaming is still in progress.
>>>> We're having some fun sharing things between arm64 and riscv, but we're getting there.
>>>> I'm hoping we'll have something bootable in v6.2. 
>>>>
>>>
>>> I see - over 700 patches for 5.10-cip...
>>>
>>
>> ...and it's based on an outdated CIP baseline. We are specifically
>> missing "riscv: fix build with binutils 2.38", compared to latest CIP
>> kernels. Those happily build with the Debian toolchain.
>>
>> Fixing up locally for now.
>>
> 
> root@demo:~# cat /sys/firmware/devicetree/base/model ; echo
> Renesas SMARC EVK based on r9a07g043f01
> root@demo:~# cat /etc/os-release
> PRETTY_NAME="Debian GNU/Linux bookworm/sid"
> NAME="Debian GNU/Linux"
> ID=debian
> HOME_URL="https://www.debian.org/"
> SUPPORT_URL="https://www.debian.org/support"
> BUG_REPORT_URL="https://bugs.debian.org/"
> BUILD_ID="698957d5-dirty"
> VARIANT="CIP Core image"
> VARIANT_VERSION="1.0"
> 
> But due to the weird U-Boot setup, I had to add some hacks, rather than
> a proper boot process.
> 

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/rzfive

Test by flashing the image to an SD-Card switching to SD booting on the 
module.

Maybe we can find a better solution for the boot procedure before moving 
forward with this.

Anyway, now we have a real distribution on this board. Pavel, can you 
re-check what you observed, if those issues persist with Debian?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


