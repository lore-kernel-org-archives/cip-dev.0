Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35DDC001DE
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 17:36:07 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.52])
 by mx.groups.io with SMTP id smtpd.web11.23975.1691688966011613183
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 10:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bqKWM1Eg;
 spf=pass (domain: siemens.com, ip: 40.107.7.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt90gIBMQDwClFKENuZrHBLSRIZ2S/eu3BLOwOcb1kw1hUpx/aTJ3dlU0ChAiJ/rfn3Hx8t1+hefZhxlGQGEg0c2SaZwA1UjhfE9sCbXdxxq76PZNu33v+9czfEvrW3hzQdlQGB3PoCyeP7C09oAutTXrYi9l8mmFP5YlvPjQS9LvT48mWrQialMtsH58hNMWu0dSN6GnUoLxsRXciKgwpDUsRsJgqvx3SWrLiNX71fYtFQSFQn3OExdJ1LDFcO3624FRkPQyUJ2jKGtnDVTfXAbrKQZjIIvIR+zIL5aaGlpRnwEhGQWmJuxwetn2kBZm8ZY291ZOkf6fMmg4/gaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5NfXK/KWGHtbHgU0FId396WzXxiU+p4YpZNLuXL6WQ=;
 b=d3xHDXo7PAO7eNheK4ypckuy+DbcifrvCanXUZxzxmdnYw1sdn7ESZlC8pzbrZ7FbAuPAB3EhGbyOUa9s2FNP+VduEParF1QxJCQ7OpVgTa+NhE4Jn8ib4A4FDxP8dj9CZxjlVvMY2lX4GUHjW8j6msWCsjC5aJgdq+nmw8ZmCQbKr1cNILtH/h1jHjSD7ZhQC4j5SoikfzRIKABrz3nfP9tuNcU2PlOFoeFVzbn6JlW+kNU0hbH+9QNsfOC9Wu9a7lyEYPZvlCoQc1iNNk5n9wIfUjyxYQG+/HzWycZorN0cs/HOvjxRMKGV0pnBwyYZUiLPqQ82xcWL/HWgX3xQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5NfXK/KWGHtbHgU0FId396WzXxiU+p4YpZNLuXL6WQ=;
 b=bqKWM1EgJwl6Pe2GRfU8SoqE8uP9iZWd81CrIMBWJ/Tmdxt46R2QxCO0wW4L1Bwpyf6BFX4T2QoaktOZfWEKwk/dtsYODe6snKoMqY6l3v8QnV9tGlfDY5+PZeJwERedCE+G94igPQ/XJBHpQByaPptszzOwE0A7TlkC2iwO3V0noOFqPzag3SGd/g5I2E9pT3qsAOKwF9iocsV9qJVHjVhlq+l0ZqjX3gewimav/KoqeEFfsPTcTXLNVj/lsbtwBtbrNwOKvYeT6kR4A4sHosySXrVWgFOeZ0tdB+K3IH3TlbJWg+mQqYMoVeBueu1EGrTpHc6tVsQ0mRjoY2VuqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5623.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 17:36:02 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 17:36:02 +0000
Message-ID: <e5b311e7-7a75-2028-156b-6f117f8221dc@siemens.com>
Date: Thu, 10 Aug 2023 19:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed
 updates
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
 <ed132a4b-7c2c-44f2-b1c6-8a7c8fdfcdda@siemens.com>
 <45e6785d-6d78-8d40-bce1-2606661730e2@siemens.com>
 <f75e9b6a-f89d-46b3-9f38-2847396e35d3@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <f75e9b6a-f89d-46b3-9f38-2847396e35d3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::22) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: a46ff7f6-791d-4d5f-7424-08db99c84427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ypc5pWNSRaz8sGF87stK8zIE0ayV/Q7u8ZJthApXTreP6TQ8R8X/niDXoPGrKvF0UsATu+ch/ZbzSsU1AJsg/dDWnXvrJouHNPxuoYEzpQ+nuZ+D66Vn+uEM8F0XfWGLe+TzqaxkMxBEy/WUsa+fAAmC2DI2Ob9KPn1WM+AI1e+snSiLvCbnp07trXrUtVoS/AgJgSg9CJ5DalZ1kHnniRJJxM8RU+ixDbSbE7QraneO91D2YzBNAf7jXcCw3pS3pfzD8KEAyemMf57hGZ0O8qEA+mqvS03xcep0mvN/enxdAWxB7ZxVUDMwmol6iFuykZwNA/z7orgyje8tvj+66Z9KVbu4vRNAjtQwJF7AVskiCBsbaTeYLySCav7V/lkYuPpIYrEup2eF/4DTOY7lU9zKWd12IJ2a24Ueo6hmcScBhk5648gjqVaYqdHuax52lGZrpNz2fjIi5FpwXAmlyRGw3j4oqX2ll44ovW0JVpuo3rTbghLGyMEdl+plIBE1IeRG6SmtCZIAyAoNS/H+GgMjEuaEIAlqNXYV57uyJPQl1PhemhZxke9jDIrghkkGj6+Kdc9EFtEPhs+zi3MWko8zBk8slhW0RsNZG9Hjt9bXgU6DCbOscMVAHyInQ9j6J7IiDHelt+VtlulIFI0TXw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(186006)(1800799006)(31696002)(36756003)(6666004)(478600001)(6506007)(66946007)(66556008)(53546011)(26005)(66476007)(6486002)(316002)(2906002)(41300700001)(15650500001)(82960400001)(5660300002)(8676002)(38100700002)(86362001)(8936002)(83380400001)(2616005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dfrq0IazKbK4a0W9/aE91gP5B7ZDIYkJLMcZi7XLHhyZSmWWUc0uVYe8fT8o?=
 =?us-ascii?Q?/Meadi1aDuuYllKlhOSODvUBF2Uw+dIgJ8SXDmbTyzlHT3OKFTvJZe2KXr/3?=
 =?us-ascii?Q?HorL8xhiMcL9D/mS+7+tc0eDKrTBWiGUUBDiz+p8sRaqRQy/nAj9yBEBeaOi?=
 =?us-ascii?Q?n7sEmVyBEEYqCTqHc6ZD2lY2WPKnl2O9dRZeTi84JRdQAhtpSzjTiXW4bXm8?=
 =?us-ascii?Q?7he2Em6DtH0Ok4cLCFvM9FXZmpBOhLFdRPoQH3n9cUT+5SRfbKkqNHbSTqUs?=
 =?us-ascii?Q?xEPBc+TNb/HD0RJxsOHz4QUHFBfT61Z2q2zxWIu9drwuNXtl2I83tEomlv6D?=
 =?us-ascii?Q?Ze3Bfq112/+79mX5lA8zhkLAIqzOgIZQr4NRlj0oqfiQSC6AC49XW6pKTIfc?=
 =?us-ascii?Q?v+Z2zWCt+v/+E/7/MajyKdf7om9nsXyHLg7UdiwBUh27dOOpIh4tK4AbkkhX?=
 =?us-ascii?Q?30GqwvzZMbTkuXjeeroEjlDIUGGFuqO4CJoKxFdsqVc5sZ7PJbaHFEUrEo7g?=
 =?us-ascii?Q?EuTYRGYWXsapCJZ4G2xnjISK/SH0kKzZKsj+CcAghgciHGFQ3oiVBxWyMIHi?=
 =?us-ascii?Q?Id96aeH+PpjKQqYhBZR74hZfH9xiQu0oZshMdQtLPWA+F9FpJwEvFUorHVfF?=
 =?us-ascii?Q?XVIpPjaJmNcpC26nRN3Yt9n63l/G9CFZVnX4jVFlVU+ArJ0vG66HSSp9MCwp?=
 =?us-ascii?Q?mwl8wZ9H51C7Dxbstg0kFZ8UEZhR0GMZe3LSgnkoRtxBRoxhJVJEId+Bm5Rc?=
 =?us-ascii?Q?iRVOeOEy7zCvyJo+MKfDf3GA3lqPsQm5+xvJ334vwOOnfYdwJ8o4cpiepfYy?=
 =?us-ascii?Q?ELioS7GVCJAlRAGBUTWC8rCoLrnADTnKjDoLXLHm5WK++eSMjyFemaxAKcS4?=
 =?us-ascii?Q?ONJFEZHUhBr6k5BgjtauJlTltCQvrv83CMzweuRVqNYuFCx4CwdN8qzkQmDJ?=
 =?us-ascii?Q?7BYKYJgPTSHrg7OxN+JJfpibAZ3mJc9M7M/azI260D1pqQtJSnFhUODZwbBG?=
 =?us-ascii?Q?eOPBRotHvbbF6MHtpEQemFGsJfHdcOzWwWspFQskm2PGkBzB4z/LquXSvLwh?=
 =?us-ascii?Q?4nUkF2GrleQ8pB1jCSLjnjJFsKVo7vOM8XxTRJsnKckAUSwOfW58v+6fWkWQ?=
 =?us-ascii?Q?Irxtq5uQKo5S7jj/5FHimiNhfElF/dLEFLIZd4iGH73ovP8aCD2OH6u94bEN?=
 =?us-ascii?Q?+ez+lOEQfYxkAFMUHgmsiBwyTAe6wTxZcl4GzL2pFhlWOUWFFyIs2WWBgvkD?=
 =?us-ascii?Q?0KAP0JfUil3BCdg761n0LocWN5BhI3pZFYCJo3OBcGDFu83QQM+ZoENfLyWH?=
 =?us-ascii?Q?q+PQRBD6W3ljY6HycoaLeEIdtmIaa79aO7MB811vT22N6qf5khP3uKj/Xwyf?=
 =?us-ascii?Q?fed0+z2t5sgW+hvudlOzYrOfJmxqfhIR6pn0GozjTnQYVHV6x6b051ddX37p?=
 =?us-ascii?Q?xjh+VFnq9BH8/vX4jR8abj6fqHzpIuB39IaVnCYaxmLp78CzY3hDEdu5XcOR?=
 =?us-ascii?Q?e/0PhTfT44G/zm1AwGKzSS0S0qWZ8zz6pFqOVbd9EgTXHH4IGy2m16qyJ6p7?=
 =?us-ascii?Q?+rVUaPZntBzUfvQAowQr7Be8Cb6F1RwK3QgWsLHlQvHdjzM6C4lVDg3JZrcL?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46ff7f6-791d-4d5f-7424-08db99c84427
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 17:36:02.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgogV3ECuyHiBNvEUY88Gdp9zgQASyko2hPlpFOzbzSmDBRYgNu0T8pxYpmjJ49kRQIcY/p54opT93/9ucAYfzMcZHfHhM6wLUAF9uXLfNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5623
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 17:36:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12608



On 8/10/23 18:38, Jan Kiszka wrote:
> On 10.08.23 17:58, Gylstorff Quirin wrote:
>>
>>
>> On 8/10/23 16:47, Jan Kiszka wrote:
>>> On 17.07.23 12:54, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> With this change SWUpdate requires signed binaries to update
>>>> the system. An update without the correct signature will lead to the
>>>> following error message:
>>>> ```
>>>> Error: SWUpdate is built for signed images, provide a public key file.
>>>> ```
>>>>
>>>
>>> I ran a build with SWU_SIGNED unset, and the result rather gives
>>>
>>> [TRACE] : SWUPDATE running :=C2=A0 [network_initializer] : Software upd=
ate
>>> started
>>> [WARN ] : SWUPDATE running :=C2=A0 [scan_mtd_devices] : MTD is not pres=
ent
>>> on the target
>>> [WARN ] : SWUPDATE running :=C2=A0 [mtd_init] : MTD is not present in t=
he
>>> system
>>> [WARN ] : SWUPDATE running :=C2=A0 [mtd_init] : cannot open libmtd
>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] : Found file
>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] :=C2=A0=C2=A0 =
filename
>>> sw-description
>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] :=C2=A0=C2=A0 =
size 1219
>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] : description =
file
>>> name not the first of the list: linux.efi instead of sw-description.sig
>>> ...
>>> [ERROR] : SWUPDATE failed [1] Image invalid or corrupted. Not
>>> installing ...
>>>
>> I will look into it a send v3 if necessary.
>>
>=20
> Otherwise, things seem to work fine. I would just like to understand if
> that is also an expected outcome.
>=20
It is a ordering problem in the cpio. If I `cpio -t <=20
cip-core-image-cip-core-bullseye-qemu-amd64.swu` this is the expected=20
result:
```
sw-description
sw-description.sig
linux.efi
cip-core-image-cip-core-bullseye-qemu-amd64.verity
280835 blocks
```
Can you do that on the transferred file?

Quirin


