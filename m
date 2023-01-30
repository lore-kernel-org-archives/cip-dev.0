Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4C1C54EAA
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 11:02:47 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.79])
 by mx.groups.io with SMTP id smtpd.web11.38276.1675076566528416995
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 03:02:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ytpOGLM3;
 spf=pass (domain: siemens.com, ip: 40.107.105.79, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4xAWfV6V3WmQ4iyxXtucpwOsKkai4EIg8zSdjzivbokB3ZOxaqZK065OZgXic0zFvHPVQHDyUqHxL0zRv4oiDDYpkZYGTMWaZqOR+Krs5q6mGJC/v+ubEC7rV1ZgSxUNMsEzsRkRgPDJjEWA/flzG2aGxKStu5jcdkQ4geig1Is+Rr0QQ2i/xRIdxZq55S0ovXMOK2ieHRipHHf7iVJ1VRp7o8Ce8iG1Mj3RIf+wZyKAAMPQNl0AKgHDCaSV1Uyha11wS7ybwNAgWEt7fH78Vq5CU515Ft5DtOoKSFGpHqxwKXgM2XTMwz8vd+9ckLN+vom0dP/C4nkC0EuCMZrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr46SjBndRjLsiAl24qqNkfh673U8qB+Zulpc4bOukU=;
 b=bM3WFwEL9gm2dRaNN8+GY5WjNhZ8OQfBpPwh8W+ntSCblXZX24GHfXi+/j8DepH0lz0YZTZ8KnO0aA0x6kdjaebypdwh4poXgKrVgtEi9HsvchkrdInNI/3xEEeGh3OmTmied4kIEhJusz02ACBRB494kbOrlsa5MZInADLCZCs+VcIziSI6wab97zbxOAqfiAmk6ZCnNoi02iglA7ka0iN3IYAWBgJs2S74DcW6tcDnEzTj0dUel4I69pW/1bRGEGWCEyNkxYYr/sKeoywrYVkuiT7RBqZGf+6UeHRhSwlgyufmwPF7AyhQqSiiE4ky1tzszLoqZcy+xwmG4+UXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr46SjBndRjLsiAl24qqNkfh673U8qB+Zulpc4bOukU=;
 b=ytpOGLM3U9VCpgb5SsO5tbX7IKIpGvdwpjGRPawXlvfsYNsTGTpCWxqi1aq4DmAZZI3uWEQHgffyhsVul7WPI0LjSDVdEOvU52oQI6bSU3f3dPUSiAv/T3o++JXT6tWnGG9YXF4nTlSgouQXiyucOVj3egN8zCopd7kb9n98PPmR/5On8IWl48h/g74r9J2o4WcGQcSGX/SZkx19/Qukac3hyZwO2MBvQDIdDl5gZ/OWPkGUkGPL5NDN2l41Dw7kSRc/QANwFUjrAhYwHCThoRGYGSp354OG18fbI3oalwrKI6c1QNhbxhYcbQmLNp08Ew3QqOBCvKfsoZNKBHADmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 11:02:43 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741%3]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 11:02:43 +0000
