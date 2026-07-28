Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD3EC54F54
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 16:55:37 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.987.1785257735883829870
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 09:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WNWy2Pmo;
 spf=pass (domain: siemens.com, ip: 52.101.69.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bL9s+No850zGGpLqftMad1KIrY87aIj5t4CEpcatR7ZD48KyNUJHjzuA79tksk9NzXngr2d1SciocqrT70twd5A5Xna0zm9kvDR4oNUdOcIqr+hP2SVCDgzFhQWNfyvcml+HusTkE0bS/4IMVIoyp4u39xfhIZrpq9a2+AaPf5HqIciMjGU1daVzGROV7IoblG6KthBrb0GNhtbKY9q6EePjsm+7kucefuWnqdNUFullpqSFxosm91Tg0S+I8nWQw6jHhS+7pZX4M8M6qd6DSVUdQFeaY1ggXigjHZllO0ovl5yKnq0ER5WlAygMWi81OS8Z+Yc09RE7o7FJ9XCB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OIRR3fsDIMQi5qvuqnMoPkrCE7vuRli2UD6Tshk5To=;
 b=mFPbyNo8awy8KCFIgOFOEOBklxGhs9F8IMKvQO4qNPBBhRuHaDsBKDLS/RZ1mK+0+7zrfZqOIxbw3HO+a0c2yeExqMIX9SyjwsmamHJY0F6Q8g7s19t9QvLzTuMvoLV/exMWqZiWZ5wQ44ND8w+OdPwltUeYxDTEWSmzz67vb8OdQrKhYyl2RX/RjA5+eVLBxoKSY9MaaR2+Php3Ze8FPzHXl19lcTdJzkL83Hq8TDnQBQkzUegnwd75QKXkQo9/Q0ltIUBmFzrWjPVhHAss+GUqZtwMF5cFo0IVWUVf8rorIqavzpjNdzcxqM95N1MKxlvBEmX1gI851Fw/CWx9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OIRR3fsDIMQi5qvuqnMoPkrCE7vuRli2UD6Tshk5To=;
 b=WNWy2PmoSIrZZlVfDDA/TmBOnhddmVT5JBHr7qjjFjcf/asdYK+PHeS+2g9PMwr5obs/J1GDlR+iUyxm4xXv9Zrk8N8Nt4mHVuYfdiXlXb7AwKFg1VY/U0FQd6OnRh7UmGnx460pG5Z0VLjnmqnTt8amBq2lTRM7VLXFhDWAIikB00iiFffG3ug+y6Ni4l9QrTwuspQO8DlKmlccelHTRYn9Mbv6jNStT8M2dEyNKRkUnR7aATdrriYusekkuXElxyYcs+JI8tsFEc/gNad7GtHZzYr1z5ODoc04o0yWEaZCZUO/kSVE0QVxafLTMnJ8qfqyz6+TxvebdxUgjsawyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 16:55:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 16:55:32 +0000
Message-ID: <88d3cbf0-eaa7-4ca7-bc7d-5b4b4ec9ce35@siemens.com>
Date: Tue, 28 Jul 2026 18:55:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 5/5] update README.md for
 rootless build
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <20260728131231.117214-6-quirin.gylstorff@siemens.com>
 <a4b6fda7-15ee-4351-9714-d700cc171504@siemens.com>
 <b88cc355-446e-4190-9b82-b74bcd2b747f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <b88cc355-446e-4190-9b82-b74bcd2b747f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DU2PR04CA0304.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: d72a01d8-0e27-4f59-ca0b-08deecc909a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|11063799006|10067099003|4143699003|56012099006|6133799003|55112099003|22082099003|20052099010|18002099003;
