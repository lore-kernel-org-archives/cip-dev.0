Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA259C433EF
	for <webhook@archiver.kernel.org>; Wed,  4 May 2022 18:41:38 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.74])
 by mx.groups.io with SMTP id smtpd.web11.1193.1651689691218636694
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 May 2022 11:41:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Pi8M/ZF4;
 spf=pass (domain: siemens.com, ip: 40.107.6.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNbpWsBMpC1vgUd3qP3izUHiyOxfn9oAiiEuAIFfJnGixX86pcYmiaf0cGDSPijypEamUTajxmXzI5AkvgXmpMomN/IzFV/rANqs/L5Ec7xX4IBj6VdR3/tpZtgT/cPzg8jlGWL88D6pYOkNCrRdxqG7NKEvgG+290DJV4yuJ2paQUjulIc/fhx9CInJ96Ja0o4qN3zxGLqU3UsH2CbL21JhOFhkTBQLaWpv7g7x6KVus+5EME4e6xgh5WMJYWRw7tZ3ziRwgmDYpjb5Hb6Mp1794eipu42yjJNLcpR2ecQvuXq/cMEDiHwBwHlvC3MP1Ff4jyW/RtvTRmjUZMmUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLER69cFwjyZFd1wdxDblGoYsVLWikkmRHkhLD5ZvHg=;
 b=gZhrNUU/iZkIKKTAvtwE86nkxryRAcogYf5bYSHfewgt2D3YW28o4ByM3grQ+Uo0xH9WrEGOT/ZOu7cFFbEWnP+4+irDTht+stm7fYlQhtKdBYYZwP/MT1lW4b0mqnP4M/N3YxPM6A80hnvcK3/f0IMKm0+H3sx0MfClG3JxcnjMcvbVjU3HVQpZlBDHxptH+2q9LWeti/opie3iJstA9MlS5gvxNzXU5JlT4NXYfDi00gPmmuO53IBTMKXZ8AUjOZ0nx5N5/SWZklz6brXBBZUwrEotjke+jGBRemmSj65ctr8oSPKVqhE6pKHw4NxHloHjzcEWuBpq7tPdbePo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=temperror action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLER69cFwjyZFd1wdxDblGoYsVLWikkmRHkhLD5ZvHg=;
 b=Pi8M/ZF4he/uy1YHoXWeP7770a4hxOdE0Jxk5d/eNVrttiS84SnshwdFeB1zU4TA65LglfmQDWzULYNQb0+IEc3CA57wKcX7+0f3zdt6GaAqQyovyEpwiTrneDQ6INhrGyzn8oQRmJ59oJbwcT87fKMURl8xcV+Uhn4loVUsO6sWu7pGnAYwPA/PM8IoUO/7pjGX9tYaN/fL6LjGPbHqkPf6ugxHyQEmnU1+mJE2oyFiWvCC+YxUuOHyw8fHc+LZw60NyY8tq19hUciqcfkQ45NLgVLgmySZo2364lBm7AIdEz0QDx+3rdxuexwM9m4kPW1UEJw0fzutUJ2eGOKLlA==
Received: from SV0P279CA0035.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::22)
 by AS8PR10MB4584.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Wed, 4 May
 2022 18:41:25 +0000
Received: from HE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::f5) by SV0P279CA0035.outlook.office365.com
 (2603:10a6:f10:12::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 4 May 2022 18:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.73) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT079.mail.protection.outlook.com (10.152.0.240) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 18:41:23 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 4 May 2022 20:41:22 +0200
Received: from [167.87.0.8] (167.87.0.8) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 20:41:22 +0200
Message-ID: <9488fa38-d319-f77b-9a6f-57c278dcdd13@siemens.com>
Date: Wed, 4 May 2022 20:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Update SRCREV
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220504125954.772971-1-Quirin.Gylstorff@siemens.com>
 <487474ce-c88a-44d1-95ae-e7a56d7a54eb@siemens.com>
