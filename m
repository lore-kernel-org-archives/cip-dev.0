Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7931CA0EC3
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 10:25:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.72])
 by mx.groups.io with SMTP id smtpd.web11.21839.1694514319284448055
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 03:25:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RsYoslfw;
 spf=pass (domain: siemens.com, ip: 40.107.22.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksMWjwokSdF3umGJuFRhViF3KCoxs/aJUca399YQfWg6u3VVIDTXVwhLm0z4V6gdfceYiAh7q6vjemCB6IjqhdH8Imbdeh8rQNv7pzxEpRvtg012bUo0OwWS4OMCc9zwO8kmGd97tDRekdrwEz4vdp37lU6nBF81hYQPs6yk8Y1k0IMcAFMe0ubTt6ZyN/N+HaK/RCsApJkneUtGlaBf7KgQS3KAxD0kkrbjVx6H/PPSd/rlFSg9V+lZYWvcODiPX/x6Ox0TvPt+P70383NjkBgK7UalkBV4IboxDGcf5LzCmtj70clCIDlT4RDkdFuRmVxgXGNHJPI7jIP+LZhmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIzf+SctPhHL2bcZTw25DaPA2h7DmwC+ODc5XcNsuCA=;
 b=mpSAsIdwFV//eGooeesmdGTttDz+SKgaWMt7Ew67wPGgT3HKDpxnj0sJ3QfYuRRdY/CnM4/kzk9RWMeiwOxzXDWs8jdU9zKLvnSkJvcIv2K9Q78aZXwNo3vNFFTw0n7JXeeOkPX6zQd9uvs8b+xtv1KtyurCuLs1UZRl0HUaniQKSM/KGgPlemujmyDyLarZgk6POIn5BkFd8AA6fwUmWcFLC/nAX8sCN3RTl+/uPUS+QC1afiaVYBwZKXkEMW3xUuDq8zXRrgsZAFsX0NiqMejXEgtPnXR4FXsjNlax90P1issNjm+nxrBmW/iWb5AGLYVKHmFKH/500R1KkiKbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIzf+SctPhHL2bcZTw25DaPA2h7DmwC+ODc5XcNsuCA=;
 b=RsYoslfw+Gl5KTIZcmJoay38skmjf72MX4afqqjYo8ZSPz6Mweloftu8c0WK53lK1l2Ij+saDOidhUefb4uozPOvQ+UiVI2oZgCTC0+7gz9Tgip0JxiStWAk8nhZXGrVpdP4a397qDC6rT6XUDTCNtbftk0si/v/8BDqNgqbiSGst2QryefQ4oKfP9hhM2HW78uMxWIkMa38F0EC8yQGdvVHJLJL0lzFm/nLIDla4VqVt8LgXWwFwdKjPfhmkZ0cQR7286iFL15sCUJk6Jry2/e7rrLADXp/wjTlMe5rvs2606CKc+mj65+/d3i9x6Y8ylY4z85t0JjENUJs4lK52Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 10:25:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:25:16 +0000
Message-ID: <c90ebb07-260e-496b-9280-c340ae41c26b@siemens.com>
Date: Tue, 12 Sep 2023 15:55:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure
 sync on rebuild
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
 <5a4f1ebe-305d-409d-b142-49626877455a@siemens.com>
 <94deff88-b5ff-16e1-89cb-d5337b788b50@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <94deff88-b5ff-16e1-89cb-d5337b788b50@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 08eb0cf1-4bfa-4ec3-1da9-08dbb37a8df1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AePTvIj/QDQezVeWTY8Nrj0gDFajK8vGZZO1U4nVyWksHShq0gV+oQE8VFpJj1YyFfafmML6rL/Kpca0mFB0MXRmrzKCnWyBhXY18ISm5rsyg/0AhEaIBXm19iI0mMInWCob9YV1QOFBd3E3Hnytaekjm11GO43LQvDsoPzjUdI9jfr8I6bZbwsdxEm7+kcqlGADyMwlZN7pc8+QIAL6FPumraH1ZiTeYjnEJLcSrvEeDf6hxkQh9GeLQ62qHnC6jjXYtkIkXUX8L2Jgg7pYPlE58fFImGz1t8CzNr7MchHur7Qkp/eu+E1SU+GZH8Dvdz5gtnoj3LwsI5UsmAeFp5utK/YmkLpDx7AhQ6gFtNq/xzs2n042KF+aztQpXMEv1tFg5RbxRZboKf2udxyX0r1RtUAOzflWMU9Qo3AP86TKvHRZta+l9GdIcsT1VDWC3fSCkLlX6nZVv2aYCL6/vt6beZ1tk42xJX4l4bcJ3hAbk68lpsaVaiaaB977aW9BfODhnVfPu77KVKHAslb5ObxQbC21GDnvZ89HenyupcNbChiSv9yBBosVwwQem8OjHRO5tbc2biRUfCVKMccqlHFzTCp48iaPDcgIV1o5NxlYkhKoo/DMaTt6OEfKef8F7EXUHcVlxBgyPoJxucAH7g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(2906002)(31696002)(86362001)(2616005)(26005)(53546011)(36756003)(6666004)(6486002)(6506007)(6512007)(83380400001)(38100700002)(82960400001)(478600001)(41300700001)(44832011)(8676002)(8936002)(66476007)(66946007)(6636002)(66556008)(5660300002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tjZFuKVLRpqzLm4H/uc96SwziccMD3NntGA23PB0N1pHBLADFJ+nxxB/YbaD?=
 =?us-ascii?Q?5fW/mvYEopMRbgDQHwLONIxIBLvz5GBeQCnpLS3i2ZTKxjLN6CUCd9k35OYi?=
 =?us-ascii?Q?UXmUcBHBYIKANb4jiWU5y3nesJuKNcIR2sSukcOmdD+TjYF9Zk7sgEF9LF55?=
 =?us-ascii?Q?TpbyyUzA1mIMbtbOsDyt90bSRcDrjI8gst2o0k1FfGiIZyeq5lpOMXIbDa1f?=
 =?us-ascii?Q?rgNpB8VYMp+vCYlm+tdiWgnFpL8fW1bEKc4jCwF3OsnmZKPjSIqQDvJygcm6?=
 =?us-ascii?Q?t2wZ094FyglfNLCnPGPIGsHWc8++QQ7zo8b9Q1J2x+gHP7Zama5K9T0TGTaa?=
 =?us-ascii?Q?Vhp5FjZN3aw9uec88f5yivsoFhRiMCUvChU2L92b4hacowEG/oS6n359rcjb?=
 =?us-ascii?Q?CsD7qKf7xQ8x+M7YFwKZb3kk1YkNsX5fz2q5vDUGmZNZxNfvyC3cfRPQWna4?=
 =?us-ascii?Q?uxj3XtWEIacW9qMGiMQ+r4u9yorxl7iI/5RmDFXhPzhjPxWzFXeJLRARlB2V?=
 =?us-ascii?Q?11ufFbJXuIOJAdNv7vaR4q51XeSCHG5vLR0Q/m/RqxMyWyqVCdNaj70uK0am?=
 =?us-ascii?Q?hAqpl3pOud2Kmj0clDmcMBQ6nstm9SqieJ5bB2uE6cFVf51aycQ4mBj3IdBX?=
 =?us-ascii?Q?IqqvxJ5QJp4KCTzRlr1kMk4y8NWxntr9XgniE/vkhnCDJO070zhdY2MbDBWf?=
 =?us-ascii?Q?R3X1HYOx2QeJ/U+qrcN6iZLIJS3yfJ2smW+nQviN1RQvcg4uom94nEPo4mrr?=
 =?us-ascii?Q?8h18VykBNlWcJdGfjfswS2MYBn+/B4RD0/WULKCeaul+xeuYsqJ7XaW1qMxz?=
 =?us-ascii?Q?5xqJIdzaoItdo/3KAv+8vsZ3z96a2LFn/z4w6vQ32AKzChuKJUSB4p48v3Oz?=
 =?us-ascii?Q?VulYbrmB7F9Vu0VTvQ+eGb+g6ouqVdS8bIhxOkrJ+TWqQqoR9tYv13hpqdZs?=
 =?us-ascii?Q?5NHzq9NrXmUNOIWhhDrEJkmaxuRnIwOiG0Bc1Rs149mo7iRkQd7gCz7aljVg?=
 =?us-ascii?Q?M3BxDu2GxFEGViNBAyCo4QaTwULPONKMVjKI0s6IRRF1DJ1Z3OqugRda8iWT?=
 =?us-ascii?Q?742CM3oJnyip5sWk8SKYa+4AMwtEbAXt3n8pqmn3N+b2ZpN4Or9dVv1njiOU?=
 =?us-ascii?Q?0Y8EhgWx1zqQJhKurCqYVZhdRuAJxFE0tf7GkDBJIa8fti5ghJgLBPBcqoKr?=
 =?us-ascii?Q?oUA5hCpKTouRmiFbbK58eWFWxJy2YatIii7AvdZGU4YRYnUpSYqwciPbBV5Y?=
 =?us-ascii?Q?aM9Do55XYbw6vv590lFWda906yHDrcxAUcVDh3IxOGAqu5szR0DnHXq1BxEC?=
 =?us-ascii?Q?ZL6RFOf43UV0KdnjYiQSubN91sl42lcTW1igQiOvve3L3flZAkS7zXkG9OlN?=
 =?us-ascii?Q?c1tA7HA2hpoZ0paqx8ZYAoMWxm+4k0uitFuOOvpC54S7c/IgtSRYe2A1M4zq?=
 =?us-ascii?Q?6jRrf4ztMaDDvJ1WTBI1UaOe2wuFQbr+2xbRhH1ZG1oWyOsxmEtW6jEl0U2J?=
 =?us-ascii?Q?wM/x8DHo7Evo2m6c1WioTfMUd7jTo5PD7UDK3REtYexUqZpwU/8W3EAKtU3A?=
 =?us-ascii?Q?IZGr0JcTB0XSVdBaq/5OsRfNqAeqmApVi4mFLFlW32VggwyUxyp5yohh8Bzq?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08eb0cf1-4bfa-4ec3-1da9-08dbb37a8df1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 10:25:15.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xejLCICIqXILkHil7iaUDmd4UtZV80GqpIFk2yUNH/LV97ynIsIVZcsEbSfczHTeDqS6O4FhQs42vecPorCPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6992
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 10:25:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13059

On 12.09.23 15:37, Gylstorff Quirin wrote:
>=20
>=20
> On 8/28/23 08:47, Jan Kiszka wrote:
>> On 23.08.23 15:28, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Disable the timestamp of the do_install() task to
>>> re-execute when ever a dependency on do_install
>>> is executed.
>>>
>>> Without this change the sstate needs to be clean for
>>> every rebuild.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../initramfs-verity-hook/initramfs-verity-hook_0.1.bb=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
>>> =C2=A0 1 file changed, 3 insertions(+)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb =
b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>>> index 3fc63ed..7435649 100644
>>> ---
>>> a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>>> +++
>>> b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>>> @@ -40,6 +40,9 @@ do_install[cleandirs] +=3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/scripts/l=
ocal-top \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${D}/usr/share/initramfs-tools/conf-hook=
s.d"
>>> =C2=A0 +# Ensure VERITY_ENV_FILE is updated also when rebuilding
>>> initramfs-verity-hook
>>> +do_install[nostamp] =3D "1"
>>> +
>>> =C2=A0 do_install() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Insert the veritysetup commandline int=
o the script
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -f "${VERITY_ENV_FILE}" ]; then
>>
>> No other dpkg-raw packages require this, do they? What makes initramfs
>> packages special here? And what about those in isar upstream?
>>
>=20
> This is necessary for the initramfs package which contain the
> checksum/uuid from the root file system build.
> This ensure that the checksum/uuid is refreshed.
>=20
> It fixes the problem that an rebuild of a verity image leads to a broken
> boot after the build.

And what will happen when the user decides to pin the UUID to fix value
in order to have reproducibility? Won't that cause a needless re-run?
Shouldn't this recipe rather make sure to depend on the UUID value?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


