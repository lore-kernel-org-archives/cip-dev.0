Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A30C2BA18
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 11:30:50 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.89])
 by mx.groups.io with SMTP id smtpd.web11.45125.1718883041350439757
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 04:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=AS/m8yVl;
 spf=pass (domain: siemens.com, ip: 40.107.7.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEuEZ68qqJclyK9XG8KY4b+5dj+QrzOEuLh3D31b9oofN/mTbhyYQCQESLVMTPyG5OlgXxNSKtXXA3+1W9xZw7wCGVIkXtObIQUICUMOA59a84gNgrH1Z3JOoRK2CRgmIsT48MZAh/SDgnJrn0TF5qlb5ZhfyAY1EbUutMTLA0vXvmIL8TmMUI2VnEC/K+DMfUcEXnNz0bOPkE6j0iwXw9Ql/DeAKnrCcRpwUG0UhRxlA8E+uMv6Ecp15D+FxySGG5EOviswVdzsxWbnlY8f7AeC3ujQI06Nv3mzI9paQMJHoq+/fOuAjTHv6illls7HlGAwKLVrg/xz99Hffsj9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUR2hlxQXfiMgRDZTcC9yVNCwQiNVDwLXTK6NpYj5I4=;
 b=SJmTZF9S6ZC9ju8Bh0sJoEmMfF7ar7ZXSSVqxnTl+drhxQWS0hA+ij27v8ByfEFLVvt0uw79jos+Xc0Vtn0xdZXj2zy0mBXyE7cDJ5S7snv85L3IJ4LBlDjnxGQ+Fol+pg42YAgAaMXbgzX593JrlzyX7HChwpJ+/1+PJC0BzDpsAZgSDbtzuSvsEV4qQe1ZZqgcdeFQ6P0zjfXsGA9NiOc4gck8ylApUoNVDH9tyQsRVtZTX5JK44mjsjSJDQeqBefvsfcWP3zht4HwBPdGANpRMbfzi1n9+QcbdJZlJe4ICOMT7t49/VoqRR6WkU6Mk04dSaiwIDUDu0laQ8Jtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUR2hlxQXfiMgRDZTcC9yVNCwQiNVDwLXTK6NpYj5I4=;
 b=AS/m8yVlPCXI5nQJA2GA7LDl7Ou6EtmZxiIvnifIWTQ/dZ4Ta9UYw/Nc8azWLEZcsp5NGxlDEVSlmqjS58XaVSlk++w7OeAKnO5c21yDnqojWdHKJkm8wJElZtasGDzZGufg+8yoMPJeSuiSdUsX37X1H32AQIsCn/0ctcL4S1kRycFsYdHbZfOl+HZDxbyCW/zJ4uApPRp43EIPeoJsR2ZHqYCBYVuwUSq82vsMErZkUHhPUnWr6OfVRbigZlVIOT3QFp75gS4sedWW1Galz2SaaEGMPTLEr2SSzgI1jWFSWLzb+l5xv43cmLgwYzx4eklVABHZjHFmVl8ZfQo/0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB8012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 11:30:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 11:30:37 +0000
Message-ID: <561f6fd4-a66f-40a3-adb4-b94eb2c35ce0@siemens.com>
Date: Thu, 20 Jun 2024 13:30:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding support for WFX backend for software updates in CIP
 Images
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, Shivanand.Kunijadar@toshiba-tsip.com,
 Sai.Sathujoda@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Christian Storm <christian.storm@siemens.com>
References: <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d416d0-5bd0-4cbc-6aa1-08dc911c682a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8i0PqmL9LmyfGD6Dqsffk9iHGwrybbWi7OoCpUmh5IH9XFzb6s/NyViGlzP0?=
 =?us-ascii?Q?1hiH7tF6PHE1E1nwhCOEb/Z23tx1Hj31/V735NBu1U0Xi4ROtn18ENUnLDj0?=
 =?us-ascii?Q?ebAjq1O687O57a0x4j8ekGM8sQ7rmL/mlJtCApLIAvJNHVPud8RSSj8vCibt?=
 =?us-ascii?Q?w7JlxhSXY7UazDIGW8DlgkZnGRIW/MlhKHjPZjSox5ycWxTDK9oWL3fYe4rA?=
 =?us-ascii?Q?rJ7cJY/E3uwTRwKFjph0f7AsUpNoGaJhT3DxCc7b2tZZT4udmHOEOnokJlLf?=
 =?us-ascii?Q?s02MpyiyHchZgXvVa+OOXC1xY0naOpZdPe5+u08cYUtSxugnbxbJRP/MGSYV?=
 =?us-ascii?Q?BBi937Ti5s5v0Ut1rWhKQZrtYNGjBXMXvDtMn8uRJu0riMRdAZtrRwYJlCGd?=
 =?us-ascii?Q?OIWvr8cYQNHdHVhLyXV6m0vcwrm8MT8lmOc0bLIUWOJFIRJboAehN717Xeq9?=
 =?us-ascii?Q?u6jNbPJqA6TpbENZa8xgEN1s1jCvEOKIstZLy1clzStYmNvRV0EHRfUgN49k?=
 =?us-ascii?Q?p6l3Y/ZuWissJ6xtTclFK9IGro5Px8l9RQAQ2WTbQNQ3Sdnv/hhrvNNXTdTo?=
 =?us-ascii?Q?36ya5VwF0hWECNqa/r8ky2BgTyTU7WtofkKmjC1FfLMhxejJD8Hj86/MiiCD?=
 =?us-ascii?Q?eaIAYsSdxjvDRr3o72PBoxIuZfsyo8LocVwwVcl9Yc8AX8Ke3BIUpUPfC+z5?=
 =?us-ascii?Q?+11V3gfS9iyr2vZvIn2/pMgHTYoQRfRa7i6LK7D0VJoY2kIxUs4UafW0vgXU?=
 =?us-ascii?Q?3bOxo44XsLadbJRFgHUuwtq+3l9fAI8l5PgS0J3t3g5UDUCAVZNRIDoxal/8?=
 =?us-ascii?Q?17KCVOuCbBMjM75//RPEFLsaXLp9C+2PvQANDUpcSdzpDIgPjMUA81Jq5+B3?=
 =?us-ascii?Q?CM6dTAlmd9SaBvAZMl024gH0v6/nYthes+b0BySuV6e4POy4N6WPmY0keJ2e?=
 =?us-ascii?Q?xuK9GccExS8teNR3h1yDLxO/q43uFP2ST4wbJBhhCf6kz9n1/tXzEuRilv9L?=
 =?us-ascii?Q?D057Xa3oFqy+G4VL4UruScBZk+mQ9kfDhz7dvNACDdAsyUcC4xyFO/iW8SmA?=
 =?us-ascii?Q?pQ46Boh9SdL0slsn6xzps0JCbFu/K9tPe7WO4TSeja6g5E+zEs+2TnbpuCR0?=
 =?us-ascii?Q?5SQ4xNHjQKzLYhVFHiBpDHZzSzhMrq7EG20A6CSs2pyzVJXNAkC02eYDmF4i?=
 =?us-ascii?Q?qzowtVHKTWxnk4zUXW6lFIl/JSTB5DfFW6G9SCD1wozSJUCrfP6HTwnxus/r?=
 =?us-ascii?Q?sTc0hWr5DLgyaePa39UgiYikku3JZVdRA+laAb7lnuZTcnBwoq8qDdvwBIqs?=
 =?us-ascii?Q?W4cYRirY4L43dkpdfenvQkN3?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RjA8PSBF42+vPMveXvJ345oS89ptCR4DLMpJs3/6KQsOMIq9DNHQsXegS5YT?=
 =?us-ascii?Q?NpDtbVOjAfa+k14Y0x7wf9aa3o0/wcO70VNpFZDbFQXmNSdHRJkxv6zZtsP0?=
 =?us-ascii?Q?4Gd5NlxC9qalj1xREvJvV6LcFsI0xo0moYJ6peuo6Lbi+6nQ6KP9EDq67Wkq?=
 =?us-ascii?Q?Kmg5ebtpOniOu47U7M0c0AnwlcNaXoUPySG4wBeIdJ4jgCfDVkTooWERV2NA?=
 =?us-ascii?Q?REMZtUDrjXrStUnmKbEPMdTW2Ox+949rBdNYiwKE5TP4PtcSw6VFTqCufiK7?=
 =?us-ascii?Q?19jBE6nuk/7CAvPFRB7Gd71h9nTRmc8T0mhTFfc+zFKHJtqb7Oc10N/kSPFU?=
 =?us-ascii?Q?UVdOGjn7E4LZEMKmQ5JWqU6EmdpjRmUaCpTWLWCXmB/mkMnTWTVDNC88l2MB?=
 =?us-ascii?Q?0GVLoITwlykAwIJdTT/Yp7xUlYG0aTNNWyx5K7f/9XzwECtMygpwv3xPq7yv?=
 =?us-ascii?Q?2jUmr8KsbZrZG8Zc/5wgWnX7C786jpV4aBDRxE7/Eyl6Rvdhkh+p5L7LYTeh?=
 =?us-ascii?Q?g9sUyaVNbO2w3tTW4nr/P4UadaIeO+QjJfT+/Q7FayvNhTtYLuKBXcadwF0u?=
 =?us-ascii?Q?tNkGwyuHSxWZRQLDr6lyIW+LWC42+V4V82geoxYsufi8jUbt/JbhuCCzYbW7?=
 =?us-ascii?Q?fCcvJwgMe2Y/spxSYY0SU1iHssusTB7uZY4H2UlqWcWQaVUVA5RVlJTgzVcj?=
 =?us-ascii?Q?9mIAvLbjCP4NT6FxafJSM8XxeNN5+bZLAxqP7ysyUhh7RxnhU5Shm7+Y/Eap?=
 =?us-ascii?Q?uuX22q30rE/DZP4xqqiSnO1k2VYICYa7CYUO6Ss+gqsUvoVUMzHxJx85KD3d?=
 =?us-ascii?Q?kcErqURY7tMT1UH6T7ZjSn9WG2YJRKAn2qTGKC4XFdrlFaRoz3nuKsGj4S2v?=
 =?us-ascii?Q?XYT99pp/0znOLayDIyfynenvYSLbL3LQ28GSjomzZZSntGLOy8M+1Z5mkYKw?=
 =?us-ascii?Q?g+GoA25BbkW2e/835xB/07+twn96Y9GduqCTWOTetg6H9QWhFJbr6ObBrDYV?=
 =?us-ascii?Q?uXwPebQUL906CTQMN2rWaxYApJq7iHRl1lcjfK18ctgcjso8bXuz8x9RrLv1?=
 =?us-ascii?Q?4K1ctDTE873AEm/lbRn1V+o1tRkPZ4HWo1AQvPdUMdfxRdfWS3uOhvNKeSyw?=
 =?us-ascii?Q?f6MYoxBHPbNhA7AbMkR4RF6we0Ue1n93ZsnqNbmPqhZsqxxIEaluyDYYMrwZ?=
 =?us-ascii?Q?jkuHkKxRKDlsqbfTX3xFVQfqojk4Dqd5G8AUalayU0j/Q7R62p/FqsfUjN+7?=
 =?us-ascii?Q?dJiSNwSePkV0I1qm/PLkIOFc6Bd46kBr06xdhvLPz/GDwEWCVOr2i/6IAUnN?=
 =?us-ascii?Q?PIjvW6XxLIHZZXvtJSaCnQv0Q2AvHgx00sV1DHzSznQ3cTe/XAPYhTXsvOqV?=
 =?us-ascii?Q?oCwIKoT6Tu24aB53egRoZ3Ht498hV+c9OSirsuNDQQEHIfXewhFkBWZNb4LR?=
 =?us-ascii?Q?QzA4HfsKcoE865sUSqStfygp7J0xzCuk6yrgyBJidHv4/c/Z2WFQld9F6x8i?=
 =?us-ascii?Q?rMIjYkOqYUmswmIIXaB4PA8NdYQkJfUgwZ7Mz1BsNLit0KhDchcq4oZ7cHKB?=
 =?us-ascii?Q?X7X9sY7G7YJpAldc8LZI5th//+S0/TbDmlD4RQB8lgvtNZMhl8/PceSQm5sq?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d416d0-5bd0-4cbc-6aa1-08dc911c682a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 11:30:37.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ASSpD7P53IUpjJqYAdTds5jXOBcNr8Cab5AVAGlD5qYR4Y3ewUD8ug6l2ILtWehvmEHL4OXQaqm2pDrWNGcCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB8012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 11:30:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16304

On 20.06.24 07:56, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi All,
>=20
> This is regarding support for WFX backend for software updates in CIP
> Images. I am writing to understand the opinions of the community on how
> to go about with the integration of WFX support.
>=20
> As I understand there are 2 parts to the WFX integration:
> 1. Hosting the WFX server.
> 2. Suricatta configuration in the CIP Images via the swupdate.cfg for
> communication with WFX server.
>=20
> As from the device side, communication with the WFX server is already
> supported by SWUpdate through the server_wfx.lua module. See [1].
> However the necessary suricatta configs in the swupdate.cfg file are
> required to be set which is currently missing from image recipes.=C2=A0
>=20
> Based on CIP Core work group meetings, I understand that there is
> already a plan to host a WFX server for CIP related purposes. While that
> is still in the works, would it be alright to update recipes to include
> the necessary configs needed for WFX support or wait for the server side
> to be completed?
>=20
> Until the planned WFX server setup is completed, how about including
> details of setting up a WFX server and other details for minimal
> verification in a README file?
>=20
> Would like to understand the opinions of the maintainer and the rest of
> the community on such an approach and also other ideas on how to go
> about with this integration?
>=20

What all needs to go into that config file? Just the backend address or
more? We could make that a kconfig variable so that users could enter
that value before building an image (and later on default the address to
wfx.cip-project.org or so).

Jan

--=20
Siemens AG, Technology
Linux Expert Center


