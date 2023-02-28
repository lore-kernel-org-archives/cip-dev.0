Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F67DC64EC7
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 17:34:10 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.65])
 by mx.groups.io with SMTP id smtpd.web11.30280.1677605643091371786
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Feb 2023 09:34:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uix3k3E6;
 spf=pass (domain: siemens.com, ip: 40.107.104.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTd3+kdrFY0/647yC9nTWJ3RW7zUvuRENkb+0LESBcyu+eIykJVo/ittvznztapLjQs4eNwpV4n3RxZM58gYU0UzEpSDy/GnC/SiQEsXEIg7dJZja+oARAvV7zJT/RXoVxGjSA+g2n1pML4Q5Xw+7GUK782OpGNM7FBRYR3QrqWeafTXBldTr7Pb21yuBwyX7QBfZPk07gyDUFnQFOt+Z5RWoLr5y+Ct8ZMhHpp7vlbb5na3dJ3de6+b8KGwtswJDfFdarvuSEx7i/g/20YBI07DQ+LvIAv7iHKa02AJqWrWnXUpJcxyeOMO4isNbKdoWJAkpdRY5xA8yJ2M+YghWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP8bxOxvt7EXfaT0eyno483q57o5AMxtLedhZgDJ1lo=;
 b=n0w71i0GmK0Ox26eyd62kb2C0YXPpR59CuccG+enXRmxpP/hJLpuRmA49/8XBnfYdFXLysVnIOretoL+DXwyv3OgmETDqUeDnfuPkbXyKStSQfS2+QDiY2xfCevuLqC4Is7OUb2c5iPlwKnvxqwZQYX+5YTy71msuN+3kySnhRU0PyVZgabnWLtulNJHVYCXGw8U5huW2iRtySLXEyDj8AYVEKVD1+Dn4mm6rwMa3lPwR1v9eCUMh9LINxaOiwGkwiJjU+yYypUTpubfm0hsR3dPDyZWkIEoY8LC/AeRp2EWefvtKRsmz7hXP21f5LeE1i1rVAoC9xGWSYOS+veNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP8bxOxvt7EXfaT0eyno483q57o5AMxtLedhZgDJ1lo=;
 b=uix3k3E6ysu6jB9+9dju01mIOVhROD48Ed0VmhApINxueRMK3kRoyjULTFY54mobOwt95f0OSBnzhQmTNkKhydFwoaEsueDQeCwNxM7MnRJIpmSGSGPrJnWBW7sv9Om+Ynic8NLnEM5MMTS7NEW8Rw2hCs33k0c1npICdK0HvoeDmrnXLKhrt5qXOvZTw04Syk/7gNMRvNCFdHg6k3Xv3F99oA2AyBb20DBeYdkBhF0yr2sxZZQvrI1Cjf/QHxwQB3T8/02U8aqQX5jsmwGE2t4SgVXVrvzkJ8NmKs3WSr8YRi5tMbny5o92weVpS6tUBgMnvaVdZnH9yjX41eDuLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Tue, 28 Feb
 2023 17:34:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 17:34:00 +0000
Message-ID: <9aa65117-ecc1-f709-4eef-2a7e228227d4@siemens.com>
Date: Tue, 28 Feb 2023 18:33:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH] README.secureboot.md: update the document
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org
CC: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230228120825.2522604-1-srinuvasan_a@mentor.com>
 <4d25f4fd-8be7-6c5f-1e53-a85f21781076@siemens.com>
 <18e068b2-303d-6d30-84a8-a86a96d9179f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <18e068b2-303d-6d30-84a8-a86a96d9179f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1513a4f1-37c0-4bf9-237a-08db19b1fa5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	onRHwKj1WcVJetpeMIbo1bfdf60jMxC+BtRm7mRZbrs7sM/bts0rRaQEZaUDwKBhiY99g5sVVMWvWoDKHTc0+9RrZYW4gRhdWlad6fenuA423aA70FiWdUHG1xX/2Z6NaJMnOvo+HNJFi7+54xGPFQmnFqB7D1Sn8raIRunD8nVWNLlyjJ5OYGfMsTI3rf892GaTC44X/mjUb/6+JYFZ8J1PgrGB5ZnmDsohvBBjpdy5DYJJfoJAi4cKq9XmpZAULzXjAwzXFxmVaoBXpEgGgNzErDtEsvHu4ZiA8OIaZQToTtk/1k22n8OkuexDrxP6V+3CKYkU4bLoXDBDyVF5EoIOi3f4jAZ/4BZy4YxEjz5deKrDdUDLlXDURsJBfyTn2ykN43RFC5ICCBGINCMK19s7DhvlQa3rHhXa0lO+ykHkQwv1Jm6+nlFATgV2nvmQ0ioSl5E2igeBI3N2I24BG987l+gscrGqItPfBI3c1mIJPOkdOo6DCaSxhKY7FQ2Ja1Q/MTt1MN4grkUXxDAjmM0KnNj/jEhn1n5JOgDchifR76oA4I9WlF/kMmqynLTgh3DD7sA7RG1wcU+gp4m3oYe2wm6Blk4n8lABNZI5laf+jze38TtPQ16b9AXPbVhtb1buAanlK6oBpI+MWqnBCrNOfFtijzvQ0tkqJUhi5qTnz4Shc16q58crUBKqg0tfuUlVIH/bdsznNCgD9w4G55WRDGgA4t0uCB8zkBZV+de3y1W32jFFU7SK4EfhvWM5
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(31686004)(8936002)(4326008)(110136005)(478600001)(41300700001)(66556008)(66476007)(53546011)(66946007)(26005)(8676002)(36756003)(31696002)(86362001)(107886003)(6486002)(82960400001)(6506007)(2616005)(6512007)(15650500001)(83380400001)(44832011)(316002)(38100700002)(186003)(5660300002)(2906002)(45980500001)(43740500002)(47845001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+Apmd5br6XArnfEyuayHHYbLL9DXEfb2xxujkXsjPhHrUTl3tSSsgKmYh0F+?=
 =?us-ascii?Q?0Qlo6wveEJxRwhIU2CMdVBe1cGLGi26Jg58CokQDcvrOxu4rm9gjZ43aO/Xu?=
 =?us-ascii?Q?fggCDLm02w17zHq73F5+XdQtCIlUAMdApUY/t5L03HH1yX6cpT+Ro6e1ne0w?=
 =?us-ascii?Q?XGpVHXBRjRyBdVxGEdJzKSHwCT2nzWiZxRrsyUl6HHWDRUNR5h4FLXHXt4mP?=
 =?us-ascii?Q?RSfGvMex9xCZNZhcPegVOEqOmtXrKNiYbIvegOrOzwHTEELs3OQGO1LjknO0?=
 =?us-ascii?Q?zGc5TfQSiUxdF3q4JnKs4/aLSVu4vgLYNEr9mwyFipwZKaUyPC6fwnyU3X/1?=
 =?us-ascii?Q?QzTZ2swU+y0uF+YQFG0TALFST4ybicVWLsKimSPYEmd7b1DBi111/DANrVI9?=
 =?us-ascii?Q?NSzk6oZlMxC9NxJfVB3rOEC8S2bf1ZmvcozfpTfxWa28Vv8oRnGX0IB7e5L2?=
 =?us-ascii?Q?tlLvhl71b31v857njKuwg5MpnI/KOpWr5DNXRoAWLrCb0RFkKH8helyUrimj?=
 =?us-ascii?Q?ya7EJ/ZqJITrU+fP53vrDQJ5kMdot4W1zTnchIsdgOyTR5SQkq93aTbRclSZ?=
 =?us-ascii?Q?h0UGnv3NAyNJk/V52vBmeivbu/eMgRFA5kvCS/V8C+gwSonaYpcxDnkcx6iL?=
 =?us-ascii?Q?iTGQXi+VFbwtnezBJKLErMFn9zNJfdx4IFQomH2rEWqaj3UyiC6gwF0rAFqa?=
 =?us-ascii?Q?qeSrbDHnJwwxJh40Ks7GRsQCWuaggDvkKCZ8MYfFz4B1mWDNn38GLNFl9MeH?=
 =?us-ascii?Q?H+MUqVDfTtmGMfFK8mFz+3Q7OolGQtjIDmDdysRB8JQlLu2U3dwgq23me7uQ?=
 =?us-ascii?Q?uU9bWoaxEcmhtQSWOPJbzj/Y5PdlKHnr7gJEThjb+J7mZiNdd6mmton+04t8?=
 =?us-ascii?Q?xBjNG7u9gx/Oi8LIXZZ1cDXGr+dKCmQeDbQCRQthN1+YuVeUOOqAqZ3sku2G?=
 =?us-ascii?Q?OzCvWEq4/j6T4WYAp8DuTAONNBTm51D2CfI2aYKZ1QOG8FNqupz7VgxUFwih?=
 =?us-ascii?Q?3XGL2XSL40zJK8tRal84LMS1SFYxbTZ3wLuK5szJTmJmYSPNo5Pyp8WEMP6g?=
 =?us-ascii?Q?681fTbRFPFUVjgELxJHIoEdU8djTZoWqO8GwniCFXOjiTcJhJlTiUjbldEMJ?=
 =?us-ascii?Q?Z13AELhbwKDADMZX4ccKN2lsj8sesnldgNsHjJWn5IWforlha0MpbavRV72k?=
 =?us-ascii?Q?MAkHX12LyFpb9hIYLjhmcnP4CifVEmkcffWkughyvCt5UM6PCGrRJ9xKo55U?=
 =?us-ascii?Q?CNohfum0KlBUwG1n2de2FwRi5ykNtIJpImLN5lqoLBZjTfwNTXnZ9JMSpdOR?=
 =?us-ascii?Q?UZS8pRnNNtZ9Hk9wCX5wiB9qpA8zSZAZD5J5qn+knd7aa47vJM/4ZA1A4qQs?=
 =?us-ascii?Q?47L56TBb9xvWDMzdDqn0fqBxPA3cY1xjih/BguO4+osabTZ/zGag+TE3bw9z?=
 =?us-ascii?Q?0RhpYwUOpW8tZhmYAHkCqxZRt9pz/alNjh7VAnG28TG+NZyIE1gPiqn2ySjD?=
 =?us-ascii?Q?mWCk2Dk4vMna6SaBuZl0vNaEyh4ZjfRGmjXisfCM7ogCo2KC1wxOcU/JzFGV?=
 =?us-ascii?Q?AuVH0oEuUVsxmoBJe7gcYjYSCNE8Q/PYZQpWafAGOWUZY7lmQ0GweYElRZzA?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1513a4f1-37c0-4bf9-237a-08db19b1fa5a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 17:34:00.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHBmPsZHCy/QMxgPuLxBuMf5PiWfrdWid7uiD1iUQstv2aDdEH9VR4HrpM49ookB66zhtCCjWF/a1Cfa1YTNkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7730
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Feb 2023 17:34:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10869

On 28.02.23 14:55, Gylstorff Quirin wrote:
>=20
>=20
> On 2/28/23 13:22, Jan Kiszka wrote:
>> On 28.02.23 13:08, Srinuvasan A wrote:
>>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>>
>>> Update the secureboot document based on the current implementation.
>>>
>>> Note: Now secureboot directly boot the linux hence no need to provide
>>> the efi
>>> file path in efi shell.
>>>
>>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>>> ---
>>> =C2=A0 doc/README.secureboot.md | 49 ++++++++++++++++++++--------------=
------
>>> =C2=A0 1 file changed, 24 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
>>> index b15ea93..54d67c7 100644
>>> --- a/doc/README.secureboot.md
>>> +++ b/doc/README.secureboot.md
>>> @@ -67,10 +67,9 @@ Set up a secure boot test environment with
>>> [QEMU](https://www.qemu.org/)
>>> =C2=A0 ### Prerequisites
>>> =C2=A0 =C2=A0 - OVMF from edk2 release edk2-stable201911 or newer
>>> -=C2=A0 - This documentation was tested under Debian 10 with OVMF
>>> (0.0~20200229-2) backported from Debian
>>> -=C2=A0 bullseye
>>> +=C2=A0 - This documentation was tested under Debian 11 with OVMF
>>> (2020.11-2+deb11u1) from Debian bullseye
>>> =C2=A0 - efitools for KeyTool.efi
>>> -=C2=A0 - This documentation was tested under Debian 10 with efitools
>>> (1.9.2-1) backported from Debian bullseye
>>> +=C2=A0 - This documentation was tested under Debian 11 with efitools
>>> (1.9.2-2~deb11u1) from Debian bullseye
>>> =C2=A0 - libnss3-tools
>=20
> Should we remove the Debian 10 lines?=C2=A0 cip-core still supports Debia=
n 10.
>=20

Yeah, for the target. I don't think anyone is still building and
configuring it on a Debian 10 host.

>=20
>>> =C2=A0 =C2=A0 ### Debian Snakeoil keys
>>> @@ -80,7 +79,7 @@ You can use them as described in section [Start
>>> Image](#start-the-image).
>>> =C2=A0 =C2=A0 ### Generate Keys
>>> =C2=A0 -#### Reuse exiting keys
>>> +#### Reuse existing keys
>>> =C2=A0 =C2=A0 It is possible to use exiting keys like
>>> /usr/share/ovmf/PkKek-1-snakeoil.pem' from Debian
>>> =C2=A0 by executing the script=C2=A0
>>> `scripts/generate-sb-db-from-existing-certificate.sh`, e.g.:
>>> @@ -196,12 +195,6 @@ and the following command is sufficient:
>>> =C2=A0 ./start-qemu.sh amd64
>>> =C2=A0 ```
>>> =C2=A0 -The default `OVMF_VARS.snakeoil_4M.fd` boot to the EFI shell. T=
o
>>> boot Linux enter the following command:
>>> -```
>>> -FS0:\EFI\BOOT\bootx64.efi
>>> -```
>>> -To change the boot behavior, enter `exit` in the shell to enter the
>>> bios and change the boot order.
>>> -
>>> =C2=A0 #### User-generated keys
>>> =C2=A0 Start the image with the following command:
>>> =C2=A0 ```
>>> @@ -239,14 +232,17 @@ scp -P 22222
>>> /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@127.0.0.1
>>> =C2=A0 ```
>>> =C2=A0 - check which partition is booted, e.g. with `lsblk`:
>>> =C2=A0 ```
>>> -root@demo:/mnt# lsblk
>>> -NAME=C2=A0=C2=A0 MAJ:MIN RM=C2=A0 SIZE RO TYPE MOUNTPOINT
>>> -sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 2G=C2=A0 0 disk
>>> -=E2=94=9C=E2=94=80sda1=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0 16.4M=C2=A0=
 0 part
>>> -=E2=94=9C=E2=94=80sda2=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
 32M=C2=A0 0 part
>>> -=E2=94=9C=E2=94=80sda3=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
 32M=C2=A0 0 part
>>> -=E2=94=9C=E2=94=80sda4=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0=
 0 part /
>>> -=E2=94=94=E2=94=80sda5=C2=A0=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0=
 0 part
>>> +root@demo:~# lsblk
>>> +NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJ:M=
IN RM=C2=A0=C2=A0 SIZE RO TYPE=C2=A0 MOUNTPOINT
>>> +sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 6G=C2=A0 0 dis=
k
>>> +=E2=94=9C=E2=94=80sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0=C2=A0 16.1M=C2=A0 0 part
>>> +=E2=94=9C=E2=94=80sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 32M=C2=A0 0 part
>>> +=E2=94=9C=E2=94=80sda3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 32M=C2=A0 0 part
>>> +=E2=94=9C=E2=94=80sda4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 1G=C2=A0 0 par=
t
>>> +=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0=C2=A0=C2=A0=C2=A0 0 110.9=
M=C2=A0 1 crypt /
>>> +=E2=94=9C=E2=94=80sda5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 1G=C2=A0 0 par=
t
>>> +=E2=94=9C=E2=94=80sda6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:6=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 1.3G=C2=A0 0 part=C2=A0 /h=
ome
>>> +=E2=94=94=E2=94=80sda7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:7=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 2.6G=C2=A0 0 part=C2=A0 /v=
ar
>>> =C2=A0 ```
>>> =C2=A0 =C2=A0 - install the swupdate and reboot the image
>>> @@ -257,11 +253,14 @@ root@demo:~# reboot
>>> =C2=A0 - check which partition is booted, e.g. with `lsblk`. The rootfs
>>> should have changed:
>>> =C2=A0 ```
>>> =C2=A0 root@demo:~# lsblk
>>> -NAME=C2=A0=C2=A0 MAJ:MIN RM=C2=A0 SIZE RO TYPE MOUNTPOINT
>>> -sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 2G=C2=A0 0 disk
>>> -=E2=94=9C=E2=94=80sda1=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0 16.4M=C2=A0=
 0 part
>>> -=E2=94=9C=E2=94=80sda2=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
 32M=C2=A0 0 part
>>> -=E2=94=9C=E2=94=80sda3=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
 32M=C2=A0 0 part
>>> -=E2=94=9C=E2=94=80sda4=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0=
 0 part
>>> -=E2=94=94=E2=94=80sda5=C2=A0=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0 1000M=C2=A0=
 0 part /
>>> +NAME=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAJ:M=
IN RM=C2=A0=C2=A0 SIZE RO TYPE=C2=A0 MOUNTPOINT
>>> +sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 6G=C2=A0 0 dis=
k
>>> +=E2=94=9C=E2=94=80sda1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:1=C2=A0=C2=A0=C2=A0 0=C2=A0 16.1M=C2=A0 0 part
>>> +=E2=94=9C=E2=94=80sda2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:2=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 32M=C2=A0 0 part
>>> +=E2=94=9C=E2=94=80sda3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:3=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 32M=C2=A0 0 part
>>> +=E2=94=9C=E2=94=80sda4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:4=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 1G=C2=A0 0 par=
t
>>> +=E2=94=9C=E2=94=80sda5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:5=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0 1G=C2=A0 0 par=
t
>>> +=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0=C2=A0=C2=A0=C2=A0 0 110.9=
M=C2=A0 1 crypt /
>>> +=E2=94=9C=E2=94=80sda6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:6=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 1.3G=C2=A0 0 part=C2=A0 /h=
ome
>>> +=E2=94=94=E2=94=80sda7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 8:7=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 2.6G=C2=A0 0 part=C2=A0 /v=
ar
>>> =C2=A0 ```
>>
>> Adding Quirin for a cross-check as well, but it looks good to me.
>>
>> Jan
>>
>=20
> Looks good to me as well
> Quirin
>=20

Thanks, merging.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