X-Microsoft-Antispam-Message-Info: 
	rUcs+q6k2LlMO9KVKt48vNGC4GzkdRsJbeShADw5tXtZ/kjiqfsFuwvNi3ad/icSRiVdSSM9dNFl5+grePsbbaqrIkvyUt0pOAxX52XdGQt99yDO2bHS3kHTNG7i3I9p3S9tj8U0RQsAmDFytNphNZK0KLWJ0ghCg5woFygeX3feHEVo4N7iuW51j7UsQ5CCB8nkrYxCK1/gQSwmTd1Q7PIryXw4khRKW3uP2zGZlwRV9Z8XDt0+1vQYxrPHel0atg1pj3xx6d+RY2FFwmrum0yj6z1r8jpNdep9JYhGUDhKv0sX3lzqB6tw9f/0myygxo5yo48wuTgOiCotKR2pWP5vucPn/xfrr6P9C9HMOF56v+QJycr2rg5rmZEZo/wo6Hkdp/cHNVXa/tKGvbcvqPYSu9no5nSSghQhSWMOUO80pMzkAUdZDFiTA0oBCcoBG3R+RMxOTSnS/c8+O9Emfrdhzfsc031X1+k8aDUYFad6cobgE6j2mPZIG/f6BVU6M/OkQY7P+wjeIt8VdYURRCGWJR0rq3eMhEiq0tvtnoUelfFCeUu07y0qYZ+CgmDG0fisCTU++rKLMCwlTyLSpKDlxt5SNW2HPk5qUgJSjxEdtMmPwE/vF7KdPC4iZnDEYDx1fni4nwt0JmH/5c4ChsBAK4V8wo0W25JnDh9Bb80=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(10067099003)(4143699003)(56012099006)(6133799003)(55112099003)(22082099003)(20052099010)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ign/YnB0bKktTPyz40lC/H/oxJ4QjgwEUpoVzj4p0n2CaV2nR6Lqev9IQZWW?=
 =?us-ascii?Q?8nmWSnQ7zO5MGCzrTk9MHuIINqkRkBPF59aPcnlI1RVrQJTuRU5juc8fvNK1?=
 =?us-ascii?Q?fBawiMJsRHYSOi0Zhu7xny2su6hWoDQxLtVnr4NgKTwcAbxKWkJtYrMi6do/?=
 =?us-ascii?Q?3VGVEqXl4tw5XlWx2jtzpn0ymayqp877ALZcvj6jQ+qncgroz4XyhzDTOLgz?=
 =?us-ascii?Q?uuKF5803ncAWfJd3LfpSERyixdPmpB/5hIyWjNBFsocsv447/1/8mJT/KW1q?=
 =?us-ascii?Q?BuNECNBJxGPOEK7iSQ0WqkwPX2TEPpo6zF89K2Sco75s02VUPMGa9ZyZAzyW?=
 =?us-ascii?Q?wnkmuXQBL4CI6bxekXv42JQ4z0lz2PWRUqwx2Aj2pudVwimlKinWFhOH0JLF?=
 =?us-ascii?Q?vBgwkAM2CFQI7bM2Bfo9MlF6wQltXY2a2hnoDT4F7CluPNYZ0MT49l9BnsGd?=
 =?us-ascii?Q?DtSp4JNdwcoEtXuFhInxRzz6X8HsokIpgkDkxOwJdUMcTxlQIs7iHEjDRKbj?=
 =?us-ascii?Q?CJh8P8nUNDb8Skq/hSGu84lI1IG+cJWbM1eCRZIwOsSPAZXa1ZIm/aPp10ue?=
 =?us-ascii?Q?D4aM5laVNyDOvumAwLWKmNRl9X14OURTmifHip/aIrZWLL221m9V1lM4Od/5?=
 =?us-ascii?Q?4s3XeifR3TNnNSER7S3DosAaCJxsyG1y5ttB5Sx7k4qE7St8Bsj32+rXSW/u?=
 =?us-ascii?Q?mVFQtKKLrdH2vSJ3PfwAU4kEKajXfimGZgWLbtDjPw+gWn0CRxJeLMi6PB2C?=
 =?us-ascii?Q?BocswCi9C+GN9cjaASBAeKASudQcBPLrvqx6/kZTbttPWqkfjTny2f64CuUY?=
 =?us-ascii?Q?+0YGJjtq6WqKBjpzObLG76FJQrOn1/gCQznWmTfbF6G3XZm0bNWKf4HrXYwI?=
 =?us-ascii?Q?TySCxJ1MXEFjFF45NjJnlJypUHND4xhWDNr40qLzGeTBthUBJxd/ndI81elH?=
 =?us-ascii?Q?HtiAh7TUdMaju7Q67a4IlksP2IikuhSxassMcwvvEc/FItSCmaOB/758RHpz?=
 =?us-ascii?Q?pPWMJqDRPvOrbovqy0Z5BJQvN/+jAQo7OqvvIwgV0fluH8YSbvh97xOc1kTd?=
 =?us-ascii?Q?2aGqLeg2jXoHIsZUGuFHFi9pSKf4cug3dPw2a0vJM62RbsOGFjubdOrefxDg?=
 =?us-ascii?Q?wdjyaWeVNjR3Nt7ptFBUWikQywwrKVJqZSuYA2Apl2KOYMlbaKi3TJeAjNyS?=
 =?us-ascii?Q?+D8YhNxD/17I6Y/7PIiGv+reWgVMtpRJSyMxlAyOqxTbkAHMMS4yExSFY70I?=
 =?us-ascii?Q?Jwd4XDoARhJmh4YUGC3LTAeiSOP0baMwq0fCprpRtFRmiM25p3FOtzP9OksL?=
 =?us-ascii?Q?f1hmlprSGLb/XVR7Fsdt+1MmUpFyqYKddLilfhmokYSg7zpgKLNBkDgSg+SQ?=
 =?us-ascii?Q?9AOfWYmPlzwdXnFg+QcSF3jRUMnE0zDnEPrKKbkR69ln8nfEu0w2Ov+jhlYf?=
 =?us-ascii?Q?iyKeLBt+/RtOiBHiivaVYyHMcbLkNg/1aHnAr1mJMNATmXnK7VCD4SvHuCSy?=
 =?us-ascii?Q?lRCRGuvLUy9Xr81poUeLAx/fzW/ONkg+aOhWpK34a8lpYzw9K1Me/hy40wVw?=
 =?us-ascii?Q?QUohuq2Sch+zcNwbGb414MNAs/vrCbDb6NNATMX6W0aCUWGoJWs9yxr7dwiE?=
 =?us-ascii?Q?r/osmgUOKSI26d5CsKGWlAj4UzGA8Z07bXQpMyia6AKnyhn++jd1oCpARJZ4?=
 =?us-ascii?Q?lRC7fvGUi32e2R1EaB3nQSIWuPND78/ChL/Bps92RR7Ct0F/lWA2ygsaYELg?=
 =?us-ascii?Q?qCSjiUyDSA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72a01d8-0e27-4f59-ca0b-08deecc909a8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 16:55:32.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8ax/0I0M/82VoK+dwQHHATdUmimhAi6E1LnGRmMIbSsTP2jRn7lyz5AJdYjNgh53x/dOT7tald5mbPR+Di4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5619
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 16:55:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23807

