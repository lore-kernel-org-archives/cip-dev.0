Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0FBC36011
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 19:24:48 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.2])
 by mx.groups.io with SMTP id smtpd.web11.5006.1743103482912826041
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 12:24:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jOtKr2/H;
 spf=pass (domain: siemens.com, ip: 52.101.70.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSf0aUxkh49ln9Aw8VbbQQV4kAF9QYdkaqvgzs5FylqVVTEqte8WOjgQ/E5jwYv9d/YY8MqHdRs/ScrqGtDts8DeSJnGjI+HE2kAHQfZ5GiE4TXffxGny16vMVw7NjriYiCSHTQCRgk4Pz5+VLARCE7Evex9c/vez9jHPj+6iXriNQhWk4DRL8VbmQGcuiltfDeSLL1V+ydRp5ya4cgSxdpCXpzSbAbubADQ20I0JFW4kVuQChvl6S1/Bk/9mY1r4MFcLDSviOqlRQE6XYGkBi2x0vz1K9uzQzMtBT0CN5xSl+G1ArH1yodzRBKV50vE81O0xXHH1Mzj5xtwLbovpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzt5S3l+UTt79VbpzmvXN7nFK7rech7FvKArBRR+bIQ=;
 b=bxBgmPur72SiXdi2naDYrAAU2YqdqEq9TaiETOpii3SwNfKvgKWQGGOHixyUrBd7F4Rkjzve7d5Ir+wwtVYhaTltUp2fJXD3whp7kcZ7mmV0XlDN9pH1aLg5uutPMUZkuc4vqfm9Jyw0L/hM/rD/klxYiBGE4oxzxjgaatotN+xaoMsXPY0lENEgq7SAgyFY/EkhaJIT4h/6wgQeMI0zr8VfZp6Qj+eYHYaQevizYh28qNlE/FIrT5EJ2xCpFYi6IyQNHdheDGASKiTLrGwNJv2eBjG+aGw0zdRyf+27s3tQV9OY63qrAnCKIHu2Rcz6qKrDfCFPCMLcl4X1Uukpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzt5S3l+UTt79VbpzmvXN7nFK7rech7FvKArBRR+bIQ=;
 b=jOtKr2/HtD3NZapSEg8OialowXtQe7QRmurDtqDRjTEW35Jy7HVcfWJubsz/JvzAVwP2ClcS7PEkxlhJHho07Tw+GWThhaNjb1BQQQ9LdNLGAqNXcEwvH11Y7tnXKyvw25Dqxddruc4KULtvjiUs0tRvUoz9QzvV0S9rvPy/cWbx3Nj+AN8ZtlmJCohuoxDz23PKFmPreWAyUBB26KESaTRzAV6r2smU8nziBO9GSEPdPWc8eVXr0shwQ9nJ3xAObkwxFfnHTiWwI2HVGxOCHuqRZ/i158v2lMyDQbAbfqD62G/ydE5luWNprjqb39qak4AUjqj/CS0YQzny28GzKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB3472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 19:24:39 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 19:24:39 +0000
Message-ID: <6c5e6f7b-0d70-4b91-a9e7-7d80f8c17135@siemens.com>
Date: Thu, 27 Mar 2025 20:24:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core] IEC_template.yml: Update IEC tests to
 latest revision
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250327093358.3419546-1-Sai.Sathujoda@toshiba-tsip.com>
 <f04f10cb-7df9-4308-9cd1-b77e6bb6ce7b@siemens.com>
 <c7b75f1c-7ed0-4375-bef7-29347a3613e1@siemens.com>
 <OSCPR01MB148384ED75CCF2281745233E5C2A12@OSCPR01MB14838.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSCPR01MB148384ED75CCF2281745233E5C2A12@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB3472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c61afa3-c7b3-4f6d-e679-08dd6d65045f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PRK1jAEjWL6K7hP9I2cWSS3L5tOV7xWfTeUGb3yT6nCO1rJi+64skgXmaano?=
 =?us-ascii?Q?vkBHn3jvN34ktwmzONwWsnTIGSNT2z/EL1K5q+SG8ZjGLnhLTFUsMJR9P0mQ?=
 =?us-ascii?Q?oUkJmE7Qg3H6qRzTBu6L0kD8enaznLO/nG6rTFa92MkkVpvcij4BfcheB7n+?=
 =?us-ascii?Q?gBMnhof/iHC9oTo2TGsWdXPhH4UGO30Ru4IHSsTJQFGHrvhu255OilkOmcfc?=
 =?us-ascii?Q?saG/1W5gvz7/mzfuWOuEjwaLQFFpn2l86fvtKFtJfhLTD9u9njKA89nK/eN9?=
 =?us-ascii?Q?ke2beEDNk0hyYOu5M86jhzUq2RTo6tk/R0Uv8YQAkFrT2gj3XUfqINdBNgSX?=
 =?us-ascii?Q?PwgGOE6J7UYnl1onOVdBCJZdlYh1IixRx9CBDCvwDuiyU1xithX3iSLqeneX?=
 =?us-ascii?Q?2FPR2O7MFtKTCZXWIvSLdiN4eBJzQVoDLjtQjd1+wnhlNGqtG9ZzLMj2GnbA?=
 =?us-ascii?Q?obGO5dZQfT/E+/UL2gsexRgqDE56Z60P17d6P8bcNZDD7goCUfe5pADwa/Mr?=
 =?us-ascii?Q?BHrkXHIarZ9tHeHju3mfe/ZXoXKp+z2Ppy3SmLOviamPpNOrZ2Ip5ZSDH5Bx?=
 =?us-ascii?Q?I5XI+AdWH2QpTaBAKasItAIVGXtHgzSTmq1yX9ImBUyNVpyfSplsRJEIEc51?=
 =?us-ascii?Q?ner2Osm8SGqNRHQtAuhnGL2ZxoNgdqFHBmwc/nhHNzdx8p367sOCmj4O/sj/?=
 =?us-ascii?Q?2DBAPqAyxIUiXbWTwIBGnh9HV/zEu7Qe9+q9CnJ9XhBhOFKYa+yfNEkJubPx?=
 =?us-ascii?Q?GUN8HisFh8wB0bol7YJ/fUDDipsNQ1Go5WQkz8tgCxCst5X65u1lKowgUIF5?=
 =?us-ascii?Q?MHWVjAd3KCX6Ci5yQkLzR8mobx5wv8DAcUpXVgrEdfjtfrhzvUC8paNamu9P?=
 =?us-ascii?Q?Syg644rvMLsX/b/DTGLscrQzocHH1ZcO6zoT4Tnt3FKTKe68FyNKE915Ev9p?=
 =?us-ascii?Q?pujlZDFC04XuTKnTVVwL8jhC4ewCRE2Mpfxr2lED4W2YREJJNviQd2PMVKVY?=
 =?us-ascii?Q?kUTq0IrA4flVG6m9pNpdMA4C0Vp2CJXuRTFgMhYGZ3JYbk4vKWZ8+/GUe9vs?=
 =?us-ascii?Q?C10bpSeR/+kAcoDgae2VFJgmStqcytliKjVG+fEzWW48xBdvf9UpIRH/PiuF?=
 =?us-ascii?Q?PvCEFNAROwVYH0efDbSQzRMLY5PukIaYpfikmuBl3dN4ecMSN80g6fNeRyPV?=
 =?us-ascii?Q?OFdr3e/avcXZ4MInoczyKR45HmVVXYmd3vfnLUIjwWNme1AUTfj3E/inaeN9?=
 =?us-ascii?Q?oOfQNcvInB+wnnsc0yXCbRiZX6Hpf93APUv0NZgFCQALOYp0owvKn2DXYmf3?=
 =?us-ascii?Q?AEJwRIpIA/s6cjotsQvu4NXfu/9Hz5PKKnVlr6iQg+S1OEMfJ9gMWVs3VKB6?=
 =?us-ascii?Q?AAvTGxHDVwWyiwqP6CTUbnDRTISW?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0n3Rgq+CiCo8fVOGdNA2QAx96BITx3MFvk/sTnj0LtJrVUJp3XrWHvL89NNB?=
 =?us-ascii?Q?AsB0PDPCt2bG0s8TnvPI/j3ktnL5/xavQ0IyUIti3j6sA6RO3sM+we3rHXZA?=
 =?us-ascii?Q?omwkg9tLU19mO/UwIzxR67Gfm5guEQiOdqLzoFnCuhfTJ4K3LWWs4AuQSgdj?=
 =?us-ascii?Q?dO1QjRS76cYDjmQzWNgy2Ol7fia2ztrTvNTkcyvckrYWdF+E5QPNEQ/LOw8L?=
 =?us-ascii?Q?Quv0wMyumrmmd/XnrVIfX2H26Lc1LrU0qmHz9g7ozzlaiQATUUXCZcccXi2B?=
 =?us-ascii?Q?4veKn1KNKYgMCU2FjTV833Nbkus925E/Yu3WI+B3lDklcE8UobB48CHvr2Nk?=
 =?us-ascii?Q?r4jyqOBz1MPHFIpZlrvAgr+ZuaLBB/9azzZpw3QXFuCXHXZikzy1ocvNQzGo?=
 =?us-ascii?Q?I44INPxDhaY4FGrDVIFX2O2iNezskuW1vg+UqkYtp1zLyYmHzFoUqe1iOXG4?=
 =?us-ascii?Q?PYVCfd/NdspsNFJKCJ6qbO1k+rk0D8+J6WBwPPL2Au72zyKpC9epXl63kf6D?=
 =?us-ascii?Q?EFqSkBjmhm6M+CZ0DM/3NStJ8fF8r32bB/a48GzU91HrGemJkPvEOlP7TaZZ?=
 =?us-ascii?Q?4wWyrOR9zfVd7+0fsStY3RCnzax8BDgeDIT1jamnnow1eiVRnOL7LDUUv0Nc?=
 =?us-ascii?Q?gsMgCvSzq41NTkyJppylbTAPyupA9SOt6yAoMqtJRghOPNt86Vilvf4XiH2e?=
 =?us-ascii?Q?q7IrRHuCJZ8YXa5t4Mx7GxvF2I2f1hHZVQ1zZvgFe0m76p+LCm5BIq5fyCIO?=
 =?us-ascii?Q?El3GIZ9CjfzddoAQ/WIlRGxeExK1oryWEmch8V8xADRRykic8seua4DuW5MY?=
 =?us-ascii?Q?K6A3xdWBRywlb8E6/4Fxb+w6g634Pt1+3CQN84V2fXI0S/Bmb+U3EarXTtRo?=
 =?us-ascii?Q?FcajtyPQpO4aEp8q/gH29YOYKHKb/Ubk9oOQuZKnPYIRostl6tWaPpaJYtDT?=
 =?us-ascii?Q?PnV/M4e4Cit5bDffaWpEWzKI+tHr3KtiFApWaH27w4U/j/FeY6gKeYwGWbMa?=
 =?us-ascii?Q?zVi2yy9b643M7+vXr3UzjONkGtGvn6mEZAnhjKcUrtQgr5o3nVSZtkHA57g8?=
 =?us-ascii?Q?ijhl+1rYpRO7BkK+pjq2ZOP8UyPCxZiNcL7q9nVHlqwlG5Xfil7amiOuSLD5?=
 =?us-ascii?Q?FC7w0ig7QRHnH+gh8nMhv6FRxAtr3IsZccknQPd71qkL3bBBmpYUY/saX4sb?=
 =?us-ascii?Q?btPuOh+RFJq/xiZZ70gxRsRm76y+DXnYe4cow2W4bziydy0OS95jj4zas4Nk?=
 =?us-ascii?Q?rAMrUJUHWWSAP5ZnIZvPN5nbdWK0YYR7koHC+BHsIn0Rtz8N5R6WnvnfUiZs?=
 =?us-ascii?Q?2brkfhiIJ+KVM+d2l0h7rmHjw95wAjmI7fhYBwZuC9v7fqk13ZGtzKxxL4CH?=
 =?us-ascii?Q?t/kpG4k/xi7s9L8yPMPGKmCA9BFRSCzqRLZDkMfL5h99L4De0Y24b8J7PhLW?=
 =?us-ascii?Q?sEb2d0FyQJnpnjsdPxZ3flgrXFjTXHghoOzgzV3WnIG9jscQZJj32UldFdPX?=
 =?us-ascii?Q?adRrBFSMA6bvpXQw8uD84gdxRWFwaIHmnCCUwsPSD5f8dI8Ksn90u0ciaF+e?=
 =?us-ascii?Q?fra2Ludffw88bpDwG8KOGfgMXH54e02e2ss6GC7f?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c61afa3-c7b3-4f6d-e679-08dd6d65045f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 19:24:39.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dchmgu5OTenY9bZLe2OmKkLvYdpWEW5R0nu9MiaWPlXvqH90rOooq+2W+a6Wrw2aTmEDDBWp14JY83T/XpN9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3472
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 19:24:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18382

