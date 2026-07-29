Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4230BC53200
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 15:41:54 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14586.1785339713097537625
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2026 08:41:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=0KNn1lwe;
 spf=pass (domain: siemens.com, ip: 52.101.66.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp4zMLvCfemg++POs2raCpeOCTQofkwmTBxx2dyjvOfuYRRwBsN/K/r/utjwVUpsyipfJ3xr1nozdD+TFhG+m94I5YGSfwXCrb8+HXUDFte/Zx7XKq34dIBdrESV7hEND+Z/ppWsOF9ydMmiEQhkZkKNCui7BCfhdJmTn2idx2C/S8XZ1Tx0pH2Vitua8hWQMEKCCd5LzsqD5xTvy9wcRaIqD9pXSBerSFDQolkYwGInjbkZxnU4kQikbh7+WXudYG9oef+fGD3z4AFjgkmHz7/0MGHeF56+Wj4U1O1NcBNDY2P1dUkg6YPABxbMf141sOZvjhByyf0/R4i1+WfK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyxyGt4h3I2YqOJT0tuyoFOIhw+uz3YjKGu2lYCNRXY=;
 b=Y4HsZPC/xS+Ss0wb5VJPtFCrTw249e+FfgmeSyHp8gQA9w9r0CjMowYMchrEhp7htSO0ztIXaOzDvTvGsyai5pu1TfMF7uTHYDuvDNECUXRwmc7C4H/H60wdE7IqZqVt56Tc/02VI3KhebXMOpBNj168lyVGQiX56uWklcrc8KIo5Le+IXymXSD7RVOkkSlZ3sFmVXP5/4UHfRxzV2Q94bc03E6HOgXRLHec++xLmfmn2rMPmWxqexZU1HYCUPgRwMiS6VZ3RuLl7FXmqKTChvbzDRoZGDUC4VV3BNC9ocxg9IYSzGVkBcj76ng2pQeq7Miz7/nYAgD7yUQUixjZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyxyGt4h3I2YqOJT0tuyoFOIhw+uz3YjKGu2lYCNRXY=;
 b=0KNn1lweZ7PtJkvHTVE6/gF3g0+yEItAXOXEOrzKC3YhPp7jBqyoxkeNYktXt5Yy/XlKwu1Q1u9uxvXoCmYovl7UXAXzenc5FcSa7XsaiVt3rsLSrSsqgCtcMLH2SkIR2FN2BA1pXNzyABlazJUmz2YPGSbV+18bcVg5kBuubVmo7Ud/Zxx8D62/LT0JjZNR7eqN+R1obXf5UaZnAHvrv0sMQzWldel4pNkUa3EwG76RSoy/GIoOW5Dnv/AlVToY7X8laQSqWH0oNqUVKsB0O/W8USvdZaBVrRCAtu37tS2HNQrGQGSk0FPLpG2ZBNjEXzQKF4JkEm8ZH9bGi+qV0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 15:41:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 15:41:48 +0000
Message-ID: <6d649c0f-5bb2-41db-a530-36b1428bff63@siemens.com>
Date: Wed, 29 Jul 2026 17:41:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 5/5] update README.md for
 rootless build
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <20260728131231.117214-6-quirin.gylstorff@siemens.com>
 <a4b6fda7-15ee-4351-9714-d700cc171504@siemens.com>
 <b88cc355-446e-4190-9b82-b74bcd2b747f@siemens.com>
 <88d3cbf0-eaa7-4ca7-bc7d-5b4b4ec9ce35@siemens.com>
 <ac934863e6483d4dfbcff9a859ee872fc5d20e0d.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ac934863e6483d4dfbcff9a859ee872fc5d20e0d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DUZPR01CA0231.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d98efa-a474-4162-7700-08deed87e6f9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|56012099006|11063799006|4143699003|10067099003|55112099003|18002099003|20052099010|22082099003;