On 28.07.26 17:32, Quirin Gylstorff wrote:
>=20
>=20
> On 7/28/26 5:25 PM, Jan Kiszka wrote:
>> On 28.07.26 15:12, Quirin Gylstorff wrote:
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 README.md | 8 ++++----
>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/README.md b/README.md
>>> index 435d037..df1564f 100644
>>> --- a/README.md
>>> +++ b/README.md
>>> @@ -10,10 +10,10 @@ from scratch.
>>> =C2=A0 =C2=A0 ## Building Target Images
>>> =C2=A0 -Install docker or podman and make sure you have required
>>> permissions to start
>>> -privileged containers. For docker, you need to be part of respective
>>> docker
>>> -group (`sudo usermod -aG docker <USER>`). Privileged podman requires
>>> sudo
>>> -rights for the caller (`<USER> ALL=3D(root) SETENV: /usr/bin/podman`
>>> in sudoers).
>>> +Install docker or podman. For docker, you need to be part of
>>> respective docker
>>> +group (`sudo usermod -aG docker <USER>`). The build requires Debian
>>> Bullseye
>>
>> ...and docker will inherently remain not fully rootless (due to its
>> daemon concept). Therefore, we should strongly recommend podman here.
>>
>>> +(kernel version >=3D 5.10.1) or newer to support user namespaces for
>>> rootless builds.
>>
>> We need much fresher systems, already kernel ~6.7 for binfmt_misc
>> namespaces, at least when cross-building. Practically, I do not want to
>> debug ANY rootless build on anything older than trixie.
>>
> Proposal:
> ```
> Install docker or podman. For docker, you need to be part of respective
> docker
> group (`sudo usermod -aG docker <USER>`) as isar-cip-core uses isar-
> rootless and due
> to its daemon concept docker cannot be fully rootless it is recommeneded
> to use podman. The build requires Debian Trixie (kernel version >=3D 6.7)
> or newer to support user and binfmt namespaces for rootless builds.
> ```
>=20

I'm using now this:

Install docker or podman. For true unprivileged builds, podman is recommend=
ed.
For docker, you need to be part of respective docker group
(`sudo usermod -aG docker <USER>`). Rootless builds furthermore require a
host kernel version 6.7 or newer.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