On 27.03.25 18:44, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> This was neither an issue with the tests nor a problem=C2=A0with the imag=
e.
> The tests ran very slow that the overall time allotted (40 minutes) to
> run all the tests was crossed while it was still at 1.9_5.
>=20
> That is the why the error is lave-test-shell timeout after 2400 seconds.

Ah, missed that. Your retry made it pass now, that's great. Let's see if
I can finalize the release soon.

Jan

>=20
> Thanks and regards,
> Sai Ashrith
>=20
>=20
> ------------------------------------------------------------------------
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on
> behalf of Jan Kiszka via lists.cip-project.org
> <jan.kiszka=3Dsiemens.com@lists.cip-project.org>
> *Sent:* Thursday, March 27, 2025 9:57 PM
> *To:* ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <Sai=
.Sathujoda@toshiba-
> tsip.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> *Cc:* dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <di=
nesh.kumar@toshiba-
> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
> <kazuhiro3.hayashi@toshiba.co.jp>
> *Subject:* Re: [cip-dev] [isar-cip-core] IEC_template.yml: Update IEC
> tests to latest revision
> =C2=A0
> On 27.03.25 12:32, Jan Kiszka wrote:
>> On 27.03.25 10:33, Sai.Sathujoda@toshiba-tsip.com wrote:
>>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>>
>>> Major changes in this revision update:
>>>
>>> 1. Skip TC_CR2.7_1 until it is redesigned to remove dependencies on sta=
tic time delays.
>>> 2. Improve tests to include testing of new IEC-62443-4-2 sub-requiremen=
ts.
>>> 3. Fail the job if any failed test cases are found in final summary.
>>>
>>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>> ---
>>>=C2=A0 tests/templates/IEC_template.yml | 2 +-
>>>=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_tem=
plate.yml
>>> index 3c33773..92944da 100644
>>> --- a/tests/templates/IEC_template.yml
>>> +++ b/tests/templates/IEC_template.yml
>>> @@ -64,7 +64,7 @@ actions:
>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 definitions:
>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - repository: https://gitlab.com/ci=
p-project/cip-testing/cip-security-tests.git
> <https://gitlab.com/cip-project/cip-testing/cip-security-tests.git>
>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from: git
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 revision: 064a92b98127b0001ca527a=
83b175521bea4b626
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 revision: 5dbc47f55d4a43449dcbde4=
363e5d23d6e96344f
>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: iec-security-test=
s/Singlenode-TestDefinition.yaml
>>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: Security-Testcase=
s
>>>=C2=A0=20
>>=20
>> Thanks, applied. Let's watch the pipeline:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> pipelines/1738025966 <https://gitlab.com/cip-project/cip-core/isar-cip-
> core/-/pipelines/1738025966>
>> :)
>=20
> 2025-03-27T15:03:09 INFO: user: 'user3' created successfully
> 2025-03-27T15:03:09
> 2025-03-27T15:03:09 runTest: TC_CR1.9_5: Strength of public key-based
> authentication - map authenticated identity to a user
> 2025-03-27T15:04:46 Marking unfinished test run as failed
>=20
> Please have a look.
>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