In-Reply-To: <487474ce-c88a-44d1-95ae-e7a56d7a54eb@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.8]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.915600-8.000000
X-TMASE-MatchedRID: sszaBKuRWIvdDS6etHbe26x38sCrHdkHPg9yfk4YC0Zwju9EALAXQvio
	Isi7Sa0ggCOzL6v7C+em2AO8c0o94vGwUUhZtzr+3tp7FoZbCBJkbZZpQYfY4dbgzPjrV+wcMVx
	/3ZYby79IyDY579vwTJ+FqTi6pivIl52eY1rK6QxqxIBA+EkMG1zebWtZSzhqAZ0lncqeHqFNej
	dAw/bX3xdHcHEd3javlSG36bKvRcz9Ktxj1mXhOuMSAZlt9hpXFDf/GgM78iVUs0TDb9X0Q0jI1
	dwe+QhroqwDjNjTZr+8ozyo7WOjviDo43Wk5cxFv/CfDioBi1YRaPVzxrheZolSWYvdSPSY45oD
	ENe4eeskt9BigJAcVmQiKyC1ofOhI+rhpvntdArvEIEamxTF+X1b439cTWEv4M3l0EeXvQ2CeHf
	YZgVO5lWFxdHdn1FZsROFTzgidLO2nC/wqQQZo82zMw88j0dCCGrFz5XLS3Q4hD0Y/Y/a7y+7N1
	Fn6XdzirdgQROurNxH5fh+PjKkyULGxx8NZPfH+5a5xthbul1grjeh0lt2oKJVTu7sjgg1OhJ9m
	53n4aCUAUfla+IhaLLzr1NWwvOcUCvLICsEVRy1Yo1HZ6kAVpH0YXYnbGozOX/V8P8ail1ZDL1g
	Lmoa/PoA9r2LThYYKrauXd3MZDUMFsa+1wyh/JRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.915600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 910EF5D630F13E53009D898B63ABE6D2C13421978FB49F194ED56C7081ABD5812000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa436251-e1e9-4738-b77a-08da2dfdb051
X-MS-TrafficTypeDiagnostic: AS8PR10MB4584:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB4584A9288C8649276DE404B795C39@AS8PR10MB4584.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KPZ5RdR55dzEiNr/6cw8lQvB+xjl3RHgQHmHUNy1PAmnvdF1GNdXu1LQ6xFEOqRNVsFdJWdkp9szNLgSxQ3z3yK924L41vn5ebagipD6G0eTf51kZsMmqOAmTYN0EEGEpKsIQTmLp54XANV3oU28tzQAmLGJ+wqrX/XWiDJc/NAjAdE7OEZTG5gnPFyj9LeUnN2lhKy3Od3LuiHGSx5w2Wc3a1LFlylNMXsQhzFKST8RvPMI7vpkzqk0ucALt2LNPFxPSG67Wh6oYom9N7vpFCEdQaIYJwU3sS23sZ7y3kToAI6MQMWCROpkHZM+r2/Gu1xl1oCzoBl/8zuNhIaZxadgM+n5zBYPUhfHHrwkAXnrn+p5Inyt7pGSszMiDPKuseVw4AKc8th2GUsEBdO0bEoAb2pJTYh5pNRxVveKxsud5e+xbrdkA5adcyjJFJY0KySB5IElIzmLKmqITcIffmd/qQRJKU/iMMmgAy8wcr8RaNlXmp9NlBpijynh5xt4wAFz9u8WlWaxwd/0fMtLE5d2c9P7kIsh8ueUQiVhOYcABFPpmJVLNtH/NBTv/8OXZ/9viUcRnIvN2hEDXp45pHNg//rnVzKdO+5GcEYIpPKH4x0vN1Ql2yKHpA52lwelYavqy8gvktuuRvyOrydY0Ezs1y6iOFW+7KcLcLCB6NtewWm/perOt7TIOnxpSY0M0XpUYXOJFZHpBmN5A7NfYWfPWYPiPkb3iUu6mCJRjbriElFKhR/JsMC/3uoBOyqARFj1RWGreb0vFBL04nHKdWvCOb+2RGM+qoxxnrvPZ6KSLDldfjF/katoEzGHvopWeP1UnWZsAEDzwtxexneghbmkODLYAeagN92N7D6V1Fo=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(8936002)(8676002)(82960400001)(36860700001)(356005)(31696002)(86362001)(36756003)(2906002)(26005)(31686004)(53546011)(498600001)(40460700003)(15650500001)(110136005)(956004)(16526019)(19627235002)(47076005)(2616005)(6706004)(16576012)(63350400001)(83380400001)(44832011)(63370400001)(5660300002)(186003)(966005)(82310400005)(336012)(30864003)(81166007)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 18:41:23.3686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 aa436251-e1e9-4738-b77a-08da2dfdb051
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4584
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 May 2022 18:41:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8238

