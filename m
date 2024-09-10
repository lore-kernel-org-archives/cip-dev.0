Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EFCEDE99C
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 15:14:25 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.60])
 by mx.groups.io with SMTP id smtpd.web10.26236.1725981259244383701
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Sep 2024 08:14:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Va3ik0s6;
 spf=pass (domain: siemens.com, ip: 40.107.22.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mw+MYSQy4caFC8a/cOl0IVgJ8nUOt0+7uJEv2xFA3lkl3ydIxK96qwTO/Gw9wQprmcqNpmrrh6fFWSFm3RtRTBHstDjzOajcuysdQ4ee3lb1L5+34oU454LNYJClETsR7JQ8+xjCZYeSw+MSylH2iq//ASzz0AgU/nSrAOn6KRRVV5R5k1FZIMzAWxBVqFJDtGI62NMqJugaEju15cOz2tNVIhZrVCgdJzg4PXcV9j1Wn7Bh6CKid3A90fqmCAtD0RKogqP2CuPpX8jOyhxlR2anJK7Jy09S8iRLC282U8TezVg98J7biLer1yNJcMDxseOR2Fz/fHvVDUWUnjMA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdpBV0NWPS6smOP3liN/61TSLvYRVEHvQQf3zD20qMw=;
 b=yE32X1C9ZS03wxWwJAMJ5TD8XfzkZJ4MbqlTBYt45uk7phhKrYTELnAW95rdb2SK6hpN7UBq973/XZj1+wejRC0afSh4kt5/pBx9y1lnvNC4dlZJxC0MDDk7+CaALnA1kiIPFiJ0lq1QDwrB89AA9pX3q33FxadBM4YyBSHXCtnM9WfPdBvoqxT2mdf4RUCvQXLe/XfozD5P/2KrgLxS0P43aI9QvxVtwri5qGaMOIy2H18zrU8I6S2/RMAQAt2SmuEPTDiGlEuzSyvcEBEYDHmnPsra/gbdXFuUZ0TCzrFrqzafsTg8FPiREJg95/s5g0ugSULb8xXpikulmkveDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdpBV0NWPS6smOP3liN/61TSLvYRVEHvQQf3zD20qMw=;
 b=Va3ik0s6epNZTeW5F0ujQx9LttV0jhkTx0Sr3cYhKsU3iN8aKIXEtvzkN6Rzc1yCQafCLX2Dk4+/EXYH9oOLmO9pPO2722kCDUczIWTFoiFjWGGjIzYOLKNfEB5Zm2/oWUT8eJeF4rma+JLimBCt52p3PWWVEHHkHfZl1GVhHIujcqTqM/DKD0yfwkddScmRQtbSuCVL19DwJ/BuKYNPjXYnI48TtB4theEzDTb2zUsTjHUILzpCQ9+FaS4fZvvcOA5ZuYPRg0vEJjZCFf5S5RwYXua+sleGrpqTnuvCAed+a+9HtvOx4tnXD5TVXubw0F0LrXO7oIL7p/In4Ve34A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB8035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 15:14:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 15:14:14 +0000
Message-ID: <311d3eda-88d6-4e0a-94fd-d4d5cdb7e7a1@siemens.com>
Date: Tue, 10 Sep 2024 17:14:10 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Reminder: Upcoming CIP Mini Summit
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:610:4d::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b635ec-560f-49cc-a0da-08dcd1ab3aee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CO6aA6lJlN5LkGn8kB85QqrOLpc1xHNj88l9b4II+t8xLGzOG91U+DWJM9hS?=
 =?us-ascii?Q?fjMpOUmgf6as1ghZardV234+vssDGwXXwQxV9yiwka6eIxkjuRlrI9PdIk+w?=
 =?us-ascii?Q?7aG8CaXSP1pL02/0gcrGr296Fp9+acf5g6B4zZA85o/kZzBTCgESmmbh2H52?=
 =?us-ascii?Q?9jWt8c6/l86lLUIkdCwWLZkF1ymZjLa2HAx6k8XD/GEXFZtgJhRmTx0QnM9u?=
 =?us-ascii?Q?Nfs6drTiQ/rJ/6JfnXnKkAX/SEjGfY7pqK7C6DIuImcFeoXgz2zZtT+ZSsq8?=
 =?us-ascii?Q?r9HrnMaIBmxst+OyGlG98lSGmonr3ou5LkvzfvnZPqR7nzyPerSSkYiFY1Mz?=
 =?us-ascii?Q?8NjeqSP62hSUs13Q9AKn/iJi1pzZozhc+xvfYcz9mVM5Nszw6XSOXoQZmdjP?=
 =?us-ascii?Q?30xQ7MJoBvEXBXlazr90tu6kxWv1R2+z8yMCnjPbnynw6TBHg9JCqq8WOBHy?=
 =?us-ascii?Q?9lDCbjU6qAbUe+drjdKz1WjKNZ2y1t74TkMV8vzmfuHqyOUnu0nqoafqlbZx?=
 =?us-ascii?Q?2L3F5lzwah2YJpm5i0HCXwXx7/plnEpfXa7tEC5y4xh8coh8gJRbnqoBnX86?=
 =?us-ascii?Q?DIUyDLkmrABca6SPzKjirNQofzzHMnb+m2+QH56Lw2dOAa592wMkuUzzhPwZ?=
 =?us-ascii?Q?dh+lIczVXpuo7Ox2BTBGBlraqvRoJfkkMlI+57EQ8TKwCsN2haxPlFLLvW7z?=
 =?us-ascii?Q?KL3lkJDg7GtlCpRCW3hboimf9uxxgH7QCdCm5y8WiEISuzONYrrGt6swV8WI?=
 =?us-ascii?Q?wBXr91VjXQdC2MMRva6Njyu0A5+HMXZWBIsz/29FqfnO9L8OdtnaYLiDHXQC?=
 =?us-ascii?Q?xtk1onRUG2ZnGlB7FI/1wJo0KWqBGTGm9omQH7I0CkXnRbQ+3UrM2U2N+YJ2?=
 =?us-ascii?Q?FPcmjXsEwfYjscWKQY+bad8JxnYWAyrZbe6CRjyxIsdL/OOmxZUyPSZyMkBB?=
 =?us-ascii?Q?y1gIYkx15+I6L8DRFjzuJ1OTOCMA1++eaLy19yscZijFxMLOQnI+TaM6pBhE?=
 =?us-ascii?Q?NHAbdqiQAZs0+3FyXgUXx9d4JGqG2kTxuxOVPUCloPgjq/zbG1ltQHXx+ZO3?=
 =?us-ascii?Q?F7cExKZlufKCu4KOFVLHnuQ7O6q3Z4w1m2S4os2T69dkjco0Dvbrl/XSnIhA?=
 =?us-ascii?Q?YI1qBdYyQ4FsQSCPZ3BhDJJ7+ALY8hA9xV64jxB5BXgdElaS1647OUHzFiuS?=
 =?us-ascii?Q?FIsns7z2Bd09C8j0gckRHCjAbpeyLyY/xDABuG4tDbuH6H1+sFOvWA8WNnm6?=
 =?us-ascii?Q?ND4AWlx5PCb2SmwM0YdO6EZ1fm6Mg1CWyNP4zE3DyRkz+RdZUEqizT9ZeWuf?=
 =?us-ascii?Q?piY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nGI/3sxd1FgYrrTAkeRXmFlyLwcbxrJABw9NsQ7kzbk6I2R/mKGMYDdH06W7?=
 =?us-ascii?Q?ZdDISzQ2dcH9x2CEFX67cvW+cKOMXB+rcHSOadlAf74zKvvz4r8Yy0x6mo/g?=
 =?us-ascii?Q?7Y4YawXQdVQuvDfTODqeGREhGdkgaUuOO7XjqHMcaQFUefGRjPZqBM6CnKG8?=
 =?us-ascii?Q?YxagP+rcJPr05ZWRBIzw6uhbkMrVhc1asVYU/dWhIFTtg3RnJ4vdZPkC7RF6?=
 =?us-ascii?Q?91STYEl8AL+fSz2hSF5C+WzEIF1eygRoi3dPekYXSbCAkBQscVj4K06piAoJ?=
 =?us-ascii?Q?JIH+GWXSxhTk0V3Tabdjpuu8F/cNF0Ldl+utLE4nqr4aUdBHrrNn5MQRjmjQ?=
 =?us-ascii?Q?rtLwW++1BCV9oc+E22HmRkJgEyK8xpiqdjXW9azsIUFGTM/ooj5RzVU/aAHo?=
 =?us-ascii?Q?9ltc3BS9ikwWQWq1iDdcZaXUqQgk50CWW5STIXKcLde3D3mtfRG34eO9GYb6?=
 =?us-ascii?Q?vzp91/wx6Z/mgNIjiCoKGHxheOtmvibNS9lIZ7YOwvj5/g/iC7f7bEQIoByC?=
 =?us-ascii?Q?d5q+zI1z58ts2W7TusqVCebd07tGeWTPGUR4cvYuULFj1/XpSJUD8Rj2zb+A?=
 =?us-ascii?Q?zLD150h9ZrHS8ywxK9dj4qj83C53Jq6lrcQq9Rf+x1R9VHsInqH8iZyW7vdF?=
 =?us-ascii?Q?M94zpnRx3U1QMtH+iWNoowIOAgMKlOUxaURIdSqDukClCfcIIour7FDXQtig?=
 =?us-ascii?Q?Bz+xZPc8p+lIHDvFzrcw6SAMzofZgTydTznSAJTXMpZbyVTqhk21x5ue7dbD?=
 =?us-ascii?Q?/h0tWFttS8RhvqDVMiubkfoxns6ApVPT4DnfKOwlSc3L7dHHkI3oLKeUc4R0?=
 =?us-ascii?Q?TFxQgrV6NpYTbYOJ/cHs/LVLKkqxatLAKwgoADccdMKHScAro9aJhODBzFz/?=
 =?us-ascii?Q?TpUJC3bqsD/XTGA6vrEUc7yPpvfHusz1U8lp/Vc69i8ypST+dhwvPVEe0xXi?=
 =?us-ascii?Q?AAAI/oZJfq1HzWb0TSqbALD+n0z5YSNUW4tolMWgQIXIxqBDYgVPm+QovbdW?=
 =?us-ascii?Q?cK8PM+yHMUeKtwEeXpIAtFKXqmyi6IKABGkTMyWxG69UPgr/RQtr2olExOVS?=
 =?us-ascii?Q?f+YtbE261LzuUl75rTkLfDl2b6z9aKY+lJmckOqgidJKWuTRgLIz7eqO9xy4?=
 =?us-ascii?Q?Z2GgZXo53PlZ+GEIe3Par8BFkRGK9QFZ3mVu62M5r2zu9+hQ34JzR/aOzIK8?=
 =?us-ascii?Q?a9NWe2XczJCpWMeYKOuKlLo+tdKxYmWYIVb6DgbSnlG9hEpXQxqEskYW3Dxv?=
 =?us-ascii?Q?6WEECZTj9xouKI923Z1o2FA73Yer+YAymOU5WfDcpSjiTuoyL3hKROL4Xy+C?=
 =?us-ascii?Q?ywIB2eX4oeVZUNHvAWEL7+nHviJIjdWLM4XvMrFR0Y2XjlrU0CDjJkBN5XWe?=
 =?us-ascii?Q?wzKAkz4D5wavcUnrxfdSitBEhpy8DEdmgYvxmFoDENTkeNtA9TrJUcbYRE64?=
 =?us-ascii?Q?PcVh/VN40bunpoJAijll7V2JCJx/CcyTARzYajVrc3zFc5Cp8ddtoyNGWCti?=
 =?us-ascii?Q?XFdKXgRF3dK6Vn88MQ+uGo653td8ZYjrayIjQWpnRK41werqEZUldUe88nqC?=
 =?us-ascii?Q?MZGQEzqAMJNxJoRG5pRSvjGzOjzyma3W6NW2nsYv/KCDxsz/7+Q5FfHhoi2B?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b635ec-560f-49cc-a0da-08dcd1ab3aee
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:14:13.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6LwH1f0AFIImU9dL+BsSsM5WRlifuts6icZ3NEmGXZbOKrYqW7alvIrbCyVuzw2CG7N+3G7KAolZK6ukR5AfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8035
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Sep 2024 15:14:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16880

Hi all,

Civil Infrastructure Platform (CIP) will be hosting an opportunity to
connect with the CIP community in Vienna September 19th at the CIP Mini
Summit

Thursday, 19 September

Time: 13:30 =E2=80=93 17:00

This event is an excellent opportunity for industry experts,
contributors, and enthusiasts to come together, share insights, and
discuss the future direction of CIP and industrial grade Linux. Whether
you are a seasoned participant or new to the community, your presence
and input will be invaluable. The agenda can be found at

https://www.cip-project.org/announcement/2024/06/06/minisummit2024
(don't miss the last item)

You can register via

https://events.linuxfoundation.org/open-source-summit-europe/features/co-lo=
cated-events/#cip-mini-summit

Hope to see you there!

Jan

--=20
Siemens AG, Technology
Linux Expert Center

