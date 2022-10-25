Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFDCC38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 08:16:37 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.40])
 by mx.groups.io with SMTP id smtpd.web08.4723.1666685787793297808
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 01:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wKt6urKP;
 spf=pass (domain: siemens.com, ip: 40.107.249.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/i7KSgesLELaa+34EtG69+6ygZwpxjkT/30RybWOqmTnMzIEb5iHw2xIE7vGLZ/D0IYoqe11aigd/MZLtmav77GSqp+HeFySZDVeIAf1bgKbioPgBsI7efJKZ4iy5ra64N7lHUEBvd0uR2wqQd8CVwPLgw4gGURofMCDeyx2M1PKMO1H60kr+fXlTKNjfaO2vZ93tjHJV12QiUt7eEdoouBN/XLilYRunkBttQ41pBkIXQj/frWz5bqqTF2hEcOLOmmmJuK32ExMIOW9xLfCKE9AIjPIVvm7srE/yFivEKYUgZS2cSc1G1sfll8umHBFyS8yJ7w0LFHumYLNNu+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm8WmOa2dxuj1xxepVwmAKKh7GonD1S9dMlnOXQlMH8=;
 b=CZJ0OJWoOLj0YFIAzGzlIbuB18ZjrQ2gv6gp2f64YHxnruOQOKF0yn0fA9de71CBw1FLsf7LSI+2wir8AGJLf7bUAVeaLKaC8UQUcnTCyJ3AlvZr2mv170IiJ+JY5dIjP93DdpgP2gn73FVaq9qPi2tjkEt8l6Xq77i/xIGQsY4nw7Q+jQcJtow2xJTk94kJ2RU0PD6vHK1Aol0kutbJd4iGrTnpLOhVeq1X3wf9DWBcCpetWinpWiIUbf8ZYL/E48tNNxHB82kMPPNwG18W+VRT2pjqPjwAORUxO/x1unuLfY6XKSgXUSoIYkwvBNw2OCelDuf63k8aoW+0WaGX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm8WmOa2dxuj1xxepVwmAKKh7GonD1S9dMlnOXQlMH8=;
 b=wKt6urKPTyFSpPTfIoXHppL9Fqy2QP0zI1J+Nxb9W1uPSJGCBajB+WjKnrVK1Bg2vLiZ4sBJG70kmRZgroHml3ush7aNSI7ynROcykt3TH7+5xjiaw0mADTPSsHkC807EQi3HlC3e9PZ6jTyio4eFAAXCDOkMqckPMnEIUIuSnO2BoEA7/A8/fmJS9gCojOLCuOR9TkI922Pf7rRQ5qaxgRSQGDMnYVNspFo5IK4CwwJYQHHhsj/jNiaT8lYS1YFLZdb3NT5vjlGmnkvrPOAwXQxow5uO+r4mrUzayTnTj6nbehv7VMrVUyi9lck4mCB6Di11DHRJ256F1F7dnrOvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5723.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 08:16:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 08:16:25 +0000
Message-ID: <a8395d4c-7945-089b-ae31-a22b8b104438@siemens.com>
Date: Tue, 25 Oct 2022 10:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 0/8] Secureboot on QEMU with EDK2, OP-TEE
 and RPBM
