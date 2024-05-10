Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052BC25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 14:41:53 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.48])
 by mx.groups.io with SMTP id smtpd.web10.14645.1715352113003344423
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 07:41:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Jc3urmbw;
 spf=pass (domain: siemens.com, ip: 40.107.22.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvHluVmTFvjw6bFRIHEPJSyo7CKpNR2h+6RCh+dxzSMC1wZrUmCHHMdfua79z5Ydv7H0bBrUt8yRo5bCKA1fRzjj+4V4G5y2+mhi2esVn5u8yEwR8TH7X7l4+gLD3BHYA3FGpAYnbyvlTUYws2plfNUafbuUkPN2879vwbWxx+74LpRktYrTmREd7kY0TkN2IkfC6V0AawJHZ5fDm9Y9z3dPpPpqk6xLAP9YCRknNd76KuRIsSx2Sz1RmQPZU6BLqDUh7wU15cte5j1qqzHoNsTPkCoaYWetoQxVlzivO7VAVrRlalYx52mdsItgiC0UNm/z8EBM66PbZ5/ROvbzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uuu804wdaBwn19x3Tid8eEmjEyciuaU/B17WKyZd9Fo=;
 b=G5mkik66MH43haRT9aC/eWTh91/1qX+tITNFxW4HwIhxL88Nbiseh/zJo/BHhQf60C3BbMSg6Sv1AJHPcZv9bhX9jA7bwgdatyjqDw7kzbllnzgfNheDjj2Jw7hVYJjtfDK4TUWex9Svu8hRocSWiomaRsUGblR35paX/gWXNfmMUSF+E8XugUzjt64FoPHBkflPPYvBpvjXASf3p6CaLUvdtpk3BM2x/2NlxnhcKG9BhMrnbGPlWW0Ibk9lzNHGlvaOtoasUrxq05vHvpzxwnyZ2N6iM/Ycmx21rVHBJslcfW5b3S8iaTvG494XAEV/IcWsybllyx9+/CbIRnvMWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uuu804wdaBwn19x3Tid8eEmjEyciuaU/B17WKyZd9Fo=;
 b=Jc3urmbwXVAemVQJTzo8aEV3niCUFEdcvsVAeeunO6ir64cuuVBgRQlaOObOrlrOGsoGFFzR+B2YRr8I5i8AsQqGalkOWpo36hIkdQORaPB9WXQRddmmS0EXpIp1Iggeob95eATP9PYsJWHgwjPpjewlmT3yt9s9l63bpGLjL4G0flSRtLdDp/tf1ytg34JmAz2lh1sdNO/p3o1C8KAkHTOpe2YYM8Za6sPZEsxErj9+ovW/9ky0ue2k0Ip0Q1+gvWmtR8EGiPtJBLvBcFyLofVY5WcC3YOsPxacX3vE6wzXZKtGvP8wxatz5XkzaWXro71QR+3+ttBP9lwahvCvxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4116.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:41:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:41:48 +0000
Message-ID: <7e896b03-0217-4a7b-a856-0ff2a51097fd@siemens.com>
Date: Fri, 10 May 2024 16:41:46 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: isar-cip-core reproducibility pipelines
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: a8488966-a53e-4623-fff7-08dc70ff52a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TzFWcDZveFllb2lORVZlWnZDREFxeTdzUm5MVWtuU3lQRkdBWG9DeGtadjlC?=
 =?utf-8?B?WndIUUlrSmRRT3k3Szc3TnJLNXJ3ZmpvbkpCa3g4QmtxdU1HRUhBeHhhVWU1?=
 =?utf-8?B?bStkbWcrVmRLQ282YlcvL1MvWE9zUTNUWE5Telptdm1oakZwWUtFcCt2WXdt?=
 =?utf-8?B?THFMU3lnY2VFSjR1ZVd2WElLSTRCWGtiZ29lZG13eldRK3dUS0hidTR1bVh1?=
 =?utf-8?B?N0FkQjdrREpTUXRZRDVtUi93bW81cnZFbitaaHhTQUl3b1B4WktHUzRTdkRC?=
 =?utf-8?B?SzN3YUI1R212cFRSYjBCYVFMT3gyd1RVR25Jc1BJL2MrdHpHRzBUaWNDS3VT?=
 =?utf-8?B?NS81WkFvR3NEdWVaQXpCVzZ2d2tyODFiM2VoUERNSTM0Zzlsck5YVTMzSWw2?=
 =?utf-8?B?dG1qODJyNUx0bkFlQys0cnJMWGIrbVRVNVZpanIvUzJSRHpqU2xlMkM3ajc5?=
 =?utf-8?B?Q2NKM21SWExWTHdpQmx3RzViUHFTL3krQmE3N3IyMXBJQUlwVHRrbG54SE55?=
 =?utf-8?B?RDRFbzZPQnkzNmsyMUFiTFA4c0UxZXdLK1hpNm9EbDlERTdVL05TckE0dm5Z?=
 =?utf-8?B?TjNMMnRCTzY0bnNWdXQ5M295RzZmVmlkclExWmFBMURxYkF0ZEhQRHBuZVlL?=
 =?utf-8?B?bFFWd2VaZUpRd2hocnZ5Z2RDNFB1Y3BCbldNTFFOZzAybDBPUDREaE53aGRV?=
 =?utf-8?B?UkRwUHJtQnltSWhBc2pRd21EdTUxYnJhUkY0OXRiMU9RQk1sWjFjcW5GN2VH?=
 =?utf-8?B?Slh4emZaZFg5b0pIeElWY2VwZWNrc2pMNWpyc05kaVdWRDUrc1VhYWxiM0pJ?=
 =?utf-8?B?OGhwSDNzK0hiVjJkbHlIek5pYytvekdzYlpZM2d0VTNYTmd0R3lmb1d2Nndj?=
 =?utf-8?B?aU5JV3dFdkpQV2JlemdTQXF3aEYrTjdOM2pyZ3RORVpwWVB2eE0wU0pwWHZF?=
 =?utf-8?B?am51aWFsMnpyYTBKdmNyWVRLemxJakNSOEVnby9VcFRPbUJPSDdzN1kwVGFi?=
 =?utf-8?B?aVkvTS8rWXVNTVZXbThDM3k0Qmx5eTB3YjlFTHNxNngrZDJjS21FRHVOa2xV?=
 =?utf-8?B?UVlqVEZOYmNkc2NNbHVVa1YrMmVXU3ViNDZWblRzbVFsendocGUwWG5tdXUw?=
 =?utf-8?B?bkRuSlVzQkk0S2F1ZVdHNDRvM1lhSDhyODlPd0d2aWhtWmgwYXRHeFVnWmdP?=
 =?utf-8?B?Q1dPZkRVRC82MXp2Qm8yVS8rclgrZzJoWGVWbS9qQlArMGxpR28vK0JKdytM?=
 =?utf-8?B?QWJtNmdjQ1dib0tVUWFxV1lCcGM2cDBSVWExUlFTWVIzZTgwOW0yN0htVHVl?=
 =?utf-8?B?V0E3RGU3YkdHNjB3Ym1EZXUvRXJORUlRajh4V2FYL3BFdEZuNVpqbEtpcDhx?=
 =?utf-8?B?dC9xaU1jOUJsZmJyQlEwY1pYSTZKMS9hVmV2ajJLWjVlMjk3MHErOFFFTGxI?=
 =?utf-8?B?Ymg1VFA3bEMwR0IvSHIvOXhYcmRyU0hQUk1SNGxLaHBrdDkxeDNmWXVyVVhS?=
 =?utf-8?B?T3h6ZnVoZkpPWHNRN0tETTJ4eC8vUzNiSzJwdS9VRHhBMGxEMGVyRzlqcjY1?=
 =?utf-8?B?bkdUYVg0T2kvMkV0TWJXY1lQd1hqRWcvSzNqTTF3cjdIblB3MFVqU0w2T2Vj?=
 =?utf-8?Q?KgXsFd/3XThRcgvktBYp0DEipakxQ9ElBxDfaIfx13RQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTRuZnk1VU9EMjlQaHJvZVAvUzVhOUpTM1BHOFRZcmhzdjBUVVoxNWhXSEJo?=
 =?utf-8?B?VjhvSFo0Sk92ekFDeithVTlsUC9xdjlia3FoRzN2eVhOMUlpUlV6bGZFRTNw?=
 =?utf-8?B?SytBdVFpTEtiRFpQK1BaYXJhM0M5Q2R4TVhhcUR2SUM5dUpPREZ1MXhtVUs1?=
 =?utf-8?B?V2xiVjhOOEN5UzYyajYyUXNqTGwxMm4zU1NhamlTaThxUFJhNDBGS25iVlVT?=
 =?utf-8?B?Q0NDTGMwR1ludmxGWk1CU0JSSHMzM1dmOHdxdit0cTErTDBLcVZZRDBLeUFm?=
 =?utf-8?B?YTl4OG9KVktsUWFMblg1T2ljdUlYMGF6cXdVVnVLQXhaSFlCNkZ2SjcyaHJX?=
 =?utf-8?B?M0VwZHNoNmEyNXk4UEFrL20wZlpZME5Kd0E0amQwbWRWbXBpbkNDenFWakRY?=
 =?utf-8?B?eHZVYURlR2VBYitBVDViYzlVL0FaT243K2wvMFlXMFQ3RUhCblpHR2IzVGFv?=
 =?utf-8?B?OEdienFKNnF1UVVGTmpKdEdXbFE3V3VpTHJGeThRMFdUc0FFQjFtQ01PN28x?=
 =?utf-8?B?amcyeGdBNmhWbjFrQmtZK0JHeFM5QzVoN2VKQVFwRDVJZ1RLQTEwSXBoWXpW?=
 =?utf-8?B?NVZlWWw1eDhEVFlZU2pKaWJVQWgwa2pNaFVpY2FOeDk1eFYrK2xhS1VsTjZ1?=
 =?utf-8?B?ZFNHNjRsdmxMRnRmK3Q3VGxPaFRZS2Rhb090OTVQWDFsMUQydXdHenhLcUJv?=
 =?utf-8?B?RG9kaEdBclZ0MDhDZHRFMzVFZEZaT1cyRWxLYys5a3VwZm42OTF4dnVmVlpz?=
 =?utf-8?B?T1hVeDE3NUxKY1ZZcGxvaWI0bit6MTRuSnVmenFIRE9vWHVpcnRSR0tWSWNW?=
 =?utf-8?B?a2syK1RIb1VxRFFWSG1makhMUkZ1cGJRSmFHaHk2bFFlRnRaTFZnRkRWUGo0?=
 =?utf-8?B?bDdHamdrOEdPQ2JIbkR2YnhSdVo3a2MxaGpPY0N4RUc0MExXUHhLMWpFbGhJ?=
 =?utf-8?B?bzI0cmRIa0ZmaE5Ud1ZLVitNQ1h1RkMxbE1ET1hqU2N5bVZQVGNienV6R0Fy?=
 =?utf-8?B?MzlnaWRLM1FzS3hDUHF0bmx4aFk2Znh5WTRwT0hvZzk2YTEvYjBsZTdpUVpx?=
 =?utf-8?B?blFOQmJ1WWZNRnBScmVhcGVqNW1QNy91SnVneEdueFNLYktkR3NaYkcvSFpa?=
 =?utf-8?B?NnJFcERBU2UweUhHeWhVZUlEYmhZVWpETEhBS1RqTGJsTTZIMEtwTEhObHJB?=
 =?utf-8?B?ZmV1REd4RlJzV2VKNkphSExOZlJZZmhrRGVtWW1UaUVnNjBmVGFLWHh5TGo3?=
 =?utf-8?B?VXZSbXpOOHk3d2U1cytVL2JEbkx1bzhldk9FRlF3UGhBOGI4em1WMGlZYnFV?=
 =?utf-8?B?Y3hzaFFVVnowejJrajlvREpDSUd6T3I1bGYwd0t4aThHcmJaVVpYUCtzZW9p?=
 =?utf-8?B?UzIyMTM4UGx4RjB3MmVxVG43RGx1Zm1FZlowZ1VIL1NoNFVOeFZiUXJtL1RX?=
 =?utf-8?B?ckxEaE9wOXpjWEVvUEhBUGVUL1paUWNmQUxoa2l3My8rUnZtbnhhcVAyUG5j?=
 =?utf-8?B?d0hxWVNTYXdTMWl5ZkNxRVYxSGE1Z0VZN3NjeXk4RU8yeXB2ZFpNbGlLYnds?=
 =?utf-8?B?UXdrbWJiKzVwK0xkL0NpbTZHamtPczBZbXp5Rlh4ZHA3bXRzRTFCZm80dEww?=
 =?utf-8?B?eXhMOFp6QkMvc3lUdFJhREJycjF0YnRacjljSzJCRW5mMHV0MGxHWVV4eUds?=
 =?utf-8?B?OVc2NGJEcHFhaklxZVJrYXRqQTVacnNnQUpTR2sxclVCUVhTS1V3bEFXK3BF?=
 =?utf-8?B?dWJEMzdxc0dnMFRieS9Xc3dNazRoS0o4dTBPQWp0ekhvd29pN3BySWpZSld4?=
 =?utf-8?B?WnRPUWxlQXJRY0d5NEJKaC9TZHdFVzBGa1IzenZ2RFNiT1QwTFRJak1qSU1K?=
 =?utf-8?B?RVBsc3EvYmV3dXRTanhFSjcyTWNNbm1OaitqUUlvSkZFdzFTY3hJeGcxTTJv?=
 =?utf-8?B?dG5aM01JcWlGZGRNR3RMaEtVeTdzQ3owYnZWQTAyNXZpdHhHV2g5Nk1ZcFRa?=
 =?utf-8?B?TE5CdDZVNDJKV2xNQWRqcGhtZldHd3pYbDBPMzlsOEJEeWttT29XOVJpUnQy?=
 =?utf-8?B?T0JZTHZJUWJScGtXWVFJeUhZRlBocVZRQ0lKRnJDTlY5UmR1RERub1JYeFVr?=
 =?utf-8?B?M2ZOcVJSNFY0NFdMMGtVK3pmMmxmS3BMRVdKZzZsRnRFbmZCbHlqRngwY0xo?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8488966-a53e-4623-fff7-08dc70ff52a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:41:48.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZNRAeyz/jM+RbEpncwVrjYZHHORcByxRGWLkqed28h74jFELGBoZcEj2PViRPQzTcb5FZH8WaTKkTzZFLWMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 14:41:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15881

Hi Kazu, hi Adithya,

FYI: I've taken control over the weekly reproducibility checks [1] in
order to switch them from master to next - earlier coverage of changes.
You can take that back at any time you need.

Those tests are apparently failing, but that already before my build
changes in current master. Known issues?

cip-core-image-security-cip-core-bookworm-qemu-amd64.wic.p6(home,ext4):
Not-Reproducible
cip-core-image-security-cip-core-bookworm-qemu-amd64.wic.p7(var,ext4):
Not-Reproducible

I've also claimed Venkata's old schedule and disabled it - it was still
active, but against a stale personal branch.

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipeline_schedules