Message-ID: <65f143aa-3e48-9075-357a-08087a5e922c@siemens.com>
Date: Mon, 30 Jan 2023 12:01:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Override of sid distro config breaks mirrors
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <0236184cd3f04ecb0a3282bdc6c8fb7eeb04ae81.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <0236184cd3f04ecb0a3282bdc6c8fb7eeb04ae81.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: f8da0d4b-38d0-43bb-08cf-08db02b1831e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	heHo6ZT4eFqymt/3/F4C1yylFtG2iz3tfKw/M/GDlxF2TGtx3m3mL1WHDOK0LfSCo7vV05MES4DnoUzw9M9ZjIMEcA18E8NKcei4WeFYPVBaPz1vMvmxg1/AlQsOloFAComWC7Tg9BLiOxSkM4cLPXsmqV20rWmStRi10Mxw85C58FidMo5OEJ+eZ3cG7BFUpZNSgy3p30rc9l6Ll5yM2WZ0lWHGgZtNV6DqK7MXmROrx474RChF5bkG7QyhKNKEElQtcmS9xDqaArgyWa//dClTp2OsXYd5xgnYvdpclJEgxxYMqFK6EatauthTdcwyZvB7yJ6l/euUj+hw0HV1acQsnjyHlm7GmZWjKWgiN8T6wi/7JDyxYe3y0hggALtmVjCROBSjhapJpzJBN8+ywJUAknjLqVxK9eic7J/7bqXIIujPnnHCXUZQqEX4YmbcVrmhU1shPPpONwKvmB+o2aT0KV70GMUZoho33aqvvoun8CMlssJowFY9zca3RHyroqux49sJUPNPJV5O4mHNicu5INTR5bqt3Sdrpbykl06NkrWQe56dyq+8IzXZOWhYc7msed1MVRYuG5IeEqTbgJ05WTMrK1g5zmHvTWfAsrquBDTrnhUXiVNOKPvhGMSmC+M5+/y9KHXT39tO7Yy1d3pnGCNxM+3bnnkFrXXtAv+vVFIp3UXxs0jGR0Yr2rxOPUGNfFqFlttRjcjYXQZK5d5K0yJvRetX2NugfRHAZ4UCUciazzZzD4JLVmNlE2ZFqy1vhkuIze6VCrox/CiFtg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199018)(41300700001)(86362001)(83380400001)(2616005)(31696002)(38100700002)(316002)(36756003)(82960400001)(110136005)(66946007)(53546011)(66476007)(6506007)(8676002)(66556008)(186003)(478600001)(36916002)(966005)(6512007)(4744005)(6486002)(2906002)(31686004)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVpjenVKVXpiUW9HRHBRWTcwNkZ2cGluajd4Y0VYNGVHTjRJeVlQNDFpb2dt?=
 =?utf-8?B?NFUrN3dWaU93K1NMSFRhaHRZbGVUT0h0WkhWM2pRUElQZ20ybktrRkdvRm9u?=
 =?utf-8?B?K1VrSjRkY1BlenhPWmJEdzJ1L2tWWDVock5VZ0U5QTk1MHlSUjRrSUJieWNq?=
 =?utf-8?B?Q2I4Q3locU4yN1pnaG1JeEVXTGhOTk0xRXV4YS9pbDZhbUhPck8yZkNSUitu?=
 =?utf-8?B?TmgydGtYTFFWNHlSaWZqd0RKQVd1Y0JkbHM5ck5hZGpqdVNZQzlEdUlLaWxX?=
 =?utf-8?B?ck5KVlR4ZDF4ZUhnWTZ2dG96QzZrMHBrYnhMZExyeVhzeEN1TDVmWjVOb1JK?=
 =?utf-8?B?RTdYY3o5Qk4xM0FWTHd2aEhsNmF5bnBBYnMvRzBjcHJkWTZqNittSEtnN240?=
 =?utf-8?B?c3BlZkx4WkhrdDVEYnZaOXF5U3MzNjMrV28zZEQzSG1RcWNsRFhXQzVhSVBl?=
 =?utf-8?B?RE9mMW1SbkF0SVpNUDQwVVJrNmhJNXh3eHJtQ0NNMWpjd2g5aHo2VjlPR0VZ?=
 =?utf-8?B?RnJXUEt1d0NsZ3ZwNUtEVWpuMklHeWtkOENhcXFJMzFhcDI2ZXFLc2hpdVNY?=
 =?utf-8?B?Y2NIM0d6NGR1TjBiZkVtWkNRbnRYNHUybTBPTnFTMHd5YUduWVREaGZPVGdG?=
 =?utf-8?B?anlzVHNsNjVEM2lJZVRXZzdFYm0rbFBiNzUwUHBoVkZkVngvL25aS3A1YU5R?=
 =?utf-8?B?SDJ3OWoxRWVoeUhuNmdZbW9YK0RFNWF2ZjBaei85ODdtQk4yd0dJUHVNQzJm?=
 =?utf-8?B?RUYyK0hMOHJ5bCtsYnF2VWIwL05xU2pRakZIdzQ2LzJSUkU5cHJMbHg2c2lZ?=
 =?utf-8?B?VEU2Yk1weTZNWmxydDZtMGVSdDliMk1Zc2tXTkE3dnpDNk1mUU81eUErZ2J6?=
 =?utf-8?B?T3lickdNWjVqdkg1Y3BjMmpqRGJNdU15bnNzRTlZeG8zNXhGekY2K0xTaG1X?=
 =?utf-8?B?NHloWUpCU2s4WXFCWWVEN0ZGdUtVbzdNM2E0cERZMjFqOER2OHBWVHZuMWNp?=
 =?utf-8?B?Y3MwQVdjb05IUUVETmlyRTBhdTNidkhPTjhBeTlxaklUUlRoa1N0MzFVTTBZ?=
 =?utf-8?B?TGowWnJFUm85ZXpEZUdQNEhub00zcXdtaTQ3K1c0SEU0ZGFVOHdFUEZSYTlr?=
 =?utf-8?B?dHJQczFRZFFaU25DKzVzaE1UVm1ZUlN1bm15ZnVQNlRudDYxZW1YaTJjWURY?=
 =?utf-8?B?TmoxR3pBbXd1L1RJVWdaVkNjaTVqc25mK1ZPWW0xVTRmMUF0NHdEVkRnRVBx?=
 =?utf-8?B?Zkx3dkZFYk1WeUY0MVNva3dXM0ZCMDlPS3BtbGdHazQ3b2oxejg0cnhab1B6?=
 =?utf-8?B?RFNTSUJQTmFITDM0RzNQeVVhUUdNNHhoRkJGQklLZnpqQmVmKzIxQWRFd05t?=
 =?utf-8?B?WWlBaVJsTUY5c1JkV1ljc3M4VU9aRVlkQjVvL0lvbVFwaDgxRnVjNFVvWkFs?=
 =?utf-8?B?QzZMZjR6WVZQem9taWNpbGtCbzV6K2dPTkxSeDM0eXFFQWpPUS84cy85MGVi?=
 =?utf-8?B?QTRBbm9lUE9JTzVId1FmUEhtUHdSM3I1V0RSYXhpZkNNWEF6OFR5elhzY2dE?=
 =?utf-8?B?ZjBPcGRhWmFkbVR4cHlhWkRhZDBrb2pyYlRaNzNwSFdsamFEOWJmM05pRkww?=
 =?utf-8?B?TVJFUjZJdDNOVDlXT1V6WjBaSkpvY2g0THd3SkhDV2dYdy9yb054NnkxSkdP?=
 =?utf-8?B?NFJoTFppVHVHNXJVRHE4aG8yKzg0bGhLUjhjbmFlUlN4elJGVFlSZlp1M0pz?=
 =?utf-8?B?N3Z3WnNaV2tzY0VUS25CUEs1V0lFSk9Lc3F0bEMrOGgxNWdGdHVabEpxTFBB?=
 =?utf-8?B?Y2IvYnZCaFc0VjQ5cVZPT2NQQkZaWGord1JHclAzZ0MxeGFNVlhjRnAwbXV2?=
 =?utf-8?B?VEpVMDBpSU1kQzQ4V3kxMVlrNnZYMG9tRnc3UWpha0pFalJGTk5vYzcySWZu?=
 =?utf-8?B?aTRUTi96eUFHRVZlUlo0UXVqYURnUk5nMjdMeFlobi9SRmtORmlXMTJvVG1D?=
 =?utf-8?B?N2VkYnlYd3RiNjAzd1BEcU5WTlZjdHBRSzVBcDVaYmEwNTI4dllnc1c1Q1JY?=
 =?utf-8?B?WjVSZEJkczVoVHJpTE5hTVFjbWs4ZUJEOHF2QUszcTZJbFV0U2JwcUlGb3Iy?=
 =?utf-8?B?d1FNaWRpcDN2T1cvZFZGaU84VzROWlE1MHd0NHMzclg4QzZVc3lFK09PaTJi?=
 =?utf-8?B?Z2drZ3NPSzRFa2pQclBxNFdNVjEzVGFBSWg5UFdneFowVVFLbW1xSFNGaEZX?=
 =?utf-8?Q?2IPk9mk0+I4ccMQU+NkKNWcuEynq68/3VdBWzo9fTA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8da0d4b-38d0-43bb-08cf-08db02b1831e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 11:02:43.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OF/xX5PlY5LWnk1bk1yX/z39i6bi2MTX+CrRrMpT2h2nbN/MGsnkAZlPKjxCKgF4dFLqsng6Zt+mrG04i3wmtGWoKlgPw9n32KG4bqWsb+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 11:02:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10503



On 1/30/23 10:58, Moessbauer, Felix (T CED INW-CN) wrote:
> Dear devs,
> 
> the distro "debian-sid" and "debian-sid-ports" is currently specified
> both in ISAR and in isar-cip-core. While in ISAR standard debian
> mirrors are used, cip-core pins that to a specific release on
> snapshots.debian.org.
You mean the list files, which override the list files provided by ISAR? 
Because the only distribution in isar-cip-core is `cip-core-sid-ports`.

This looks to me like a workaround to override DISTRO_APT_SOURCES
from `conf/distro/debian-sid-ports.conf`.

I pushed a fix at 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/quirin/sid-lists/

> 
> This breaks use-cases where local mirrors shall be used, as these do
> not support snapshots. Also, this "infects" other layers that actually
> want to use sid "as-is".
> 
> Please consider renaming this distro to "cip-<distro>" to get rid of
> this ambiguity.
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
Best regards

Quirin

