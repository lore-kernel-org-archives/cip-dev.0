Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE0CFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 06:51:06 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10656.1763967061556621965
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Nov 2025 22:51:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yXwNO2KB;
 spf=pass (domain: siemens.com, ip: 52.101.83.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHa528ZYRtHG95+T594IyV8xEaUkzHVROCE3NW7Lbf+3SmJjnP5LA8MGlXqWokzX8JPpEnrtZVNbAeebnXXXxdqGfKlLgqPkRrqevQq4tN/lGxSutDZ1n84b39QQIjsj1+h8HrsD8cldkOtvTWGPrwAAM8bXfshv0kfYIMYxC/vKXOaf8vhJmyeG57J04/qBLNqX+Bsj0XMkPI5Pdbs5Hvjogz/NtRNjfNja9p8feBttaBG2z9Uh99mtQh0+vugRCvKWXcuegUETHnizkiT805TZt36VFndWufR21WAAxEqS1eanOBmGKfgyAXZcf/s7KKYlRNBJxbfu6zuFhUC/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgI4lf7Mmaow0vnrDPW/fPJfln1oBGL9NM15j8FV+BQ=;
 b=t3cxP2Bp1F6Rcdap73R+F9/ZETUSvx1o+yPjQ1DLlkhHLL/QNU/V81k3S3ysjBYGP+K7fGxcOqrFaac+XY/UpEUlCs3w5/DsIYQV1e54ISpQaF504GO8ggaJXLTci5lGRl3u0e5/JEEh6VY5scgAU1xxpvNJzy6O62woaMn9aZ2tL5C7sSivhiRaBAAyrK9z0fmszcnGn1ZdHCaLBbTIKtyLQ1bw5jRh0m0UQRYiFx90kyztcNd2uvLsssflLcCH7eE75znikjP5E7tBdN8dQS8aa+Sda3wxTM4Aaept94sMLm+VhkK0Bv55JQJqKd2wcJWplUYfUtNEszpN5JSd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgI4lf7Mmaow0vnrDPW/fPJfln1oBGL9NM15j8FV+BQ=;
 b=yXwNO2KBtV8bOlFE0pdWvB0+aUImIejIR02JBLItMhwhbV4LCB/y1sWLpRNxEs4MIVVN+DXHZnDmCCXsLNlNfjqNSRTx9r00bZ5DeIbZaAIeVfUvX8jqq/tCUVN+HXJk7Y3r9qBVqqU1+08nc4/mVgzXQCUkHWLzMyNaHy4zsANDXU1lsG8kI7YLYFFGmOBWZ0bqe6cMKr1N9YdgiP3ilN6wO8YMAhwgS443IxzbV7QdcXZ/Ft1GTictI+6pZ08xoTV63mAh70ognTOBoXziE6o5a23ftzhuBSJkfx01c3eNgJZKiqBTaMRp009V93R11/EUl3U3cwxI+F9JKvS6Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3315.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 06:50:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 06:50:55 +0000
Message-ID: <345f8c1e-0166-4946-893b-02dba9dd71ce@siemens.com>
Date: Mon, 24 Nov 2025 07:50:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-systemd in
 Debian trixie
To: Gourav Singh <gourav.singh.ext@siemens.com>, cip-dev@lists.cip-project.org
References: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
CC: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro.hayashi.f74@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3315:EE_
X-MS-Office365-Filtering-Correlation-Id: 13545a99-022f-43a5-5dce-08de2b25d0fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wm/3WWMnCdK+yvoyNUu417k+cK4XvHzXDhYTd1oDq3NEVUKf0bwZ6TpZx+jo?=
 =?us-ascii?Q?WZGYoqkLJR0NB6ma89PncKw1aAyKleQ4Bdvyw45pc0minlFVbkO5wWPu/SCd?=
 =?us-ascii?Q?lALNTHEIbbFAq4VfaAVbEvz6Ex3qgwFHQtnZTnEu64yb27tUtjIKdF+5aItO?=
 =?us-ascii?Q?/PDyA7XnIU9zLeHK/NDdDgBh3gmkeHJspwq5zMUb+uCzvYQhmclYQJTXRvKs?=
 =?us-ascii?Q?pnSwn9M7sUkSWB3zcKT7Wms7WwVEKVeOVtKmL2BsM9Ylyv6ItBMWZPX1HBL1?=
 =?us-ascii?Q?bGKvrssjnQ0qiJpQMXOPUaz51pYKLc8twlpXrYmc9/Ds43b70ycUB1OVaQP0?=
 =?us-ascii?Q?2NEhO1s1owDIDYA0jhZcOQgH7LXGP/JK0RPBpqTYl+Sqd6u2rEp1p+d7CR+Q?=
 =?us-ascii?Q?qEfDAvLTMd3mcrNmhJjDObgq6Gyfa0vaW+8NgtVvVgoA274JtAeLw8r0CR+/?=
 =?us-ascii?Q?vxd6i2XiKnHL5c0daD/5QssNEqG1Y7SUr4ekcytNOVS28S1jdJhIj7pLO/co?=
 =?us-ascii?Q?y9Xzd91rKdTUlciuLhukxL7VjUxTb2okw1mxuPwi25HN76cTvZGCrQBYlF6B?=
 =?us-ascii?Q?/azySl8q01ylL0Q2AL0QK1uszFtYeppeyAgbiKHwgwGXbKWbiisyA5goVZ3E?=
 =?us-ascii?Q?7SrEgVAuTCSGMVQ3i2JyYmiSovLPyFJx1xt/dtBjeQUFGCbVqaOUaGZbVhcx?=
 =?us-ascii?Q?GMAHA9t/iJfm8cHAzNMtTbQgd1LXzL9RidRbVLsxjlYqc5ZOVbEsy5H/x7A5?=
 =?us-ascii?Q?YrnbwD5YcX8p/xqXkSKxRyVzvoXDrqGj6veOdjD4TBPdCu/satFvm789UAUr?=
 =?us-ascii?Q?OHYK7MuJNJWBfPsYDUPXKWlTqmpetB03HVu/++MmEflXoqgiFYZf7skXFgPr?=
 =?us-ascii?Q?gPWKNYwOd1j1OFZGcJ5UKz/v5fQFTmEMU+WWcpX1htwedcE9NbtNmij+wVP8?=
 =?us-ascii?Q?EMVNk/HKMOlkjfwfEQu/it5Y6p9mhSQhUDMjGjgZjcw1AEUSVWJaWRLP+7oG?=
 =?us-ascii?Q?eTw6+CM6O/BDx8j+ZrYGKB5syFmcCC7Ii1t68Q7MbE686tCYa767yjIKHmih?=
 =?us-ascii?Q?HqrRgicrm4gEng4qMmtVEU+b6EpgecKxgeCnHh3j8tp7fXvGj2U9lqUN0gmT?=
 =?us-ascii?Q?LIRWj0sqO9jD5UqQ+EKgu/3joyD68gsPNhFjMjPFyRw/HS24pTQHcPLkqSJO?=
 =?us-ascii?Q?gTeEQ8pnUF+OznKVZHvlFo1DppZwIbtDeSXXtLSzvGq9dFV3SmWQ1RZ+gCu8?=
 =?us-ascii?Q?NX8sfJlMYggtQ3nwgKcPY1UJU3gB6RIk5xiPYx13ovp3+qE/VcWF687rWhX+?=
 =?us-ascii?Q?XjCOktUqTHjLXsXo+PUL7RgD2oow8tVYvSHAszEK1M3Kw+9MjBX1XJKENvV+?=
 =?us-ascii?Q?b652fReZ4IT3kxfR14MCZXwLks1d9ClR9vJNVkZAcptBfYRUQFw1WdsubQBC?=
 =?us-ascii?Q?aatEoxjefBBoKhPu2P0uQHXhX4X+yOr8NCiZcJh8ZWHK5y2DdY76+Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WF3z3/iTcxNfDK+FjrLg+z3b63Dsyd2WCnd6b+8E4QlzVGYlSLHIBwMza4cH?=
 =?us-ascii?Q?9GosCzWC/HM8F5m75pNTg2IPwDqYXxPHgxowD9toxRvzgCwd0F/8i/xHN8S9?=
 =?us-ascii?Q?4ZA6FkGxr0YMRhf31g756A154ewPJjukaklaR4aJdnsmaSwiXtMKZqPrN2Yr?=
 =?us-ascii?Q?HnlDDOjiJEcwc76dCedNf5pgkXNZ4APhg5yFqibg9FPa9Xqs+pMIGo0Ih8zi?=
 =?us-ascii?Q?NSpaf9dzHlxNYj5S74PUgJosq8Kbb/t1Om7Zit+smXLvuy136ZkT5+uGRYIA?=
 =?us-ascii?Q?OGCj6fAeKFKTGSCm2hWbBA46gPJCb1Z2XLAwp8+jTyGt6aWG9JnbqAWQovHx?=
 =?us-ascii?Q?vKBxoC/IQ6lQ/YaGmJ/uGtWZbxStzfLpdFxxa83VDp1/SVbcTxeZ9Nu3kzxK?=
 =?us-ascii?Q?rjMdnnHDgl/SMlVrsm06R+66sh1L6tkgu3KLPM8Fx9k+DQd4i2HKOc8CP/CO?=
 =?us-ascii?Q?S9i/YAH1Ih+8H2/NOCf0Wltiq+il4l2K2mDmKpOW/ODCnH7xb3HtBj9xOWGA?=
 =?us-ascii?Q?YPnHJxip+aMnuG/3rq1Z9xmTS3WAAS3ZX4YmAcbSeys0yrjWdPD7XVYumNsO?=
 =?us-ascii?Q?zYl0Ggk8cGC2lHN6Ys/BLUWVi1omnLhlLInXUBECzoX0deTj1KnAcj9v66kg?=
 =?us-ascii?Q?h7cRsPkChjuxniupFfOU5B+5wtrpdvqz60ZDLnMbq3XmRWWNu6iPdGSVZ41Z?=
 =?us-ascii?Q?1aECFTiQhE6NvY1RT1l+esi3VZGdsTFOtIXu8Z/Yj85Y7GRlA+7eyyRvvYFl?=
 =?us-ascii?Q?4nH50Sd13XaUiL+C2BbiGyppauMaBVY2QPoDXGUD5KbhigXKIwotJRhJgsmw?=
 =?us-ascii?Q?1VdVITn49dHl/JLs59PyZFEDkyePFsIUrCxPKtJpIgml9ci8w/eIE7B3Ild+?=
 =?us-ascii?Q?KZwaaxNhTIYyf2kdI4CwjLNZmcfdrKsZ98FbkmpVaKYVz4h5rQ9lx+7iQiXt?=
 =?us-ascii?Q?bP9qBxd9hS7WqqRuGPXqPTwj7VJ3jizAYgZJLjCO32VEFtp1KaPpq6QVK70P?=
 =?us-ascii?Q?qMXpGRmb7wLBfRhkTF5Fn2hZqUkxdXjhkaU5Gk9VKkiWTAUpJ6wQueOCZXdH?=
 =?us-ascii?Q?gZXtt8MkYqGI4uDUyiUkStmKIDh5ZZ5LeQqD7zxjTbMA4yUjHQbd00yhdmzi?=
 =?us-ascii?Q?OUXRlLIoy96J7uldEgXfS7aNf2YLGOSW6q52gs+YhGx9FYgyW/TR4u2qgyl3?=
 =?us-ascii?Q?K8l5LYsfBhchbwF8VcOfyISoxWwpaycywtcNiTC9rDgnezRTxFDtCBULElgS?=
 =?us-ascii?Q?69V0aA7HvJldeT05YBI8+OwMVypgKTdd1CVoIuug5zUO2Spn6lsU2M7Mo02p?=
 =?us-ascii?Q?mF8LjsxKosqxsAAeOjMR6vAxa3L9InvZdCdHsN7KYSaCOP6VmthjwWYYUUYt?=
 =?us-ascii?Q?viNXdHrKewUAZu6CObTHFWUjO1CicNcpqPK7WlSTOtR1WUEDdRayBY6xvOle?=
 =?us-ascii?Q?DN9FbSWUmzb3eqzLrVeac0D1/VMAP5NWJ+DAV4fcdDcMTGATnh7fM+LrC1j6?=
 =?us-ascii?Q?LCBt77bBUmvikPH+G2PDpw46kKEqCE6Hc+MIc6BPHbfGeIiqkmt+/X440my8?=
 =?us-ascii?Q?JIdAmE0h6nG9x50vxmdYKBdU+6hq6QZZ5zQxrx/w?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13545a99-022f-43a5-5dce-08de2b25d0fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 06:50:55.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eq4YH73+wAbJY6m/+ZI1ZpUL2J33Y6KYArzDFuWtelCW1+Usc+pgkYh74e6ckCemDDIthyq2h8om1svj4dv+FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3315
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 06:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20700

On 24.11.25 06:06, Gourav Singh wrote:
> In Debian Trixie, /run/utmp has been removed, so traditional
> session-tracking mechanisms (used by w/who) no longer work.
> To restore secure and correct session accounting (needed for
> enforcing limits like maxlogins to comply with IEC 62443
> CR2.7_1), we can add libpam-systemd.
>=20
> This ensures that PAM can register user sessions with
> systemd-logind, aligning with Debian=E2=80=99s design for Trixie.
> See Debian-devel discussion: "/run/utmp is no longer provided
> in trixie ... replacement mechanism provided by systemd."
>=20
> Ref: https://lists.debian.org/debian-devel/2025/04/msg00011.html
>=20
> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
> ---
>  .../security-customizations/security-customizations.bb         | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/recipes-core/security-customizations/security-customizations=
.bb b/recipes-core/security-customizations/security-customizations.bb
> index 717e2d3..d8fa22b 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -25,6 +25,9 @@ DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, li=
bpam-google-authenticator,
>  # - libpam-passwdqc: Preferred for newer Debian releases (post-Bullseye)=
.
>  DEBIAN_DEPENDS:append =3D ", libpam-passwdqc | libpam-cracklib"
> =20
> +# Append systemd PAM package to limit concurrent sessions in Debian trix=
ie
> +DEBIAN_DEPENDS:append:trixie =3D ", libpam-systemd"
> +

So, no configuration needed? And does this obsolete any other dependency
in trixie?

>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>  do_install () {
>      install -m 600 ${WORKDIR}/ssh-remote-session-term.conf ${D}/etc/ssh/=
sshd_config.d/

Thanks for tracking this down. I suspect that our certification efforts
are still focused on bookworm as baseline, but this is an important step
ahead already. I also hope we can soon switch CI to trixie, currently
waiting on lava-docker updates on the workers.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

