Return-Path: <tobias.schaffner@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F4BC982DA
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 15:21:44 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13538.1789744903479494389
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 08:21:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gTWdDaF7;
 spf=pass (domain: siemens.com, ip: 52.101.83.23, mailfrom: tobias.schaffner@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0JW9l7UIn1r9BKtFAq1t16UiOxagnO4pQ92tspzbpeGf8ZbUyMRqi4pnPz2CWW7kuWB6vf0NRcjKDEUHEDveHbcchDLsr/6chUKiaIdZzlU0OAPJC38DwcjWXSHAnjZ9rYEY7q+D3Y8pZ+EBQsPx723k+s/izp0BUMx2k7U8wN0TqEIkhwY4qnBIUdAI3dy15buBDN+RxkTcJZ0OvzCjiZeQXoYatCW7R4sEWj77tfI5Ho9lUEMMfVAcK3tS1G1TlM6QAu5kdh/veEaUStOFnKFQ2rB/JEkkG+zpcYMqSSYqNbMJsWaZeANV4KXxh03WEJ/tYcZjLZS/fgCr9patQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxHTZy9dzlrTe0JhgrN1KlABC5/hveAVvdHR7Lwmjs0=;
 b=u2uz8WPxglKhovTY8JQoTjksHDTuv1zDsHXHut21LrhJXTRJuKMMrLi2L+LzpUxzyx5JAdT8vySeiSNCBWB0o2i88ndte7gPHx3jHj+PTTjx5dgXpYgkf6Uc5Rm/pCXPYeHMM9OW/Yge1mPaqtVM7L16ZTetWyRLRarbtrjIniq6vJyuG1iIUkVAPhVc+TKPmb4O6MHHrvV21s+N2tkSX8Yh4+5l3rB6O71U+yBvFeF3FbHe8PpQJlyHyJaJ7FaaWriwR4w2rvGOkhDlNSWRp/hx70ZjENPZfg+MmmfDqFMYSWXbXzDWUYH+bFzvCYnWVO7xgZDALNAyqksv6QKnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxHTZy9dzlrTe0JhgrN1KlABC5/hveAVvdHR7Lwmjs0=;
 b=gTWdDaF7er7lfbAeQN0QJa08HnqgABwYl2SPZrPmeARt1b5wKAiqPnrrPR0IeJBz3x9Gac91lRXqZZy0JgKXDQPbgTGGHqc55BIGNbxUmrmXFDNnsYxz11u/tYpUCaWHMMnM/BO+kd98PTkfWEMIGYALaujDVfWZcsFhqZKRSMLk/hJMHFE0xI0WhoXopKrWJeGcfUDG+Ywgb8+uuzp1NLxZ5H9TE7QQcKQftOur3+1m/gm5ILDCH4bIQouyZapqzeYxX+MTzk0ip3VYepmcXLDtXLxmwLgiKyROZdgd7dPtHfmsVUOD2uj7rXhCDiNxhRXlFxheX/HIbuGFhFHULw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB6767.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:32c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 15:21:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 15:21:38 +0000
Message-ID: <e9200d07-c3ec-4504-8126-af315eb6c6f0@siemens.com>
Date: Fri, 18 Sep 2026 17:21:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [ANNOUNCE] 2nd Isar community meetup
To: cip-dev@lists.cip-project.org
References: <18BE71FDDB19A7A5.114350@lists.cip-project.org>
 <18C769C917299A44.3212680@lists.cip-project.org>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <18C769C917299A44.3212680@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: b2086123-6c49-46b8-f6a1-08df159888e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|376014|13003099007|56012099006|11063799006|4143699003|5023799004|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Eoc7tgPmjuiZIWpg/JUGN1VPpgEFw8WYnHfkh6IxaQ/+Fwzz8M9K+fMpW0yAlda7iBX9YIzPjZHbMdbcC+QmPI5YKiKYgGeLtfSlC2mhfCpKxm2OqXCb77jdOdBiwjqk5UoXjV03W3oMXXyzi6aWB+70fedLx7K7HTD4DKdY0adXJkTXJfIwEJasNJgcS4keE2sJH/Agt/DKfCjLhIO96sv3YzeUxmLCQV8ytp6n2LfnSFwvaq7nCVoLsNYXN63QaPUO+H65LyVS+nybHs5RWghcow5g4mpZsEmGWLPOaKC9RhX87LX4bRc5hcm8eEIX+o/gg6Dw0d6Jb2uaVeRysWC0Rn3P3H2x4TVoeeFWrnI82QtRaFyp3Wz9vgj0EvVD+QwvIvoKE/LLHpZWmxNjYKyTI96vt4H5lX2VVrmN69LtI3UbBX+jWGfsM00Bfgdeqd+yvQQ4qscO6gBzrMFxX4RD5C0G3W7AMnMY7ZtP9nVmOcYw6/2UyM9x/AqBwxUDcDutcqrCZFmCfiOss8fTMWJKVUkI0rM5Eot8ZATLT8kfezqnYV7hvbSaakS8WNvPY7S1gcjbS1dgas6SA5+3RcHev6RAabnsI/4JCJcqvjw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(13003099007)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0MdUNeiDsDINMqS1ekG/9kidosnkknUFCRB8SDOeKgKy8sGVCkdGjR6Uobjl?=
 =?us-ascii?Q?LCAFfzpwZhtiHOgqL2TPgAdPy6N/9IT5fc8fkisltcrLivjA+KScdBlnxVzL?=
 =?us-ascii?Q?uS7cPv+rddayqYqNuxJZX7IsyNyFhTZ2HB76Qg29YPiuh9gLzFLX5lj9RyFO?=
 =?us-ascii?Q?8k29bOb07mEVu6MODy5V1QBDHxSDSc4BfaYrOU1t0Fev69x2nv/vJnQOr4vW?=
 =?us-ascii?Q?4hxbI9opznWlqKIq3MkmharIChC3pkfxvOIbyOak2HsqNGjCMvFR5pg099Yv?=
 =?us-ascii?Q?gESZ7czXro8zVVEdATo2D/ZsgGSg60F11bxtuIDoZf306rm5opGLiaaA5ipC?=
 =?us-ascii?Q?9MVatsJx1D5HzW3mT9GBtlHVoPUHiCg8XXgCY0RJzoFNgCNlnJjO0690vllL?=
 =?us-ascii?Q?uFRt9tNknY38I/yTB8D1envhTLI5f+lIuS7FcAWoLMF6eWnoiYpbUeDpyQuX?=
 =?us-ascii?Q?s9g0ggxcA95OsCD0E7cDgaiguGLFlf8iGlsXISwiYIBZz5K0gICJRwTbryN6?=
 =?us-ascii?Q?KTtJ1U3sokAS1Xppd42H5iYKcqQ1AclTO9QSZRoSJL9dyhD2MmmB1yIoByXn?=
 =?us-ascii?Q?gFJHSLR3ZDYNujZVfPpC5APEkJf+qYxG6YUp73YYF2hN5dH3boDGDYzhdldT?=
 =?us-ascii?Q?UH7X6DqYFlhlDiE/oKP7c/QljXyLz/pOQKO5ooXnzyhlGDWBeTY9vvle3y4/?=
 =?us-ascii?Q?y3EGG/agOGMIIb0cH3uGbUEHY0C2+j5hro9rD1Oe2UwiuMpgARZfAocJDYOn?=
 =?us-ascii?Q?DFloMtp/4ZQNgocdXR/6LI14fVO0VaW98ucd2knHe/NtZbgXYjAAYNwq/Rc/?=
 =?us-ascii?Q?8yXzUaky/Mld1h2YNt/AxB0Jh//3ckrOWV1g0UNHvaboCdU1pZKr5SiWXzqz?=
 =?us-ascii?Q?LLJMaUgAI8Z/dlUaKNxHglOxh7X+RoKv+77RN6NCDCyol+zyqa4xKSodjiqK?=
 =?us-ascii?Q?e12gfspyxveNtTX0OuGHebRO55o2TGCrpRJP3dEcAUYm6/N2hAnWncHQaJxL?=
 =?us-ascii?Q?+B9kPVqQzV1Cc8er4I/wUbtJffCBQLM/7vtitgSef6adpGUunlj0A3O3rTQY?=
 =?us-ascii?Q?WQ8CTstSff4S2uCmfkieDxWKRiwlQpYxksH99FRO6ktZ0TqYEo1YMahS4XtX?=
 =?us-ascii?Q?0u6qT8P12zA3cPCIzL8i+hBCMmYsVHSdDvtUheF/UvrIPkiYg9OuKwwJrFtI?=
 =?us-ascii?Q?dw7/TzUIMp1fN0g+DZ1NnKw6rK9eiqKN7nlzsfm3/8dLlCDymFkdENH/6sie?=
 =?us-ascii?Q?ex6b0raPIpMHwyTdBJQsrk9OawugKDlN13jUyvAgEQfBA/OoIjXX7XFpu8LX?=
 =?us-ascii?Q?53L34P2BEPlVPnX1Es2tZSFtKYq6vrXPvwYxFyAkGepe4Ol/I4/msyIG536d?=
 =?us-ascii?Q?Lpb+9ijZphlqVkcBIUNKNW3ZQLSzcptgEmdPurMi8PgFg/oMGFb95JWayzMu?=
 =?us-ascii?Q?0Y87IEgjfdImGv0ZRoKWv9QYN+5XN+6+GGQh0ifS/zVFasPs2t/EZHyRWxIA?=
 =?us-ascii?Q?WkyPFRsU7atPdoNqc9ht4TiodzS3+hrGJlqXXkEEPIFPgkz7kTuuZbluXQaP?=
 =?us-ascii?Q?J/9pNyllYri5QNV8qYid1ENnPF9z2g9S1YSWSL3JlHZYLsewxWwz0iEhabez?=
 =?us-ascii?Q?XbrFFR5+MDw074kIg860aKCuycASYCsM/jIVOfd0hvtbAjJJZfcOyY3vRYjt?=
 =?us-ascii?Q?aq3t3yo3tvocIgO/jW7LlD0k5NXvPto/3Qxm1Fx8W2YtLaldq7dFC7XlkhBm?=
 =?us-ascii?Q?T6CQOUc+0Fo6KqzWDMQQ0zDTwJr8kQK+sQfBgVofjzdwkTx38ArbzmLhiCI2?=
X-MS-Exchange-AntiSpam-MessageData-1: fPPQQjfqQnZRpk+oiYY+4GgblnPQjLNii3A=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2086123-6c49-46b8-f6a1-08df159888e2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:21:38.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3KewFsIMDRacNwOEEwDD20hlBUBEoHojtPXhDkSbsc7MxHNnqFHOWma3OZY+h6wR+8WWl+IaDwf8069B0mhk+WNYiDi5Q2orUm8updbIDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6767
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 15:21:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24244

On 7/31/26 17:34, Schaffner, Tobias via lists.cip-project.org wrote:
> On 7/2/26 12:23, Schaffner, Tobias via lists.cip-project.org wrote:
>> Hi all,
>>
>> we, the Isar enthusiasts at ilbers GmbH and Siemens AG, are happy to
>> invite the CIP community to the second Isar Community Meetup in Prague,
>> taking place right before the Embedded Linux Conference Europe 2026.
>>
>> Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Monday, October 5,=
 2026
>> Location:=C2=A0=C2=A0=C2=A0=C2=A0 SIEMENS Conference Centre Prague
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 SIEMENSOVA 2716/2, 15500 PRAHA 13-STOD=C5=AELKY [1]
>> Registration: https://eveeno.com/isar2026
>>

[...]

>=20
> Looking forward to see you in Prague!

Hi everyone,

We are just over two weeks away from the 2nd Isar Community Meetup in=20
Prague and we are happy to announce that the full agenda for the 2nd=20
Isar Community Meetup, along with the details for our evening event, are=20
now available!

You can find all the latest updates and the complete schedule on our=20
info page: https://eveeno.com/isar2026

If you're still planning to join us, please register soon as we have=20
just a few places left.

We look forward to seeing you there!

