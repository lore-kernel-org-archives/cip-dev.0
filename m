Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A8DEB64DB
	for <webhook@archiver.kernel.org>; Mon, 19 Jun 2023 12:49:53 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.47])
 by mx.groups.io with SMTP id smtpd.web10.6627.1687178990045602690
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jun 2023 05:49:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KHpHtUQ0;
 spf=pass (domain: siemens.com, ip: 40.107.14.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoCpUU0qKvlmCIxI50J8PnMBuJus2v+iZSx5itTw1u1PYGORQC9b4O7RM6lwIXr3m/bh4POfBmDPrxfCiGl5Fg0JVZyaJ/dQgqtU9z5xP/7n2S7kodEn1/SfLjAWzrLJrB6rRW1V8Y4DAHQ/GhZvL8f+W4k2/1+Ff4UfABBzdM57SBYo+LGVZTKyjQVwRLhMSJ+MAdNVgeRlMdERVMIQq1wSFy58Z1aXvkYZf3SpAaYxoxoq/GgVhljqrMH4hErkYMaAGsQ0QZko7OFWAnN5xOTva+mytOLm1K2Y+98Daq0e9DUsh0z4B0eQSGLfoJKdf+FO9eSkVdgER+Pn6Zy4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueK3WVK0AUIs5UoWBWExHQuBodQlQc5uhhe9RDIj8h4=;
 b=kXqsMiSC6WoROoHR7prje2IMFGU2UGZTiIg72Tlxp/+xP1duKfwMA0iuQGbLE0t5jAeSLT234NeTuu6JamrcLUVPXDEyjI654F07g2w3UEvbZC1QVu3IGcQHDNnRVf3EX8AL0ZTbYEMPdDXIv9nKbJn9bvLWobVzU7ul80Q8DozRs0vI1BooQAPtdvr5l7nxDVRfWDSBbcu1Rq/8WLRuD/mUXAO+xMQ4Mh7zNizOM/8J+NaLZgmSFPTuTRkil7tSBKUCP7JJQ3YiO4nUblpvajRyRQE0jylDGh8f65dnuvlOD5EtcZbbWhUL/Uk8ccuBO66PbmXL0tzwDo9zn87UNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueK3WVK0AUIs5UoWBWExHQuBodQlQc5uhhe9RDIj8h4=;
 b=KHpHtUQ09eufP5Jr+Hz7VjKErywyoc8KZJr0BTEQiDj5i5pCfBQy1W5/rCncsJ5m1vcJP5zRo4PaVEWDbBkkFMaOVRXEopLg7yvRqWihULOiGHx740CUDRnhjL0s29AtleSZmDRdR2Q3ENmv8aBZoCoZ3DxooqtzzXaTmTkLD3eJa8lo9Di59WgiMPHqxcKz1hYIPBGALghb0kID5n6roJa4Z4ZTr+lxhpUWpQeCvi+UbosjOjfCz/F9v4i+aKcrtgSzpBXa8vutHFM7NyUdblbvzz8/7pd5Du1RlI0D6jEgL7GZ04EkhjeSkfUk3WGXwxOwNwC8AJ+AiTNabA84Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 12:49:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 12:49:46 +0000
Message-ID: <9c903f05-5ea0-9f99-dfee-10a0c6ac39b3@siemens.com>
Date: Mon, 19 Jun 2023 14:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] swupdate: Update to 2023.05
 with wfx support
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 christian.storm@siemens.com, cip-dev@lists.cip-project.org
References: <20230619105015.195380-1-Quirin.Gylstorff@siemens.com>
 <94ab0687-0b45-b10f-3115-5d336aaae83b@siemens.com>
 <946aa906-b596-b1fa-a66b-4b61106e2cc6@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <946aa906-b596-b1fa-a66b-4b61106e2cc6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:33::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: d150e4ca-fee5-427e-cb4e-08db70c3a920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yroiNf/7OAcvWGlT5cVJlsLpSkIsLp6m6hdIy15xeH6y6aAjd17/9/ENBKDuDSIhnt2g+pTXNlPzzEJUBft7joTpEwTGgYxZnColHMsJQEcevNfXK3hDjXRHjSaRBZzjrKkYuu1H72HQ6DIgA0nGR+xk2AdqA8qNL7R3Yr7ZRYmjOsuEDsD+ODsyt5bjXPMXnqvzSDTiWAhOuxV4CdmS9loJSkY5AvFbOm11BlS7nON/zET+vYVfrJFgRfsWeK1+AIS8JomWZ2ZvB4dJ721uNkxOunGQKtq7HxBNuCwSCF5efddWpjmanvQyJ2KiNSv+Cs6CNtgv1pEFF1akcSs7iAluZ22Ks0DW1wEVPJH9HBbZdaCQMVetnXljl+bse5BZHJiy4IEmTQqXpvp0HGaMb+56ECcjrnpy06yC1vr/T4R/M4ikgmG2ml2f19n3HVxkRJIsUgGaiXi3oR1983m00I09g3OsKukCWM2xje7NRs0e9fSRMjF+pMDo1kawIdbG509S8qMRBbwte6Ze/BBJ4IflRT0YmVjjY+RWFtuWF+SNLDyEz1w3VwyU4WRhgxCLsIXpbvQW97y5se/rbldXSZT7xSZW1n15aG0zUzSf8siIUjuU2KfYx11unF1zLV99mOHwN5fnjnnI0lNjl/9e3w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(186003)(6512007)(26005)(53546011)(6506007)(82960400001)(2616005)(66899021)(83380400001)(38100700002)(478600001)(41300700001)(66556008)(66476007)(31686004)(66946007)(36756003)(8676002)(316002)(8936002)(19627235002)(15650500001)(30864003)(6486002)(31696002)(44832011)(86362001)(6666004)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qM30bEFeroHdB31I9XCm66wUxAl3jufJwYu2k/UTm1vDO+Woxkrmgp5CeA1I?=
 =?us-ascii?Q?jC264lPuVHdmC3IL45OmlENRPHhnj/HnLHafBAJhIseYmU/ZFP1J64qKYpjn?=
 =?us-ascii?Q?6hkFkmTyDtkyiSwZIlfb5UOacnWhjM9h1udFAf33z7+nBw6l/w/YPUac0LfI?=
 =?us-ascii?Q?kWuaZ49fLs52WGagKcAtQmVUNbTWC+6J0Dh+n5OR3xPpax41+Tr6rXB5iTnr?=
 =?us-ascii?Q?/jKFOm3RHvoqi+zda+hC302vq4F004NCqxd/k54WuvC+cuTnvJKf3eN1lagJ?=
 =?us-ascii?Q?hozNJ2Rz7r57viUC5ODQAwvv1hf6Xmyw9e8r35wEW2F9nWMEze6559jkMGBE?=
 =?us-ascii?Q?3RRT63QETDCa9+VurnlygjviLiy9bMRWZC5PLNfQUOvmTPMxVlXqKsKkilgJ?=
 =?us-ascii?Q?5SdcHhLnSDyaBVpAshai+1Ckdpa9B8GJE5azi6YzWWdFCDbMCfXXpoWs57q4?=
 =?us-ascii?Q?aScrH1Nw5rN8692YYcjGAD+c6MlSX8UinV3NWyuV06hd4dcyWE110Kpqh3A8?=
 =?us-ascii?Q?eG/epZqzVM6swV2tGV6TyJHl1WHxA6TnvXvRad+3bqfayH2TKPTdsDO4h/8X?=
 =?us-ascii?Q?bluhQcPBlZGws4w4TcO7pXKBQyIbPYodS+t20N6RdaUjrf0RQOiFAco1uH/2?=
 =?us-ascii?Q?qkK9KZABTDymr+ppAVsTX7VSA+s0lkmiht1hjLaq28wr9S5KFgBuhpUe891h?=
 =?us-ascii?Q?gbAKF7ws2C+7Gm+V0KEyuH7x+JJw94T4GrivbzFAlmwI1FHXr8Dkp2fC+sRV?=
 =?us-ascii?Q?0t+CjzebEFFRJ+0PwCyJz9tx8MWjwoU8dLN5SQJLOcejy6oC1kHbj0go9NiM?=
 =?us-ascii?Q?lGeQ6zibi1qOCIZZ0LgSp3zFt6+R0zJNpfUN5Mwnh0VDNUgK0iU0HqPHsAMa?=
 =?us-ascii?Q?a+KjDr2uBqZJ6cez3mhr2NNpq/fULWDH3ule7MCmRWmexU4vLBWB3WgehqD1?=
 =?us-ascii?Q?iNENOUxJjx0ejzx6n2cFsW5s/cE2M+IuUBKn0HBAeqZmEUoBvsh55l/ouRk5?=
 =?us-ascii?Q?vmSTuTTZ1TDL4fejAS2f4tKbyY0gDarCo4aM7pF5Vfi41CqUdxlqeRCVjVbO?=
 =?us-ascii?Q?V38ZqxlkF9FlLYkRk4BJktDtOj4kbc/H4PuO29oOzf1K+ib71ca/pb+SJWvt?=
 =?us-ascii?Q?mmoi792vi+4sfBXr3hapr9CtMkEZRrsqH9xTRTLgdewwfsBzF6ODMKeBgfkg?=
 =?us-ascii?Q?9tK0rq+8Wd7LpmWkvkCQgtV6bDb5/vVuIDJvZonsMbAiMhe6xatbcI1wrXK7?=
 =?us-ascii?Q?twxcbt82Ib8DEoyiKasgxkMrMaQ0tVMktJONT71mwpi6cW2UGEQBXUU4HSXg?=
 =?us-ascii?Q?ta4LDhBwKdt7VneEwbPVbHq1bNI7i9BfomcZ9ubaQ8z5EM2J5PT/P145FVgz?=
 =?us-ascii?Q?zmKfP6mEsvWdia/4+hiI9BxXoHClrsD2MZTNmdiyKtTsyvGIfEGht9r5nsJd?=
 =?us-ascii?Q?Bp0IWFzxSs4yC14YgNeK7uhvJQCtgNb4YbP1nxcpRLO6FETZG7n06WDSjWT+?=
 =?us-ascii?Q?AOM+w4D1UuC0mgEjCRATZDWsTb5m8GRNH2hQmtc9UuxXIU/prbT0NoZXcLkN?=
 =?us-ascii?Q?qptAHrTB/nhxrZ0haysJvqrDJuxjVsxvH0sKAAQcL4XgMpxwOxYOMxWUSYLR?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d150e4ca-fee5-427e-cb4e-08db70c3a920
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 12:49:46.3916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcQINLJQm60PjhNDvstjmrCUEqMDaUoEoWmXLu32bD0eacl7U+79GqCmp+KRMaRjO7eBG9JHeb3jV6KcFDsxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5155
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jun 2023 12:49:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12074