X-Microsoft-Antispam-Message-Info: 
	zgqmBqgg2gVwRG4VPZz13ncArLiEdj2zoDdycrvBrUAL/aLPiJt3NBhtAk4J04QQN30wY5+zfxSPZXLdZLEhKwTGCBx1vEq8C6JlCdqST+Is4y9hfq6fzYy5cutl+JJRxRx0SJb8fich6XhgAXZBGguuinhL06zao+hPZk9Eh+T3ToR3EY/fJAPwl+LGIk3xzgFzLqkfZ+SnlhFL9+zZn803NA8w8ExZmN00XxcLSswUSXHkhQzKbq8xgZj4U5Oc6Q58pyWwZjragZWfMdTh7jw/4Kikb1RTnPZQkwVQ45u/GLLCNVNhoF+NByiWWdttG9Kys1Hf7FKINeNmt9qeYiosBQUykHiNNKQ0SmlUW6rjZZMcRz9qwZ5hCpT3ZEZrvjhrn3tZz6uFRIoxzaWdROkNKsEDX/6WlSRvn4H+TTgGrZ1Wg7PsMI6ocnOpIXyVfF+9ffzR78a3wH0lfuaCBqaAlJEmVlU/rU7oM+pw2lD6jcLIDs7vxbPhStR0t7XeagbDRy8s93IZyTV0npNLxVm8rgW4D2eQy5MJaXPPHAtGYvvBHGoLuKbRBITuiiTnpaMoIEFBpx0bKODJ2l7uh0tsgpN5hH2/pzq6luzWocX8swqQntWSxvtQ1J2Fjd38B5LQremkKMO/q6xYwcKhKX14gfjtHn7lciewNHO/270=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(55112099003)(18002099003)(20052099010)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QjESOVAdTrkNDfnAhKIM2CleizidSymLu8hYpf8Lbx+Ddzi+0wMg4d+nySrZ?=
 =?us-ascii?Q?Bpwy4LzJxst/rqr1aqJbyuXo1M200DJR1jtUCI2Vh+0AzklRFIcQGOFzu+74?=
 =?us-ascii?Q?2urM9L4hRFVVrb42ixli1q3e4WkDNgpK84SFiyTJadaiEODyJCgrGZnFW+zb?=
 =?us-ascii?Q?shInlV9qF98QAPQdr2boNB8+eEi7pQeWkVGthahH9/avNN6qmPiCvgWO3QHj?=
 =?us-ascii?Q?CEA6cv37L+fl9n3OKbQDDQuZCPiJy67rjeCSPANQ1VF74eQqaYEUx6Jf1tC5?=
 =?us-ascii?Q?BrdtO5qr4eh+E96zL2QnJRef9FJQyBjHlGdEQa9C4sesRr3pIHY9rLZ5dU71?=
 =?us-ascii?Q?jiL762w7+mwL8rPt4Xg9f3+Gz7QAkCf0+NPH0iVgs7iXzCZwv/cAjpIUUu3V?=
 =?us-ascii?Q?bQrm0XH4FztzwDA7LoBVh4Sy6SXys7N5+yqYaTCee1a/KkOG6ilWj6d4Tmcr?=
 =?us-ascii?Q?Lb1HBazgO+0uh92MK+McYJRxDMcLevIkPSDafSDmkFjXmIviifNebZpRw5l9?=
 =?us-ascii?Q?jdjYH7Z/DOl330MjqbZGpURKqm5r5u6x/Os6v+xWAoCtL0N1dRKSOOChv67v?=
 =?us-ascii?Q?w/WDHilauK82jldcfyTY8dBvhc18I2KixvNyPSMkF+pjUIpmW4oA66mO3YqM?=
 =?us-ascii?Q?yWV8NnGN6R/ztpXzIxu5Qkz1ToTnsUrwA397yFLle01UMTo2xfOs8z7N6kYZ?=
 =?us-ascii?Q?TIgtzQjckfgkbchBCNbWQOCnDk8O3GQuWw+whiBgox8suAXe8H81KlNIGti1?=
 =?us-ascii?Q?VfQEQ0TCh4X2588GwyUnYkKTuMDsERIPiMTvPiOZ0vwZ7l+AOurze8GP/J8v?=
 =?us-ascii?Q?IlCiNFiHIdhWj/CtGPN0/UE2FgGJqkPO1dHrnP4m2xwsxHgek2w1eFXwI4JD?=
 =?us-ascii?Q?X6DABKLm0jUri9oBa4SaOckULmZqTIFTXKVnDlDWcdmo2rZq+jHrgaHurrWm?=
 =?us-ascii?Q?/W/Ol0z91R4pbrnko49NUgqAOSNpf5/aU2Ye8qfExmDbRN2CNF9JpHJW2alS?=
 =?us-ascii?Q?XGklslR67huHkacGQmZ+IiME3Cl6SZX0Ae18c2+ebhKsvWgDlFbpW16gGrIk?=
 =?us-ascii?Q?p1Rz2TOBL/F8o7e2thYGqTngGurO6dH2WbaozT7Te8BJWbY0SRigbgtNh6a8?=
 =?us-ascii?Q?Fa+UlYi4y1ohRwgCoNuzqZ8yOC3JnCEPwjHIIh68SOR+pqpDEbJXcTfRCcfF?=
 =?us-ascii?Q?mnge7kOLES2rJQMyDOdFfhZan6ZVeuZ1cR6oL3jjEW6xluhGZpSi5tNUDKdA?=
 =?us-ascii?Q?7C5nszS8WZctU8M+ir0hQ4lCNlZUb1CH5vWH6uGHGvfR+cHmKbdOGuodx/rS?=
 =?us-ascii?Q?nEJyQ90SylPlMRIwRkxKWMSlHXjgs/1c4OBBpn1q6t6Brhr417iyn+VOxSZW?=
 =?us-ascii?Q?aJ6w+xgdSWmQUa4+37iD+qiM8WiIjdEnWHQyZ4Ep1v7jIdATdBQMifBCwtcf?=
 =?us-ascii?Q?/bSvMBk9ihbi1NDxSQD2jzeBbwL/d6BXF855b2Mw3Wo+fUJjBmxexQSqM3Vy?=
 =?us-ascii?Q?WJ3X6XVU7Ai/zxoNg8EhzXfzAljyHnPR7n+EeEnzAiNgGX/jV249C4CNKf8c?=
 =?us-ascii?Q?qnLG+xFt4THMY9gPV73AAutIq6Getp6OCQTWb+zKGhIlHayvKWy7ThlIN9MJ?=
 =?us-ascii?Q?iJ5/QKAXbgfRHsHx4/a/0ypjqDo6K3D++UuOYu3WCPj7inkjOPSdXn7jDWWg?=
 =?us-ascii?Q?b2mofjZSb16PMBqeyXPCFI/g5anzGfQuow64ijA/zouXBqoWKHJWrDvuLLT3?=
 =?us-ascii?Q?0qdZMpl6iQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d98efa-a474-4162-7700-08deed87e6f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 15:41:48.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0CGVAvxTam2E4tjv9Gf8iLqxFU5DblAR/AXqgsKTbe8GrzP79fnDnLAzOtPgW+BKzHQT/XIyn/JS9nxdGmE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6385
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2026 15:41:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23814