Content-Language: en-US
To: "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <23b969e6df97fb95a7e5fefe68c4a01a4c4fe7c7.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <23b969e6df97fb95a7e5fefe68c4a01a4c4fe7c7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 795cf033-cc41-4883-d08a-08dab6613585
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vlbDSWhgHYw75p0W/bypOj9DaFZXINhQnSYcXkNPM1h1YsmODzbWLIfwdeqz6meQfQtMFEF5TGO7TI+FgGQUpBVztpZ/J0e/Saqr0G4EtDpI/5xQLKZ35SRK4jX2R+rxV9SZg5Pi5ITIwfgAE349WDa13b9ZVmynlbDXuFpHfjX6sG+CauHM9gXEphTk9DI4V41UOeVbiqHhsekDHBSCEdbcMDxb4YEyykrYYG5v+ovtloLKcyVzwcwddxRGVn9gNJ8YmscFBAzAvH9cpSij1dEMZY0ASdAynOTxlL+0Qx0EemsWdfa2ghvW3qGqhGpDWUYpjZJHNzFJimETKncT9+rMYcsO4WZWszgL2nNrnDkUgP26FLB/IK1Nw+il9GZSbHiZFS+cicTzuZwAds1JPYz6urLiwh5WLA1susnuzQEpxRPgSUQ5E+s5rEsIQfqBlXO7JLnc3+i4Wv31F7hpVEA8ngQtD/RGZamJMe/19WCxjtcpedfBVNVdvcbH56+M9+GrvnV3X+rediKPgLkhl66GPFFqSgudST0PxOyP8iX+uZShmtBP2UnIP4SyUqW8uj0Y9Dyug1ZC+vTmU1BqXI2NrhR2koxGpy3JxVQgSU+ibEWRr+D4s5dpjiI42isB41NFOhYcdtpWl5+e9OCr4/4UkUxllQ1S+RQein3OwzHr7VNyUKTpy3YGLjZc4T9flP1IdsKOxmxQWiOz1/VLX+y8wf+qw/kRIEfINRWA2VBnoT+7uvcYalMOCw4YbKnpFrv//OZrtMPmEMQM5twDDlGZN3c97jw63+0sklgEq38=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(26005)(6486002)(6666004)(8676002)(41300700001)(66476007)(6512007)(53546011)(6506007)(82960400001)(38100700002)(31696002)(4001150100001)(478600001)(36756003)(44832011)(2906002)(8936002)(86362001)(186003)(83380400001)(5660300002)(2616005)(66556008)(110136005)(31686004)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MlRjY1Q2ZlM4Q2JOWEVnYlpiZCtWTm9uQmhmYnNEblNySmh5NDM2OEtqNDZh?=
 =?utf-8?B?Z0FHeXY2eW43YnFOL3M5UHZWZU9zS1lCNlNlU1hJTzZUZ2dqN1BYd0UvVDNt?=
 =?utf-8?B?QjBHRWhHTFEybzdtdERUMmdmQ3lZcTkwWUJZVmFQMlFJWTVGT2ZxcTk5cDJl?=
 =?utf-8?B?VkxCdzlGNkFFSGttbHg3SmdsR2ZrMCtsWHlrMnZCb3AvR1lVT0U5eExhQmlx?=
 =?utf-8?B?K2k2TVdRV016WDR3RkFlNU1CbWhoUENQMlhWTzVLYUIrL09tYXhDWGtUNmtv?=
 =?utf-8?B?MzF3Mi9DRTRtL3NaU2dpMm5ycmR4Sjh6OFM4d3E4NnkxMFdXV3VnVHpvTVJG?=
 =?utf-8?B?UnNnVWl0MVlYdHZMZkhaYW0zOHRQQmdhN25xSVpRRWJEUHVyQVMyeWpqdEZh?=
 =?utf-8?B?eS92bXZvRzJmV1VsbEZjV2xmVXJLQ3NWTmNhbVZnNlQvbE02N1UwK3ZJQUNw?=
 =?utf-8?B?TVRLdkxyRjA2TzdKais0WjFOZzFtaG4yczJZTjE1a09XNGs2TndKSXF3MXl0?=
 =?utf-8?B?MHN2L3NPT0xZRHMwTUJyOUErR3FsWWxjRlE1UzdTcUFGMFFLV2pxMngxQXlM?=
 =?utf-8?B?UERBZDcyNkVBL25yRHZKMkJFcmZCbGptNmplcGZ5K1FKSlFIditCZVRMT3V1?=
 =?utf-8?B?cURWVHpIY3o0a3Z2Y3BVUHJ1S1BhWkdId3ZBc1BMV2p3S1hSWWNXZUZFL3F3?=
 =?utf-8?B?OTRRMjBWWFdLYllSeVJyci9ML1dJZm45NGhMRVRNUmZ5RU5XZHhBL3hWZkpK?=
 =?utf-8?B?YnY2TWp1U0h6R1BWVGgyQnhEK3FIeHRWSllTOXZESGlzbGpsb2VLY2drMzNG?=
 =?utf-8?B?NGlTeWFBb0dKK1h0d3dKeGZuSGl3Y3Z6SzNwbTdxQ1REQkdYN3FUaXZlTjgy?=
 =?utf-8?B?bE1MQnk1NURseno5YlRDakFaQjliK1BtUjZGbk9aek40Y3hETUdaUDZ2Wmho?=
 =?utf-8?B?STdsdldieFJReGhoRXZUemhUejR1VVJJY29PNnNjYTNUeEdENjk0a21hZFNZ?=
 =?utf-8?B?M3puWkc1ZGxkRHhpQXZWNExOMktVZFlEWlYzd0hsaWFzV1RTNG1EVHM0NWt1?=
 =?utf-8?B?NVFDZ2l3LzBwZHJRNnd3bE1PR2lBOWJWRzJGTVFIeGMrVkROMWJveGlMazFI?=
 =?utf-8?B?RnNWK0ZsTUFYVjZOYS8wVG5wR2xzM0s5Vzd4VWY2NXU1T1l6TTl0M3hOZlMr?=
 =?utf-8?B?ai9jZTNGUEpadVRyTnFMWmZRWHpERVlFVzZQTjExaGo1V1hSc0NzMzRVVjl6?=
 =?utf-8?B?NjhwUW5QY1pkVlNLa09yL0pNYlBDTnBLVWxmTFJleFlWS3pRM3NzbitreG8r?=
 =?utf-8?B?L0kydUxiekduRG5vNFRPUXlwYXA4dHNORDhwN1lqTHhYV2Jqd3VsYjFjRCs4?=
 =?utf-8?B?aDREd21lUEFuR09pTkJzdjdPTGFNdGdYSC95RXNQNlF6NHo2czBucm5UdEpk?=
 =?utf-8?B?MUhhWlhFejBIaXVuQ1RlNEVqTmp6N1J3NVlVV3U5RTU4NDQ3RENpMTViSS84?=
 =?utf-8?B?eGxyRWJYaDJnM2FWYmZ3cDZQdkk5NFVMOVlyTWJTUXdCVjFwRkhWeUlVaWN6?=
 =?utf-8?B?NlNqNFJJUEwzZDBqV00vbEFXZnFheEJQRE8wZktKc1JFR0dHem4ybUJOdDhK?=
 =?utf-8?B?ZnptNTFLUlo2USs2T25aOHNQbVNIaWY1N0dPd1F0UTVYamJJOExlUkRuMlNR?=
 =?utf-8?B?SC9Zb3BWUjY5R0JQQ3JDYXV6OFVZcXhDS29RTWhqSTBreklhZ2VyMzRhZTlY?=
 =?utf-8?B?SlFRdVNjZUhIdytPOTNQVE15Mm9WTDI5MUtPL1pBdEZ0b05qbkRDT0ZUL3VL?=
 =?utf-8?B?U1N1QU1adWk1bEZTM3QwcDJGRkwwWlpHVHZFQ3k3UDBqVFVOZytUKzVweGlr?=
 =?utf-8?B?djgrcUxhN3VlVlFlZmtJNWxScGZIS29rTFhUbTM0NUwrZTZxNG9LeVMrWUx1?=
 =?utf-8?B?WGZYTmsvdkdsR2kxN3lhRll3R2lOL1FBK2tRSEgxRmNoTnFDenh5WnEwWWo0?=
 =?utf-8?B?dXh5Vjh2OEtnMmFPM2xKeWFhUzk2RU5oa2xCRVVydk5nSEsyWXFuaHkvSkFZ?=
 =?utf-8?B?OGhjMFlxT3VURk1rdlZYbDRWMWNSQkg3bE9xeXhhdWJaZnY4WEJMKytvZkRm?=
 =?utf-8?B?L2hBekxmN1J3QzFuOFd5SmFYQUpIcGRxdzVLQVI3WW5mRS9Ga01OUnJSSlZh?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795cf033-cc41-4883-d08a-08dab6613585
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:16:25.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roqrQ9EGjehnpw0TMBNju5JCuGpEwnMnUKJeMnAwtofbAn6QbA1eQOd9vXct1ZtJFqoLVCwpU6l6DmPf+RiG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5723
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 08:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9814