On 19.06.23 13:57, Gylstorff Quirin wrote:
>=20
>=20
> On 6/19/23 12:55, Jan Kiszka wrote:
>> On 19.06.23 12:50, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This will update swupdate to c8ca55684c375937dbcdefb0563071a35137f4ba
>>> (tools/swupdate-progress: Adapt for wfx) to add the wfx bindings.
>>>
>>> You can enable wfx by enabling during in the systemd service by writing
>>> to `/etc/swupdate/conf.d/suricatta.conf`:
>>> ```
>>> SWUPDATE_SURICATTA_ARGS=3D"-S lua <wfx arguments>"
>>> ```
>>> For the <wfx arguments> see 'swupdate -h'.
>>>
>>> To switch between wfx and hawkbit exchange `lua` with `hawkbit`.
>>>
>>
>> There is still no note that we disable delta update support with this
>> version, right?
>=20
> I will send a v3.
>=20
>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> Changes v2:
>>> =C2=A0 - add patch to display swupdate version
>>> =C2=A0=C2=A0=C2=A0 - this Patch also sets the EXTRAVERSION with package=
version+git
>>> commit sha
>>> =C2=A0 - set CONFIG_SURICATTA_WFX to always enable wfx
>>> =C2=A0 - use version 2023.05 as it is the version stored in the swupdat=
e
>>> =C2=A0=C2=A0=C2=A0 sources
>>> =C2=A0 - move patches to version specific folders for readability
>>> =C2=A0 - Add instructions to start swupdate service with wfx
>>>
>>> =C2=A0 conf/distro/cip-core-bookworm.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 conf/distro/cip-core-bullseye.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 conf/distro/cip-core-sid-ports.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 recipes-core/images/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +-
>>> =C2=A0 recipes-core/persistent-fs/files/data.mount=C2=A0=C2=A0 | 13 +++
>>> =C2=A0 recipes-core/persistent-fs/files/postinst=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +
>>> =C2=A0 .../persistent-fs/persistent-fs_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 20 ++++
>>> =C2=A0 .../0002-debian-rules-Add-CONFIG_MTD.patch=C2=A0=C2=A0=C2=A0 | 2=
7 ------
>>> =C2=A0 ...-SWUpdate-USB-service-and-Udev-rules.patch |=C2=A0 0
>>> =C2=A0 ...ules-Add-Embedded-Lua-handler-option.patch |=C2=A0 0
>>> =C2=A0 ...es-Add-option-to-disable-fs-creation.patch |=C2=A0 0
>>> =C2=A0 ...ules-Add-option-to-disable-webserver.patch |=C2=A0 0
>>> =C2=A0 ...ch-to-fix-bootloader_env_get-for-EBG.patch |=C2=A0 0
>>> =C2=A0 ...prepare-build-for-isar-debian-buster.patch |=C2=A0 0
>>> =C2=A0 ...d-rules-Add-option-for-suricatta_lua.patch |=C2=A0 4 +-
>>> =C2=A0 ...rate-build_profile-option-for-delta-.patch | 45 +++++++++
>>> =C2=A0 ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++=
++++++
>>> =C2=A0 ...s-Add-option-to-enable-suricatta_wfx.patch | 30 ++++++
>>> =C2=A0 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |=C2=A0 2 +
>>> =C2=A0 .../swupdate/swupdate_2022.12+dfsg-4-gbp.bb=C2=A0=C2=A0 | 39 ---=
-----
>>> =C2=A0 recipes-core/swupdate/swupdate_2023.05.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 | 60 ++++++++++++
>>> =C2=A0 21 files changed, 273 insertions(+), 74 deletions(-)
>>> =C2=A0 create mode 100644 recipes-core/persistent-fs/files/data.mount
>>> =C2=A0 create mode 100755 recipes-core/persistent-fs/files/postinst
>>> =C2=A0 create mode 100644 recipes-core/persistent-fs/persistent-fs_0.1.=
bb
>>> =C2=A0 delete mode 100644
>>> recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>>> =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>> 2021.11}/0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
>>> (100%)
>>> =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>> 2021.11}/0002-debian-rules-Add-Embedded-Lua-handler-option.patch (100%)
>>> =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>> 2021.11}/0003-debian-rules-Add-option-to-disable-fs-creation.patch
>>> (100%)
>>> =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>> 2021.11}/0004-debian-rules-Add-option-to-disable-webserver.patch (100%)
>>> =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>> 2021.11}/0005-debian-Add-patch-to-fix-bootloader_env_get-for-EBG.patch =
(100%)
>>> =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>> 2021.11}/0006-debian-prepare-build-for-isar-debian-buster.patch (100%)
>>> =C2=A0 rename recipes-core/swupdate/files/{ =3D>
>>> 2023.05}/0001-d-rules-Add-option-for-suricatta_lua.patch (87%)
>>> =C2=A0 create mode 100644
>>> recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_pro=
file-option-for-delta-.patch
>>> =C2=A0 create mode 100644
>>> recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the=
-build-version-to-swup.patch
>>> =C2=A0 create mode 100644
>>> recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-s=
uricatta_wfx.patch
>>> =C2=A0 delete mode 100644
>>> recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>>> =C2=A0 create mode 100644 recipes-core/swupdate/swupdate_2023.05.bb
>>>
>>> diff --git a/conf/distro/cip-core-bookworm.conf
>>> b/conf/distro/cip-core-bookworm.conf
>>> index f05d3d3..adafc92 100644
>>> --- a/conf/distro/cip-core-bookworm.conf
>>> +++ b/conf/distro/cip-core-bookworm.conf
>>> @@ -12,6 +12,6 @@
>>> =C2=A0 require conf/distro/debian-bookworm.conf
>>> =C2=A0 require cip-core-common.inc
>>> =C2=A0 -PREFERRED_VERSION_swupdate ?=3D "2022.12%"
>>> +PREFERRED_VERSION_swupdate ?=3D "2023.05%"
>>> =C2=A0 PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
>>> =C2=A0 PREFERRED_VERSION_linux-cip-rt ?=3D "5.10.%"
>>> diff --git a/conf/distro/cip-core-bullseye.conf
>>> b/conf/distro/cip-core-bullseye.conf
>>> index 9c83054..4f26299 100644
>>> --- a/conf/distro/cip-core-bullseye.conf
>>> +++ b/conf/distro/cip-core-bullseye.conf
>>> @@ -15,6 +15,6 @@ require cip-core-common.inc
>>> =C2=A0 DISTRO_APT_SOURCES:append:swupdate =3D "
>>> conf/distro/debian-bullseye-backports.list"
>>> =C2=A0 DISTRO_APT_PREFERENCES:append:swupdate =3D "
>>> conf/distro/preferences.swupdate-bullseye-backports.conf"
>>> =C2=A0 -PREFERRED_VERSION_swupdate ?=3D "2022.12%"
>>> +PREFERRED_VERSION_swupdate ?=3D "2023.05%"
>>> =C2=A0 PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
>>> =C2=A0 PREFERRED_VERSION_linux-cip-rt ?=3D "5.10.%"
>>> diff --git a/conf/distro/cip-core-sid-ports.conf
>>> b/conf/distro/cip-core-sid-ports.conf
>>> index edd3c28..2e74af7 100644
>>> --- a/conf/distro/cip-core-sid-ports.conf
>>> +++ b/conf/distro/cip-core-sid-ports.conf
>>> @@ -14,6 +14,7 @@ require cip-core-common.inc
>>> =C2=A0 =C2=A0 PREFERRED_VERSION_linux-cip ?=3D "5.10.%"
>>> =C2=A0 PREFERRED_VERSION_linux-cip-rt ?=3D "5.10.%"
>>> +PREFERRED_VERSION_swupdate ?=3D "2023.05%"
>>> =C2=A0 =C2=A0 DISTRO_APT_SOURCES =3D
>>> "conf/distro/cip-debian-sid-ports-snapshot.list"
>>> =C2=A0 HOST_DISTRO_APT_SOURCES =3D "conf/distro/cip-debian-sid-snapshot=
.list
>>> ${DISTRO_APT_SOURCES}"
>>> diff --git a/recipes-core/images/swupdate.inc
>>> b/recipes-core/images/swupdate.inc
>>> index ebc844a..6a01abb 100644
>>> --- a/recipes-core/images/swupdate.inc
>>> +++ b/recipes-core/images/swupdate.inc
>>> @@ -12,9 +12,6 @@
>>> =C2=A0 inherit image_uuid
>>> =C2=A0 inherit read-only-rootfs
>>> =C2=A0 -IMAGE_INSTALL:append:buster =3D " swupdate"
>>> -IMAGE_INSTALL:append:bullseye =3D " swupdate"
>>> -IMAGE_PREINSTALL:append:bookworm =3D " swupdate"
>>> -IMAGE_PREINSTALL:append:sid =3D " swupdate"
>>> +IMAGE_INSTALL +=3D " swupdate"
>>> =C2=A0 =C2=A0 IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>>> diff --git a/recipes-core/persistent-fs/files/data.mount
>>> b/recipes-core/persistent-fs/files/data.mount
>>> new file mode 100644
>>> index 0000000..dc64a91
>>> --- /dev/null
>>> +++ b/recipes-core/persistent-fs/files/data.mount
>>> @@ -0,0 +1,13 @@
>>> +[Unit]
>>> +Description=3DMount /data partition
>>> +Before=3Dlocal-fs.target
>>> +
>>> +[Mount]
>>> +What=3D${PERSISTENT_PARTITION}
>>> +Where=3D/data
>>> +Type=3Dauto
>>> +Options=3Ddefaults
>>> +
>>> +
>>> +[Install]
>>> +WantedBy=3Dlocal-fs.target
>>> diff --git a/recipes-core/persistent-fs/files/postinst
>>> b/recipes-core/persistent-fs/files/postinst
>>> new file mode 100755
>>> index 0000000..8a13328
>>> --- /dev/null
>>> +++ b/recipes-core/persistent-fs/files/postinst
>>> @@ -0,0 +1,3 @@
>>> +#!/bin/sh
>>> +
>>> +#deb-systemd-helper enable data.mount=C2=A0 || true
>>> diff --git a/recipes-core/persistent-fs/persistent-fs_0.1.bb
>>> b/recipes-core/persistent-fs/persistent-fs_0.1.bb
>>> new file mode 100644
>>> index 0000000..c665b6c
>>> --- /dev/null
>>> +++ b/recipes-core/persistent-fs/persistent-fs_0.1.bb
>>> @@ -0,0 +1,20 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2022
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +inherit dpkg-raw
>>> +
>>> +SRC_URI =3D "file://postinst \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file://da=
ta.mount"
>>> +
>>> +do_install[cleandirs]+=3D"${D}/lib/systemd/system"
>>> +do_install[cleandirs]+=3D"${D}/data"
>>> +do_install() {
>>> +=C2=A0=C2=A0=C2=A0 install -m 0644 ${WORKDIR}/data.mount
>>> ${D}/lib/systemd/system/data.mount
>>> +}
>>> diff --git
>>> a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>>> b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
>>> deleted file mode 100644
>>> index e62a4fc..0000000
>>> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patc=
h
>>> +++ /dev/null
>>> @@ -1,27 +0,0 @@
>>> -From c3adc5d2be41e151c811c96f2bed245778fec82c Mon Sep 17 00:00:00 2001
>>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> -Date: Wed, 29 Sep 2021 11:29:57 +0200
>>> -Subject: [PATCH 02/10] debian/rules: Add CONFIG_MTD
>>> -
>>> -if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>>> -
>>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ----
>>> - debian/rules | 1 +
>>> - 1 file changed, 1 insertion(+)
>>> -
>>> -diff --git a/debian/rules b/debian/rules
>>> -index 08b74a1..6705140 100755
>>> ---- a/debian/rules
>>> -+++ b/debian/rules
>>> -@@ -20,6 +20,7 @@ endif
>>> - override_dh_auto_configure:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 cp debian/configs/defconfig=C2=A0 configs/deb=
ian_defconfig
>>> - ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>>> -+=C2=A0=C2=A0=C2=A0 echo CONFIG_MTD=3Dy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>=
 configs/debian_defconfig
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_SWUFORWARDER_HANDLER=3Dy >> confi=
gs/debian_defconfig
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_CFI=3Dy=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 >> configs/debian_defconfig
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_CFIHAMMING1=3Dy=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >> configs/debian_defconfig
>>> ---
>>> -2.34.1
>>> -
>>> diff --git
>>> a/recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-a=
nd-Udev-rules.patch b/recipes-core/swupdate/files/2021.11/0001-debian-Remov=
e-SWUpdate-USB-service-and-Udev-rules.patch
>>> similarity index 100%
>>> rename from
>>> recipes-core/swupdate/files/0001-debian-Remove-SWUpdate-USB-service-and=
-Udev-rules.patch
>>> rename to
>>> recipes-core/swupdate/files/2021.11/0001-debian-Remove-SWUpdate-USB-ser=
vice-and-Udev-rules.patch
>>> diff --git
>>> a/recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handle=
r-option.patch b/recipes-core/swupdate/files/2021.11/0002-debian-rules-Add-=
Embedded-Lua-handler-option.patch
>>> similarity index 100%
>>> rename from
>>> recipes-core/swupdate/files/0002-debian-rules-Add-Embedded-Lua-handler-=
option.patch
>>> rename to
>>> recipes-core/swupdate/files/2021.11/0002-debian-rules-Add-Embedded-Lua-=
handler-option.patch
>>> diff --git
>>> a/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-f=
s-creation.patch b/recipes-core/swupdate/files/2021.11/0003-debian-rules-Ad=
d-option-to-disable-fs-creation.patch
>>> similarity index 100%
>>> rename from
>>> recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable-fs-=
creation.patch
>>> rename to
>>> recipes-core/swupdate/files/2021.11/0003-debian-rules-Add-option-to-dis=
able-fs-creation.patch
>>> diff --git
>>> a/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-w=
ebserver.patch b/recipes-core/swupdate/files/2021.11/0004-debian-rules-Add-=
option-to-disable-webserver.patch
>>> similarity index 100%
>>> rename from
>>> recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable-web=
server.patch
>>> rename to
>>> recipes-core/swupdate/files/2021.11/0004-debian-rules-Add-option-to-dis=
able-webserver.patch
>>> diff --git
>>> a/recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_e=
nv_get-for-EBG.patch b/recipes-core/swupdate/files/2021.11/0005-debian-Add-=
patch-to-fix-bootloader_env_get-for-EBG.patch
>>> similarity index 100%
>>> rename from
>>> recipes-core/swupdate/files/0005-debian-Add-patch-to-fix-bootloader_env=
_get-for-EBG.patch
>>> rename to
>>> recipes-core/swupdate/files/2021.11/0005-debian-Add-patch-to-fix-bootlo=
ader_env_get-for-EBG.patch
>>> diff --git
>>> a/recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian=
-buster.patch b/recipes-core/swupdate/files/2021.11/0006-debian-prepare-bui=
ld-for-isar-debian-buster.patch
>>> similarity index 100%
>>> rename from
>>> recipes-core/swupdate/files/0006-debian-prepare-build-for-isar-debian-b=
uster.patch
>>> rename to
>>> recipes-core/swupdate/files/2021.11/0006-debian-prepare-build-for-isar-=
debian-buster.patch
>>> diff --git
>>> a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua=
.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-su=
ricatta_lua.patch
>>> similarity index 87%
>>> rename from
>>> recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua.p=
atch
>>> rename to
>>> recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricat=
ta_lua.patch
>>> index 0be5a71..5aeb605 100644
>>> ---
>>> a/recipes-core/swupdate/files/0001-d-rules-Add-option-for-suricatta_lua=
.patch
>>> +++
>>> b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suric=
atta_lua.patch
>>> @@ -1,7 +1,7 @@
>>> -From 00fc691802e671594cea1d0a5e880d255e04b7f0 Mon Sep 17 00:00:00 2001
>>> +From f94f8c2f62ade7568fe8fafa106488761fc55f91 Mon Sep 17 00:00:00 2001
>>> =C2=A0 From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> =C2=A0 Date: Wed, 3 May 2023 16:02:37 +0200
>>> -Subject: [PATCH] d/rules: Add option for suricatta_lua
>>> +Subject: [PATCH 1/4] d/rules: Add option for suricatta_lua
>>> =C2=A0 =C2=A0 This allows to use lua plugins as suricatta backends. It =
is optional
>>> =C2=A0 as it overrides the default HAWKBIT backend.
>>> diff --git
>>> a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_p=
rofile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0002-d=
-rules-Add-seperate-build_profile-option-for-delta-.patch
>>> new file mode 100644
>>> index 0000000..4203061
>>> --- /dev/null
>>> +++
>>> b/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_p=
rofile-option-for-delta-.patch
>>> @@ -0,0 +1,45 @@
>>> +From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00 2001
>>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +Date: Thu, 15 Jun 2023 18:48:25 +0200
>>> +Subject: [PATCH 2/4] d/rules: Add seperate build_profile option for
>>> delta
>>> + update
>>> +
>>> +Delta update need zchunk 1.3 to work on memory restricted
>>> +devices. zchunk 1.3 is is not available in bullseye-backports
>>> +and Debian bookworm(12).
>>> +
>>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +---
>>> + debian/control | 2 +-
>>> + debian/rules=C2=A0=C2=A0 | 2 +-
>>> + 2 files changed, 2 insertions(+), 2 deletions(-)
>>> +
>>> +diff --git a/debian/control b/debian/control
>>> +index e47c320c..d4b17972 100644
>>> +--- a/debian/control
>>> ++++ b/debian/control
>>> +@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (=3D 13),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uuid-dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 zlib1g-dev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libzstd-dev,
>>> +-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 libzck-dev (>=3D 1.2) <!pkg.swupdate.bpo>,
>>> ++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 libzck-dev (>=3D 1.3) <pkg.swupdate.delta>,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libp11-kit-dev <pkg.swupdate.p11>,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libwolfssl-dev <pkg.swupdate.p11>,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 libmtd-dev [linux-any],
>>> +diff --git a/debian/rules b/debian/rules
>>> +index 91106fbd..8cac6359 100755
>>> +--- a/debian/rules
>>> ++++ b/debian/rules
>>> +@@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
>>> + else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo "# CONFIG_MTD is not set"=C2=A0=C2=A0=C2=
=A0=C2=A0 >> configs/debian_defconfig
>>> + endif
>>> +-ifeq (,$(filter pkg.swupdate.bpo,$(DEB_BUILD_PROFILES)))
>>> ++ifneq (,$(filter pkg.swupdate.delta,$(DEB_BUILD_PROFILES)))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_DELTA=3Dy >> configs/debian_defco=
nfig
>>> + endif
>>> + ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf
>>> riscv64 ia64))
>>> +--
>>> +2.39.2
>>> +
>>> diff --git
>>> a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-t=
he-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0003-d=
-patches-Add-patch-to-add-the-build-version-to-swup.patch
>>> new file mode 100644
>>> index 0000000..857b4ab
>>> --- /dev/null
>>> +++
>>> b/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-t=
he-build-version-to-swup.patch
>>> @@ -0,0 +1,94 @@
>>> +From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00 2001
>>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +Date: Fri, 16 Jun 2023 19:43:38 +0200
>>> +Subject: [PATCH 3/4] d/patches: Add patch to add the build version
>>> to swupdate
>>> +
>>> +The build version is only set if build in a git repository
>>> +this patch allows to use the version information stored in
>>> +the Makefile.
>>> +
>>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +---
>>> + ...Set-version-if-git-returns-no-informa.diff | 46 ++++++++++++++++++=
+
>>> + debian/patches/series=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> + debian/rules=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +
>>> + 3 files changed, 49 insertions(+)
>>> + create mode 100644
>>> debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.dif=
f
>>> +
>>> +diff --git
>>> a/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.d=
iff b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.d=
iff
>>> +new file mode 100644
>>> +index 00000000..7f964fb7
>>> +--- /dev/null
>>> ++++
>>> b/debian/patches/Makefile.flags-Set-version-if-git-returns-no-informa.d=
iff
>>> +@@ -0,0 +1,46 @@
>>> ++From bc50744125e8686ec2eb7e5676522da98e51601f Mon Sep 17 00:00:00 200=
1
>>> ++From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ++Date: Sat, 17 Jun 2023 17:56:18 +0200
>>> ++Subject: [PATCH] Makefile.flags: Set version if git returns no
>>> information
>>> ++
>>> ++This set the swupdate version if build in a non git environment.
>>> ++E.g. pristine-tar build or from a release tarball.
>>> ++
>>> ++Also allows to set the EXTRAVERSION from the command line.
>>> ++
>>> ++Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ++---
>>> ++ Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> ++ Makefile.flags | 3 +++
>>> ++ 2 files changed, 4 insertions(+), 1 deletion(-)
>>> ++
>>> ++diff --git a/Makefile b/Makefile
>>> ++index 09d03a34..1004945c 100644
>>> ++--- a/Makefile
>>> +++++ b/Makefile
>>> ++@@ -5,7 +5,7 @@
>>> ++ VERSION =3D 2023
>>> ++ PATCHLEVEL =3D 05
>>> ++ SUBLEVEL =3D 0
>>> ++-EXTRAVERSION =3D
>>> +++EXTRAVERSION ?=3D
>>> ++ NAME =3D
>>> ++
>>> ++ IPCLIB_VERSION =3D 0.1
>>> ++diff --git a/Makefile.flags b/Makefile.flags
>>> ++index 2a021c89..8eada8fc 100644
>>> ++--- a/Makefile.flags
>>> +++++ b/Makefile.flags
>>> ++@@ -7,6 +7,9 @@
>>> ++ #
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> ++ SWU_DIR =3D $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))=
)
>>> ++ SWU_VER =3D $(shell git -C $(SWU_DIR) describe --tags --always --dir=
ty)
>>> +++ifeq (,$(SWU_VER))
>>> +++=C2=A0=C2=A0=C2=A0 SWU_VER =3D $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$=
(EXTRAVERSION)
>>> +++endif
>>> ++ export SWU_VER
>>> ++ SKIP_STRIP ?=3D n
>>> ++
>>> ++--
>>> ++2.39.2
>>> ++
>>> +diff --git a/debian/patches/series b/debian/patches/series
>>> +index 5638bbf5..12324569 100644
>>> +--- a/debian/patches/series
>>> ++++ b/debian/patches/series
>>> +@@ -1,3 +1,4 @@
>>> + Link-config-to-swupdate-www-path.diff
>>> + Replace-Font-Awesome-5-with-Fork-Awesome.diff
>>> + use-gcc-compiler.diff
>>> ++Makefile.flags-Set-version-if-git-returns-no-informa.diff
>>> +diff --git a/debian/rules b/debian/rules
>>> +index 8cac6359..566a21bd 100755
>>> +--- a/debian/rules
>>> ++++ b/debian/rules
>>> +@@ -17,6 +17,8 @@ export DH_WITH=3D--with lua
>>> + export HAVE_LUA=3Dy
>>> + endif
>>> +
>>> ++DEB_CHANGELOG_VERSION :=3D $(shell dpkg-parsechangelog | sed -n -e
>>> 's/^Version: //p' | cut -d + -f 2)
>>> ++export EXTRAVERSION=3D($(DEB_CHANGELOG_VERSION))
>>> + BU_SWU=3D
>>> + ifeq (linux,$(DEB_HOST_ARCH_OS))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 BU_SWU +=3D -VBuilt-Using=3D"$(shell dpkg-que=
ry -f
>>> '$${source:Package} (=3D $${source:Version}), ' -W libmtd-dev libubi-de=
v)"
>>> +--
>>> +2.39.2
>>> +
>>> diff --git
>>> a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable=
-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0004-d-rules-Add=
-option-to-enable-suricatta_wfx.patch
>>> new file mode 100644
>>> index 0000000..9c5ebd3
>>> --- /dev/null
>>> +++
>>> b/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable=
-suricatta_wfx.patch
>>> @@ -0,0 +1,30 @@
>>> +From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00 2001
>>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +Date: Fri, 16 Jun 2023 20:32:38 +0200
>>> +Subject: [PATCH 4/4] d/rules: Add option to enable suricatta_wfx
>>> +
>>> +Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
>>> +suricattawfx lua module.
>>> +
>>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +---
>>> + debian/rules | 3 +++
>>> + 1 file changed, 3 insertions(+)
>>> +
>>> +diff --git a/debian/rules b/debian/rules
>>> +index 566a21bd..fc122d0d 100755
>>> +--- a/debian/rules
>>> ++++ b/debian/rules
>>> +@@ -61,6 +61,9 @@ endif
>>> + ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_SURICATTA_LUA=3Dy >> configs/debi=
an_defconfig
>>> + endif
>>> ++ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
>>> ++=C2=A0=C2=A0=C2=A0 echo CONFIG_SURICATTA_WFX=3Dy >> configs/debian_de=
fconfig
>>> ++endif
>>> + ifneq (,$(LUA_VERSION))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_LUAPKG=3D\"lua$(LUA_VERSION)\" >>
>>> configs/debian_defconfig
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 echo CONFIG_LUASCRIPTHANDLER=3Dy=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>
>>> configs/debian_defconfig
>>> +--
>>> +2.39.2
>>> +
>>> diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> index da1434e..2384f41 100644
>>> --- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
>>> @@ -15,6 +15,8 @@ require swupdate.inc
>>> =C2=A0 DEB_BUILD_PROFILES +=3D "nodoc"
>>> =C2=A0 DEB_BUILD_OPTIONS +=3D "nodoc"
>>> =C2=A0 +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files/2021.11:"
>>> +
>>> =C2=A0 SRC_URI =3D
>>> "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps;branch=3Dd=
ebian/master"
>>> =C2=A0 SRCREV =3D"344548c816b555c58ec199f31e45703897d23fb5"
>>> =C2=A0 diff --git a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.b=
b
>>> b/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>>> deleted file mode 100644
>>> index da44ae5..0000000
>>> --- a/recipes-core/swupdate/swupdate_2022.12+dfsg-4-gbp.bb
>>> +++ /dev/null
>>> @@ -1,39 +0,0 @@
>>> -#
>>> -# CIP Core, generic profile
>>> -#
>>> -# Copyright (c) Siemens AG, 2023
>>> -#
>>> -# Authors:
>>> -#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> -#
>>> -# SPDX-License-Identifier: MIT
>>> -
>>> -inherit dpkg-gbp
>>> -
>>> -require swupdate.inc
>>> -
>>> -DEPENDS +=3D "libebgenv-dev"
>>> -
>>> -DEB_BUILD_PROFILES +=3D "nodoc"
>>> -DEB_BUILD_OPTIONS +=3D "nodoc"
>>> -
>>> -SRC_URI =3D
>>> "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps;branch=3Dd=
ebian/master"
>>> -SRCREV =3D"aa9edf070567fa5b3e942c270633a8feef49dad8"
>>> -SRC_URI +=3D "file://0001-d-rules-Add-option-for-suricatta_lua.patch"
>>> -
>>> -# deactivate signing and hardware compability for simple a/b rootfs
>>> update
>>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>>> -
>>> -# use suricatta-lua instead of suricatta-hawkbit
>>> -# DEB_BUILD_PROFILES =3D "pkg.swupdate.suricattalua"
>>> -
>>> -# Disable cross for arm and arm64 on bullseye
>>> -# with cross compile we have a unsat-dependency to dh-nodejs on
>>> arm/arm64
>>> -ISAR_CROSS_COMPILE:bullseye =3D "0"
>>> -
>>> -# add cross build and deactivate testing for arm based builds
>>> -DEB_BUILD_PROFILES +=3D "cross nocheck"
>>> -
>>> -# use backport build profile for bullseye
>>> -DEB_BUILD_PROFILES:append:bullseye =3D " pkg.swupdate.bpo"
>>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb
>>> b/recipes-core/swupdate/swupdate_2023.05.bb
>>> new file mode 100644
>>> index 0000000..26c0e67
>>> --- /dev/null
>>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>>> @@ -0,0 +1,60 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2023
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +inherit dpkg
>>> +
>>> +require swupdate.inc
>>> +
>>> +DEPENDS +=3D "libebgenv-dev"
>>> +
>>> +DEB_BUILD_PROFILES +=3D "nodoc"
>>> +DEB_BUILD_OPTIONS +=3D "nodoc"
>>> +
>>> +FILESEXTRAPATHS:prepend :=3D "${FILE_DIRNAME}/files/${PV}:"
>>> +
>>> +SRC_URI +=3D
>>> "git://github.com/sbabic/swupdate.git;protocol=3Dhttps;branch=3Dmaster;=
name=3Dupstream;destsuffix=3D${P}"
>>> +SRC_URI +=3D
>>> "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttps;branch=3Dd=
ebian/master;name=3Ddebian;subpath=3Ddebian;destsuffix=3D${P}/debian"
>>> +
>>> +SRCREV_debian =3D "aa9edf070567fa5b3e942c270633a8feef49dad8"
>>> +SRCREV_upstream =3D "c8ca55684c375937dbcdefb0563071a35137f4ba"
>>> +
>>> +# patches
>>> +SRC_URI +=3D "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> file://0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch =
\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch =
\
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>>> +
>>> +# deactivate signing and hardware compability for simple a/b rootfs
>>> update
>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>>> +
>>> +# suricatta wfx requires suricatta lua and the dependency
>>> +# is not set automatically
>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattalua"
>>> +# add suricatta wfx
>>> +DEB_BUILD_PROFILES +=3D "pkg.swupdate.suricattawfx"
>>> +
>>> +# Disable cross for arm and arm64 on bullseye
>>> +# with cross compile we have a unsat-dependency to dh-nodejs on
>>> arm/arm64
>>> +ISAR_CROSS_COMPILE:bullseye =3D "0"
>>
>> So, this means we can drop all the backport lists again? But that worked
>> without native compilation with 2022.12.
>=20
> I tested it on my system and it still necessary for arm64/armhf to
> build. This is the same as for the=C2=A0 2022.12 recipe.
>=20

Oh, wow, it's even getting worse then. Can't we build swupdate withough
nodejs? Yet another build profile? This is a new depencency with
2022.12, isn't it?

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