On 29.07.26 13:37, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Tue, 2026-07-28 at 18:55 +0200, Jan Kiszka wrote:
>> On 28.07.26 17:32, Quirin Gylstorff wrote:
>>>
>>>
>>> On 7/28/26 5:25 PM, Jan Kiszka wrote:
>>>> On 28.07.26 15:12, Quirin Gylstorff wrote:
>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> ---
>>>>> =C2=A0 README.md | 8 ++++----
>>>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/README.md b/README.md
>>>>> index 435d037..df1564f 100644
>>>>> --- a/README.md
>>>>> +++ b/README.md
>>>>> @@ -10,10 +10,10 @@ from scratch.
>>>>> =C2=A0 =C2=A0 ## Building Target Images
>>>>> =C2=A0 -Install docker or podman and make sure you have required
>>>>> permissions to start
>>>>> -privileged containers. For docker, you need to be part of respective
>>>>> docker
>>>>> -group (`sudo usermod -aG docker <USER>`). Privileged podman requires
>>>>> sudo
>>>>> -rights for the caller (`<USER> ALL=3D(root) SETENV: /usr/bin/podman`
>>>>> in sudoers).
>>>>> +Install docker or podman. For docker, you need to be part of
>>>>> respective docker
>>>>> +group (`sudo usermod -aG docker <USER>`). The build requires Debian
>>>>> Bullseye
>>>>
>>>> ...and docker will inherently remain not fully rootless (due to its
>>>> daemon concept). Therefore, we should strongly recommend podman here.
>>>>
>>>>> +(kernel version >=3D 5.10.1) or newer to support user namespaces for
>>>>> rootless builds.
>>>>
>>>> We need much fresher systems, already kernel ~6.7 for binfmt_misc
>>>> namespaces, at least when cross-building. Practically, I do not want t=
o
>>>> debug ANY rootless build on anything older than trixie.
>>>>
>>> Proposal:
>>> ```
>>> Install docker or podman. For docker, you need to be part of respective
>>> docker
>>> group (`sudo usermod -aG docker <USER>`) as isar-cip-core uses isar-
>>> rootless and due
>>> to its daemon concept docker cannot be fully rootless it is recommenede=
d
>>> to use podman. The build requires Debian Trixie (kernel version >=3D 6.=
7)
>>> or newer to support user and binfmt namespaces for rootless builds.
>>> ```
>>>
>>
>> I'm using now this:
>>
>> Install docker or podman. For true unprivileged builds, podman is recomm=
ended.
>> For docker, you need to be part of respective docker group
>> (`sudo usermod -aG docker <USER>`). Rootless builds furthermore require =
a
>=20
> This is dangerous, as being part of the docker group essentially means
> you're root (without password). It also is not any different from "sudo
> docker". For rootless docker, please refer to
> https://docs.docker.com/engine/security/rootless/
>=20

Valid point, and I think we would document that setup with more details
elsewhere, just linking that here afterwards. The kas docs are likely
the best place for these docker complications.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

