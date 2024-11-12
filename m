Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC275D41D5E
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 06:25:24 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.49])
 by mx.groups.io with SMTP id smtpd.web10.80626.1731392717279153633
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Nov 2024 22:25:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tPoJPTVJ;
 spf=pass (domain: siemens.com, ip: 40.107.20.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYVvEIe3+DOqV8LtHJugIphnIu/pcitoPZwst+zPYLjiuhq933DgAD4UsWMBk9IUOi8C/4wPSIcn3JWhrh+lnsBfvAMSQac8IWl5mHMBgcBhYWR9BKOtKWK9xGw8c1jaliy8yuwno5A+WUCg+t4NbjWiihNkd8zy0tX+oJeW3hqQ9KD5FWd6EBkGojDn++23lVWtTkUWVEXEHI91xhtXWcSb5ztIpICjHAc1UqjQ5A4IJfZrOyMiETfz6pX0GnJAp76rJap5rwe0VjBPfCJTNUglQRqZZzkSX6qo5v5E/WhlrzICyDaKcH1wwG1YtPcQeUcnjlHaP1cNmd0QOP2jzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JZMemPVJVjb3RSdDiA6GlxLseYi7Q0vqHghhFMcoSk=;
 b=yi77gRgQEZKWgzCKSb1trmogcq+KAEevPcp3tRczaZEr2/DTdfU3QiV4sl4xj8p7Ias7ceHg0aVSVFHIVJW1ZjIaUveUe45RxKOhx87VsGGbicPkSIcDHK28dEfZfvuO2kUWSIKjvczOhig5fgNFLTP8nJ5NgMfezUnRWE6A8Bf7Kfco/evfzYpyuatHKWYFWXUNSY8AIjgKtmwuNvxa+K5LWEHfUuXtH6mETLMgOEdHg4Gg8PWB0IHOSQiHJL9z7Q/X2YxWogU0ZBBzznVFEBAV1fA0ewWQjs4SDSIzI5kUmz7VG1fXZWb9IdrJs0lRtg9p21AVNjsFqZ0yfdtLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JZMemPVJVjb3RSdDiA6GlxLseYi7Q0vqHghhFMcoSk=;
 b=tPoJPTVJvMusBXv/CRPPgEr+sIu7uMhRSmiz/42h1NafEogHUsHf4lIbWbP+AgD/OIkT2K/66fANO23DW0objVwtpr2exJWCndxfpoNHL4BZIkcER2e9nakB92hgB5kqF0EtYdODXlATIpq2+qmmBNkOUP8LZVyX3b/SQEcbrxk/lcpV4pAkOFQsJImYLbhdrD3jmkLicJrf2hiRVpVIVgXAPJHAXUJ25nVJbfLS3FEbg6J8pgjFqXqGB24zBVKfCg+WhQNUkyQUJ9fnjCmRBS6OWhq3QPHbuIHLoHwwZlakaxqtFhObe0PDb2qJpNZV+X8V69JZgWD1KYje0hW0Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3219.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 06:25:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 06:25:14 +0000
Message-ID: <ada9b77b-4a89-40ed-bf24-676d15b75c46@siemens.com>
Date: Tue, 12 Nov 2024 07:25:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [cip-security] Manually run Kernel and IEC tests on
 M-COM x86 and generate results
To: cip-security@lists.cip-project.org
CC: kazuhiro3.hayashi@toshiba.co.jp, dinesh.kumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
References: <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <59bd0258-8092-4988-80db-e8f5a14a5104@siemens.com>
 <OS3PR01MB61035F246D6307C5F03F2421C2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OS3PR01MB61035F246D6307C5F03F2421C2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0385.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3219:EE_
X-MS-Office365-Filtering-Correlation-Id: c10977a0-7cb4-45ef-e237-08dd02e2c48f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|4022899009|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LbZ+NH7VN4LiLPkVfJ+Wfg3CcIAP8DDnSLzP3RalaiY3PKDwM0h6i4O0wLhd?=
 =?us-ascii?Q?BXvLs8VeUHqx9MbulUsGMY99eDR4cFpEh9QgU1JSILO9cMGdTfRrHaNgSyKF?=
 =?us-ascii?Q?CqgXIW4gd03+clKiUpU7PyeZLneVWfKpo5rcQWVO/fC21PhMkug6oFTPtdvA?=
 =?us-ascii?Q?N3XI/09ggPKctlHBsJybSo91Md3gXhYPxYf27jEYxoSWvu9FqtfpsRA/18um?=
 =?us-ascii?Q?YX4C15lhRhlcDTYWNblwv7GvWSfi3ycu70rz3SsjSKbtLsyPcLDdtt+/J/Ik?=
 =?us-ascii?Q?+QAViBTR9qUqfyxziljbTpUXy03Wm8hHLb6HHVgEeHsz15P0V/Ak/D7QGh/M?=
 =?us-ascii?Q?mEMbi/ySFtOmUtGabqH3cAknL6uORW2piYjGriU/K+9QAiIl7auon0YCpEYx?=
 =?us-ascii?Q?u9rM3xImW9m+SFNvcbPYRgtYPFKC206Nad3Rdue9kd11Wq3iHPbJ1fRdm+h6?=
 =?us-ascii?Q?2KzAkxemTw1Upr70UHV3Ke7s5PpDUJmc2UWqMgk/4ZTLMfDYwkwCGfOWNU+f?=
 =?us-ascii?Q?RGhzzfydeT5QoJkmX/0O5tesAfca5uAsYsNU39QMPgKIvrarOFWMeWTt9nWj?=
 =?us-ascii?Q?rMT8xdIIRPrlxI7Spun1L1RvFD9NplYc1c/A7Nva6UxVA3CpaGf9N2VjdM32?=
 =?us-ascii?Q?hZvPiX2Ro7STKWhnzKST3+VcHFOpMCOD7due3K635/kbuZNMNODitBpvppHP?=
 =?us-ascii?Q?lQih/d6ogXQT1IbSAjFVKIAj7/JCxxHFFa6clQtrNHhwKtgMIgBuEtMgQFDD?=
 =?us-ascii?Q?0Q2yQZYIHQBCy5EaUIoqgreVAGJy1AgkOptBWvq26wXNaPY1Yq/WTaYAaGQK?=
 =?us-ascii?Q?eUz01DA3n1wPEvXkma7Ua5gNGdG/XMk1lIFbmwDXIhq6t2mPAGatrmEBeuwv?=
 =?us-ascii?Q?DodlPjrakSTtZHSlh1/n5AemhI0/Q/pgfAK8Fta41cOTSL1/LC/afAscF65M?=
 =?us-ascii?Q?/p4koYqZHQ8u/1jrPXJvNTHbulb+LRDdKrcllkPfkYnFMWpP336zZAYBhb1Q?=
 =?us-ascii?Q?7AAH62le7PKHvlHFr93FMigFlh/i4S2HSgDREfN1FXp9BtQIS+OoUZMqUwgk?=
 =?us-ascii?Q?p1QkDJIn2zSjNsmv9QjuSGVNrlZRQyf/M0wgq1MNftMX61NG8uEBoPsqlOio?=
 =?us-ascii?Q?+NRx7eDPyd212FoeXZL5RPscgEdMG3NsH+K+THnHDPC1S0lp1TeSwQEbkDQV?=
 =?us-ascii?Q?4g8CE9aFQENxdgwbpUGLlQdtnLA/kmRpBza9Ufmz/VNLMhFfzN9KLI+BTVNY?=
 =?us-ascii?Q?4pFXmoNwDh9mlDqSlWZN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(4022899009)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0tGfMeDIQg/PGYoHbVaZYd1tSPRr1HoURE1mrtrywKwq18zXnIrJQWM/fZ3p?=
 =?us-ascii?Q?u6x1W+DdVYXgSl0eCt5wfD5v9IbXb1JN9BS4Vw1wmEyuFQ8GbA3P0cQXTLJa?=
 =?us-ascii?Q?2ClmY5f8C7kxqxFzkzxq3zFFnlRyOXdhHd4jTJjs7rQyCE3EOCT+80GDrAlt?=
 =?us-ascii?Q?nooZFuB0Tf/fWjPatLTUI7MOa8IiiruUTxF2av7oMKGEjJgtmNYJ8qtqytRE?=
 =?us-ascii?Q?/rkBhhlUHBdsvFRRPzPsFGclz7vlNDQtlusdZrm9OL6LDL5cxn6L1/KT9uPm?=
 =?us-ascii?Q?0gfTOR8OrEn9EkOHPvlPCouC2nNfXKMS9Sl0AN6HoVBP/2IqH/vPa250YPdJ?=
 =?us-ascii?Q?GywGfZjMYO9wAAaY0MoW5ZsrAneZYO1GnCj94KeddnflJOwhDHCn7cYD5/ca?=
 =?us-ascii?Q?hS5Zd5VIeo7bdD/iXD/7DpV3XMLVrqyBV8WAIuQWf39k/rpQRYNgap+8uts3?=
 =?us-ascii?Q?aCG5MGNe0ULnq8hA60obdtKTu493LGnmtYR9jvMzMa+M8KOsnvxQpO3w69zJ?=
 =?us-ascii?Q?p9GSEOelOZ950l2I1sVPVEzKgpaEd/bN/vHpCs0SfotM0UUJ3bs4ia588V6B?=
 =?us-ascii?Q?lw1KdoCR2XXjsXwtUX9pa/CHp14OkBRPyl4nxq1q+NrwYjqHhiQmf1ODo0tw?=
 =?us-ascii?Q?mfNYZZ+joxvhFxQqc+CvR/PsJKY+8MFbUdcWd1pHVLp8h3B3yIlEWhgdGAz6?=
 =?us-ascii?Q?mwWfXgsUvbqPisH9TQVtGtM8RorJaQRnsDqX33VO6OqnH7aaXFKbSH+k7Bvz?=
 =?us-ascii?Q?IKfzc/W3BSU4JfygVdONVQilODSpaYG8FS297jztCsxTPvZZ6PJqW4jPNh/k?=
 =?us-ascii?Q?brcJXo3Wo4zUWuczle3ZUYpXlB1fRaEUgkTKFe3BVJD07r/nMmcpsKU6Tdid?=
 =?us-ascii?Q?gg2T3yxFqpHOwoFzYGFYm92zSQCbuohXPv23wXKvBB6v+LjLw+mbz/H52GFL?=
 =?us-ascii?Q?hoI5BRTzWb7kIVJ4CQ+9Wt9J9MQ2x19cJwMqzDzWncPbYo4oh1mrln0joQHP?=
 =?us-ascii?Q?Lj4V19bBgDU8yFgpVnNYuLySFRU0cAwPRh6O8bVTnvjg8BAY0CDLi8+lYmJh?=
 =?us-ascii?Q?BqEeadPu+Wlk/IzVCqFPv49LRADhqElwdETK9fl6XbHKLn3oGSSGQb7sY0RI?=
 =?us-ascii?Q?IC7NnppnB2OMIPFU0oIhVRWrVLd0wyGCihXtpDeLVMg2/NfAR0h6oZHyJ89h?=
 =?us-ascii?Q?8m5Ntm5CYetJuaxD0CPGSeG/ZaWRlfmDbA/k5US0h79J+NYBkN5ZMlbordlL?=
 =?us-ascii?Q?cTJju2RB/n6RQCbXfzta5Vq06eVSDRS+Sh+VrzdX6mxS23RJ8CYH7FHWigu4?=
 =?us-ascii?Q?6Tqy1GAsuYd474Nu2F14hPgp6tg4F+NxGY31sCgBorD133HY+VK1a+8W5imT?=
 =?us-ascii?Q?lglrqrs+nvrAd6WO5KSIiAxGrDoXiOexzKUGoWCX+iZViqTAje9K7pOWrvI9?=
 =?us-ascii?Q?XrVti4Dq+N2jB7U9XaTYKTpfZiJOAFuKZG/HDd3uFZbr4gDBwb6lOjAzmvIg?=
 =?us-ascii?Q?ZIirbaKukue9WPA+ssKKu3mxHu5kGppfI9LXHQudGZIXHwyKee4C0VRzA3mk?=
 =?us-ascii?Q?Ti/rh56ol8d5e9qsNo1befa9krZJqkRn4cOirgNW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10977a0-7cb4-45ef-e237-08dd02e2c48f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 06:25:14.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx+bjR9+jsR8tJdRJiQuQlp2YWr47MYpbtHd1bJPbMwvc2qSb0hZsomhmbcuHmBo/WDSRMDhqKYGMEdzjwQSjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3219
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Nov 2024 06:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17240

On 12.11.24 07:18, sai ashrith sathujoda via lists.cip-project.org wrote:
> Hello Jan,
>=20
> Sorry I did not notice. Thank you so much.=C2=A0

Not your mistake - we didn't share this news broadly yet.

Jan

>=20
> Regards,
> Sai Ashrith
>=20
> ------------------------------------------------------------------------
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on
> behalf of Jan Kiszka via lists.cip-project.org
> <jan.kiszka=3Dsiemens.com@lists.cip-project.org>
> *Sent:* Tuesday, November 12, 2024 11:42 AM
> *To:* cip-security@lists.cip-project.org <cip-security@lists.cip-
> project.org>; Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
> *Cc:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;
> hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5=
 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=
=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
> <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG
> Porting) <dinesh.kumar@toshiba-tsip.com>
> *Subject:* Re: [cip-dev] [cip-security] Manually run Kernel and IEC
> tests on M-COM x86 and generate results
> =C2=A0
> On 12.11.24 05:14, sai ashrith sathujoda via lists.cip-project.org wrote:
>> Hello Chris,
>>
>> Hope you are doing=C2=A0well.
>>
>> Regarding IEC 62443-4-2 certification, the certification body has
>> asked for Kernel and IEC test results on M-COM device. Based on my
>> current knowldege, I believe that the test suites mentioned here
>> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/
>> submit_tests.sh?ref_type=3Dheads#L55 <https://gitlab.com/cip-project/
>> cip-testing/linux-cip-ci/-/blob/master/submit_tests.sh?
>> ref_type=3Dheads#L55>=C2=A0shall run for every updated kernel image on
>> different CIP reference hardware in LAVA.
>>
>> Since availability of M-COM device on CIP LAVA Lab still needs some
>> time, we are manually running each test suite i.e SMC, Smoke, LTP etc.
>> from https://github.com/kernelci/test-definitions <https://github.com/
>> kernelci/test-definitions>
>=20
> https://lava.ciplatform.org/scheduler/device/mcom <https://
> lava.ciplatform.org/scheduler/device/mcom>
>=20
> Jan
>=20
>>
>> There are no issues with running SMC, Smoke tests but while running
>> LTP tests it is trying to install some dependency packages to the root
>> file system. Currently it shows it is a network issue but even if it
>> gets resolved, the packages cannot be installed because the security
>> image has read-only root file system.
>>
>> Another idea which needs to be discussed is, since Kernel tests by
>> name means focusing on testing only the Kernel, we can try to use a
>> different root file system to run these tests. But this is just an
>> idea, this needs to internally be discussed within SWG and with
>> Certification body.
>>
>> I request you to provide any suggestions regarding the attached LTP
>> issues.
>>
>> Thanks and regards,
>> Sai Ashrith (T S I P)
>=20
> _._,_._,_
> ------------------------------------------------------------------------
> Links:
>=20
> You receive all messages sent to this group.
>=20
> View/Reply Online (#2297) <https://lists.cip-project.org/g/cip-security/
> message/2297> | Reply to Group <mailto:cip-security@lists.cip-
> project.org?subject=3DRe:%20Re%3A%20%5Bcip-dev%5D%20%5Bcip-
> security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-
> COM%20x86%20and%20generate%20results> | Reply to Sender
> <mailto:sai.sathujoda@toshiba-tsip.com?subject=3DPrivate:%20Re:
> %20Re%3A%20%5Bcip-dev%5D%20%5Bcip-
> security%5D%20Manually%20run%20Kernel%20and%20IEC%20tests%20on%20M-
> COM%20x86%20and%20generate%20results> | Mute This Topic <https://
> lists.cip-project.org/mt/109530876/1050698> | New Topic <https://
> lists.cip-project.org/g/cip-security/post>
> Your Subscription <https://lists.cip-project.org/g/cip-security/
> editsub/1050698> | Contact Group Owner <mailto:cip-
> security+owner@lists.cip-project.org> | Unsubscribe <https://lists.cip-
> project.org/g/cip-security/leave/11905283/1050698/1444493412/xyzzy>
> [jan.kiszka@siemens.com]
>=20
> _._,_._,_


--=20
Siemens AG, Technology
Linux Expert Center