On 25.10.22 10:09, Su, Bao Cheng (DI FA CTR IPC CN PRC4) wrote:
> On Mon, 2022-10-24 at 14:27 +0200, sven.schultschik@siemens.com wrote:
>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>
>> This series of patches will add recipes to build a QEMU setup
>> which uses OP-TEE to use RPBM (Replay protected memory) of
>> an EMMC for a secure storage. Which is used within Secureboot
>> on ARM64. QEMU itself does not have an implementation of a
>> virtual RPBM. Therefore a patch for u-boot is needed which
>> adds this feature to u-boot, but breaks hardware
>> compatibility within u-boot. As soon as QEMU has a native
>> RPMB support included, the patch can be removed.
>>
> 
> Part of this patch could also be integrated into real setup, besides
> QEMU?

Yes, this is the plan. QEMU is the friendly testing environment, and
then devices like the IOT2050 could pick up the baseline and use it for
its own, real setup. So, whatever can be done generically here, should
be done this way.

Jan

> 
> By the way, s/RPBM/RPMB/
> 
>> The last patch is ment for manually test and verify the
>> patches, but should not be merged.
>>
>> Sven Schultschik (8):
>>   add recipe for edk2
>>   add recipe for optee qemu arm64
>>   Include optee into u-boot
>>   add u-boot patch for qemu to support RPMB
>>   add recipe for trusted firmware a qemu arm64
>>   add kas files for building qemu secure boot images
>>   enhance start-qemu.sh for arm64 secure boot
>>   no merge - manually instructions test secure boot
>>
>>  README.md                                     |   65 +
>>  kas/opt/u-boot-efi-ebg-op-tee-qemu.yml        |   11 +
>>  keys/helloworld.efi                           |  Bin 0 -> 4576 bytes
>>  recipes-bsp/edk2/edk2_202205.bb               |   43 +
>>  recipes-bsp/edk2/files/rules.tmpl             |   61 +
>>  .../op-tee/optee-os-qemu-arm64_3.17.0.bb      |   54 +
>>  .../trusted-firmware-a-qemu-arm64_2.7.0.bb    |   61 +
>>  ...hack.-Breaks-proper-hardware-support.patch | 1375 +++++++++++++++++
>>  recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |    9 +-
>>  recipes-bsp/u-boot/u-boot-qemu-common.inc     |    5 +
>>  start-qemu.sh                                 |   14 +-
>>  11 files changed, 1695 insertions(+), 3 deletions(-)
>>  create mode 100644 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml
>>  create mode 100644 keys/helloworld.efi
>>  create mode 100644 recipes-bsp/edk2/edk2_202205.bb
>>  create mode 100755 recipes-bsp/edk2/files/rules.tmpl
>>  create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
>>  create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb
>>  create mode 100644 recipes-bsp/u-boot/files/0002-rpmb-emulation-hack.-Breaks-proper-hardware-support.patch
>>
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux


