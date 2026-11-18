Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1620.1795021729049098715
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 09:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VGtyOMDU;
 spf=pass (domain: siemens.com, ip: 52.101.66.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3XsCK/+Jx/3mbfIl4JkGsUrgEXExqSg2oG4CG2zZyLePr8UcckwofmBKtKD5CrO698Czohipl/t4wPouxAFFGLOhWA++YFtmhVPsKmRuAOHJGtrS/XQVFngN4xE6lsWGNlmB13YOnwP5GrC7CseD4NQFfavxWdbZnYzygQvhVPFbySnNzhH6hSLycNMMnvw6BqC/Up5cuGibPI9f0Yf3f3k1JQxGPEkuKpl9vimAAvcyLji7qWwID1xmvJ8kkaCG1eddkVhx632IMuABwpz1j/ado/n3MVKejcVSBLUWLXSAtyPJrPKUmXCse/fqMFSXxvD5qQtQr9chhqmOalUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ0I5bphaC/x/PKgv5vfgssa+0pjcN0nv/nN8imEbmA=;
 b=BlKiaiWNkQLQ/eZdgbtqFIqucbkx1p+XYa9cHR+8MJdBrKOJ8m49eDgKg84ZvM1B4XGwMGMztWSEeRxGtfCD97A84JWyEMq+jrTPf9m81qMxDKc3pkchARN6aLZHS0j33aeUc43AFu7gVMUejZ4hbLbYPqyxwZRirZil3JYKCkGyDau45RZTpZ13jdY60ACqKnh+FHLXLraBMbEIq5LVXJS2iGcrzzCQVdx1sm60su9qngglS+HQi9Kx6r1dWsTnznQp11Y6ZamsQZoZnUB7+vZ6xz57lVIRS/lTPKOliZLYHYQ6SgwePd3j/HNPSYyMoAzl42uVhQaH68m37g71Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ0I5bphaC/x/PKgv5vfgssa+0pjcN0nv/nN8imEbmA=;
 b=VGtyOMDUWfNCTr5pM7JfXw2wgcydeAphLmufP2cZF67f9nqeHurqEfRRw38MO6okYrKS8IftfHcx5FCjN39SjnFvc3Marbv1o8yt6dN7weNaVCASqBUC09xfCAiKfkJ2OpwMrdX9R++lBpU2aWaZuwAhN0Uc13AEsdZUsq6g2tw655zgm2IOytTOqOES9HMT+U0Ocm06W6/+qRf2FxdhXb23Z9TQZamHWi7HPTrQnUKn72VeQar1eXgOt5TEANdDQx+aQbbMxMDr4In8Tj68KLsjOM6XDHCh7ZcrsH8sqt8sQsKnnXktCevlfLYyTxQU9yDvlnqYm2tRYTbxvyQiIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB9075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:214::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Wed, 18 Nov
 2026 17:08:45 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Wed, 18 Nov 2026
 17:08:45 +0000
Message-ID: <67ac521c-b7aa-434d-b5c4-0c3539d76a3f@siemens.com>
Date: Wed, 18 Nov 2026 18:08:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] Drop ext4 build as default
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
CC: chris.paterson2@renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp
References: <20261118125450.620231-1-quirin.gylstorff@siemens.com>
 <8906c84c-2b82-4a3b-a83d-844dbc061936@siemens.com>
 <f37d9f15-1ce7-4aa8-a925-6a4f3889b4ae@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f37d9f15-1ce7-4aa8-a925-6a4f3889b4ae@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: f507d256-bc38-4132-8d65-08df45969a84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|55112099003|11063799006|260925022911599003|260925021911599003|260925021311599003|4143699003|56012099006|261022115727099003|261028144727099003|261026140227099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: QXPsHs+fhNNTfdyyEbUwx3drWfb0yKvGjT/fDVN0gBWrTBJiPVWYnarE6NS9vH+5reVYdIV3uqP0K+d+6J731yty2MtPSzDm+aE7M0+/KB14WOHPktmuMDV+b7fpKEaMkwiUWPkxQqlnqiEs5G/f52LCjZ4i9XldZSRjamHWTH/LQqhdFQ3Rnswg5S7cX23lniD00FEHSrhled0lNXEIe2Fl0l+j/ap2jHgUBku6U1lcgckBig0SK0JbwPzL7Yarzm9/QhrrJ3cMz+7s4GXIQ/el1iDvgDv9aZHNjzMs1lq4LwcpX6FrsbkFjl5b8QKLDZYEkZxcyO1sHr/hmA6bzQg/2lPvC1ii2+tHVYs53hl0NjJJwrnW1oUni/Ja5qJG0wOcv3wcXa22FjAUYoJwCcuswy6E923MQMlKvPcE9GB37woopyOnsldNEhos9cqFbnyRvp37isTWkfTPCIhYancxVW7hiV/6YTDqTDJdhgxzNgvTuSSEB9cOrslhDj1tXyoZI4FNLXoe5LnNTh3vyhXMlHjlxplHDAj6C8uZKM0XdZLDT2NdLBIWATUf1YT7N0RJIDH6xRr4UIjrsR/mqbNv9HsyJJCOQkKo65tcTBd1yY13rjNGb2kWwZux9jp4/+AD7h+yEEoT20NrROc1Jryb+HivCnJ9mCUQMXsjA0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(55112099003)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(4143699003)(56012099006)(261022115727099003)(261028144727099003)(261026140227099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P55Cuvtp5MoTfyjTUuQ5K8DPNk4unhno9jeScnt4Iltl0+ISeUoIsyHd3mpQ?=
 =?us-ascii?Q?Udh+0i20sdZIivTT9k2STLU53JjYUzHRg9CTdVhs4ixhqVzmk1iCvjQxL9i5?=
 =?us-ascii?Q?HHZ57S7T0y1aj8q5kfW5PdBG6S+lWvB3zUse9OdG4Z/J1xs/OpUKOIySJSTc?=
 =?us-ascii?Q?133lNoJvpRQhKSJ4E0eCGhT8mNiJH6aC/LD7t45yB++GMiTJVuZLTbWk4n5M?=
 =?us-ascii?Q?afLH2icuRC+LeHQn12n/yW8hDg5MNbtTeWgmXpnPNJjmnoSxFiNViB7+2Eda?=
 =?us-ascii?Q?RwTPdSw1g4NFXq0fjI9vB+j9zOCodY7MYS8csDUG/baHD1vPj6TqRhw9jHy5?=
 =?us-ascii?Q?m+ixiRtn2tNSh+dkzsB0jzWFh/0PAlshziQNyrv4jEpIfDa+DsLk+SGlkKeg?=
 =?us-ascii?Q?Ql3fyLSCGq5Oa2ffKE1VBTOmEgllsDz5kSavrElt0JVNQi93dIkA4Xd6L7od?=
 =?us-ascii?Q?w5itgMd1t74lh/jcjHBN9o9sOITorJGUjecXY1r4TbOzyh+75xpTfgPHjX4Y?=
 =?us-ascii?Q?SfhmmQjY/p1MAKes/s3S9Zz1J6RkZA3aKrnJ19AFBbLGHpWQOqIyK/LYSfGj?=
 =?us-ascii?Q?P/dZtihBvLBqStTfPBrmQGsgdzLuRXQ8sccb2kiO8KogaU+hmP7QQMvOr8Lq?=
 =?us-ascii?Q?IQBneK8DHscjLuNuAHsgsATUM30btqLqIf70SyXRzPB1kP4OJX8Gb3j11ozQ?=
 =?us-ascii?Q?qE58+7qLjII+ffOl/gfbJkISCWVTeOYBo3qvfa0fMWSEVxYQq2x9+mb8/gfF?=
 =?us-ascii?Q?RybSoF7kMrxo5UMNt6b+E1QFaQtRk1DaA5OZWU6I6EqxSgMaLn8jDWVc6g/H?=
 =?us-ascii?Q?v5sSdM0NAimFHUIk0nobjKKm2JM2L+TJKS6kpcVVyoeMdSmSoBKuYWmbZMDd?=
 =?us-ascii?Q?Esdo/TLvvFkJiTzxS0itWBaFJjYJ+3r8Y5CuZkZ0vSp2ZyZIH/oonwU+Nfx0?=
 =?us-ascii?Q?E96gsLCxe0YcjzIvtS0Z39Qot07mEwUT0HAFIJyd9dDEUGLS2ID9iYQfG+PP?=
 =?us-ascii?Q?CRXUjINNOqEcRO+dvXPj8ygargpdaAjrzK8l/qlpBYQM3zml2dEwy5Y1qRfX?=
 =?us-ascii?Q?t6vQnCZJDVMKIb8+AKixKNrj9TBjxcMGa30n0XwcYpGyD+LyOWNWvkq86Qf9?=
 =?us-ascii?Q?3C23f+xm+pLylyD2DnM05C4hRvHsqMZKRz0p9K9K8YNzKS8PzpG1n8sOcnGJ?=
 =?us-ascii?Q?Yl2/dljzfZyMmFUpVsvmHkMLS5RVwCBdc8AJeMBU3D3dZbqAGPt9hQAK4hVk?=
 =?us-ascii?Q?RM7yl4v07reI0MoiUj1YmqwpbCKZmqQ4hHvmSoqSL/u6FKM5WboYtekFQNE4?=
 =?us-ascii?Q?7LxP+d6XbJlWx1KbmCriXq18ZpfVBVgvREFn6ULltWT8hurY3aJm+3ooO7gD?=
 =?us-ascii?Q?D6kA3WzLjoglFboseY9NTljDL0L9Dmxu9uGR0krZqWmGmuLBhgMITfVCsd6o?=
 =?us-ascii?Q?A6YEjf8O5yzEvFRjWNqodChDwB+4UWZNGbnyjj+4rTz0GUwU8uLFtspKDKRH?=
 =?us-ascii?Q?+VAwVYw8KWfQ2Hx6nxA6OQveqBgOJ/zdDKiTZupmtBSkuqUg33Y3kyJi2+iq?=
 =?us-ascii?Q?pTRIArdR5kezyWANU0nv4CU+979Wrz5WyAdGcYcVY5w3ztNvsWd6508y1zTK?=
 =?us-ascii?Q?I7vycM07gbM/UZuqncb4Ii90DKF+hfbur2a2v5/OkxDH7nlG+czehVdn17jX?=
 =?us-ascii?Q?g/iK5C0KGFKz51zvGiqSD2zffjVqOorTlp7CZAe+2rzMsMREB+PvD8t5t0Is?=
 =?us-ascii?Q?borPAg/Lez8kbYoKAWG5BzXtklLBtu0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f507d256-bc38-4132-8d65-08df45969a84
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:08:45.0332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgI1dTCbucb9PAQbF3TOV+tdWAvkIC1AdtXHn67eGNVRJYR42Vtq7NaLeO6zmSHoHcDVchnObipe9hR4PsVxBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9075
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 17:08:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25001

On 18.11.26 17:41, Quirin Gylstorff wrote:
>=20
>=20
> On 11/18/26 1:57 PM, Jan Kiszka wrote:
>> On 18.11.26 13:54, Quirin Gylstorff wrote:
>>> Only the no-kernel builds and qemu-risc64 require the ext4 build.
>>> Make wic the default and set ext4 via a kas option.
>>>
>>
>> What would be the benefit? Or is anything broken with the current setup?
>> Not voting against the chance, just looking for a reasoning in the
>> commit message.
>=20
> This is original a fix for https://github.com/ilbers/isar/
> commit/6393523290ee4bf108dc7b0a4337720dbf4602c8 as it removed all
> intermediate images in our case wic is a intermediate type of swu.
>=20
> Felix recommended=C2=A0 in the meantime the revert of that commit.
>=20
> I still posted it as most of our builds do not use ext4 as an artifact.
>=20

So the idea is simplification by using the actual default - write that down=
.

BTW, you are most likely missing some Kconfig change or an inclusion of
the new ext4.yml by some other snippet.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
