Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC7ACDC19A
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 13:05:20 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89432.1767704714484161376
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 05:05:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bh74O3Nr;
 spf=pass (domain: siemens.com, ip: 52.101.70.29, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agvoUfpadtTiOxTCr/AKLIm70T0k5BrMbBgjRWKolktucC6RDbHDG2/itrituDmyInchJrxiTWuNHxUek7j7l77KmT/0BssIW9e5+s/UxOKRSqgju30C4uCzdMF2SadAzp6KCbkFgiAZuFmUt7kiMgcJvEpCk7X6VyLob26Es7YbSDr/ouZwu0ZOTrgxn8o4Rjgz+C+HhM/vFdvXtfLQtOPoGa7afu0lvdSX/8joLPteNCH5GCqyOhLNjTQRjavrcfy27dB381qHlZxhKLRJDFG6ZUv4r5E3tMJotw+p004OaH8rAI9pfigsVNcvSJat0C+Kny6YdqP/bdY+Jyf5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n39/xtQ+HVu1YPSloIHX6bq0jQLE0LYvsKHXge1D/zA=;
 b=OWz1+pcUvlmfahhWDkBgBe1qntX8zck7atEiUXUr/trBtZQJ91GpB06xPIgAPGXeq2AsNGmjvx5ztBduONycFp+bkhq6k29r3DJqBCbaUuCqt428R9oHE0hAt3e0vcEhTUciR6UXO+VCEumb/28tIvF5+3cEc8AOFsQ1TMEpwsyJS33tzR6lMxx5hLfX3B7WzjwoSLl1z18C50H4u88g/ecqNcDPewwb8tL28jTr2uCo5mS7aO4rFQTobbPi7aYQc569iFndyjmoA2hRN2CLwqtPR7/RCl/3NDOGtEhxRwbasB1xG5XKsG/afHi+l7Q4ddFZp9UrLqHy1+EKcot7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n39/xtQ+HVu1YPSloIHX6bq0jQLE0LYvsKHXge1D/zA=;
 b=bh74O3NrRkwcQDw5DsIoreZNbUxMiOAQSnOsgTrJILduwt0Nhse2fCI1mfsaYfebUh7AQmfHgWh6qv0Ojx3yRhOowbmqc3NLzcGFsFxpsfN5G8vYsmteOtqS7NwT8ELuGtIwW9MB6YDn5FyLH5LjILPTK9CZBOZQa9zancyx7g77RyH6VY/kxKGelt7jdpgsvpcpWK+bjZXLvH58Yf0gfi3aq0GqVEm6qHzrUi8T+3zibMgCoJpjh/ErHn1q22yq58Ik0O7VaqkYR4ZccpSWRk0BKFgopXdGpos5KbSydxOwUR9bAGmrjnZ2YwL888xx3zNLVpLSHr7vVegJsWXZ4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 13:05:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 13:05:09 +0000
Message-ID: <5964ea5e-8878-4412-879c-6a791409e1eb@siemens.com>
Date: Tue, 6 Jan 2026 14:05:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] fix(security): install
 systemd-cryptsetup for LUKS userspace support on Trixie
To: Gourav Singh <gourav.singh.ext@siemens.com>, cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com
References: <20260106124712.930274-1-gourav.singh.ext@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260106124712.930274-1-gourav.singh.ext@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f07574-2c98-4a69-a93d-08de4d24387c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eAOHWC2xtrNZVErotJ6y4W+2wyjHY+BiZHEPxFeUQhwxOun23okXRgLXyNBU?=
 =?us-ascii?Q?OIWLoEfS1EtlGZmRF3uexETJZCgY7OE/hQJMnOki6EdzWgoXeCbGYn0Qkw72?=
 =?us-ascii?Q?YwA4jmdm9byQ29Ytg0JbrspjdwX8eQaox9Evg6M5cY/a+qXN4asMuZf9/u8y?=
 =?us-ascii?Q?yeLWEEl+4/ZRYPcBU7krjt7Pd5BEiqA0ZfXyoZqqvd+o1jvnhvcMTPWJngmP?=
 =?us-ascii?Q?tc5WjaQ4AUU2zPdEaCwyLe/O9cNB8kRt241Mdpro9qwHvcJlP5C0kxTvDBnL?=
 =?us-ascii?Q?fEI2vv4QN7cvFY/MdQSKAI4/y3zgPmuGDjmoHHvUUKy+SWmiSOwl9wjwNj/U?=
 =?us-ascii?Q?y5/WpPMvcBnPCWvSg9pdw1SULOGw95baPFTmzAxjxMCbRHmC3ikd+n7o4nYy?=
 =?us-ascii?Q?VIpca4bgVVMc6+dIRixf2g8fbZw0SoVrua624Oy5fa87w7InFGl5pX0HKIvu?=
 =?us-ascii?Q?0uolKqlKvO7lOS5/hTRcdku+W3nN1JjWN4cKCGA8Rz5R1amXnq6op9J8RRgs?=
 =?us-ascii?Q?IAwrUnQ5P+UjJq7vfaKSlx0g8WBfomCdd8dbCPcJNSWhgabuxsORP252/rNK?=
 =?us-ascii?Q?s/aEMuAQ6+BS7G7A7Ht+4K9pwY7kHcS9p0zdoFYU3YTLiEPxjQSGNgSwCzt0?=
 =?us-ascii?Q?ilbd+nj8nRKxHy/csL8P5fWAMq8ony+JSAd7Lh/8K3bAXUD0nlT5S6ngjWiB?=
 =?us-ascii?Q?Md5W/q+VAB2C0d+cE/c5PWilFgN1Qr3G+VzHXbRhwau3uGm4jTvUaCWq+Zu6?=
 =?us-ascii?Q?e3dnPIt+6ON3qJlJoYs3wFyvCak4FRA5IjyNfc/F6ftl/731EJepoF45G/qZ?=
 =?us-ascii?Q?KE6ScfX+QmEmjA4fNhNejArh28XC+/BmRzSQsbjd5S5LN0t64YjfZ4ZfG3y6?=
 =?us-ascii?Q?Gc2Egddmi35fcozSOmVBgBnx8OGPqwkHQE2i6PpkgdFajs6zdN+U7AyQ30dG?=
 =?us-ascii?Q?LA5DpHf3dfEbmpCdtOBCBFI/+ruCNhw39l2HowNKPbpJ/TCqb/bVLWNZQGW9?=
 =?us-ascii?Q?82cGY4T/cPm8pC5heZKg4sY8E6PnJFxTpTc4H5if1hJHtg4RmZHu8a1M6M4b?=
 =?us-ascii?Q?odLZ4GLcre4C/XIVX/l2QTZ+HW6k4b7hyTEP2gym5akFjUIQuQYy9ur+onE8?=
 =?us-ascii?Q?xn2xk2ncmulwF/cej1WrR1cQNvsyLGeu0sAWEMEHtLJMJ8EKopybdnWncT6S?=
 =?us-ascii?Q?RH3xlKNz03+2v1jpPlbFAUGJ12a9bzbF9Mj5xMjkvUTqxtw9s/tPRhdID1rL?=
 =?us-ascii?Q?gAyrASdn8CbIUJbbKTfOjHt3bEUWcjENB9lEWJNhLNBCEHF02Wfgby2/Q7sn?=
 =?us-ascii?Q?mzxDC3Z6Za6+ffQ2K/JS3aQItAZ/iSEipuLQfCotxX9IFVoAmrI4t+osRXbI?=
 =?us-ascii?Q?JAcjyMsuT9jFiIfYvJvvkCh5kgnsxtf+1jQnmlmsOEm82hjQlbRhlbaO1Icn?=
 =?us-ascii?Q?3vOQXwmqRENA5jx/CAcpUbu7lto8AblE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mAIoSGjwcbJConebyk29OR+7Bbg0TIkiD6cfsWdBahaZmAVhal+Gn1pVW3q4?=
 =?us-ascii?Q?6u2h/oIHps5Bh+0yS4O1E++JmAXe8T6TiTl0ZNTk8b4UnufkEfBUo4Lit8D/?=
 =?us-ascii?Q?ejl5gmw+eNGKatyJShDsfqtu+LAH9YZD8ZJ0L+YC0JJTz69hjm2YAhqsDSIx?=
 =?us-ascii?Q?8TgCUbNMwjMVthADGbGrgcYTJOBxL9V8yL7m86nUakXxwerWLNmTiI4mfg87?=
 =?us-ascii?Q?tgGhjW7LCvei96VQjIH0UHWku2fO4TWU1V4KRswzZvuf1EEqScpTaAFZNe4w?=
 =?us-ascii?Q?DF9jgIqhAgvzg1uGKDQqs/+zGeCV53oF8JY6JteaSBmdSO/sswlFkzINtvzo?=
 =?us-ascii?Q?fH7VHAFq2yHpqOVdMqOGFsm6RByhiMUs4u9+BSFfLtVr4rShFJHGfxhTY8TM?=
 =?us-ascii?Q?dpBBnss5nHsdUAQz99/F5/D55fzC7+inxV0QSX+0wDA+polkDyxyryrZsFy8?=
 =?us-ascii?Q?i/NbCc/RZ0FwBoUdCVSZbC1jMfAORx0fn2LyTWiZXRdpHLeLHW9heRRUB8PB?=
 =?us-ascii?Q?JwlQp5PiC1k8w/1c0FF3PMgwP3B+Bng0MwobM9Uu2NzwUhlqyn52Hspo02am?=
 =?us-ascii?Q?KV1Alk9fjattGbEIa3Le2I/lxisffsTYt2JhZ0M2fzNjIuPSIDYH9nTLE/d6?=
 =?us-ascii?Q?WNMyHvuXHdvb3f0kUyMmey9i4wXv+pb11HKQzC+Sr1ebZdXFoTpbhHf0ONYG?=
 =?us-ascii?Q?Vo2oLID6OKsjhyyISBkob9241FPPAd0iYzSplSdyBL4S59c3EiwyjhPbA23J?=
 =?us-ascii?Q?wj2UocrKKSuo/ZOvbbXwUQdDMhWMU8+95vf0ZVXDGyPLIqJgfTCO/SzwGvoz?=
 =?us-ascii?Q?plpdlZpROdULiAmb3rAG5oiR6H7OI4CGS5iCA1IrPUOVjFrv5KcPZjEIGgEg?=
 =?us-ascii?Q?i8H/6CAAmqqmUpESHu3hW77X8URA1p75mBhB1Jkn9wEA6L7nnTtQNYZFeQ9f?=
 =?us-ascii?Q?eRgrbH/PwBwY8UaUiTQteivP1NFrPW50ANaZcpscUeK7vQeF0NywS2Cfq+sP?=
 =?us-ascii?Q?MyK1ZazQ7SPn7n0mfmhOE8vdXkrqgqwsijMxW+CLtvyRIbUca9U7Kd9VaObS?=
 =?us-ascii?Q?1Wt4sb7taMQtUlNO/9UB/vN+Ok9tj9Zaf7A7+uF3xLCyQnDUOISW7CFIKjtn?=
 =?us-ascii?Q?weeSms6psI+ZqUkx5cB5C1Vh7+ATEhx11NHOkpMhiAONWlRGL/mVI0qv+dFo?=
 =?us-ascii?Q?AaGuU5J8NzuZTAgAfLsdKn3p+V1jlFkqAoeAZ1OFCEnx8IVhrxjBdcwtjKWM?=
 =?us-ascii?Q?tWE0OpHtVR6CBTlhcCkx61ZgcDXU2K4c7xUaVXAtPBxuVic8QBZMcD2BJjga?=
 =?us-ascii?Q?m5Hua/3Zg90JAArLZtHqZceLFG2WAK8tg8XuOz1K9gaEw4sgyULfJJEDAVMe?=
 =?us-ascii?Q?uk593Agwb39JyD0RJBLJHlB4DqjbW0BMRMs7N5Q1/Bj188fNQDcxH3hlNXb4?=
 =?us-ascii?Q?j0wYreeWptl4ZecUL3O+gtNUkVG/RTade8NklRlh+fXa8wjUIjT01xB1n8fk?=
 =?us-ascii?Q?oU40hRI9knVpZrfmASSNDv+aG2QrT7V8xAPCyJToZliJHR+XGhxuTor80f2P?=
 =?us-ascii?Q?7kq54a/WcIxbdAoPmkB4pMHRLVPjQR98EIJ0oWRnqvWqHBUaqGBaKoBL4jdF?=
 =?us-ascii?Q?CeELiaiVYA6sSekvm8EaC7kuoJoOcxbSqEYr6crMayIOM9F4E8C8SFy5Kamt?=
 =?us-ascii?Q?05G4nPxvqp1n1+GDYxC71PGdAvuRkqCRUEbZiMp9OIyDnci7j23Vcsqt+MSX?=
 =?us-ascii?Q?U6EOv6ApNA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f07574-2c98-4a69-a93d-08de4d24387c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:05:09.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI+jLtD933uFGDEkfXSM9Pj+WZSsxfZTe0KmCF5oMzs8RtLhu7aEpYhJd9DY3HUdJjeYQfqaW58QFCVCtjhSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5142
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 13:05:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21377

On 06.01.26 13:47, Gourav Singh wrote:
> systemd (>=3D 256-2) split cryptsetup tools into a separate systemd-crypt=
setup
> package which is only Recommends. On minimal Debian Trixie images this
> causes LUKS devices to be unlocked in kernel space but not exposed in
> userspace (/dev/mapper).
> Ref: https://salsa.debian.org/systemd-team/systemd/-/commit/65e0731d3a036=
0fe9816a24be459fc2d2b8becb3
>=20
> Installing systemd-cryptsetup will restore expected LUKS behavior.
>=20
> Related to issue: https://gitlab.com/cip-project/cip-testing/cip-security=
-tests/-/issues/8
>=20
> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-cor=
e/images/cip-core-image-security.bb
> index 8a8c695..d14f749 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -33,7 +33,12 @@ IMAGE_PREINSTALL +=3D " \
>  	passwd \
>  	login \
>  	util-linux \
> +    systemd-cryptsetup \

Inconsistent indention. With that fixed:

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

>  "
> +# Remove systemd-cryptsetup from older versions as it=E2=80=99s only ava=
ilable in Trixie and later.
> +IMAGE_PREINSTALL:remove:bullseye =3D " systemd-cryptsetup"
> +IMAGE_PREINSTALL:remove:buster =3D " systemd-cryptsetup"
> +IMAGE_PREINSTALL:remove:bookworm =3D " systemd-cryptsetup"
>=20
>  CIP_IMAGE_OPTIONS ?=3D ""
>  require ${CIP_IMAGE_OPTIONS}
> --
> 2.39.5
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

