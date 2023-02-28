Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11412C7EE2E
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 13:55:29 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.84])
 by mx.groups.io with SMTP id smtpd.web10.23697.1677592523116698978
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Feb 2023 05:55:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wG5LXkKi;
 spf=pass (domain: siemens.com, ip: 40.107.7.84, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVAZPNPgChH0dlqnpNgzO0WCnMStuavsQJuxA4dEIYAsfJMBV7NKVfUvjN4Vt8R3V/VHrBtLzzG6ugr8ETKlyJf5h5llnKXLLOHfiregyOrV0yUCm0xDkBK1rxpdYtkuP8+S2ZLMFJGi5Wm+luGN3cqCbXa5EQan5y4pTO2q/xBkXyURqZKp8Gf27+V5U8li2PrONlc9ApJTFuM07LhOhIvtxvTk4wSW49Nfwbc7kbKM/U8lBOxbfJ3uqi4tlVj8g+9NXfBPDohu4zAb3thNvUvlDdWcALpugJwMFOJ92eSmYJDaFz0ciW9BJOBSRAOUlZLjuaNKPgFaiMAkDYypBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXznHJ8cR5uLhIBNuTSreTUpdjYlU7yplAxwQICjU/k=;
 b=fFZ7CLM1lE6rf612Go1mZobMi2LX2CB3N6oj7V/Lmy1JstiiOlrFF1KnAkurBTEQj78oQxKCoslDveMgPZ606RYQFmQ0VjY/TV0MFQ5Km3FrX7FOosOU3IXcxMhbsCLQD3Iszj2wubdezRI6b2szgRr985WCeurHb/87qgvTyxI7oQB0COC9pVCmIPYiUZKsiJBWbsF2S7jd6EZf/KPbIM97Qvw/1l5KPVRFXqs5wNi5SxQQ2Hc4ivhoDHFVcE253ejtWUktCUipEgTC9MxxUj3e5WcVrSew8SlAtzmWHuMQfKmzqgI+Ffw7WpggCYexLE6qfgc4JGDe+OG/OSN+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXznHJ8cR5uLhIBNuTSreTUpdjYlU7yplAxwQICjU/k=;
 b=wG5LXkKiAHCMjXEsth4DwYvWnoaxzph1M7dE3tAQaR4tpMgJ9AddxIwKe4HlIlD8/6sDr/5ld8yJ+4vMaAxXxTZPsFloH11+4SasgAC9wEXzGnFU4SJnxlfkbM4acYhsLx0mxqOFPQxls2QaFuvTYsl76BVTFegbRwVsw+E3N9cmHgX5pT5xIBT+MM0EJQykwMlhm4fCsg1T3Gy3Czn2OTVZdw8NISugWcEf4wdffkzyj9sGyVQrVC3cRQfMC11wgZHPvxdJfB27nHgSHH4ex6jJAx15MzEJ7A5CM0fAExlhHLqOqSNMRa04J/pMxV6g98A0xsflb6K2GXt8vV6deA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB7850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:649::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 13:55:19 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 13:55:19 +0000
Message-ID: <18e068b2-303d-6d30-84a8-a86a96d9179f@siemens.com>
Date: Tue, 28 Feb 2023 14:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [isar-cip-core][PATCH] README.secureboot.md: update the document
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org
CC: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230228120825.2522604-1-srinuvasan_a@mentor.com>
 <4d25f4fd-8be7-6c5f-1e53-a85f21781076@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <4d25f4fd-8be7-6c5f-1e53-a85f21781076@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:610:54::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f2eee6-6568-4f0c-be19-08db19936d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OqFF90LI0MaZngQ1fdOs9laNOA78JgEU5z2TkGXAj+pgjPN/lH/4U+RHztkf3jD7qEscYq2NsoxZiB+tojnsSL+RdiXyzc1pRg3U42UUIvHm9ZeoLPOggWZ4A512FqgjV/zlEDLkMxQwZUyVx9xncKu/cJqj0ajZOrjqNVFwLQUgPMcuRm/6SAv6OS6i1sIhoKzXsmpoL4T5TOl8o4mfPg9Phml735ObiZFs59NE6OB9GGqre8SxHcWKosRnXTfMIcCK9tknBsV7nUxxMT9PsSMNHPnjBNKn38JU/WKdfYGMcKV095AHhRrpQwxnyZMv/mPL7wZfUV+h4kfeDHFwlgMxtXOPJVACwSW9HqnGTDEnMjJvy7J8pfgYto+VxTHPW1hV86s5HcyerLEnEsznZHxaDaQMebNsrWKbhReW1yqcuW+oBDRf8+9WA0QmwsNP9N5D1KQ7fKtSc24g8tjqFAkr/BB853Z7KEYr+3AH/gNRV9M2j60EbrxsoLlcOAMIeHb63cJ1DzUxi3IOPW9fop9KwX/3VfJkQln7ldl9RlFrgBWkjY0valvX/kUzh0W4dUtiCKUV+T1AXtpdXo/4jSjl31YmV/dIWPRf1oeAOQNLxcOsinornzQ/UG+nzvSl5YsHvABVgHTcm+SPR/7xrFP08BjC2cS3mtwMgE42b864Lhc6yVgxIDBpf6G+JgCoEuZhU2FV4gBhkGdAGG/AnwtY82l7fFjBpjtCl/GErC8moMzQifcgRvsawnnnq/61JEZorQGMbZYBBbH4/u8Ivaz3qjOWikd2SB4r0ElwuX0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199018)(8936002)(5660300002)(31686004)(2906002)(66946007)(8676002)(4326008)(66556008)(66476007)(15650500001)(41300700001)(316002)(110136005)(478600001)(6486002)(107886003)(6666004)(26005)(6512007)(186003)(53546011)(6506007)(2616005)(82960400001)(86362001)(36756003)(83380400001)(31696002)(38100700002)(43740500002)(45980500001)(47845001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/zxe4HYM76YfT/wu+ab/QScrNURPIC+BhgRKVR/9/fFNiRYPU1L+P8Ouqdbq?=
 =?us-ascii?Q?gnEMkV8IZ2DM8QSRCzTgrBr9+XLgfNBdNcIXvlL6Se4yRj3v4ijEcFrHd5Nm?=
 =?us-ascii?Q?cobUgW7x1PmacE41amhl9Ac0GiHhc2YSdb4oIevHgA7bagqj7xqwygPvTWnR?=
 =?us-ascii?Q?kApPlWWldmRzNDHbhJLudsqxKLLPi3kc8INeT2PdkzzaClo0KJTzhkHG7RXe?=
 =?us-ascii?Q?wr/Lgj1pVdlxRVj1iKMh9ohbfIAzKV6qgzaUaYNQk/Uk08nLy3rzxL5TNCV+?=
 =?us-ascii?Q?Eb+mock+eF42I8LL8WSYyCsmKtuUR8yakjwjjXRX4TiYR0DUIHNDGxO9cC+s?=
 =?us-ascii?Q?cVBEBlEs3nsw8YfY2ihws8oFI5+xdDMxUsUQ35CGEb23jk5GkApgb0m1RTjD?=
 =?us-ascii?Q?PikInfXFHeFuk4nvDtm4n2o8lo7uVNOprxgtujhlhvRlO6xZ5x9zGVXp3RRA?=
 =?us-ascii?Q?4f+vont2DcrPlAJE9+rXHlfCCpWbJqfrL2nyL32v4h1sU86DXllwc7nSD3Wk?=
 =?us-ascii?Q?Ev/E0007eVs0VVSzAA4+AUS7BDb7FjLSmQCEjlM7kJzu9qC/2lK5s4bAdqrn?=
 =?us-ascii?Q?0eaGYASfukdFUPKJI/PV1CFXRscZMNBDFxYEBddPHM8Of8GapyjfZORxuRXG?=
 =?us-ascii?Q?a5LImp+Gj565/csunTPXP7QgtzjTNbH2Coh9Ecdon7ncTVAvdCLH8MVZ5JkG?=
 =?us-ascii?Q?jAdSB6HzmyGApc/kU+tUP+M8l4R2TRyW533p3rSnixdVhAsZcNK/UeMbokur?=
 =?us-ascii?Q?GVgSCs6uEmN4fiu+lSNYuwf8slnAVDucQJcGlwgNhyWt1PAJ+KppYXLNBupb?=
 =?us-ascii?Q?l7k9EplXHQ3gYsrkE6dzvrKNMmZyDp4zUSiMxwlLoLWInqqGy/P5qClJ4Zpo?=
 =?us-ascii?Q?MIhIzbs2SYPzPO24hfqyho2JTLCA6wHhpzhJN7+TtmzmDSogcC6HhxgWQ7cw?=
 =?us-ascii?Q?UET17tLEODGwippKGfZQ5WU8NYiiMajJ7Y8haAudoWhsxMgy5itHAAESzcta?=
 =?us-ascii?Q?vw2pYilYPs1MbdhEJ0hKgAGzeHk+YehK5z6xBp5yVy9SaERyhiFuNVX6Xi69?=
 =?us-ascii?Q?2T+HUApUAWjIhxbDrK6gZ7LS6vTOQZOZ/kqnZi370Z0MbElvJXaHOGtG72Kl?=
 =?us-ascii?Q?Y7fT2ddCD3hQ6GQHM8L3TL01zxocAoPr4brprbaK+ya8vEMFpC48fUy51r7E?=
 =?us-ascii?Q?kvpQO7ub96/XAf4/ZX85U70nsPvbUbn1cQkoor2hQOqeCkviJV6N8Ep1kAJ1?=
 =?us-ascii?Q?C5UTXEU+uCCZDNgOSojkwXdS8Zvbc5Sq4OTSSWsvGswWL4DXkW3Ue2kDzC9w?=
 =?us-ascii?Q?2gCeoBPmVyj/2c7JlZBHFrGMtUPAK4c0J2CJW5rPJJAUFB2CdrUgfKiwDGvN?=
 =?us-ascii?Q?N7U4kU9ZZsAzmSmf1/b4gsSWJc05xmY8vIufHzhFOCOW48hJ2SeqEUDUOU7a?=
 =?us-ascii?Q?TarRUqc2QGKsa8jWQXnYBcJFmX9vvYNmwMRnHw+PRsM3i0QyzJ+jk0VOWEBj?=
 =?us-ascii?Q?coA5OComsqxIQQIKHKHlSrMJetbD0+mlqf++p3pq5AoOqgXdpm0hQDQxaFw/?=
 =?us-ascii?Q?cenH6JqBqKKO7lljM/ZFlOTrmQeGPIaX3d/biiTi6lrHP4oHU7uhCgYXS2kL?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f2eee6-6568-4f0c-be19-08db19936d86
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 13:55:19.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNp4prctyXTjLps/kIsRWBJbeTWzgbz8KLE5XFNfVnZpiTU5qSvdOcph0rPqBEt00IDd6wwCaeYDtR2ybUamrp3iwTgq2weDQltcuk8JIo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7850
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Feb 2023 13:55:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10867



On 2/28/23 13:22, Jan Kiszka wrote:
> On 28.02.23 13:08, Srinuvasan A wrote:
>> From: Srinuvasan A <srinuvasan.a@siemens.com>
>>
>> Update the secureboot document based on the current implementation.
>>
>> Note: Now secureboot directly boot the linux hence no need to provide th=
e efi
>> file path in efi shell.
>>
>> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
>> ---
>>   doc/README.secureboot.md | 49 ++++++++++++++++++++--------------------
>>   1 file changed, 24 insertions(+), 25 deletions(-)
>>
>> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
>> index b15ea93..54d67c7 100644
>> --- a/doc/README.secureboot.md
>> +++ b/doc/README.secureboot.md
>> @@ -67,10 +67,9 @@ Set up a secure boot test environment with [QEMU](htt=
ps://www.qemu.org/)
>>   ### Prerequisites
>>  =20
>>   - OVMF from edk2 release edk2-stable201911 or newer
>> -  - This documentation was tested under Debian 10 with OVMF (0.0~202002=
29-2) backported from Debian
>> -  bullseye
>> +  - This documentation was tested under Debian 11 with OVMF (2020.11-2+=
deb11u1) from Debian bullseye
>>   - efitools for KeyTool.efi
>> -  - This documentation was tested under Debian 10 with efitools (1.9.2-=
1) backported from Debian bullseye
>> +  - This documentation was tested under Debian 11 with efitools (1.9.2-=
2~deb11u1) from Debian bullseye
>>   - libnss3-tools

Should we remove the Debian 10 lines?  cip-core still supports Debian 10.


>>  =20
>>   ### Debian Snakeoil keys
>> @@ -80,7 +79,7 @@ You can use them as described in section [Start Image]=
(#start-the-image).
>>  =20
>>   ### Generate Keys
>>  =20
>> -#### Reuse exiting keys
>> +#### Reuse existing keys
>>  =20
>>   It is possible to use exiting keys like /usr/share/ovmf/PkKek-1-snakeo=
il.pem' from Debian
>>   by executing the script  `scripts/generate-sb-db-from-existing-certifi=
cate.sh`, e.g.:
>> @@ -196,12 +195,6 @@ and the following command is sufficient:
>>   ./start-qemu.sh amd64
>>   ```
>>  =20
>> -The default `OVMF_VARS.snakeoil_4M.fd` boot to the EFI shell. To boot L=
inux enter the following command:
>> -```
>> -FS0:\EFI\BOOT\bootx64.efi
>> -```
>> -To change the boot behavior, enter `exit` in the shell to enter the bio=
s and change the boot order.
>> -
>>   #### User-generated keys
>>   Start the image with the following command:
>>   ```
>> @@ -239,14 +232,17 @@ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye=
-qemu-amd64.swu root@127.0.0.1
>>   ```
>>   - check which partition is booted, e.g. with `lsblk`:
>>   ```
>> -root@demo:/mnt# lsblk
>> -NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>> -sda      8:0    0    2G  0 disk
>> -=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
>> -=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
>> -=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
>> -=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part /
>> -=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
>> +root@demo:~# lsblk
>> +NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
>> +sda              8:0    0     6G  0 disk
>> +=E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
>> +=E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
>> +=E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
>> +=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
>> +=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
>> +=E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
>> +=E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
>> +=E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
>>   ```
>>  =20
>>   - install the swupdate and reboot the image
>> @@ -257,11 +253,14 @@ root@demo:~# reboot
>>   - check which partition is booted, e.g. with `lsblk`. The rootfs shoul=
d have changed:
>>   ```
>>   root@demo:~# lsblk
>> -NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
>> -sda      8:0    0    2G  0 disk
>> -=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
>> -=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
>> -=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
>> -=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part
>> -=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part /
>> +NAME           MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
>> +sda              8:0    0     6G  0 disk
>> +=E2=94=9C=E2=94=80sda1           8:1    0  16.1M  0 part
>> +=E2=94=9C=E2=94=80sda2           8:2    0    32M  0 part
>> +=E2=94=9C=E2=94=80sda3           8:3    0    32M  0 part
>> +=E2=94=9C=E2=94=80sda4           8:4    0     1G  0 part
>> +=E2=94=9C=E2=94=80sda5           8:5    0     1G  0 part
>> +=E2=94=82 =E2=94=94=E2=94=80verityroot 252:0    0 110.9M  1 crypt /
>> +=E2=94=9C=E2=94=80sda6           8:6    0   1.3G  0 part  /home
>> +=E2=94=94=E2=94=80sda7           8:7    0   2.6G  0 part  /var
>>   ```
>=20
> Adding Quirin for a cross-check as well, but it looks good to me.
>=20
> Jan
>

Looks good to me as well
Quirin