On 04.05.22 20:38, Jan Kiszka wrote:
> On 04.05.22 14:59, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Update SWUpdate to commit https://salsa.debian.org/debian/swupdate/
>> 344548c816b555c58ec199f31e45703897d23fb5.
>>
>> This contains the upstream version of the patches:
>>  -debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>>  -debian-rules-Add-Embedded-Lua-handler-option.patch
>>  -debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>>  -Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>>
>> The available build options are now documented in ${S}/debian/README.Debian.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  ...SWUpdate-USB-service-and-Udev-rules.patch} | 24 ++++-------
>>  ...onfig-Make-image-encryption-optional.patch | 42 -------------------
>>  .../0002-debian-rules-Add-CONFIG_MTD.patch    | 27 ------------
>>  ...les-Add-Embedded-Lua-handler-option.patch} | 10 ++---
>>  ...es-Add-option-to-disable-fs-creation.patch | 16 +++----
>>  ...ules-Add-option-to-disable-webserver.patch | 18 ++++----
>>  ...h-to-fix-bootloader_env_get-for-EBG.patch} | 11 ++---
>>  ...Make-CONFIG_HW_COMPATIBILTY-optional.patch | 40 ------------------
>>  ...repare-build-for-isar-debian-buster.patch} | 34 +++------------
>>  ...option-to-disable-CONFIG_HASH_VERIFY.patch | 29 -------------
>>  .../swupdate/swupdate_2021.11-1+debian-gbp.bb | 19 ++++-----
>>  11 files changed, 49 insertions(+), 221 deletions(-)
>>  rename recipes-core/swupdate/files/{0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch => 0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch} (65%)
>>  delete mode 100644 recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>>  delete mode 100644 recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>>  rename recipes-core/swupdate/files/{0006-debian-rules-Add-Embedded-Lua-handler-option.patch => 0002-debian-rules-Add-Embedded-Lua-handler-option.patch} (83%)
>>  rename recipes-core/swupdate/files/{0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch => 0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch} (89%)
>>  delete mode 100644 recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>>  rename recipes-core/swupdate/files/{0010-debian-prepare-build-for-isar-debian-buster.patch => 0006-debian-prepare-build-for-isar-debian-buster.patch} (58%)
>>  delete mode 100644 recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>>
>> diff --git a/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch b/recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> similarity index 65%
>> rename from recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> rename to recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> index 90c8d98..239b389 100644
>> --- a/recipes-core/swupdate/files/0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> +++ b/recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>> @@ -1,7 +1,7 @@
>> -From db391d1dd34806ae6694205b08b4661318bef37b Mon Sep 17 00:00:00 2001
>> +From 7925d016efc3e9ebac10a465f165135f21c5d799 Mon Sep 17 00:00:00 2001
>>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  Date: Mon, 7 Feb 2022 09:28:39 +0100
>> -Subject: [PATCH 07/10] debian: Remove SWUpdate USB service and Udev rules
>> +Subject: [PATCH 1/6] debian: Remove SWUpdate USB service and Udev rules
>>  
>>  The current implementation will install an abitrary SWUpdate binary
>>  from a plug-in USB stick. This is a major security risk for devices
>> @@ -13,16 +13,14 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  ---
>>   debian/rules                          | 1 -
>>   debian/swupdate.swupdate-usb@.service | 8 --------
>> - debian/swupdate.udev                  | 2 --
>> - 3 files changed, 11 deletions(-)
>> + 2 files changed, 9 deletions(-)
>>   delete mode 100644 debian/swupdate.swupdate-usb@.service
>> - delete mode 100644 debian/swupdate.udev
>>  
>>  diff --git a/debian/rules b/debian/rules
>> -index 12eb0ba..76fce01 100755
>> +index 95d4d48f..ff8b6726 100755
>>  --- a/debian/rules
>>  +++ b/debian/rules
>> -@@ -101,7 +101,6 @@ override_dh_auto_install:
>> +@@ -79,7 +79,6 @@ override_dh_auto_install:
>>   override_dh_installsystemd:
>>   	dh_installsystemd --no-start
>>   	dh_installsystemd --name=swupdate-progress
>> @@ -32,7 +30,7 @@ index 12eb0ba..76fce01 100755
>>   override_dh_gencontrol:
>>  diff --git a/debian/swupdate.swupdate-usb@.service b/debian/swupdate.swupdate-usb@.service
>>  deleted file mode 100644
>> -index eda9d15..0000000
>> +index eda9d153..00000000
>>  --- a/debian/swupdate.swupdate-usb@.service
>>  +++ /dev/null
>>  @@ -1,8 +0,0 @@
>> @@ -44,14 +42,6 @@ index eda9d15..0000000
>>  -ExecStartPre=/bin/mount /dev/%I /mnt
>>  -ExecStart=/bin/sh -c "swupdate-client -v /mnt/*.swu"
>>  -ExecStopPost=/bin/umount /mnt
>> -diff --git a/debian/swupdate.udev b/debian/swupdate.udev
>> -deleted file mode 100644
>> -index b4efd0b..0000000
>> ---- a/debian/swupdate.udev
>> -+++ /dev/null
>> -@@ -1,2 +0,0 @@
>> --ACTION=="add", KERNEL=="sd*", SUBSYSTEM=="block", ENV{ID_BUS}=="usb", ENV{ID_FS_USAGE}=="filesystem", TAG+="systemd", ENV{SYSTEMD_WANTS}+="swupdate-usb@%k.service"
>> --
>>  -- 
>> -2.34.1
>> +2.35.1
>>  
>> diff --git a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> deleted file mode 100644
>> index aa20ab6..0000000
>> --- a/recipes-core/swupdate/files/0001-debian-config-Make-image-encryption-optional.patch
>> +++ /dev/null
>> @@ -1,42 +0,0 @@
>> -From 5d78de76eab1218494c714e9816152e4d821fa86 Mon Sep 17 00:00:00 2001
>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -Date: Wed, 29 Sep 2021 15:28:21 +0200
>> -Subject: [PATCH 01/10] debian/config: Make image encryption optional
>> -
>> -This can be use to ease the setup with SWUpdate.
>> -
>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ----
>> - debian/configs/defconfig | 1 -
>> - debian/rules             | 3 +++
>> - 2 files changed, 3 insertions(+), 1 deletion(-)
>> -
>> -diff --git a/debian/configs/defconfig b/debian/configs/defconfig
>> -index 02681e5..b34168e 100644
>> ---- a/debian/configs/defconfig
>> -+++ b/debian/configs/defconfig
>> -@@ -3,7 +3,6 @@ CONFIG_HW_COMPATIBILITY=y
>> - CONFIG_DOWNLOAD=y
>> - CONFIG_DOWNLOAD_SSL=y
>> - CONFIG_SIGALG_CMS=y
>> --CONFIG_ENCRYPTED_IMAGES=y
>> - CONFIG_SURICATTA=y
>> - CONFIG_SURICATTA_SSL=y
>> - CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
>> -diff --git a/debian/rules b/debian/rules
>> -index 864add2..08b74a1 100755
>> ---- a/debian/rules
>> -+++ b/debian/rules
>> -@@ -41,6 +41,9 @@ endif
>> - ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
>> - endif
>> -+ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
>> -+	echo CONFIG_ENCRYPTED_IMAGES=y >> configs/debian_defconfig
>> -+endif
>> - ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>> - endif
>> --- 
>> -2.34.1
>> -
>> diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> deleted file mode 100644
>> index e62a4fc..0000000
>> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>> +++ /dev/null
>> @@ -1,27 +0,0 @@
>> -From c3adc5d2be41e151c811c96f2bed245778fec82c Mon Sep 17 00:00:00 2001
>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -Date: Wed, 29 Sep 2021 11:29:57 +0200
>> -Subject: [PATCH 02/10] debian/rules: Add CONFIG_MTD
>> -
>> -if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>> -
>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ----
>> - debian/rules | 1 +
>> - 1 file changed, 1 insertion(+)
>> -
>> -diff --git a/debian/rules b/debian/rules
>> -index 08b74a1..6705140 100755
>> ---- a/debian/rules
>> -+++ b/debian/rules
>> -@@ -20,6 +20,7 @@ endif
>> - override_dh_auto_configure:
>> - 	cp debian/configs/defconfig  configs/debian_defconfig
>> - ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>> -+	echo CONFIG_MTD=y                  >> configs/debian_defconfig
>> - 	echo CONFIG_SWUFORWARDER_HANDLER=y >> configs/debian_defconfig
>> - 	echo CONFIG_CFI=y                  >> configs/debian_defconfig
>> - 	echo CONFIG_CFIHAMMING1=y          >> configs/debian_defconfig
>> --- 
>> -2.34.1
>> -
>> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
>> similarity index 83%
>> rename from recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> rename to recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
>> index 1d6a247..9ca5002 100644
>> --- a/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-handler-option.patch
>> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-option.patch
>> @@ -1,7 +1,7 @@
>> -From 19969a388e414db84e54a706e9227c301b0408a2 Mon Sep 17 00:00:00 2001
>> +From d262afcf95e617eace2f4207d4690587841d8882 Mon Sep 17 00:00:00 2001
>>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  Date: Wed, 29 Sep 2021 11:32:41 +0200
>> -Subject: [PATCH 06/10] debian/rules: Add Embedded Lua handler option
>> +Subject: [PATCH 2/6] debian/rules: Add Embedded Lua handler option
>>  
>>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  ---
>> @@ -9,10 +9,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   1 file changed, 5 insertions(+)
>>  
>>  diff --git a/debian/rules b/debian/rules
>> -index 19870e9..12eb0ba 100755
>> +index ff8b6726..e1df4f06 100755
>>  --- a/debian/rules
>>  +++ b/debian/rules
>> -@@ -68,7 +68,12 @@ ifneq (,$(LUA_VERSION))
>> +@@ -51,7 +51,12 @@ ifneq (,$(LUA_VERSION))
>>   	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>>   	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>>   	echo CONFIG_HANDLER_IN_LUA=y             >> configs/debian_defconfig
>> @@ -26,5 +26,5 @@ index 19870e9..12eb0ba 100755
>>   	echo CONFIG_EXTRA_LDFLAGS=\"$(LDFLAGS)\"           >> configs/debian_defconfig
>>   	echo CONFIG_EXTRA_LDLIBS=\"$(LDLIBS)\"             >> configs/debian_defconfig
>>  -- 
>> -2.34.1
>> +2.35.1
>>  
>> diff --git a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> index 08ba9b9..c6f84ce 100644
>> --- a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> +++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>> @@ -1,7 +1,7 @@
>> -From 17d962a9b43f5debaed85affc6dccb2c471bffe9 Mon Sep 17 00:00:00 2001
>> +From 404d1f73f791babf3dd4546fa5f671f7717d6179 Mon Sep 17 00:00:00 2001
>>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  Date: Mon, 4 Oct 2021 17:15:56 +0200
>> -Subject: [PATCH 03/10] debian/rules: Add option to disable fs creation
>> +Subject: [PATCH 3/6] debian/rules: Add option to disable fs creation
>>  
>>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  ---
>> @@ -10,7 +10,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   2 files changed, 9 insertions(+), 6 deletions(-)
>>  
>>  diff --git a/debian/configs/defconfig b/debian/configs/defconfig
>> -index b34168e..d011deb 100644
>> +index ad28854c..d8e260b6 100644
>>  --- a/debian/configs/defconfig
>>  +++ b/debian/configs/defconfig
>>  @@ -9,12 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
>> @@ -27,12 +27,12 @@ index b34168e..d011deb 100644
>>   CONFIG_RAW=y
>>   CONFIG_RDIFFHANDLER=y
>>  diff --git a/debian/rules b/debian/rules
>> -index 6705140..983e122 100755
>> +index e1df4f06..2ed88ad2 100755
>>  --- a/debian/rules
>>  +++ b/debian/rules
>> -@@ -45,6 +45,15 @@ endif
>> - ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_ENCRYPTED_IMAGES=y >> configs/debian_defconfig
>> +@@ -44,6 +44,15 @@ endif
>> + ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
>>   endif
>>  +ifeq (,$(filter pkg.swupdate.nocreatefs,$(DEB_BUILD_PROFILES)))
>>  +	echo CONFIG_DISKPART=y            >> configs/debian_defconfig
>> @@ -47,5 +47,5 @@ index 6705140..983e122 100755
>>   	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>>   endif
>>  -- 
>> -2.34.1
>> +2.35.1
>>  
>> diff --git a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> index eaa6fcf..c670ee9 100644
>> --- a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> +++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-webserver.patch
>> @@ -1,7 +1,7 @@
>> -From a02a6d4385f314601ef5c7094ecb26f5b5c3f134 Mon Sep 17 00:00:00 2001
>> +From 9e5313a9fe784e55bcf25dc0b61573aeedcc11ee Mon Sep 17 00:00:00 2001
>>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  Date: Mon, 4 Oct 2021 17:27:11 +0200
>> -Subject: [PATCH 04/10] debian/rules: Add option to disable webserver
>> +Subject: [PATCH 4/6] debian/rules: Add option to disable webserver
>>  
>>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  ---
>> @@ -10,10 +10,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>  
>>  diff --git a/debian/configs/defconfig b/debian/configs/defconfig
>> -index d011deb..337fcce 100644
>> +index d8e260b6..c365f9ce 100644
>>  --- a/debian/configs/defconfig
>>  +++ b/debian/configs/defconfig
>> -@@ -6,8 +6,6 @@ CONFIG_SIGALG_CMS=y
>> +@@ -6,8 +6,6 @@ CONFIG_ENCRYPTED_IMAGES=y
>>   CONFIG_SURICATTA=y
>>   CONFIG_SURICATTA_SSL=y
>>   CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=y
>> @@ -23,12 +23,12 @@ index d011deb..337fcce 100644
>>   CONFIG_UNIQUEUUID=y
>>   CONFIG_RAW=y
>>  diff --git a/debian/rules b/debian/rules
>> -index 983e122..6078ed8 100755
>> +index 2ed88ad2..58742a6b 100755
>>  --- a/debian/rules
>>  +++ b/debian/rules
>> -@@ -39,6 +39,10 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
>> - else
>> - 	echo CONFIG_BOOTLOADER_NONE=y                   >> configs/debian_defconfig
>> +@@ -41,6 +41,10 @@ endif
>> + ifeq (,$(filter pkg.swupdate.nohwcompat,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
>>   endif
>>  +ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
>>  +	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
>> @@ -38,5 +38,5 @@ index 983e122..6078ed8 100755
>>   	echo CONFIG_SIGNED_IMAGES=y >> configs/debian_defconfig
>>   endif
>>  -- 
>> -2.34.1
>> +2.35.1
>>  
>> diff --git a/recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch b/recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
>> similarity index 89%
>> rename from recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
>> rename to recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
>> index fd263ee..793bd7a 100644
>> --- a/recipes-core/swupdate/files/0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
>> +++ b/recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch
>> @@ -1,9 +1,10 @@
>> -From 09a736a651ae05378d9ef8018589c9f834b729a6 Mon Sep 17 00:00:00 2001
>> +From 962f4b81ac1202e536628bfac822a22b8d7b0b3a Mon Sep 17 00:00:00 2001
>>  From: Jan Kiszka <jan.kiszka@siemens.com>
>>  Date: Tue, 12 Apr 2022 08:01:21 +0200
>> -Subject: [PATCH 09/10] debian: Add patch to fix bootloader_env_get for EBG
>> +Subject: [PATCH 5/6] debian: Add patch to fix bootloader_env_get for EBG
>>  
>>  Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  ---
>>   ...ix-do_env_get-for-anything-but-globa.patch | 38 +++++++++++++++++++
>>   debian/patches/series                         |  1 +
>> @@ -12,7 +13,7 @@ Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>  
>>  diff --git a/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch b/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>>  new file mode 100644
>> -index 0000000..f99f7ee
>> +index 00000000..f99f7ee6
>>  --- /dev/null
>>  +++ b/debian/patches/0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>>  @@ -0,0 +1,38 @@
>> @@ -55,12 +56,12 @@ index 0000000..f99f7ee
>>  +2.34.1
>>  +
>>  diff --git a/debian/patches/series b/debian/patches/series
>> -index 8c5564a..98628a7 100644
>> +index 8c5564ae..98628a77 100644
>>  --- a/debian/patches/series
>>  +++ b/debian/patches/series
>>  @@ -1 +1,2 @@
>>   use-gcc-compiler.diff
>>  +0001-bootloader-EBG-fix-do_env_get-for-anything-but-globa.patch
>>  -- 
>> -2.34.1
>> +2.35.1
>>  
>> diff --git a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> deleted file mode 100644
>> index eb19e5f..0000000
>> --- a/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch
>> +++ /dev/null
>> @@ -1,40 +0,0 @@
>> -From 8315d5ff8168fca1bd3752764e71f98e8b55f2ad Mon Sep 17 00:00:00 2001
>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -Date: Tue, 5 Oct 2021 10:56:25 +0200
>> -Subject: [PATCH 05/10] debian: Make CONFIG_HW_COMPATIBILTY optional
>> -
>> -Add option for qemu.
>> -
>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ----
>> - debian/configs/defconfig | 1 -
>> - debian/rules             | 3 +++
>> - 2 files changed, 3 insertions(+), 1 deletion(-)
>> -
>> -diff --git a/debian/configs/defconfig b/debian/configs/defconfig
>> -index 337fcce..6fc1137 100644
>> ---- a/debian/configs/defconfig
>> -+++ b/debian/configs/defconfig
>> -@@ -1,5 +1,4 @@
>> - CONFIG_SYSTEMD=y
>> --CONFIG_HW_COMPATIBILITY=y
>> - CONFIG_DOWNLOAD=y
>> - CONFIG_DOWNLOAD_SSL=y
>> - CONFIG_SIGALG_CMS=y
>> -diff --git a/debian/rules b/debian/rules
>> -index 6078ed8..19870e9 100755
>> ---- a/debian/rules
>> -+++ b/debian/rules
>> -@@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
>> - else
>> - 	echo CONFIG_BOOTLOADER_NONE=y                   >> configs/debian_defconfig
>> - endif
>> -+ifneq (,$(filter pkg.swupdate.hwcompatibility,$(DEB_BUILD_PROFILES)))
>> -+	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
>> -+endif
>> - ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
>> - 	echo CONFIG_MONGOOSESSL=y >> configs/debian_defconfig
>> --- 
>> -2.34.1
>> -
>> diff --git a/recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch b/recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch
>> similarity index 58%
>> rename from recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch
>> rename to recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch
>> index 1d476e9..f3b9bfc 100644
>> --- a/recipes-core/swupdate/files/0010-debian-prepare-build-for-isar-debian-buster.patch
>> +++ b/recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-buster.patch
>> @@ -1,25 +1,24 @@
>> -From c9661853aea11f090b5936363b0bae10fe6ebed6 Mon Sep 17 00:00:00 2001
>> +From 33ce7123621f5da43cc8be730e916451abe84239 Mon Sep 17 00:00:00 2001
>>  From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  Date: Wed, 29 Sep 2021 16:17:03 +0200
>> -Subject: [PATCH 10/10] debian: prepare build for isar debian buster
>> +Subject: [PATCH 6/6] debian: prepare build for isar debian buster
>>  
>>  Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  ---
>>   debian/compat  |  1 +
>>   debian/control | 10 +++++-----
>> - debian/rules   |  4 +++-
>> - 3 files changed, 9 insertions(+), 6 deletions(-)
>> + 2 files changed, 6 insertions(+), 5 deletions(-)
>>   create mode 100644 debian/compat
>>  
>>  diff --git a/debian/compat b/debian/compat
>>  new file mode 100644
>> -index 0000000..f599e28
>> +index 00000000..f599e28b
>>  --- /dev/null
>>  +++ b/debian/compat
>>  @@ -0,0 +1 @@
>>  +10
>>  diff --git a/debian/control b/debian/control
>> -index 192c4a2..9318fa1 100644
>> +index 192c4a2a..9318fa12 100644
>>  --- a/debian/control
>>  +++ b/debian/control
>>  @@ -4,7 +4,7 @@ Priority: optional
>> @@ -46,27 +45,6 @@ index 192c4a2..9318fa1 100644
>>                  libubootenv-dev <pkg.swupdate.uboot>,
>>                  libebgenv-dev <pkg.swupdate.efibootguard> | efibootguard-dev <pkg.swupdate.efibootguard>,
>>                  libcmocka-dev,
>> -diff --git a/debian/rules b/debian/rules
>> -index 4dc9e17..370ca3d 100755
>> ---- a/debian/rules
>> -+++ b/debian/rules
>> -@@ -19,13 +19,15 @@ endif
>> - 
>> - override_dh_auto_configure:
>> - 	cp debian/configs/defconfig  configs/debian_defconfig
>> --ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>> -+ifneq (,$(filter pkg.swupdate.mtd,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_MTD=y                  >> configs/debian_defconfig
>> -+ifneq (,$(filter pkg.swupdate.ubi,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_SWUFORWARDER_HANDLER=y >> configs/debian_defconfig
>> - 	echo CONFIG_CFI=y                  >> configs/debian_defconfig
>> - 	echo CONFIG_CFIHAMMING1=y          >> configs/debian_defconfig
>> - 	echo CONFIG_UBIVOL=y               >> configs/debian_defconfig
>> - 	echo CONFIG_SSBLSWITCH=y           >> configs/debian_defconfig
>> -+endif
>> - else
>> - 	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
>> - endif
>>  -- 
>> -2.34.1
>> +2.35.1
>>  
>> diff --git a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch b/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>> deleted file mode 100644
>> index a5207ee..0000000
>> --- a/recipes-core/swupdate/files/0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch
>> +++ /dev/null
>> @@ -1,29 +0,0 @@
>> -From 2776a4817eb91be3df001e04d548a702e9f5291a Mon Sep 17 00:00:00 2001
>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -Date: Mon, 14 Feb 2022 12:27:43 +0100
>> -Subject: [PATCH 08/10] Add Profile option to disable CONFIG_HASH_VERIFY
>> -
>> -This change also enables CONFIG_HASH_VERIFY by default.
>> -
>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ----
>> - debian/rules | 3 +++
>> - 1 file changed, 3 insertions(+)
>> -
>> -diff --git a/debian/rules b/debian/rules
>> -index 76fce01..4dc9e17 100755
>> ---- a/debian/rules
>> -+++ b/debian/rules
>> -@@ -42,6 +42,9 @@ endif
>> - ifneq (,$(filter pkg.swupdate.hwcompatibility,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_HW_COMPATIBILITY=y                   >> configs/debian_defconfig
>> - endif
>> -+ifeq (,$(filter pkg.swupdate.nohashverify,$(DEB_BUILD_PROFILES)))
>> -+	echo CONFIG_HASH_VERIFY=y                   >> configs/debian_defconfig
>> -+endif
>> - ifeq (,$(filter pkg.swupdate.nowebserver,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_WEBSERVER=y   >> configs/debian_defconfig
>> - 	echo CONFIG_MONGOOSESSL=y >> configs/debian_defconfig
>> --- 
>> -2.34.1
>> -
>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> index 7edefe7..0892a6b 100644
>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>> @@ -13,23 +13,20 @@ inherit dpkg-gbp
>>  include swupdate.inc
>>  
>>  SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master"
>> -SRCREV ="debian/2021.11-1"
>> +SRCREV ="344548c816b555c58ec199f31e45703897d23fb5"
>>  
>>  # add options to DEB_BUILD_PROFILES
>> -SRC_URI += "file://0001-debian-config-Make-image-encryption-optional.patch \
>> -            file://0002-debian-rules-Add-CONFIG_MTD.patch \
>> +SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
>> +            file://0002-debian-rules-Add-Embedded-Lua-handler-option.patch \
>>              file://0003-debian-rules-Add-option-to-disable-fs-creation.patch \
>>              file://0004-debian-rules-Add-option-to-disable-webserver.patch \
>> -            file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patch \
>> -            file://0006-debian-rules-Add-Embedded-Lua-handler-option.patch \
>> -            file://0007-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch \
>> -            file://0008-Add-Profile-option-to-disable-CONFIG_HASH_VERIFY.patch \
>> -            file://0009-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
>> +            file://0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch"
>>  
>>  # end patching for dm-verity based images
>>  
>> -# deactivate signing and encryption for simple a/b rootfs update
>> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning pkg.swupdate.noencryption"
>> +# deactivate signing and hardware compability for simple a/b rootfs update
>> +DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>>  
>>  # add cross build and deactivate testing for arm based builds
>>  DEB_BUILD_PROFILES += "cross nocheck"
>> @@ -40,7 +37,7 @@ DEB_BUILD_PROFILES += "cross nocheck"
>>  # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
>>  
>>  # modify for debian buster build
>> -SRC_URI_append_buster = " file://0010-debian-prepare-build-for-isar-debian-buster.patch"
>> +SRC_URI_append_buster = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
>>  
>>  # disable create filesystem due to missing symbols in debian buster
>>  # disable webserver due to missing symbols in debian buster
> 
> Thanks, applied.
> 

...too quickly: buster build is broken now.

I'm pulling it out again, please have a look.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

