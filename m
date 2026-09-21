Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE243C982DE
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 05:29:44 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42816.1789968575765798712
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Sep 2026 22:29:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dw0mFsSd;
 spf=pass (domain: siemens.com, ip: 52.101.72.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZhVHUwVGNCO59utr4lAZ5DbA2CRpbkX4FOv0tFJJd20uyqmOqOW3DvquWKJQo0U3M/DobcYT34QU24eAT5RvFTTbWTbnCOcICHoH/sMebj2tcrDfu6HDeGlTg+CZ25via5vgmcxBFzleLXV4UIki4yfiyR8k1R6uu1xJ2W0UMN8lqEvFz217rc48tSk34iJ1QEFt6DmIowqk6OGqYUJ1qHbiVp9QAQIAsjpmmBsHWqxo5FLRphIgi5R7eYzXh6O6r48+ZU/6lbdXJw9r+HKuwBRQ7PKszu38ukzwl/ltF2QIcHWhK6ZZcLwYdVfRS+qhZbgeZVe7qMD16JAYhpfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fd5RUxhL3gm0KdLbe7pv5ehP+J/HC1q1WWhUZWCl5A=;
 b=mYKTWci4oTR0nSq9NfhKSF3qiRQHRrbbJO4FxMKKMPybZllUkA9JaTU7SSJIQOaDkwRpSEH6OCarUF9GcosspYckWI1hH5hnaFbc8ofQFbb6Bny8iywPZeNizfxkg7/pztYr8Df4U+qWTwlcUGzJtBmKuG/ndnv632/FbtxAulj/s9bHoM4907qflTGwje4lIvGXF9V+MBSItCV95ASieMCQJhNc6TG5WTSi5PMwXWjA1AP4WMhxCNvn9hkG9S6SPrRJDypL6cgGeU31hsgy7xo5PJU6Rf1ACVdueBAw4Al7+wpK9vdC54BFSF0duAKSOUFLwkmdIkm/lIE5PQ025A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fd5RUxhL3gm0KdLbe7pv5ehP+J/HC1q1WWhUZWCl5A=;
 b=dw0mFsSdRUObG0Jdz3xKkSB+Vah9vwgbIWh3gJzQh/29k2ElS1QogGF0FOVFjwAVNnnfimDCAgMz9+EeOnkWMiqvGIfqhcoQw4s4RJbTuHiVzcIriQflzojqZSBRYoMwUI+Dds4l0JzUWJH/pruEwUo2ymb4WGlwJqQLf1uLNqHbn2NqP1YIIhBXmXI+DBfrzMW7zRRD0q1wYfPxzYPZ4gdqe4JBLi+K7OjnuDrWfhRPVSg71+PJgN9HP9hL+emfe5ViSKMmesyeaOwiLYVndAE9hRJQx8bDooXTMxbG6KW0jNraH0iY/F7oF1R9mEa7zMWrUtkyRxiVd4HaOMnstA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:29:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:29:33 +0000
Message-ID: <be8e94d0-45da-4f96-b60e-20b45c9f865c@siemens.com>
Date: Mon, 21 Sep 2026 07:29:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [6.12.y-cip][PATCH v2] Add SECURITY.md for the CIP kernel
Content-Language: en-US
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf63d53-9533-457b-e93c-08df17a15125
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|3023799007|10067099003|6133799003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	B0QquPlAhkXbp5mKA2yFkAb0Xo0/CDtsfgas0HmldeMluer4aa1JtBGuOZTGpd6wCLppF6bhgO5gyr299+eHnEcQ55kz2Mjb0A3yRMGoBmcmbSZO7BVgoeR/kRygt8yMcN8WcDgMT085huXo6VsEng3u2ToX3P6I4g8WeoIHOtvixpFP14+ZmiFLbcl1yg3QaKPZLWr6hNK0VuujRkW6r42+yIfIYhg/3dvmqI1uUzD3Z5y7AjfOZPyhMh4PEEYQTla/FVRmUTFdHsaDjMzXmdvv40GKjGkEuB3Gc46TuAjbDaCs27DFHCbaaYdpUsbTpxC11I72NZuXqcc6omQC0T/9l8xEr0iluCDeR3Mu7jJIckATJvOMla39gz2/mDYXPM3RDkSyyvhFz9dxdbkUkE01E4Ow3xEBuwrUa93Jp3a6QkD/QoXl7YNQF7AnAtxqICM6Wa0GijqLSAD8bOvG1r+rUoc8D0TTweeNepY3cxdWcAsQd83UaRlM+46UiUO0hVRGYoINL9vDLl/BRo1mFqOaGfYERPtFpR9dp19bSsaGcBJhRdXmeqessZjyVv2ADy9PZ2uz/agTP0V1xjI4LtDchZvxwH0FHbjghPp/Jria+XtQlCG48Yda3eLAq+mh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XxbXxT219eTaZXf73olDE/4Dr7xPfkWv5q7lnfwdvKAnebxL6r6JNopuuymU?=
 =?us-ascii?Q?qm8HtnPQ8JtM7gdMUjO1jPnKeTUOPutOrMEObiKfw/sUxV6R7semWLSZ6/l0?=
 =?us-ascii?Q?2K9wJMybr+yh+bDhL7HbCPaDH829LB7172DYHoh2dYI0G4J9WwxLAkYeoSIk?=
 =?us-ascii?Q?61cUoPnCMctJUaYksCw/AS6XNEX1Z0rv5Og+fxLtZrC0u3rLdh8pCfldLWno?=
 =?us-ascii?Q?tm21ZELn0LbrF8fT0LZpussgngSMyXGvfGhr1dFXIDnACz6LtVdpwnjC4RLS?=
 =?us-ascii?Q?kMhAnceYTMMZQ54O41hJQ2NZ0HDk3CkkCJgGYdZxnL9PL99kYjXuw1cyeEJ7?=
 =?us-ascii?Q?f4jOPyGF6PITY5Y1N8g09pjNx+2QwNv8q4vMol5DFcdCSpGE9v5HZs+oQUU0?=
 =?us-ascii?Q?mGRIglcjYP33NDjbZXk62H0RBUTwAO4bztLCrtZ3yY7z14aXaQsVTUGZFvfp?=
 =?us-ascii?Q?rKVVGLMcKLjYTPxZEeJObn1CwUeNNwKXhwJOiG1Sb1lzuVLLWA/rHU7dW3Wb?=
 =?us-ascii?Q?QnjWkS2Zs4y9wGjKs5S7Mee1o13Ol6LtqAWEmQOaRhDEACvNoan1oI51u83F?=
 =?us-ascii?Q?SwM/YXe2soRzG+9pEOYO+SOzqV6z6/zbNKhMI2k1XDYRDOOiJtzr0VHRkzjS?=
 =?us-ascii?Q?1J3t+UqXfZgP8+hqrv0JoUdN2UuN+OAJBmA4xinQB8vWZ2LvZhQAOVWJAhni?=
 =?us-ascii?Q?Ba0PUvDYeNkixyt/e02uF9DAu4mNQCyvGOi03wheNbMAXXnKFAmXNmTsaUis?=
 =?us-ascii?Q?LX2DGk/3ZJwISa4JZsaBZqiNwbFsO0IKz9aMGRztUL0my3YGCmPFpIhUXFl0?=
 =?us-ascii?Q?48HONLf3RKmznuCD4gifxUivdyxvEWOO4cE4kZdn798fhhT49LXBiMUEQKvr?=
 =?us-ascii?Q?H/0fQe1Dnct1yuJC0fRLthMmXigoaoNR1tTL7Ni17rDFnVX+J1SUFmHjmq52?=
 =?us-ascii?Q?x6ntTibcfnTjXgtUI0ub+HEpee09OpHpMtr6vmHjiy5b8yh9srP+jOm3Xxqw?=
 =?us-ascii?Q?82NKQF1EY6HfUiF2b34r4oTkEhhhJCrxvDUtLTsth3bsGwCmoA+CqyNy/Y+g?=
 =?us-ascii?Q?rzQEAhC8GgsFnozK6mbws0AuUHfQlhViTRMR4TBb/0e/IM6iKvYDVrrBXBv5?=
 =?us-ascii?Q?kB6giG5jITl0Kjkk+AMaBmUlGL9dpD2Xcbz1yuF1bqllcIHSdgCXeb9EeoRg?=
 =?us-ascii?Q?lUQ+/UNJsd7abTfe76ZKYCoY8533neez7EvbtrIfiRRQFobZeB94CCRl6ImF?=
 =?us-ascii?Q?oY23u7Ol88QrZ9SUTzmVqPuMyDSoZ7MXWyyGOwSxxQFdM10L5W3QJpvM1BK9?=
 =?us-ascii?Q?Xy7CcVUB/6DYN0RLBdmsnP8wKvHa4nKjivCmdesmr/m9/HvqlgQoos+IbEHl?=
 =?us-ascii?Q?Fn8MFgjhdupjfpJvrUqR5k+7nRWWUj6ZUD+q3bq6lt7Myk1badDqhRp+ua4H?=
 =?us-ascii?Q?YkIty4PnhKbrUJDbHcrozz9ev+W8RRrviqnux7TuwiKlbBWsJ1yYnr19faG6?=
 =?us-ascii?Q?ukAvIVVf3DK69/dp4mdrP9A1IUQtpDRJoo7NNy+LAJ86Jxn/b0sfLpsOaqQw?=
 =?us-ascii?Q?Ldi5bkXqROfxd+C0Prk21/rV9HM7YBdHMr4XbSNtZhQqzb3eK8+wzP4cd5tI?=
 =?us-ascii?Q?jr4bglJyr3Vo/1A5DqVGAXcsFv8/MRf9Gy9pjofBdSfGNMrfIEBoHhb/8mVT?=
 =?us-ascii?Q?OuGqxlwmpDK58kqm8fef+p6mFV9pc/IHRDsdCT9MEHzSpWf83wwrG3UtK9/g?=
 =?us-ascii?Q?Yk6iLHZUmg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf63d53-9533-457b-e93c-08df17a15125
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:29:32.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdDyUH54WJxrh5kBUxX/vBc90/a1oewkg7GWcSeRqWtQhitBhu/YJcPvIWpd2RMdbFaMKzEm5RhMSKOF87kKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9167
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 05:29:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24249

From: Jan Kiszka <jan.kiszka@siemens.com>

This describes at which time which ares of the CIP kernel are handled by
the CIP security team and how to report vulnerabilities to it. It
furthermore state the this projects falls under the LF stewardship
framework.

As the original kernel documentation already contains a reporting guide,
leave a note there which one applies to CIP kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - leave a note in security-bugs.rst (will need adjustment for older=20
   kernels)

 Documentation/process/security-bugs.rst |  6 ++++
 SECURITY.md                             | 37 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/Documentation/process/security-bugs.rst b/Documentation/proces=
s/security-bugs.rst
index 56c560a00b37a..7b38c83d932d6 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -3,6 +3,12 @@
 Security bugs
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+.. note::
+
+   If you identified a vulnerability that only affects a CIP kernel, pleas=
e
+   instead follow the reporting process described in SECURITY.md that can =
be
+   found in the top-level directory.
+
 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.  Please report security bugs to the
diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 0000000000000..f39a0178338ee
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,37 @@
+# Security Policy
+
+This project is supported under the Linux Foundation CRA stewardship frame=
work,
+as described at https://www.linuxfoundation.org/security. Security
+vulnerabilities should be reported through the mechanisms described below,
+which we will coordinate with our CRA steward. For actively exploited
+vulnerabilities and severe incidents that may require CRA escalation, plea=
se
+use the project=E2=80=99s emergency security reporting mechanisms as appro=
priate.
+
+## Security Context
+
+Open source software can be used in various contexts that may go far beyon=
d
+what it was originally designed and also secured for. Therefore, we descri=
be
+here what the CIP kernel maintenance is particularly covering and what is =
out
+of scope.
+
+Unlike the upstream kernel, the CIP kernel is maintained with the focus on
+architectures and configurations defined by the CIP project members, see
+https://gitlab.com/cip-project/cip-kernel/cip-kernel-config. Vulnerabiliti=
es
+found in code paths not covered this way are considered out of scope.
+Furthermore, vulnerabilities that are affecting the upstream Linux kernel =
as
+well are in the responsibility of the kernel security team, see
+https://www.kernel.org/doc/html/latest/process/security-bugs.html. In scop=
e for
+the CIP kernel are issues caused by patches not found in the corresponding
+stable kernel (linux-6.12.y-cip vs. linux-6.12.y) or that are related to
+missing backports after the corresponding stable kernel went end-of-life.
+
+## Reporting a Vulnerability
+
+Please DO NOT report any potential security vulnerability via a public cha=
nnel
+(mailing list, gitlab issue etc.). Instead, contact the CIP security team =
via
+security@cip-project.org via email. Please provide a detailed description =
of
+the issue, the steps to reproduce it, the affected versions and, if alread=
y
+available, a proposal for a fix. You should receive a response within 5 wo=
rking
+days. If the issue is confirmed as a vulnerability by us, we will request =
a
+CVE, publish the fix and give credits for your report if desired. This pro=
ject
+follows a 90 day disclosure timeline.
--=20
2.47.3

